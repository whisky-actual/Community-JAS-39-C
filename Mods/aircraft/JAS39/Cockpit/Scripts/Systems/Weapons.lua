local dev = GetSelf()

dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")

local update_time_step = 0.02
make_default_activity(update_time_step)

local sensor_data = get_base_data()

function post_initialize()
    local birth = LockOn_Options.init_conditions.birth_place
    if birth=="GROUND_HOT" then
		MASTER_ARM = 0
		dev:performClickableAction(device_commands.Mass, 0, true)
		TRIGGER_ARM = 0
		dev:performClickableAction(device_commands.TriggerSafe, 0, true)	
		
    elseif birth=="AIR_HOT" then	
		MASTER_ARM = 0
		dev:performClickableAction(device_commands.Mass, 0, true)
		TRIGGER_ARM = 0
		dev:performClickableAction(device_commands.TriggerSafe, 0, true)	
	
    elseif birth=="GROUND_COLD" then
		MASTER_ARM = -1
		dev:performClickableAction(device_commands.Mass, -1, true)
		TRIGGER_ARM = 0
		dev:performClickableAction(device_commands.TriggerSafe, 0, true)		
    end

end

dev:listen_command(84)															-- PlaneFire
dev:listen_command(85) 															-- PlaneFireOff
dev:listen_command(350)                                                         -- PickleOn
dev:listen_command(351)                                                         -- PickleOff
dev:listen_command(178)															-- Tank Jettison
dev:listen_command(82)															-- Weapon Jettison  
dev:listen_command(171)															-- Weapon Jettison Up  
dev:listen_command(device_commands.Mass)										-- MASS switch, -1 = Safe, 1 = Live, 0 = Standby
dev:listen_command(Keys.Trigger)
dev:listen_command(Keys.WeaponJettison)
dev:listen_command(Keys.WeaponJettisonCover)
dev:listen_command(Keys.TankJettison)
dev:listen_command(Keys.TankJettisonCover)
dev:listen_command(Keys.MassLive)
dev:listen_command(Keys.MassStby)
dev:listen_command(Keys.MassSafe)
dev:listen_command(device_commands.WeaponJettison)
dev:listen_command(device_commands.WeaponJettisonCover)
dev:listen_command(device_commands.TankJettison)
dev:listen_command(device_commands.TankJettisonCover)
dev:listen_command(device_commands.TriggerSafe)
dev:listen_command(Keys.TriggerSafe)
dev:listen_command(Keys.TriggerSafeHold)
dev:listen_command(Keys.CannonMode)
dev:listen_command(device_commands.EmergencyJettisonCover)
dev:listen_command(device_commands.EmergencyJettison)
dev:listen_command(105) -- PlaneModeNAV 
dev:listen_command(106) -- PlaneModeBVR 	
dev:listen_command(107) -- PlaneModeVS 	
dev:listen_command(108) -- PlaneModeBore 	
dev:listen_command(110) -- PlaneModeFI0 	
dev:listen_command(111) -- PlaneModeGround
dev:listen_command(349) -- PlaneLaunchPermissionOverride


-- local MASTER_ARM = -1
local TankJettisonCover = 0
local WeaponJettisonCover = 0
-- local TRIGGER_ARM = 0															-- 0 = Safe, 1 = Armed
local PlaneCannonMode = 0
local MissileMode = 0
local EmergencyJettisonCover = 0
local OverrideLA = 0

local GripenType = get_aircraft_type()

local MASS_PARAM = get_param_handle("MASS_PARAM")
MASS_PARAM:set(MASTER_ARM)

local TRIGGER_SAFE_PARAM = get_param_handle("TRIGGER_SAFE_PARAM")
TRIGGER_SAFE_PARAM:set(TRIGGER_ARM)

function SetCommand(command,value)												-- Listen for commands									

    if command == device_commands.Mass then 
		if value == 1 then		
		MASTER_ARM = 1
		MASS_PARAM:set(MASTER_ARM)			
		end
	end
	
	if command == device_commands.Mass then 
		if value == 0 then				
		MASTER_ARM = 0
		MASS_PARAM:set(MASTER_ARM) 		
		end
	end

	if command == device_commands.Mass then 
		if value == -1 then			
		MASTER_ARM = -1
		MASS_PARAM:set(MASTER_ARM) 		
		end
	end
	
    if command == Keys.MassLive then 
		dev:performClickableAction(device_commands.Mass, 1, true)	
		MASTER_ARM = 1
		MASS_PARAM:set(MASTER_ARM) 		
	end
	
	if command == Keys.MassStby then 
		dev:performClickableAction(device_commands.Mass, 0, true)	
		MASTER_ARM = 0
		MASS_PARAM:set(MASTER_ARM) 		
	end

	if command == Keys.MassSafe then 	
		dev:performClickableAction(device_commands.Mass, -1, true)	
		MASTER_ARM = -1
		MASS_PARAM:set(MASTER_ARM) 		
	end	
	
 	if command == Keys.CannonMode then
		if PlaneCannonMode == 0 then
			dispatch_action(nil,113)
			PlaneCannonMode = 1
			MissileMode = 0
		elseif PlaneCannonMode == 1 then
			dispatch_action(nil,113)	
			PlaneCannonMode = 0
			MissileMode = 1		
		end
	end	   

	if command == 105 then
		if PlaneCannonMode == 1 then
			PlaneCannonMode = 0
		end
	elseif command == 106 then
		MissileMode = 1
		if PlaneCannonMode == 1 then
			PlaneCannonMode = 0
		end
		
	elseif command == 107 then
		MissileMode = 1		
		if PlaneCannonMode == 1 then
			PlaneCannonMode = 0	
		end
	elseif command == 108 then
		MissileMode = 1				
		if PlaneCannonMode == 1 then
			PlaneCannonMode = 0	
		end
	elseif command == 110 then
		MissileMode = 1		
		if PlaneCannonMode == 1 then
			PlaneCannonMode = 0		
		end
	elseif command == 111 then
		if PlaneCannonMode == 1 then
			MissileMode = 0
		elseif PlaneCannonMode == 0 then
			MissileMode = 1
		end	
		
	end	
		
	if command == Keys.Trigger then
        if GripenType == 'JAS39Gripen_BVR' then		
			if value == 1 and MASTER_ARM == 1 and TRIGGER_ARM == 1 and PlaneCannonMode == 1 and MissileMode == 0 then 
				dispatch_action(nil,84)
			elseif value == 0 then
				dispatch_action(nil,85)
			elseif value == 1 and MASTER_ARM == 1 and TRIGGER_ARM == 1 and PlaneCannonMode == 0 and MissileMode == 1 then 
				dispatch_action(nil,350)
			elseif value == 0 then
				dispatch_action(nil,351)				
			end
		elseif GripenType == 'JAS39Gripen' or 'JAS39Gripen_AG' then
			if value == 1 and MASTER_ARM == 1 and TRIGGER_ARM == 1 then 
				dispatch_action(nil,84)
			elseif value == 0 then
				dispatch_action(nil,85)	
			end
		end	
	end

    if command == device_commands.TankJettisonCover then 
		if value == 1 then
			TankJettisonCover = 1				
		elseif value == 0 then	
			TankJettisonCover = 0			
		end
	end	
	
    if command == device_commands.TankJettison then 
		if value == 1 then
			if TankJettisonCover == 1 and MASTER_ARM == 1 then
				dispatch_action(nil,178)
			end		
		end
	end		

    if command == device_commands.WeaponJettisonCover then 
		if value == 1 then
			WeaponJettisonCover = 1			
		elseif value == 0 then	
			WeaponJettisonCover = 0		
		end
	end	

    if command == device_commands.WeaponJettison then 
		if value == 1 then
			if WeaponJettisonCover == 1 and MASTER_ARM == 1 then				
				dispatch_action(nil,82)
			end	
		elseif value == 0 then
			dispatch_action(nil,171)
		end
	end	

    if command == device_commands.EmergencyJettisonCover then 
		if value == 1 then
			EmergencyJettisonCover = 1		
		elseif value == 0 then	
			EmergencyJettisonCover = 0			
		end
	end	

    if command == device_commands.EmergencyJettison then 
		if value == 1 then
			if EmergencyJettisonCover == 1 and MASTER_ARM >= 0 then				
				dispatch_action(nil,82)
				dispatch_action(nil,82)
				dispatch_action(nil,82)
				dispatch_action(nil,82)				
			end	
		elseif value == 0 then
			dispatch_action(nil,171)
		end
	end	
	
	if command == device_commands.TriggerSafe then
		if value == 1 then
			TRIGGER_ARM = 1
			TRIGGER_SAFE_PARAM:set(TRIGGER_ARM)			
			if OverrideLA == 0 and MASTER_ARM == 1 then
				dispatch_action(nil,349)
				OverrideLA = 1
			end	
		elseif value == 0 then
			TRIGGER_ARM = 0
			TRIGGER_SAFE_PARAM:set(TRIGGER_ARM)				
			if OverrideLA == 1 then
				dispatch_action(nil,349)
				OverrideLA = 0
			end
		end	
	end		
	
	if command == Keys.TriggerSafe then
		if TRIGGER_ARM == 0 then
			dev:performClickableAction(device_commands.TriggerSafe, 1, true)
		elseif TRIGGER_ARM == 1 then
			dev:performClickableAction(device_commands.TriggerSafe, 0, true)
		end
	end		

	if command == Keys.TriggerSafeHold then
		if value == 1 then
			dev:performClickableAction(device_commands.TriggerSafe, 1, true)
		elseif value == 0 then
			dev:performClickableAction(device_commands.TriggerSafe, 0, true)
		end
	end	
	
end

function update()		
get_param_handle("CANNON_MODE"):set(PlaneCannonMode)
	-- print_message_to_user(get_param_handle("CANNON_MODE"):get())
	
				
-- ======================== Stationary =====================================
	-- if get_param_handle("CURRENT_PHASE_STATIONARY"):get() > 0.0 then						
		-- if GEAR_BAY_STATE < GEAR_BAY_TARGET_OPEN then
		-- GEAR_BAY_STATE = GEAR_BAY_STATE + BayDoorOpenCloseIncrement
		-- end

-- ======================== Parked =========================================	
	-- elseif get_param_handle("CURRENT_PHASE_PARKED"):get() > 0.0 and (self_gs > 11) then		
		-- if GEAR_BAY_STATE > GEAR_BAY_TARGET_CLOSE then
		-- GEAR_BAY_STATE = GEAR_BAY_STATE - BayDoorOpenCloseIncrement
		-- end

-- ======================== Taxi ===========================================	
	-- elseif get_param_handle("CURRENT_PHASE_TAXI"):get() > 0.0 and (self_gs > 11) then
		-- if GEAR_BAY_STATE > GEAR_BAY_TARGET_CLOSE then
		-- GEAR_BAY_STATE = GEAR_BAY_STATE - BayDoorOpenCloseIncrement
		-- end

-- ======================== Take off Ground Roll ===========================		
	-- elseif get_param_handle("CURRENT_PHASE_TGR"):get() > 0.0 and (self_gs > 11) then
		-- if GEAR_BAY_STATE > GEAR_BAY_TARGET_CLOSE then
		-- GEAR_BAY_STATE = GEAR_BAY_STATE - BayDoorOpenCloseIncrement
		-- end

-- ======================== Rotation =======================================
	-- elseif get_param_handle("CURRENT_PHASE_ROT"):get() > 0.0 and (self_gs > 11) then
    	-- if GEAR_BAY_STATE > GEAR_BAY_TARGET_CLOSE then
    	-- GEAR_BAY_STATE = GEAR_BAY_STATE - BayDoorOpenCloseIncrement
    	-- end

-- ======================== Lift Off =======================================
    -- elseif get_param_handle("CURRENT_PHASE_LO"):get() > 0.0 then							
		-- GEAR_BAY_STATE = -1			

-- ======================== Combat =========================================
    -- if get_param_handle("CURRENT_PHASE_CO"):get() > 0.0 then							
		-- if MASTER_ARM == 1 then
		-- dispatch_action(nil, 84)
	-- end	

-- ======================== Powered Approach and Landing ===================
	-- elseif get_param_handle("CURRENT_PHASE_PAL"):get() > 0.0 then							
		-- GEAR_BAY_STATE = -1	
	
	-- end
	
    -- if GEAR_BAY_TARGET_CLOSE < 0 then
        -- GEAR_BAY_TARGET_CLOSE = 0
    -- elseif GEAR_BAY_TARGET_OPEN > 1 then
        -- GEAR_BAY_TARGET_OPEN = 1
    -- end

	-- set_aircraft_draw_argument_value(498,GEAR_BAY_STATE)

end

need_to_be_closed = false