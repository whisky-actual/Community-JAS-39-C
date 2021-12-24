dofile(LockOn_Options.script_path.."MFD/Indicator/MFD_def.lua")
local MFDID=get_param_handle("MFDID")
MFDID:set(MFDID:get()+1)
MFD_ID = MFDID:get()

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

 