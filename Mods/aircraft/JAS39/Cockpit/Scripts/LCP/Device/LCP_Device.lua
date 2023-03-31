dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path .. "devices.lua")
local update_time_step = 0.01 --update will be called 100 times per second
make_default_activity(update_time_step)
dev = GetSelf()
-------------------------------------------------------
-- Local Variables
-------------------------------------------------------
local sensor_data = get_base_data()

local LCP_Brightness = get_param_handle("LCP_BRIGHTNESS")

dev:listen_command(Keys.LCP_X)	      
dev:listen_command(Keys.LCP_SYS)       
dev:listen_command(Keys.LCP_TAC)       
dev:listen_command(Keys.LCP_IFF)       
dev:listen_command(Keys.LCP_COM)       
dev:listen_command(Keys.LCP_SK01)      
dev:listen_command(Keys.LCP_SK02)      
dev:listen_command(Keys.LCP_SK03)      
dev:listen_command(Keys.LCP_SK04)      
dev:listen_command(Keys.LCP_SK05)      
dev:listen_command(Keys.LCP_SK06)      
dev:listen_command(Keys.LCP_SK07)      
dev:listen_command(Keys.LCP_SK08)      
dev:listen_command(Keys.LCP_SK09)      
dev:listen_command(Keys.LCP_SK10)      
dev:listen_command(Keys.LCP_SK11)      
dev:listen_command(Keys.LCP_SK12)      
dev:listen_command(Keys.LCP_SK13)      
dev:listen_command(Keys.LCP_Brightness)
dev:listen_command(Keys.LCP_Contrast)  
dev:listen_command(Keys.LCP_1)         
dev:listen_command(Keys.LCP_2)         
dev:listen_command(Keys.LCP_3)         
dev:listen_command(Keys.LCP_4)         
dev:listen_command(Keys.LCP_5)         
dev:listen_command(Keys.LCP_6)         
dev:listen_command(Keys.LCP_7)         
dev:listen_command(Keys.LCP_8)         
dev:listen_command(Keys.LCP_9)         
dev:listen_command(Keys.LCP_0)         
dev:listen_command(Keys.LCP_ENT)       
dev:listen_command(Keys.LCP_CLR)      

dev:listen_command(device_commands.LCP_X)	      
dev:listen_command(device_commands.LCP_SYS)       
dev:listen_command(device_commands.LCP_TAC)       
dev:listen_command(device_commands.LCP_IFF)       
dev:listen_command(device_commands.LCP_COM)       
dev:listen_command(device_commands.LCP_SK01)      
dev:listen_command(device_commands.LCP_SK02)      
dev:listen_command(device_commands.LCP_SK03)      
dev:listen_command(device_commands.LCP_SK04)      
dev:listen_command(device_commands.LCP_SK05)      
dev:listen_command(device_commands.LCP_SK06)      
dev:listen_command(device_commands.LCP_SK07)      
dev:listen_command(device_commands.LCP_SK08)      
dev:listen_command(device_commands.LCP_SK09)      
dev:listen_command(device_commands.LCP_SK10)      
dev:listen_command(device_commands.LCP_SK11)      
dev:listen_command(device_commands.LCP_SK12)      
dev:listen_command(device_commands.LCP_SK13)      
dev:listen_command(device_commands.LCP_Brightness)
dev:listen_command(device_commands.LCP_Contrast)  
dev:listen_command(device_commands.LCP_1)         
dev:listen_command(device_commands.LCP_2)         
dev:listen_command(device_commands.LCP_3)         
dev:listen_command(device_commands.LCP_4)         
dev:listen_command(device_commands.LCP_5)         
dev:listen_command(device_commands.LCP_6)         
dev:listen_command(device_commands.LCP_7)         
dev:listen_command(device_commands.LCP_8)         
dev:listen_command(device_commands.LCP_9)         
dev:listen_command(device_commands.LCP_0)         
dev:listen_command(device_commands.LCP_ENT)       
dev:listen_command(device_commands.LCP_CLR)    








function post_initialize()
	dev:performClickableAction(device_commands.LCP_Brightness, get_param_handle("LD_BRIGHTNESS"):get(), true)
end

function SetCommand(command,value)

	if command == device_commands.LCP_Brightness then
		LCP_Brightness:set(value)
		--print_message_to_user(value)
	end
	
   
end 
need_to_be_closed = false