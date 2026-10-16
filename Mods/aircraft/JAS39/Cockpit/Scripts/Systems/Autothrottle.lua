local dev = GetSelf()

dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."utils.lua")

local update_time_step = 0.01 
make_default_activity(update_time_step)

local sensor_data = get_base_data()

local ThrottleAxis = 2005														-- FC3 Left Throttle Axis

--local autothrottle_pid = PID(5, 0.02, 0.1, -0.71, 1.0, 1)   					-- Create the PID controller ( Kp, Ki, Kd, umin, umax, uscale )

local AT_P = get_param_handle("AT_PID_Kp")
local AT_I = get_param_handle("AT_PID_Ki")
local AT_D = get_param_handle("AT_PID_Kd")
--min = idle, max = Mil. Hardcoded


dev:listen_command(10064)														-- Toggle autothrottle
dev:listen_command(10065)														-- Toggle AoA 12/14
dev:listen_command(10066)														-- Gripen Throttle Axis
dev:listen_command(keys.GripenThrottleIncrease)
dev:listen_command(keys.GripenThrottleDecrease)


local ThrottleIncrement = 0.045
local AOA1214_STATE = 0
local AUTOTHROTTLE_STATE = 0
local speedHold = -100
local throttle = 0
local THROTTLE_INPUT = 1
local tpos = 0

local AT_Target = get_param_handle("AutoThrottle_Target")
local AT_Current = get_param_handle("AutoThrottle_Current")

function SetCommand(command,value)

	if command == 10066 then													-- Gripen Throttle Axis
		THROTTLE_INPUT = value
	end	
   
	if command == keys.GripenThrottleDecrease and THROTTLE_INPUT < 1 then			-- 1 is off, -1 is AB
		THROTTLE_INPUT = THROTTLE_INPUT + 0.045
	end
	
	if command == keys.GripenThrottleIncrease and THROTTLE_INPUT > -1 then
		THROTTLE_INPUT = THROTTLE_INPUT - 0.045
	end
   
   
	if command == 10064 then													-- Engage and disengage AT
		if AUTOTHROTTLE_STATE == 0 then
			AUTOTHROTTLE_STATE = 1
			tpos = THROTTLE_INPUT
			speedHold = sensor_data.getTrueAirSpeed()
			--print_message_to_user(speedHold)
		elseif AUTOTHROTTLE_STATE == 1 then
			AUTOTHROTTLE_STATE = 0
			speedHold = -100
			AT_Target:set(0)
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
		AT_Target:set(speedHold)
		AT_Current:set(sensor_data.getTrueAirSpeed())
		AT_P:set(0.1337)
		AT_I:set(0.069)
		AT_D:set(0.0420)
 	end	
end

function update_autothrottle_aoa12()											-- AoA 12 landing mode function

	if AUTOTHROTTLE_STATE == 1 then	
		AT_Target:set(12)
		AT_Current:set(math.deg(sensor_data.getAngleOfAttack()))
		AT_P:set(-1)
		AT_I:set(-0.03)
		AT_D:set(-1)
	end	



end

function update_autothrottle_aoa14()											-- AoA 14 landing mode function
	
	if AUTOTHROTTLE_STATE == 1 then	
		AT_Target:set(14)
		AT_Current:set(math.deg(sensor_data.getAngleOfAttack()))
		AT_P:set(-1)
		AT_I:set(-0.03)
		AT_D:set(-1)
	end	
end

function throttle_axis()
	--dispatch_action(nil, ThrottleAxis, THROTTLE_INPUT)
end			

function throttle_override()
	if AUTOTHROTTLE_STATE == 1 and (tpos - THROTTLE_INPUT) > 0.2 then
		dispatch_action(nil,10064)
	elseif AUTOTHROTTLE_STATE == 1 and (THROTTLE_INPUT - tpos) > 0.2 then
		dispatch_action(nil,10064)
	end
end

function update()		

--print_message_to_user(THROTTLE_INPUT)

	local ias = sensor_data.getIndicatedAirSpeed() * 1.944						-- IAS in kts

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








