dofile(LockOn_Options.script_path .. "MFCD/MFCDs_defs.lua")

local page_root = create_page_root()

local EFIS_ADI_LEVEL     = PAGE_LEVEL_EFIS
local EFIS_ADI_BAR_LEVEL = EFIS_ADI_LEVEL + 3


-- material
local MFCD_TEX_IND1   = "mfcd_tex_ind1"
local MFCD_TEX_IND1_G = "mfcd_tex_ind1_g"
local MFCD_TEX_IND1_W = "mfcd_tex_ind1_w"

local MFCD_TEX_IND2   = "mfcd_tex_ind2"

local TEX_SIZE_X = 2048
local TEX_SIZE_Y = 2048

-- adi ball 大小
local adi_ball_radius = 0.482295 --0.51 / 1.094444 -- 0.482295 (inner) / 0.492295 (outer)
local adi_ball_shell  = (0.482295 + 0.492295)/2 --adi_ball_radius + 0.002
local adi_ball_offset = -0.10

-- 天地高宽
local box_bias_y = 400 * 3.1415926
local box_pos_y = box_bias_y
local gs_box_w = 0.6

local pitch_line_width = 0.0035
local pitch_ladder_len = 0.5
local pitch_five_bias = adi_ball_radius / 6 -- 0.9 -- 30 degree -> adi_ball_radius

-- spd/alt/hdg 刻度参数
local adi_bar_offset = 0.56
local adi_barbox_hh = 0.32 + 0.02
local adi_barbox_hw = 0.12

local bar_dist_hori = 0.40 / 4.0 -- hdg
local bar_dist_vert = 0.32 / 4.0 -- spd/alt

local bar_len_long  = 0.09 * 2/3
local bar_len_short = 0.06 * 2/3

local adi_bar_width = pitch_line_width * 1.8
local adi_bar_idx_bias = 0.06


-- pos fix
local adi_ball_vert_fix = 6.667/1000 -- -0.01

local adi_bar_spd_fix = 0.015*2
local adi_bar_alt_fix = -0.00825*2
local adi_bar_hdg_fix = -0.014*2


-- 用填充矩形画线
local DRAW_PITCH_TRIANGLE = 1

--OSB
local osb_txt = {
    {
        value="NORM", init_pos={MFCD_FONT_L_HORI_X, MFCD_FONT_LR5_Y}, align="LeftCenter",
        controllers={{"adi_text_norm_backup"}},
    },
    {
        name="efis_ils_osb", value="ILS", init_pos={MFCD_FONT_R_HORI_X, MFCD_FONT_LR5_Y}, align="RightCenter",
        controllers={{"adi_text_ils_aap"}},
    },
}

for i=1, #(osb_txt) do
    local text_strpoly      = CreateElement "ceStringPoly"
    if osb_txt[i].name then
        text_strpoly.name = osb_txt[i].name
    end
    text_strpoly.material   = MFCD_FONT_DEF
    text_strpoly.stringdefs = MFCD_STRINGDEFS_DEF_X08
    text_strpoly.init_pos   = osb_txt[i].init_pos
    text_strpoly.alignment  = osb_txt[i].align
    text_strpoly.value      = osb_txt[i].value
    if osb_txt[i].controllers then
        text_strpoly.controllers = osb_txt[i].controllers
    end
    text_strpoly.level      = EFIS_ADI_LEVEL
    AddToUpper(text_strpoly)
    text_strpoly = nil
end

-- box for ILS on/off
local ilsparent = { name = "efis_ils_osb", }

ils_osb_box             = CreateElement "ceTexPoly"
ils_osb_box.material    = MFCD_TEX_IND2
ils_osb_box.tex_coords  = MFCD_tex_coord(72, 1770, 116, 80, TEX_SIZE_X, TEX_SIZE_Y)
ils_osb_box.init_pos    = {MFCD_BOX3_R_HORI_X, MFCD_FONT_LR5_Y, 0}
ils_osb_box.vertices    = {{ 116/160 * 266.667/2000, 133.333/2000},
                           { 116/160 * 266.667/2000,-133.333/2000},
                           {-116/160 * 266.667/2000,-133.333/2000},
                           {-116/160 * 266.667/2000, 133.333/2000},}
ils_osb_box.indices     = DEF_BOX_INDICES
ils_osb_box.controllers = {{"efis_ils_box"}}
AddToUpper(ils_osb_box)
ils_osb_box = nil

-- SHARS ALIGN
shars_align             = CreateElement "ceStringPoly"
shars_align.material    = MFCD_FONT_DEF
shars_align.stringdefs  = MFCD_STRINGDEFS_DEF_X08
shars_align.init_pos    = {adi_ball_offset, MFCD_FONT_LR5_Y-0.1}
shars_align.alignment   = "CenterCenter"
shars_align.value       = "SHARS ALIGN"
shars_align.controllers = {{"efis_shars_align"}}
shars_align.level       = EFIS_ADI_LEVEL
AddToUpper(shars_align)
shars_align = nil


-- TODO: ILS LOC/GS mark



----[[ ADI Ball ]]

local adi_ball_base           = CreateElement "ceMeshPoly"
adi_ball_base.name            = create_guid_string()
adi_ball_base.material        = MFCD_MATERIAL_W_BASE
adi_ball_base.primitivetype   = "triangles"
adi_ball_base.init_pos        = {adi_ball_offset, adi_ball_vert_fix, 0}
adi_ball_base.h_clip_relation = h_clip_relations.REWRITE_LEVEL -- this element will sit on level(.level + 1)
adi_ball_base.level           = EFIS_ADI_LEVEL
adi_ball_base.isvisible       = false -- IMPORTANT: do not show this MeshPoly, used as mask poly
--SetMeshCircleClippedV(adi_ball_base, adi_ball_shell, 36)
SetCircleMesh(adi_ball_base, adi_ball_shell, 0, 360, true)
AddToUpper(adi_ball_base)

--[[
-- 滚转刻度 0 10 20 30 45 60
local roll_mark_width = 0.003 * 1.8
local roll_mark_leng  = 0.06
local adi_roll_mark_angle = {-60, -45, -30, -20, -10, 10, 20, 30, 45, 60}
local adi_roll_mark_scale = {1, 0.6, 1, 0.6, 0.6, 0.6, 0.6, 1, 0.6, 1}

for i = 1, #adi_roll_mark_angle do
    local br_mx = adi_ball_shell * math.sin(math.pi*adi_roll_mark_angle[i]/180)
    local br_my = adi_ball_shell * math.cos(math.pi*adi_roll_mark_angle[i]/180)
    adi_roll_mark_xx                 = CreateElement "ceMeshPoly"
    adi_roll_mark_xx.material        = MFCD_MATERIAL_GREEN
    adi_roll_mark_xx.primitivetype   = "triangles"
    adi_roll_mark_xx.vertices        = {{  roll_mark_width,  0},
                                        {  roll_mark_width, -adi_roll_mark_scale[i] * roll_mark_leng},
                                        { -roll_mark_width, -adi_roll_mark_scale[i] * roll_mark_leng},
                                        { -roll_mark_width,  0},}
    adi_roll_mark_xx.indices         = DEF_BOX_INDICES
    adi_roll_mark_xx.init_rot        = {adi_roll_mark_angle[i], 0, 0}
    adi_roll_mark_xx.init_pos        = {adi_ball_offset+br_mx, adi_ball_vert_fix+0-br_my, 0}
    --adi_roll_mark_xx.h_clip_relation = h_clip_relations.COMPARE
    adi_roll_mark_xx.level           = EFIS_ADI_LEVEL
    --adi_roll_mark_xx.controllers     = {{"move", br_mx*GetScale(), -br_my*GetScale(), 0},}
    adi_roll_mark_xx.isdraw          = true
    adi_roll_mark_xx.isvisible       = true
    adi_roll_mark_xx.use_mipfilter   = true
    adi_roll_mark_xx.additive_alpha  = true
    adi_roll_mark_xx.collimated      = false
    AddToUpper(adi_roll_mark_xx)
    adi_roll_mark_xx = nil
end

adi_roll_mark_0                 = CreateElement "ceMeshPoly"
adi_roll_mark_0.material        = MFCD_MATERIAL_WHITE_Y
adi_roll_mark_0.primitivetype   = "triangles"
adi_roll_mark_0.vertices        = {{ 0.04,  0},
                                   { 0.00, -0.06},
                                   {-0.04,  0},}
adi_roll_mark_0.indices         = {0, 1, 2}
adi_roll_mark_0.init_pos        = {adi_ball_offset, adi_ball_vert_fix-adi_ball_shell, 0}
--adi_roll_mark_0.h_clip_relation = h_clip_relations.COMPARE
adi_roll_mark_0.level           = EFIS_ADI_LEVEL
--adi_roll_mark_0.controllers     = {{"move", br_mx*GetScale(), -br_my*GetScale(), 0},}
adi_roll_mark_0.isdraw          = true
adi_roll_mark_0.isvisible       = true
adi_roll_mark_0.use_mipfilter   = true
adi_roll_mark_0.additive_alpha  = true
adi_roll_mark_0.collimated      = false
AddToUpper(adi_roll_mark_0)
adi_roll_mark_0 = nil
]]

local adi_roll_mark0       = CreateElement "ceTexPoly"
adi_roll_mark0.material    = MFCD_TEX_IND1
adi_roll_mark0.tex_coords  = MFCD_tex_coord(754, 584, 76, 76, TEX_SIZE_X, TEX_SIZE_Y)
adi_roll_mark0.vertices    = {{ 126.667/2000,  126.667/2000},
                              { 126.667/2000, -126.667/2000},
                              {-126.667/2000, -126.667/2000},
                              {-126.667/2000,  126.667/2000}}
adi_roll_mark0.indices     = DEF_BOX_INDICES
adi_roll_mark0.init_pos    = {adi_ball_offset, -510/1000, 0}
AddToUpper(adi_roll_mark0)
adi_roll_mark0 = nil

-- roll mark 0 三角指示符号

local adi_roll_delta       = CreateElement "ceTexPoly"
adi_roll_delta.material    = MFCD_TEX_IND1
adi_roll_delta.tex_coords  = MFCD_tex_coord(678, 584, 76, 76, TEX_SIZE_X, TEX_SIZE_Y)
adi_roll_delta.vertices    = {{ 126.667/2000,  126.667/2000},
                              { 126.667/2000, -126.667/2000},
                              {-126.667/2000, -126.667/2000},
                              {-126.667/2000,  126.667/2000}}
adi_roll_delta.indices     = DEF_BOX_INDICES
adi_roll_delta.init_pos    = {adi_ball_offset, adi_ball_vert_fix, 0}
adi_roll_delta.controllers = {{"adi_roll_indicator", 10.0},
                              {"move", 0, (6.667-573.333)/1000*GetScale() --[[(-adi_ball_radius-0.05)*GetScale()]], 0},}
AddToUpper(adi_roll_delta)
adi_roll_delta = nil

----- ADI deviation mark
local function add_adi_deviation_mark(is_hori)
    for i=-2,2 do
        local initpos = {0,0,0}
        local h_bias = i * bar_dist_hori
        local v_bias = i * bar_dist_hori
        local name = ""
        
        if is_hori then
            name = "adi_cdi_h_"
            initpos = {adi_ball_offset+h_bias, adi_ball_vert_fix+adi_ball_radius+bar_len_short, 0}
        else
            name = "adi_cdi_v_"
            initpos = {adi_ball_offset-adi_bar_offset+bar_len_long+adi_bar_spd_fix, adi_ball_vert_fix+v_bias, 0}
        end
        
        local adi_cdi_h           = CreateElement "ceMeshPoly"
        adi_cdi_h.name            = name .. tostring(i)
        adi_cdi_h.material        = MFCD_MATERIAL_GREEN
        adi_cdi_h.init_pos        = initpos
        adi_cdi_h.level           = EFIS_ADI_LEVEL
        --adi_cdi_h.h_clip_relation = h_clip_relations.COMPARE
        adi_cdi_h.isdraw          = true
        adi_cdi_h.use_mipfilter   = true
        adi_cdi_h.additive_alpha  = false
        set_circle(adi_cdi_h, 0.010, 0.002, 360, 36)
        AddToUpper(adi_cdi_h)
    end
end

-- [[ 横向 CDI 定位点 ]]
add_adi_deviation_mark(true)

-- [[ 横向 CDI 指示条 竖线 ]]
adi_cdi_mark_h                 = CreateElement "ceMeshPoly"
adi_cdi_mark_h.name            = "adi_cdi_mark_h"
adi_cdi_mark_h.material        = MFCD_MATERIAL_GREEN
adi_cdi_mark_h.primitivetype   = "triangles"
adi_cdi_mark_h.vertices        = {{ adi_bar_width, bar_len_long},
                                  { adi_bar_width, 0},
                                  {-adi_bar_width, 0},
                                  {-adi_bar_width, bar_len_long},}
adi_cdi_mark_h.indices         = DEF_BOX_INDICES
adi_cdi_mark_h.init_pos        = {adi_ball_offset, adi_ball_vert_fix+0.53+bar_len_long+adi_bar_hdg_fix, 0}
adi_cdi_mark_h.level           = EFIS_ADI_LEVEL
adi_cdi_mark_h.isdraw          = true
adi_cdi_mark_h.isvisible       = true
adi_cdi_mark_h.use_mipfilter   = true
adi_cdi_mark_h.additive_alpha  = true
adi_cdi_mark_h.collimated      = false
adi_cdi_mark_h.controllers     = {{"adi_cdi_bar_move", bar_dist_hori*2.0},}
AddToUpper(adi_cdi_mark_h)




-- [[ 竖向 CDI 定位点 ]]
add_adi_deviation_mark(false)

-- [[ 竖向 CDI 指示条 横线 ]]






--[[ ADI 球体 ]]

--[[
local adi_ball_frame           = CreateElement "ceMeshPoly" -- "ceSimpleLineObject", "ceMeshPoly"
adi_ball_frame.name            = create_guid_string()
adi_ball_frame.material        = MFCD_MATERIAL_GREEN
adi_ball_frame.primitivetype   = "triangles"
adi_ball_frame.init_pos        = {adi_ball_offset, adi_ball_vert_fix, 0}
--adi_ball_frame.h_clip_relation = h_clip_relations.COMPARE
--adi_ball_frame.level           = EFIS_ADI_LEVEL
adi_ball_frame.isdraw          = true
adi_ball_frame.isvisible       = true
adi_ball_frame.use_mipfilter   = true
adi_ball_frame.additive_alpha  = true
SetCircleMesh(adi_ball_frame, adi_ball_shell+0.01, adi_ball_shell, 360, true)
AddToUpper(adi_ball_frame)
]]

local adi_ball_frame_new       = CreateElement "ceTexPoly"
adi_ball_frame_new.material    = MFCD_TEX_IND1
adi_ball_frame_new.tex_coords  = MFCD_tex_coord(0, 0, 608, 656, TEX_SIZE_X, TEX_SIZE_Y)
adi_ball_frame_new.vertices    = {{ 1013.333/2000,  1093.333/2000},
                                  { 1013.333/2000, -1093.333/2000},
                                  {-1013.333/2000, -1093.333/2000},
                                  {-1013.333/2000,  1093.333/2000}}
adi_ball_frame_new.indices        = DEF_BOX_INDICES
adi_ball_frame_new.init_pos       = {adi_ball_offset, adi_ball_vert_fix, 0}
adi_ball_frame_new.isdraw         = true
adi_ball_frame_new.isvisible      = true
adi_ball_frame_new.use_mipfilter  = true
adi_ball_frame_new.additive_alpha = true
AddToUpper(adi_ball_frame_new)
adi_ball_frame_new = nil


local adi_ball_clip           = CreateElement "ceMeshPoly"
adi_ball_clip.name            = create_guid_string()
adi_ball_clip.material        = MFCD_MATERIAL_W_BASE
adi_ball_clip.primitivetype   = "triangles"
adi_ball_clip.init_pos        = {adi_ball_offset, adi_ball_vert_fix, 0}
adi_ball_clip.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL -- this element will sit on level(.level + 1)
adi_ball_clip.level           = EFIS_ADI_LEVEL
adi_ball_clip.isvisible       = false -- IMPORTANT: do not show this MeshPoly, used as mask poly
--SetMeshCircleClippedV(adi_ball_clip, adi_ball_shell, 36)
SetCircleMesh(adi_ball_clip, adi_ball_shell, 0, 360, true)
AddToUpper(adi_ball_clip)

--[[
local adi_ball_frame           = CreateElement "ceSimpleLineObject" -- "ceSimpleLineObject", "ceMeshPoly"
adi_ball_frame.name            = create_guid_string()
adi_ball_frame.material        = MakeMaterial(nil, MFCD_COLOR_G)
adi_ball_frame.primitivetype   = "lines"
adi_ball_frame.width           = 1.0
adi_ball_frame.init_pos        = {adi_ball_offset, 0, 0}
adi_ball_frame.h_clip_relation = h_clip_relations.COMPARE
adi_ball_frame.level           = EFIS_ADI_LEVEL + 1
adi_ball_frame.isvisible       = true
--SetLineCircleClippedV(adi_ball_frame, adi_ball_radius, 36)
SetFrameCircleClippedV(adi_ball_frame, adi_ball_radius-0.01, adi_ball_shell+0.02)
AddToUpper(adi_ball_frame)
]]



adi_ball_hori = nil
if DRAW_PITCH_TRIANGLE == 0 then
    adi_ball_hori                 = CreateElement "ceSimpleLineObject" -- "ceMeshPoly", "ceSimpleLineObject"
    adi_ball_hori.name            = create_guid_string()
    adi_ball_hori.material        = MFCD_MATERIAL_WHITE_Y
    adi_ball_hori.primitivetype   = "lines"
    adi_ball_hori.width           = pitch_ladder_len * 2.5
    adi_ball_hori.vertices        = {{-1, 0},
                                     { 1, 0},}
    adi_ball_hori.indices         = {0, 1}
    adi_ball_hori.init_pos        = {adi_ball_offset, adi_ball_vert_fix, 0}
    adi_ball_hori.h_clip_relation = h_clip_relations.COMPARE
    adi_ball_hori.level           = EFIS_ADI_LEVEL + 1
    adi_ball_hori.isvisible       = true
    adi_ball_hori.controllers     = {{"adi_ball_movement"}, {"adi_white_color"}}
    AddToUpper(adi_ball_hori)
else
    adi_ball_hori                 = CreateElement "ceMeshPoly" -- "ceMeshPoly", "ceSimpleLineObject"
    adi_ball_hori.name            = create_guid_string()
    adi_ball_hori.material        = MFCD_MATERIAL_WHITE_Y
    adi_ball_hori.primitivetype   = "triangles"
    adi_ball_hori.width           = pitch_ladder_len * 2.5
    adi_ball_hori.vertices        = {{  1,  pitch_line_width * 1.5},
                                     {  1, -pitch_line_width * 1.5},
                                     { -1, -pitch_line_width * 1.5},
                                     { -1,  pitch_line_width * 1.5},}
    adi_ball_hori.indices         = DEF_BOX_INDICES
    adi_ball_hori.init_pos        = {adi_ball_offset, adi_ball_vert_fix, 0}
    adi_ball_hori.h_clip_relation = h_clip_relations.COMPARE
    adi_ball_hori.level           = EFIS_ADI_LEVEL + 1
    adi_ball_hori.isvisible       = true
    adi_ball_hori.controllers     = {{"adi_ball_movement"}, {"adi_white_color"}}
    AddToUpper(adi_ball_hori)
end

local adi_ball_sg_vertices = {{ gs_box_w,  box_pos_y},
                              { gs_box_w, -box_pos_y},
                              {-gs_box_w, -box_pos_y},
                              {-gs_box_w,  box_pos_y}}

local adi_ball_sky           = CreateElement "ceMeshPoly"
adi_ball_sky.name            = "adi_ball_sky"
adi_ball_sky.material        = MFCD_MATERIAL_SKY
adi_ball_sky.primitivetype   = "triangles"
adi_ball_sky.vertices        = adi_ball_sg_vertices
adi_ball_sky.indices         = DEF_BOX_INDICES --{0,1,2,0,2,3 }
adi_ball_sky.init_pos        = {0, box_pos_y, 0}
adi_ball_sky.h_clip_relation = h_clip_relations.COMPARE
adi_ball_sky.level           = EFIS_ADI_LEVEL + 1
adi_ball_sky.isvisible       = true
adi_ball_sky.parent_element  = adi_ball_hori.name
adi_ball_sky.controllers     = {{"adi_sky_color"}}
AddToUpper(adi_ball_sky)


local adi_ball_ground           = CreateElement "ceMeshPoly"
adi_ball_ground.name            = "adi_ball_ground"
adi_ball_ground.material        = MFCD_MATERIAL_GRND
adi_ball_ground.primitivetype   = "triangles"
adi_ball_ground.vertices        = adi_ball_sg_vertices
adi_ball_ground.indices         = DEF_BOX_INDICES --{0,1,2,0,2,3 }
adi_ball_ground.init_pos        = {0, -box_pos_y, 0}
adi_ball_ground.h_clip_relation = h_clip_relations.COMPARE
adi_ball_ground.level           = EFIS_ADI_LEVEL + 1
adi_ball_ground.isvisible       = true
adi_ball_ground.parent_element  = adi_ball_hori.name
adi_ball_ground.controllers     = {{"adi_gnd_color"}}
AddToUpper(adi_ball_ground)

--[[
local adi_ball_hori           = CreateElement "ceSimpleLineObject" -- "ceMeshPoly", "ceSimpleLineObject"
adi_ball_hori.name            = "adi_ball_hori"
adi_ball_hori.material        = MakeMaterial(nil, MFCD_COLOR_WHITE_Y)
adi_ball_hori.primitivetype   = "lines"
adi_ball_hori.width           = pitch_ladder_len * 1.5
adi_ball_hori.vertices        = {{ -0.3, 0},
                                 { 0.3, 0},}
adi_ball_hori.indices         = {0,1}
adi_ball_hori.init_pos        = {0, 0, 0}
adi_ball_hori.h_clip_relation = h_clip_relations.COMPARE
adi_ball_hori.level           = EFIS_ADI_LEVEL + 1
adi_ball_hori.isvisible       = true
--adi_ball_hori.parent_element  = adi_ball_hori.name
AddToUpper(adi_ball_hori)
]]

function add_adi_pitch_ladder(name, width, hw, pos, parent)
    if DRAW_PITCH_TRIANGLE == 0 then
        adi_ball_pitch_ladder                 = CreateElement "ceSimpleLineObject"
        adi_ball_pitch_ladder.name            = name
        adi_ball_pitch_ladder.material        = MFCD_MATERIAL_WHITE_Y
        adi_ball_pitch_ladder.primitivetype   = "lines"
        adi_ball_pitch_ladder.width           = width
        adi_ball_pitch_ladder.vertices        = {{-hw, 0},
                                                 { hw, 0},}
        adi_ball_pitch_ladder.indices         = {0, 1}
        adi_ball_pitch_ladder.init_pos        = {0, pos, 0}
        adi_ball_pitch_ladder.h_clip_relation = h_clip_relations.COMPARE
        adi_ball_pitch_ladder.level           = EFIS_ADI_LEVEL + 1
        adi_ball_pitch_ladder.parent_element  = parent.name
        adi_ball_pitch_ladder.isdraw          = true
        adi_ball_pitch_ladder.isvisible       = true
        adi_ball_pitch_ladder.use_mipfilter   = true
        adi_ball_pitch_ladder.additive_alpha  = true
        adi_ball_pitch_ladder.collimated      = false
        adi_ball_pitch_ladder.controllers     = {{"adi_pitch_norm_backup"}, {"adi_white_color"}}
        AddToUpper(adi_ball_pitch_ladder)
        adi_ball_pitch_ladder = nil
    else
        adi_ball_pitch_ladder                 = CreateElement "ceMeshPoly"
        adi_ball_pitch_ladder.name            = name
        adi_ball_pitch_ladder.material        = MFCD_MATERIAL_WHITE_Y
        adi_ball_pitch_ladder.primitivetype   = "triangles"
        adi_ball_pitch_ladder.width           = width
        adi_ball_pitch_ladder.vertices        = {{  hw,  pitch_line_width * 1.5},
                                                 {  hw, -pitch_line_width * 1.5},
                                                 { -hw, -pitch_line_width * 1.5},
                                                 { -hw,  pitch_line_width * 1.5},}
        adi_ball_pitch_ladder.indices         = DEF_BOX_INDICES
        adi_ball_pitch_ladder.init_pos        = {0, pos, 0}
        adi_ball_pitch_ladder.h_clip_relation = h_clip_relations.COMPARE
        adi_ball_pitch_ladder.level           = EFIS_ADI_LEVEL + 1
        adi_ball_pitch_ladder.parent_element  = parent.name
        adi_ball_pitch_ladder.isdraw          = true
        adi_ball_pitch_ladder.isvisible       = true
        adi_ball_pitch_ladder.use_mipfilter   = true
        adi_ball_pitch_ladder.additive_alpha  = true
        adi_ball_pitch_ladder.collimated      = false
        adi_ball_pitch_ladder.controllers     = {{"adi_pitch_norm_backup"}, {"adi_white_color"}}
        AddToUpper(adi_ball_pitch_ladder)
        adi_ball_pitch_ladder = nil
    end
end


function add_adi_pitch_index(name, idx, px, pos, parent, font)
    local name_side  = {"_left", "_right"}
    local index_side = {1.0, -1.0}
    for i = 1,2 do
        adi_pitch_index                 = CreateElement "ceStringPoly"
        adi_pitch_index.name            = name .. name_side[i]
        adi_pitch_index.material        = MFCD_FONT_WY
        adi_pitch_index.stringdefs      = font
        adi_pitch_index.init_pos        = {px*index_side[i], pos, 0}
        adi_pitch_index.alignment       = "CenterCenter"
        --adi_pitch_index.formats         = {"%02.0f","%s"}
        adi_pitch_index.value           = idx
        adi_pitch_index.h_clip_relation = h_clip_relations.COMPARE
        adi_pitch_index.level           = EFIS_ADI_LEVEL + 1
        adi_pitch_index.parent_element  = parent.name
        adi_pitch_index.isdraw          = true
        adi_pitch_index.isvisible       = true
        adi_pitch_index.use_mipfilter   = true
        adi_pitch_index.additive_alpha  = true
        adi_pitch_index.collimated      = false
        adi_pitch_index.controllers     = {{"adi_pitch_norm_backup"}, {"adi_white_color"}}
        AddToUpper(adi_pitch_index)
        adi_pitch_index = nil
    end
end

-- pitch lander
for i = 1, 9 do
    local n1 = "adi_pitch_ladder_p" .. tostring(10*i)
    local n2 = "adi_pitch_ladder_p" .. tostring(10*i-5)
    local n3 = "adi_pitch_ladder_n" .. tostring(10*i-5)
    local n4 = "adi_pitch_ladder_n" .. tostring(10*i)
    
    local p1 =  pitch_five_bias * (2*i)
    local p2 =  pitch_five_bias * (2*i-1)
    local p3 = -pitch_five_bias * (2*i-1)
    local p4 = -pitch_five_bias * (2*i)
    
    add_adi_pitch_ladder(n1, pitch_ladder_len, 0.22, p1, adi_ball_hori) -- + 10
    add_adi_pitch_ladder(n2, pitch_ladder_len, 0.10, p2, adi_ball_hori) -- + 5
    add_adi_pitch_ladder(n3, pitch_ladder_len, 0.10, p3, adi_ball_hori) -- - 5
    add_adi_pitch_ladder(n4, pitch_ladder_len, 0.22, p4, adi_ball_hori) -- - 10    

    local i1 = "adi_pitch_index_p" .. tostring(10*i)
    local i2 = "adi_pitch_index_n" .. tostring(10*i)
    add_adi_pitch_index(i1, 10*i, 0.300, p1, adi_ball_hori, MFCD_STRINGDEFS_DEF_X06) -- + 10
    add_adi_pitch_index(i2, 10*i, 0.300, p4, adi_ball_hori, MFCD_STRINGDEFS_DEF_X06) -- - 10    
end

-- aircraft -w-
local adi_ball_ac_sym       = CreateElement "ceTexPoly"
adi_ball_ac_sym.material    = MFCD_TEX_IND1
adi_ball_ac_sym.tex_coords  = MFCD_tex_coord(1264, 1702, 404, 92, TEX_SIZE_X, TEX_SIZE_Y)
adi_ball_ac_sym.vertices    = {{ 673.333/2000,  153.333/2000},
                               { 673.333/2000, -153.333/2000},
                               {-673.333/2000, -153.333/2000},
                               {-673.333/2000,  153.333/2000}}
adi_ball_ac_sym.indices        = DEF_BOX_INDICES
adi_ball_ac_sym.init_pos       = {adi_ball_offset, adi_ball_vert_fix-45/1000, 0}
adi_ball_ac_sym.isdraw         = true
adi_ball_ac_sym.isvisible      = true
adi_ball_ac_sym.use_mipfilter  = true
adi_ball_ac_sym.additive_alpha = true
adi_ball_ac_sym.h_clip_relation = h_clip_relations.REWRITE_LEVEL
adi_ball_ac_sym.level           = EFIS_ADI_LEVEL + 2
AddToUpper(adi_ball_ac_sym)
adi_ball_ac_sym = nil



---- ILS
local adi_ils_bar_len = 0.26

-- ILS LOC (vert)
adi_ils_loc                 = CreateElement "ceMeshPoly"
adi_ils_loc.name            = "adi_ils_loc"
adi_ils_loc.material        = MFCD_MATERIAL_YELLOW
adi_ils_loc.primitivetype   = "triangles"
adi_ils_loc.vertices        = {{ adi_bar_width,  adi_ils_bar_len},
                               { adi_bar_width, -adi_ils_bar_len},
                               {-adi_bar_width, -adi_ils_bar_len},
                               {-adi_bar_width,  adi_ils_bar_len},}
adi_ils_loc.indices         = DEF_BOX_INDICES
adi_ils_loc.init_pos        = {adi_ball_offset, adi_ball_vert_fix, 0}
--adi_ils_loc.h_clip_relation = h_clip_relations.COMPARE
adi_ils_loc.level           = EFIS_ADI_LEVEL + 2
adi_ils_loc.isdraw          = true
adi_ils_loc.isvisible       = true
adi_ils_loc.use_mipfilter   = true
adi_ils_loc.additive_alpha  = true
adi_ils_loc.collimated      = false
adi_ils_loc.controllers     = {{"adi_ils_loc_move", bar_dist_hori, adi_ball_offset},}
AddToUpper(adi_ils_loc)

-- ILS GS (hori)
adi_ils_gs                 = CreateElement "ceMeshPoly"
adi_ils_gs.name            = "adi_ils_gs"
adi_ils_gs.material        = MFCD_MATERIAL_YELLOW
adi_ils_gs.primitivetype   = "triangles"
adi_ils_gs.vertices        = {{ adi_ils_bar_len,  adi_bar_width},
                              { adi_ils_bar_len, -adi_bar_width},
                              {-adi_ils_bar_len, -adi_bar_width},
                              {-adi_ils_bar_len,  adi_bar_width},}
adi_ils_gs.indices         = DEF_BOX_INDICES
adi_ils_gs.init_pos        = {adi_ball_offset, adi_ball_vert_fix, 0}
--adi_ils_gs.h_clip_relation = h_clip_relations.COMPARE
adi_ils_gs.level           = EFIS_ADI_LEVEL + 2
adi_ils_gs.isdraw          = true
adi_ils_gs.isvisible       = true
adi_ils_gs.use_mipfilter   = true
adi_ils_gs.additive_alpha  = true
adi_ils_gs.collimated      = false
adi_ils_gs.controllers     = {{"adi_ils_gs_move", bar_dist_hori, adi_ball_offset},}
AddToUpper(adi_ils_gs)

--[[
-- aircraft
if DRAW_PITCH_TRIANGLE == 0 then
    adi_ball_aircraft                 = CreateElement "ceMeshPoly"
    adi_ball_aircraft.name            = "adi_ball_aircraft"
    adi_ball_aircraft.material        = MFCD_MATERIAL_GREEN
    adi_ball_aircraft.primitivetype   = "lines"
    adi_ball_aircraft.vertices        = {{ -0.3,  0.0},
                                         { -0.1,  0.0},
                                         {-0.05, -0.1},
                                         {  0.0,  0.0},
                                         { 0.05, -0.1},
                                         {  0.1,  0.0},
                                         {  0.3,  0.0},}
    adi_ball_aircraft.indices         = {0,1,1,2,2,3,3,4,4,5,5,6}
    adi_ball_aircraft.init_pos        = {adi_ball_offset, adi_ball_vert_fix, 0}
    --adi_ball_aircraft.h_clip_relation = h_clip_relations.REWRITE_LEVEL
    adi_ball_aircraft.level           = EFIS_ADI_LEVEL + 2
    adi_ball_aircraft.isdraw          = true
    adi_ball_aircraft.isvisible       = true
    adi_ball_aircraft.use_mipfilter   = true
    adi_ball_aircraft.additive_alpha  = false
    adi_ball_aircraft.collimated      = false
    AddToUpper(adi_ball_aircraft)
    adi_ball_aircraft = nil
else
    local adi_ac_line_scale = 2.5
    local aid_line_dir = {1.0, -1.0}
    local adi_ac_nodes = {{-0.30,  0},
                          {-0.10,  0},
                          {-0.05, -0.1},
                          {    0,  0}}
    for i = 1, 2 do
        for j = 1, (#adi_ac_nodes-1) do
            local idx = i * (#adi_ac_nodes-1) + j
            local x1  = adi_ac_nodes[j][1]
            local x2  = adi_ac_nodes[j+1][1]
            local y1  = adi_ac_nodes[j][2]
            local y2  = adi_ac_nodes[j+1][2]
            local dir = aid_line_dir[i]
            adi_ball_aircraft                 = CreateElement "ceMeshPoly"
            adi_ball_aircraft.name            = "adi_ball_aircraft_" .. idx
            adi_ball_aircraft.material        = MFCD_MATERIAL_GREEN
            adi_ball_aircraft.primitivetype   = "triangles"
            adi_ball_aircraft.vertices        = {{ dir*x2, y2+pitch_line_width*adi_ac_line_scale},
                                                 { dir*x2, y2-pitch_line_width*adi_ac_line_scale},
                                                 { dir*x1, y1-pitch_line_width*adi_ac_line_scale},
                                                 { dir*x1, y1+pitch_line_width*adi_ac_line_scale},}
            adi_ball_aircraft.indices         = DEF_BOX_INDICES
            adi_ball_aircraft.init_pos        = {adi_ball_offset, adi_ball_vert_fix, 0}
            --adi_ball_aircraft.h_clip_relation = h_clip_relations.REWRITE_LEVEL
            adi_ball_aircraft.level           = EFIS_ADI_LEVEL + 2
            adi_ball_aircraft.isdraw          = true
            adi_ball_aircraft.isvisible       = true
            adi_ball_aircraft.use_mipfilter   = true
            adi_ball_aircraft.additive_alpha  = false
            adi_ball_aircraft.collimated      = false
            AddToUpper(adi_ball_aircraft)
            adi_ball_aircraft = nil
        end
    end
end
]]


----========================================================----
----========================================================----



---------[[ 指示条 ]]---------

local function add_adi_bar_scale(name, num, dir, parent, level, len, dist, islong, add_idx, isdummy)
    x1 = len; x2 = len; x3 = len; x4 = len
    fontinitx = len+0.02
    fontalign = "LeftCenter"
    ctrler    = {}
    if name == "spd" then
        ctrler = {{"adi_spd_boxclip", 0.06, adi_barbox_hh}}
    elseif name == "alt" then
        ctrler = {{"adi_alt_boxclip", 0.06, adi_barbox_hh}}
    elseif name == "hdg" then
        ctrler = {{"adi_hdg_boxclip", 0.11+0.03, adi_ball_offset}}
    else
        ctrler = nil
    end
    
    if dir == -1 then
        x1 = 0; x2 = 0;
        x3 = -len; x4 = -len;
        fontinitx = -fontinitx
        fontalign = "RightCenter"
    else
        x1 = len; x2 = len;
        x3 = 0; x4 = 0;
    end
    
    tname = "adi_" .. name .. "_scale_"
    
    sname = "long_"
    if islong == false then
        sname = "short_"
    end
    if isdummy == true then
        sname = sname .. "n"
    else
        sname = sname .. "p"
    end
    
    for i = 1, num do
        lstep = 2*i
        if islong == false then
            lstep = 2*i-1
        end
        
        if isdummy == true then
            lstep = -lstep
        end
    
        -- 长条
        adi_xxx_scale_long                 = CreateElement "ceMeshPoly"
        adi_xxx_scale_long.name            = tname .. sname .. tostring(i)
        adi_xxx_scale_long.material        = MFCD_MATERIAL_GREEN
        adi_xxx_scale_long.primitivetype   = "triangles"
        if name == "hdg" then
            adi_xxx_scale_long.vertices    = {{ adi_bar_width, x1},
                                              { adi_bar_width, x3},
                                              {-adi_bar_width, x4},
                                              {-adi_bar_width, x2},}
            adi_xxx_scale_long.init_pos    = {lstep * dist, 0, 0}
        else
            adi_xxx_scale_long.vertices    = {{ x1,  adi_bar_width},
                                              { x2, -adi_bar_width},
                                              { x3, -adi_bar_width},
                                              { x4,  adi_bar_width},}
            adi_xxx_scale_long.init_pos    = {0, lstep * dist, 0}
        end
        adi_xxx_scale_long.indices         = DEF_BOX_INDICES
        adi_xxx_scale_long.h_clip_relation = h_clip_relations.COMPARE
        adi_xxx_scale_long.level           = level
        if parent ~= nil then
            adi_xxx_scale_long.parent_element = parent.name
        end
        adi_xxx_scale_long.isdraw          = true
        adi_xxx_scale_long.isvisible       = true
        adi_xxx_scale_long.use_mipfilter   = true
        adi_xxx_scale_long.additive_alpha  = true
        adi_xxx_scale_long.collimated      = false
        if name ~= "hdg" then
            adi_xxx_scale_long.controllers = ctrler
        end
        AddToUpper(adi_xxx_scale_long)
        adi_xxx_scale_long = nil
                
        -- 数字
        if add_idx == true then
            local text = i
            if name == "alt" then
                local p1000 = math.floor(i/10)
                local p100  = i % 10
                text = p1000 .. "," .. p100
                if isdummy then
                    text = "-" .. text
                end
            elseif name == "vvs" then
                text = i * 20
            end
            
            tsname = "idx_"
            if islong == false then
                tsname = tsname .. "s"
            else
                tsname = tsname .. "l"
            end
            if isdummy == true then
                tsname = tsname .. "n"
            else
                tsname = tsname .. "p"
            end
            
            adi_xxx_scale_idx                 = CreateElement "ceStringPoly"
            adi_xxx_scale_idx.name            = tname .. tsname .. tostring(i)
            adi_xxx_scale_idx.material        = MFCD_FONT_G
            adi_xxx_scale_idx.stringdefs      = MFCD_STRINGDEFS_DEF_X07
            if name == "hdg" then
                k = i
                if isdummy == true then
                    k = 36 - i
                    text = k
                end
                if k < 10 then
                    text = "0" .. k
                end
                fontinitx = len + 0.04
                adi_xxx_scale_idx.init_pos    = {lstep * dist, fontinitx, 0}
                adi_xxx_scale_idx.formats     = {"%02.0f","%s"}
                adi_xxx_scale_idx.alignment   = "CenterCenter"
            else
                adi_xxx_scale_idx.init_pos    = {fontinitx, lstep * dist, 0}
                adi_xxx_scale_idx.alignment   = fontalign
            end
            adi_xxx_scale_idx.value           = text
            adi_xxx_scale_idx.h_clip_relation = h_clip_relations.COMPARE
            adi_xxx_scale_idx.level           = level
            if parent ~= nil then
                adi_xxx_scale_idx.parent_element = parent.name
            end
            adi_xxx_scale_idx.isdraw          = true
            adi_xxx_scale_idx.isvisible       = true
            adi_xxx_scale_idx.use_mipfilter   = true
            adi_xxx_scale_idx.additive_alpha  = true
            adi_xxx_scale_idx.collimated      = false
            adi_xxx_scale_idx.controllers     = ctrler
            AddToUpper(adi_xxx_scale_idx)
            adi_xxx_scale_idx = nil
        end

    end

end


----========================================================----


----[[ 速度框 ]]
local spd_box_bias = adi_ball_offset-adi_bar_offset-0.05+adi_bar_spd_fix
local spd_box_vertices = {{ 0.05,  0.05},
                          { 0.05, -0.05},
                          {-0.15, -0.05},
                          {-0.15,  0.05}}

local spd_box_base           = CreateElement "ceMeshPoly"
spd_box_base.name            = create_guid_string()
spd_box_base.material        = MFCD_MATERIAL_BOXBASE
spd_box_base.primitivetype   = "triangles"
spd_box_base.init_pos        = {spd_box_bias, adi_ball_vert_fix, 0}
spd_box_base.vertices        = spd_box_vertices
spd_box_base.indices         = DEF_BOX_INDICES --{0,1,2,0,2,3 }
spd_box_base.h_clip_relation = h_clip_relations.REWRITE_LEVEL
spd_box_base.level           = EFIS_ADI_BAR_LEVEL + 2
spd_box_base.isdraw          = true
spd_box_base.isvisible       = true
spd_box_base.use_mipfilter   = true
spd_box_base.additive_alpha  = false
spd_box_base.collimated      = false
AddToUpper(spd_box_base)
spd_box_base = nil

-- 速度框Mask
local spd_box_clip           = CreateElement "ceMeshPoly"
spd_box_clip.name            = create_guid_string()
spd_box_clip.material        = MFCD_MATERIAL_W_BASE
spd_box_clip.primitivetype   = "triangles"
spd_box_clip.init_pos        = {spd_box_bias, adi_ball_vert_fix, 0}
spd_box_clip.vertices        = spd_box_vertices
spd_box_clip.indices         = DEF_BOX_INDICES --{0,1,2,0,2,3 }
spd_box_clip.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
spd_box_clip.level           = EFIS_ADI_BAR_LEVEL + 1
spd_box_clip.isdraw          = true
spd_box_clip.isvisible       = false
spd_box_clip.use_mipfilter   = true
spd_box_clip.additive_alpha  = true
spd_box_clip.collimated      = false
AddToUpper(spd_box_clip)
spd_box_clip = nil


-- 速度框边线

local spd_box_frame       = CreateElement "ceTexPoly"
spd_box_frame.material    = MFCD_TEX_IND1
spd_box_frame.tex_coords  = MFCD_tex_coord(1676, 0, 158, 86, TEX_SIZE_X, TEX_SIZE_Y)
spd_box_frame.vertices    = {{ 263.333/2000,  143.333/2000},
                             { 263.333/2000, -143.333/2000},
                             {-263.333/2000, -143.333/2000},
                             {-263.333/2000,  143.333/2000}}
spd_box_frame.indices        = DEF_BOX_INDICES
--spd_box_frame.init_pos       = {spd_box_bias, adi_ball_vert_fix, 0}
spd_box_frame.init_pos       = {-745/1000 + 0.01, adi_ball_vert_fix, 0}
spd_box_frame.level          = EFIS_ADI_BAR_LEVEL + 2
spd_box_frame.isdraw         = true
spd_box_frame.isvisible      = true
spd_box_frame.use_mipfilter  = true
spd_box_frame.additive_alpha = true
AddToUpper(spd_box_frame)
spd_box_frame = nil



-- 当前速度
local spd_box_value           = CreateElement "ceStringPoly"
spd_box_value.name            = "adi_spd_box_value"
spd_box_value.material        = MFCD_FONT_G
spd_box_value.stringdefs      = MFCD_STRINGDEFS_DEF_X07
--spd_box_value.init_pos        = {spd_box_bias-adi_bar_idx_bias, adi_ball_vert_fix, 0}
spd_box_value.init_pos        = {spd_box_bias+adi_bar_idx_bias/2, adi_ball_vert_fix, 0}
spd_box_value.alignment       = "RightCenter"
spd_box_value.formats         = {"%03.0f","%s"}
spd_box_value.level           = EFIS_ADI_BAR_LEVEL + 2
spd_box_value.h_clip_relation = h_clip_relations.COMPARE
spd_box_value.value           = "0"
spd_box_value.controllers     = {{"adi_spd_value"},}
AddToUpper(spd_box_value)



----[[ 速度条 ]]
local adi_spdbar_bias     = adi_ball_offset-adi_bar_offset+adi_bar_spd_fix
local adi_spdbar_vertices = {{               0,  adi_barbox_hh},
                             {               0, -adi_barbox_hh},
                             {-2*adi_barbox_hw, -adi_barbox_hh},
                             {-2*adi_barbox_hw,  adi_barbox_hh}}

adi_spdbar_base                 = CreateElement "ceMeshPoly"
adi_spdbar_base.name            = "adi_spdbar_base"
adi_spdbar_base.material        = MFCD_MATERIAL_W_BASE
adi_spdbar_base.primitivetype   = "triangles"
adi_spdbar_base.init_pos        = {adi_spdbar_bias, adi_ball_vert_fix, 0}
adi_spdbar_base.vertices        = adi_spdbar_vertices
adi_spdbar_base.indices         = DEF_BOX_INDICES
adi_spdbar_base.h_clip_relation = h_clip_relations.REWRITE_LEVEL
adi_spdbar_base.level           = EFIS_ADI_BAR_LEVEL
adi_spdbar_base.collimated      = false
adi_spdbar_base.isvisible       = false
AddToUpper(adi_spdbar_base)
adi_spdbar_base = nil

--速度条clip层
adi_spdbar_clip                 = CreateElement "ceMeshPoly"
adi_spdbar_clip.name            = "adi_spdbar_clip"
adi_spdbar_clip.material        = MFCD_MATERIAL_W_BASE
adi_spdbar_clip.primitivetype   = "triangles"
adi_spdbar_clip.init_pos        = {adi_spdbar_bias, adi_ball_vert_fix, 0}
adi_spdbar_clip.vertices        = adi_spdbar_vertices
adi_spdbar_clip.indices         = DEF_BOX_INDICES
adi_spdbar_clip.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
adi_spdbar_clip.level           = EFIS_ADI_BAR_LEVEL
adi_spdbar_clip.collimated      = false
adi_spdbar_clip.isvisible       = false
AddToUpper(adi_spdbar_clip)
adi_spdbar_clip = nil


--速度条
local _dummyspd            = CreateElement "ceSimple"
_dummyspd.level            = EFIS_ADI_BAR_LEVEL + 1
_dummyspd.isvisible        = false
_dummyspd.init_pos         = {adi_spdbar_bias, adi_ball_vert_fix, 0}
_dummyspd.controllers      = {{"adi_spdbar_move", bar_dist_vert*2.0},} -- per 10 knots, bar for 5 knots
AddToUpper(_dummyspd)

adi_spd_scale_long0                 = CreateElement "ceMeshPoly"
adi_spd_scale_long0.name            = "adi_spd_scale_long_0"
adi_spd_scale_long0.material        = MFCD_MATERIAL_GREEN
adi_spd_scale_long0.primitivetype   = "triangles"
adi_spd_scale_long0.vertices        = {{            0,  adi_bar_width},
                                       {            0, -adi_bar_width},
                                       {-bar_len_long, -adi_bar_width},
                                       {-bar_len_long,  adi_bar_width},}
adi_spd_scale_long0.indices         = DEF_BOX_INDICES
--adi_spd_scale_long0.init_pos        = {adi_spdbar_bias, 0, 0}
adi_spd_scale_long0.h_clip_relation = h_clip_relations.COMPARE
adi_spd_scale_long0.level           = EFIS_ADI_BAR_LEVEL + 1
adi_spd_scale_long0.parent_element  = _dummyspd.name
adi_spd_scale_long0.isdraw          = true
adi_spd_scale_long0.isvisible       = true
adi_spd_scale_long0.use_mipfilter   = true
adi_spd_scale_long0.additive_alpha  = true
adi_spd_scale_long0.collimated      = false
adi_spd_scale_long0.controllers     = {{"adi_spd_boxclip", 0.06, adi_barbox_hh},}
AddToUpper(adi_spd_scale_long0)


adi_spd_scale_idx0                 = CreateElement "ceStringPoly"
adi_spd_scale_idx0.name            = "adi_spd_scale_idx_0"
adi_spd_scale_idx0.material        = MFCD_FONT_G
adi_spd_scale_idx0.stringdefs      = MFCD_STRINGDEFS_DEF_X075
adi_spd_scale_idx0.init_pos        = {-bar_len_long-adi_bar_idx_bias, 0, 0}
adi_spd_scale_idx0.alignment       = "RightCenter"
--adi_spd_scale_idx0.formats         = {"%02.0f","%s"}
adi_spd_scale_idx0.value           = "0"
adi_spd_scale_idx0.h_clip_relation = h_clip_relations.COMPARE
adi_spd_scale_idx0.level           = EFIS_ADI_BAR_LEVEL + 1
adi_spd_scale_idx0.parent_element  = _dummyspd.name
adi_spd_scale_idx0.isdraw          = true
adi_spd_scale_idx0.isvisible       = true
adi_spd_scale_idx0.use_mipfilter   = true
adi_spd_scale_idx0.additive_alpha  = true
adi_spd_scale_idx0.collimated      = false
adi_spd_scale_idx0.controllers     = {{"adi_spd_boxclip", 0.06, adi_barbox_hh},}
AddToUpper(adi_spd_scale_idx0)
adi_spd_scale_idx0 = nil


add_adi_bar_scale("spd", 100, -1, _dummyspd, EFIS_ADI_BAR_LEVEL+1, bar_len_long, bar_dist_vert, true, true, false)
add_adi_bar_scale("spd", 100, -1, _dummyspd, EFIS_ADI_BAR_LEVEL+1, bar_len_short, bar_dist_vert, false, false, false)
add_adi_bar_scale("spd",  10, -1, _dummyspd, EFIS_ADI_BAR_LEVEL+1, bar_len_long, bar_dist_vert, true, false, true)
add_adi_bar_scale("spd",  10, -1, _dummyspd, EFIS_ADI_BAR_LEVEL+1, bar_len_short, bar_dist_vert, false, false, true)



----========================================================----


----[[ 高度框 ]]
local alt_box_bias     = adi_ball_offset+adi_bar_offset+0.05+adi_bar_alt_fix
local alt_box_vertices = {{ 0.21,  0.05},
                          { 0.21, -0.05},
                          {-0.05, -0.05},
                          {-0.05,  0.05},}

local alt_box_base           = CreateElement "ceMeshPoly"
alt_box_base.name            = create_guid_string()
alt_box_base.material        = MFCD_MATERIAL_BOXBASE
alt_box_base.primitivetype   = "triangles"
alt_box_base.init_pos        = {alt_box_bias, adi_ball_vert_fix, 0}
alt_box_base.vertices        = alt_box_vertices
alt_box_base.indices         = DEF_BOX_INDICES --{0,1,2,0,2,3 }
alt_box_base.h_clip_relation = h_clip_relations.REWRITE_LEVEL
alt_box_base.level           = EFIS_ADI_BAR_LEVEL + 2
alt_box_base.isdraw          = true
alt_box_base.isvisible       = true
alt_box_base.use_mipfilter   = true
alt_box_base.additive_alpha  = false
alt_box_base.collimated      = false
AddToUpper(alt_box_base)
alt_box_base = nil

-- 高度框Mask
local alt_box_clip           = CreateElement "ceMeshPoly"
alt_box_clip.name            = create_guid_string()
alt_box_clip.material        = MFCD_MATERIAL_W_BASE
alt_box_clip.primitivetype   = "triangles"
alt_box_clip.init_pos        = {alt_box_bias, adi_ball_vert_fix, 0}
alt_box_clip.vertices        = alt_box_vertices
alt_box_clip.indices         = DEF_BOX_INDICES --{0,1,2,0,2,3 }
alt_box_clip.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
alt_box_clip.level           = EFIS_ADI_BAR_LEVEL + 1
alt_box_clip.isdraw          = true
alt_box_clip.isvisible       = false
alt_box_clip.use_mipfilter   = true
alt_box_clip.additive_alpha  = true
alt_box_clip.collimated      = false
AddToUpper(alt_box_clip)
alt_box_clip = nil


-- 高度框边线

local alt_box_frame       = CreateElement "ceTexPoly"
alt_box_frame.material    = MFCD_TEX_IND1
alt_box_frame.tex_coords  = MFCD_tex_coord(1834, 0, 200, 86, TEX_SIZE_X, TEX_SIZE_Y)
alt_box_frame.vertices    = {{ 333.333/2000,  143.333/2000},
                             { 333.333/2000, -143.333/2000},
                             {-333.333/2000, -143.333/2000},
                             {-333.333/2000,  143.333/2000}}
alt_box_frame.indices        = DEF_BOX_INDICES
--alt_box_frame.init_pos       = {spd_box_bias, adi_ball_vert_fix, 0}
alt_box_frame.init_pos       = {580/1000, adi_ball_vert_fix, 0}
alt_box_frame.level          = EFIS_ADI_BAR_LEVEL + 2
alt_box_frame.isdraw         = true
alt_box_frame.isvisible      = true
alt_box_frame.use_mipfilter  = true
alt_box_frame.additive_alpha = true
AddToUpper(alt_box_frame)
alt_box_frame = nil


-- 当前高度
local alt_box_value           = CreateElement "ceStringPoly"
alt_box_value.name            = "adi_alt_box_value"
alt_box_value.material        = MFCD_FONT_G
alt_box_value.stringdefs      = MFCD_STRINGDEFS_DEF_X07
--alt_box_value.init_pos        = {alt_box_bias+adi_bar_idx_bias+0.12, adi_ball_vert_fix, 0}
alt_box_value.init_pos        = {698.333/1000, adi_ball_vert_fix, 0}
alt_box_value.alignment       = "RightCenter"
alt_box_value.formats         = {"%5.0f","%s"}
alt_box_value.level           = EFIS_ADI_BAR_LEVEL + 2
alt_box_value.h_clip_relation = h_clip_relations.COMPARE
alt_box_value.value           = "0"
alt_box_value.controllers     = {{"adi_alt_value"},}
AddToUpper(alt_box_value)



----[[ 高度条 ]]
local adi_altbar_bias   = adi_ball_offset+adi_bar_offset+adi_bar_alt_fix
local adi_altbar_vertices = {{ 2*adi_barbox_hw,  adi_barbox_hh},
                             { 2*adi_barbox_hw, -adi_barbox_hh},
                             {               0, -adi_barbox_hh},
                             {               0,  adi_barbox_hh}}

adi_altbar_base                 = CreateElement "ceMeshPoly"
adi_altbar_base.name            = "adi_altbar_base"
adi_altbar_base.material        = MFCD_MATERIAL_W_BASE
adi_altbar_base.primitivetype   = "triangles"
adi_altbar_base.init_pos        = {adi_altbar_bias, adi_ball_vert_fix, 0}
adi_altbar_base.vertices        = adi_altbar_vertices
adi_altbar_base.indices         = DEF_BOX_INDICES
adi_altbar_base.h_clip_relation = h_clip_relations.REWRITE_LEVEL
adi_altbar_base.level           = EFIS_ADI_BAR_LEVEL
adi_altbar_base.collimated      = false
adi_altbar_base.isvisible       = false
AddToUpper(adi_altbar_base)
adi_altbar_base = nil

--高度条clip层
adi_altbar_clip                 = CreateElement "ceMeshPoly"
adi_altbar_clip.name            = "adi_altbar_clip"
adi_altbar_clip.material        = MFCD_MATERIAL_W_BASE
adi_altbar_clip.primitivetype   = "triangles"
adi_altbar_clip.init_pos        = {adi_altbar_bias, adi_ball_vert_fix, 0}
adi_altbar_clip.vertices        = adi_altbar_vertices
adi_altbar_clip.indices         = DEF_BOX_INDICES
adi_altbar_clip.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
adi_altbar_clip.level           = EFIS_ADI_BAR_LEVEL
adi_altbar_clip.collimated      = false
adi_altbar_clip.isvisible       = false
AddToUpper(adi_altbar_clip)
adi_altbar_clip = nil


--高度条
local _dummyalt            = CreateElement "ceSimple"
_dummyalt.level            = EFIS_ADI_BAR_LEVEL + 1
_dummyalt.isvisible        = false
_dummyalt.init_pos         = {adi_altbar_bias, adi_ball_vert_fix, 0}
_dummyalt.controllers      = {{"adi_altbar_move", bar_dist_vert*2.0},} -- per 100 feets, bar for 50 feets
AddToUpper(_dummyalt)

adi_alt_scale_long0                 = CreateElement "ceMeshPoly"
adi_alt_scale_long0.name            = "adi_alt_scale_long_0"
adi_alt_scale_long0.material        = MFCD_MATERIAL_GREEN
adi_alt_scale_long0.primitivetype   = "triangles"
adi_alt_scale_long0.vertices        = {{ bar_len_long,  adi_bar_width},
                                       { bar_len_long, -adi_bar_width},
                                       {            0, -adi_bar_width},
                                       {            0,  adi_bar_width},}
adi_alt_scale_long0.indices         = DEF_BOX_INDICES
--adi_alt_scale_long0.init_pos        = {0, 0, 0}
adi_alt_scale_long0.h_clip_relation = h_clip_relations.COMPARE
adi_alt_scale_long0.level           = EFIS_ADI_BAR_LEVEL + 1
adi_alt_scale_long0.parent_element  = _dummyalt.name
adi_alt_scale_long0.isdraw          = true
adi_alt_scale_long0.isvisible       = true
adi_alt_scale_long0.use_mipfilter   = true
adi_alt_scale_long0.additive_alpha  = true
adi_alt_scale_long0.collimated      = false
adi_alt_scale_long0.controllers     = {{"adi_alt_boxclip", 0.06, adi_barbox_hh},}
AddToUpper(adi_alt_scale_long0)


adi_alt_scale_idx0                 = CreateElement "ceStringPoly"
adi_alt_scale_idx0.name            = "adi_alt_scale_idx_0"
adi_alt_scale_idx0.material        = MFCD_FONT_G
adi_alt_scale_idx0.stringdefs      = MFCD_STRINGDEFS_DEF_X075
adi_alt_scale_idx0.init_pos        = {bar_len_long+adi_bar_idx_bias, 0, 0}
adi_alt_scale_idx0.alignment       = "LeftCenter"
--adi_alt_scale_idx0.formats         = {"%02.0f","%s"}
adi_alt_scale_idx0.value           = "0"
adi_alt_scale_idx0.h_clip_relation = h_clip_relations.COMPARE
adi_alt_scale_idx0.level           = EFIS_ADI_BAR_LEVEL + 1
adi_alt_scale_idx0.parent_element  = _dummyalt.name
adi_alt_scale_idx0.isdraw          = true
adi_alt_scale_idx0.isvisible       = true
adi_alt_scale_idx0.use_mipfilter   = true
adi_alt_scale_idx0.additive_alpha  = true
adi_alt_scale_idx0.collimated      = false
adi_alt_scale_idx0.controllers     = {{"adi_alt_boxclip", 0.06, adi_barbox_hh},}
AddToUpper(adi_alt_scale_idx0)
adi_alt_scale_idx0 = nil


add_adi_bar_scale("alt", 600, 1, _dummyalt, EFIS_ADI_BAR_LEVEL+1, bar_len_long, bar_dist_vert, true, true, false)
add_adi_bar_scale("alt", 600, 1, _dummyalt, EFIS_ADI_BAR_LEVEL+1, bar_len_short, bar_dist_vert, false, false, false)
add_adi_bar_scale("alt",  10, 1, _dummyalt, EFIS_ADI_BAR_LEVEL+1, bar_len_long, bar_dist_vert, true, true, true)
add_adi_bar_scale("alt",  10, 1, _dummyalt, EFIS_ADI_BAR_LEVEL+1, bar_len_short, bar_dist_vert, false, false, true)




----========================================================----



----[[ 航向框 ]]
local adi_hdgbar_up  = 0.65+adi_bar_hdg_fix
local hdg_box_bias   = adi_ball_offset
local hdg_box_upbias = 0.05
local hdg_box_offset = adi_hdgbar_up+bar_len_long+hdg_box_upbias
local hdg_box_vertices = {{ 0.1,  0.05},
                          { 0.1, -0.05},
                          {-0.1, -0.05},
                          {-0.1,  0.05},}

local hdg_box_base           = CreateElement "ceMeshPoly"
hdg_box_base.name            = create_guid_string()
hdg_box_base.material        = MFCD_MATERIAL_BOXBASE
hdg_box_base.primitivetype   = "triangles"
hdg_box_base.init_pos        = {hdg_box_bias, adi_ball_vert_fix+hdg_box_offset, 0}
hdg_box_base.vertices        = hdg_box_vertices
hdg_box_base.indices         = DEF_BOX_INDICES --{0,1,2,0,2,3 }
hdg_box_base.h_clip_relation = h_clip_relations.REWRITE_LEVEL
hdg_box_base.level           = EFIS_ADI_BAR_LEVEL + 2
hdg_box_base.isdraw          = true
hdg_box_base.isvisible       = true
hdg_box_base.use_mipfilter   = true
hdg_box_base.additive_alpha  = false
hdg_box_base.collimated      = false
AddToUpper(hdg_box_base)
hdg_box_base = nil

-- 航向框Mask
local hdg_box_clip           = CreateElement "ceMeshPoly"
hdg_box_clip.name            = create_guid_string()
hdg_box_clip.material        = MFCD_MATERIAL_W_BASE
hdg_box_clip.primitivetype   = "triangles"
hdg_box_clip.init_pos        = {hdg_box_bias, adi_ball_vert_fix+hdg_box_offset, 0}
hdg_box_clip.vertices        = hdg_box_vertices
hdg_box_clip.indices         = DEF_BOX_INDICES --{0,1,2,0,2,3 }
hdg_box_clip.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
hdg_box_clip.level           = EFIS_ADI_BAR_LEVEL + 1
hdg_box_clip.isdraw          = true
hdg_box_clip.isvisible       = false
hdg_box_clip.use_mipfilter   = true
hdg_box_clip.additive_alpha  = true
hdg_box_clip.collimated      = false
AddToUpper(hdg_box_clip)
hdg_box_clip = nil


-- 航向框边线

local hdg_box_frame       = CreateElement "ceTexPoly"
hdg_box_frame.material    = MFCD_TEX_IND1
hdg_box_frame.tex_coords  = MFCD_tex_coord(1676, 0, 158, 86, TEX_SIZE_X, TEX_SIZE_Y)
hdg_box_frame.vertices    = {{ 263.333/2000,  143.333/2000},
                             { 263.333/2000, -143.333/2000},
                             {-263.333/2000, -143.333/2000},
                             {-263.333/2000,  143.333/2000}}
hdg_box_frame.indices        = DEF_BOX_INDICES
--hdg_box_frame.init_pos       = {hdg_box_bias, adi_ball_vert_fix+hdg_box_offset, 0}
hdg_box_frame.init_pos       = {hdg_box_bias, adi_ball_vert_fix+hdg_box_offset, 0}
hdg_box_frame.level          = EFIS_ADI_BAR_LEVEL + 2
hdg_box_frame.isdraw         = true
hdg_box_frame.isvisible      = true
hdg_box_frame.use_mipfilter  = true
hdg_box_frame.additive_alpha = true
AddToUpper(hdg_box_frame)
hdg_box_frame = nil

-- 当前航向
local hdg_box_value           = CreateElement "ceStringPoly"
hdg_box_value.name            = "adi_hdg_box_value"
hdg_box_value.material        = MFCD_FONT_G
hdg_box_value.stringdefs      = MFCD_STRINGDEFS_DEF_X07
--hdg_box_value.init_pos        = {hdg_box_bias, adi_ball_vert_fix+hdg_box_offset, 0}
hdg_box_value.init_pos        = {hdg_box_bias, adi_ball_vert_fix+hdg_box_offset, 0}
hdg_box_value.alignment       = "CenterCenter"
hdg_box_value.formats         = {"%2.0f","%s"}
hdg_box_value.level           = EFIS_ADI_BAR_LEVEL + 2
hdg_box_value.h_clip_relation = h_clip_relations.COMPARE
hdg_box_value.value           = "0"
hdg_box_value.controllers     = {{"adi_hdg_value"},}
AddToUpper(hdg_box_value)




----[[ 航向条 ]]
local adi_hdgbar_bias     = adi_ball_offset
local adi_hdgbar_vertices = {{ (adi_barbox_hh+0.08)+0.02, 2*adi_barbox_hw},
                             { (adi_barbox_hh+0.08)+0.02, 0},
                             {-(adi_barbox_hh+0.08)-0.02, 0},
                             {-(adi_barbox_hh+0.08)-0.02, 2*adi_barbox_hw}}

adi_hdgbar_base                 = CreateElement "ceMeshPoly"
adi_hdgbar_base.name            = "adi_hdgbar_base"
adi_hdgbar_base.material        = MFCD_MATERIAL_W_BASE
adi_hdgbar_base.primitivetype   = "triangles"
adi_hdgbar_base.init_pos        = {adi_hdgbar_bias, adi_ball_vert_fix+adi_hdgbar_up, 0}
adi_hdgbar_base.vertices        = adi_hdgbar_vertices
adi_hdgbar_base.indices         = DEF_BOX_INDICES
adi_hdgbar_base.h_clip_relation = h_clip_relations.REWRITE_LEVEL
adi_hdgbar_base.level           = EFIS_ADI_BAR_LEVEL
adi_hdgbar_base.collimated      = false
adi_hdgbar_base.isvisible       = false
AddToUpper(adi_hdgbar_base)
adi_hdgbar_base = nil

--航向条clip层
adi_hdgbar_clip                 = CreateElement "ceMeshPoly"
adi_hdgbar_clip.name            = "adi_hdgbar_clip"
adi_hdgbar_clip.material        = MFCD_MATERIAL_W_BASE
adi_hdgbar_clip.primitivetype   = "triangles"
adi_hdgbar_clip.init_pos        = {adi_hdgbar_bias, adi_ball_vert_fix+adi_hdgbar_up, 0}
adi_hdgbar_clip.vertices        = adi_hdgbar_vertices
adi_hdgbar_clip.indices         = DEF_BOX_INDICES
adi_hdgbar_clip.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
adi_hdgbar_clip.level           = EFIS_ADI_BAR_LEVEL
adi_hdgbar_clip.collimated      = false
adi_hdgbar_clip.isvisible       = false
AddToUpper(adi_hdgbar_clip)
adi_hdgbar_clip = nil


--航向条
local _dummyhdg            = CreateElement "ceSimple"
_dummyhdg.level            = EFIS_ADI_BAR_LEVEL + 1
_dummyhdg.isvisible        = false
_dummyhdg.init_pos         = {adi_hdgbar_bias, adi_ball_vert_fix+adi_hdgbar_up, 0}
_dummyhdg.controllers      = {{"adi_hdgbar_move", bar_dist_hori*2.0},} -- per 10 deg, bar for 5 deg
AddToUpper(_dummyhdg)

adi_hdg_scale_long0                 = CreateElement "ceMeshPoly"
adi_hdg_scale_long0.name            = "adi_hdg_scale_long_0"
adi_hdg_scale_long0.material        = MFCD_MATERIAL_GREEN
adi_hdg_scale_long0.primitivetype   = "triangles"
adi_hdg_scale_long0.vertices        = {{ adi_bar_width, bar_len_long},
                                       { adi_bar_width, 0},
                                       {-adi_bar_width, 0},
                                       {-adi_bar_width, bar_len_long},}
adi_hdg_scale_long0.indices         = DEF_BOX_INDICES
--adi_hdg_scale_long0.init_pos        = {0, 0, 0}
adi_hdg_scale_long0.h_clip_relation = h_clip_relations.COMPARE
adi_hdg_scale_long0.level           = EFIS_ADI_BAR_LEVEL + 1
adi_hdg_scale_long0.parent_element  = _dummyhdg.name
adi_hdg_scale_long0.isdraw          = true
adi_hdg_scale_long0.isvisible       = true
adi_hdg_scale_long0.use_mipfilter   = true
adi_hdg_scale_long0.additive_alpha  = true
adi_hdg_scale_long0.collimated      = false
--adi_hdg_scale_long0.controllers     = {{"adi_hdgbar_move", bar_dist_hori},}
AddToUpper(adi_hdg_scale_long0)


adi_hdg_scale_idx0                 = CreateElement "ceStringPoly"
adi_hdg_scale_idx0.name            = "adi_hdg_scale_idx_0"
adi_hdg_scale_idx0.material        = MFCD_FONT_G
adi_hdg_scale_idx0.stringdefs      = MFCD_STRINGDEFS_DEF_X075
adi_hdg_scale_idx0.init_pos        = {0, bar_len_long+0.04, 0}
adi_hdg_scale_idx0.alignment       = "CenterCenter"
--adi_hdg_scale_idx0.formats         = {"%02.0f","%s"}
adi_hdg_scale_idx0.value           = "0"
adi_hdg_scale_idx0.h_clip_relation = h_clip_relations.COMPARE
adi_hdg_scale_idx0.level           = EFIS_ADI_BAR_LEVEL + 1
adi_hdg_scale_idx0.parent_element  = _dummyhdg.name
adi_hdg_scale_idx0.isdraw          = true
adi_hdg_scale_idx0.isvisible       = true
adi_hdg_scale_idx0.use_mipfilter   = true
adi_hdg_scale_idx0.additive_alpha  = true
adi_hdg_scale_idx0.collimated      = false
adi_hdg_scale_idx0.controllers     = {{"adi_hdg_boxclip", 0.11+0.03, adi_ball_offset},}
AddToUpper(adi_hdg_scale_idx0)
adi_hdg_scale_idx0 = nil


-- 01 to 18
add_adi_bar_scale("hdg", 18+2, 1, _dummyhdg, EFIS_ADI_BAR_LEVEL+1, bar_len_long, bar_dist_hori, true, true, false)
add_adi_bar_scale("hdg", 19+2, 1, _dummyhdg, EFIS_ADI_BAR_LEVEL+1, bar_len_short, bar_dist_hori, false, false, false)
-- 35 to 18
add_adi_bar_scale("hdg", 18+2, 1, _dummyhdg, EFIS_ADI_BAR_LEVEL+1, bar_len_long, bar_dist_hori, true, true, true)
add_adi_bar_scale("hdg", 19+2, 1, _dummyhdg, EFIS_ADI_BAR_LEVEL+1, bar_len_short, bar_dist_hori, false, false, true)




----========================================================----


----[[ 垂直速度条 ]]
local adi_vvsbar_bias = adi_ball_offset+adi_bar_offset+0.35
local adi_vvsbar_vertices = {{ 2*adi_barbox_hw,  adi_barbox_hh},
                             { 2*adi_barbox_hw, -adi_barbox_hh},
                             {               0, -adi_barbox_hh},
                             {               0,  adi_barbox_hh}}

adi_vvsbar_base                 = CreateElement "ceMeshPoly"
adi_vvsbar_base.name            = "adi_vvsbar_base"
adi_vvsbar_base.material        = MFCD_MATERIAL_W_BASE
adi_vvsbar_base.primitivetype   = "triangles"
adi_vvsbar_base.init_pos        = {adi_vvsbar_bias, adi_ball_vert_fix, 0}
adi_vvsbar_base.vertices        = adi_vvsbar_vertices
adi_vvsbar_base.indices         = DEF_BOX_INDICES
adi_vvsbar_base.h_clip_relation = h_clip_relations.REWRITE_LEVEL
adi_vvsbar_base.level           = EFIS_ADI_BAR_LEVEL
adi_vvsbar_base.collimated      = false
adi_vvsbar_base.isvisible       = false
AddToUpper(adi_vvsbar_base)
adi_vvsbar_base = nil

--垂直速度条clip层
adi_vvsbar_clip                 = CreateElement "ceMeshPoly"
adi_vvsbar_clip.name            = "adi_vvsbar_clip"
adi_vvsbar_clip.material        = MFCD_MATERIAL_W_BASE
adi_vvsbar_clip.primitivetype   = "triangles"
adi_vvsbar_clip.init_pos        = {adi_vvsbar_bias, adi_ball_vert_fix, 0}
adi_vvsbar_clip.vertices        = adi_vvsbar_vertices
adi_vvsbar_clip.indices         = DEF_BOX_INDICES
adi_vvsbar_clip.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
adi_vvsbar_clip.level           = EFIS_ADI_BAR_LEVEL
adi_vvsbar_clip.collimated      = false
adi_vvsbar_clip.isvisible       = false
AddToUpper(adi_vvsbar_clip)
adi_vvsbar_clip = nil

adi_vvs_scale_long0                 = CreateElement "ceMeshPoly"
adi_vvs_scale_long0.name            = "adi_vvs_scale_long_0"
adi_vvs_scale_long0.material        = MFCD_MATERIAL_GREEN
adi_vvs_scale_long0.primitivetype   = "triangles"
adi_vvs_scale_long0.vertices        = {{ bar_len_short,  adi_bar_width},
                                       { bar_len_short, -adi_bar_width},
                                       {             0, -adi_bar_width},
                                       {             0,  adi_bar_width},}
adi_vvs_scale_long0.indices         = DEF_BOX_INDICES
adi_vvs_scale_long0.init_pos        = {adi_vvsbar_bias, adi_ball_vert_fix, 0}
adi_vvs_scale_long0.h_clip_relation = h_clip_relations.COMPARE
adi_vvs_scale_long0.level           = EFIS_ADI_BAR_LEVEL + 1
adi_vvs_scale_long0.isdraw          = true
adi_vvs_scale_long0.isvisible       = true
adi_vvs_scale_long0.use_mipfilter   = true
adi_vvs_scale_long0.additive_alpha  = true
adi_vvs_scale_long0.collimated      = false
--adi_vvs_scale_long0.controllers     = {{"adi_vvsbar_move"},}
AddToUpper(adi_vvs_scale_long0)


adi_vvs_scale_idx0                 = CreateElement "ceStringPoly"
adi_vvs_scale_idx0.name            = "adi_vvs_scale_idx_0"
adi_vvs_scale_idx0.material        = MFCD_FONT_G
adi_vvs_scale_idx0.stringdefs      = MFCD_STRINGDEFS_DEF_X075
adi_vvs_scale_idx0.init_pos        = {bar_len_short+0.02, 0, 0}
adi_vvs_scale_idx0.alignment       = "LeftCenter"
--adi_vvs_scale_idx0.formats         = {"%02.0f","%s"}
adi_vvs_scale_idx0.value           = "0"
adi_vvs_scale_idx0.h_clip_relation = h_clip_relations.COMPARE
adi_vvs_scale_idx0.level           = EFIS_ADI_BAR_LEVEL + 1
adi_vvs_scale_idx0.parent_element  = adi_vvs_scale_long0.name
adi_vvs_scale_idx0.isdraw          = true
adi_vvs_scale_idx0.isvisible       = true
adi_vvs_scale_idx0.use_mipfilter   = true
adi_vvs_scale_idx0.additive_alpha  = true
adi_vvs_scale_idx0.collimated      = false
AddToUpper(adi_vvs_scale_idx0)
adi_vvs_scale_idx0 = nil

add_adi_bar_scale("vvs", 2, 1, adi_vvs_scale_long0, EFIS_ADI_BAR_LEVEL + 1, bar_len_short, 0.05, true, true, false)
add_adi_bar_scale("vvs", 2, 1, adi_vvs_scale_long0, EFIS_ADI_BAR_LEVEL + 1, bar_len_short*0.8, 0.05, false, false, false)
add_adi_bar_scale("vvs", 2, 1, adi_vvs_scale_long0, EFIS_ADI_BAR_LEVEL + 1, bar_len_short, 0.05, true, true, true)
add_adi_bar_scale("vvs", 2, 1, adi_vvs_scale_long0, EFIS_ADI_BAR_LEVEL + 1, bar_len_short*0.8, 0.05, false, false, true)

-- vvs三角指示符号

local adi_vvs_delta       = CreateElement "ceTexPoly"
adi_vvs_delta.material    = MFCD_TEX_IND1
adi_vvs_delta.tex_coords  = MFCD_tex_coord(608, 584, 70, 76, TEX_SIZE_X, TEX_SIZE_Y)
adi_vvs_delta.vertices    = {{ 116.667/2000,  126.667/2000},
                             { 116.667/2000, -126.667/2000},
                             {-116.667/2000, -126.667/2000},
                             {-116.667/2000,  126.667/2000}}
adi_vvs_delta.indices     = DEF_BOX_INDICES
--adi_vvs_delta.init_pos    = {adi_vvsbar_bias, adi_ball_vert_fix, 0}
adi_vvs_delta.init_pos    = {778.333/1000, adi_ball_vert_fix, 0}
adi_vvs_delta.init_rot    = {0, 0, 0}
--adi_vvs_delta.h_clip_relation  = h_clip_relations.REWRITE_LEVEL
--adi_vvs_delta.level            = EFIS_ADI_BAR_LEVEL + 2
adi_vvs_delta.controllers = {{"adi_vvs_indicator"},}
AddToUpper(adi_vvs_delta)
adi_vvs_delta = nil




----========================================================----


-- AoA Indicator
local efis_aoa_value           = CreateElement "ceStringPoly"
efis_aoa_value.name            = "efis_aoa_value"
efis_aoa_value.material        = MFCD_FONT_G
efis_aoa_value.stringdefs      = MFCD_STRINGDEFS_DEF_X075
efis_aoa_value.init_pos        = {adi_ball_offset-0.55+adi_bar_spd_fix, adi_ball_vert_fix+0.43, 0}
efis_aoa_value.alignment       = "RightCenter"
efis_aoa_value.formats         = {"%s"}
efis_aoa_value.level           = EFIS_ADI_BAR_LEVEL + 2
--efis_aoa_value.h_clip_relation = h_clip_relations.COMPARE
efis_aoa_value.value           = "AOA"
efis_aoa_value.controllers     = {{"efis_aoa_disp"},}
AddToUpper(efis_aoa_value)


-- Mach Indicator
local efis_mach_value           = CreateElement "ceStringPoly"
efis_mach_value.name            = "efis_mach_value"
efis_mach_value.material        = MFCD_FONT_G
efis_mach_value.stringdefs      = MFCD_STRINGDEFS_DEF_X075
efis_mach_value.init_pos        = {adi_ball_offset-adi_bar_offset+adi_bar_spd_fix, adi_ball_vert_fix-adi_barbox_hh-0.08, 0}
efis_mach_value.alignment       = "RightCenter"
efis_mach_value.formats         = {"%s"}
efis_mach_value.level           = EFIS_ADI_BAR_LEVEL + 2
--efis_mach_value.h_clip_relation = h_clip_relations.COMPARE
efis_mach_value.value           = "M"
efis_mach_value.controllers     = {{"efis_mach_disp"},}
AddToUpper(efis_mach_value)


-- Hgin Indicator
local efis_mach_value           = CreateElement "ceStringPoly"
efis_mach_value.name            = "efis_hgin_value"
efis_mach_value.material        = MFCD_FONT_G
efis_mach_value.stringdefs      = MFCD_STRINGDEFS_DEF_X075
efis_mach_value.init_pos        = {adi_ball_offset+adi_bar_offset-0.04+adi_bar_alt_fix, adi_ball_vert_fix-adi_barbox_hh-0.08, 0}
efis_mach_value.alignment       = "LeftCenter"
efis_mach_value.formats         = {"%s"}
efis_mach_value.level           = EFIS_ADI_BAR_LEVEL + 2
--efis_mach_value.h_clip_relation = h_clip_relations.COMPARE
efis_mach_value.value           = "0.00 IN"
efis_mach_value.controllers     = {{"efis_hgin_disp"},}
AddToUpper(efis_mach_value)



