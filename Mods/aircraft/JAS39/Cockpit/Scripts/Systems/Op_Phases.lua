-- The Operational phases:

-- Engine off				STATIONARY                             (1)
-- Engine start up			PARKED                                 (2)
-- Speed above 25 kts		TAXI                                   (3)
-- Speed above 40 kts		TGR			Take Off Ground Roll       (4)
-- Nose gear lift off		ROT			Rotate                     (5)
-- Main gear lift off		LO			Lift Off                   (6)
-- Gear up					CO			Combat                     (7)
-- Gear down				PAL (*)		Power Approach and Landing (8)
-- Main gear touch down		TD (*)		Touch Down                 (9)
-- Nose gear touch down		LR (*)		Landing Roll               (10)
-- Speed below 40 kts		TAXI                                   (3)
-- Speed below 25 kts		PARKED                                 (2)
-- Engine off				STATIONARY                             (1)

-- (*) requires Landing Mode enabled

local dev 	    = GetSelf()

dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")

local update_time_step = 0.01
make_default_activity(update_time_step)

local sensor_data = get_base_data()

local current_phase =               get_param_handle("CURRENT_PHASE")
local current_phase_STATIONARY = 	get_param_handle("CURRENT_PHASE_STATIONARY")
local current_phase_PARKED = 		get_param_handle("CURRENT_PHASE_PARKED")
local current_phase_TAXI = 			get_param_handle("CURRENT_PHASE_TAXI")
local current_phase_TGR = 			get_param_handle("CURRENT_PHASE_TGR")
local current_phase_ROT = 			get_param_handle("CURRENT_PHASE_ROT")
local current_phase_LO = 			get_param_handle("CURRENT_PHASE_LO")
local current_phase_CO = 			get_param_handle("CURRENT_PHASE_CO")
local current_phase_PAL = 			get_param_handle("CURRENT_PHASE_PAL")
local current_phase_TD = 			get_param_handle("CURRENT_PHASE_TD")
local current_phase_LR = 			get_param_handle("CURRENT_PHASE_LR")
local landing_mode = 				get_param_handle("LANDING_MODE")

current_phase:set(0)
current_phase_STATIONARY:set(0)
current_phase_PARKED:set(0)
current_phase_TAXI:set(0)
current_phase_TGR:set(0)
current_phase_ROT:set(0)		
current_phase_LO:set(0)
current_phase_CO:set(0)
current_phase_PAL:set(0)
current_phase_TD:set(0)	
landing_mode:set(0)

dev:listen_command(10060)														-- Listen for Landing mode
dev:listen_command(10066)

local ThrottlePct = 0
local PrevPhase = ""

function SetCommand(command,value)												-- Set Landing mode
    if command == 10060 then 
		if get_param_handle("LANDING_MODE"):get() == 0 then
			landing_mode:set(1.0)
		elseif get_param_handle("LANDING_MODE"):get() == 1 then
			landing_mode:set(0.0)
		end
	end

	if command == 10066 then
		ThrottlePct = 100 * (-value + 1) /2
		--print_message_to_user(ThrottlePct)
	end
end

local lastprint = 0
function PrintButBetter(input)

    if input ~= lastprint then
        print_message_to_user(input, 1)
    end

    lastprint = input
end

function debug_print(x)
	debug_status = 0																-- Display Operational Phase: 0 = Disable, 1 = Enable
	if debug_status == 1 then
		PrintButBetter(x)
	end 
end

function update()
	--local mach = sensor_data.getMachNumber()									-- Speed in MACH
	local self_vel_l,self_vel_v,self_vel_h = sensor_data.getSelfAirspeed()		-- Prereq for ground speed in kts
	local self_gs = math.sqrt(self_vel_h^2 + self_vel_l^2)*1.944 				-- Ground speed in kts
	local rpm = get_param_handle("RM12_RPM"):get()								-- Engine rpm
    local wow_n = sensor_data.getWOW_NoseLandingGear()							-- Nose gear weight on wheels 
	local wow_l = sensor_data.getWOW_LeftMainLandingGear()						-- Left main gear weight on wheels 
	local wow_r = sensor_data.getWOW_RightMainLandingGear()						-- Right main gear weight on wheels 
	local gear_n_up = sensor_data.getNoseLandingGearUp()						-- Nose gear up


-- ======================== Stationary =====================================		
	if (rpm < 60) and (self_gs <= 25) and (wow_n == 1) and (wow_l == 1) and (gear_n_up == 0) and (wow_r == 1) then		-- nytt	
		current_phase:set(1)			
		current_phase_STATIONARY:set(1.0)
		debug_print("Current operational phase: STATIONARY")
		PrevPhase = "STATIONARY"
	else
		current_phase_STATIONARY:set(0.0)
	end	

-- ======================== Parked =========================================			
	if (rpm >= 60) and (self_gs <= 25) and (wow_n == 1) and (wow_l == 1) and (gear_n_up == 0) and (wow_r == 1) then			-- nytt			
		current_phase:set(2)
		current_phase_PARKED:set(1.0)
		debug_print("Current operational phase: PARKED")
		PrevPhase = "PARKED"
	else
		current_phase_PARKED:set(0.0)
	end

-- ======================== Taxi ===========================================
	if ((self_gs > 25) and (self_gs <= 40) and (wow_n == 1) and (wow_l == 1) and (gear_n_up == 0) and (wow_r == 1)) 
		or ( (self_gs > 40) and (wow_n == 1) and (wow_l == 1) and (gear_n_up == 0) and (wow_r == 1) and (ThrottlePct <= 80) and (ThrottlePct > 40) ) then					
		current_phase:set(3)
		current_phase_TAXI:set(1.0)
		debug_print("Current operational phase: TAXI")
		PrevPhase = "TAXI"
	else
		current_phase_TAXI:set(0.0)
	end

-- ======================== Take off Ground Roll ===========================		
	if (self_gs > 40) and (wow_n == 1) and (wow_l == 1) and (wow_r == 1) and (gear_n_up == 0) and ThrottlePct > 80 then			
		current_phase:set(4)
		current_phase_TGR:set(1.0)
		debug_print("Current operational phase: TGR")
		PrevPhase = "TGR"
	else
		current_phase_TGR:set(0.0)
	end

-- ======================== Rotation =======================================	
	if (self_gs > 40) and (wow_n == 0) and (wow_r == 1) and (wow_l == 1) and (gear_n_up == 0) and ThrottlePct > 80 then			
		current_phase:set(5)
	current_phase_ROT:set(1.0)
		debug_print("Current operational phase: ROT")
		PrevPhase = "ROT"
	else
		current_phase_ROT:set(0.0)
	end

-- ======================== Lift Off =======================================	
	if (self_gs > 40) and (wow_n == 0) and (wow_l == 0) and (wow_r == 0) and (gear_n_up == 0) and ThrottlePct > 80 then			
		current_phase:set(6)
	current_phase_LO:set(1.0)
		debug_print("Current operational phase: LO")
		PrevPhase = "LO"
	else
		current_phase_LO:set(0.0)
	end

-- ======================== Combat =========================================	
	if (wow_n == 0) and (wow_l == 0) and (wow_r == 0) and (gear_n_up == 1) then			
		current_phase:set(7)
	current_phase_CO:set(1.0)
		debug_print("Current operational phase: CO")
		PrevPhase = "CO"
	else
		current_phase_CO:set(0.0)
	end

-- ======================== Powered Approach and Landing ===================	
	if (self_gs > 40) and (wow_n == 0) and (wow_l == 0) and (wow_r == 0) and (gear_n_up == 0) and ThrottlePct <= 80 then			
		current_phase:set(8)
	current_phase_PAL:set(1.0)
		debug_print("Current operational phase: PAL")
		PrevPhase = "PAL"
	else
		current_phase_PAL:set(0.0)
	end

-- ======================== Touch Down =====================================	
	if (self_gs > 40) and (wow_n == 0) and (wow_l == 1) and (wow_r == 1) and (gear_n_up == 0) and ThrottlePct <= 80 then			
		current_phase:set(9)
		current_phase_TD:set(1.0)
		debug_print("Current operational phase: TD")
		PrevPhase = "TD"
	else
		current_phase_TD:set(0.0)
	end

-- ======================== Landing Roll ===================================	
	if (self_gs > 10) and (wow_n == 1) and (wow_l == 1) and (wow_r == 1) and (gear_n_up == 0) and (ThrottlePct <= 40) and (PrevPhase == "TD" or PrevPhase == "TGR" or PrevPhase == "LR" or (PrevPhase == "TAXI" and current_phase_TAXI:get() == 0)) then			
		current_phase:set(10)
	current_phase_LR:set(1.0)
		debug_print("Current operational phase: LR")
		PrevPhase = "LR"
	else
		current_phase_LR:set(0.0)
	end

-- ======================== Landing Mode ===================================
	if get_param_handle("LANDING_MODE"):get() == 1 and get_param_handle("CURRENT_PHASE_LR"):get() == 1 then
		landing_mode:set(0)
	end
end

need_to_be_closed = false
