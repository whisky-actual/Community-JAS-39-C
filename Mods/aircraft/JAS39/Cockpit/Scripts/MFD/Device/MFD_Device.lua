dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")

dev = GetSelf()

update_time_step = 0.020833 --update will be called 48 times per second
make_default_activity(update_time_step)
local sensor_data = get_base_data()

-- Conversions
local RAD_TO_DEGREE  = 57.29577951308233

	
--adi
local adi_level_enable = get_param_handle("ADI_LINE_GROUP")
local ADI_ROLL = get_param_handle("ADI_ROLL")
local ADI_PITCH = get_param_handle("ADI_PITCH")
local ADI_ATTITUDE = get_param_handle("ADI_ATTITUDE")

--altitude
local ALTITUDE_T 	  	  	  = get_param_handle("ALTITUDE_T")
local ALTITUDE_H 	  	  	  = get_param_handle("ALTITUDE_H")
local ALT_ALTITUDE_T 	  	  	  = get_param_handle("ALT_ALTITUDE_T")
local ALT_ALTITUDE_H 	  	  	  = get_param_handle("ALT_ALTITUDE_H")
local GPS_ALTITUDE_FEET = get_param_handle("GPS_ALTITUDE_FEET")
local EMGY_ALTITUDE = get_param_handle("EMGY_ALTITUDE")
local EMGY_VS   =  get_param_handle("EMGY_VS")


local RAW_RALT 						=  get_param_handle("RAW_RALT")
local Local_RALT = 0
local GROUND_COLLISION_TIME   =  get_param_handle("GROUND_COLLISION_TIME")
local Ground_col_time = 0


local RoundedAltitude = 0
local ROUNDED_ALTITUDE   =  get_param_handle("ROUNDED_ALTITUDE")

local TERRAIN_DATA_ALT   =  get_param_handle("TERRAIN_DATA_ALT")
TERRAIN_DATA_ALT:set(7)

local CAB_PRESSURE = get_param_handle("CAB_PRESSURE")
-- speed
local CUR_IAS  = get_param_handle("CUR_IAS")	--Airspeed
local EMGY_IAS  = get_param_handle("EMGY_IAS")
local CUR_TAS  = get_param_handle("CUR_TAS")	--True speed
local CUR_MACH = get_param_handle("CUR_MACH") 	-- Mach
local CUR_GS = get_param_handle("CUR_GS") 		--Ground speed

-- Flight data 
local CUR_AOA = get_param_handle("CUR_AOA")		--Angle of attack
local CUR_G = get_param_handle("CUR_G")			-- G loading

local CURR_RPM = 0
local NEEDLE_RPM = 0
local TGT_TARGET = 0
local TGT_STATE = 0
local TGT_IndicatorTimeSec = 1/48
local TGT_IndicatorIncrement = update_time_step / TGT_IndicatorTimeSec
local Diff1 = 0
local Diff2 = 0


local RPM_PARAM = get_param_handle("RPM_PARAM")
local RPM_NEEDLE = get_param_handle("RPM_NEEDLE")
local RPM_PARAM_H = get_param_handle("RPM_PARAM_H")
local RPM_PARAM_U = get_param_handle("RPM_PARAM_U")
local RPM_PARAM_T = get_param_handle("RPM_PARAM_T")

local TGT_PARAM = get_param_handle("TGT_PARAM")
local TGT_NEEDLE = get_param_handle("TGT_NEEDLE")
local TGT_PARAM_H = get_param_handle("TGT_PARAM_H")
local TGT_PARAM_U = get_param_handle("TGT_PARAM_U")
local TGT_PARAM_T = get_param_handle("TGT_PARAM_T")
-- Controls
local CUR_TRH = get_param_handle("CUR_TRH")		-- Throttle position



-- heading
local HEADING 		  = get_param_handle("HEADING") 
local HEADINGCOMPASS  = get_param_handle("HEADINGCOMPASS") 
local NUMERICAL_HEADING  = get_param_handle("NUMERICAL_HEADING") 
local EMGY_HEADING  = get_param_handle("EMGY_HEADING") 

-- System indications
local AT = get_param_handle("AUTOTHROTTLE_ONOFF")
AT:set(0)
local AT_MODE = get_param_handle("AUTOTHROTTLE_MODE")

dev:listen_command(10064) -- Toggle autothrottle
dev:listen_command(10065) -- Toggle AoA 12/14

function post_initialize()
    local birth = LockOn_Options.init_conditions.birth_place
    if birth=="GROUND_HOT" then
		CURR_RPM = 59.5
		TGT_STATE = 479.5
    elseif birth=="AIR_HOT" then
		CURR_RPM = 59.5
		TGT_STATE = 479.5
    elseif birth=="GROUND_COLD" then
    end	
end
function update()

-- ADI====================================================================================================================================
	ADI_ROLL:set(sensor_data.getRoll())
    ADI_PITCH:set(-sensor_data.getPitch())
	ADI_ATTITUDE:set(-sensor_data.getPitch())
-- Altitude====================================================================================================================================

	Local_RALT = sensor_data.getRadarAltitude() * 3.2808399


	if get_param_handle("ALTITUDE_MODE"):get() == 1 then	-- 1 = barometric, 2 = Radar 
		ALTITUDE_T:set(math.floor(sensor_data.getBarometricAltitude() * 3.2808399 / 1000))		-- feet
		ALTITUDE_H:set(math.floor(sensor_data.getBarometricAltitude()* 3.2808399 % 1000))		-- feet
	else
		if (Local_RALT > 5249.4) and (Local_RALT < 5249.6) then
			ALTITUDE_T:set(math.floor(GPS_ALTITUDE_FEET:get() - get_param_handle("TERRAIN_ALT"):get() ) / 1000)	
			ALTITUDE_H:set(math.floor(GPS_ALTITUDE_FEET:get() - get_param_handle("TERRAIN_ALT"):get() )  % 1000)
		else
			ALTITUDE_T:set(math.floor(sensor_data.getRadarAltitude() * 3.2808399 / 1000))		-- feet
			ALTITUDE_H:set(math.floor(sensor_data.getRadarAltitude()* 3.2808399 % 1000))		-- feet
		
		end
	end
	

	
	--EMGY_ALTITUDE:set(0)
	EMGY_ALTITUDE:set(sensor_data.getBarometricAltitude() * 3.2808399) 

	
	
	if (Local_RALT > 5249.4) and (Local_RALT < 5249.6) then	-- when Radar altimiter cant get an accurate readout it returs ~5249.5
		RAW_RALT:set((sensor_data.getBarometricAltitude()* 3.2808399) - get_param_handle("TERRAIN_ALT"):get())
		
		ALT_ALTITUDE_T:set(math.floor(GPS_ALTITUDE_FEET:get() - get_param_handle("TERRAIN_ALT"):get() ) / 1000)		-- feet
		ALT_ALTITUDE_H:set(math.floor(GPS_ALTITUDE_FEET:get() - get_param_handle("TERRAIN_ALT"):get() )  % 1000)		-- feet		
	
		
	else
		RAW_RALT:set(Local_RALT)
	
		ALT_ALTITUDE_T:set(math.floor(Local_RALT / 1000))		-- feet
		ALT_ALTITUDE_H:set(math.floor(Local_RALT % 1000))	-- feet	
		
		
	end
	
	local EMGY_VSI = sensor_data.getVerticalVelocity()*3.2808399*60
	
	if EMGY_VSI > 2000 then
		EMGY_VSI = 2000
	elseif EMGY_VSI < -2000 then
		EMGY_VSI = -2000
	end
	EMGY_VS:set(EMGY_VSI)
	
	Ground_col_time = ((RAW_RALT:get() /3.2808399) + 7) / (-sensor_data.getVerticalVelocity())-- m / m/s = s
	
	GROUND_COLLISION_TIME:set(Ground_col_time) -- seconds until ground collision
	
	
	
--RoundedAltitude 
--ROUNDED_ALTITUDE:set()
	
	
	
-- Flight data ========================================================================================================================
	if (get_param_handle("CURRENT_PHASE_PARKED"):get() == 1) or (get_param_handle("CURRENT_PHASE_STATIONARY"):get() == 1 )then	-- just to make it look nicer while parked 
		CUR_AOA:set(0)			--Angle of attack
	else 
		CUR_AOA:set(sensor_data.getAngleOfAttack() * RAD_TO_DEGREE)			--Angle of attack
	end


	CUR_G:set(sensor_data.getVerticalAcceleration())						-- G loading	

 -- Speed====================================================================================================================================
	CUR_MACH:set(sensor_data.getMachNumber())
	local self_vel_l,self_vel_v,self_vel_h = sensor_data.getSelfAirspeed()		-- Prereq for ground speed in kts
	CUR_GS:set(math.sqrt(self_vel_h^2 + self_vel_l^2)*1.94384449)				-- Ground speed in kts
	local ias = sensor_data.getIndicatedAirSpeed() * 1.94384449			 -- m/s to kts
	local iasx, iasy, iasz = sensor_data.getSelfAirspeed()
	local tSpeed = sensor_data.getTrueAirSpeed() * 1.94384449 			-- m/s to kts
	
	

	if ias < 100 then
		EMGY_IAS:set(82)
	elseif ias > 600 then
		EMGY_IAS:set(600)
	else 	
		EMGY_IAS:set(ias)
	end


	if CUR_MACH:get() < 0.11 then 
		CUR_MACH:set(0)
	end
	if ias < 100 then
		ias = CUR_GS:get()
	elseif (ias > 100) and (ias < 200) then
		ias = ias + (ias -100)
	elseif (ias >= 200) then
		ias = ias + 100
	end
	CUR_IAS:set(ias)
	CUR_TAS:set(tSpeed)
	
	
-- Engine ====================================================================================================================================


	CURR_RPM = sensor_data.getEngineLeftRPM()
	
	
	NEEDLE_RPM = CURR_RPM
	
	if CURR_RPM <= 60 then
		NEEDLE_RPM = NEEDLE_RPM * 0.5
	elseif CURR_RPM > 60 then
		NEEDLE_RPM = NEEDLE_RPM - 29.5 - (CURR_RPM/99)
	end

	if CURR_RPM <= 61 then
		TGT_TARGET = (sensor_data.getEngineLeftTemperatureBeforeTurbine() + (260 * CURR_RPM / 60) * 0.6175) - 0.5
	elseif CURR_RPM <= 100 and CURR_RPM > 61 then
		TGT_TARGET = 480+28 + (sensor_data.getEngineLeftTemperatureBeforeTurbine()-( 580 * (CURR_RPM / 102.44))) 
	elseif CURR_RPM > 100 then
		TGT_TARGET = 101+28 + (sensor_data.getEngineLeftTemperatureBeforeTurbine()-( 201 * (CURR_RPM / 122.44)))
	end
	
	TGT_TARGET = TGT_TARGET / 1.185
	
	Diff1 = TGT_TARGET - TGT_PARAM:get()
	Diff2 = TGT_PARAM:get() - TGT_TARGET
	
	if (TGT_STATE < TGT_TARGET) and (Diff1 >= TGT_IndicatorIncrement) then
		TGT_STATE = TGT_STATE + TGT_IndicatorIncrement
	elseif (TGT_STATE > TGT_TARGET) and (Diff2 >= TGT_IndicatorIncrement) then
		TGT_STATE = TGT_STATE - TGT_IndicatorIncrement
	end


	if CURR_RPM > 100 then
		CURR_RPM = 100
		NEEDLE_RPM = 69
	end
	
	
	TGT_PARAM:set(TGT_STATE)
	TGT_NEEDLE:set(TGT_STATE)

	
	RPM_NEEDLE:set(NEEDLE_RPM)
	
	
	if CURR_RPM < 99.5 then
		RPM_PARAM_U:set(CURR_RPM)
		RPM_PARAM:set(0)
	else
		RPM_PARAM_U:set(CURR_RPM-99.5)
		RPM_PARAM:set(1)
	end
	
	
	if (get_param_handle("ECON_TOGGLE"):get() == 1) and (sensor_data.getMachNumber() > 0.5) then 
		TGT_PARAM:set(TGT_STATE-20)
		TGT_NEEDLE:set(TGT_STATE-20) 
		CURR_RPM = CURR_RPM - 1
		RPM_NEEDLE:set(NEEDLE_RPM-1)
	end
	
--Controls====================================================================================================================================
	local Throttle_pos = sensor_data.getThrottleLeftPosition()					-- Throttle position
	
	if (Throttle_pos >= 0.91) and (Throttle_pos < 0.99) then
		Throttle_pos = Throttle_pos + (0.12)
	elseif (Throttle_pos >= 0.99) then
		Throttle_pos = Throttle_pos * 1.175
	end
	
	CUR_TRH:set(Throttle_pos)	
-- Heading====================================================================================================================================
	local true_heading = (sensor_data.getHeading() * -57.29577951308233) + 540
	local magnetic_heading = (sensor_data.getMagneticHeading() * -57.29577951308233)
	
	NUMERICAL_HEADING:set(true_heading - 180.5)
	EMGY_HEADING:set((sensor_data.getMagneticHeading() * RAD_TO_DEGREE))
	--EMGY_HEADING:set(360)
	
	if get_param_handle("HEADING_MODE"):get() == 1 then
		HEADING:set(360 - (sensor_data.getHeading() * RAD_TO_DEGREE))
		--HEADING:set(360)
		HEADINGCOMPASS:set(true_heading-180)
	else	
		HEADING:set((sensor_data.getMagneticHeading() * RAD_TO_DEGREE))
		HEADINGCOMPASS:set(-magnetic_heading)
	end

	--print_message_to_user(EMGY_HEADING:get())

-- CABIN ====================================================================================================================================	

local BaroAlt = (sensor_data.getBarometricAltitude()* 3.28084) 		-- altitude in meters * meter_to_feet 
local CabinPressure = BaroAlt 
local CabinState = sensor_data.getCanopyState()	-- 0 = closed, 1 = open

if CabinState == 0 then -- If canopy is closed
	
	if BaroAlt > 8000 and BaroAlt < 24000 then
		CabinPressure = 8000
	elseif BaroAlt >= 24000 then
		CabinPressure = BaroAlt / 3
		
	end
	
else 
	if BaroAlt > 30000 then
		CabinPressure = 30000 + ((BaroAlt-30000) / 8)
	end
	
end

CAB_PRESSURE:set(CabinPressure/1000)

-- Oxygen	==================================================================================================================================



	
	
	


	
	
	
-- Hide fuel guage on lower area when monitor page is selected

		if get_param_handle("LD_LOWER"):get() == 2 then
			get_param_handle("FUEL_IND_TOGGLE_M"):set(0)
		else
		get_param_handle("FUEL_IND_TOGGLE_M"):set(1)
		end
	
	
	
	
	
	
end


function CockpitEvent(command,val)
  
end
 
need_to_be_closed = false -- close lua state after initialization


