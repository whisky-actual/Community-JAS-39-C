self_ID = "VSN_JAS39Gripen"
declare_plugin(self_ID,
{
image     	 = "FC3.bmp",
installed 	 = true, -- if false that will be place holder , or advertising
dirName	  	 = current_mod_path,
displayName  = _("VSN_JAS39Gripen"),
developerName = _("VSN"),

fileMenuName = _("VSN_JAS39Gripen"),
update_id        = "VSN_JAS39Gripen",
version		 = "2.5.6",
state		 = "installed",
info		 = _("Die Saab JAS 39 Gripen der Greif ist ein schwedisches Mehrzweckkampfflugzeug und die Nachfolgeentwicklung der Saab JA 37 Viggen. Die bei der schwedischen Luftwaffe Flygvapnet verwendete Bezeichnung JAS steht fuer Jakt, Attack och Spaning, das heisst woertlich Jagd, Angriff und Aufklaerung. Die Prototypen flogen ab 1988 und die aktuelle Version JAS 39C D steht seit 2005 bei der schwedischen Luftwaffe im Einsatz. Neben ihrem Einsatz bei der Flygvapnet befindet sich die Gripen auch bei den Luftstreitkraeften weiterer Staaten im Einsatz."),

Skins	=
	{
		{
		    name	= _("VSN_JAS39Gripen"),
			dir		= "Theme"
		},
	},
Missions =
	{
		{
			name		    = _("VSN_JAS39Gripen"),
			dir			    = "Missions",
  		},
	},
LogBook =
	{
		{
			name		= _("VSN_JAS39Gripen"),
			type		= "VSN_JAS39Gripen",
		},
		{
			name		= _("VSN_JAS39Gripen_AG"),
			type		= "VSN_JAS39Gripen_AG",
		},
	},	
		
InputProfiles =
	{
		["VSN_JAS39Gripen"] = current_mod_path .. '/Input/VSN_JAS39Gripen',
		["VSN_JAS39Gripen_AG"] = current_mod_path .. '/Input/VSN_JAS39Gripen_AG',
	},
binaries 	 =
{
'F15',
},	
	
})
----------------------------------------------------------------------------------------
mount_vfs_model_path	(current_mod_path.."/Shapes")
mount_vfs_liveries_path (current_mod_path.."/Liveries")
mount_vfs_texture_path  (current_mod_path.."/Textures/VSN_JAS39Gripen")
mount_vfs_texture_path  (current_mod_path.."/Textures/DEVRiM_DCS_SU-27_EnglishGrayCockpitMod")
----------------------------------------------------------------------------------------
local cfg_path = current_mod_path ..  "/FM/F15/config.lua"
dofile(cfg_path)
F15FM[1] 				= self_ID
F15FM[2] 				= 'F15'
F15FM.config_path 		= cfg_path
F15FM.old 				= 3
dofile(current_mod_path.."/LUA/Views_SU27Pit.lua")
make_view_settings('VSN_JAS39Gripen', ViewSettings, SnapViews)
make_flyable('VSN_JAS39Gripen',current_mod_path..'/Cockpit/KneeboardRight/',F15FM, current_mod_path..'/Comm.lua')--AFM
-------------------------------------------------------------------------------------
local cfg_path = current_mod_path ..  "/FM/F15/config.lua"
dofile(cfg_path)
F15FM[1] 				= self_ID
F15FM[2] 				= 'F15'
F15FM.config_path 		= cfg_path
F15FM.old 				= 54
dofile(current_mod_path.."/LUA/Views_SU27Pit.lua")
make_view_settings('VSN_JAS39Gripen_AG', ViewSettings, SnapViews)
make_flyable('VSN_JAS39Gripen_AG',current_mod_path..'/Cockpit/KneeboardRight/',F15FM, current_mod_path..'/Comm.lua')--AFM
-------------------------------------------------------------------------------------
dofile(current_mod_path..'/VSN_JAS39Gripen.lua')
dofile(current_mod_path..'/VSN_JAS39Gripen_AG.lua')
-------------------------------------------------------------------------------------
plugin_done()
