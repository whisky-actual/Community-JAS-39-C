dofile(LockOn_Options.script_path.."MFD/Indicator/MFD_def.lua")

SHOW_MASKS = true

local aspect     = 1.2
local xpos       = 0
local ypos       = 0

local TST  		 = MakeMaterial(nil,{242, 235, 179,255})
local TST  		 = MakeMaterial(nil,{0, 0, 0,255})
local SHOW_MASKS = false		 
			 
local aspect       = GetAspect()  -- GetHalfHeight()/GetHalfWidth()

nav_total_field_of_view 				= CreateElement "ceMeshPoly"
nav_total_field_of_view.name 			= create_guid_string()
nav_total_field_of_view.primitivetype 	= "triangles"
nav_total_field_of_view.vertices	    = { {-aspect , aspect }, { aspect,aspect}, { aspect,-aspect}, {-aspect,-aspect}, }
nav_total_field_of_view.indices			= {0, 1, 2, 0, 2, 3}
nav_total_field_of_view.init_pos		= {0, 0, 0}
nav_total_field_of_view.material		= TST
nav_total_field_of_view.h_clip_relation = h_clip_relations.REWRITE_LEVEL
nav_total_field_of_view.level			= MFD_DEFAULT_LEVEL
nav_total_field_of_view.change_opacity	= false
nav_total_field_of_view.collimated 		= false
nav_total_field_of_view.isvisible		= true
Add(nav_total_field_of_view)

dofile(LockOn_Options.script_path.."MFD/Indicator/MFD_PAGE1.lua")

 

 