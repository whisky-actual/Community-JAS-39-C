local self_ID = "JAS39Gripen"
declare_plugin(self_ID,
{
image     	 = "FC3.bmp",
installed 	 = true, -- if false that will be place holder , or advertising
dirName	  	 = current_mod_path,
displayName  = _("JAS39Gripen"),
developerName = _("Lion Eagle Simulations"),

fileMenuName = _("JAS39Gripen"),
update_id        = "JAS39Gripen",
version		 = "v1.5-Beta",
state		 = "installed",
info		 = _("The Saab JAS 39 Gripen is a light single-engine multirole fighter aircraft manufactured by the Swedish aerospace company Saab AB. The Gripen has a delta wing and canard configuration with relaxed stability design and fly-by-wire flight controls. Various versions have been built, grouped as A-, C- and E-series. Gripen A- and C-series are powered by the GE F404G engine (previously designated Volvo RM12) and the E-series is powered by the GE F414G engine, and has a top speed of Mach 2. Later aircraft are modified for NATO interoperability standards and to undertake air to air refuelling."),

Skins	=
	{
		{
		    name	= _("JAS39Gripen"),
			dir		= "Theme"
		},
	},
Missions =
	{
		{
			name		    = _("JAS39Gripen"),
			dir			    = "Missions",
  		},
	},
LogBook =
	{
		{
			name		= _("JAS39Gripen"),
			type		= "JAS39Gripen",
		},
		{
			name		= _("JAS39Gripen_AG"),
			type		= "JAS39Gripen_AG",
		},
	},	
		
InputProfiles =
	{
		["JAS39Gripen"] = current_mod_path .. '/Input/JAS39Gripen',
		["JAS39Gripen_AG"] = current_mod_path .. '/Input/JAS39Gripen_AG',
	},
	
})
----------------------------------------------------------------------------------------
mount_vfs_model_path	(current_mod_path.."/Shapes")
mount_vfs_model_path	(current_mod_path.."/Weapons/Shapes")
mount_vfs_model_path	(current_mod_path.."/Cockpit/Shapes")
mount_vfs_liveries_path (current_mod_path.."/Liveries")
mount_vfs_texture_path  (current_mod_path.."/Textures")
mount_vfs_texture_path  (current_mod_path.."/Cockpit/Textures/JAS39_Cockpit")
mount_vfs_texture_path  (current_mod_path.."/Textures/JAS39_Common")
mount_vfs_texture_path  (current_mod_path.."/Textures/JAS39_CAF")
mount_vfs_texture_path  (current_mod_path.."/Textures/JAS39_RSAF")
mount_vfs_texture_path  (current_mod_path.."/Textures/JAS39_Fictional")
mount_vfs_texture_path  (current_mod_path.."/Textures/JAS39_Operators")
mount_vfs_texture_path  (current_mod_path.."/Textures/JAS39_AA_Weapons")
mount_vfs_texture_path  (current_mod_path.."/Textures/JAS39_AG_Weapons")
mount_vfs_texture_path  (current_mod_path.."/Textures/JAS39_Cockpit")
----------------------------------------------------------------------------------------
dofile(current_mod_path.."/Views_JAS39Gripen.lua")
make_view_settings('JAS39Gripen', ViewSettings, SnapViews)
make_flyable('JAS39Gripen',current_mod_path..'/Cockpit/KneeboardRight/',{nil, old = 6}, current_mod_path..'/comm.lua')--SFM
make_flyable('JAS39Gripen',current_mod_path..'/Cockpit/Scripts/',{nil, old = 6}, current_mod_path..'/comm.lua')--SFM
-------------------------------------------------------------------------------------
dofile(current_mod_path.."/Views_JAS39Gripen_AG.lua")
make_view_settings('JAS39Gripen_AG', ViewSettings, SnapViews)
make_flyable('JAS39Gripen_AG',current_mod_path..'/Cockpit/KneeboardRight/',{nil, old = 54}, current_mod_path..'/comm.lua')--SFM
make_flyable('JAS39Gripen_AG',current_mod_path..'/Cockpit/Scripts/',{nil, old = 54}, current_mod_path..'/comm.lua')--SFM
-------------------------------------------------------------------------------------
dofile(current_mod_path..'/JAS39Gripen.lua')
dofile(current_mod_path..'/JAS39Gripen_AG.lua')
-------------------------------------------------------------------------------------
dofile(current_mod_path.."/Weapons/Loadout.lua")
-----------------------------------------------------------
local cfg_path =current_mod_path.."/FM/JAS39/config.lua"
dofile(cfg_path)
-------------------------------------------------------------------------------------
plugin_done()