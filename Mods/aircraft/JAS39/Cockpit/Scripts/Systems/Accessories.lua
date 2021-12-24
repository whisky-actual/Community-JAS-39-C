local dev = GetSelf()

dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")

local update_time_step = 0.05
make_default_activity(update_time_step)

local sensor_data = get_base_data()
local WHEELCHOCKS_LADDER_ANIM_ARG = 499

local WHEELCHOCKS_STATE = 0 					-- state of wheel chocks

dev:listen_command(10038)
dev:listen_command(10039)

dev:listen_event("WheelChocksOn")
dev:listen_event("WheelChocksOff")

function CockpitEvent(event,val)
    if event == "WheelChocksOn" then
        WHEELCHOCKS_STATE = 1
    elseif event == "WheelChocksOff" then
        WHEELCHOCKS_STATE = 0
    end
end

function update()		
	if WHEELCHOCKS_STATE == 1 then
	dispatch_action(nil,10038)
	elseif WHEELCHOCKS_STATE == 0 then
	dispatch_action(nil,10039)
	WHEELCHOCKS_STATE = -1
	end

	set_aircraft_draw_argument_value(WHEELCHOCKS_LADDER_ANIM_ARG, WHEELCHOCKS_STATE)
	
end

need_to_be_closed = false