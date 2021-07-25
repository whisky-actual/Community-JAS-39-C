local dev = GetSelf()

local update_time_step = 0.05
make_default_activity(update_time_step)

local sensor_data = get_base_data()
local WHEELCHOCKS_LADDER_ANIM_ARG = 499

--Creating local variables
local WHEELCHOCKS_STATE = 0 -- state of wheel chocks
local wheelchocks_state_param = get_param_handle("WHEEL_CHOCKS_STATE")
wheelchocks_state_param:set(WHEELCHOCKS_STATE)

local P_BRAKE = 10059

dev:listen_event("WheelChocksOn")
dev:listen_event("WheelChocksOff")

function CockpitEvent(event,val)
    if event == "WheelChocksOn" then
        WHEELCHOCKS_STATE = 1
        wheelchocks_state_param:set(WHEELCHOCKS_STATE)
		dispatch_action(nil,P_BRAKE)
    elseif event == "WheelChocksOff" then
        WHEELCHOCKS_STATE = 0
        wheelchocks_state_param:set(WHEELCHOCKS_STATE)
		dispatch_action(nil,P_BRAKE)
    end
end

function update()		

	set_aircraft_draw_argument_value(WHEELCHOCKS_LADDER_ANIM_ARG, WHEELCHOCKS_STATE)
	
end

need_to_be_closed = false