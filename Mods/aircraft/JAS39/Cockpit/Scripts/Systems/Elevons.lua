dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."utils.lua")
local update_time_step = 0.01 
make_default_activity(update_time_step)
local Elevons = GetSelf()
local sensor_data = get_base_data()

-- ===== Local variables =====
local INNER_L_STATE = 0 
local INNER_L_TARGET = 0
local INNER_R_STATE = 0 
local INNER_R_TARGET = 0
local OUTER_L_STATE = 0 
local OUTER_L_TARGET = 0
local OUTER_R_STATE = 0 
local OUTER_R_TARGET = 0

local AirSpeedCoeff = 1
local rate_met2knot = 0.539956803456
local ELEVONTimeSec = 1.071 -- Time it takes for elevons to go from -1 to 1
local ELEVONIncrement = update_time_step / ELEVONTimeSec
local STICK_ROLL = 0
local STICK_PITCH = 0
local arg15 = 0
local arg16 = 0
local DUMPINGLIFT = 0

local PITCH_OUTPUT = get_param_handle("CURRENT_PITCH_OUTPUT"):get()	--output from flybywire.lua
local ROLL_OUTPUT = get_param_handle("CURRENT_ROLL_OUTPUT"):get()	--output from flybywire.lua


function Sensor_data() 
	--local turn_rate = sensor_data.getRateOfPitch() * 57.2957795
	arg15 = get_aircraft_draw_argument_value(15)	-- Right elevon standard argument. used by Ai
	arg16 = get_aircraft_draw_argument_value(16)	-- Left elevon standard argument. used by Ai
	STICK_PITCH = -get_param_handle("CURRENT_PITCH_OUTPUT"):get() * 0.1
	STICK_ROLL = -get_param_handle("CURRENT_ROLL_OUTPUT"):get() * 0.35
	IAS_knots = sensor_data.getIndicatedAirSpeed() * 3.6 * rate_met2knot	--Indicated airspeed converted into knots
	--print_message_to_user(turn_rate)
end

function IAS_coeff() -- Gives full actuation at speeds below 280 kias (output is limited below), actuation decreases with higher speed
	AirSpeedCoeff = (IAS_knots / 280)
	
	INNER_L_TARGET = INNER_L_TARGET / AirSpeedCoeff 
	INNER_R_TARGET = INNER_R_TARGET	/ AirSpeedCoeff 
	OUTER_L_TARGET = OUTER_L_TARGET	/ AirSpeedCoeff 
	OUTER_R_TARGET = OUTER_R_TARGET	/ AirSpeedCoeff
end

function Joystick_movement()						-- Moves elevons after pitch and roll joystick output from flybywire.lua
	INNER_L_TARGET = (-STICK_ROLL * 0.5 + STICK_PITCH)	+ (sensor_data.getAngleOfAttack() * 0.39)
	INNER_R_TARGET = (STICK_ROLL * 0.5 + STICK_PITCH)	+ (sensor_data.getAngleOfAttack() * 0.39)
	OUTER_L_TARGET = (-STICK_ROLL + STICK_PITCH)		+ (sensor_data.getAngleOfAttack() * 0.39)
	OUTER_R_TARGET = (STICK_ROLL + STICK_PITCH)			+ (sensor_data.getAngleOfAttack() * 0.39)
end

function update()
Sensor_data()

-- beginning of phases
-- ======================== Stationary =============================		-- Inner elenovs pointing down
	if get_param_handle("CURRENT_PHASE_STATIONARY"):get() > 0.0 then
		INNER_L_TARGET = 1
		INNER_R_TARGET = 1
		
-- ========================= Parked ================================		 -- Moves elevons after pitch and roll input
	elseif get_param_handle("CURRENT_PHASE_PARKED"):get() > 0.0 then 
		Joystick_movement()
		DUMPINGLIFT = 0
--========================= Taxi ================================
	elseif get_param_handle("CURRENT_PHASE_TAXI"):get() > 0.0 then			-- Moves elevons after pitch and roll input OR lift dump animation
		if get_param_handle("BRAKE_FORCE"):get() > 0.0 then
			if DUMPINGLIFT == 1 then 
				-- Move inner elevons by braking force
				INNER_L_TARGET = get_param_handle("BRAKE_FORCE"):get() / -1
				INNER_R_TARGET = get_param_handle("BRAKE_FORCE"):get() / -1
				OUTER_R_TARGET = 0
				OUTER_L_TARGET = 0
				-- cancel out standard args here instead of further down. Since Argument 15 and 16 move with pitch command value
				arg15 = 0
				arg16 = 0
				set_aircraft_draw_argument_value(16,0)
				set_aircraft_draw_argument_value(15,0)
			else
				Joystick_movement()
			end
		end
-- ============= Take off ground roll ===========================
	elseif get_param_handle("CURRENT_PHASE_TGR"):get() > 0.0 then									
		Joystick_movement()
		
-- ========================= Rotation ===========================	
	elseif get_param_handle("CURRENT_PHASE_ROT"):get() > 0.0 then
		Joystick_movement()
		
-- ================== Lift off ================================
	elseif get_param_handle("CURRENT_PHASE_LO"):get() > 0.0 then
		Joystick_movement()
		
-- ======================= Combat ==============================
	elseif get_param_handle("CURRENT_PHASE_CO"):get() > 0.0 then			
		Joystick_movement()
		IAS_coeff()
--================ Powered Approach And Landing =================
	elseif get_param_handle("CURRENT_PHASE_PAL"):get() > 0.0 then
		Joystick_movement()

--===================== Touch Down =============================		
	elseif get_param_handle("CURRENT_PHASE_TD"):get() > 0.0 then
		Joystick_movement()
--======================= Landing Roll =========================
	elseif get_param_handle("CURRENT_PHASE_LR"):get() > 0.0 then
		if get_param_handle("BRAKE_FORCE"):get() > 0.0 then
			INNER_L_TARGET = get_param_handle("BRAKE_FORCE"):get() * -1
			INNER_R_TARGET = get_param_handle("BRAKE_FORCE"):get() * -1
			OUTER_R_TARGET = 0
			OUTER_L_TARGET = 0
			DUMPINGLIFT = 1
			arg15 = 0
			arg16 = 0
			set_aircraft_draw_argument_value(16,0)
			set_aircraft_draw_argument_value(15,0)
		else 
			Joystick_movement()
			DUMPINGLIFT = 0
		end
	end	
-- end of phases
--===================== Animations ==============================================================================

	OUTER_R_STATE = MoveControlSurface(OUTER_R_STATE, OUTER_R_TARGET, ELEVONIncrement)
	OUTER_L_STATE = MoveControlSurface(OUTER_L_STATE, OUTER_L_TARGET, ELEVONIncrement)
	INNER_R_STATE = MoveControlSurface(INNER_R_STATE, INNER_R_TARGET, ELEVONIncrement)
	INNER_L_STATE = MoveControlSurface(INNER_L_STATE, INNER_L_TARGET, ELEVONIncrement)

	set_aircraft_draw_argument_value(487,OUTER_R_STATE + arg15)
	set_aircraft_draw_argument_value(484,OUTER_L_STATE + arg16)
	set_aircraft_draw_argument_value(486,INNER_R_STATE + arg15)
	set_aircraft_draw_argument_value(485,INNER_L_STATE + arg16)
end

need_to_be_closed = 0
