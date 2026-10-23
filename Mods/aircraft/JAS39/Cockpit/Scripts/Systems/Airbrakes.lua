dofile(LockOn_Options.script_path .. "command_defs.lua")
local update_time_step = 0.01
make_default_activity(update_time_step)
local filename = GetSelf()
local sensor_data = get_base_data()

local AIRBRAKE_OUT  = false
local SpeedBrakeInd = get_param_handle("SpeedBrakeInd")

function Sensor_data()
	SpeedBrakeInd:set(sensor_data.getSpeedBrakePos()) -- TODO: Fix the airbrake indicator and correct keybinds? (does EFM work with the S4 or FC3)?
end

-- dispatch_action(nil,148) = Airbrake in.
-- dispatch_action(nil,147) = Airbrake out.

function update()
	Sensor_data()


	if get_param_handle("CURRENT_PHASE_STATIONARY"):get() == 1 or get_param_handle("CURRENT_PHASE_PARKED"):get() == 1 or get_param_handle("CURRENT_PHASE_TAXI"):get() == 1 then
		if AIRBRAKE_OUT == true then
			dispatch_action(nil, 148)
			AIRBRAKE_OUT = false
		end
	elseif get_param_handle("CURRENT_PHASE_TGR"):get() == 1 or get_param_handle("CURRENT_PHASE_ROT"):get() == 1 then
		if AIRBRAKE_OUT == true or SpeedBrakeInd:get() == 1 then
			dispatch_action(nil, 148)
			AIRBRAKE_OUT = false
		end
	elseif get_param_handle("CURRENT_PHASE_LO"):get() == 1 or get_param_handle("CURRENT_PHASE_CO"):get() == 1 or get_param_handle("CURRENT_PHASE_PAL"):get() == 1 then
		if get_param_handle("CUR_AOA"):get() >= 26.5 and AIRBRAKE_OUT == false and SpeedBrakeInd:get() ~= 1 then
			dispatch_action(nil, 147)
			AIRBRAKE_OUT = true
		elseif get_param_handle("CUR_AOA"):get() < 26.5 and AIRBRAKE_OUT == true and SpeedBrakeInd:get() == 1 then
			dispatch_action(nil, 148)
			AIRBRAKE_OUT = false
		end
	elseif get_param_handle("CURRENT_PHASE_TD"):get() == 1 or get_param_handle("CURRENT_PHASE_LR"):get() == 1 then
		if AIRBRAKE_OUT == false then
			dispatch_action(nil, 147)
			AIRBRAKE_OUT = true
		end
	end
end



need_to_be_closed = false