dofile(LockOn_Options.script_path.."command_defs.lua")

local electric_system = GetSelf()

local update_time_step = 1 --update will be called 1 time per second

make_default_activity(update_time_step)

local RWR_Power = get_param_handle("RWRPOWER_STATE")

function post_initialize()
	RWR_Power:set(1)

end
need_to_be_closed = false -- close lua state after initialization


