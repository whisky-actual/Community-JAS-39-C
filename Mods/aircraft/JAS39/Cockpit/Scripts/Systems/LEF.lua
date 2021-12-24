dofile(LockOn_Options.script_path.."command_defs.lua")

local update_time_step = 0.01 
make_default_activity(update_time_step)

local sensor_data = get_base_data()

--local rate_met2knot = 0.539956803456
local ias_knots = 0 -- * rate_met2knot
local LEF_STATE = 0
local LEF_TARGET = 0
local Diff1 = 0
local Diff2 = 0
--local DEGREE_TO_RAD  = 0.0174532925199433
local RAD_TO_DEGREE  = 57.29577951308233
local slat_system = GetSelf()
local AOA = 0
local MACH = 0
local LEFTimeSec = 1.78
local LEFIncrement = update_time_step / LEFTimeSec
local arg13 = 0
local arg14 = 0
local DUMPINGLIFT = 0

function Sensor_data()
    --ias_knots = sensor_data.getIndicatedAirSpeed() * 3.6 * rate_met2knot
    --print_message_to_user("ISA:")
    --print_message_to_user(ias_knots)
    --print_message_to_user("SLAT_POS:")
	MACH = sensor_data.getMachNumber()
    AOA =(sensor_data.getAngleOfAttack() * RAD_TO_DEGREE)
    -- SLATS_STATE = tonumber(string.format(fmt,AOA))
    -- print_message_to_user(SLATS_STATE)
	arg13 = get_aircraft_draw_argument_value(13)
	arg14 = get_aircraft_draw_argument_value(14)
end

function alfa_movement()
	if (AOA >= 27) then
		LEF_TARGET = 1
	elseif (AOA < 27) then
		LEF_TARGET= AOA/27
	end
end


function update()
    Sensor_data()
-- beginning of phases
-- ======================== Stationary =============================	
	--if get_param_handle("CURRENT_PHASE_STATIONARY"):get() > 0.0 then						
		
-- ========================= Parked ================================
	if get_param_handle("CURRENT_PHASE_PARKED"):get() > 0.0 then		
		LEF_TARGET = 0
	DUMPINGLIFT = 0	
--========================= Taxi ================================
 	elseif get_param_handle("CURRENT_PHASE_TAXI"):get() > 0.0 then				
		if get_param_handle("BRAKE_FORCE"):get() > 0.0 then
			if DUMPINGLIFT == 1 then 
				LEF_TARGET = get_param_handle("BRAKE_FORCE"):get()
			elseif DUMPINGLIFT == 0 then
				LEF_TARGET = 0		
			end
		else 
			LEF_TARGET = 0
		end
-- ============= Take off ground roll ===========================
-- 	elseif get_param_handle("CURRENT_PHASE_TGR"):get() > 0.0 then										


-- ==================== Rotate =======================
 	elseif get_param_handle("CURRENT_PHASE_ROT"):get() > 0.0 then
	alfa_movement()

 --================== Lift off ================================
   elseif get_param_handle("CURRENT_PHASE_LO"):get() > 0.0 then							
	alfa_movement()

-- ================= Combat ===================================			
	elseif get_param_handle("CURRENT_PHASE_CO"):get() > 0.0 then
		if (MACH < 1) then
			alfa_movement()
		elseif (MACH >= 1) then
			LEF_TARGET = -1
		end
		
--===================== Powered Approach And Landing ============
	elseif get_param_handle("CURRENT_PHASE_PAL"):get() > 0.0 then							
		alfa_movement()
-- ===================== Touch Down =============================	
 	elseif get_param_handle("CURRENT_PHASE_TD"):get() > 0.0 then									
	alfa_movement()
-- ======================= Landing roll =======================		-- Lift dumping
	elseif get_param_handle("CURRENT_PHASE_LR"):get() > 0.0 then
		if get_param_handle("BRAKE_FORCE"):get() > 0.0 then
			LEF_TARGET = get_param_handle("BRAKE_FORCE"):get()
			DUMPINGLIFT = 1
		elseif get_param_handle("BRAKE_FORCE"):get() <= 0.0 then
			LEF_TARGET = 0
			DUMPINGLIFT = 0
		end
	end
-- end of phases	
	--print_message_to_user(LEF_TARGET)
--===================== Actuation of leading edge flaps ==========================	
	
	Diff1 = LEF_TARGET - LEF_STATE  			-- Difference between desired and current canard angle
	Diff2 = LEF_STATE - LEF_TARGET				-- Difference between current and desired canard angle
	
	if (LEF_STATE < LEF_TARGET) and (Diff1 >= LEFIncrement) then
		LEF_STATE = LEF_STATE + LEFIncrement
	elseif (LEF_STATE > LEF_TARGET) and (Diff2 >= LEFIncrement) then
		LEF_STATE = LEF_STATE - LEFIncrement
	end
	
    set_aircraft_draw_argument_value(477,LEF_STATE - arg13)	-- Right LEF
    set_aircraft_draw_argument_value(478,LEF_STATE - arg14)	-- Left LEF
end

need_to_be_closed = false