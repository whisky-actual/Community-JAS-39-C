dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."utils.lua")
local update_time_step = 0.01 
make_default_activity(update_time_step)
local Canard_system = GetSelf()
local sensor_data = get_base_data()

local rate_met2knot = 0.539956803456
local ias_knots = 0
CANARDS_STATE = 0 
CANARDS_TARGET = 0
local RAD_TO_DEGREE  = 57.29577951308233
local AOA = 0
local FLAPS_STATE = 0
local G_LOADING = 0
local PITCH_COEFF = 0
local FLAPS_DOWN = 0
local Diff1 = 0
local Diff2 = 0
local CanardsTimeSec = 1.34
local CanardsIncrement = update_time_step / CanardsTimeSec
local CorrTimeSec = 0.33
local CorrIncrement = update_time_step / CorrTimeSec
local CORR_TARGET = 1
local CORR_STATE = 0
local PITCH_CORRECTED = 0
local STICK_PITCH = 0
local TRIM_STATE = 0
local TRIM_TARGET_DOWN = 1
local TRIM_TARGET_UP = 0
local TrimTimeSec = 3
local TrimIncrement = update_time_step / TrimTimeSec
local TRIMMED = false
local DUMPINGLIFT = 0
local PITCH_TARGET = 0

--Canard_system:listen_command(10061)--Pitch axis


function Sensor_data()
	ias_knots = sensor_data.getIndicatedAirSpeed() * 3.6 * rate_met2knot
    AOA = sensor_data.getAngleOfAttack() * RAD_TO_DEGREE		-- Angle of attack converted from radians to degrees
	FLAPS_STATE = sensor_data.getFlapsPos()
	G_LOADING = sensor_data.getVerticalAcceleration()
	PITCH_COEFF = sensor_data.getRateOfPitch() / (ias_knots / 280) 
	STICK_PITCH = get_param_handle("CURRENT_PITCH_OUTPUT"):get() --PITCH_TARGET --sensor_data.getStickRollPosition()			-- Actually pitch input, dcs has it backwards
end

function Pitch_input()
	CANARDS_TARGET = STICK_PITCH * 0.5
end

function update()
	Sensor_data()
-- beginning of phases
-- ======================== Stationary =============================	
	if get_param_handle("CURRENT_PHASE_STATIONARY"):get() > 0.0 then
		CANARDS_TARGET = 0
		
-- ========================= Parked ================================
	elseif get_param_handle("CURRENT_PHASE_PARKED"):get() > 0.0 then 
		CANARDS_TARGET = 0
		if get_param_handle("BRAKE_FORCE"):get() > 0.0 then
			CANARDS_TARGET = 0
		else 
			Pitch_input()
		end
	DUMPINGLIFT = 0	
--========================= Taxi ================================

	elseif get_param_handle("CURRENT_PHASE_TAXI"):get()> 0.0 then
		if get_param_handle("BRAKE_FORCE"):get() > 0.0 then
			if DUMPINGLIFT == 1 then 
				CANARDS_TARGET = get_param_handle("BRAKE_FORCE"):get() * -0.47272
			elseif DUMPINGLIFT == 0 then
				CANARDS_TARGET = 0		
			end
		else 
			Pitch_input()
		end
-- ============= Take off ground roll ===========================
	elseif get_param_handle("CURRENT_PHASE_TGR"):get() > 0.0 then									-- pitch up on takeoff
		Pitch_input()
		
-- ================= Rotation ===================================		
	elseif get_param_handle("CURRENT_PHASE_ROT"):get() > 0.0 then
		Pitch_input()
		
-- ================== Lift off ================================
	elseif get_param_handle("CURRENT_PHASE_LO"):get() > 0.0 then
			CANARDS_TARGET = AOA/-115
		
--======================= Combat ===============================
	elseif get_param_handle("CURRENT_PHASE_CO"):get() > 0.0 then			
		-- AOA-dependent movement, makes the canards follow the aircrafts path of motion	
		if (AOA >=25) then									
			CANARDS_TARGET = -0.5 
		elseif (AOA > 0) and (AOA < 25) then
			CANARDS_TARGET = AOA/-60
		elseif (AOA < 0) and (AOA > -25) then
			CANARDS_TARGET = AOA/-30
		end
		
		-- Turn rate and joystick-input-dependent movement, counteracts the AOA-dependent movement when turning/pitching. Initially adds pitch up anim. when pitching
		if (PITCH_COEFF >= 0.025) then						
			CANARDS_TARGET = CANARDS_TARGET + PITCH_COEFF + (STICK_PITCH * 0.15)
		elseif (PITCH_COEFF <= (-0.025)) then
			CANARDS_TARGET = CANARDS_TARGET + PITCH_COEFF + (STICK_PITCH * 0.15)
		end
		
		if (CANARDS_STATE < 0.1) and (CANARDS_TARGET < 0.1) and (STICK_PITCH < 0.16) then
			CORR_STATE = 0
			PITCH_CORRECTED = 0
		end

		if (PITCH_CORRECTED == 0) and (CORR_STATE < CORR_TARGET) and (CANARDS_STATE > 0.075) then
			CORR_STATE = CORR_STATE + CorrIncrement
		elseif (CORR_STATE >= CORR_TARGET) then
			PITCH_CORRECTED = 1
		end
		
		if (PITCH_CORRECTED == 1) then
			CANARDS_TARGET = AOA/-95  + (PITCH_COEFF * 0.3)
			
		end
		--print_message_to_user(PITCH_CORRECTED)
	


	--print_message_to_user(CANARDS_STATE)
	
--===================== Powered Approach And Landing ============

	elseif get_param_handle("CURRENT_PHASE_PAL"):get() > 0.0 then
	
		CANARDS_TARGET = 0.40 + (STICK_PITCH * 0.2)
		
-- ===================== Touch Down =============================		
	elseif get_param_handle("CURRENT_PHASE_TD"):get() > 0.0 then
		if (PITCH_COEFF <= 0) then						-- pitch down on landing, before lift dump animation takes over
			CANARDS_TARGET = 0
		end
		
		if (TRIM_STATE < TRIM_TARGET_DOWN) then
			TRIM_STATE = TRIM_STATE + TrimIncrement
			dispatch_action(nil,96)				 --Trim down
			TRIMMED = true						 --declares aircraft is trimmed
			--print_message_to_user("Trim down")
		end
	
--======================= Landing Roll ==============================

	elseif get_param_handle("CURRENT_PHASE_LR"):get() > 0.0 then
		if get_param_handle("BRAKE_FORCE"):get() > 0.0 then
			CANARDS_TARGET = get_param_handle("BRAKE_FORCE"):get() * -0.47272
			DUMPINGLIFT = 1
		elseif get_param_handle("BRAKE_FORCE"):get() <= 0.0 then
			CANARDS_TARGET = 0
			DUMPINGLIFT = 0
		end
		
		if (TRIMMED == true) then							-- two instances of trim seems to be required to begin trimming while on the ground
			dispatch_action(nil,97)							-- trims once then makes itself not run again
			TRIMMED = false
			--print_message_to_user("Trim once")
		end
		
		if (TRIM_STATE > TRIM_TARGET_UP) then				
			TRIM_STATE = TRIM_STATE - TrimIncrement
			dispatch_action(nil,95)							--Trim up
			--print_message_to_user("Trim up")
		end
	end	
-- end of phases

--===================== Actuation of canards ==========================

	CANARDS_STATE = MoveControlSurface(CANARDS_STATE, CANARDS_TARGET, CanardsIncrement)

	
	if (TRIM_STATE > 1 ) then		-- makes sure TRIM_STATE won't go above 1 or below 0
		TRIM_STATE = 1
	elseif (TRIM_STATE < 0 ) then
		TRIM_STATE = 0
	end	
--Sets (argument,value)	
		--used for debugging
set_aircraft_draw_argument_value(10,CANARDS_STATE)					-- Left Canard		
set_aircraft_draw_argument_value(9,CANARDS_STATE)					-- Right Canard		
end

need_to_be_closed = 0