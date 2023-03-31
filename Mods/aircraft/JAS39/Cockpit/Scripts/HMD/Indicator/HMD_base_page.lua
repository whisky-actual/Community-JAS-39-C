dofile(LockOn_Options.script_path.."HMD/Indicator/HMD_def.lua")
dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.common_script_path .. "elements_defs.lua")

--local aspect       = GetAspect()
--local aspect     = 1
--local xpos       = 0
--local ypos       = 0

local TST  		 = MakeMaterial(nil,{0,0,0,255})
local TST_G		 = MakeMaterial(nil,{0,0,100,255})
local SHOW_MASKS = true		 
			 
--local aspect       = 1

local hud_offset_x = 0
local hud_offset_y = 0

nav_total_field_of_view_hmd 				= CreateElement "ceMeshPoly"
nav_total_field_of_view_hmd.name 			= create_guid_string()
nav_total_field_of_view_hmd.primitivetype 	= "triangles"
nav_total_field_of_view_hmd.vertices	    = { {-2, 2 }, { 2 , 2}, { 2 ,-2 }, {-2 ,-2 }, }
nav_total_field_of_view_hmd.indices			= {0, 1, 2, 0, 2, 3}
nav_total_field_of_view_hmd.init_pos		= {-0.0615, -0.4039, 0}
nav_total_field_of_view_hmd.material		= TST
nav_total_field_of_view_hmd.h_clip_relation = h_clip_relations.REWRITE_LEVEL
nav_total_field_of_view_hmd.level			= HUD_DEFAULT_LEVEL -1
nav_total_field_of_view_hmd.change_opacity	= false
nav_total_field_of_view_hmd.collimated 		= false
nav_total_field_of_view_hmd.isvisible		= false
Add(nav_total_field_of_view_hmd)

hud_base_clip_hmd 					= CreateElement "ceMeshPoly"		-- change shape 
hud_base_clip_hmd.name 				=  create_guid_string()
hud_base_clip_hmd.primitivetype 	= "triangles"
hud_base_clip_hmd.vertices	   	 	= { {-2, 2 }, { 2 , 2}, { 2 ,-2 }, {-2 ,-2 }, }
hud_base_clip_hmd.indices			= {0, 1, 2, 0, 2, 3}
hud_base_clip_hmd.init_pos			= {0, 0, 0}
hud_base_clip_hmd.material			= TST_G
hud_base_clip_hmd.h_clip_relation   = h_clip_relations.INCREASE_IF_LEVEL 
hud_base_clip_hmd.level  		 	= HUD_DEFAULT_LEVEL  - 1
hud_base_clip_hmd.change_opacity	= false
hud_base_clip_hmd.collimated 		= false
hud_base_clip_hmd.isvisible			= false
Add(hud_base_clip_hmd)




 
dofile(LockOn_Options.script_path.."HMD/Indicator/HMD_indication_page.lua")
