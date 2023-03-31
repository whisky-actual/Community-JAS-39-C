dofile(LockOn_Options.script_path.."MFD/Indicator/MFD_def.lua")
dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.common_script_path .. "elements_defs.lua")

UCP_DEFAULT_LEVEL = 7

--local aspect       = GetAspect()
--local aspect     = 1
--local xpos       = 0
--local ypos       = 0

local TST  		 = MakeMaterial(nil,{0,0,0,255})
local TST_G		 = MakeMaterial(nil,{0,0,100,255})
local SHOW_MASKS = true		 
			 

nav_total_field_of_view_UCP 				= CreateElement "ceMeshPoly"
nav_total_field_of_view_UCP.name 			= create_guid_string()
nav_total_field_of_view_UCP.primitivetype 	= "triangles"
nav_total_field_of_view_UCP.vertices	    = { {-2, 2 }, { 2 , 2}, { 2 ,-2 }, {-2 ,-2 }, }
nav_total_field_of_view_UCP.indices			= {0, 1, 2, 0, 2, 3}
nav_total_field_of_view_UCP.init_pos		= {-0.0615, -0.4039, 0}
nav_total_field_of_view_UCP.material		= TST
nav_total_field_of_view_UCP.h_clip_relation = h_clip_relations.REWRITE_LEVEL
nav_total_field_of_view_UCP.level			= UCP_DEFAULT_LEVEL -1
nav_total_field_of_view_UCP.change_opacity	= false
nav_total_field_of_view_UCP.collimated 		= false
nav_total_field_of_view_UCP.isvisible		= false
Add(nav_total_field_of_view_UCP)

 
dofile(LockOn_Options.script_path.."UCP/Indicator/UCP_indication_page.lua")
