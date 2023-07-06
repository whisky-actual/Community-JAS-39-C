local dev = GetSelf()

dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")

local update_time_step = 0.001
make_default_activity(update_time_step)

local sensor_data = get_base_data()

local CanopyState = -1									-- 0 = closed, 1 = open
local CanopyJettisonState = 0
local CanopyJettisonDone = 0
local EjectState = 0
local SeatArmState = 1									-- 0 = armed, 1 = safe
local AARProbeCoverState = 0							-- 0 = closed, 1 = open
local AARProbeState = 0
local ProbeTarget = 0
local ProbeCurrent = 0

local ProbeTime = 20
local ProbeIncrement = update_time_step / ProbeTime

local SeatTarget = 0

dev:listen_event("WeaponRearmSingleStepComplete")

dev:listen_command(device_commands.CanopyLever)			-- 0 = closed, 1 = open
dev:listen_command(Keys.CanopyLever)
dev:listen_command(71)								 	-- iCommandPlaneFonar
dev:listen_command(144)									-- iCommandPlaneResetMasterWarning
dev:listen_command(device_commands.MasterCaution)
dev:listen_command(485)									-- iCommandViewPitCameraMoveDown	
dev:listen_command(484)									-- iCommandViewPitCameraMoveUp	
dev:listen_command(device_commands.SeatUpDown)
dev:listen_command(device_commands.SeatEject)
dev:listen_command(device_commands.SeatArm)
dev:listen_command(device_commands.AARProbeCover)
dev:listen_command(device_commands.AARProbe)
dev:listen_command(155)									-- PlaneAirRefuel
dev:listen_command(Keys.AARProbeCover)
dev:listen_command(Keys.AARProbe)
dev:listen_command(Keys.SeatEject)

function post_initialize()

    local birth = LockOn_Options.init_conditions.birth_place
    if birth=="AIR_HOT" then
		CanopyState = 0
		dev:performClickableAction(device_commands.CanopyLever, 0, true)
		SeatArmState = 0
		dev:performClickableAction(device_commands.SeatArm, 0, true)
		AARProbeCoverState = 0	
		dev:performClickableAction(device_commands.AARProbeCover, 0, true)
	   
	elseif birth=="GROUND_HOT" then
		CanopyState = 0
		dev:performClickableAction(device_commands.CanopyLever, 0, true)
		SeatArmState = 0
		dev:performClickableAction(device_commands.SeatArm, 0, true)
		AARProbeCoverState = 0	
		dev:performClickableAction(device_commands.AARProbeCover, 0, true)
		
    elseif birth=="GROUND_COLD" then
		CanopyState = 1
		dev:performClickableAction(device_commands.CanopyLever, 1, true)
		SeatArmState = 1
		dev:performClickableAction(device_commands.SeatArm, 1, true)
		AARProbeCoverState = 0	
		dev:performClickableAction(device_commands.AARProbeCover, 0, true)	
    end

	sndhost = create_sound_host("COCKPIT_CANOPY","3D",0,0,0)
	JAS39CANOPYJETTISON = sndhost:create_sound("Aircrafts/JAS39/Cockpit/JAS39CANOPYJETTISON") 

end

function SetCommand(command,value)
	
	local rpms = sensor_data.getEngineLeftRPM() 
	
    if command == device_commands.CanopyLever then
			if value == 0 then
				if CanopyState == 1 then
					dispatch_action(nil, 71)
					CanopyState = 0
				end
			elseif value == 1 then
				if CanopyState == 0 then
					dispatch_action(nil, 71)
					CanopyState = 1
				end
			end	
	
	elseif command == Keys.CanopyLever then
			if CanopyState == 1 then
				dev:performClickableAction(device_commands.CanopyLever, 0, true)	
				dispatch_action(nil, 71)
				CanopyState = 0		
			elseif CanopyState == 0 then
				dev:performClickableAction(device_commands.CanopyLever, 1, true)				
				dispatch_action(nil, 71)
				CanopyState = 1
			end
	
	elseif command == device_commands.MasterCaution then
		dispatch_action(nil,144)
	
	elseif command == device_commands.SeatUpDown then
		if value > 0 then
			SeatTarget = 1
		elseif value < 0 then
			SeatTarget = -1
		elseif value == 0 then
			SeatTarget = 0
		end	
	
	elseif command == device_commands.CanopyJettison then
		if value == 1 then
			CanopyJettisonState = 1			
			if CanopyJettisonDone == 0 then
				set_aircraft_draw_argument_value(38,100)
				JAS39CANOPYJETTISON:play_once()	
				CanopyJettisonDone = 1
			end
		elseif value == 0 then
			CanopyJettisonState = 0
		end	

	elseif command == device_commands.SeatEject then
		if value == 1 then
			if SeatArmState == 0 then
				dispatch_action(nil,83)			
			end
		end	

	elseif command == Keys.SeatEject then
		if SeatArmState == 0 then
			dispatch_action(nil,83)					
		end		
	
	elseif command == device_commands.SeatArm then
		if value == 1 then
			SeatArmState = 1
		elseif value == 0 then
			SeatArmState = 0
		end

	elseif command == Keys.SeatArm then
		if SeatArmState == 0 then
		SeatArmState = 1
		elseif SeatArmState == 1 then
		SeatArmState = 0
		end

	elseif command == device_commands.AARProbeCover then
		if value == 1 then 				
			AARProbeCoverState = 1			
		elseif value == 0 then 				
			if AARProbeState == 1 then
				dispatch_action(nil,155)
				AARProbeState = 0
			end	
			dev:performClickableAction(device_commands.AARProbe, 0, true)	
			AARProbeCoverState = 0	
		end

	elseif command == device_commands.AARProbe then
		if rpms >= 60 then
			if value == 1 then
				if AARProbeCoverState == 1 then
					if AARProbeState == 0 then
						dispatch_action(nil,155)
						AARProbeState = 1
					end
			end
			elseif value == 0 then
				if AARProbeCoverState == 1 then
					if AARProbeState == 1 then
						dispatch_action(nil,155)
						AARProbeState = 0
					end	
				end
			end
		end
		
	elseif command == Keys.AARProbeCover then
		if AARProbeCoverState == 0 then
			dev:performClickableAction(device_commands.AARProbeCover, 1, true)
		elseif AARProbeCoverState == 1 then
			dev:performClickableAction(device_commands.AARProbeCover, 0, true)
			dev:performClickableAction(device_commands.AARProbe, 0, true)
		end
	
	elseif command == Keys.AARProbe then
		if rpms >= 60 then
			if AARProbeState == 0 then
				if AARProbeCoverState == 1 then
				dev:performClickableAction(device_commands.AARProbe, 1, true)	
				end
			elseif AARProbeState == 1 then
				dev:performClickableAction(device_commands.AARProbe, 0, true)		
			end
		end
	end		
	
end

function CockpitEvent(event, val)												-- Function for repairing the canopy
    if event == "WeaponRearmSingleStepComplete" then
        CanopyJettisonState = 0	
		EjectState = 0
	end
end

local canopy_light = get_param_handle("CANOPY_LIGHT")

function canopy_warning_light()
	if get_param_handle("MAINPOWER"):get() == 1 then
		if CanopyState == 1 then 
			canopy_light:set(1)		
		elseif CanopyState == 0 then
			canopy_light:set(0)
		end
	end	
end

local caution_light = get_param_handle("CAUTION_LIGHT")

function caution_lights()

	local GripenType = get_aircraft_type()
	local master_caution_wvr = get_cockpit_draw_argument_value(107)
	local master_caution_bvr = get_cockpit_draw_argument_value(117)
	local master_caution_ag = get_cockpit_draw_argument_value(107)

	if GripenType == 'JAS39Gripen' then
		if master_caution_wvr > 0 then
			caution_light:set(1)
		elseif master_caution_wvr == 0 then
			caution_light:set(-1)
		end		
	elseif GripenType == 'JAS39Gripen_AG' then
		if master_caution_ag > 0 then
			caution_light:set(1)
		elseif master_caution_ag == 0 then
			caution_light:set(-1)
		end
		elseif GripenType == 'JAS39Gripen_BVR' then
		if master_caution_bvr > 0 then
			caution_light:set(1)
		elseif master_caution_bvr == 0 then
			caution_light:set(-1)
		end
	end	
end	

function seat_adjustment()

	if SeatTarget == 1 then
		dispatch_action(nil,484)
		SeatTarget = 0
	elseif SeatTarget == -1 then
		dispatch_action(nil,485)
		SeatTarget = 0
	end

end

function extend_probe()
	
	ProbeTarget = AARProbeState
		if ProbeCurrent < ProbeTarget then
			ProbeCurrent = ProbeCurrent + ProbeIncrement
		elseif ProbeCurrent > ProbeTarget then
			ProbeCurrent = ProbeCurrent - ProbeIncrement
		end
	
	set_aircraft_draw_argument_value(22,ProbeCurrent)
	
end

function update()		

	caution_lights()
	canopy_warning_light()
	seat_adjustment()
	extend_probe()

-- ======================== Lift Off =======================================
	-- if get_param_handle("CURRENT_PHASE_LO"):get() > 0.0 then	

		
-- ======================== Powered Approach and Landing ===================
	-- elseif get_param_handle("CURRENT_PHASE_PAL"):get() > 0.0 then	

	-- end	
	
end

need_to_be_closed = false
