self_ID = "JAS-39-C Gripen"
declare_plugin(self_ID,
{
image     	 = "FC3.bmp",
installed 	 = true, -- if false that will be place holder , or advertising
dirName	  	 = current_mod_path,
developerName = _("JAS-39-C Community MOD"),
fileMenuName = _("JAS-39-C Gripen"),
displayName  = _("JAS-39-C Gripen"),
shortName  	  = _("JAS-39-C"),
version		 = "Test",
state		 = "installed",
update_id        = "JAS-39-C Gripen",
info		 = _("Info."),
encyclopedia_path = current_mod_path..'/Encyclopedia',
Skins	=
	{
		{
		    name	= _("JAS-39-C Gripen"),
			dir		= "Theme"
		},
	},
Missions =
	{
		{
			name		    = _("JAS-39-C Gripen"),
			dir			    = "Missions",
  		},
	},
LogBook =
	{
		{
		
		
		
			name		= _("JAS-39-C Gripen"),
			type		= "JAS-39-C Gripen",
		},
		
	},	
		
InputProfiles =
	{
		["JAS-39-C Gripen"] = current_mod_path .. '/Input/JAS-39-C',
	},
	
})
----------------------------------------------------------------------------------------
mount_vfs_model_path	(current_mod_path.."/Shapes")
mount_vfs_liveries_path (current_mod_path.."/Liveries")
mount_vfs_texture_path  (current_mod_path.."/Textures/JAS-39-C")
----------------------------------------------------------------------------------------
dofile(current_mod_path.."/LUA/Views_F15Pit.lua")
make_view_settings('VSN_JAS39Gripen', ViewSettings, SnapViews)
make_flyable('VSN_JAS39Gripen',current_mod_path..'/Cockpit/KneeboardRight/',{nil, old = 6}, current_mod_path..'/comm.lua')--SFM
-------------------------------------------------------------------------------------
dofile(current_mod_path..'/JAS-39-C.lua')
-------------------------------------------------------------------------------------
plugin_done()