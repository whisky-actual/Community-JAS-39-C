dofile(LockOn_Options.common_script_path .. "../../../Database/wsTypes.lua")
dofile(LockOn_Options.script_path .. "Systems/Weapon_Data.lua")
dofile(LockOn_Options.script_path .. "command_defs.lua")
dofile(LockOn_Options.script_path .. "devices.lua")
dofile(LockOn_Options.script_path .. "utils.lua")



local updateTimeStep = 1 / 60
make_default_activity(updateTimeStep)


local WS = GetSelf()

WS:listen_command(keys.trigger)
WS:listen_command(keys.stickS5Up)
WS:listen_command(keys.stickS5Down)
WS:listen_command(keys.stickS5Left)
WS:listen_command(keys.stickS5Right)
WS:listen_command(deviceCommands.MASS) -- MASS switch, -1 = Safe, 1 = Live, 0 = Standby
WS:listen_command(keys.MASSLive)
WS:listen_command(keys.MASSStby)
WS:listen_command(keys.MASSSafe)


local ammoCount = get_param_handle("ammoCount")
local selectedPylon = get_param_handle("selectedPylon")

local MASSParam = get_param_handle("MASSParam")

local primaryMode = get_param_handle("primaryMode") -- Primary modes: 1 = A/A, 2 = A/S, 3 = RCE
local weaponsMode = get_param_handle("weaponsMode") -- holds a wTypes value: AA = 1, dogfight = 2, gun = 3, AS = 4 (0 = NAV)



local baseData = get_base_data()


local MS_TO_KTS = 1.94384449
local M_TO_FT = 3.28083989501312335958

local pylonOrder      = {"p1L", "p1R", "p2L", "p2R", "p3L", "p3R", "FLIR", "p4", "p5", "ELINT", "EWS39"}
local pylonInfo       = {}
local selectedStation = -1          -- 0-based station index, -1 = nothing selected, GUN_PYLON = gun
local GUN_PYLON       = #pylonOrder -- virtual station for the gun, one past the last real station

local modeCommands = {
	[keys.stickS5Up]    = {weaponsMode = wTypes.AA},
	[keys.stickS5Down]  = {weaponsMode = wTypes.AS, primaryMode = 2},
	[keys.stickS5Left]  = {weaponsMode = wTypes.dogfight},
	[keys.stickS5Right] = {weaponsMode = wTypes.gun}
}

local ASModeClock = false
local ASModeClockTime = 0
local AS_MODE_DELAY = .7

local MASSCommands = {
	[keys.MASSSafe] = {value = -1},
	[keys.MASSStby] = {value = 0},
	[keys.MASSLive] = {value = 1}
}

local MASSState

local trigger = false
local gunFiring = false



--- Sets ParamHandle `ammoCount` to the current count of ammunition in the gun.
--- @return integer count The current ammunition remaining.
local function updateAmmoCount()
	local count = GetDevice(devices["gun"]):getAmmoCount() -- Made possible by C++ function in the custom Lua device "MZ::avGun", found in Avionics.dll

	ammoCount:set(count)

	return count
end

--- Updates table `pylonInfo` with the data from each pylon, such as type and weapon count.
local function updatePylonInfo()
	for i, name in ipairs(pylonOrder) do
		local info = WS:get_station_info(i - 1)
		local data = info and weaponData[info["CLSID"]]
		local pylon = pylonInfo[name]
		local count = info["count"]
		local pylonName = get_param_handle("pylonName_" .. i)

		pylon.modes = data and data.modes or {} -- Pods, tanks, empty stations etc. have no modes
		pylon.count = info and count or 0


		if count > 0 then
			pylonName:set(data.name or "Har du lagt till nya vapen igen, Current?")
		else
			pylonName:set("") -- empty string when pylon is spent
		end
	end
end

--- Returns the priority of a `pylon`'s weapon in the given `mode` (lower = higher priority), (nil if the weapon doesn't support the `mode` given).
--- @param pylon table Entry of `pylonInfo` to get the weapon priority of.
--- @param mode integer wTypes mode to get the weapon's priority in.
--- @return integer|nil priority
local function getPriority(pylon, mode)
	for _, m in ipairs(pylon.modes) do
		if m[1] == mode then
			return m[2]
		end
	end

	return nil
end

--- Returns the selectable entries for the given `mode`, in the order they are cycled through.
--- Pylons with ammo that support the `mode` are sorted by priority, then pylon order.
--- In dogfight mode only the best pylon takes part, since the pilot toggles between the best IR-missile and the gun.
--- If `includeGun` is set, the gun (GUN_PYLON) is added last for the modes that have it in their cycle (A/A and dogfight).
--- @param mode integer wTypes mode to get the candidates for.
--- @param includeGun boolean Whether the gun should be part of the list.
--- @return table|nil candidates List of `{index = integer, prio = number}`.
local function getCandidates(mode, includeGun)
	local list = {}

	for i, name in ipairs(pylonOrder) do
		local pylon = pylonInfo[name]
		local prio = getPriority(pylon, mode)

		if prio and (pylon.count or 0) > 0 then
			list[#list+1] = {index = i - 1, prio = prio}
		end
	end

	table.sort(list, function (a, b)
		if a.prio ~= b.prio then
			return a.prio < b.prio
		end

		return a.index < b.index
	end)

	if mode == wTypes.dogfight then
		list = {list[1]} -- Only the best IR-missile (empty table if there is none)
	end

	if includeGun and (mode == wTypes.AA or mode == wTypes.dogfight) then
		list[#list+1] = {index = GUN_PYLON, prio = math.huge}
	end

	return list
end

--- Returns the next station index after `fromIndex` in the priority list for the given `mode`, wrapping around. Returns nil if nothing is available.
--- @param mode integer wTypes mode to get the next station for.
--- @param fromIndex integer The index to start the search from. `fromIndex` = -1 (or a station that doesn't support the `mode`) returns the top of the list.
--- @param includeGun boolean Whether the gun (GUN_PYLON) can be returned.
--- @return integer|nil
local function findNextPylon(mode, fromIndex, includeGun)
	local list = getCandidates(mode, includeGun)

	if #list == 0 then
		return nil
	end

	local fromName = pylonOrder[(fromIndex or -1) + 1]
	local fromPrio = fromName and getPriority(pylonInfo[fromName], mode)

	if not fromPrio then
		return list[1].index
	end

	for _, c in ipairs(list) do
		if c.prio > fromPrio or (c.prio == fromPrio and c.index > fromIndex) then
			return c.index
		end
	end

	return list[1].index
end

--- Selects the next weapon for the `mode`, or the gun (selectedStation = GUN_PYLON) if none is available.
--- @param mode integer wTypes value of the current weaponsMode
--- @param fromIndex integer Index to start search from
--- @param includeGun boolean Whether the gun can be selected as part of the cycle. The gun is always the fallback when nothing else is available.
local function selectFrom(mode, fromIndex, includeGun)
	local idx = findNextPylon(mode, fromIndex, includeGun)

	selectedStation = idx or GUN_PYLON
	selectedPylon:set(selectedStation)

	if selectedStation ~= GUN_PYLON then
		WS:select_station(selectedStation)
	end
end

--- Selects the correct mode when pressing a weapon mode select button.
--- @param newMaster integer The new primaryMode corresponding to the selected weapon mode.
--- @param newWeapons integer The new weaponsMode corresponing to the selected weapon mode.
local function selectMode(newMaster, newWeapons)
	local same = primaryMode:get() == newMaster and weaponsMode:get() == newWeapons -- Pressing the button of the mode we're already in cycles weapons, otherwise jump to the highest priority weapon.

	primaryMode:set(newMaster)
	weaponsMode:set(newWeapons)

	updatePylonInfo()
	selectFrom(newWeapons, same and selectedStation or -1, true)
end

--- Selects a pylon from `pylonOrder` with index `pylon`, changes primary and weapons mode accordingly.
--- @param pylon integer The pylon to select
local function selectPylon(pylon)
	updatePylonInfo()

	if pylonInfo[pylonOrder[pylon]].count > 0 then
		local mainWPNMode = pylonInfo[pylonOrder[pylon]].modes[1][1]

		primaryMode:set((mainWPNMode == 1 or mainWPNMode == 2) and 1 or 2)
		weaponsMode:set(mainWPNMode)

		selectedStation = pylon - 1
		selectedPylon:set(selectedStation)
		WS:select_station(selectedStation)
	end
end


function post_initialize()
	local birth = LockOn_Options.init_conditions.birth_place

	if birth == "GROUND_HOT" then
		WS:performClickableAction(deviceCommands.MASS, 0, false)
		WS:performClickableAction(deviceCommands.TriggerSafe, 0, true)
	elseif birth == "AIR_HOT" then
		WS:performClickableAction(deviceCommands.MASS, 0, false)
		WS:performClickableAction(deviceCommands.TriggerSafe, 0, true)
	elseif birth == "GROUND_COLD" then
		WS:performClickableAction(deviceCommands.MASS, -1, false)
		WS:performClickableAction(deviceCommands.TriggerSafe, 0, true)
	end


	for _, name in ipairs(pylonOrder) do
		pylonInfo[name] = {modes = {}, count = 0}
	end

	selectedPylon:set(selectedStation)

	updateAmmoCount()
	updatePylonInfo()
end

function update()
	if selectedStation > -1 then
		printButBetter("p: " .. (pylonOrder[selectedStation + 1] or "gun"), "selected pylon")
	end

	if get_param_handle("WS_IR_MISSILE_LOCK"):get() == 0 then
		get_param_handle("WS_IR_MISSILE_SEEKER_DESIRED_AZIMUTH"):set(-get_param_handle("RADAR_STT_AZIMUTH"):get())
		get_param_handle("WS_IR_MISSILE_SEEKER_DESIRED_ELEVATION"):set(get_param_handle("RADAR_STT_ELEVATION"):get())
	end

	if ASModeClock then
		ASModeClockTime = ASModeClockTime + updateTimeStep

		if ASModeClockTime >= AS_MODE_DELAY then
			ASModeClock = false
			ASModeClockTime = 0

			selectMode(2, wTypes.AS)
		end
	end


	if trigger and selectedStation == GUN_PYLON then updateAmmoCount() end
end

function SetCommand(command, value)
	local MASS = MASSCommands[command]

	if MASS then WS:performClickableAction(deviceCommands.MASS, MASS.value, false) end

	if command == deviceCommands.MASS then
		MASSState = value
		MASSParam:set(MASSState)
	end


	if command == keys.trigger then
		if value == 1 and not trigger then
			trigger = true

			if selectedStation == GUN_PYLON then
				gunFiring = true
				dispatch_action(nil, 84)
			elseif selectedStation >= 0 then
				local fired = selectedStation

				WS:launch_station(fired)
				updatePylonInfo()


				if (pylonInfo[pylonOrder[fired + 1]].count or 0) <= 0 then -- Only move on once the station is empty
					-- Dogfight goes back to the best IR-missile, other modes continue forward from the fired station.
					-- The gun is only selected here if no missile is left.
					local from = weaponsMode:get() == wTypes.dogfight and -1 or fired

					selectFrom(weaponsMode:get(), from, false)
				end
			end
			-- selectedStation == -1: nothing selected, trigger does nothing
		elseif value == 0 then
			trigger = false

			if gunFiring then
				gunFiring = false
				dispatch_action(nil, 85)
			end
		end
	end



	if command == 99990 then selectPylon(value) end -- A command 99990 comes from Displays.lua whenever a LD softkey button that selects a specific weapon.


	local mode = modeCommands[command]

	if mode and value == 1 then
		if command ~= keys.stickS5Down then
			ASModeClock = false -- Any other mode button cancels a pending A/S switch
			ASModeClockTime = 0
		end

		if command == keys.stickS5Down and weaponsMode:get() ~= wTypes.AS then
			ASModeClock = true -- Delay entering A/S so it isn't triggered by accident from A/A
		else
			selectMode(mode.primaryMode or 1, mode.weaponsMode)
		end
	elseif mode and value == 0 and command == keys.stickS5Down and ASModeClock == true then
		ASModeClock = false
		ASModeClockTime = 0
	end
end