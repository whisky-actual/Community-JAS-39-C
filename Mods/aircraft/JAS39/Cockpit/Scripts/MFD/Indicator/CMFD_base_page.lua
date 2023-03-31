dofile(LockOn_Options.script_path.."MFD/Indicator/MFD_def.lua")

SHOW_MASKS = true

local aspect     = 1.2
local xpos       = 0
local ypos       = 0


local TST  		 = MakeMaterial(nil,{0, 0, 0, 0})
local SHOW_MASKS = false		 
			 
local aspect       = GetAspect()  -- GetHalfHeight()/GetHalfWidth()

CenterDisplayBase 					= CreateElement "ceMeshPoly"
CenterDisplayBase.name 				= create_guid_string()
CenterDisplayBase.primitivetype 	= "triangles"
CenterDisplayBase.vertices	   		= { {-aspect , aspect }, { aspect,aspect}, { aspect,-aspect}, {-aspect,-aspect}, }
CenterDisplayBase.indices			= {0, 1, 2, 0, 2, 3}
CenterDisplayBase.init_pos			= {0, 0, 0}
CenterDisplayBase.material			= TST
CenterDisplayBase.h_clip_relation 	= h_clip_relations.REWRITE_LEVEL
CenterDisplayBase.level				= MFD_DEFAULT_LEVEL - 3
CenterDisplayBase.change_opacity	= true
CenterDisplayBase.collimated 		= false
CenterDisplayBase.isvisible			= true
Add(CenterDisplayBase)

dofile(LockOn_Options.script_path.."MFD/Indicator/CD_GENERAL.lua")
dofile(LockOn_Options.script_path.."MFD/Indicator/CD_EMERGENCY_PAGE.lua")
dofile(LockOn_Options.script_path.."MFD/Indicator/CD_RWR.lua")

 