local dev = GetSelf()
dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")

local dt = 0.024
make_default_activity(dt)

local sensor_data = get_base_data()

local B_axis_value  = -1
local BrakesON      = false
local BrakesOFF     = true

local L_axis_value  = -1
local R_axis_value  = -1

dev:listen_command(10000)--Brakes On	74
dev:listen_command(10001)--Brakes Off	75

--TODO: Create custom 

--You will need to create custom input commands for the brakes same way I did for F-22 there was an F-22 wheel brakes axis
dev:listen_command(10002)--left axis
dev:listen_command(10003)--right axis
dev:listen_command(10004)--both axis


function SetCommand(command,value)
--Axis Commands
    if command == 10002 then --left brake
        L_axis_value = value
    elseif command == 10003 then--right brake
        R_axis_value = value
    elseif command == 10004 then-- Both brakes ?
        L_axis_value = value
        R_axis_value = value
    end
--Keyboard Commands
    if command == 10000 and (BrakesON == false or BrakesOFF == true) then
        BrakesON = true
        BrakesOFF = false
        L_axis_value = 1
        R_axis_value = 1
    elseif command == 10001 and (BrakesON == true or BrakesOFF == false) then
		BrakesON = false
		BrakesOFF = true
		L_axis_value = -1
		R_axis_value = -1

end

function update()

    if B_axis_value > 0.1 or (L_axis_value > 0.1 or R_axis_value > 0.1) then
        dispatch_action(nil,74)
        print_message_to_user("Brakes ON")
    else
        dispatch_action(nil,75)
    end

end
