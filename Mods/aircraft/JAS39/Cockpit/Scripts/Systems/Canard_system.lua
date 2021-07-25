dofile(LockOn_Options.script_path.."command_defs.lua")

local update_time_step = 0.01 
make_default_activity(update_time_step)

local sensor_data = get_base_data()
local rate_met2knot = 0.539956803456
local ias_knots = 0 
local fmt = '%.2f'
local CANARDS_STATE = 0 --*
local CANARDS_TARGET = 0
local DEGREE_TO_RAD  = 0.0174532925199433
local RAD_TO_DEGREE  = 57.29577951308233
local Canard_system = GetSelf()
local AOA = 0
local FLAPS_STATE = 0
local FLAPS_X = 1
local WOW = 0

function post_initialize()
    local birth = LockOn_Options.init_conditions.birth_place
end

function get_canard_data()
    ias_knots = sensor_data.getIndicatedAirSpeed() * 3.6 * rate_met2knot
	WOW = sensor_data.getWOW_NoseLandingGear()
    AOA =(sensor_data.getAngleOfAttack() * RAD_TO_DEGREE)
	FLAPS_STATE = sensor_data.getFlapsPos()
end

function Canard_pitch()
	if (AOA >=26) then
	CANARDS_TARGET = -1 
	
	elseif (AOA < 26) then
	CANARDS_TARGET = AOA/-26
	end
	if (FLAPS_STATE > 0) then
		Powered_Approach_mode()
    end
	
end

function Powered_Approach_mode()

	FLAPS_X = (FLAPS_STATE + 1) 
end

function update()
    get_canard_data()
	--print_message_to_user(FLAPS_STATE)
	if (WOW < 1) then
		Canard_pitch()	
	else 
	CANARDS_TARGET = 0
	end
	
	
   set_aircraft_draw_argument_value(91,CANARDS_TARGET / FLAPS_X)

end

need_to_be_closed = false