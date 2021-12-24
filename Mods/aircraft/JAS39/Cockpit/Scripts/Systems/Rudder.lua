dofile(LockOn_Options.script_path.."command_defs.lua")
local update_time_step = 0.01 
make_default_activity(update_time_step)
local Rudder_system = GetSelf()
local sensor_data = get_base_data()

local arg17 = 0
local Rudder = 0
local RudderTimeSec = 1.11
local RudderIncrement = update_time_step / RudderTimeSec
local RUDDER_STATE = 0 
local RUDDER_TARGET = 0
local Diff1 = 0
local Diff2 = 0
local YAW_TARGET = 0



function get_data()
	arg17 = get_aircraft_draw_argument_value(17) 					--Raw values: 0.993, 0, -0.993 L/N/R
	Rudder = -get_param_handle("CURRENT_YAW_OUTPUT"):get() -- -sensor_data.getRudderPosition() * 0.08559919   		--Raw values: -85, 0, 85 L/N/R
	--print_message_to_user(Rudder)			
end

function update()
	get_data()
-- beginning of phases
-- ======================== Stationary =============================	
	if get_param_handle("CURRENT_PHASE_STATIONARY"):get() > 0.0 then
		RUDDER_TARGET = 0
		
-- ========================= Parked ================================
	elseif get_param_handle("CURRENT_PHASE_PARKED"):get() > 0.0 then 
		RUDDER_TARGET = Rudder
--========================= Taxi ================================
	elseif get_param_handle("CURRENT_PHASE_TAXI"):get()> 0.0 then
		RUDDER_TARGET = Rudder
-- ============= Take off ground roll ===========================
	elseif get_param_handle("CURRENT_PHASE_TGR"):get() > 0.0 then									
		RUDDER_TARGET = Rudder
		
-- ========================= Rotation ===========================	
	elseif get_param_handle("CURRENT_PHASE_ROT"):get() > 0.0 then
		RUDDER_TARGET = Rudder
		
-- ================== Lift off ================================
	elseif get_param_handle("CURRENT_PHASE_LO"):get() > 0.0 then
		RUDDER_TARGET = Rudder
		
--======================= Combat ===============================
	elseif get_param_handle("CURRENT_PHASE_CO"):get() > 0.0 then			
		RUDDER_TARGET = Rudder
--================ Powered Approach And Landing =================
	elseif get_param_handle("CURRENT_PHASE_PAL"):get() > 0.0 then
		RUDDER_TARGET = Rudder
-- ===================== Touch Down =============================		
	elseif get_param_handle("CURRENT_PHASE_TD"):get() > 0.0 then
		RUDDER_TARGET = Rudder
--======================= Landing Roll =========================
	elseif get_param_handle("CURRENT_PHASE_LR"):get() > 0.0 then
		RUDDER_TARGET = Rudder
	end	
-- end of phases
	

	--RUDDER_TARGET = Rudder
--===================== Animation ==========================
	Diff1 = RUDDER_TARGET - RUDDER_STATE  				-- Difference between desired and current RUDDER angle
	Diff2 = RUDDER_STATE - RUDDER_TARGET				-- Difference between current and desired RUDDER angle


	if (RUDDER_STATE < RUDDER_TARGET) and (Diff1 >= RudderIncrement) then
		RUDDER_STATE = RUDDER_STATE + RudderIncrement
	elseif (RUDDER_STATE > RUDDER_TARGET) and (Diff2 >= RudderIncrement) then
		RUDDER_STATE = RUDDER_STATE - RudderIncrement
	end
	
	if (RUDDER_STATE < -1) then							
		RUDDER_STATE = -1
	elseif (RUDDER_STATE > 1) then
		RUDDER_STATE = 1
	end
	
	set_aircraft_draw_argument_value(488,RUDDER_STATE - arg17)
	set_aircraft_draw_argument_value(2, RUDDER_STATE)				-- Nose wheel turning animation
end


need_to_be_closed = 0