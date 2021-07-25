dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.common_script_path.."tools.lua")
dofile(LockOn_Options.script_path.."materials.lua")

layoutGeometry = {}

-- set panel

layoutGeometry = {}

attributes = {
	"support_for_cws",
	"avNightVisionGoggles" 
}
---------------------------------------------
MainPanel = {"ccMainPanel",LockOn_Options.script_path.."mainpanel_init.lua"}		-- Crashes the AG version

creators = {}

--creators[devices.ELECTRIC_SYSTEM] 	={"avSimpleElectricSystem"			,LockOn_Options.script_path.."Systems/electric_system.lua"}
--creators[devices.CANOPY] 			={"avLuaDevice"			,LockOn_Options.script_path.."Systems/canopy_system.lua"}
--creators[devices.UTILITIES] 		={"avLuaDevice"			,LockOn_Options.script_path.."Systems/utilites.lua"}
--creators[devices.ENGINE] 			={"avLuaDevice"			,LockOn_Options.script_path.."Systems/engine_system.lua"}
creators[devices.Wheel_BRAKES] 	={"avLuaDevice"			,LockOn_Options.script_path.."Systems/Wheel_Brakes.lua"}
creators[devices.SLAT_SYSTEM]       ={"avLuaDevice"         ,LockOn_Options.script_path.."Systems/slat_system.lua"}
creators[devices.CANARD_SYSTEM]       ={"avLuaDevice"         ,LockOn_Options.script_path.."Systems/Canard_system.lua"}
----creators[devices.FLAP_SYSTEM]       ={"avLuaDevice"         ,LockOn_Options.script_path.."Systems/flap_system.lua"}
creators[devices.LIFT_DUMPING_SYSTEM]        ={"avLuaDevice"         ,LockOn_Options.script_path.."Systems/Lift_Dumping_system.lua"}
creators[devices.WHEEL_CHOCKS_LADDER]		 = {"avLuaDevice",LockOn_Options.script_path.."Systems/Wheel_chocks_ladder.lua"}
--creators[devices.SUPERSONIC_SYSTEM]        ={"avLuaDevice"         ,LockOn_Options.script_path.."Systems/supersonic_system.lua"}
-- creators[devices.FBW_SYSTEM]        ={"avLuaDevice"         ,LockOn_Options.script_path.."Systems/fbw_system.lua"}
-- creators[devices.FBW_SYSTEM_API]    ={"avLuaDevice"         ,LockOn_Options.script_path.."Systems/fbw_system_api.lua"}
-- creators[devices.GEAR_SYSTEM]     ={"avLuaDevice"          ,LockOn_Options.script_path.."Systems/gear_system.lua"}
--creators[devices.ADI]             	={"avLuaDevice"         ,LockOn_Options.script_path.."ADI/Device/device.lua"}
--creators[devices.UFC]             	={"avLuaDevice"         ,LockOn_Options.script_path.."UFC/Device/device.lua"}
--creators[devices.RADAR]				={"avSimpleRadar"			,LockOn_Options.script_path.."avRadar_example/Device/Radar_init.lua"}
--creators[devices.MISC_ELEC]			={"avSimpleElectricSystem",LockOn_Options.script_path.."avRWR_example/miscSystems/simple_electric_system.lua"}
--creators[devices.RWR]				={"avSimpleRWR"			,LockOn_Options.script_path.."avRWR_example/Device/RWR_init.lua"}
creators[devices.GEAR_BAYS]	  = {"avLuaDevice",LockOn_Options.script_path.."Systems/Gear_bays.lua"}
creators[devices.NVG]         = {"avNightVisionGoggles"  ,LockOn_Options.script_path.."HELMET/NVG.lua"                            ,{}}

creators[devices.MFD]        = {"avLuaDevice", LockOn_Options.script_path.."MFD/Device/MFD_init.lua"}	

-- Indicators
indicators = {}

indicators[#indicators + 1] = {"ccIndicator", LockOn_Options.script_path.."MFD/Indicator/LMFD_init.lua",	--init script
 nil, 
    {
		{"JAS39-LMFD-CENTER", "JAS39-LMFD-DOWN", "JAS39-LMFD-RIGHT"},	-- initial geometry anchor , triple of connector names. Note: not actually used atm, we adjust position manually
		{sx_l =  0,  -- center position correction in meters (+forward , -backward)
		 sy_l =  0,  -- center position correction in meters (+up , -down)
		 sz_l =  0,  -- center position correction in meters (-left , +right)
		 sh   =  0,  -- half height correction 
		 sw   =  0,  -- half width correction 
		 rz_l =  0,  -- rotation corrections  
		 rx_l =  0,
		 ry_l =  0}
	}	
}
--[[
indicators[#indicators + 1] = {"ccIndicator", LockOn_Options.script_path.."MFD/Indicator/RMFD_init.lua",	--init script
 nil, 
    {
		{"JAS39-CMFD-CENTER", "JAS39-CMFD-DOWN", "JAS39-CMFD-RIGHT"},	-- initial geometry anchor , triple of connector names. Note: not actually used atm, we adjust position manually
		{sx_l =  0,  -- center position correction in meters (+forward , -backward)
		 sy_l =  0,  -- center position correction in meters (+up , -down)
		 sz_l =  0,  -- center position correction in meters (-left , +right)
		 sh   =  0,  -- half height correction 
		 sw   =  0,  -- half width correction 
		 rz_l =  0,  -- rotation corrections  
		 rx_l =  0,
		 ry_l =  0}
	}	
}
-- }
--]]
---------------------------------------------
dofile(LockOn_Options.common_script_path.."KNEEBOARD/declare_kneeboard_device.lua")
---------------------------------------------
