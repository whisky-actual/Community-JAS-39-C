local dev = GetSelf()
dofile(LockOn_Options.common_script_path.."devices_defs.lua")
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
local current_braking_force = get_param_handle("BRAKE_FORCE")
current_braking_force:set(0.0)

--You will need to create custom input commands for the brakes. Add them in Input and in command_defs
dev:listen_command(10038)--Brakes On	
dev:listen_command(10039)--Brakes Off	
dev:listen_command(10056)--left axis
dev:listen_command(10057)--right axis
dev:listen_command(10058)--both axis
dev:listen_command(10059)--parking brake
dev:listen_command(device_commands.ParkingBrake) 	-- Parking brake: 0 = enabled, 1 = disabled

function post_initialize()

    local birth = LockOn_Options.init_conditions.birth_place
    if birth=="AIR_HOT" then
		dev:performClickableAction(device_commands.ParkingBrake, 1, true)
		L_axis_value = -1
		R_axis_value = -1
		BrakesON = false
	   
	elseif birth=="GROUND_HOT" then
		dev:performClickableAction(device_commands.ParkingBrake, 1, true)	
		L_axis_value = -1
		R_axis_value = -1
		BrakesON = false
			
		
    elseif birth=="GROUND_COLD" then
		dev:performClickableAction(device_commands.ParkingBrake, 0, true)
		L_axis_value = 1
		R_axis_value = 1
		BrakesON = true		
		
    end

end

function SetCommand(command,value)	
--Axis Commands
    if command == 10056 then --left brake
        L_axis_value = value
		current_braking_force:set(value)
    elseif command == 10057 then--right brake
        R_axis_value = value
		current_braking_force:set(value)
    elseif command == 10058 then-- Both brakes 
        L_axis_value = value
        R_axis_value = value
		current_braking_force:set(value)
	end 
   
--Keyboard Commands
    if command == 10039 then		-- and (BrakesON == false or BrakesOFF == true)
       -- BrakesON = true
       -- BrakesOFF = false
        L_axis_value = -1
        R_axis_value = -1
		current_braking_force:set(-1)
    elseif command == 10038 then		-- and (BrakesON == true or BrakesOFF == false)
	--	BrakesON = false
	--	BrakesOFF = true
		L_axis_value = 1
		R_axis_value = 1
		current_braking_force:set(1)

	end
	
-- Parking brake toggle
	if (command == 10059) and (BrakesON == false) then
		dev:performClickableAction(device_commands.ParkingBrake, 0, true)	
		L_axis_value = 1
		R_axis_value = 1
		BrakesON = true
	elseif (command == 10059) and (BrakesON == true) then
		dev:performClickableAction(device_commands.ParkingBrake, 1, true)		
	    L_axis_value = -1
		R_axis_value = -1
		BrakesON = false
	elseif command == device_commands.ParkingBrake then
		if value == 0 then
			L_axis_value = 1
			R_axis_value = 1
			BrakesON = true
		elseif value == 1 then
			L_axis_value = -1
			R_axis_value = -1
			BrakesON = false
		end		
	end
	
end


function update()
	
    if B_axis_value > 0.1 or (L_axis_value > 0.1 or R_axis_value > 0.1) then
        dispatch_action(nil,74)
        
    else
        dispatch_action(nil,75)
    end
print_message_to_user(get_param_handle("BRAKE_FORCE"))		--used for debugging

end		
need_to_be_closed = false