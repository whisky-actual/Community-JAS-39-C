dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.common_script_path.."tools.lua")
dofile(LockOn_Options.script_path.."materials.lua")

-- set panel

layoutGeometry = {}

attributes = {
	"support_for_cws",
	"avNightVisionGoggles" 
}
---------------------------------------------
MainPanel = {"ccMainPanel",LockOn_Options.script_path.."mainpanel_init.lua"}

creators = {}

-- creators[devices.ELECTRIC_SYSTEM]	= {"avSimpleElectricSystem"}
-- creators[devices.WEAPONS]			= {"avSimpleWeaponSystem"}  ,LockOn_Options.script_path.."Systems/Weapons.lua"}
creators[devices.OP_PHASES] 			= {"avLuaDevice"			,LockOn_Options.script_path.."Systems/Op_Phases.lua"}
creators[devices.WHEEL_BRAKES] 			= {"avLuaDevice"			,LockOn_Options.script_path.."Systems/Wheel_Brakes.lua"}
creators[devices.ACCESSORIES] 			= {"avLuaDevice"			,LockOn_Options.script_path.."Systems/Accessories.lua"}
creators[devices.GEAR]	  				= {"avLuaDevice"		,LockOn_Options.script_path.."Systems/Gear.lua"}
creators[devices.ENGINE] 				= {"avLuaDevice"			,LockOn_Options.script_path.."Systems/Engine.lua"}
creators[devices.NVG]         			= {"avNightVisionGoggles"  ,LockOn_Options.script_path.."HELMET/NVG.lua"}                          
creators[devices.AIRBRAKES] 			= {"avLuaDevice"			,LockOn_Options.script_path.."Systems/Airbrakes.lua"}
creators[devices.LEF]       			= {"avLuaDevice"         ,LockOn_Options.script_path.."Systems/LEF.lua"}
creators[devices.ELEVONS]   		    = {"avLuaDevice"         ,LockOn_Options.script_path.."Systems/Elevons.lua"}
creators[devices.RUDDER]	  			= {"avLuaDevice"		,LockOn_Options.script_path.."Systems/Rudder.lua"}
creators[devices.CANARDS]      			= {"avLuaDevice"         ,LockOn_Options.script_path.."Systems/Canards.lua"}
creators[devices.FLYBYWIRE]      		= {"avLuaDevice"         ,LockOn_Options.script_path.."Systems/Flybywire.lua"}
creators[devices.AUTOTHROTTLE]     		= {"avLuaDevice"         ,LockOn_Options.script_path.."Systems/Autothrottle.lua"}
creators[devices.WEAPONS]     			= {"avLuaDevice"         ,LockOn_Options.script_path.."Systems/Weapons.lua"}  
creators[devices.CANOPY]     			= {"avLuaDevice"         ,LockOn_Options.script_path.."Systems/Canopy.lua"}
creators[devices.LIGHTS]     			= {"avLuaDevice"         ,LockOn_Options.script_path.."Systems/Lights.lua"}
creators[devices.DISPLAYS]     		    = {"avLuaDevice"         ,LockOn_Options.script_path.."Systems/Displays.lua"}
creators[devices.MFD]        			= {"avLuaDevice"		,LockOn_Options.script_path.."MFD/Device/MFD_Device.lua"}	
creators[devices.HUD]        			= {"avLuaDevice"		,LockOn_Options.script_path.."HUD/Device/HUD Device.lua"}	
creators[devices.COUNTERMEASURES]       = {"avLuaDevice"         ,LockOn_Options.script_path.."Systems/Countermeasures.lua"}
creators[devices.STORES]       			= {"avLuaDevice"         ,LockOn_Options.script_path.."Systems/Stores.lua"}
creators[devices.FUEL]     		   		= {"avLuaDevice"         ,LockOn_Options.script_path.."Systems/Fuel.lua"}	-- Needs to be after STORES in order for it to work
creators[devices.NAVIGATION]       		= {"avLuaDevice"         ,LockOn_Options.script_path.."Systems/Navigation.lua"}




-- Indicators
indicators = {}

indicators[#indicators + 1] = {"ccIndicator", LockOn_Options.script_path.."MFD/Indicator/LMFD_init.lua",	--init script
 nil, 
    {
		{"JAS39-LMFD-CENTER", "JAS39-LMFD-DOWN", "JAS39-LMFD-RIGHT"},	-- initial geometry anchor , triple of connector names.
		{sx_l =  0.0000,  -- center position correction in meters (+forward , -backward)
		 sy_l =  0,  -- center position correction in meters (+up , -down)
		 sz_l =  0,  -- center position correction in meters (-left , +right)
		 sh   =  0,  -- half height correction 
		 sw   =  0,  -- half width correction 
		 rz_l =  0,  -- rotation corrections  z
		 rx_l =  0,	 -- rotation corrections  x
		 ry_l =  0}	 -- rotation corrections  y
	}	
}



indicators[#indicators + 1] = {"ccIndicator", LockOn_Options.script_path.."MFD/Indicator/RMFD_init.lua",	--init script
 nil, 
    {
		{"JAS39-RMFD-CENTER", "JAS39-RMFD-DOWN", "JAS39-RMFD-RIGHT"},	-- initial geometry anchor , triple of connector names. 
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


indicators[#indicators + 1] = {"ccIndicator", LockOn_Options.script_path.."MFD/Indicator/CMFD_init.lua",	--init script
 nil, 
    {
		{"JAS39-CMFD-CENTER", "JAS39-CMFD-DOWN", "JAS39-CMFD-RIGHT"},	-- initial geometry anchor , triple of connector names. 
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

indicators[#indicators + 1] = {"ccIndicator", LockOn_Options.script_path.."HUD/Indicator/HUD_init.lua",	--init script
 nil, 
    {
		{"JAS39-HUD-CENTER", "JAS39-HUD-DOWN", "JAS39-HUD-RIGHT"},	-- initial geometry anchor , triple of connector names. 
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


---------------------------------------------
dofile(LockOn_Options.common_script_path.."KNEEBOARD/declare_kneeboard_device.lua")
---------------------------------------------
