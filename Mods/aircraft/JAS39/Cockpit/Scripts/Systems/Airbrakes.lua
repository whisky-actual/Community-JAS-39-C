dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."utils.lua")
local update_time_step = 0.01 
make_default_activity(update_time_step)
local dev = GetSelf()  
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
local SpeedBrakeInd = get_param_handle("SpeedBrakeInd")



dev:listen_command(keys.PlaneAirBrake)
dev:listen_command(keys.PlaneAirBrakeOn)
dev:listen_command(keys.PlaneAirBrakeOff)


local AIRBRAKE_TARGET = 0
local AIRBRAKE_STATE = 0
local isOverAOALimit = false

function SetCommand(command,value)
	if command == keys.PlaneAirBrake then 
		if AIRBRAKE_OUT == false then
			AIRBRAKE_TARGET = 1
			AIRBRAKE_OUT = true
		else
			AIRBRAKE_TARGET = 0
			AIRBRAKE_OUT = false
		end

	elseif command == keys.PlaneAirBrakeOn then
		AIRBRAKE_TARGET = 1
		AIRBRAKE_OUT = true
	elseif command == keys.PlaneAirBrakeOff then
		AIRBRAKE_TARGET = 0
		AIRBRAKE_OUT = false
	end


	--print_message_to_user(command)
end



function Sensor_data()					
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
			AIRBRAKE_TARGET = 0 --dispatch_action(nil,148)  						--Airbrake in
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
			AIRBRAKE_TARGET = 1 --dispatch_action(nil,147)
			AIRBRAKE_OUT = true
			isOverAOALimit = true
		elseif (AOA < 26.5) and (isOverAOALimit == true) then
			AIRBRAKE_TARGET = 0 --dispatch_action(nil,148)
			AIRBRAKE_OUT = false
			isOverAOALimit = false
		end
--================ Powered Approach And Landing =================
	--elseif get_param_handle("CURRENT_PHASE_PAL"):get() > 0.0 then
	
--===================== Touch Down =============================		
	elseif get_param_handle("CURRENT_PHASE_TD"):get() > 0.0 then
		if (AIRBRAKE_OUT == false) then	
			AIRBRAKE_TARGET = 1 --dispatch_action(nil,147)  					 --Airbrake out
			AIRBRAKE_OUT = true							 -- declares airbrake is out
		end
	end


	AIRBRAKE_STATE = MoveControlSurface(AIRBRAKE_STATE, AIRBRAKE_TARGET, AIRBRAKEIncrement)

	set_aircraft_draw_argument_value(182,AIRBRAKE_STATE) -- for 3D model animation
	set_aircraft_draw_argument_value(21,AIRBRAKE_STATE) -- for SFM drag, animation not present on external model
end

need_to_be_closed = false