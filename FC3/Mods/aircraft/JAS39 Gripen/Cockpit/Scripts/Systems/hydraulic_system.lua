dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."Systems/hydraulic_system_api.lua")
dofile(LockOn_Options.script_path.."Systems/electric_system_api.lua")
dofile(LockOn_Options.script_path.."utils.lua")

local hydraulic_system = GetSelf()

local update_time_step = 0.1 --update() 每秒10次
make_default_activity(update_time_step)

startup_print("hydraulic_system: load")

local conthyd_light_param   = get_param_handle("D_CONTHYD_CAUTION")
local utilhyd_light_param   = get_param_handle("D_UTILHYD_CAUTION")

function update_hydraulic_state()
    -- TODO: only enable hydraulics when engine is running
    if get_elec_primary_dc_ok() then
        hyd_flight_control_ok:set(1)
        hyd_utility_ok:set(1)
        hyd_brakes_ok:set(1)
        conthyd_light_param:set(1)
        utilhyd_light_param:set(1)
    else
        hyd_flight_control_ok:set(0)
        hyd_utility_ok:set(0)
        hyd_brakes_ok:set(0)
    end
end

function update()
    update_hydraulic_state()
end

function post_initialize()
    startup_print("hydraulic_system: postinit start")
end

function SetCommand(command,value)

end

need_to_be_closed = false -- close lua state after initialization
