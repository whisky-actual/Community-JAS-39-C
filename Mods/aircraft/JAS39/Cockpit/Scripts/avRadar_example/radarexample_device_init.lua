-- put this line into your device_init.lua
-- dofile(LockOn_Options.script_path.."avRadar_example/radarexample_device_init.lua")

--[[
in the part where you define your AC, you need to specify the radar:


Sensors = {
		RADAR = "N-019", -- Radar type
		--RADAR = "AN/APQ-159",
		},

]]
--





dofile(LockOn_Options.script_path .. "devices.lua")



creators[devices.radar] = {"avSimpleRadar", LockOn_Options.script_path .. "avRadar_example/Device/Radar_init.lua"}


-- indicators[#indicators+1] = {"ccIndicator", LockOn_Options.script_path .. "avRadar_example/indicator/init.lua", nil,
-- 	{
-- 		{"JAS39-RMFD-CENTER", "JAS39-RMFD-DOWN", "JAS39-RMFD-RIGHT"},
-- 		{
-- 			sx_l =  0,  -- center position correction in meters (+forward , -backward)
-- 			sy_l =  -0.035,  -- center position correction in meters (+up , -down)
-- 			sz_l =  0,  -- center position correction in meters (-left , +right)
-- 			sh   =  0,  -- half height correction 
-- 			sw   =  0,  -- half width correction 
-- 			rz_l =  0,  -- rotation corrections  
-- 			rx_l =  0,
-- 			ry_l =  0
-- 		}
-- 			--sz_l = 0.19, sx_l = -0.35, sy_l = -0.35 -- -0.14	-- -0.3
-- 	},
-- }