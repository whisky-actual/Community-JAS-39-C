local dev = GetSelf()

dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")

local update_time_step = 0.01 
make_default_activity(update_time_step)

local sensor_data = get_base_data()

function post_initialize()
local birth = LockOn_Options.init_conditions.birth_place
	if birth=="GROUND_HOT" or birth=="GROUND_COLD" then
	LANDING_GEAR_STATE = 1														-- Landing gear states: 0 = up, 1 = down	
	LANDING_GEAR_TARGET = 1
	dev:performClickableAction(device_commands.LandingGearLever, 0, true)	
	elseif birth=="AIR_HOT" then
	LANDING_GEAR_STATE = 0
	LANDING_GEAR_TARGET = 0	
	dev:performClickableAction(device_commands.LandingGearLever, 1, true)	
	end
end	

local GEAR_BAY_STATE = 0
local GEAR_BAY_TARGET_OPEN = 1	
local GEAR_BAY_TARGET_CLOSE = 0

local BayDoorOpenCloseTimeSec = 3
local BayDoorOpenCloseIncrement = update_time_step / BayDoorOpenCloseTimeSec

local WHEEL_DAMAGE_STATE_NOSE_WHEEL = 0
local WHEEL_DAMAGE_STATE_MAIN_WHEELS = 0

local LANDING_GEAR_UP = 0
local LANDING_GEAR_DOWN = 1

local GearOpenTimeSec = 8														-- Landing gear speed = Extend: 8 seconds, Retract: 13 seconds
local GearOpenIncrement = update_time_step / GearOpenTimeSec
local GearCloseTimeSec = 13
local GearCloseIncrement = update_time_step / GearCloseTimeSec

dev:listen_event("WeaponRearmSingleStepComplete")

dev:listen_command(Keys.GearUp) 												-- Gear up
dev:listen_command(Keys.GearDown) 												-- Gear down
dev:listen_command(device_commands.LandingGearLever)							-- 1 = Landing gear up, 0 = Landing gear down


function SetCommand(command,value)												-- Listen for landing gear commands									
    if command == Keys.GearUp then 
		dev:performClickableAction(device_commands.LandingGearLever, 1, true)		
		LANDING_GEAR_TARGET = 0
	end
	
	if command == Keys.GearDown then
		dev:performClickableAction(device_commands.LandingGearLever, 0, true)		
		LANDING_GEAR_TARGET = 1
	end

    if command == device_commands.LandingGearLever then 
		if value == 1 then
			dev:performClickableAction(device_commands.LandingGearLever, 1, true)		
			LANDING_GEAR_TARGET = 0
		end
	end
	
	if command == device_commands.LandingGearLever then 
		if value == 0 then
			dev:performClickableAction(device_commands.LandingGearLever, 0, true)				
			LANDING_GEAR_TARGET = 1
		end
	end

end

function CockpitEvent(event, val)												-- Function for repairing the wheels
    if event == "WeaponRearmSingleStepComplete" then
        WHEEL_DAMAGE_STATE_NOSE_WHEEL = 0
		WHEEL_DAMAGE_STATE_MAIN_WHEELS = 0
	end
end

function debug_print(x)
debug_status = 0																-- Display Operational Phase: 0 = Disable, 1 = Enable
	if debug_status == 1 then
		print_message_to_user(x)
	end 
end

local gear_nose_light = get_param_handle("GEAR_NOSE_LIGHT")
local gear_left_light = get_param_handle("GEAR_LEFT_LIGHT")
local gear_right_light = get_param_handle("GEAR_RIGHT_LIGHT")
	
function landing_gear_lights()
	local gear_n_up = sensor_data.getNoseLandingGearUp()						-- Nose gear up
	local gear_n_down = sensor_data.getNoseLandingGearDown()					-- Nose gear down
	local gear_l_up = sensor_data.getLeftMainLandingGearUp()					-- Main gear left up
	local gear_l_down = sensor_data.getLeftMainLandingGearDown()				-- Main gear left down
	local gear_r_up = sensor_data.getRightMainLandingGearUp()					-- Main gear right up
	local gear_r_down = sensor_data.getRightMainLandingGearDown()				-- Main gear right down

	if get_param_handle("MAINPOWER"):get() == 1 then
		if gear_n_down == 1 then 
			gear_nose_light:set(0)
		elseif gear_n_down == 0 then
			gear_nose_light:set(1)
		end
		
		if gear_l_down == 1 then
			gear_left_light:set(0)
		elseif gear_l_down == 0 then
			gear_left_light:set(1)
		end
		
		if gear_r_down == 1 then
			gear_right_light:set(0)	
		elseif gear_r_down == 0 then
			gear_right_light:set(1)			
		end
		
	elseif get_param_handle("MAINPOWER"):get() == 0 then
		gear_nose_light:set(1)	
		gear_left_light:set(1)	
		gear_right_light:set(1)							
	end	

end

function update()		
    local WOW = sensor_data.getWOW_LeftMainLandingGear()						-- Main gear left weight on wheel
	local mach = sensor_data.getMachNumber()									-- Speed in MACH
	local self_vel_l,self_vel_v,self_vel_h = sensor_data.getSelfAirspeed()		-- Prereq for ground speed in kts
	self_gs = math.sqrt(self_vel_h^2 + self_vel_l^2)*1.944 						-- Ground speed in kts
	local rpm = sensor_data.getEngineLeftRPM()									-- Engine rpm
    local wow_n = sensor_data.getWOW_NoseLandingGear()							-- Nose gear weight on wheels 
	local wow_l = sensor_data.getWOW_LeftMainLandingGear()						-- Left main gear weight on wheels 
	local wow_r = sensor_data.getWOW_RightMainLandingGear()						-- Right main gear weight on wheels 
	local gear_handle_pos = sensor_data.getLandingGearHandlePos()				-- Gear handle position
	local vertical_vel = sensor_data.getVerticalVelocity()						-- Vertical velocity in m/s	
	local tas = sensor_data.getTrueAirSpeed()*1.944								-- TAS in kts
	local ias = sensor_data.getIndicatedAirSpeed()*1.944						-- IAS in kts	

	landing_gear_lights()
				
-- <<<<<<<<<<<<<<<<<<<<<<<< GEAR BAY DOORS >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

-- ======================== Stationary =====================================
	if get_param_handle("CURRENT_PHASE_STATIONARY"):get() > 0.0 then						
		if GEAR_BAY_STATE < GEAR_BAY_TARGET_OPEN then
			GEAR_BAY_STATE = GEAR_BAY_STATE + BayDoorOpenCloseIncrement
		end

-- ======================== Parked =========================================	
	elseif get_param_handle("CURRENT_PHASE_PARKED"):get() > 0.0 and (self_gs > 11) then		
		if GEAR_BAY_STATE > GEAR_BAY_TARGET_CLOSE then
			GEAR_BAY_STATE = GEAR_BAY_STATE - BayDoorOpenCloseIncrement
		end

-- ======================== Taxi ===========================================	
	elseif get_param_handle("CURRENT_PHASE_TAXI"):get() > 0.0 and (self_gs > 11) then
		if GEAR_BAY_STATE > GEAR_BAY_TARGET_CLOSE then
			GEAR_BAY_STATE = GEAR_BAY_STATE - BayDoorOpenCloseIncrement
		end

-- ======================== Take off Ground Roll ===========================		
	elseif get_param_handle("CURRENT_PHASE_TGR"):get() > 0.0 and (self_gs > 11) then
		if GEAR_BAY_STATE > GEAR_BAY_TARGET_CLOSE then
			GEAR_BAY_STATE = GEAR_BAY_STATE - BayDoorOpenCloseIncrement
		end

-- ======================== Rotation =======================================
	elseif get_param_handle("CURRENT_PHASE_ROT"):get() > 0.0 and (self_gs > 11) then
    	if GEAR_BAY_STATE > GEAR_BAY_TARGET_CLOSE then
			GEAR_BAY_STATE = GEAR_BAY_STATE - BayDoorOpenCloseIncrement
    	end

-- ======================== Lift Off =======================================
    elseif get_param_handle("CURRENT_PHASE_LO"):get() > 0.0 then							
		GEAR_BAY_STATE = -1			

-- ======================== Combat =========================================
    elseif get_param_handle("CURRENT_PHASE_CO"):get() > 0.0 then							
		GEAR_BAY_STATE = -1	

-- ======================== Powered Approach and Landing ===================
	elseif get_param_handle("CURRENT_PHASE_PAL"):get() > 0.0 then							
		GEAR_BAY_STATE = -1	
	
	end
	
    if GEAR_BAY_TARGET_CLOSE < 0 then
        GEAR_BAY_TARGET_CLOSE = 0
    elseif GEAR_BAY_TARGET_OPEN > 1 then
        GEAR_BAY_TARGET_OPEN = 1
    end

	set_aircraft_draw_argument_value(498,GEAR_BAY_STATE)

-- <<<<<<<<<<<<<<<<<<<<<<<<  TIRE DAMAGE >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

-- ======================== Stationary =====================================


-- ======================== Parked =========================================		


-- ======================== Taxi ===========================================		


-- ======================== Take off Ground Roll ===========================			
	if get_param_handle("CURRENT_PHASE_TGR"):get() > 0.0 then 							
		if self_gs > 260 then
			WHEEL_DAMAGE_STATE_NOSE_WHEEL = 1
			WHEEL_DAMAGE_STATE_MAIN_WHEELS = 1
		end

-- ======================== Rotation =======================================	
	elseif get_param_handle("CURRENT_PHASE_ROT"):get() > 0.0 then							
		if self_gs > 260 then
			WHEEL_DAMAGE_STATE_MAIN_WHEELS = 1
		end

-- ======================== Touch Down =====================================		
	elseif get_param_handle("CURRENT_PHASE_TD"):get() > 0.0 then							
		if self_gs > 260 then
			WHEEL_DAMAGE_STATE_MAIN_WHEELS = 1
		end

-- ======================== Landing Roll ====================================		
	elseif get_param_handle("CURRENT_PHASE_LR"):get() > 0.0 then							
		if self_gs > 260 then
			WHEEL_DAMAGE_STATE_NOSE_WHEEL = 1
			WHEEL_DAMAGE_STATE_MAIN_WHEELS = 1
		end

	end
	
	set_aircraft_draw_argument_value(134,WHEEL_DAMAGE_STATE_NOSE_WHEEL)
	set_aircraft_draw_argument_value(135,WHEEL_DAMAGE_STATE_MAIN_WHEELS)
	set_aircraft_draw_argument_value(136,WHEEL_DAMAGE_STATE_MAIN_WHEELS)

-- <<<<<<<<<<<<<<<<<<<<<<<< LANDING GEAR >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

-- ======================== Liftoff =========================================	
	if get_param_handle("CURRENT_PHASE_LO"):get() > 0.0 then
		if ias < 330 then
			if LANDING_GEAR_STATE > LANDING_GEAR_TARGET then
				LANDING_GEAR_STATE = LANDING_GEAR_STATE - GearOpenIncrement
			end
			if LANDING_GEAR_STATE < LANDING_GEAR_TARGET then
				LANDING_GEAR_STATE = LANDING_GEAR_STATE + GearCloseIncrement
			end
			if LANDING_GEAR_STATE >= 1 and ias < 270 then							
				dispatch_action(nil, 431)
			end			
			if LANDING_GEAR_STATE <= 0 and ias < 330 then
				dispatch_action(nil, 430)
			end	
		end
-- ======================== Combat ==========================================	
	elseif get_param_handle("CURRENT_PHASE_CO"):get() > 0.0 then
		if ias < 330 then
			if LANDING_GEAR_STATE > LANDING_GEAR_TARGET then
				LANDING_GEAR_STATE = LANDING_GEAR_STATE - GearOpenIncrement
			end
			if LANDING_GEAR_STATE < LANDING_GEAR_TARGET then
				LANDING_GEAR_STATE = LANDING_GEAR_STATE + GearCloseIncrement				
			end
			if LANDING_GEAR_STATE >= 1 and ias < 270 then							
				dispatch_action(nil, 431)
			end			
			if LANDING_GEAR_STATE <= 0 and ias < 330 then
				dispatch_action(nil, 430)
			end
		end				
-- ======================== Powered Approach and Landing ====================
	elseif get_param_handle("CURRENT_PHASE_PAL"):get() > 0.0 then
		if ias < 330 then
			if LANDING_GEAR_STATE > LANDING_GEAR_TARGET then
				LANDING_GEAR_STATE = LANDING_GEAR_STATE - GearOpenIncrement
			end
			if LANDING_GEAR_STATE < LANDING_GEAR_TARGET then
				LANDING_GEAR_STATE = LANDING_GEAR_STATE + GearCloseIncrement
			end
			if LANDING_GEAR_STATE >= 1 and ias < 270 then							
				dispatch_action(nil, 431)
			end			
			if LANDING_GEAR_STATE <= 0 and ias < 330 then
				dispatch_action(nil, 430)
			end
		end

	end	

	set_aircraft_draw_argument_value(0,LANDING_GEAR_STATE)
	set_aircraft_draw_argument_value(3,LANDING_GEAR_STATE)
	set_aircraft_draw_argument_value(5,LANDING_GEAR_STATE)

end

need_to_be_closed = false
