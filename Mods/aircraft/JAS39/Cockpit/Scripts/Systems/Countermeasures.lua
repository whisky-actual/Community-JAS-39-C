dofile(LockOn_Options.script_path.."command_defs.lua")
local update_time_step = 0.05 
make_default_activity(update_time_step)
local dev = GetSelf()
local sensor_data = get_base_data()

local FLARECOUNT = get_param_handle("FLARE_COUNT")
local CHAFFCOUNT = get_param_handle("CHAFF_COUNT")
FLARECOUNT:set(40)
CHAFFCOUNT:set(80)
local FLAR_TOGGLE = get_param_handle("FLAR_TOGGLE")		
local CHAF_TOGGLE = get_param_handle("CHAF_TOGGLE")
	
dev:listen_command(Keys.CountermeasureRelease)

dev:listen_event("WeaponRearmComplete")

function CockpitEvent(event, val)												
    if event == "WeaponRearmComplete" then
		FLARECOUNT:set(40)
		CHAFFCOUNT:set(80)
	end
end

function SetCommand(command,value)

	if (command == Keys.CountermeasureRelease) and (get_param_handle("MASS_PARAM"):get() ~= -1) and (sensor_data.getWOW_NoseLandingGear() == 0) then
		-- when countermeasure dispense is pressed
		if (FLAR_TOGGLE:get() == 1) and (FLARECOUNT:get() > 0) then	-- if Flares have been toggled on
			dispatch_action(nil,357) 	-- dispense flares
			FLARECOUNT:set(FLARECOUNT:get() -2) -- two flares at a time
		end
		if (CHAF_TOGGLE:get() == 1) and (CHAFFCOUNT:get() > 0) then	-- if chaff have been toggled on
			dispatch_action(nil,358)	-- dispense chaff
			CHAFFCOUNT:set(CHAFFCOUNT:get() -1)	-- one chaff at a time
		end
	end
end


need_to_be_closed = false