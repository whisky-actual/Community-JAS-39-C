dofile(LockOn_Options.script_path .. "command_defs.lua")
dofile(LockOn_Options.script_path .. "devices.lua")



local updateTimeStep = 1/60 --Refresh rate of device script.
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
--TODO add the following keybinds:
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


local menu = 0
local arrowRow = 0

local tempHMDBrightness = 0



function post_initialize()
	UCP:performClickableAction(deviceCommands.UCP_Brightness, get_param_handle("LD_BRIGHTNESS"):get(), true)



	UCPRow1:set("121750A ")
	UCPRow2:set("XXXXXXXX")
	UCPRow3:set("121500A ")
	UCPRow4:set("        ")
	UCPRow5:set("MASTR 10")
	UCPRow6:set("--------")



	tempHMDBrightness = desiredHMDBrightness:get()
end

function update()
	
end

function SetCommand(command, value)
	if command == deviceCommands.UCP_DAT and menu ~= 1 then
		menu = 1
		UCPRow1:set("HMD     ")
		UCPRow2:set(" BRIGHT ")
		UCPRow3:set(" DIM    ")
		UCPRow4:set("        ")
		UCPRow5:set("        ")
		UCPRow6:set("        ")

		addArrowToRow(UCPRow2)
		arrowRow = 2
	end

	if command == deviceCommands.UCP_Cursor then
		if menu == 1 then
			if arrowRow == 2 then
				removeArrowToRow(UCPRow2)
				addArrowToRow(UCPRow3)
				arrowRow = 3
			elseif arrowRow == 3 then
				removeArrowToRow(UCPRow3)
				addArrowToRow(UCPRow2)
				arrowRow = 2
			end
		end
	end

	if command == deviceCommands.UCP_AMFM_ENT then
		if menu == 1 then
			if arrowRow == 2 then
				if desiredHMDBrightness:get() == 0 then
					desiredHMDBrightness:set(0.125)
				else
					tempHMDBrightness = desiredHMDBrightness:get() * 2
					desiredHMDBrightness:set(tempHMDBrightness <= 1 and tempHMDBrightness or 1)
				end
			elseif arrowRow == 3 then
				tempHMDBrightness = desiredHMDBrightness:get() * 0.5
				desiredHMDBrightness:set(tempHMDBrightness >= 0.125 and tempHMDBrightness or 0)
			end
		end
	end

	if command == deviceCommands.UCP_MENU then
		menu = 0
		UCPRow1:set("121750A ")
		UCPRow2:set("XXXXXXXX")
		UCPRow3:set("121500A ")
		UCPRow4:set("        ")
		UCPRow5:set("MASTR 10")
		UCPRow6:set("--------")
	end

-------------------------------------------------------
--Test Functions
--print_message_to_user(command)
-------------------------------------------------------	
	if command == deviceCommands.UCP_L then
		dispatch_action(OP_PHASES, 10060)
	end

	if command == (deviceCommands.UCP_Brightness) then
		get_param_handle("UCP_BRIGHTNESS"):set(value)
		--print_message_to_user(value)

	end


end


function addArrowToRow(row)
	row:set("-" .. row:get().sub(row:get(), 2, 8))
	print_message_to_user(row:get().sub(row:get(), 2, 8))
end

function removeArrowToRow(row)
	row:set(" " .. row:get().sub(row:get(), 2, 8))
end



need_to_be_closed = false