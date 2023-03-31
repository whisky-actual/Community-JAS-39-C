dofile(LockOn_Options.script_path.."command_defs.lua")
local update_time_step = 0.01 
make_default_activity(update_time_step)
local filename = GetSelf()  
local sensor_data = get_base_data()
-------------------------------------------------------
-- Local Variables
-------------------------------------------------------
local RAD_TO_DEGREE  = 57.29577951308233
local AIRBRAKE_STATE = 0 
local AIRBRAKE_TARGET = 0
local Diff1 = 0
local Diff2 = 0
local AIRBRAKETimeSec = 1.08
local AIRBRAKEIncrement = update_time_step / AIRBRAKETimeSec
local AOA = 0
local AIRBRAKE_OUT = false
local SpeedBrakeInd =     get_param_handle("SpeedBrakeInd")
-------------------------------------------------------
-- Initialization Functions	
-------------------------------------------------------
	--None
-------------------------------------------------------
-- Params
-------------------------------------------------------
--dev:listen_command(device_commands.SpeedBrakeInd)
-------------------------------------------------------
-- Complexe Functions
-------------------------------------------------------
function Sensor_data()							-- Go to line 130 for list of available base data
	AOA = sensor_data.getAngleOfAttack() * RAD_TO_DEGREE		-- Angle of attack converted from radians to degrees
	SpeedBrakeInd:set(sensor_data.getSpeedBrakePos())
end



function update()
Sensor_data()



-- beginning of phases
-- ======================== Stationary =============================	
	--if get_param_handle("CURRENT_PHASE_STATIONARY"):get() > 0.0 then
		
		
-- ========================= Parked ================================
	--elseif get_param_handle("CURRENT_PHASE_PARKED"):get() > 0.0 then 

--========================= Taxi ================================
	if get_param_handle("CURRENT_PHASE_TAXI"):get()> 0.0 then
		if (AIRBRAKE_OUT == true) then 
			dispatch_action(nil,148)  						--Airbrake in
			AIRBRAKE_OUT = false
		end
-- ============= Take off ground roll ===========================
	--elseif get_param_handle("CURRENT_PHASE_TGR"):get() > 0.0 then									
	
		
-- ========================= Rotation ===========================	
	--elseif get_param_handle("CURRENT_PHASE_ROT"):get() > 0.0 then
		
		
-- ================== Lift off ================================
	--elseif get_param_handle("CURRENT_PHASE_LO"):get() > 0.0 then
		
		
-- ======================= Combat ==============================
	elseif get_param_handle("CURRENT_PHASE_CO"):get() > 0.0 then			
		if (AOA >= 26.5) and (AIRBRAKE_OUT == false) then
			dispatch_action(nil,147)
			AIRBRAKE_OUT = true
		elseif (AOA < 26.5) and (AIRBRAKE_OUT == true) then
			dispatch_action(nil,148)
			AIRBRAKE_OUT = false
		end
--================ Powered Approach And Landing =================
	--elseif get_param_handle("CURRENT_PHASE_PAL"):get() > 0.0 then
	
--===================== Touch Down =============================		
	elseif get_param_handle("CURRENT_PHASE_TD"):get() > 0.0 then
		if (AIRBRAKE_OUT == false) then	
			dispatch_action(nil,147)  					 --Airbrake out
			AIRBRAKE_OUT = true							 -- declares airbrake is out
		end
	end
--======================= Landing Roll =========================
	--elseif get_param_handle("CURRENT_PHASE_LR"):get() > 0.0 then
	
	--end	
-- end of phases

--set_aircraft_draw_argument_value(182,AIRBRAKE_STATE) --(arg,value)
end

need_to_be_closed = false