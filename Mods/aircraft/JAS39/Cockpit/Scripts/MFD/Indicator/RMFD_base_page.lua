dofile(LockOn_Options.script_path.."MFD/Indicator/MFD_def.lua")
SHOW_MASKS = true

local aspect     = 1.2
local xpos       = 0
local ypos       = 0

local TST  		 = MakeMaterial(nil,{0, 0, 0,0})
local SHOW_MASKS = false		 
			 
local aspect       = GetAspect()  -- GetHalfHeight()/GetHalfWidth()

RightDisplayBase 					= CreateElement "ceMeshPoly"
RightDisplayBase.name 				= create_guid_string()
RightDisplayBase.primitivetype 		= "triangles"
RightDisplayBase.vertices	    	= { {-aspect , aspect }, { aspect,aspect}, { aspect,-aspect}, {-aspect,-aspect}, }
RightDisplayBase.indices			= {0, 1, 2, 0, 2, 3}
RightDisplayBase.init_pos			= {0, 0, 0}
RightDisplayBase.material			= TST
RightDisplayBase.h_clip_relation 	= h_clip_relations.REWRITE_LEVEL
RightDisplayBase.level				= MFD_DEFAULT_LEVEL
RightDisplayBase.change_opacity		= false
RightDisplayBase.collimated 		= false
RightDisplayBase.isvisible			= true
Add(RightDisplayBase)

dofile(LockOn_Options.script_path.."MFD/Indicator/RD_GENERAL.lua")
dofile(LockOn_Options.script_path.."MFD/Indicator/RD_EMERGENCY_PAGE.lua")



local RDBrightness           = CreateElement "ceSimpleLineObject"
RDBrightness.name            = create_guid_string()
RDBrightness.vertices        = {{0, -aspect}, {0, aspect + .1}}
RDBrightness.width           = 1
RDBrightness.material        = MakeMaterial(nil, {0, 0, 0, 255})
RDBrightness.h_clip_relation = h_clip_relations.REWRITE_LEVEL
RDBrightness.level           = MFD_DEFAULT_LEVEL
RDBrightness.element_params  = {"mainpower", "RDBrightness"}
RDBrightness.controllers     = {{"parameter_compare_with_number", 0, 1}, {"opacity_using_parameter", 1}}
Add(RDBrightness)