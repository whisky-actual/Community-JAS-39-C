dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")

local canopy_system = GetSelf()
local sensor_data		= get_base_data()
local update_time_step = 0.006 --0.006
make_default_activity(update_time_step)

--We make a table for get params as they can exceed 200 upticks very easy
local parameters = 
{
    CANOPY = get_param_handle("CANOPY"), --I tend to make params in ALL UPPERCASE
}



-----LISTEN COMMANDS HERE-----
local canopy_key = Keys.PlaneFonar --setting the iCommands from command defs 
local canopy_click =  device_commands.CanopySwitch--Track mouse clicks

canopy_system:listen_command(canopy_key) --listen command needs to be here to work in set command
canopy_system:listen_command(canopy_click)


-----Local Variables Here-----
local canopy_state = 0 -- I tend to make local vars all lower case
------------------------------------------------------------------FUNCTION-POST-INIT---------------------------------------------------------------------------------------------------
function post_initialize()
    local birth = LockOn_Options.init_conditions.birth_place
    if birth == "GROUND_HOT" or birth == "AIR_HOT" then
        canopy_state = 0
        -- dispatch_action(nil,canopy_key)--power will be on by default so we turn it off so when the click happens to set the switch it turns it back on...
        Canopy_system:performClickableAction(canopy_click, 0, false)--set battery switch ON
    elseif birth =="GROUND_COLD" then
        canopy_state = 1
        -- dispatch_action(nil,canopy_key)--power will be on by default so we turn it off so when the click happens to set the switch it turns it back on...
        Canopy_system:performClickableAction(canopy_click, 0, false)
    end
end
------------------------------------------------------------------FUNCTION-SETCOMMAND---------------------------------------------------------------------------------------------------
function SetCommand(command,value)
    if command == canopy_key and canopy_state == 0 then
        canopy_state = 1
    elseif command == canopy_key and canopy_state == 1 then
        canopy_state = 0
    end
    --Battery Click Command
    if command == canopy_click then
        dispatch_action(nil,canopy_key)-- this is used to push a keyboad/icommand with a mouse click
        --print_message_to_user("BATTERY CLICK")
    end


end
------------------------------------------------------------------FUNCTION-UPDATE---------------------------------------------------------------------------------------------------
function update()
    parameters.CANOPY:set(canopy_state)
    local Canopyclickconnector = get_clickable_element_reference("Canopy_click")
    Canopyclickconnector:update() -- ensure the connector moves too

end