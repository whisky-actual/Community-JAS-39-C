dofile(LockOn_Options.script_path.."command_defs.lua")

local update_time_step = 0.01 
make_default_activity(update_time_step) 

-----------------------------------------------------------------
-- atterrizaje canards en modo depresión
-- si rpm < 70 

local sensor_data = get_base_data()

local rate_met2knot = 0.539956803456
local ias_knots = 0 -- * rate_met2knot

local fmt = '%.2f'
local FCS_TARGET = 0

local DEGREE_TO_RAD  = 0.0174532925199433
local RAD_TO_DEGREE  = 57.29577951308233
local fcs_system = GetSelf()
local AOA = 0



function post_initialize()
    local birth = LockOn_Options.init_conditions.birth_place
end

function getIASKnots()
    ias_knots = sensor_data.getIndicatedAirSpeed() * 3.6 * rate_met2knot
    WOW = sensor_data.getWOW_NoseLandingGear()
    RPM = sensor_data.getEngineLeftRPM()
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
    getIASKnots()
    if (RPM <= 75 ) and (ias_knots >= 15) and (ias_knots <= 140) and (WOW == 1) then
        if FCS_TARGET ~= 1 then
            FCS_TARGET = FCS_TARGET + 0.005
        end
        if FCS_TARGET >= 1 then
            FCS_TARGET = 1
			
        end
    else
        if FCS_TARGET ~= 0 then
            FCS_TARGET = FCS_TARGET - 0.005
        elseif FCS_TARGET <= 0  then
            FCS_TARGET = 0
        end
        if FCS_TARGET <= 0 then
            FCS_TARGET = 0
        end
    end
    --print_message_to_user(FCS_TARGET)

    set_aircraft_draw_argument_value(35,FCS_TARGET)
	
end

need_to_be_closed = false