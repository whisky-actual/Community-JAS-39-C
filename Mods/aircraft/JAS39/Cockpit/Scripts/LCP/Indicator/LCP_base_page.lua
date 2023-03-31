dofile(LockOn_Options.script_path.."MFD/Indicator/MFD_def.lua")
dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.common_script_path .. "elements_defs.lua")

--local aspect       = GetAspect()
--local aspect     = 1
--local xpos       = 0
--local ypos       = 0
LCP_DEFAULT_LEVEL = 7


local TST  		 = MakeMaterial(nil,{0,30,0,255})
local TST_G		 = MakeMaterial(nil,{0,0,100,255})
local SHOW_MASKS = true		 
			 
--local aspect       = 1

local hud_offset_x = 0
local hud_offset_y = 0

nav_total_field_of_view_LCP 				= CreateElement "ceMeshPoly"
nav_total_field_of_view_LCP.name 			= create_guid_string()
nav_total_field_of_view_LCP.primitivetype 	= "triangles"
nav_total_field_of_view_LCP.vertices	    = { {-1, 1 }, { 1 , 1}, { 1 ,-1 }, {-1 ,-1 }, }
nav_total_field_of_view_LCP.indices			= {0, 1, 2, 0, 2, 3}
nav_total_field_of_view_LCP.init_pos		= {0, 0, 0}
nav_total_field_of_view_LCP.material		= TST
nav_total_field_of_view_LCP.h_clip_relation = h_clip_relations.REWRITE_LEVEL
nav_total_field_of_view_LCP.level			= LCP_DEFAULT_LEVEL -1
nav_total_field_of_view_LCP.change_opacity	= false
nav_total_field_of_view_LCP.collimated 		= false
nav_total_field_of_view_LCP.isvisible		= false
Add(nav_total_field_of_view_LCP)
 
dofile(LockOn_Options.script_path.."LCP/Indicator/LCP_indication_page.lua")
