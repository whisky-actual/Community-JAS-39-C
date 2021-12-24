dofile(LockOn_Options.script_path.."command_defs.lua")
local update_time_step = 0.0025
make_default_activity(update_time_step)
local FBW = GetSelf()
local sensor_data = get_base_data()

-- ===== Local variables =====
local ROLL_INPUT = 0
local PITCH_INPUT = 0
local RUDDER_INPUT = 0

local PITCH_STATE = 0 
local PITCH_TARGET = 0
local PITCH_Diff1 = 0
local PITCH_Diff2 = 0
local ROLL_Diff1 = 0
local ROLL_Diff2 = 0
local YAW_Diff1 = 0
local YAW_Diff2 = 0
local AirSpeedCoeff = 1
local RudderTimeSec = 1.1
local RudderIncrement = update_time_step / RudderTimeSec
local PITCHTimeSec = 0.9
local PITCHIncrement = update_time_step / PITCHTimeSec
local ROLLTimeSec = 0.15
local ROLLIncrement = update_time_step / ROLLTimeSec
local PITCH_TARGET = 0
local PITCH_STATE = 0 
local ROLL_TARGET = 0
local ROLL_STATE = 0
local YAW_STATE = 0
local YAW_TARGET = 0
local DUMPINGLIFT = 0
local PITCH_OUTPUT = get_param_handle("CURRENT_PITCH_OUTPUT")
local ROLL_OUTPUT = get_param_handle("CURRENT_ROLL_OUTPUT")
local YAW_OUTPUT = get_param_handle("CURRENT_YAW_OUTPUT")

local JOYSTICK_PITCH_ANIM = get_param_handle("JOYSTICK_PITCH_ANIM")
local JOYSTICK_ROLL_ANIM = get_param_handle("JOYSTICK_ROLL_ANIM")
local RUDDER_PEDAL_ANIM = get_param_handle("RUDDER_PEDAL_ANIM")

local I_dont_like_fun	= get_param_handle("I_dont_like_fun")
I_dont_like_fun:set(0)

PITCH_OUTPUT:set(0.0)
ROLL_OUTPUT:set(0.0)
YAW_OUTPUT:set(0.0)

FBW:listen_command(10061)--Pitch axis
FBW:listen_command(10062)--roll
FBW:listen_command(10063)--rudder/yaw
FBW:listen_command(Keys.NoHotas) -- Enable keyboard controls

function SetCommand(command,value)
	if command == 10061 then
		PITCH_INPUT = value
		--print_message_to_user(value)
	end
	if command == 10062 then
		ROLL_INPUT = value
	end
	if command == 10063 then
		RUDDER_INPUT = value		
	end
	
	if command == Keys.NoHotas then
		if I_dont_like_fun:get() == 0 then
			print_message_to_user("Hotas Controls Disabled") 
			I_dont_like_fun:set(1)
		else
			print_message_to_user("Hotas Controls Enabled") 
			I_dont_like_fun:set(0)
		end
	end	
	
end

function Sensor_data() 
	PITCH_TARGET = PITCH_INPUT
	ROLL_TARGET = ROLL_INPUT
	YAW_TARGET = RUDDER_INPUT

end

function Joystick_Animation()
	JOYSTICK_PITCH_ANIM:set(PITCH_INPUT)
	JOYSTICK_ROLL_ANIM:set(ROLL_INPUT)
	RUDDER_PEDAL_ANIM:set(RUDDER_INPUT)
end





function update()
Sensor_data()
Joystick_Animation()

--[[ beginning of phases
-- ======================== Stationary =============================		
	if get_param_handle("CURRENT_PHASE_STATIONARY"):get() > 0.0 then

		
-- ========================= Parked ================================		
	if get_param_handle("CURRENT_PHASE_PARKED"):get() > 0.0 then 

--========================= Taxi ================================
	if get_param_handle("CURRENT_PHASE_TAXI"):get() > 0.0 then			

		
-- ============= Take off ground roll ===========================
	elseif get_param_handle("CURRENT_PHASE_TGR"):get() > 0.0 then									
		
		
-- ========================= Rotation ===========================	
	elseif get_param_handle("CURRENT_PHASE_ROT"):get() > 0.0 then
		
		
-- ================== Lift off ================================
	elseif get_param_handle("CURRENT_PHASE_LO"):get() > 0.0 then
		
		
-- ======================= Combat ==============================
	elseif get_param_handle("CURRENT_PHASE_CO"):get() > 0.0 then			
		

--================ Powered Approach And Landing =================
	elseif get_param_handle("CURRENT_PHASE_PAL"):get() > 0.0 then
		
===================== Touch Down =============================		
	elseif get_param_handle("CURRENT_PHASE_TD"):get() > 0.0 then
--]]		
	if I_dont_like_fun:get() == 0 then
	--======================= Landing Roll =========================
			if get_param_handle("CURRENT_PHASE_LR"):get() > 0.0 then
				if get_param_handle("BRAKE_FORCE"):get() > 0.0 then
					PITCH_TARGET = get_param_handle("BRAKE_FORCE"):get() * -1		--Apply pitch forward proportional to braking force
					DUMPINGLIFT = 1
				end
			end	
		-- end of phases
		--print_message_to_user(get_param_handle("BRAKE_FORCE"):get() * -1)
		
		-- ============= PITCH =============================
			PITCH_Diff1 = PITCH_TARGET - PITCH_STATE  			-- Difference between desired and current angle
			PITCH_Diff2 = PITCH_STATE - PITCH_TARGET				-- Difference between current and desired angle
			--print_message_to_user(PITCH_Diff1)
		-- if current value does not match desiered value and requiered actuation is greater than the increment in which the movement is done
		
			if (PITCH_STATE < PITCH_TARGET) and (PITCH_Diff1 >= PITCHIncrement * (PITCH_Diff1 / PITCHIncrement)) then
				PITCH_STATE = PITCH_STATE + PITCHIncrement * (PITCH_Diff1 / PITCHIncrement)
			elseif (PITCH_STATE > PITCH_TARGET) and (PITCH_Diff2 >= PITCHIncrement * (PITCH_Diff2 / PITCHIncrement)) then
				PITCH_STATE = PITCH_STATE - PITCHIncrement * (PITCH_Diff2 / (PITCHIncrement * 2))
			end
			
				if (PITCH_STATE < -1) then							
				PITCH_STATE = -1
			elseif (PITCH_STATE > 1) then
				PITCH_STATE = 1
			end
			
		-- ============= ROLL =============================
			ROLL_Diff1 = ROLL_TARGET - ROLL_STATE  			-- Difference between desired and current value
			ROLL_Diff2 = ROLL_STATE - ROLL_TARGET				-- Difference between current and desired value
			
		-- if current value does not match desiered value and requiered actuation is greater than the increment in which the movement is done
		
			if (ROLL_STATE < ROLL_TARGET) and (ROLL_Diff1 >= ROLLIncrement * (ROLL_Diff1 / ROLLIncrement)) then
				ROLL_STATE = ROLL_STATE + ROLLIncrement * (ROLL_Diff1 / ROLLIncrement)
			elseif (ROLL_STATE > ROLL_TARGET) and (ROLL_Diff2 >= ROLLIncrement * (ROLL_Diff2 / ROLLIncrement)) then
				ROLL_STATE = ROLL_STATE - ROLLIncrement * (ROLL_Diff2 / ROLLIncrement)
			end
		
			if (ROLL_STATE < -1) then							
				ROLL_STATE = -1
			elseif (ROLL_STATE > 1) then
				ROLL_STATE = 1
			end
		
		-- ============= YAW =============================
			YAW_Diff1 = YAW_TARGET - YAW_STATE  			-- Difference between desired and current value
			YAW_Diff2 = YAW_STATE - YAW_TARGET				-- Difference between current and desired value
			
		-- if current value does not match desiered value and requiered actuation is greater than the increment in which the movement is done
		
			if (YAW_STATE < YAW_TARGET) and (YAW_Diff1 >= RudderIncrement) then
				YAW_STATE = YAW_STATE + RudderIncrement
			elseif (YAW_STATE > YAW_TARGET) and (YAW_Diff2 >= RudderIncrement) then
				YAW_STATE = YAW_STATE - RudderIncrement
			end
		
			if (YAW_STATE < -1) then							
				YAW_STATE = -1
			elseif (YAW_STATE > 1) then
				YAW_STATE = 1
			end
		
		-- Axis commands
		
		PITCH_OUTPUT:set(PITCH_STATE)
		dispatch_action(nil, 2001, PITCH_STATE)	--PITCH
		
		ROLL_OUTPUT:set(ROLL_STATE)
		dispatch_action(nil, 2002, ROLL_STATE)	--ROLL
		
		YAW_OUTPUT:set(YAW_STATE)
		dispatch_action(nil, 2003, YAW_STATE) 	--RUDDER/YAW
	end
end

need_to_be_closed = 0

--[[
--**This file is an attempt to document every available function in lua in DCS, but is incomplete at the moment**

local dev = GetSelf() --With this utility function the following can be used: performClickableAction, listen_command, listen_event, and for some special devices like avSimpleElectricSystem and avSimpleWeaponSystem there are a few more available

dev:listen_command()
function SetCommand(command,value) -- function called by DCS when a command is triggered
end

dev:listen_event("GroundPowerOn")
dev:listen_event("GroundPowerOff")
dev:listen_event("GroundAirOff")
dev:listen_event("GroundAirOn")
dev:listen_event("WeaponRearmFirstStep")
dev:listen_event("WeaponRearmComplete")
dev:listen_event("WeaponRearmSingleStepComplete")
dev:listen_event("UnlimitedWeaponStationRestore")
dev:listen_event("WheelChocksOn")
dev:listen_event("WheelChocksOff")
function CockpitEvent(event,val) -- function called by DCS when event happens
end

dev:performClickableAction(command, value, true/false)--This is used to ‘click’ a switch without using your mouse. This is used a lot for when a key is pressed and you want that key to move a switch.

post_initialize() --This function is run once at the beginning of mission start

update() --This function is run multiple times a second, depending on the update rate set. At the beginning of your device script you must define the update rate using make_default_activity()

print_message_to_user(output)--prints on screen in game, very useful for debug

local sensor_data = get_base_data() -- sensor data, full list below
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

set_aircraft_draw_argument_value(arg #, value)
get_aircraft_draw_argument_value(arg)
get_cockpit_draw_argument_value(arg)

dispatch_action(device ID, command, value)--Triggers command with value. Similar to device:performClickableAction() but doesn’t move the switch

get_param_handle(name)--This is used to set a param handle, best described as a global variable. It is useful for setting animations in mainpanel.lua, getting information into indicators, and getting information between an EFM and lua if you have an EFM. You use :set(value) and :get() to set and read it. Usage would look like:
throttle_position = get_param_handle("THROTTLE_POSITION")
throttle_position:set(0.5)
throttle_position:get()


--]]