-----DOFILE-------------
dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")
-----UPDATE-------------
local electric_system = GetSelf()
local sensor_data		= get_base_data()
local update_time_step = 0.006 --0.006
make_default_activity(update_time_step)

--We make a table for get params as they can exceed 200 upticks very easy
local parameters = 
{
    BATTERY           = get_param_handle("BATTERY"), --I tend to make params in ALL UPPERCASE
    GENLEFTSWITCH     = get_param_handle("GENLEFTSWITCH"),
    GENRIGHTSWITCH    = get_param_handle("GENRIGHTSWITCH"),
}

-----LISTEN COMMANDS HERE-----
local PowerOnOff        = Keys.PowerOnOff --setting the iCommands from command defs 
local battery_click     = device_commands.BatterySwitchClick--Track mouse clicks

local LeftGen           = Keys.PowerGeneratorLeft --setting the iCommands from command defs 
local lgen_click        = device_commands.GenRightSwitch--Track mouse clicks

local RightGen          = Keys.PowerGeneratorRight --setting the iCommands from command defs 
local rgen_click        = device_commands.GenLeftSwitch--Track mouse clicks

electric_system:listen_command(LeftGen)
electric_system:listen_command(RightGen)
electric_system:listen_command(lgen_click)
electric_system:listen_command(rgen_click)
electric_system:listen_command(PowerOnOff) --listen command needs to be here to work in set command
electric_system:listen_command(battery_click)

-- adi_yaw:set(sensor_data.getRateOfYaw())

-----Local Variables Here-----
battery_state = 0 -- I tend to make local vars all lower case
left_gen_state = 0
right_gen_state = 0

------------------------------------------------------------------FUNCTION-POST-INIT---------------------------------------------------------------------------------------------------
function post_initialize()
	-- print_message_to_user("Electrical System Initialize")
    local birth = LockOn_Options.init_conditions.birth_place

    if birth == "GROUND_HOT" or birth == "AIR_HOT" then
        battery_state = 1
        right_gen_state = 1
        left_gen_state = 1
        dispatch_action(nil,PowerOnOff)--power will be on by default so we turn it off so when the click happens to set the switch it turns it back on...
        electric_system:performClickableAction(battery_click, 1, false)
        --set_aircraft_draw_argument_value(616, 0)--GPU CART ON/OFF
        -- print_message_to_user("HOT START")
        --dispatch_action(nil,1073)
    elseif birth =="GROUND_COLD" then
        --print_message_to_user("COLD START")
    end
	
	-- electric_system:set_power(true)
   electric_system:AC_Generator_1_on(true)
   electric_system:AC_Generator_2_on(true)
   electric_system:DC_Battery_on(true)
	GetDevice(devices.RWR):set_power(true)

end
------------------------------------------------------------FUNCTION-SETCOMMAND---------------------------------------------------------------------------------------------------
function SetCommand(command,value)
--BATTERY iCOMMAND
    if command == PowerOnOff and battery_state == 0 then
        battery_state = 1
        --print_message_to_user("BATTERY ON")--spell out what you are testing it makes it eaiser to track whats going on
    elseif command == PowerOnOff and battery_state == 1 then
        battery_state = 0
        --print_message_to_user("BATTERY OFF")
    end
    --Battery Click Command
    if command == battery_click then
        dispatch_action(nil,PowerOnOff)-- this is used to push a keyboad/icommand with a mouse click
        --print_message_to_user("BATTERY CLICK")
    end
end--END SETCOMMAND
------------------------------------------------------------------FUNCTION-UPDATE---------------------------------------------------------------------------------------------------
function update()
    parameters.BATTERY:set(battery_state)--this will set the BATTERY param to the battery_state local variable # so 0 or 1
    -- print_message_to_user(battery_state)

    -- local BatterySwitch= get_clickable_element_reference("PNT_107")
    -- BatterySwitch:update() -- ensure the connector moves too
end --END UPDATE