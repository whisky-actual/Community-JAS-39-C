local dev = GetSelf()


dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")

local update_time_step = 1/60
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

dev:listen_command(deviceCommands.Start)
dev:listen_command(deviceCommands.Main)
dev:listen_command(deviceCommands.FuelCover)
dev:listen_command(deviceCommands.Fuel)
dev:listen_command(deviceCommands.APU)
dev:listen_command(deviceCommands.ThrottleStop)
dev:listen_command(keys.Start)
dev:listen_command(keys.Main)
dev:listen_command(keys.APU)
dev:listen_command(keys.Fuel)
dev:listen_command(keys.FuelCover)
dev:listen_command(keys.ThrottleStop)
dev:listen_command(315) 															-- Power on/off
dev:listen_command(311) 															-- Engine start
dev:listen_command(313) 															-- Engine stop
dev:listen_command(deviceCommands.DTU)

dev:listen_command(efm_commands.FUEL_switch)
dev:listen_command(efm_commands.APU_ON_switch)
dev:listen_command(efm_commands.MAIN_PWR_switch)
dev:listen_command(efm_commands.Throttle_latch)
dev:listen_command(efm_commands.FCS_PWR_switch)



																	
function ClickButBetter(cmdnum, cmdval, animval)			-- This is a workaround for performClickableAction only updating the animation not actually sending the command
	GetDevice(nil):performClickableAction(cmdnum, animval, false) -- I put the bool in here even though it's effectively always false and that is the whole point of the function
	dispatch_action(nil, cmdnum, cmdval)							-- using GetSelf() instead of nil will cause switch to not animate
end




function post_initialize()

	local birth = LockOn_Options.init_conditions.birth_place

	--print_message_to_user(birth,5)

	if birth == "AIR_HOT" then
		dev:performClickableAction(deviceCommands.FuelCover, 1, true)

		ClickButBetter(efm_commands.APU_ON_switch, 1, 1)
		ClickButBetter(efm_commands.MAIN_PWR_switch, 1, 1)
		ClickButBetter(efm_commands.Throttle_latch, 1, 1)
		ClickButBetter(efm_commands.FCS_PWR_switch, 1, 0)
	elseif birth == "GROUND_HOT" then
		dev:performClickableAction(deviceCommands.FuelCover, 1, true)
		--ClickButBetter(efm_commands.FUEL_switch, 1, 0)
		ClickButBetter(efm_commands.APU_ON_switch, 1, 1)
		ClickButBetter(efm_commands.MAIN_PWR_switch, 1, 1)
		ClickButBetter(efm_commands.Throttle_latch, 1, 1)
		ClickButBetter(efm_commands.FCS_PWR_switch, 1, 0)
	elseif birth == "GROUND_COLD" then
		dev:performClickableAction(deviceCommands.FuelCover, 0, true)
		ClickButBetter(efm_commands.FUEL_switch, 1, 1)
	end

	
	


	
sndhost = create_sound_host("COCKPIT_ARMS","3D",0,0,0)
JAS39APURUN = sndhost:create_sound("Aircrafts/JAS39/Cockpit/JAS39APURUN") 
JAS39ELECTRICNOISE = sndhost:create_sound("Aircrafts/JAS39/Cockpit/JAS39ELECTRICNOISE") 
JAS39APUSTART = sndhost:create_sound("Aircrafts/JAS39/Cockpit/JAS39APUSTART")
JAS39APUSHUTDOWN = sndhost:create_sound("Aircrafts/JAS39/Cockpit/JAS39APUSHUTDOWN")

end

function SetCommand(command,value)

	if command == deviceCommands.DTU then
		DTUState = value
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
		dev:performClickableAction(deviceCommands.ThrottleStop, 1, true)		
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

	
	
end

need_to_be_closed = false
