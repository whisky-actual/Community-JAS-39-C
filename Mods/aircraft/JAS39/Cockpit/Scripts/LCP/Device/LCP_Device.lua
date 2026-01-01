dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path .. "devices.lua")
local update_time_step = 0.01 --update will be called 100 times per second
make_default_activity(update_time_step)
dev = GetSelf()
-------------------------------------------------------
-- Local Variables
-------------------------------------------------------
local sensor_data = get_base_data()

local LCPBrightness = get_param_handle("LCPBrightness")

dev:listen_command(keys.LCP_X)	      
dev:listen_command(keys.LCP_SYS)       
dev:listen_command(keys.LCP_TAC)       
dev:listen_command(keys.LCP_IFF)       
dev:listen_command(keys.LCP_COM)       
dev:listen_command(keys.LCP_SK01)      
dev:listen_command(keys.LCP_SK02)      
dev:listen_command(keys.LCP_SK03)      
dev:listen_command(keys.LCP_SK04)      
dev:listen_command(keys.LCP_SK05)      
dev:listen_command(keys.LCP_SK06)      
dev:listen_command(keys.LCP_SK07)      
dev:listen_command(keys.LCP_SK08)      
dev:listen_command(keys.LCP_SK09)      
dev:listen_command(keys.LCP_SK10)      
dev:listen_command(keys.LCP_SK11)      
dev:listen_command(keys.LCP_SK12)      
dev:listen_command(keys.LCP_SK13)      
dev:listen_command(keys.LCP_Brightness)
dev:listen_command(keys.LCP_Contrast)  
dev:listen_command(keys.LCP_1)         
dev:listen_command(keys.LCP_2)         
dev:listen_command(keys.LCP_3)         
dev:listen_command(keys.LCP_4)         
dev:listen_command(keys.LCP_5)         
dev:listen_command(keys.LCP_6)         
dev:listen_command(keys.LCP_7)         
dev:listen_command(keys.LCP_8)         
dev:listen_command(keys.LCP_9)         
dev:listen_command(keys.LCP_0)         
dev:listen_command(keys.LCP_ENT)       
dev:listen_command(keys.LCP_CLR)      

dev:listen_command(deviceCommands.LCP_X)	      
dev:listen_command(deviceCommands.LCP_SYS)       
dev:listen_command(deviceCommands.LCP_TAC)       
dev:listen_command(deviceCommands.LCP_IFF)       
dev:listen_command(deviceCommands.LCP_COM)       
dev:listen_command(deviceCommands.LCP_SK01)      
dev:listen_command(deviceCommands.LCP_SK02)      
dev:listen_command(deviceCommands.LCP_SK03)      
dev:listen_command(deviceCommands.LCP_SK04)      
dev:listen_command(deviceCommands.LCP_SK05)      
dev:listen_command(deviceCommands.LCP_SK06)      
dev:listen_command(deviceCommands.LCP_SK07)      
dev:listen_command(deviceCommands.LCP_SK08)      
dev:listen_command(deviceCommands.LCP_SK09)      
dev:listen_command(deviceCommands.LCP_SK10)      
dev:listen_command(deviceCommands.LCP_SK11)      
dev:listen_command(deviceCommands.LCP_SK12)      
dev:listen_command(deviceCommands.LCP_SK13)      
dev:listen_command(deviceCommands.LCP_Brightness)
dev:listen_command(deviceCommands.LCP_Contrast)  
dev:listen_command(deviceCommands.LCP_1)         
dev:listen_command(deviceCommands.LCP_2)         
dev:listen_command(deviceCommands.LCP_3)         
dev:listen_command(deviceCommands.LCP_4)         
dev:listen_command(deviceCommands.LCP_5)         
dev:listen_command(deviceCommands.LCP_6)         
dev:listen_command(deviceCommands.LCP_7)         
dev:listen_command(deviceCommands.LCP_8)         
dev:listen_command(deviceCommands.LCP_9)         
dev:listen_command(deviceCommands.LCP_0)         
dev:listen_command(deviceCommands.LCP_ENT)       
dev:listen_command(deviceCommands.LCP_CLR)    








function post_initialize()
	LCPBrightness:set(get_param_handle("LDBrightness"):get())
	-- dev:performClickableAction(deviceCommands.LCP_Brightness, get_param_handle("LDBrightness"):get(), true)

	get_param_handle("LCP_BRIGHTNESS"):set(1)
end

function SetCommand(command,value)

	if command == deviceCommands.LCP_Brightness then
		LCPBrightness:set(1 - value)
		--print_message_to_user(value)
	end
	
   
end 
need_to_be_closed = false