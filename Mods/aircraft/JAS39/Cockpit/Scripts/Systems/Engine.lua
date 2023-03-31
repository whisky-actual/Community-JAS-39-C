local dev = GetSelf()

dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")

local update_time_step = 0.001
make_default_activity(update_time_step)

local sensor_data = get_base_data()

local MainPower = get_param_handle("MAINPOWER")
MainPower:set(0.0)

local APUPower = get_param_handle("APUPOWER")
APUPower:set(0.0)

local apu_start_light = get_param_handle("APU_START_LIGHT")
local apu_running_light = get_param_handle("APU_RUNNING_LIGHT")
local apuemgy_running_light = get_param_handle("APUEMGY_RUNNING_LIGHT")

local APUStartLightWait = 25
local APUStartLightIncrement = update_time_step / APUStartLightWait
local APU_start_light_target = 1
local APU_start_light_state = 0

-- NOZZLE ANIMATION: 0 = CLOSED, 1 = OPEN
local NOZZLE_STATE = 0
local NOZZLE_TARGET_STATE1 = 0

local FastNozzleOpenCloseTimeSec = 0.5
local FastNozzleOpenCloseIncrement = update_time_step / FastNozzleOpenCloseTimeSec

local SlowNozzleOpenCloseTimeSec = 3.0
local SlowNozzleOpenCloseIncrement = update_time_step / SlowNozzleOpenCloseTimeSec

-- APU sounds
local APUwait = 120
local APUincrement = update_time_step / APUwait
local APU_target = 1
local APU_liftoff = 0
local APU_stby = 0

local Start = 0
local Main = 0
local APU = 0						

dev:listen_command(device_commands.Start)
dev:listen_command(device_commands.Main)
dev:listen_command(device_commands.FuelCover)
dev:listen_command(device_commands.Fuel)
dev:listen_command(device_commands.APU)
dev:listen_command(device_commands.ThrottleStop)
dev:listen_command(Keys.Start)
dev:listen_command(Keys.Main)
dev:listen_command(Keys.APU)
dev:listen_command(Keys.Fuel)
dev:listen_command(Keys.FuelCover)
dev:listen_command(Keys.ThrottleStop)
dev:listen_command(315) 															-- Power on/off
dev:listen_command(311) 															-- Engine start
dev:listen_command(313) 															-- Engine stop
dev:listen_command(device_commands.DTU)

function post_initialize()

    local birth = LockOn_Options.init_conditions.birth_place
    if birth=="AIR_HOT" then
		APU_state = 0.99	
		Fuel = 1
		FuelCover = 1
		ThrottleStop = 0															-- 0 = Stop, 1 = G.I/start
		DTUState = 0																-- 0 = Inserted, 1 = Ejected
		APU_start_light_state = 1.0	
		dev:performClickableAction(device_commands.Start, 0, true)
		dev:performClickableAction(device_commands.Main, 1, true)
		dev:performClickableAction(device_commands.FuelCover, 0, true)
		dev:performClickableAction(device_commands.Fuel, 0, true)
		dev:performClickableAction(device_commands.APU, 1, true)
		dev:performClickableAction(device_commands.ThrottleStop, 1, true)
		dev:performClickableAction(device_commands.DTU, 0, true)		

	   
	elseif birth=="GROUND_HOT" then
		APU_state = 0.99
		Fuel = 1
		FuelCover = 1
		ThrottleStop = 0
		DTUState = 0
		APU_start_light_state = 1.0		
		dev:performClickableAction(device_commands.Start, 0, true)
		dev:performClickableAction(device_commands.Main, 1, true)
		dev:performClickableAction(device_commands.FuelCover, 0, true)
		dev:performClickableAction(device_commands.Fuel, 0, true)
		dev:performClickableAction(device_commands.APU, 1, true)
		dev:performClickableAction(device_commands.ThrottleStop, 1, true)	
		dev:performClickableAction(device_commands.DTU, 0, true)			

		
    elseif birth=="GROUND_COLD" then
		APU_state = 0
		Fuel = 0
		FuelCover = 0
		ThrottleStop = 1
		DTUState = 1
		APU_start_light_state = 0			
		dev:performClickableAction(device_commands.Start, 0, true)
		dev:performClickableAction(device_commands.Main, 0, true)
		dev:performClickableAction(device_commands.FuelCover, 1, true)
		dev:performClickableAction(device_commands.Fuel, 1, true)
		dev:performClickableAction(device_commands.APU, 0, true)
		dev:performClickableAction(device_commands.ThrottleStop, 0, true)
		dev:performClickableAction(device_commands.DTU, 1, true)		

	
    end
	
sndhost = create_sound_host("COCKPIT_ARMS","3D",0,0,0)
JAS39APURUN = sndhost:create_sound("Aircrafts/JAS39/Cockpit/JAS39APURUN") 
JAS39ELECTRICNOISE = sndhost:create_sound("Aircrafts/JAS39/Cockpit/JAS39ELECTRICNOISE") 
JAS39APUSTART = sndhost:create_sound("Aircrafts/JAS39/Cockpit/JAS39APUSTART")
JAS39APUSHUTDOWN = sndhost:create_sound("Aircrafts/JAS39/Cockpit/JAS39APUSHUTDOWN")

end

function SetCommand(command,value)

local rpms = sensor_data.getEngineLeftRPM() 
local tposition = get_cockpit_draw_argument_value(1071)
	
    if command == device_commands.Start then
        if value == 1 then
			Start = 1
			if ThrottleStop == 1 and Start == 1 and Fuel == 1 and APU == 1 and Main == 1 and rpms < 60 then 
				dispatch_action(nil, 311)
			end
        elseif value == 0 then
			Start = 0
        end

    elseif command == Keys.Start then
        if Start == 0 then
			dev:performClickableAction(device_commands.Start, 1, true)				
			if ThrottleStop == 1 and Start == 1 and Fuel == 1 and APU == 1 and Main == 1 and rpms < 60 then 
				dispatch_action(nil, 311)				
			end
			Start = 1
        elseif Start == 1 then
			dev:performClickableAction(device_commands.Start, 0, true)	
			Start = 0
        end
	
    elseif command == device_commands.Main then
        if value == 1 then 
			if rpms < 60 then 		
				dispatch_action(nil, 315)
			end
			Main = 1
			MainPower:set(1)
			get_param_handle("littlegreendots"):set(0)
        elseif value == 0 then
			if Main == 1 then
				dispatch_action(nil, 315)
			end
			Main = 0
			MainPower:set(0)
			get_param_handle("littlegreendots"):set(-1)
        end

    elseif command == Keys.Main then
        if Main == 0 then 
			dev:performClickableAction(device_commands.Main, 1, true)	
			Main = 1
			MainPower:set(1)
			get_param_handle("littlegreendots"):set(0)
        elseif Main == 1 then
			dev:performClickableAction(device_commands.Main, 0, true)			
			if Main == 1 then
				dispatch_action(nil, 315)
			end
			Main = 0
			MainPower:set(0)
			get_param_handle("littlegreendots"):set(-1)
        end

    elseif command == device_commands.Fuel then
        if value == 0 then 
			Fuel = 1
        elseif value == 1 then 
			Fuel = 0
			if Fuel == 0 and rpms > 0 then
				dispatch_action(nil, 313)
			end
        end

    elseif command == Keys.Fuel then
        if Fuel == 0 then 
			dev:performClickableAction(device_commands.Fuel, 0, true)	
			Fuel = 1		
        elseif Fuel == 1 then 
			dev:performClickableAction(device_commands.Fuel, 1, true)				
			Fuel = 0
			if Fuel == 0 and rpms > 0 then
				dispatch_action(nil, 313)
			end
        end

    elseif command == device_commands.APU then
        if value == 1 then 
			APU = 1
			APUPower:set(1)			
		elseif value == 0 then
			if APU == 1 then
				APU = 2				
			end
        end		
	
    elseif command == Keys.APU then
        if APU == 0 then
			dev:performClickableAction(device_commands.APU, 1, true)				
			APU = 1
			APUPower:set(1)				
		elseif APU == 1 then
			dev:performClickableAction(device_commands.APU, 0, true)				
			APU = 2
        end		
	
    elseif command == device_commands.FuelCover then
        if value == 1 then 
			FuelCover = 1
			Fuel = 1		
        elseif value == 0 then
			dev:performClickableAction(device_commands.Fuel, 0, true)				
			FuelCover = 0
			Fuel = 1				
        end

    elseif command == Keys.FuelCover then
        if FuelCover == 0 then 
			dev:performClickableAction(device_commands.FuelCover, 1, true)					
			FuelCover = 1
        elseif FuelCover == 1 then
			dev:performClickableAction(device_commands.FuelCover, 0, true)		
			dev:performClickableAction(device_commands.Fuel, 0, true)				
			FuelCover = 0
			Fuel = 1
        end
		
	elseif command == device_commands.ThrottleStop then
		if tposition < 0.05 then	
			if value == 1 then
				ThrottleStop = 1
			elseif value == 0 then
				ThrottleStop = 0				
				if ThrottleStop == 0 and rpms > 0 then
					dispatch_action(nil, 313)
				end			
			end
		end	
	
	elseif command == Keys.ThrottleStop then
		if tposition < 0.05 then		
			if ThrottleStop == 0 then
				dev:performClickableAction(device_commands.ThrottleStop, 1, true)		
				ThrottleStop = 1
			elseif ThrottleStop == 1 then
				dev:performClickableAction(device_commands.ThrottleStop, 0, true)			
				ThrottleStop = 0
				if ThrottleStop == 0 and rpms > 0 then
					dispatch_action(nil, 313)
				end			
			end
		end	

	elseif command == device_commands.DTU then
		if value == 1 then
			DTUState = 1
		elseif value == 0 then
			DTUState = 0
		end
	
	end
	
end



function sounds()

	local wow_l = sensor_data.getWOW_LeftMainLandingGear()		
	local main_gear_up = sensor_data.getLeftMainLandingGearUp()

	if Main == 1 then
		JAS39ELECTRICNOISE:play_continue()
	elseif Main == 0 then
		JAS39ELECTRICNOISE:stop()
	end
	
	if APU == 1 and main_gear_up == 0 and wow_l == 1 then 
		APU_stby = 0		
		if APU_stby == 0 then
			if APU_state < APU_target then
				APU_state = APU_state + APUincrement			
				if APU_state < 1.0 then 
					JAS39APUSTART:play_continue()
					else
					JAS39APUSTART:stop()
				end				
				if APU_state > 0.98 then 
					JAS39APURUN:play_continue()						
				end	
			end
		end
		
	elseif APU == 1 and main_gear_up == 1 and wow_l == 0 and APU_stby == 0 then
		if JAS39APUSTART:is_playing() then
			JAS39APUSTART:stop()		
		elseif JAS39APURUN:is_playing() then
			JAS39APURUN:stop()			
		end
		JAS39APUSHUTDOWN:play_once()
		APU_stby = 2							
		APU_state = 0.99		
		
	elseif APU == 2 then
		if JAS39APUSTART:is_playing() then
			JAS39APUSTART:stop()		
		elseif JAS39APURUN:is_playing() then
			JAS39APURUN:stop()
		end
		JAS39APUSHUTDOWN:play_once()
		APU = 0
		APU_state = 0
		APUPower:set(0)			
	end

end

function throttlestop()

	local tposition = get_cockpit_draw_argument_value(1071)
	
	if tposition > 0.05 then
		dev:performClickableAction(device_commands.ThrottleStop, 1, true)		
		ThrottleStop = 1		
	end	

end

function apu_lights()

	if get_param_handle("APUPOWER"):get() == 1 then
		if APU_start_light_state < APU_start_light_target then
			APU_start_light_state = APU_start_light_state + APUStartLightIncrement
		end
		
		if APU_start_light_state < 1 then
			apu_start_light:set(0)
			apu_running_light:set(1)
			apuemgy_running_light:set(-1)
		elseif APU_start_light_state >= 1 then 
			if APU_stby == 0 then
				apu_start_light:set(1)
				apu_running_light:set(-1)
				apuemgy_running_light:set(1)
			elseif APU_stby == 2 then
				apu_start_light:set(1)
				apu_running_light:set(1)
				apuemgy_running_light:set(-1)
			end
		end	

	elseif get_param_handle("APUPOWER"):get() == 0 then
	apu_start_light:set(1)
	apu_running_light:set(1)
	apuemgy_running_light:set(-1)
	APU_start_light_state = 0	
	end	

end

function update()		

	sounds()
	throttlestop()
	apu_lights()	

	local rpm = sensor_data.getEngineLeftRPM() 

	local NOZZLE_TARGET_STATE3 = ((rpm - 96)*(1/(100-96)))	
	local NOZZLE_TARGET_STATE2 = math.abs(((rpm - 60)*(1/(95-60))-1))
	
	if (rpm < 60) then 												-- State 1: Engine off: Nozzle closing
		if NOZZLE_STATE > NOZZLE_TARGET_STATE1 then
		NOZZLE_STATE = NOZZLE_STATE - SlowNozzleOpenCloseIncrement
		end

		elseif (rpm > 59) and (rpm < 61) then						-- State 1-2: Engine 70000 rpm: Nozzle from fully open to closing at higher rpm	
		if NOZZLE_STATE > NOZZLE_TARGET_STATE2 then
		NOZZLE_STATE = NOZZLE_STATE - SlowNozzleOpenCloseIncrement
		end
		if NOZZLE_STATE < NOZZLE_TARGET_STATE2 then
		NOZZLE_STATE = NOZZLE_STATE + SlowNozzleOpenCloseIncrement
		end

		elseif (rpm > 60) and (rpm < 96) then						-- State 2: Engine 70000 rpm: Nozzle from fully open to closing at higher rpm	
		if NOZZLE_STATE > NOZZLE_TARGET_STATE2 then
		NOZZLE_STATE = NOZZLE_STATE - FastNozzleOpenCloseIncrement
		end
		if NOZZLE_STATE < NOZZLE_TARGET_STATE2 then
		NOZZLE_STATE = NOZZLE_STATE + FastNozzleOpenCloseIncrement
		end
				
		elseif (rpm > 95) then										-- State 3: Engine 101009 rpm AB: Nozzle from almost fully open to fully open
		if NOZZLE_STATE < NOZZLE_TARGET_STATE3 then
		NOZZLE_STATE = NOZZLE_STATE + FastNozzleOpenCloseIncrement
		end
		if NOZZLE_STATE > NOZZLE_TARGET_STATE3 then
		NOZZLE_STATE = NOZZLE_STATE - FastNozzleOpenCloseIncrement
		end
		
	end
	
    if NOZZLE_TARGET_STATE1 < 0 then
        NOZZLE_TARGET_STATE1 = 0
    elseif NOZZLE_TARGET_STATE1 > 1 then
        NOZZLE_TARGET_STATE1 = 1
    end
	
	if NOZZLE_TARGET_STATE2 < 0 then
        NOZZLE_TARGET_STATE2 = 0
    elseif NOZZLE_TARGET_STATE2 > 1 then
        NOZZLE_TARGET_STATE2 = 1
    end
	
	if NOZZLE_TARGET_STATE3 < 0 then
        NOZZLE_TARGET_STATE3 = 0
    elseif NOZZLE_TARGET_STATE3 > 1 then
        NOZZLE_TARGET_STATE3 = 1
    end

	set_aircraft_draw_argument_value(89,NOZZLE_STATE)	

-- ======================== Combat =========================================
	-- if get_param_handle("CURRENT_PHASE_CO"):get() > 0.0 then

-- ======================== Landing Roll ===================================
	-- elseif get_param_handle("CURRENT_PHASE_LR"):get() > 0.0 then	

	-- end		
	
end

need_to_be_closed = false
