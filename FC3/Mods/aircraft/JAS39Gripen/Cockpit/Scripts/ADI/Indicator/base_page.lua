dofile(LockOn_Options.script_path.."ADI/Device/device_defs.lua")

SHOW_MASKS = true

local half_width = GetScale()
local half_height = GetAspect() * half_width

local aspect = GetAspect()

ADI_base_clip                   = CreateElement "ceMeshPoly"
ADI_base_clip.name              = "ADI_base_clip"
ADI_base_clip.primitivetype     = "triangles"
ADI_base_clip.vertices          = { {1, aspect}, { 1,-aspect}, { -1,-aspect}, {-1,aspect},}
ADI_base_clip.indices           = {0,1,2,0,2,3}
ADI_base_clip.init_pos          = {0, 0, 0}
ADI_base_clip.init_rot          = {0, 0, 0}
ADI_base_clip.material          = "DBG_GREEN"
ADI_base_clip.h_clip_relation   = h_clip_relations.REWRITE_LEVEL
ADI_base_clip.level             = ADI_DEFAULT_NOCLIP_LEVEL +1
ADI_base_clip.isdraw            = true
ADI_base_clip.change_opacity    = true
ADI_base_clip.element_params    = {"BATTERY"}
ADI_base_clip.controllers       = {{"parameter_compare_with_number",0,1}}
ADI_base_clip.isvisible         = SHOW_MASKS
Add(ADI_base_clip)

ADI_ROLL                                 = CreateElement "ceSimple"
ADI_ROLL.name                            = "ADI_ROLL"
ADI_ROLL.init_pos                        = {0, 0, 0} --{0, 0, default_ADI_z_offset}
ADI_ROLL.init_rot                        = {0, 0, 0}
ADI_ROLL.element_params                  = {"ADI_ROLL","ADI_PITCH"}
ADI_ROLL.controllers                     = {{"rotate_using_parameter",0,1}}
ADI_ROLL.collimated                      = true
ADI_ROLL.use_mipfilter                   = true
ADI_ROLL.additive_alpha                  = true
ADI_ROLL.h_clip_relation                 = h_clip_relations.COMPARE
ADI_ROLL.level                           = ADI_DEFAULT_NOCLIP_LEVEL +1
ADI_ROLL.parent_element                  = "ADI_base_clip"
ADI_ROLL.isvisible                       = false
Add(ADI_ROLL)

ADI_PITCH                                = CreateElement "ceSimple"
ADI_PITCH.name                           = "ADI_PITCH"
ADI_PITCH.init_pos                       = {0, 0.00, 0}
ADI_PITCH.init_rot                       = {180, 0, 0}
ADI_PITCH.element_params                 = {"ADI_PITCH","ADI_LINES"}--"ADI_FD_Y"
ADI_PITCH.controllers                    = {{"move_up_down_using_parameter",0,0.066}}
ADI_PITCH.collimated                     = true
ADI_PITCH.use_mipfilter                  = true
ADI_PITCH.additive_alpha                 = true
ADI_PITCH.h_clip_relation                = h_clip_relations.COMPARE
ADI_PITCH.level                          = ADI_DEFAULT_NOCLIP_LEVEL +1
ADI_PITCH.parent_element                 = "ADI_ROLL"
ADI_PITCH.isvisible                      = false
Add(ADI_PITCH)


local SCREEN_clip                    = CreateElement "ceTexPoly"
SCREEN_clip.vertices                 = adi_vert_gen(27650,27650)
SCREEN_clip.indices                  = {0,1,2,2,3,0}
SCREEN_clip.tex_coords               = tex_coord_gen(0,0,1024,1024,1024,1024)
SCREEN_clip.material                 = ADI_CLIP
SCREEN_clip.name                     = create_guid_string()
SCREEN_clip.init_pos                 = {0, 0, 0}
SCREEN_clip.init_rot                 = {0, 0, 0}
SCREEN_clip.collimated               = true
SCREEN_clip.use_mipfilter            = true
SCREEN_clip.additive_alpha           = false
SCREEN_clip.h_clip_relation          = h_clip_relations.COMPARE
SCREEN_clip.level                    = ADI_DEFAULT_NOCLIP_LEVEL +1
SCREEN_clip.parent_element           = "ADI_base_clip"
Add(SCREEN_clip)

local ADI_ladder               = CreateElement "ceTexPoly"
ADI_ladder.vertices            = adi_vert_gen(32000,100000)
ADI_ladder.indices             = {0,1,2,0,3,2,}
ADI_ladder.tex_coords          = tex_coord_gen(0,0,512,2048,512,2048)
ADI_ladder.material            = PtchLddrMat
ADI_ladder.name                = create_guid_string()
ADI_ladder.init_pos            = {0, 0, 0}
ADI_ladder.init_rot            = {180, 0, 0}
ADI_ladder.collimated          = true
ADI_ladder.use_mipfilter       = true
ADI_ladder.additive_alpha      = false
ADI_ladder.h_clip_relation     = h_clip_relations.COMPARE
ADI_ladder.level               = ADI_DEFAULT_NOCLIP_LEVEL +1
ADI_ladder.parent_element      = "ADI_PITCH"
Add(ADI_ladder)

local ADIL_BG               = CreateElement "ceTexPoly"
ADIL_BG.vertices            = adi_vert_gen(9216,27648)
ADIL_BG.indices             = {0,1,2,0,3,2,}
ADIL_BG.tex_coords          = tex_coord_gen(0,0,1024,2048,1024,2048)
ADIL_BG.material            = PtchBGMat
ADIL_BG.name                = create_guid_string()
ADIL_BG.init_pos            = {1.5358, 0, 0}
ADIL_BG.init_rot            = {0, 0, 0}
ADIL_BG.collimated          = true
ADIL_BG.use_mipfilter       = true
ADIL_BG.additive_alpha      = false
ADIL_BG.h_clip_relation     = h_clip_relations.COMPARE
ADIL_BG.level               = ADI_DEFAULT_NOCLIP_LEVEL +1
ADIL_BG.parent_element      = "ADI_PITCH"
Add(ADIL_BG)

local ADIR_BG               = CreateElement "ceTexPoly"
ADIR_BG.vertices            = adi_vert_gen(9216,27648)
ADIR_BG.indices             = {0,1,2,0,3,2,}
ADIR_BG.tex_coords          = tex_coord_gen(0,0,1024,2048,1024,2048)
ADIR_BG.material            = PtchBGMat
ADIR_BG.name                = create_guid_string()
ADIR_BG.init_pos            = {-1.5358, 0, 0}
ADIR_BG.init_rot            = {0, 0, 0}
ADIR_BG.collimated          = true
ADIR_BG.use_mipfilter       = true
ADIR_BG.additive_alpha      = false
ADIR_BG.h_clip_relation     = h_clip_relations.COMPARE
ADIR_BG.level               = ADI_DEFAULT_NOCLIP_LEVEL +1
ADIR_BG.parent_element      = "ADI_PITCH"
Add(ADIR_BG)

local ADIFD                    = CreateElement "ceTexPoly"
ADIFD.vertices                 = adi_vert_gen(12288,12288)
ADIFD.indices                  = {0,1,2,0,3,2}
ADIFD.tex_coords               = tex_coord_gen(0,0,512,512,512,512)
ADIFD.material                 = FD_MATERIAL
ADIFD.name                     = create_guid_string()
ADIFD.init_pos                 = {0, 0, 0}
ADIFD.init_rot                 = {0, 0, 0}
ADIFD.collimated               = true
ADIFD.use_mipfilter            = true
ADIFD.additive_alpha           = true
ADIFD.h_clip_relation          = h_clip_relations.COMPARE
ADIFD.level                    = ADI_DEFAULT_NOCLIP_LEVEL +1
ADIFD.parent_element           = "ADI_base_clip"
Add(ADIFD)

local ADIFD_N                    = CreateElement "ceTexPoly"
ADIFD_N.vertices                 = adi_vert_gen(12288,12288)
ADIFD_N.indices                  = {0,1,2,0,3,2}
ADIFD_N.tex_coords               = tex_coord_gen(0,0,512,512,512,512)
ADIFD_N.material                 = FD_MATERIAL_N
ADIFD_N.name                     = create_guid_string()
ADIFD_N.init_pos                 = {0, 0, 0}
ADIFD_N.init_rot                 = {0, 0, 0}
ADIFD_N.collimated               = true
ADIFD_N.use_mipfilter            = true
ADIFD_N.additive_alpha           = true
ADIFD_N.h_clip_relation          = h_clip_relations.COMPARE
ADIFD_N.level                    = ADI_DEFAULT_NOCLIP_LEVEL +1
ADIFD_N.parent_element           = "ADI_base_clip"
Add(ADIFD_N)

local ADIFD_B                    = CreateElement "ceTexPoly"
ADIFD_B.vertices                 = adi_vert_gen(12288,12288)
ADIFD_B.indices                  = {0,1,2,0,3,2}
ADIFD_B.tex_coords               = tex_coord_gen(0,0,512,512,512,512)
ADIFD_B.material                 = FD_MATERIAL_B
ADIFD_B.name                     = create_guid_string()
ADIFD_B.init_pos                 = {0, 0, 0}
ADIFD_B.init_rot                 = {0, 0, 0}
ADIFD_B.collimated               = true
ADIFD_B.use_mipfilter            = true
ADIFD_B.additive_alpha           = true
ADIFD_B.h_clip_relation          = h_clip_relations.COMPARE
ADIFD_B.level                    = ADI_DEFAULT_NOCLIP_LEVEL +1
ADIFD_B.parent_element           = "ADI_base_clip"
Add(ADIFD_B)

----------------------------------------------------------------------

local ADI_COMPAS                   = CreateElement "ceTexPoly"
ADI_COMPAS.vertices                 = adi_vert_gen(9500,9500)
ADI_COMPAS.indices                  = {0,1,2,0,3,2}
ADI_COMPAS.tex_coords               = tex_coord_gen(0,0,512,512,512,512)
ADI_COMPAS.material                 = ADI_HDG
ADI_COMPAS.name                     = create_guid_string()
ADI_COMPAS.init_pos                 = {0, 0, 0}
ADI_COMPAS.init_rot                 = {1 , 0, 0}
ADI_COMPAS.element_params           = {"ADI_HSI_ROT"}
ADI_COMPAS.controllers              = {{"rotate_using_parameter",0,-1}}
ADI_COMPAS.collimated               = true
ADI_COMPAS.use_mipfilter            = true
ADI_COMPAS.additive_alpha           = true
ADI_COMPAS.h_clip_relation          = h_clip_relations.COMPARE
ADI_COMPAS.level                    = ADI_DEFAULT_NOCLIP_LEVEL +1
ADI_COMPAS.parent_element           = "ADI_base_clip"
Add(ADI_COMPAS)

--------------------------------------------------------------------

local ADI_SPEED_DIS             = CreateElement "ceStringPoly" 
ADI_SPEED_DIS.material          = "hud_font_base" 
ADI_SPEED_DIS.init_pos          = {-0.57 , -0.85 , 0}
ADI_SPEED_DIS.alignment         = "RightCenter" --Left/Right/Center; Top/Down/Center
ADI_SPEED_DIS.stringdefs        = {0.00450, 0.00450, 0.0004, 0.0}   
ADI_SPEED_DIS.formats           = {"%.0f","%s"} 
ADI_SPEED_DIS.element_params    = {"ADI_SPEED_DIS"}
ADI_SPEED_DIS.controllers       = {{"text_using_parameter",0},}
ADI_SPEED_DIS.collimated        = true
ADI_SPEED_DIS.use_mipfilter     = true
ADI_SPEED_DIS.additive_alpha    = true
ADI_SPEED_DIS.isvisible		    = true
ADI_SPEED_DIS.h_clip_relation   = h_clip_relations.COMPARE 
ADI_SPEED_DIS.level			    = ADI_DEFAULT_NOCLIP_LEVEL +1
ADI_SPEED_DIS.parent_element    = "ADI_base_clip" 
Add(ADI_SPEED_DIS)

------------------------------------------------------------------------

local ADI_ALT_DIS             = CreateElement "ceStringPoly" 
ADI_ALT_DIS.material          = "hud_font_base" 
ADI_ALT_DIS.init_pos          = {0.96 , -0.85 , 0}
ADI_ALT_DIS.alignment         = "RightCenter" --Left/Right/Center; Top/Down/Center
ADI_ALT_DIS.stringdefs        = {0.00450, 0.00450, 0.0004, 0.0}   
ADI_ALT_DIS.formats           = {"%.0f","%s"} 
ADI_ALT_DIS.element_params    = {"ADI_ALT_DIS"}
ADI_ALT_DIS.controllers       = {{"text_using_parameter",0},}
ADI_ALT_DIS.collimated        = true
ADI_ALT_DIS.use_mipfilter     = true
ADI_ALT_DIS.additive_alpha    = true
ADI_ALT_DIS.isvisible		    = true
ADI_ALT_DIS.h_clip_relation   = h_clip_relations.COMPARE 
ADI_ALT_DIS.level			    = ADI_DEFAULT_NOCLIP_LEVEL +1
ADI_ALT_DIS.parent_element    = "ADI_base_clip" 
Add(ADI_ALT_DIS)

-----------------------------------------------------------------------------