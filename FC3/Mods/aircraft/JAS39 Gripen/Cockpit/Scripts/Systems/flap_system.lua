dofile(LockOn_Options.script_path.."command_defs.lua")

local update_time_step = 0.01 
make_default_activity(update_time_step)

local sensor_data = get_base_data()

local rate_met2knot = 0.539956803456
local ias_knots = 0 -- * rate_met2knot

local fmt = '%.2f'
local FLAPS_TARGET = 0

local DEGREE_TO_RAD  = 0.0174532925199433
local RAD_TO_DEGREE  = 57.29577951308233
local flap_system = GetSelf()
local AOA = 0

function post_initialize()
    local birth = LockOn_Options.init_conditions.birth_place
end

function getIASKnots()
    ias_knots = sensor_data.getIndicatedAirSpeed() * 3.6 * rate_met2knot
    WOW = sensor_data.getWOW_LeftMainLandingGear()
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
    --print_message_to_user(WOW)
    getIASKnots()
    -- if (ias_knots >= 190) then
    --     FLAPS_TARGET = 0
    --     dispatch_action(nil,Keys.PlaneFlapsOff)
    -- elseif (ias_knots <= 45) then
    --     FLAPS_TARGET = 0
    --     dispatch_action(nil,Keys.PlaneFlapsOff)
    -- elseif (ias_knots < 190 and ias_knots > 45) then
    --     FLAPS_TARGET = 1
    --     dispatch_action(nil,Keys.PlaneFlapsOn)
    -- end
end

need_to_be_closed = false