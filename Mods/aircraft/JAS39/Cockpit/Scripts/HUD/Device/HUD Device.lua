dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path .. "devices.lua")
dev = GetSelf()
local update_time_step = 0.001 --update will be called 1000 times per second
make_default_activity(update_time_step)
local sensor_data = get_base_data()

-- Conversions

local RAD_TO_DEGREE  = 57.29577951308233


--hud indicator params
local CURR_IAS  = get_param_handle("CURR_IAS")	--Airspeed.
local MACH_A  	= get_param_handle("MACH_A")
local MACH_B  	= get_param_handle("MACH_B")	

local HUD_MACH = 0

local HUD_IAS = 0
local HUD_GS = 0

local OverSpeedBlink = 0
-- Direction related params

local PITCH_HUD  = get_param_handle("PITCH_HUD")

local ROLL_HUD  = get_param_handle("ROLL_HUD")

local HEADING_HUD = get_param_handle("HEADING_HUD")

local ALTITUDE_HUD = get_param_handle("ALTITUDE_HUD")
local HEADING_MODE = get_param_handle("HEADING_MODE")


local VELVEC_HUD_Y  = get_param_handle("VELVEC_HUD_Y")
local VELVEC_HUD_X  = get_param_handle("VELVEC_HUD_X")

local VV_LimitedLower = get_param_handle("VV_LimitedLower")
local VV_LimitedUpper = get_param_handle("VV_LimitedUpper")




-- System indications
local AT = get_param_handle("AUTOTHROTTLE_ONOFF")
AT:set(0)	-- 0 = off 1 = on
local AT_MODE = get_param_handle("AUTOTHROTTLE_MODE")
AT_MODE:set(0)	-- 0 = off, 0.5 = 12, 1 = 14

local Autothrottle_mode = 12

local ALT_HOLD = get_param_handle("ALT_HOLD")
local GPS_ALTITUDE_FEET = get_param_handle("GPS_ALTITUDE_FEET")

dev:listen_command(10064) -- Toggle autothrottle
dev:listen_command(10065) -- Toggle AoA 12/14

dev:listen_command(389) -- on Alt hold
dev:listen_command(408) -- off Alt hold




function post_initialize()

	local GripenType = get_aircraft_type()

	if GripenType == 'JAS39Gripen' then
		get_param_handle("GRIPEN_TYPE"):set(1)
	elseif GripenType == 'JAS39Gripen_BVR' then
		get_param_handle("GRIPEN_TYPE"):set(2)
	elseif GripenType == 'JAS39Gripen_AG' then
		get_param_handle("GRIPEN_TYPE"):set(3)
	end


end

function SetCommand(command,value)	
   -- Auto throttle			
	if command == 10064 then
		if AT:get() == 1 then
			AT:set(0)
		else
			AT:set(1)
		end
	elseif command == 10065 then
		if Autothrottle_mode == 12  then
			Autothrottle_mode = 14
		else
			Autothrottle_mode = 12
		end
	end
	
	
	if command == 389 then
		ALT_HOLD:set(1)
	end	
		
	if command == 408 then
		ALT_HOLD:set(0)
	end
end	

function update()

	ROLL_HUD:set(sensor_data.getRoll())

	PITCH_HUD:set(sensor_data.getPitch())
	

 local VelVec_x = math.rad(sensor_data.getAngleOfSlide())
 local VelVec_y = -sensor_data.getAngleOfAttack() 

	VELVEC_HUD_Y:set(VelVec_y * (1.08))

	if VelVec_x > -0.247 and VelVec_x < 0.247 then
		VELVEC_HUD_X:set(VelVec_x)	
	end

	if VELVEC_HUD_Y:get() < -0.26 then
		VV_LimitedLower:set(1)
	elseif VELVEC_HUD_Y:get() > 0.125 then
		VV_LimitedUpper:set(1)
	else 
		VV_LimitedLower:set(0)
		VV_LimitedUpper:set(0)
	end


	if HEADING_MODE:get() == 1 then
		HEADING_HUD:set(360 - (sensor_data.getHeading() * RAD_TO_DEGREE))
	else	
		HEADING_HUD:set((sensor_data.getMagneticHeading() * RAD_TO_DEGREE))
	end


	if get_param_handle("ALTITUDE_MODE"):get() == 1 then	-- 1 = barometric, 2 = Radar
		ALTITUDE_HUD:set(sensor_data.getBarometricAltitude() * 3.2808399)
	elseif get_param_handle("ALTITUDE_MODE"):get() == 2 then
		local Hud_Ralt = sensor_data.getRadarAltitude() * 3.2808399
		
		if (Hud_Ralt > 5249.4) and (Hud_Ralt < 5249.6) then	
			ALTITUDE_HUD:set(GPS_ALTITUDE_FEET:get() - get_param_handle("TERRAIN_ALT"):get()) 
			get_param_handle("RadarAltAvail"):set(0)
		else
		
			ALTITUDE_HUD:set(Hud_Ralt)
			get_param_handle("RadarAltAvail"):set(1)
		end
	end


-- Speeds =================================================================================================================================
	HUD_IAS = sensor_data.getIndicatedAirSpeed() * 1.94384449		 -- m/s to kts
	local self_vel_l,self_vel_v,self_vel_h = sensor_data.getSelfAirspeed()		-- Prereq for ground speed in kts
	HUD_GS = math.sqrt(self_vel_h^2 + self_vel_l^2)*1.94384449
-- Below 50 kts use ground speed reading instead
	if HUD_IAS < 50 then
		CURR_IAS:set(HUD_GS)
	else
		CURR_IAS:set(HUD_IAS)
	end
	
	
	
	HUD_MACH = sensor_data.getMachNumber()
	
	if HUD_MACH < 0.995 then
		HUD_MACH = HUD_MACH *100
	end
	
	MACH_A:set(sensor_data.getMachNumber())

	MACH_B:set(HUD_MACH)
	--MACH_A:set(1.69)
	
	--MACH_B:set(69)
	
	
	
	
-- Takeoff phase, tells you when to rotate	
	
	
	if (get_param_handle("CURRENT_PHASE_TGR"):get() == 1) or (get_param_handle("CURRENT_PHASE_ROT"):get() == 1) or (get_param_handle("CURRENT_PHASE_STATIONARY"):get() == 1) or (get_param_handle("CURRENT_PHASE_PARKED"):get() == 1) or (get_param_handle("CURRENT_PHASE_TAXI"):get() == 1) or (get_param_handle("CURRENT_PHASE_TD"):get() == 1) or (get_param_handle("CURRENT_PHASE_LR"):get() == 1) then	
		local TakeOffSpeed = CURR_IAS:get()
		local TakeOffOverspeed = 0
		
		if TakeOffSpeed > 150 then		-- limit movement of rotation que
			TakeOffSpeed = 150
			
			TakeOffOverspeed = 1		
			
		elseif TakeOffSpeed < 150 then	
			TakeOffOverspeed = 0
		end
		
		if TakeOffOverspeed == 1 then
			if OverSpeedBlink < 1 then
				OverSpeedBlink = OverSpeedBlink + update_time_step
				
			else
				OverSpeedBlink = 0
			end
				
		
		end
		
		get_param_handle("TO_SPEED"):set(TakeOffSpeed)

		if get_param_handle("CURRENT_PHASE_TGR"):get() == 1 then
			get_param_handle("TO_OVERSPEED"):set(OverSpeedBlink)
		else
			get_param_handle("TO_OVERSPEED"):set(0)
		end
	else		
		get_param_handle("TO_OVERSPEED"):set(0)
		
	end
	
	--print_message_to_user(get_param_handle("TO_OVERSPEED"):get())
	
-- Auto Throttle ==========================================================================================================================
	if (AT:get() == 1) and ((get_param_handle("CURRENT_PHASE_LO"):get() > 0.0) or (get_param_handle("CURRENT_PHASE_PAL"):get() > 0.0)) then
		if Autothrottle_mode == 12 then
			AT_MODE:set(0.5)
		elseif Autothrottle_mode == 14 then
			AT_MODE:set(1)
		end
	elseif (get_param_handle("CURRENT_PHASE_LO"):get() < 1.0) or (get_param_handle("CURRENT_PHASE_PAL"):get() < 1.0) or (AT:get() < 0.5 ) then
		AT_MODE:set(0)
	end
end

need_to_be_closed = false






--[[
getAngleOfAttack()
getAngleOfSlide()
getBarometricAltitude()
getCanopyPos()
getCanopyState()
getEngineLeftFuelConsumption()
getEngineLeftRPM()
getEngineLeftTemperatureBeforeTurbine()
getEngineRightFuelConsumption()
getEngineRightRPM()
getEngineRightTemperatureBeforeTurbine()
getFlapsPos()
getFlapsRetracted()
getHeading()
getHorizontalAcceleration()
getIndicatedAirSpeed()
getLandingGearHandlePos()
getLateralAcceleration()
getLeftMainLandingGearDown()
getLeftMainLandingGearUp()
getMachNumber()
getMagneticHeading()
getNoseLandingGearDown()
getNoseLandingGearUp()
getPitch()
getRadarAltitude()
getRateOfPitch()
getRateOfRoll()
getRateOfYaw()
getRightMainLandingGearDown()
getRightMainLandingGearUp()
getRoll()
getRudderPosition()
getSpeedBrakePos()
getSelfAirspeed()
getSelfCoordinates()
getSelfVelocity()
getStickPitchPosition()
getStickRollPosition()
getThrottleLeftPosition()
getThrottleRightPosition()
getTotalFuelWeight()
getTrueAirSpeed()
getVerticalAcceleration()
getVerticalVelocity()
getWOW_LeftMainLandingGear()
getWOW_NoseLandingGear()
getWOW_RightMainLandingGear()
--]]