local Breaks = GetSelf()
dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."Systems/electric_system_api.lua")

-- ATTENTION:  

local update_time_step = 0.02   
make_default_activity(update_time_step)

local sensor_data = get_base_data()

local fmt = '%.2f'

local air_brake_state
local air_brake_pos = 0
 
local drag_chute_target_state = 0  
local drag_chute_pos

local Airbrake  = 73  
local AirbrakeOn = 147
local AirbrakeOff = 148

local iCommandPlaneWheelBrakeOn = 74  
local iCommandPlaneWheelBrakeOff = 75

function post_initialize()
    air_brake_state = 0
    local birth = LockOn_Options.init_conditions.birth_place
end

 
Breaks:listen_command(Keys.BrakesOn)
Breaks:listen_command(Keys.BrakesOff)
 
Breaks:listen_command(Airbrake)
Breaks:listen_command(AirbrakeOn)
Breaks:listen_command(AirbrakeOff)
 
Breaks:listen_command(Keys.DragParachute)


function SetCommand(command,value)
    if (command == Keys.BrakesOn) then
        dispatch_action(nil,iCommandPlaneWheelBrakeOn)
    elseif (command == Keys.BrakesOff) then
        dispatch_action(nil,iCommandPlaneWheelBrakeOff)
    elseif (command == Airbrake) then
        if (air_brake_state == 0) then
            air_brake_state = 1
        elseif (air_brake_state == 1) then
            air_brake_state = 0
        end
    elseif (command == AirbrakeOn) then
        air_brake_state = 1
    elseif (command == AirbrakeOff) then
        air_brake_state = 0
    elseif (command == Keys.DragParachute) then
        drag_chute_target_state = 1 - drag_chute_target_state   
        drag_chute_pos = air_brake_pos
    end
end

function update()
    air_brake_pos = tonumber(string.format(fmt, air_brake_pos))
    if (drag_chute_target_state == 0) then
        if (air_brake_pos < air_brake_state) then
            air_brake_pos = air_brake_pos + 0.01
            set_aircraft_draw_argument_value(182, air_brake_pos)
        elseif (air_brake_pos > air_brake_state) then
            air_brake_pos = air_brake_pos - 0.01
            set_aircraft_draw_argument_value(182, air_brake_pos)
        elseif (air_brake_pos == air_brake_state) then
            set_aircraft_draw_argument_value(182, air_brake_pos)
        end
    elseif (drag_chute_target_state == 1) then
        if (drag_chute_pos < 0.9) then
            drag_chute_pos = drag_chute_pos + 0.01
            set_aircraft_draw_argument_value(21,1)
            set_aircraft_draw_argument_value(35, drag_chute_pos)
            if (drag_chute_pos <= 0.45) then
                air_brake_pos = drag_chute_pos
            end
        elseif (drag_chute_pos >= 0.9) then
            set_aircraft_draw_argument_value(35, drag_chute_pos)
        end
    end
	--print_message_to_user("BREAKPOS")
	--print_message_to_user(air_brake_pos)
	--print_message_to_user("BREAKTAR")
	--print_message_to_user(air_brake_state)
end

--不关闭该lua
need_to_be_closed = false
