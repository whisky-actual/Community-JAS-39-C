dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")

local dev = GetSelf()

local update_time_step = 1/30
make_default_activity(update_time_step)

local sensor_data = get_base_data()

function post_initialize()
    local birth = LockOn_Options.init_conditions.birth_place

    if birth=="AIR_HOT" then
        dev:performClickableAction(device_commands.LandingTaxiLights, -1, true)		
        dev:performClickableAction(device_commands.CovertLights, 1, true)
        dev:performClickableAction(device_commands.AntiCollisionLights, 0, true)	
        dev:performClickableAction(device_commands.FormationLights, 0, true)			
        dev:performClickableAction(device_commands.FormFlashLights, 0, true)			
        dev:performClickableAction(device_commands.NavigationLights, 0, true)			
	
    elseif birth=="GROUND_HOT" then
        dev:performClickableAction(device_commands.LandingTaxiLights, 1, true)
        dev:performClickableAction(device_commands.CovertLights, 1, true)	
        dev:performClickableAction(device_commands.AntiCollisionLights, 1, true)
        dev:performClickableAction(device_commands.FormationLights, 0, true)			
        dev:performClickableAction(device_commands.FormFlashLights, 1, true)			
        dev:performClickableAction(device_commands.NavigationLights, 0, true)		
	
    elseif birth=="GROUND_COLD" then
        dev:performClickableAction(device_commands.LandingTaxiLights, -1, true)
        dev:performClickableAction(device_commands.CovertLights, 1, true)	
        dev:performClickableAction(device_commands.AntiCollisionLights, 0, true)
        dev:performClickableAction(device_commands.FormationLights, -1, true)			
        dev:performClickableAction(device_commands.FormFlashLights, 0, true)			
        dev:performClickableAction(device_commands.NavigationLights, -1, true)			
		
    end
end

dev:listen_command(device_commands.FloodLight)
dev:listen_command(device_commands.LandingTaxiLights)
dev:listen_command(device_commands.CovertLights)
dev:listen_command(device_commands.AntiCollisionLights)
dev:listen_command(device_commands.FormationLights)
dev:listen_command(device_commands.FormFlashLights)
dev:listen_command(device_commands.NavigationLights)

dev:listen_command(Keys.LandingLights)
dev:listen_command(Keys.TaxiLights)
dev:listen_command(Keys.LandingTaxiLightsOff)  

local LD_BRIGHTNESS = get_param_handle("LD_BRIGHTNESS")

local landing_lights_state = 0              -- 0: off, 1: on
local taxi_lights_state = 0                 -- 0: off, 1: on
local covert_lights_state = 0				-- 0: covert, 0: norm
local anti_collision_lights_state = 0		-- 0: off, 1: on
local formation_lights_state = 0			-- 0: off, 0.5: step 1, 0.625: step 2, 0.875: step 3, 1.0: step 4
local formation_lights_flash_state = 0		-- 0: steady, 1: flash
local navigation_lights_state = 0			-- -1: brt, 0: dim, 1: off

function SetCommand(command,value)
	
	if command == device_commands.LandingTaxiLights then
			if value == -1 then			
				landing_lights_state = 0
				taxi_lights_state = 0					
			elseif value == 0 then
				landing_lights_state = 0
				taxi_lights_state = 1					
			elseif value == 1 then
				landing_lights_state = 1			
				taxi_lights_state = 1
			end
	
	elseif command == Keys.LandingLights then
			dev:performClickableAction(device_commands.LandingTaxiLights, -1, true)		
			landing_lights_state = 0
			taxi_lights_state = 0	
				
	elseif command == Keys.LandingTaxiLightsOff then		
			dev:performClickableAction(device_commands.LandingTaxiLights, 0, true)
			landing_lights_state = 0
			taxi_lights_state = 1
	
	elseif command == Keys.TaxiLights then		
			dev:performClickableAction(device_commands.LandingTaxiLights, 1, true)
			landing_lights_state = 1
			taxi_lights_state = 0		
	
	elseif command == device_commands.CovertLights then
		if value == 0 then
			covert_lights_state = 1
		elseif value == 1 then
			covert_lights_state = 0					
		end			
	
	elseif command == Keys.CovertLights then
		if covert_lights_state == 0 then
			dev:performClickableAction(device_commands.CovertLights, 1, true)			
			covert_lights_state = 1
		elseif covert_lights_state == 1 then
			dev:performClickableAction(device_commands.CovertLights, 0, true)			
			covert_lights_state = 0					
		end		
	
	elseif command == device_commands.AntiCollisionLights then
			if value == 0 then
				anti_collision_lights_state = 0
			elseif value == 1 then
				anti_collision_lights_state = 1
			end	
		
	elseif command == device_commands.FormationLights then
			if value == -1.0 then
				formation_lights_state = 0.000
			elseif value == -0.5 then
				formation_lights_state = 0.500
			elseif value == 0 then
				formation_lights_state = 0.625
			elseif value == 0.5 then
				formation_lights_state = 0.875
			elseif value == 1.0 then
				formation_lights_state = 1.000				
			end		

	elseif command == device_commands.FormFlashLights then
			if value == 0 then
				formation_lights_flash_state = 0
			elseif value == 1 then
				formation_lights_flash_state = 1
			end			

	elseif command == device_commands.NavigationLights then
			if value == -1 then
				navigation_lights_state = 0
			elseif value == 0 then
				navigation_lights_state = 0.5
			elseif value == 1 then
				navigation_lights_state = 1				
			end			
		
	end	
end

-- Anti collision lights flash 
local flashcounter_anticoll = 0
local flashperminute_anticoll = 90

function update_flashing_anticoll()
    flashcounter_anticoll = flashcounter_anticoll + (update_time_step*(flashperminute_anticoll/60))
    if flashcounter_anticoll > flashperminute_anticoll then
        flashcounter_anticoll = 0
    end

    local a,b = math.modf(flashcounter_anticoll)
    if b < (0.54/(0.54+0.21)) then
        return 1
    else
        return 0
    end
end

-- Formation lights flash 
local FormLightTime1 = 0.1
local FormLightTime1Increment1 = update_time_step / FormLightTime1

local FormLightTime2 = 0.1
local FormLightTime1Increment2 = update_time_step / FormLightTime2

local FormLightTime3 = 0.5
local FormLightTime1Increment3 = update_time_step / FormLightTime3

local FormLightPause1 = 0.1
local FormLightPauseIncrement1 = update_time_step / FormLightPause1

local FormLightPause2 = 0.5
local FormLightPauseIncrement2 = update_time_step / FormLightPause2

local flash_form_state = 1
local flash_form_target_high = 1
local flash_form_target_low = 0

local flash_step = 0

function update_flashing_form()

	if flash_step == 0 then
		if flash_form_state > flash_form_target_low then
			flash_form_state = flash_form_state - FormLightTime1Increment1
			if flash_form_state <= flash_form_target_low then
				flash_step = 1
			end
		end
	
	elseif flash_step == 1 then
		if flash_form_state < flash_form_target_high then
			flash_form_state = flash_form_state + FormLightPauseIncrement1
			if flash_form_state >= flash_form_target_high then
				flash_step = 2
			end
		end
	
	elseif flash_step == 2 then
		if flash_form_state > flash_form_target_low then
			flash_form_state = flash_form_state - FormLightTime1Increment2
			if flash_form_state <= flash_form_target_low then
				flash_step = 3
			end
		end	
	
	elseif flash_step == 3 then
		if flash_form_state < flash_form_target_high then
			flash_form_state = flash_form_state + FormLightPauseIncrement1
			if flash_form_state >= flash_form_target_high then
				flash_step = 4
			end			
		end	
	
	elseif flash_step == 4 then
		if flash_form_state > flash_form_target_low then
			flash_form_state = flash_form_state - FormLightTime1Increment3
			if flash_form_state <= flash_form_target_low then
				flash_step = 5
			end			
		end

	elseif flash_step == 5 then
		if flash_form_state < flash_form_target_high then
			flash_form_state = flash_form_state + FormLightPauseIncrement2
			if flash_form_state >= flash_form_target_high then
				flash_step = 0
			end				
		end
	end

end

function interior_lights()

	local floodlight_status = get_cockpit_draw_argument_value(180)

	if get_param_handle("MAINPOWER"):get() == 1 then	
		set_aircraft_draw_argument_value(210,LD_BRIGHTNESS:get())
		set_aircraft_draw_argument_value(212,LD_BRIGHTNESS:get())
	elseif 	get_param_handle("MAINPOWER"):get() == 0 then
		set_aircraft_draw_argument_value(210,-1)
		set_aircraft_draw_argument_value(212,0)
	end	
	
	set_aircraft_draw_argument_value(211,floodlight_status)

end

function update()

	interior_lights()
	update_flashing_form() -- Formation lights flash
		
	local flashon_anticoll = update_flashing_anticoll()

	local gear_n_up = sensor_data.getNoseLandingGearUp()						-- Nose gear up
	local gear_n_down = sensor_data.getNoseLandingGearDown()					-- Nose gear down
	local gear_l_up = sensor_data.getLeftMainLandingGearUp()					-- Main gear left up
	local gear_l_down = sensor_data.getLeftMainLandingGearDown()				-- Main gear left down
	local gear_r_up = sensor_data.getRightMainLandingGearUp()					-- Main gear right up
	local gear_r_down = sensor_data.getRightMainLandingGearDown()				-- Main gear right down
	local rpm = sensor_data.getEngineLeftRPM() 

	if get_param_handle("APUPOWER"):get() == 1 or rpm >= 60 then  
		
		if covert_lights_state == 1 then
			set_aircraft_draw_argument_value(190,0) -- Left front red navigation light
			set_aircraft_draw_argument_value(191,0)	-- Right front green navigation light
			set_aircraft_draw_argument_value(192,0)	-- Rear white navigation lights
			set_aircraft_draw_argument_value(193,0) -- Rear tail fin anticollision light			
			set_aircraft_draw_argument_value(200,0)	-- Formation lights
			set_aircraft_draw_argument_value(201,0)	-- Wingtip lights
			set_aircraft_draw_argument_value(208,0) -- Landing lights
			set_aircraft_draw_argument_value(209,0) -- Taxi lights
		
		elseif covert_lights_state == 0 then
			if navigation_lights_state >= 0 and formation_lights_state == 0 then
				set_aircraft_draw_argument_value(190,navigation_lights_state) 	-- Left front red navigation light
				set_aircraft_draw_argument_value(191,navigation_lights_state)	-- Right front green navigation light
				set_aircraft_draw_argument_value(192,navigation_lights_state)	-- Rear white navigation lights
				set_aircraft_draw_argument_value(200,0)							-- Formation lights				
				set_aircraft_draw_argument_value(201,0)							-- Wingtip lights			
			
			elseif navigation_lights_state == -1 and formation_lights_state == 0 then
				set_aircraft_draw_argument_value(190,0) 	-- Left front red navigation light
				set_aircraft_draw_argument_value(191,0)		-- Right front green navigation light
				set_aircraft_draw_argument_value(192,0)		-- Rear white navigation lights
				set_aircraft_draw_argument_value(200,0)		-- Formation lights				
				set_aircraft_draw_argument_value(201,0)		-- Wingtip lights			
			end
			
			if formation_lights_state > 0 and formation_lights_flash_state == 0 then
				set_aircraft_draw_argument_value(190,formation_lights_state) 	-- Left front red navigation light
				set_aircraft_draw_argument_value(191,formation_lights_state)	-- Right front green navigation light
				set_aircraft_draw_argument_value(192,formation_lights_state)	-- Rear white navigation lights
				set_aircraft_draw_argument_value(201,formation_lights_state)	-- Wingtip lights
				set_aircraft_draw_argument_value(200,formation_lights_state)	-- Formation lights			
			
			elseif formation_lights_state > 0 and formation_lights_flash_state == 1 then
				set_aircraft_draw_argument_value(190,formation_lights_state*flash_form_state) 	-- Left front red navigation light
				set_aircraft_draw_argument_value(191,formation_lights_state*flash_form_state)	-- Right front green navigation light
				set_aircraft_draw_argument_value(192,formation_lights_state*flash_form_state)	-- Rear white navigation lights	
				set_aircraft_draw_argument_value(201,formation_lights_state*flash_form_state)	-- Wingtip lights	
				set_aircraft_draw_argument_value(200,formation_lights_state)					-- Formation lights				
			end
	
			if anti_collision_lights_state == 1 then
				set_aircraft_draw_argument_value(193,flashon_anticoll)	
			elseif anti_collision_lights_state == 0 then
				set_aircraft_draw_argument_value(193,0)				
			end
			
			if landing_lights_state == 1 and gear_l_down == 1 and gear_r_down == 1 then		
				set_aircraft_draw_argument_value(208,landing_lights_state)				
			else
				set_aircraft_draw_argument_value(208,0)			
			end	
			
			if taxi_lights_state == 1 and gear_n_down == 1 then
				set_aircraft_draw_argument_value(209,taxi_lights_state)	
			else
				set_aircraft_draw_argument_value(209,0)
			end		
		end	
		
	elseif get_param_handle("APUPOWER"):get() == 0 or rpm < 60 then
			set_aircraft_draw_argument_value(190,0) -- Left front red navigation light
			set_aircraft_draw_argument_value(191,0)	-- Right front green navigation light
			set_aircraft_draw_argument_value(192,0)	-- Rear white navigation lights
			set_aircraft_draw_argument_value(193,0) -- Rear tail fin anticollision light			
			set_aircraft_draw_argument_value(200,0)	-- Formation lights
			set_aircraft_draw_argument_value(201,0)	-- Wingtip lights
			set_aircraft_draw_argument_value(208,0) -- Landing lights
			set_aircraft_draw_argument_value(209,0) -- Taxi lights
	end

end

need_to_be_closed = false

