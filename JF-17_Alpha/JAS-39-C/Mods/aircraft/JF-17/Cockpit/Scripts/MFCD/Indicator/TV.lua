dofile(LockOn_Options.script_path .. "MFCD/MFCDs_defs.lua")

local page_root = create_page_root()



local hw     = 1.0
local verts  = {{-hw,  hw}, { hw,  hw}, { hw, -hw}, {-hw, -hw}}

TV_RENDER                    = CreateElement "ceTexPoly"
TV_RENDER.name               = "TV_RENDER"
TV_RENDER.init_pos           = {0,0}
TV_RENDER.vertices           = verts
TV_RENDER.indices            = DEF_BOX_INDICES
TV_RENDER.tex_coords         = {{0,0},{1,0},{1,1},{0,1}}
TV_RENDER.material           = MakeMaterial("mfd1", {0,0,0,255}) --"render_target_1" MFCD_MATERIAL_DEF
AddToUpper(TV_RENDER)
