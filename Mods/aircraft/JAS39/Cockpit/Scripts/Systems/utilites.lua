dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")

local utilites = GetSelf()
local sensor_data		= get_base_data()

local update_time_step = 0.006 --0.006
make_default_activity(update_time_step)

local parameters = 
{
    FUELCOVER = get_param_handle("FUELCOVER"),
    FUELPROBE = get_param_handle("FUELPROBE"),
    HOOK      = get_param_handle("HOOK")
}

local fuel_cover_click = device_commands.FuelProbeCover
local fuel_cover_state = 0

local hook_click = device_commands.HookSwitch
local hook_state = 0
local hook_key = Keys.PlaneHook

local fuel_probe_key = Keys.PlaneAirRefuel
local fuel_probe_click = device_commands.FuelProbeSwitch
local fuel_probe_state = 0

utilites:listen_command(fuel_cover_click)
utilites:listen_command(fuel_probe_key)
utilites:listen_command(fuel_probe_click)
utilites:listen_command(hook_click)
utilites:listen_command(hook_key)
------------------------------------------------------------------FUNCTION-POST-INIT---------------------------------------------------------------------------------------------------
function post_initialize()

    -- print_message_to_user("AAR:System")
	

end
------------------------------------------------------------------FUNCTION-SETCOMMAND---------------------------------------------------------------------------------------------------
function SetCommand(command,value)

    if command == fuel_probe_click and fuel_probe_state == 0 and fuel_cover_state == 1 then
        fuel_probe_state = 1
        dispatch_action(nil, fuel_probe_key)
    elseif command == fuel_probe_click and fuel_probe_state == 1 and fuel_cover_state == 1 then
        fuel_probe_state = 0 
        dispatch_action(nil, fuel_probe_key)
    end

    if command == hook_click and hook_state == 0 then
        hook_state = 1
        dispatch_action(nil,hook_key)
    elseif command == hook_click and hook_state == 1 then
        hook_state = 0
        dispatch_action(nil,hook_key)
    end


    if command ==  fuel_cover_click and fuel_cover_state == 0 then
        fuel_cover_state = 1
        -- print_message_to_user("open")
    elseif command == fuel_cover_click and fuel_cover_state == 1 then
        fuel_cover_state = 0
        if fuel_probe_state == 1 then
            fuel_probe_state = 0
            dispatch_action(nil, fuel_probe_key)
        end
        -- print_message_to_user("close")
    end
end
------------------------------------------------------------------FUNCTION-UPDATE---------------------------------------------------------------------------------------------------
function update()
    parameters.FUELCOVER:set(fuel_cover_state)
    parameters.FUELPROBE:set(fuel_probe_state)
    parameters.HOOK:set(hook_state)
    local FuelSwitchConnector = get_clickable_element_reference("Fuel_Probe")
    FuelSwitchConnector:update() -- ensure the connector moves too
end