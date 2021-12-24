local dev = GetSelf()

dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."utils.lua")

local degrees_per_radian = 57.2957795
local feet_per_meter_per_minute = 196.8
local meters_to_feet = 3.2808399
local GALLON_TO_KG = 3.785 * 0.8
local KG_TO_POUNDS = 2.20462
local MPS_TO_KNOTS = 1.94384
local RADIANS_TO_DEGREES = 57.2958

local update_time_step = 0.01 
make_default_activity(update_time_step)

local sensor_data = get_base_data()

local ThrottleAxis = 2005														-- FC3 Left Throttle Axis

local autothrottle_pid = PID(5, 0.02, 0.1, -0.85, 1.0, 1)   					-- Create the PID controller ( Kp, Ki, Kd, umin, umax, uscale )

dev:listen_command(10064)														-- Toggle autothrottle
dev:listen_command(10065)														-- Toggle AoA 12/14
dev:listen_command(10066)														-- Gripen Throttle Axis

local AOA1214_STATE = 0
local AUTOTHROTTLE_STATE = 0
local speedHold = -100
local throttle = 0
local THROTTLE_INPUT = 1
local tpos = 0

function SetCommand(command,value)

	if command == 10066 then													-- Gripen Throttle Axis
		THROTTLE_INPUT = value
	end	
   
	if command == 10064 then													-- Engage and disengage AT
		if AUTOTHROTTLE_STATE == 0 then
			AUTOTHROTTLE_STATE = 1
			tpos = THROTTLE_INPUT
			speedHold = sensor_data.getTrueAirSpeed()
		elseif AUTOTHROTTLE_STATE == 1 then
			AUTOTHROTTLE_STATE = 0
			speedHold = -100
		end  
	end

	if command == 10065 then													-- AoA12 = 0, AoA14 = 1
		if AOA1214_STATE == 0 then
			AOA1214_STATE = 1
		elseif AOA1214_STATE == 1 then
			AOA1214_STATE = 0
		end
	end

 end

function update_autothrottle()													-- Autothrottle function
	
    if AUTOTHROTTLE_STATE == 1 then
        tas = -math.sqrt(sensor_data.getTrueAirSpeed())
        tastarget = -math.sqrt(speedHold)
        throttle = autothrottle_pid:run( tastarget, tas )
		dispatch_action(nil, ThrottleAxis, (throttle * 0.999))
 	end	
end

function update_autothrottle_aoa12()											-- AoA 12 landing mode function
	local aoadeg
    local aoa_target
	
	if AUTOTHROTTLE_STATE == 1 then	
		aoadeg = math.deg(sensor_data.getAngleOfAttack())
        aoa_target = 144  -- (12^2)		
		throttle = autothrottle_pid:run( aoa_target, aoadeg*aoadeg )
		dispatch_action(nil, ThrottleAxis, (throttle * 0.999)) 
	end	
end

function update_autothrottle_aoa14()											-- AoA 14 landing mode function
	local aoadeg
    local aoa_target
	
	if AUTOTHROTTLE_STATE == 1 then	
		aoadeg = math.deg(sensor_data.getAngleOfAttack())
        aoa_target = 196  -- (14^2)		
		throttle = autothrottle_pid:run( aoa_target, aoadeg*aoadeg )
		dispatch_action(nil, ThrottleAxis, (throttle * 0.999)) 		
	end	
end

function throttle_axis()
	if get_param_handle("I_dont_like_fun"):get() == 0 then
		dispatch_action(nil, ThrottleAxis, THROTTLE_INPUT)
	end
end			

function throttle_override()
	if AUTOTHROTTLE_STATE == 1 and (tpos - THROTTLE_INPUT) > 0.2 then
		dispatch_action(nil,10064)
	elseif AUTOTHROTTLE_STATE == 1 and (THROTTLE_INPUT - tpos) > 0.2 then
		dispatch_action(nil,10064)
	end
end

function update()		

	local ias = sensor_data.getIndicatedAirSpeed()*1.944						-- IAS in kts

-- ======================== Stationary =====================================
	if get_param_handle("CURRENT_PHASE_STATIONARY"):get() > 0.0 then	
		throttle_axis()	
		if AUTOTHROTTLE_STATE == 1 then
			dispatch_action(nil,10064)
		end 	

-- ======================== Parked =========================================	
	elseif get_param_handle("CURRENT_PHASE_PARKED"):get() > 0.0 then	
		throttle_axis()	
		if AUTOTHROTTLE_STATE == 1 then
			dispatch_action(nil,10064)
		end 

-- ======================== Taxi ===========================================	
	elseif get_param_handle("CURRENT_PHASE_TAXI"):get() > 0.0 then	
		throttle_axis()	
		if AUTOTHROTTLE_STATE == 1 then
			dispatch_action(nil,10064)
		end 

-- ======================== Take off Ground Roll ===========================		
	elseif get_param_handle("CURRENT_PHASE_TGR"):get() > 0.0 then	
		throttle_axis()	
		if AUTOTHROTTLE_STATE == 1 then
			dispatch_action(nil,10064)
		end 

-- ======================== Rotation =======================================
	elseif get_param_handle("CURRENT_PHASE_ROT"):get() > 0.0 then	
		throttle_axis()
		if AUTOTHROTTLE_STATE == 1 then
			dispatch_action(nil,10064)
		end 		

-- ======================== Lift Off =======================================
	elseif get_param_handle("CURRENT_PHASE_LO"):get() > 0.0 then	
		throttle_axis()
		if AUTOTHROTTLE_STATE == 1 then
			if AOA1214_STATE == 0 then
				update_autothrottle_aoa12()
				throttle_override()
			elseif AOA1214_STATE == 1 then
				update_autothrottle_aoa14()
				throttle_override()	
			end
		end

-- ======================== Combat =========================================
	elseif get_param_handle("CURRENT_PHASE_CO"):get() > 0.0 then	
		throttle_axis()
		if ias >= 175 then
			update_autothrottle()
			throttle_override()
		end
		if ias < 175 and AUTOTHROTTLE_STATE == 1 then
			dispatch_action(nil,10064)
		end
		
-- ======================== Powered Approach and Landing ===================
	elseif get_param_handle("CURRENT_PHASE_PAL"):get() > 0.0 then	
		throttle_axis()
		if AOA1214_STATE == 0 then
			update_autothrottle_aoa12()
			throttle_override()
		elseif AOA1214_STATE == 1 then
			update_autothrottle_aoa14()
			throttle_override()	
		end

		
-- ======================== Touch Down =====================================	
	elseif get_param_handle("CURRENT_PHASE_TD"):get() > 0.0 then	
		throttle_axis()	
		if AUTOTHROTTLE_STATE == 1 then
			dispatch_action(nil,10064)
		end 

-- ======================== Landing Roll ===================================	
	elseif get_param_handle("CURRENT_PHASE_LR"):get() > 0.0 then	
		throttle_axis()
		if AUTOTHROTTLE_STATE == 1 then
			dispatch_action(nil,10064)
		end 		
	end
	
end

need_to_be_closed = false








