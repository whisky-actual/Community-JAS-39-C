dofile(LockOn_Options.script_path .. "command_defs.lua")
dofile(LockOn_Options.script_path .. "devices.lua")



local updateTimeStep = 1/180 --Refresh rate of device script.
make_default_activity(updateTimeStep)


local HMD = GetSelf()


HMD:listen_command(deviceCommands.HMDToggle) --HMD toggle dashboard button.
HMD:listen_command(keys.HMDToggle) --HMD toggle keybind.


local HMDState = get_param_handle("HMDState")

local desiredHMDBrightness = get_param_handle("desiredHMDBrightness")
local HMDBrightness        = get_param_handle("HMDBrightness")


local birth = LockOn_Options.init_conditions.birth_place

local onlyHMD = false --true = Turns off HUD and on HMD, for testing.

local absViewX
local viewX
local viewY

local fadeInVal = 0
local prevStatus --1 = off, 2 = stby, 3 = on.



function post_initialize()
	HMDState:set((birth ~= "GROUND_COLD" or onlyHMD) and 1 or 0)


	desiredHMDBrightness:set(1)
end

function update()
	viewX = get_aircraft_draw_argument_value(39)
	viewY = get_aircraft_draw_argument_value(99)
	absViewX = math.abs(viewX)

	get_param_handle("horizontalViewHMD"):set(viewX)
	get_param_handle("verticalViewHMD"):set(viewY)


	if HMDState:get() == 1 then
		--TODO: Fix the absViewX values when the new camera is fixed.
		if ((absViewX <= 0.233 and viewY <= 0.097) or (absViewX > 0.233 and absViewX <= 0.487 and viewY <= -0.231) or (absViewX > 0.487 and absViewX <= 0.908 and viewY <= -0.428) or viewY <= -0.552) and not onlyHMD then
			HMDBrightness:set(0) --HMD is not visible when looking down into the cockpit.
			prevStatus = (prevStatus ~= 1) and 2 or prevStatus
		else
			if prevStatus == 2 then
				HMDBrightness:set(fadeIn(0.2))
			elseif prevStatus == 1 then
				HMDBrightness:set(fadeIn(0.01))
			else
				HMDBrightness:set(fadeIn())
			end
		end
	else
		HMDBrightness:set(0)
		prevStatus = 1
	end


	if onlyHMD then
		get_param_handle("HUDBrightness"):set(0)
	end



	get_param_handle("HMDPitch"):set(math.abs(math.deg(get_base_data().getPitch()) - 90))



	get_param_handle("HMDButtonLight"):set((get_param_handle("mainpower"):get() == 1 and HMDState:get() == 1) and 1 or 0)
end

function SetCommand(command, value)
	if command == keys.HMDToggle then
		HMD:performClickableAction(deviceCommands.HMDToggle, (value == 1) and 1 or 0, true)
	end

	if command == deviceCommands.HMDToggle then
		HMDState:set((HMDState:get() == 0) and 1 or 0)
	end
end


function fadeIn(durationMult)
	durationMult = durationMult or 0.2
	fadeInVal = fadeInVal + updateTimeStep * durationMult

	if HMDBrightness:get() >= desiredHMDBrightness:get() then
		fadeInVal = 0
		prevStatus = durationMult and 3 or prevStatus
		return desiredHMDBrightness:get()
	end
	
	return HMDBrightness:get() + fadeInVal
end




need_to_be_closed = false