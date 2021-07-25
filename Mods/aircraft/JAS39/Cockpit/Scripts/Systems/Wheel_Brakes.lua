local dev = GetSelf()
dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")

local dt = 0.024
make_default_activity(dt)

local sensor_data = get_base_data()

local B_axis_value  = -1
local BrakesON      = false
local BrakesOFF     = true
local P_Brake		= 0
local L_axis_value  = -1
local R_axis_value  = -1

--You will need to create custom input commands for the brakes. Add them in Input and in command_defs
dev:listen_command(10038)--Brakes On	
dev:listen_command(10039)--Brakes Off	
dev:listen_command(10056)--left axis
dev:listen_command(10057)--right axis
dev:listen_command(10058)--both axis
dev:listen_command(10059)--parking brake

function SetCommand(command,value)	
--Axis Commands
    if command == 10056 then --left brake
        L_axis_value = value
    elseif command == 10057 then--right brake
        R_axis_value = value
    elseif command == 10058 then-- Both brakes 
        L_axis_value = value
        R_axis_value = value
	end 
   
--Keyboard Commands
    if command == 10039 then		-- and (BrakesON == false or BrakesOFF == true)
       -- BrakesON = true
       -- BrakesOFF = false
        L_axis_value = -1
        R_axis_value = -1
    elseif command == 10038 then		-- and (BrakesON == true or BrakesOFF == false)
	--	BrakesON = false
	--	BrakesOFF = true
		L_axis_value = 1
		R_axis_value = 1

	end
	
-- Parking brake
	if (command == 10059) and (BrakesON == false) then
		L_axis_value = 1
		R_axis_value = 1
		BrakesON = true
	elseif (command == 10059) and (BrakesON == true) then
	    L_axis_value = -1
		R_axis_value = -1
		BrakesON = false
	end
	
end

function update()

    if B_axis_value > 0.1 or (L_axis_value > 0.1 or R_axis_value > 0.1) then
        dispatch_action(nil,74)
        --print_message_to_user("Brakes ON")		--used for debugging
    else
        dispatch_action(nil,75)
    end


end		
need_to_be_closed = false