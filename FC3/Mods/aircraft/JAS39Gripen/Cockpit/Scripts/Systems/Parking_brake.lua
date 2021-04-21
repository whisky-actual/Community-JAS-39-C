dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")

local Parking_Brake = Keys.PlaneWheelBrakeOn --setting the iCommands from command defs 
local parking_brake_click =  device_commands.ParkingBrakeSwitch--Track mouse clicks

electric_system:listen_command(Parking_Brake)
electric_system:listen_command(parking_brake_click)