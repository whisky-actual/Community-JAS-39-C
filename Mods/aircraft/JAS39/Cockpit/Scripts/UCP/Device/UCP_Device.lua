dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."devices.lua")

local update_time_step = 1/60
make_default_activity(update_time_step)
local dev = GetSelf()

--Clickables:
dev:listen_command(device_commands.UCP_MENU)
dev:listen_command(device_commands.UCP_1)
dev:listen_command(device_commands.UCP_2)
dev:listen_command(device_commands.UCP_3)
dev:listen_command(device_commands.UCP_DAT)
dev:listen_command(device_commands.UCP_SHIFT)
dev:listen_command(device_commands.UCP_4)
dev:listen_command(device_commands.UCP_5)
dev:listen_command(device_commands.UCP_6)
dev:listen_command(device_commands.UCP_0)
dev:listen_command(device_commands.UCP_AMFM_ENT)
dev:listen_command(device_commands.UCP_7)
dev:listen_command(device_commands.UCP_8)
dev:listen_command(device_commands.UCP_9)
dev:listen_command(device_commands.UCP_L)
dev:listen_command(device_commands.UCP_CLR)
dev:listen_command(device_commands.UCP_Brightness)
--TODO add the following keybinds:
dev:listen_command(Keys.UCP_MENU)
dev:listen_command(Keys.UCP_1)
dev:listen_command(Keys.UCP_2)
dev:listen_command(Keys.UCP_3)
dev:listen_command(Keys.UCP_DAT)
dev:listen_command(Keys.UCP_SHIFT)
dev:listen_command(Keys.UCP_4)
dev:listen_command(Keys.UCP_5)
dev:listen_command(Keys.UCP_6)
dev:listen_command(Keys.UCP_0)
dev:listen_command(Keys.UCP_AMFM_ENT)
dev:listen_command(Keys.UCP_7)
dev:listen_command(Keys.UCP_8)
dev:listen_command(Keys.UCP_9)
dev:listen_command(Keys.UCP_L)
dev:listen_command(Keys.UCP_CLR)
dev:listen_command(Keys.UCP_Brightness)


function post_initialize()
	--get_param_handle("UCP_BRIGHTNESS"):set(get_param_handle("LD_BRIGHTNESS"):get())
	
	dev:performClickableAction(device_commands.UCP_Brightness, get_param_handle("LD_BRIGHTNESS"):get(), true)



	get_param_handle("UCP_ROW1"):set("121750A")
	get_param_handle("UCP_ROW2"):set("XXXXXXXX")
	get_param_handle("UCP_ROW3"):set("121500A")
	get_param_handle("UCP_ROW4"):set(" ")
	get_param_handle("UCP_ROW5"):set("MASTR 10")








end



function SetCommand(command,value) -- Post initialize gets called once on mission start. SetCommand gets called when ever there is a button clicked
-------------------------------------------------------
--Test Functions
--print_message_to_user(command)
-------------------------------------------------------	
	if command == device_commands.UCP_L then
		dispatch_action(OP_PHASES, 10060)
	end

	if command == (device_commands.UCP_Brightness) then
		get_param_handle("UCP_BRIGHTNESS"):set(value)
		--print_message_to_user(value)

	end


end

need_to_be_closed = false