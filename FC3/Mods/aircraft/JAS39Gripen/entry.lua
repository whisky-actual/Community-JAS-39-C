self_ID = "JAS39Gripen"
declare_plugin(self_ID,
{
image     	 = "FC3.bmp",
installed 	 = true, -- if false that will be place holder , or advertising
dirName	  	 = current_mod_path,
displayName  = _("JAS39Gripen"),
developerName = _("Placeholder"),

fileMenuName = _("JAS39Gripen"),
update_id        = "JAS39Gripen",
version		 = "2.5.6",
state		 = "installed",
info		 = _("Die Saab JAS 39 Gripen der Greif ist ein schwedisches Mehrzweckkampfflugzeug und die Nachfolgeentwicklung der Saab JA 37 Viggen. Die bei der schwedischen Luftwaffe Flygvapnet verwendete Bezeichnung JAS steht fuer Jakt, Attack och Spaning, das heisst woertlich Jagd, Angriff und Aufklaerung. Die Prototypen flogen ab 1988 und die aktuelle Version JAS 39C D steht seit 2005 bei der schwedischen Luftwaffe im Einsatz. Neben ihrem Einsatz bei der Flygvapnet befindet sich die Gripen auch bei den Luftstreitkraeften weiterer Staaten im Einsatz."),

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
mount_vfs_liveries_path (current_mod_path.."/Liveries")
mount_vfs_texture_path  (current_mod_path.."/Textures/JAS39Gripen")
mount_vfs_texture_path  (current_mod_path.."/Textures/Weapon_textures")
mount_vfs_texture_path  (current_mod_path.."/Textures/Cockpit_textures")
----------------------------------------------------------------------------------------
dofile(current_mod_path.."/Views_JAS39Gripen.lua")
make_view_settings('JAS39Gripen', ViewSettings, SnapViews)
make_flyable('JAS39Gripen',current_mod_path..'/Cockpit/KneeboardRight/',{nil, old = 6}, current_mod_path..'/comm.lua')--SFM
-------------------------------------------------------------------------------------
dofile(current_mod_path.."/Views_JAS39Gripen_AG.lua")
make_view_settings('JAS39Gripen_AG', ViewSettings, SnapViews)
make_flyable('JAS39Gripen_AG',current_mod_path..'/Cockpit/KneeboardRight/',{nil, old = 54}, current_mod_path..'/comm.lua')--SFM
-------------------------------------------------------------------------------------
dofile(current_mod_path..'/JAS39Gripen.lua')
dofile(current_mod_path..'/JAS39Gripen_AG.lua')
-------------------------------------------------------------------------------------
dofile(current_mod_path.."/Weapons/Loadout.lua")

-------------------------------------------------------------------------------------
--dofile(current_mod_path.."/Cockpit/Scripts/Hud_size.lua")

plugin_done()
