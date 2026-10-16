local dev = GetSelf()
-- EFM adjusted
dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")

local update_time_step = 0.01 
make_default_activity(update_time_step)

local sensor_data = get_base_data()

local GEAR_BAY_STATE = 0
local GEAR_BAY_TARGET_OPEN = 1	
local GEAR_BAY_TARGET_CLOSE = 0

local BayDoorOpenCloseTimeSec = 3
local BayDoorOpenCloseIncrement = update_time_step / BayDoorOpenCloseTimeSec

dev:listen_command(keys.GearUp) 												-- Gear up
dev:listen_command(keys.GearDown) 												-- Gear down
dev:listen_command(deviceCommands.LandingGearLever)							-- 1 = Landing gear up, 0 = Landing gear down


function SetCommand(command,value)												-- Listen for landing gear commands									
    if command == keys.GearUp then 
		dev:performClickableAction(deviceCommands.LandingGearLever, 1, true)		
	end
	
	if command == keys.GearDown then
		dev:performClickableAction(deviceCommands.LandingGearLever, 0, true)		
	end

    if command == deviceCommands.LandingGearLever then 
		if value == 1 then
			dev:performClickableAction(deviceCommands.LandingGearLever, 1, true)		
			dispatch_action(nil, 430) -- gear up
		end
	end
	
	if command == deviceCommands.LandingGearLever then 
		if value == 0 then
			dev:performClickableAction(deviceCommands.LandingGearLever, 0, true)				
			dispatch_action(nil, 431) -- gear down
		end
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

	local gear_n_down = sensor_data.getNoseLandingGearDown()					-- Nose gear down
	local gear_l_down = sensor_data.getLeftMainLandingGearDown()				-- Main gear left down
	local gear_r_down = sensor_data.getRightMainLandingGearDown()				-- Main gear right down

	if get_param_handle("MAINPOWER"):get() == 1 then
		gear_nose_light:set(gear_n_down)
		gear_left_light:set(gear_l_down)
		gear_right_light:set(gear_r_down)	
	elseif get_param_handle("MAINPOWER"):get() == 0 then
		gear_nose_light:set(0)	
		gear_left_light:set(0)	
		gear_right_light:set(0)							
	end	

end

function post_initialize()

	if LockOn_Options.init_conditions.birth_place == "AIR_HOT" then
		dev:performClickableAction(deviceCommands.LandingGearLever, 1, true)		
		dispatch_action(nil, 430) -- gear up
	end

end




function update()		
    local WOW = sensor_data.getWOW_LeftMainLandingGear()						-- Main gear left weight on wheel
	local self_vel_l,self_vel_v,self_vel_h = sensor_data.getSelfAirspeed()		-- Prereq for ground speed in kts
	self_gs = math.sqrt(self_vel_h^2 + self_vel_l^2)*1.944 						-- Ground speed in kts
	local rpm = get_param_handle("RM12_RPM"):get()									-- Engine rpm
    local wow_n = sensor_data.getWOW_NoseLandingGear()							-- Nose gear weight on wheels 
	local wow_l = sensor_data.getWOW_LeftMainLandingGear()						-- Left main gear weight on wheels 
	local wow_r = sensor_data.getWOW_RightMainLandingGear()						-- Right main gear weight on wheels 
	local gear_handle_pos = sensor_data.getLandingGearHandlePos()				-- Gear handle position

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

end

need_to_be_closed = false