dofile(LockOn_Options.common_script_path .. "devices_defs.lua")
dofile(LockOn_Options.common_script_path .. "elements_defs.lua")
-- dofile(LockOn_Options.script_path .. "MFD/Indicator/MFD_def.lua")
dofile(LockOn_Options.script_path .. "MFD/Indicator/RD/RD_Def.lua")



base = "RD_Base"



addRDBox(nil, nil, nil, nil, hcr.rw, lvls.noclip, {"mainpower"}, {{ctrl.compareNum, 0, 1}}, width / halfWidth, height / halfWidth, materials["green"], true)  -- Mask for clipping.
addRDBox(nil, nil, nil, nil, hcr.incIf, lvls.noclip, {"mainpower"}, {{ctrl.compareNum, 0, 1}}, width / halfWidth, height / halfWidth, materials["MFDBGGray"]) -- Mask for clipping and background.



addRDSimple(base, nil, nil, nil, nil, nil, {"mainpower"}, {{ctrl.compareNum, 0, 1}})



dofile(LockOn_Options.script_path .. "MFD/Indicator/RD/RD_Main_Pages.lua")



addRDBox(nil, nil, nil, base, hcr.rw, nil, {"RDBrightness"}, {{ctrl.opacity, 0}}, width / halfWidth, height / halfWidth, materials["black"])





-- OLD:
--[[
local aspect       = GetAspect()  -- GetHalfHeight()/GetHalfWidth()

RightDisplayBase 					= CreateElement "ceMeshPoly"
RightDisplayBase.name 				= create_guid_string()
RightDisplayBase.primitivetype 		= "triangles"
RightDisplayBase.vertices	    	= { {-aspect , aspect }, { aspect,aspect}, { aspect,-aspect}, {-aspect,-aspect}, }
RightDisplayBase.indices			= {0, 1, 2, 0, 2, 3}
RightDisplayBase.init_pos			= {0, 0, 0}
RightDisplayBase.material			= MakeMaterial(nil,{0, 0, 0,0})
RightDisplayBase.h_clip_relation 	= h_clip_relations.REWRITE_LEVEL
RightDisplayBase.level				= MFD_DEFAULT_LEVEL
RightDisplayBase.change_opacity		= false
RightDisplayBase.collimated 		= false
RightDisplayBase.isvisible			= true
Add(RightDisplayBase)

dofile(LockOn_Options.script_path.."MFD/Indicator/RD/RD_Main_Pages.lua")
-- dofile(LockOn_Options.script_path.."MFD/Indicator/RD/RD_Emergency_Page.lua")



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
--]]