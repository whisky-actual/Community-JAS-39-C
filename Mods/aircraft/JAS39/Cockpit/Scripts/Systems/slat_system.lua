dofile(LockOn_Options.script_path.."command_defs.lua")

local update_time_step = 0.01 
make_default_activity(update_time_step)

local sensor_data = get_base_data()

local rate_met2knot = 0.539956803456
local ias_knots = 0 -- * rate_met2knot

local fmt = '%.2f'

local slat_pos
local SLATS_STATE = 0
local SLATS_TARGET = 0

local DEGREE_TO_RAD  = 0.0174532925199433
local RAD_TO_DEGREE  = 57.29577951308233
local slat_system = GetSelf()
local AOA = 0
function post_initialize()
    local birth = LockOn_Options.init_conditions.birth_place
end

function getIASKnots()
    ias_knots = sensor_data.getIndicatedAirSpeed() * 3.6 * rate_met2knot
    --print_message_to_user("ISA:")
    --print_message_to_user(ias_knots)
    --print_message_to_user("SLAT_POS:")
    AOA =(sensor_data.getAngleOfAttack() * RAD_TO_DEGREE)
    -- SLATS_STATE = tonumber(string.format(fmt,AOA))
    -- print_message_to_user(SLATS_STATE)
end

function SetCommand(command,value)
end

function update()
    getIASKnots()--si el AOA es menor que 2, slats = 0; si slats < 8 pon AOA/8 si AOA > 8 slats =1 si IAS <115 slat slat_system = 0
    if (AOA >= 18) then
        SLATS_TARGET = 1
    elseif (AOA < 18) then
        SLATS_TARGET= AOA/18
    end
    -- print_message_to_user(AOA)
    set_aircraft_draw_argument_value(13,SLATS_TARGET)
    set_aircraft_draw_argument_value(14,SLATS_TARGET)
end

need_to_be_closed = false