dofile(LockOn_Options.script_path.."UFC/Device/device_defs.lua")

SHOW_MASKS = true

local half_width = GetScale()
local half_height = GetAspect() * half_width

local aspect = GetAspect()

UFC_base_clip                   = CreateElement "ceMeshPoly"
UFC_base_clip.name              = "UFC_base_clip"
UFC_base_clip.primitivetype     = "triangles"
UFC_base_clip.vertices          = { {1, aspect}, { 1,-aspect}, { -1,-aspect}, {-1,aspect},}
UFC_base_clip.indices           = {0,1,2,0,2,3}
UFC_base_clip.init_pos          = {0, 0, 0}
UFC_base_clip.init_rot          = {0, 0, 0}
UFC_base_clip.material          = "DBG_BLACK"
UFC_base_clip.h_clip_relation   = h_clip_relations.REWRITE_LEVEL
UFC_base_clip.level             = UFC_DEFAULT_NOCLIP_LEVEL +1
UFC_base_clip.isdraw            = true
UFC_base_clip.change_opacity    = true
UFC_base_clip.element_params    = {"BATTERY"}
UFC_base_clip.controllers       = {{"parameter_compare_with_number",0,1}}
UFC_base_clip.isvisible         = SHOW_MASKS
Add(UFC_base_clip)

local SCREEN_clip                    = CreateElement "ceTexPoly"
SCREEN_clip.vertices                 = ufc_vert_gen(11700,5000)
SCREEN_clip.indices                  = {0,1,2,0,3,2}
SCREEN_clip.tex_coords               = tex_coord_gen(0,0,1024,1024,1024,1024)
SCREEN_clip.material                 = UFC_CLIP
SCREEN_clip.name                     = create_guid_string()
SCREEN_clip.init_pos                 = {0, 0, 0}
SCREEN_clip.init_rot                 = {0, 0, 0}
SCREEN_clip.collimated               = true
SCREEN_clip.use_mipfilter            = true
SCREEN_clip.additive_alpha           = true
SCREEN_clip.h_clip_relation          = h_clip_relations.COMPARE
SCREEN_clip.level                    = UFC_DEFAULT_NOCLIP_LEVEL +1
SCREEN_clip.parent_element           = "UFC_base_clip"
Add(SCREEN_clip)

-------------------------------------------------------------------------

local UFC_RPM_BG_L                    = CreateElement "ceTexPoly"
UFC_RPM_BG_L.vertices                 = ufc_vert_gen(2700,2700)
UFC_RPM_BG_L.indices                  = {0,1,2,0,3,2}
UFC_RPM_BG_L.tex_coords               = tex_coord_gen(0,0,1024,1024,1024,1024)
UFC_RPM_BG_L.material                 = UFC_RPM_RING
UFC_RPM_BG_L.name                     = create_guid_string()
UFC_RPM_BG_L.init_pos                 = {-0.47, 0.1, 0} --L-R,U-D,F-B
UFC_RPM_BG_L.init_rot                 = {0, 0, 0}
UFC_RPM_BG_L.collimated               = true
UFC_RPM_BG_L.use_mipfilter            = true
UFC_RPM_BG_L.additive_alpha           = true
UFC_RPM_BG_L.h_clip_relation          = h_clip_relations.COMPARE
UFC_RPM_BG_L.level                    = UFC_DEFAULT_NOCLIP_LEVEL +1
UFC_RPM_BG_L.parent_element           = "UFC_base_clip"
Add(UFC_RPM_BG_L)

local UFC_RPM_BG_R                    = CreateElement "ceTexPoly"
UFC_RPM_BG_R.vertices                 = ufc_vert_gen(2700,2700)
UFC_RPM_BG_R.indices                  = {0,1,2,0,3,2}
UFC_RPM_BG_R.tex_coords               = tex_coord_gen(0,0,1024,1024,1024,1024)
UFC_RPM_BG_R.material                 = UFC_RPM_RING
UFC_RPM_BG_R.name                     = create_guid_string()
UFC_RPM_BG_R.init_pos                 = {0.49, 0.1, 0} --L-R,U-D,F-B
UFC_RPM_BG_R.init_rot                 = {0, 0, 0}
UFC_RPM_BG_R.collimated               = true
UFC_RPM_BG_R.use_mipfilter            = true
UFC_RPM_BG_R.additive_alpha           = true
UFC_RPM_BG_R.h_clip_relation          = h_clip_relations.COMPARE
UFC_RPM_BG_R.level                    = UFC_DEFAULT_NOCLIP_LEVEL +1
UFC_RPM_BG_R.parent_element           = "UFC_base_clip"
Add(UFC_RPM_BG_R)

----------------------------------------------------------------------

local UFC_RPM_ROT_L                   = CreateElement "ceTexPoly"
UFC_RPM_ROT_L.vertices                 = ufc_vert_gen(2700,2700)
UFC_RPM_ROT_L.indices                  = {0,1,2,0,3,2}
UFC_RPM_ROT_L.tex_coords               = tex_coord_gen(0,0,512,512,512,512)
UFC_RPM_ROT_L.material                 = UFC_RPM_ROT
UFC_RPM_ROT_L.name                     = create_guid_string()
UFC_RPM_ROT_L.init_pos                 = {-0.49, 0.1, 0} --L-R,U-D,F-B
UFC_RPM_ROT_L.init_rot                 = {0 , 0, 0}
UFC_RPM_ROT_L.element_params           = {"UFC_RPM_L"}
UFC_RPM_ROT_L.controllers              = {{"rotate_using_parameter",0,-0.042}}
UFC_RPM_ROT_L.collimated               = true
UFC_RPM_ROT_L.use_mipfilter            = true
UFC_RPM_ROT_L.additive_alpha           = true
UFC_RPM_ROT_L.h_clip_relation          = h_clip_relations.COMPARE
UFC_RPM_ROT_L.level                    = UFC_DEFAULT_NOCLIP_LEVEL +1
UFC_RPM_ROT_L.parent_element           = "UFC_base_clip"
Add(UFC_RPM_ROT_L)

local UFC_RPM_TEXT_L             = CreateElement "ceStringPoly" 
UFC_RPM_TEXT_L.material          = "hud_font_base_green" 
UFC_RPM_TEXT_L.init_pos          = {-0.35, 0.115, 0} --L-R,U-D,F-B
UFC_RPM_TEXT_L.alignment         = "RightCenter" --Left/Right/Center; Top/Down/Center
UFC_RPM_TEXT_L.stringdefs        = {0.0070, 0.0070, 0.0003, 0.0}     
UFC_RPM_TEXT_L.formats           = {"%.0f","%s"} 
UFC_RPM_TEXT_L.element_params    = {"UFC_TEXT_L"}
UFC_RPM_TEXT_L.controllers       = {{"text_using_parameter",0},}
UFC_RPM_TEXT_L.collimated        = true
UFC_RPM_TEXT_L.use_mipfilter     = true
UFC_RPM_TEXT_L.additive_alpha    = true
UFC_RPM_TEXT_L.isvisible		 = true
UFC_RPM_TEXT_L.h_clip_relation   = h_clip_relations.COMPARE 
UFC_RPM_TEXT_L.level			 = UFC_DEFAULT_NOCLIP_LEVEL +1
UFC_RPM_TEXT_L.parent_element    = "UFC_base_clip" 
Add(UFC_RPM_TEXT_L)

----------------------------------------------------------------------------

local UFC_RPM_ROT_R                   = CreateElement "ceTexPoly"
UFC_RPM_ROT_R.vertices                 = ufc_vert_gen(2700,2700)
UFC_RPM_ROT_R.indices                  = {0,1,2,0,3,2}
UFC_RPM_ROT_R.tex_coords               = tex_coord_gen(0,0,512,512,512,512)
UFC_RPM_ROT_R.material                 = UFC_RPM_ROT
UFC_RPM_ROT_R.name                     = create_guid_string()
UFC_RPM_ROT_R.init_pos                 = {0.47, 0.1, 0} --L-R,U-D,F-B
UFC_RPM_ROT_R.init_rot                 = {0 , 0, 0}
UFC_RPM_ROT_R.element_params           = {"UFC_RPM_R"}
UFC_RPM_ROT_R.controllers              = {{"rotate_using_parameter",0,-0.042}}
UFC_RPM_ROT_R.collimated               = true
UFC_RPM_ROT_R.use_mipfilter            = true
UFC_RPM_ROT_R.additive_alpha           = true
UFC_RPM_ROT_R.h_clip_relation          = h_clip_relations.COMPARE
UFC_RPM_ROT_R.level                    = UFC_DEFAULT_NOCLIP_LEVEL +1
UFC_RPM_ROT_R.parent_element           = "UFC_base_clip"
Add(UFC_RPM_ROT_R)

local UFC_RPM_TEXT_R             = CreateElement "ceStringPoly" 
UFC_RPM_TEXT_R.material          = "hud_font_base_green" 
UFC_RPM_TEXT_R.init_pos          = {0.63, 0.115, 0} --L-R,U-D,F-B
UFC_RPM_TEXT_R.alignment         = "RightCenter" --Left/Right/Center; Top/Down/Center
UFC_RPM_TEXT_R.stringdefs        = {0.0070, 0.0070, 0.0003, 0.0}   
UFC_RPM_TEXT_R.formats           = {"%.0f","%s"} 
UFC_RPM_TEXT_R.element_params    = {"UFC_TEXT_R"}
UFC_RPM_TEXT_R.controllers       = {{"text_using_parameter",0},}
UFC_RPM_TEXT_R.collimated        = true
UFC_RPM_TEXT_R.use_mipfilter     = true
UFC_RPM_TEXT_R.additive_alpha    = true
UFC_RPM_TEXT_R.isvisible		 = true
UFC_RPM_TEXT_R.h_clip_relation   = h_clip_relations.COMPARE 
UFC_RPM_TEXT_R.level			 = UFC_DEFAULT_NOCLIP_LEVEL +1
UFC_RPM_TEXT_R.parent_element    = "UFC_base_clip" 
Add(UFC_RPM_TEXT_R)

----------------------------------------------------------------------

local UFC_FUEL            = CreateElement "ceStringPoly" 
UFC_FUEL.material          = "hud_font_base_green" 
UFC_FUEL.init_pos          = {-0.065, -0.052, 0} --L-R,U-D,F-B
UFC_FUEL.alignment         = "LeftCenter" --Left/Right/Center; Top/Down/Center
UFC_FUEL.stringdefs        = {0.0070, 0.0070, 0.0003, 0.0}    
UFC_FUEL.formats           = {"%.0f","%s"} 
UFC_FUEL.element_params    = {"UFC_FUEL"}
UFC_FUEL.controllers       = {{"text_using_parameter",0},}
UFC_FUEL.collimated        = true
UFC_FUEL.use_mipfilter     = true
UFC_FUEL.additive_alpha    = true
UFC_FUEL.isvisible		 = true
UFC_FUEL.h_clip_relation   = h_clip_relations.COMPARE 
UFC_FUEL.level			 = UFC_DEFAULT_NOCLIP_LEVEL +1
UFC_FUEL.parent_element    = "UFC_base_clip" 
Add(UFC_FUEL)