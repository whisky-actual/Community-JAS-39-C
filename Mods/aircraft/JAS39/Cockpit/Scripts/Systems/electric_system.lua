dofile(LockOn_Options.script_path.."command_defs.lua")

local electric_system = GetSelf()
local dev = electric_system

local update_time_step = 0.02  
make_default_activity(update_time_step)

local sensor_data = get_base_data()

function post_initialize()  

   value = 1
   electric_system:AC_Generator_1_on(value > 0)
   electric_system:AC_Generator_2_on(value > 0)
   electric_system:DC_Battery_on(value > 0)
  
end

local parameters = 
{
    BATTERY           = get_param_handle("BATTERY"), --I tend to make params in ALL UPPERCASE
    GENLEFTSWITCH     = get_param_handle("GENLEFTSWITCH"),
    GENRIGHTSWITCH    = get_param_handle("GENRIGHTSWITCH"),
}

function SetCommand(command,value)

end

afterbunr_state = 0
afterburne_val = 0
afterburne_dir = 0.5

local CUR_IAS = get_param_handle("CUR_IAS")
local CUR_TAS = get_param_handle("CUR_TAS")
local ALTIBARO2 = get_param_handle("ALTIBARO2")

local PowerOnOff        = Keys.PowerOnOff --setting the iCommands from command defs 
local battery_click     = device_commands.BatterySwitchClick--Track mouse clicks

local LeftGen           = Keys.PowerGeneratorLeft --setting the iCommands from command defs 
local lgen_click        = device_commands.GenRightSwitch--Track mouse clicks

local RightGen          = Keys.PowerGeneratorRight --setting the iCommands from command defs 
local rgen_click        = device_commands.GenLeftSwitch--Track mouse clicks

electric_system:listen_command(PowerOnOff) --listen command needs to be here to work in set command
electric_system:listen_command(battery_click)

battery_state = 0 -- I tend to make local vars all lower case

------------------------------------------------------------------FUNCTION-POST-INIT---------------------------------------------------------------------------------------------------
function post_initialize()
	-- print_message_to_user("Electrical System Initialize")
    local birth = LockOn_Options.init_conditions.birth_place

    if birth == "GROUND_HOT" or birth == "AIR_HOT" then
        battery_state = 1
        right_gen_state = 1
        left_gen_state = 1
        dispatch_action(nil,PowerOnOff)--power will be on by default so we turn it off so when the click happens to set the switch it turns it back on...
        --dispatch_action(nil,keys.BrightnessILS)
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
    --GetDevice(devices.RADAR):set_power(true)
    --GetDevice(devices.RWR):set_power(true)

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
	local current_aos = sensor_data.getAngleOfSlide() 
	local current_aoa = sensor_data.getAngleOfAttack() 
	local current_throtte = sensor_data.getThrottleLeftPosition()
	local engine_rpm = sensor_data.getEngineLeftRPM()
	
	local tSpeed = sensor_data.getTrueAirSpeed() -- km/h
	local iSpeed = sensor_data.getHeading() % 360   -- km/h
    -- local BatterySwitch= get_clickable_element_reference("PNT_107")
    -- BatterySwitch:update() -- ensure the connector moves too
end --END UPDATE

need_to_be_closed = false 