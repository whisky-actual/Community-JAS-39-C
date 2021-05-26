dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."Terrain.lua")
dofile(LockOn_Options.script_path.."materials.lua") -- 加载材质
dofile(LockOn_Options.common_script_path.."KNEEBOARD/declare_kneeboard_device.lua")

-- set panel

mount_vfs_texture_archives("Bazar/Textures/AvionicsCommon")

attributes = {
	"support_for_cws",
}
---------------------------------------------
MainPanel = {"ccMainPanel",LockOn_Options.script_path.."mainpanel_init.lua"}

creators = {}

--creators[devices.ELECTRIC_SYSTEM] 	={"avSimpleElectricSystem"			,LockOn_Options.script_path.."Systems/electric_system.lua"}
--creators[devices.CANOPY] 			={"avLuaDevice"			,LockOn_Options.script_path.."Systems/canopy_system.lua"}
--creators[devices.UTILITIES] 		={"avLuaDevice"			,LockOn_Options.script_path.."Systems/utilites.lua"}
--creators[devices.ENGINE] 			={"avLuaDevice"			,LockOn_Options.script_path.."Systems/engine_system.lua"}
creators[devices.GRINNELLI_BRAKES] 	={"avLuaDevice"			,LockOn_Options.script_path.."Systems/Grinnelli_Brakes.lua"}
creators[devices.SLAT_SYSTEM]       ={"avLuaDevice"         ,LockOn_Options.script_path.."Systems/slat_system.lua"}
--creators[devices.CANARD_SYSTEM]       ={"avLuaDevice"         ,LockOn_Options.script_path.."Systems/canard_system.lua"}
----creators[devices.FLAP_SYSTEM]       ={"avLuaDevice"         ,LockOn_Options.script_path.."Systems/flap_system.lua"}
creators[devices.FCS_SYSTEM]        ={"avLuaDevice"         ,LockOn_Options.script_path.."Systems/fcs_system.lua"}
--creators[devices.SUPERSONIC_SYSTEM]        ={"avLuaDevice"         ,LockOn_Options.script_path.."Systems/supersonic_system.lua"}
-- creators[devices.FBW_SYSTEM]        ={"avLuaDevice"         ,LockOn_Options.script_path.."Systems/fbw_system.lua"}
-- creators[devices.FBW_SYSTEM_API]    ={"avLuaDevice"         ,LockOn_Options.script_path.."Systems/fbw_system_api.lua"}
-- creators[devices.GEAR_SYSTEM]     ={"avLuaDevice"          ,LockOn_Options.script_path.."Systems/gear_system.lua"}
--creators[devices.ADI]             	={"avLuaDevice"         ,LockOn_Options.script_path.."ADI/Device/device.lua"}
--creators[devices.UFC]             	={"avLuaDevice"         ,LockOn_Options.script_path.."UFC/Device/device.lua"}
--creators[devices.RADAR]				={"avSimpleRadar"			,LockOn_Options.script_path.."avRadar_example/Device/Radar_init.lua"}
--creators[devices.MISC_ELEC]			={"avSimpleElectricSystem",LockOn_Options.script_path.."avRWR_example/miscSystems/simple_electric_system.lua"}
--creators[devices.RWR]				={"avSimpleRWR"			,LockOn_Options.script_path.."avRWR_example/Device/RWR_init.lua"}
	

-- Indicators
indicators = {}
-- ADI
indicators[#indicators + 1] = {"ccIndicator", LockOn_Options.script_path.."ADI/Indicator/init.lua",--init script
 nil,
  {	
	{"ADI-CENTER","ADI-DOWN","ADI-RIGHT"}, -- initial geometry anchor , triple of connector names 
	{sx_l =  0,  -- center position correction in meters (forward , backward)
	 sy_l =  0,  -- center position correction in meters (up , down)
	 sz_l =  0,  -- center position correction in meters (left , right)
	 sh   =  0,  -- half height correction 
	 sw   =  0,  -- half width correction 
	 rz_l =  0,  -- rotation corrections  
	 rx_l =  0,
	 ry_l =  0}
  }
} 

indicators[#indicators + 1] = {"ccIndicator", LockOn_Options.script_path.."HUD/Indicator/init.lua",--init script
 nil,
  {	
	{"HUD-CENTER","HUD-DOWN","HUD-RIGHT"}, -- initial geometry anchor , triple of connector names 
	{sx_l =  0,  -- center position correction in meters (forward , backward)
	 sy_l =  0,  -- center position correction in meters (up , down)
	 sz_l =  0,  -- center position correction in meters (left , right)
	 sh   =  0,  -- half height correction 
	 sw   =  0,  -- half width correction 
	 rz_l =  0,  -- rotation corrections  
	 rx_l =  0,
	 ry_l =  0}
  }
} 
--UFC
indicators[#indicators + 1] = {"ccIndicator", LockOn_Options.script_path.."UFC/Indicator/init.lua",--init script
 nil,
  {	
	{"UFC-CENTER","UFC-DOWN","UFC-RIGHT"}, -- initial geometry anchor , triple of connector names 
	{sx_l =  0,  -- center position correction in meters (forward , backward)
	 sy_l =  0,  -- center position correction in meters (up , down)
	 sz_l =  0,  -- center position correction in meters (left , right)
	 sh   =  0,  -- half height correction 
	 sw   =  0,  -- half width correction 
	 rz_l =  0,  -- rotation corrections  
	 rx_l =  0,
	 ry_l =  0}
  }
} 

indicators[#indicators + 1] = {"ccIndicator", LockOn_Options.script_path.."avRadar_example/indicator/init.lua",--init script
 nil,
  {	
	{"RADAR-PLASHKA-CENTER","RADAR-PLASHKA-DOWN","RADAR-PLASHKA-RIGHT"}, -- initial geometry anchor , triple of connector names 
	{sx_l =  0,  -- center position correction in meters (forward , backward)
	 sy_l =  0,  -- center position correction in meters (up , down)
	 sz_l =  0,  -- center position correction in meters (left , right)
	 sh   =  0,  -- half height correction 
	 sw   =  0,  -- half width correction 
	 rz_l =  0,  -- rotation corrections  
	 rx_l =  0,
	 ry_l =  0}
  }
} 

indicators[#indicators + 1] = 	{
	"ccIndicator",
	LockOn_Options.script_path.."avRWR_example/indicator/init.lua",
	nil,
	{	
		{"TEWS-PLASHKA-CENTER","TEWS-PLASHKA-DOWN","TEWS-PLASHKA-RIGHT"},
		{
		sz_l = 0.0,sx_l = 0.0, sy_l =  0.0  -- -0.14	-- -0.3
		},
		1
	}
}			


attributes = {
	"support_for_cws",
}
---------------------------------------------
dofile(LockOn_Options.common_script_path.."KNEEBOARD/declare_kneeboard_device.lua")
---------------------------------------------
