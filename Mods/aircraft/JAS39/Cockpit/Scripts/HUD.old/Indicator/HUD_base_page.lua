dofile(LockOn_Options.script_path.."HUD/Indicator/HUD_def.lua")
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

nav_total_field_of_view 				= CreateElement "ceMeshPoly"
nav_total_field_of_view.name 			= create_guid_string()
nav_total_field_of_view.primitivetype 	= "triangles"
nav_total_field_of_view.vertices	    = { {0 , 0.96 }, { 0.8 , 0.82}, { 1.01 ,0.5 }, { 1.01 ,-0.25 }, {0.85 ,-0.75 },  
											{0 , 0.96 }, { -0.8 , 0.82}, { -1.01 ,0.5 }, { -1.01 ,-0.25 }, {-0.85 ,-0.75 },{ 0.5 , 0.92}, { -0.5 , 0.92} }
nav_total_field_of_view.indices			= {0,6,7,  0,1,2,  2,3,4, 7,8,9, 7,0,2, 4,2,7, 7,9,4, 0,10,1 ,5,11,6}
nav_total_field_of_view.init_pos		= {-0.0615, -0.4039, 0}
nav_total_field_of_view.material		= TST
nav_total_field_of_view.h_clip_relation = h_clip_relations.REWRITE_LEVEL
nav_total_field_of_view.level			= HUD_DEFAULT_LEVEL  - 1
nav_total_field_of_view.change_opacity	= false
nav_total_field_of_view.collimated 		= false
nav_total_field_of_view.isvisible		= false
Add(nav_total_field_of_view)

hud_base_clip_FOV 					= CreateElement "ceMeshPoly"		-- change shape 
hud_base_clip_FOV.name 				=  create_guid_string()
hud_base_clip_FOV.primitivetype 	= "triangles"
hud_base_clip_FOV.vertices	   	 	= { {-2, 2 }, { 2 , 2}, { 2 ,-2 }, {-2 ,-2 }, }
hud_base_clip_FOV.indices			= {0, 1, 2, 0, 2, 3}
hud_base_clip_FOV.init_pos			= {0, 0, 0}
hud_base_clip_FOV.material			= TST_G
hud_base_clip_FOV.h_clip_relation   = h_clip_relations.INCREASE_IF_LEVEL 
hud_base_clip_FOV.level  		 	= HUD_DEFAULT_LEVEL  - 1
hud_base_clip_FOV.change_opacity	= false
hud_base_clip_FOV.collimated 		= false
hud_base_clip_FOV.isvisible			= false
Add(hud_base_clip_FOV)
 
dofile(LockOn_Options.script_path.."HUD/Indicator/HUD_indication_page.lua")
