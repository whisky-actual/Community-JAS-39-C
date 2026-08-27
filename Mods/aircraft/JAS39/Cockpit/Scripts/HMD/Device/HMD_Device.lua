dofile(LockOn_Options.script_path .. "command_defs.lua")
dofile(LockOn_Options.script_path .. "devices.lua")
dofile(LockOn_Options.script_path .. "utils.lua")



local updateTimeStep = 1 / 30 -- Refresh rate of device script.
make_default_activity(updateTimeStep)


local HMD = GetSelf()

HMD:listen_command(deviceCommands.HMDToggle) -- HMD toggle dashboard button.
HMD:listen_command(keys.HMDToggle)           -- HMD toggle keybind.


local birth = ""


local HMDState = get_param_handle("HMDState")

local desiredHMDBrightness = get_param_handle("desiredHMDBrightness")
local HMDBrightness        = get_param_handle("HMDBrightness")


local onlyHMD = false -- true = Turns off HUD and alwasy shows HMD, for testing.

local viewX = 0
local viewY = 0
local absViewX = 0

local prevStatus -- 1 = off, 2 = stby, 3 = on.
local fadeInVal = 0

local curAlt = 0
local altLineLo = 0
local altLineHi = 0



function post_initialize()
	print_message_to_user(Dump(getmetatable(HMD)))
	birth = LockOn_Options.init_conditions.birth_place



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
		if ((absViewX <= .223 and viewY <= .105) or (absViewX > .223 and absViewX <= .493 and viewY <= -.275) or (absViewX > .493 and absViewX <= .53 and viewY <= -.358) or (absViewX > .53 and absViewX <= .627 and viewY <= -.48) or viewY <= -.557) and not onlyHMD then
			HMDBrightness:set(0) -- HMD is not visible when looking down into the cockpit.
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



	curAlt = math.floor(get_param_handle("altTape"):get())
	altLineLo = curAlt - 150
	altLineHi = curAlt + 150

	for i = 1, 3 do
		local j = i + 1

		local longLine = wrapValue(altLineLo, altLineHi, 100 * j)
		get_param_handle("HMDLongAltLine_" .. i):set(longLine)
		get_param_handle("HMDShortAltLine_" .. i):set(wrapValue(altLineLo, altLineHi, 100 * j - 50))

		if longLine <= 999 then
			get_param_handle("HMDAltBig_" .. i):set(longLine)
			get_param_handle("HMDAltSmall_" .. i):set(" ")
			get_param_handle("HMDAltSmallStr_" .. i):set("")
		else
			local thousands = math.floor(longLine / 1000)
			local hundreds = math.floor((longLine % 1000) / 100)
			get_param_handle("HMDAltBig_" .. i):set(thousands)
			if hundreds == 0 then
				get_param_handle("HMDAltSmall_" .. i):set(".          000")
				get_param_handle("HMDAltSmallStr_" .. i):set(0)
			else
				get_param_handle("HMDAltSmall_" .. i):set(".          " .. hundreds .. "00")
				get_param_handle("HMDAltSmallStr_" .. i):set(hundreds)
			end
		end
	end
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