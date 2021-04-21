dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")

local engine_system = GetSelf()
local sensor_data		= get_base_data()

local update_time_step = 0.006 --0.006
make_default_activity(update_time_step)

local parameters = 
{
    ENGINE_R_COVER = get_param_handle("ENGINE_R_COVER"),
    ENGINE_L_COVER = get_param_handle("ENGINE_L_COVER"),
    ENGINE_R_CRANK = get_param_handle("ENGINE_R_CRANK"),
    ENGINE_L_CRANK = get_param_handle("ENGINE_L_CRANK"),
}
local engine_rcover_click = device_commands.FuelPumpRCover
local engine_rcover_state = 0

local engine_rcrank_key = Keys.RightEngineStart
local engine_rshutoff = Keys.RightEngineStop
local engine_rcrank_click = device_commands.FuelPumpRight
local engine_r_state = 0

local engine_lcover_click = device_commands.FuelPumpLCover
local engine_lcover_state = 0

local engine_lcrank_key = Keys.LeftEngineStart
local engine_lshutoff = Keys.LeftEngineStop
local engine_lcrank_click = device_commands.FuelPumpLeft
local engine_l_state = 0


engine_system:listen_command(engine_rcover_click)
engine_system:listen_command(engine_rshutoff)
engine_system:listen_command(engine_rcrank_key)
engine_system:listen_command(engine_rcrank_click)

engine_system:listen_command(engine_lcover_click)
engine_system:listen_command(engine_lshutoff)
engine_system:listen_command(engine_lcrank_key)
engine_system:listen_command(engine_lcrank_click)
------------------------------------------------------------------FUNCTION-POST-INIT---------------------------------------------------------------------------------------------------
function post_initialize()

    local birth = LockOn_Options.init_conditions.birth_place
    if birth == "GROUND_HOT" or birth == "AIR_HOT" then
        engine_r_state = 1
        engine_system:performClickableAction(engine_rcrank_click, 1, false)
        engine_l_state = 1
        engine_system:performClickableAction(engine_lcrank_click, 1, false)
    elseif birth =="GROUND_COLD" then
        --print_message_to_user("COLD START")
    end
	
end
------------------------------------------------------------------FUNCTION-SETCOMMAND---------------------------------------------------------------------------------------------------
function SetCommand(command,value)


    if command ==  engine_rcover_click and engine_rcover_state == 0 then
        engine_rcover_state = 1
        -- print_message_to_user("open")
    elseif command == engine_rcover_click and engine_rcover_state == 1 then
        engine_rcover_state = 0
        -- print_message_to_user("close")
    end

    if command == engine_rcrank_click and engine_r_state == 0 and engine_rcover_state == 1 then
        engine_r_state = 1
        dispatch_action(nil, engine_rcrank_key)
    elseif command == engine_rcrank_click and engine_r_state == 1 and engine_rcover_state == 1 then
        engine_r_state = 0 
        dispatch_action(nil, engine_rshutoff)
    end

    if command ==  engine_lcover_click and engine_lcover_state == 0 then
        engine_lcover_state = 1
        -- print_message_to_user("open")
    elseif command == engine_lcover_click and engine_lcover_state == 1 then
        engine_lcover_state = 0
        -- print_message_to_user("close")
    end

    if command == engine_lcrank_click and engine_l_state == 0 and engine_lcover_state == 1 then
        engine_l_state = 1
        dispatch_action(nil, engine_lcrank_key)
    elseif command == engine_lcrank_click and engine_l_state == 1 and engine_lcover_state == 1 then
        engine_l_state = 0 
        dispatch_action(nil, engine_lshutoff)
    end
end
------------------------------------------------------------------FUNCTION-UPDATE---------------------------------------------------------------------------------------------------
function update()
    parameters.ENGINE_R_COVER:set(engine_rcover_state)
    parameters.ENGINE_R_CRANK:set(engine_r_state)
    parameters.ENGINE_L_COVER:set(engine_lcover_state)
    parameters.ENGINE_L_CRANK:set(engine_l_state)
    local engine_r_connector = get_clickable_element_reference("R_Engine_Crank")
    engine_r_connector:update() -- ensure the connector moves too
    local engine_l_connector = get_clickable_element_reference("L_Engine_Crank")
    engine_l_connector:update() -- ensure the connector moves too
end