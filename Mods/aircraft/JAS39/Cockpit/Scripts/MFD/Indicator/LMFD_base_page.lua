dofile(LockOn_Options.script_path .. "MFD/Indicator/MFD_def.lua")
-- dofile(LockOn_Options.script_path .. "Indicator/Common_Defs.lua")



SHOW_MASKS = true

local aspect = 1.2
local xpos   = 0
local ypos   = 0


local TST        = MakeMaterial(nil, {0, 0, 0, 0})
local SHOW_MASKS = false

local aspect = GetAspect()       -- GetHalfHeight()/GetHalfWidth()

LeftDisplayBase                 = CreateElement "ceMeshPoly"
LeftDisplayBase.name            = create_guid_string()
LeftDisplayBase.primitivetype   = "triangles"
LeftDisplayBase.vertices        = {{-aspect, aspect}, {aspect, aspect}, {aspect, -aspect}, {-aspect, -aspect}}
LeftDisplayBase.indices         = {0, 1, 2, 0, 2, 3}
LeftDisplayBase.init_pos        = {0, 0, 0}
LeftDisplayBase.material        = TST
LeftDisplayBase.h_clip_relation = h_clip_relations.REWRITE_LEVEL
LeftDisplayBase.level           = MFD_DEFAULT_LEVEL
LeftDisplayBase.change_opacity  = true
LeftDisplayBase.collimated      = false
LeftDisplayBase.isvisible       = true
Add(LeftDisplayBase)



dofile(LockOn_Options.script_path .. "MFD/Indicator/LD_UPPER_AREA.lua")
dofile(LockOn_Options.script_path .. "MFD/Indicator/LD_LOWER_AREA.lua")
dofile(LockOn_Options.script_path .. "MFD/Indicator/LD_EMERGENCY_PAGE.lua")
dofile(LockOn_Options.script_path .. "MFD/Indicator/MFD_RWR.lua")



local LDBrightness           = CreateElement "ceSimpleLineObject"
LDBrightness.name            = create_guid_string()
LDBrightness.vertices        = {{0, -aspect}, {0, aspect + .1}}
LDBrightness.width           = 1
LDBrightness.material        = MakeMaterial(nil, {0, 0, 0, 255})
LDBrightness.h_clip_relation = h_clip_relations.REWRITE_LEVEL
LDBrightness.level           = MFD_DEFAULT_LEVEL
LDBrightness.element_params  = {"mainpower", "LDBrightness"}
LDBrightness.controllers     = {{"parameter_compare_with_number", 0, 1}, {"opacity_using_parameter", 1}}
Add(LDBrightness)