-- The Operational phases:

-- Engine off				STATIONARY
-- Engine start up			PARKED
-- Speed above 27 kts		TAXI
-- Speed above 39 kts		TGR			Take Off Ground Roll
-- Nose gear lift off		ROT			Rotate
-- Main gear lift off		LO			Lift Off
-- Gear up					CO			Combat
-- Gear down				PAL (*)		Power Approach and Landing
-- Main gear touch down		TD (*)		Touch Down
-- Nose gear touch down		LR (*)		Landing Roll
-- Speed below 39 kts		TAXI
-- Speed below 27 kts		PARKED
-- Engine off				STATIONARY

-- (*) requires Landing Mode enabled

local dev 	    = GetSelf()

dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")

local update_time_step = 0.01
make_default_activity(update_time_step)

local sensor_data = get_base_data()

local current_phase_STATIONARY = get_param_handle("CURRENT_PHASE_STATIONARY")
local current_phase_PARKED = get_param_handle("CURRENT_PHASE_PARKED")
local current_phase_TAXI = get_param_handle("CURRENT_PHASE_TAXI")
local current_phase_TGR = get_param_handle("CURRENT_PHASE_TGR")
local current_phase_ROT = get_param_handle("CURRENT_PHASE_ROT")
local current_phase_LO = get_param_handle("CURRENT_PHASE_LO")
local current_phase_CO = get_param_handle("CURRENT_PHASE_CO")
local current_phase_PAL = get_param_handle("CURRENT_PHASE_PAL")
local current_phase_TD = get_param_handle("CURRENT_PHASE_TD")
local current_phase_LR = get_param_handle("CURRENT_PHASE_LR")
local landing_mode = get_param_handle("LANDING_MODE")

current_phase_STATIONARY:set(0.0)
current_phase_PARKED:set(0.0)
current_phase_TAXI:set(0.0)
current_phase_TGR:set(0.0)
current_phase_ROT:set(0.0)		
current_phase_LO:set(0.0)
current_phase_CO:set(0.0)
current_phase_PAL:set(0.0)
current_phase_TD:set(0.0)	
landing_mode:set(0.0)

dev:listen_command(10060)														-- Listen for Landing mode

function SetCommand(command,value)												-- Set Landing mode
    if command == 10060 then 
		if get_param_handle("LANDING_MODE"):get() == 0 then
		landing_mode:set(1.0)
--		print_message_to_user("LANDING MODE: ENABLED")
		elseif get_param_handle("LANDING_MODE"):get() == 1 then
		landing_mode:set(0.0)
--		print_message_to_user("LANDING MODE: DISABLED")
		end
	end
end

function debug_print(x)
debug_status = 0																-- Display Operational Phase: 0 = Disable, 1 = Enable
	if debug_status == 1 then
	print_message_to_user(x)
	end 
end

function update()
	--local mach = sensor_data.getMachNumber()									-- Speed in MACH
	local self_vel_l,self_vel_v,self_vel_h = sensor_data.getSelfAirspeed()		-- Prereq for ground speed in kts
	local self_gs = math.sqrt(self_vel_h^2 + self_vel_l^2)*1.944 				-- Ground speed in kts
	local rpm = sensor_data.getEngineLeftRPM()									-- Engine rpm
    local wow_n = sensor_data.getWOW_NoseLandingGear()							-- Nose gear weight on wheels 
	local wow_l = sensor_data.getWOW_LeftMainLandingGear()						-- Left main gear weight on wheels 
	local wow_r = sensor_data.getWOW_RightMainLandingGear()						-- Right main gear weight on wheels 
	--local gear_handle_pos = sensor_data.getLandingGearHandlePos()				-- Gear handle position
	local gear_n_up = sensor_data.getNoseLandingGearUp()						-- Nose gear up
	--local gear_n_down = sensor_data.getNoseLandingGearDown()					-- Nose gear down
	--local gear_l_up = sensor_data.getLeftMainLandingGearUp()					-- Main gear left up
	--local gear_l_down = sensor_data.getLeftMainLandingGearDown()				-- Main gear left down
	--local gear_r_up = sensor_data.getRightMainLandingGearUp()					-- Main gear right up
	--local gear_l_down = sensor_data.getRightMainLandingGearDown()				-- Main gear right down
	--local vertical_vel = sensor_data.getVerticalVelocity()						-- Vertical velocity in m/s

-- ======================== Stationary =====================================		
	if (rpm < 60) and (self_gs <= 27) and (wow_n == 1) and (wow_l == 1) and (gear_n_up == 0) and (wow_r == 1) then		-- nytt				
	current_phase_STATIONARY:set(1.0)
		debug_print("Current operational phase: STATIONARY")
	else
	current_phase_STATIONARY:set(0.0)
	end	

-- ======================== Parked =========================================			
	if (rpm >= 60) and (self_gs <= 27) and (wow_n == 1) and (wow_l == 1) and (gear_n_up == 0) and (wow_r == 1) then			-- nytt			
	current_phase_PARKED:set(1.0)
		debug_print("Current operational phase: PARKED")
	else
	current_phase_PARKED:set(0.0)
	end

-- ======================== Taxi ===========================================
	if (self_gs > 27) and (self_gs <= 39) and (wow_n == 1) and (wow_l == 1) and (gear_n_up == 0) and (wow_r == 1) then					
	current_phase_TAXI:set(1.0)
		debug_print("Current operational phase: TAXI")
	else
	current_phase_TAXI:set(0.0)
	end

-- ======================== Take off Ground Roll ===========================		
	if (self_gs > 39) and (wow_n == 1) and (wow_l == 1) and (wow_r == 1) and (gear_n_up == 0) and (get_param_handle("LANDING_MODE"):get() == 0) then			
	current_phase_TGR:set(1.0)
		debug_print("Current operational phase: TGR")	
	else
	current_phase_TGR:set(0.0)
	end

-- ======================== Rotation =======================================	
	if (self_gs > 39) and (wow_n == 0) and (wow_r == 1) and (wow_l == 1) and (gear_n_up == 0) and (get_param_handle("LANDING_MODE"):get() == 0) then			
	current_phase_ROT:set(1.0)
		debug_print("Current operational phase: ROT")
	else
	current_phase_ROT:set(0.0)
	end

-- ======================== Lift Off =======================================	
	if (self_gs > 39) and (wow_n == 0) and (wow_l == 0) and (wow_r == 0) and (gear_n_up == 0) and (get_param_handle("LANDING_MODE"):get() == 0) then			
	current_phase_LO:set(1.0)
		debug_print("Current operational phase: LO")
	else
	current_phase_LO:set(0.0)
	end

-- ======================== Combat =========================================	
	if (wow_n == 0) and (wow_l == 0) and (wow_r == 0) and (gear_n_up == 1) and (get_param_handle("LANDING_MODE"):get() < 2) then			
	current_phase_CO:set(1.0)
		debug_print("Current operational phase: CO")
	else
	current_phase_CO:set(0.0)
	end

-- ======================== Powered Approach and Landing ===================	
	if (self_gs > 39) and (wow_n == 0) and (wow_l == 0) and (wow_r == 0) and (gear_n_up == 0) and (get_param_handle("LANDING_MODE"):get() == 1) then			
	current_phase_PAL:set(1.0)
		debug_print("Current operational phase: PAL")
	else
	current_phase_PAL:set(0.0)
	end

-- ======================== Touch Down =====================================	
	if (self_gs > 39) and (wow_n == 0) and (wow_l == 1) and (wow_r == 1) and (gear_n_up == 0) and (get_param_handle("LANDING_MODE"):get() == 1) then			
	current_phase_TD:set(1.0)
		debug_print("Current operational phase: TD")
	else
	current_phase_TD:set(0.0)
	end

-- ======================== Landing Roll ===================================	
	if (self_gs > 39) and (wow_n == 1) and (wow_l == 1) and (wow_r == 1) and (gear_n_up == 0) and (get_param_handle("LANDING_MODE"):get() == 1) then			
	current_phase_LR:set(1.0)
		debug_print("Current operational phase: LR")
	else
	current_phase_LR:set(0.0)
	end

end

need_to_be_closed = false
