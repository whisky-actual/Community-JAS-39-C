dofile(LockOn_Options.script_path .. "command_defs.lua")
dofile(LockOn_Options.script_path .. "devices.lua")
dofile(LockOn_Options.script_path .. "utils.lua")
dofile(LockOn_Options.script_path .. "Systems/Navigation.lua")



local updateTimeStep = 1 / 60 -- Refresh rate of device script.
make_default_activity(updateTimeStep)


local UCP = GetSelf()


UCP:listen_command(deviceCommands.UCP_MENU)
UCP:listen_command(deviceCommands.UCP_1)
UCP:listen_command(deviceCommands.UCP_2)
UCP:listen_command(deviceCommands.UCP_3)
UCP:listen_command(deviceCommands.UCP_DAT)
UCP:listen_command(deviceCommands.UCP_SHIFT)
UCP:listen_command(deviceCommands.UCP_4)
UCP:listen_command(deviceCommands.UCP_5)
UCP:listen_command(deviceCommands.UCP_6)
UCP:listen_command(deviceCommands.UCP_0)
UCP:listen_command(deviceCommands.UCP_AMFM_ENT)
UCP:listen_command(deviceCommands.UCP_7)
UCP:listen_command(deviceCommands.UCP_8)
UCP:listen_command(deviceCommands.UCP_9)
UCP:listen_command(deviceCommands.UCP_L)
UCP:listen_command(deviceCommands.UCP_CLR)
UCP:listen_command(deviceCommands.UCP_Brightness)
UCP:listen_command(deviceCommands.UCP_Cursor)
-- TODO add the following keybinds:
UCP:listen_command(keys.UCP_MENU)
UCP:listen_command(keys.UCP_1)
UCP:listen_command(keys.UCP_2)
UCP:listen_command(keys.UCP_3)
UCP:listen_command(keys.UCP_DAT)
UCP:listen_command(keys.UCP_SHIFT)
UCP:listen_command(keys.UCP_4)
UCP:listen_command(keys.UCP_5)
UCP:listen_command(keys.UCP_6)
UCP:listen_command(keys.UCP_0)
UCP:listen_command(keys.UCP_AMFM_ENT)
UCP:listen_command(keys.UCP_7)
UCP:listen_command(keys.UCP_8)
UCP:listen_command(keys.UCP_9)
UCP:listen_command(keys.UCP_L)
UCP:listen_command(keys.UCP_CLR)
UCP:listen_command(keys.UCP_Brightness)


local UCPRow1 = get_param_handle("UCPRow1")
local UCPRow2 = get_param_handle("UCPRow2")
local UCPRow3 = get_param_handle("UCPRow3")
local UCPRow4 = get_param_handle("UCPRow4")
local UCPRow5 = get_param_handle("UCPRow5")
local UCPRow6 = get_param_handle("UCPRow6")

local desiredHMDBrightness = get_param_handle("desiredHMDBrightness")


local loopStart = 0

local menu = 0 -- 0: Nothing, -1: Status info, 1: MENU, 2: MISSION, 3: DAT
local carretRow = 0

local UCPRows = {}
local carretAvail = {}

local prevCursVal = 0

local scrollableUp = false
local scrollableDown = false
local scroll = 0

local changeWPType = {}
local changeWPTypeCounter = 0



function post_initialize()
	get_param_handle("UCPBrightness"):set(get_param_handle("LDBrightness"):get())
	get_param_handle("UCP_BRIGHTNESS"):set(1)



	menu = -1
end

function update()
	if menu == -1 then
		UCPRows[1] = "121500F "
		UCPRows[2] = "42{    U"
		UCPRows[3] = "--------"
		UCPRows[4] = "G       "
		UCPRows[5] = "        "
		UCPRows[6] = get_param_handle("nextWPName"):get() .. "      "

		carretAvail = {}
		scrollableUp = false
		scrollableDown = false
	elseif menu == 0 then
		for i = 1, 6 do UCPRows[i] = "        " end

		carretAvail = {}
		scrollableUp = false
		scrollableDown = false
	elseif menu == 1 then
		UCPRows[1] = "  MENU  "
		UCPRows[2] = " COM    "
		UCPRows[3] = " MISSION"
		UCPRows[4] = " WEAPONS"
		UCPRows[5] = " EWS    "
		UCPRows[6] = "        "

		carretAvail = {2, 3, 4, 5}
		scrollableUp = false
		scrollableDown = false
	elseif menu == 2 then
		if scroll == 0 then
			UCPRows[1 - scroll] = "MISSION "
		end

		carretAvail = {}

		for i = 1, #get_mission_route() or 39 do
			local j = i + 1 - scroll
			if next(changeWPType) ~= nil and j == carretRow and math.floor(changeWPTypeCounter * 2) % 2 == 0 then
				UCPRows[j] = "        "
			else
				UCPRows[j] = " " .. waypoints[i].name:get()
			end
			if j < 7 then
				table.insert(carretAvail, j)
			end
		end

		if get_param_handle("numOfWP"):get() >= 6 + scroll then
			scrollableDown = true
		else
			scrollableDown = false
		end

		if UCPRows[2] ~= " " .. waypoints[1].name:get() then
			scrollableUp = true
		else
			scrollableUp = false
		end
	elseif menu == 3 then
		UCPRows[1] = "HMD     "
		UCPRows[2] = " BRIGHT "
		UCPRows[3] = " DIM    "
		UCPRows[4] = "        "
		UCPRows[5] = "        "
		UCPRows[6] = "        "

		carretAvail = {2, 3}
		scrollableUp = false
		scrollableDown = false
	end

	updateCarret()

	if next(changeWPType) ~= nil then
		if changeWPType[3] ~= carretRow then
			waypoints[changeWPType[1]].type:set(changeWPType[4])
			changeWPTypeCounter = 0
			changeWPType = {}
		else
			if changeWPTypeCounter >= 5 then
				changeWPTypeCounter = 0
				changeWPType = {}
			else
				changeWPTypeCounter = changeWPTypeCounter + updateTimeStep
			end
		end
	end

	UCPRow1:set(UCPRows[1])
	UCPRow2:set(UCPRows[2])
	UCPRow3:set(UCPRows[3])
	UCPRow4:set(UCPRows[4])
	UCPRow5:set(UCPRows[5])
	UCPRow6:set(UCPRows[6])


	-- printButBetter("cR: " .. carretRow, "cR")
	-- printButBetter("cA[1]: " .. carretAvail[1], "cA[1]")
	-- for k,v in ipairs(carretAvail) do
	--     printButBetter(k.." = "..v, "cA" .. k)
	-- end
	-- printButBetter("sD: " .. tostring(scrollableDown), "sD")
end

function SetCommand(command, value)
	if get_param_handle("mainpower"):get() == 1 then
		if command == deviceCommands.UCP_Cursor then
			if value > prevCursVal then
				if scrollableUp and carretRow == carretAvail[1] then
					scroll = scroll - 1

					if menu == 2 then
						carretRow = 2
					end
				else
					carretRow = wrapValue(carretAvail[1], carretAvail[#carretAvail] + 1, carretRow - 1)
				end
			else
				if scrollableDown and carretRow == 6 then
					scroll = scroll + 1
				else
					carretRow = wrapValue(carretAvail[1] - 1, carretAvail[#carretAvail], carretRow + 1)
				end
			end
			prevCursVal = value
		end


		if command == deviceCommands.UCP_MENU then
			if menu ~= 1 then
				menu = 1
				carretRow = 2
			else
				menu = -1
			end
		end

		if command == deviceCommands.UCP_AMFM_ENT then
			if menu == 1 then
				if carretRow == 2 or (carretRow > 3 and carretRow <= 5) then
					menu = 0
				elseif carretRow == 3 then
					menu = 2
					carretRow = 2
				end
			elseif menu == 2 then
				if next(changeWPType) ~= nil then
					changeWPTypeCounter = 5
				end
			elseif menu == 3 then
				if carretRow == 2 then
					desiredHMDBrightness:set(1)
				else
					desiredHMDBrightness:set(.0625)
				end
			end
		end

		if command == deviceCommands.UCP_2 or command == keys.UCP_2 then
			if menu ~= 2 then
				if get_param_handle("nextWPType"):get() == 3 then
					loopStart = get_param_handle("selectedWP"):get()
				else
					loopStart = get_param_handle("selectedWP"):get() + 1
				end

				changeWP(2, loopStart)
			else
				changeWPType = {carretRow - 1 + scroll, 2, carretRow, waypoints[carretRow - 1 + scroll].type:get()}
				waypoints[changeWPType[1]].type:set(changeWPType[2])
			end
		end

		if command == deviceCommands.UCP_5 or command == keys.UCP_5 then
			if menu ~= 2 then
				if get_param_handle("nextWPType"):get() == 3 then
					loopStart = get_param_handle("selectedWP"):get()
				else
					loopStart = get_param_handle("selectedWP"):get() + 1
				end

				changeWP(1, loopStart)
			else
				changeWPType = {carretRow - 1 + scroll, 1, carretRow, waypoints[carretRow - 1 + scroll].type:get()}
				waypoints[changeWPType[1]].type:set(changeWPType[2])
			end
		end

		if command == deviceCommands.UCP_L or command == keys.UCP_L then
			if menu ~= 2 then
				changeWP(3)
			else
				changeWPType = {carretRow - 1 + scroll, 3, carretRow, waypoints[carretRow - 1 + scroll].type:get()}
				waypoints[changeWPType[1]].type:set(changeWPType[2])
			end
		end

		if command == deviceCommands.UCP_DAT then
			menu = menu ~= 3 and 3 or -1

			carretRow = 2
		end
	end



	if command == deviceCommands.UCP_Brightness then
		get_param_handle("UCPBrightness"):set(1 - value)
	end
end


function changeWP(WPType, startIndex)
	local num = get_param_handle("numOfWP"):get()
	if num == 0 then return end

	for k = 0, num - 1 do
		local i = (((startIndex or (get_param_handle("selectedWP"):get() % num) + 1) - 1 + k) % num) + 1
		if get_param_handle("WP_" .. i .. "_type"):get() == WPType then
			get_param_handle("selectedWP"):set(i)
			return
		end
	end
end


function updateCarret()
	for i, el in ipairs(UCPRows) do
		if tableContains(carretAvail, i) and carretRow == i then
			UCPRows[i] = "}" .. string.sub(el, 2, 8)
		elseif string.sub(el, 1, 2) == "}" then
			UCPRows[i] = " " .. string.sub(el, 2, 8)
		end
	end
end



need_to_be_closed = false