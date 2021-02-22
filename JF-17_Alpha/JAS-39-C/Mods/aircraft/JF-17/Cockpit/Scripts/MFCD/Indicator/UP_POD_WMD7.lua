dofile(LockOn_Options.script_path .. "MFCD/MFCDs_defs.lua")

local page_root = create_page_root()

local WHITE    = "mfcd_tex_basic_w" --MakeMaterial(IndTexture_Path.."label_basic.dds", MFCD_COLOR_WHITE_Y)
local DARK     = "mfcd_tex_basic_bk" --MakeMaterial(IndTexture_Path.."label_basic.dds", MFCD_COLOR_DARK)
local DEFAULT  = "mfcd_tex_basic" --MakeMaterial(IndTexture_Path.."label_basic.dds", MFCD_COLOR_DEF)


MFCD_TEX_IND3 = "mfcd_tex_ind3"
MFCD_TEX_IND4 = "mfcd_tex_ind4"

TEX_SIZE_X = 2048
TEX_SIZE_Y = 2048


local BASIC_TEX_SIZE_X = 1080
local BASIC_TEX_SIZE_Y = 1080


local hw     = 1.0
local clip_verts  = {{-hw, hw},{ hw, hw},{ hw, -hw*0.855},{-hw, -hw*0.855}}
local verts  = {{-hw, hw},{ hw, hw},{ hw, -hw},{-hw, -hw}}

local tv_render_clip           = CreateElement "ceMeshPoly"
tv_render_clip.name            = create_guid_string()
tv_render_clip.material        = MFCD_MATERIAL_W_BASE
tv_render_clip.primitivetype   = "triangles"
tv_render_clip.init_pos        = {0, 0, 0}
tv_render_clip.vertices        = {{-1,  0.8875}, 
                                  { 1,  0.8875},
                                  { 1, -0.8875}, 
                                  {-1, -0.8875}}
tv_render_clip.indices         = DEF_BOX_INDICES --{0,1,2,0,2,3}
tv_render_clip.h_clip_relation = h_clip_relations.REWRITE_LEVEL
tv_render_clip.level           = PAGE_LEVEL_POD
tv_render_clip.isdraw          = true
tv_render_clip.isvisible       = false
tv_render_clip.use_mipfilter   = true
tv_render_clip.additive_alpha  = true
tv_render_clip.collimated      = false
AddToUpper(tv_render_clip)


local TV_RENDER           = CreateElement "ceTexPoly"
TV_RENDER.name            = "TV_RENDER"
TV_RENDER.init_pos        = {0, 0, 0}
TV_RENDER.vertices        = {{-1,  0.8875},
                             { 1,  0.8875},
                             { 1, -0.8875}, 
                             {-1, -0.8875}}
TV_RENDER.tex_coords      = {{0, 0.5 * (1 - 0.8875)},
                             {1, 0.5 * (1 - 0.8875)},
                             {1, 1 - 0.5 * (1 - 0.8875)},
                             {0, 1 - 0.5 * (1 - 0.8875)}}
TV_RENDER.indices         = DEF_BOX_INDICES
--TV_RENDER.material        = "render_target_"..tostring(GetRenderTarget() + 1)
TV_RENDER.material        = "WMD_Material_" .. tostring(GetRenderTarget())
TV_RENDER.level           = PAGE_LEVEL_POD
TV_RENDER.h_clip_relation = h_clip_relations.COMPARE
TV_RENDER.additive_alpha  = true
TV_RENDER.controllers     = {{'POD_wmd_video_check'},}
AddToUpper(TV_RENDER)


local osb_txt = {
    {
        name="WMD_LABEL", value="WMD7",          init_pos={MFCD_FONT_UD1_X,    MFCD_FONT_U_Y  }, align="CenterCenter", ctrls={},
    },
    {
        name="WMD_MODE",  value="MODE",          init_pos={MFCD_FONT_UD2_X,    MFCD_FONT_U_Y  }, align="CenterCenter", ctrls={{"POD_wmd_mode"},},
    },
    {
        name='WMD_SP',    value='SP',            init_pos={MFCD_FONT_UD3_X,    MFCD_FONT_U_Y  }, align='CenterCenter', ctrls={{'POD_wmd_snowplow',},},
    },
    {
        name="WMD_wbhot", value="WHOT",          init_pos={MFCD_FONT_UD4_X,    MFCD_FONT_U_Y  }, align="CenterCenter", ctrls={{"POD_wmd_WBHOT"},},},
    {
        name="WMD_FOV",   value="NAR",           init_pos={MFCD_FONT_R_HORI_X, MFCD_FONT_LR1_Y}, align="RightCenter",  ctrls={{"POD_wmd_fov" },{"POD_wmd_check"},},
    }, --宽窄视场
    {
        name="WMD_LSS",   value="L\nS\nS",       init_pos={MFCD_FONT_R_HORI_X, MFCD_FONT_LR2_Y}, align="RightCenter",  ctrls={{"POD_wmd_LSS" },{"POD_wmd_check"},},
    }, --LSS
    {
        name="WMD_CODE",  value="C\nO\nD\nE",    init_pos={MFCD_FONT_R_HORI_X, MFCD_FONT_LR3_Y}, align="RightCenter",  ctrls={{"POD_wmd_check"},},
    }, --设置code
    {
        name="WMD_LSRMAN",value="A\nU\nT\nO",    init_pos={MFCD_FONT_R_HORI_X, MFCD_FONT_LR4_Y}, align="RightCenter",  ctrls={{"POD_wmd_LSR_MODE" },{"POD_wmd_check"},},
    }, --自动/手动照射
    {
        name="WMD_UNCAGE",value="C\nA\nG\nE",    init_pos={MFCD_FONT_L_HORI_X, MFCD_FONT_LR1_Y}, align="LeftCenter",   ctrls={{"POD_wmd_uncage"},{"POD_wmd_check"},},
    }, --uncage
    
    {
        name='WMD_GAIN',  value="0",     init_pos={MFCD_FONT_L_HORI_X, (MFCD_FONT_LR2_Y + MFCD_FONT_LR3_Y)/2}, align="LeftCenter",
        ctrls={{'POD_wmd_params', 1.0},},
    },
    {
        name='WMD_LEVEL', value="0",     init_pos={MFCD_FONT_L_HORI_X, (MFCD_FONT_LR4_Y + MFCD_FONT_LR5_Y)/2}, align="LeftCenter",
        ctrls={{'POD_wmd_params', 2.0},},
    },
    {
        name='WMD_REFCOS',value="RE\nFOCUS",init_pos={MFCD_FONT_R_HORI_X, MFCD_FONT_LR5_Y}, align="RightCenter",
        ctrls={{'POD_wmd_check_focusing'},},
    },
    --{
    --    name="WMD_LSRIR", value="L\nS\nR\nI\nR", init_pos={MFCD_FONT_L_HORI_X, MFCD_FONT_LR2_Y}, align="LeftCenter",   ctrls={{"POD_wmd_check"},},
    --}, --设置laser / IR
}

local text_strpoly
local mesh_poly

for i=1, #(osb_txt) do
    text_strpoly                    = CreateElement "ceStringPoly"
    text_strpoly.material           = MFCD_FONT_W
    text_strpoly.BackgroundMaterial = MFCD_MATERIAL_BLACK
    text_strpoly.stringdefs         = MFCD_STRINGDEFS_DEF_X08
    text_strpoly.init_pos           = osb_txt[i].init_pos
    text_strpoly.alignment          = osb_txt[i].align

    if osb_txt[i].ctrls == nil then
        osb_txt[i].ctrls = {}
    end
    osb_txt[i].ctrls[#osb_txt[i].ctrls + 1] = {"string_background_color", 0,0,0}
    osb_txt[i].ctrls[#osb_txt[i].ctrls + 1] = {"mfcd_isedit_show", 0}
    text_strpoly.controllers = osb_txt[i].ctrls
    
    if osb_txt[i].value ~= nil then
        text_strpoly.value = osb_txt[i].value
    else
        text_strpoly.value = "OSB" .. i
    end
    AddToUpper(text_strpoly)
    text_strpoly = nil
end

local info_txt = {
    {value="state",       bkgrounded = true , init_pos = {     0.0,  0.0*0.80/2.5}, align="CenterCenter", ctrls={{"POD_wmd_state_txt"},}, stringdefs = MFCD_STRINGDEFS_DEF,},
    {value="LL_COORD",    bkgrounded = true , init_pos = {-4*1.0/5,  2.0*0.80/2.5}, align="LeftCenter",   ctrls={{"POD_wmd_aim_latlong"},{"POD_wmd_check"},},},
    {value="RANGE",       bkgrounded = true , init_pos = {       0,  2.0*0.80/2.5}, align="LeftCenter",   ctrls={{"POD_wmd_aim_range"},{"POD_wmd_check"},},},
    {value="TRACK_MODE",  bkgrounded = true , init_pos = { 0*1.0/5, -2.0*0.80/2.5}, align="CenterCenter", ctrls={{"POD_wmd_track"},{"POD_wmd_check"},},},
    {value="LASER_CODE",  bkgrounded = true , init_pos = { 0*1.0/5, -2.5*0.80/2.5}, align="CenterCenter", ctrls={{"POD_wmd_code"},{"POD_wmd_check"},},},
    {value="LASER_IR",    bkgrounded = true , init_pos = {-2*1.0/5, -2.0*0.80/2.5}, align="LeftCenter",   ctrls={{"POD_wmd_laser_ir"},{"POD_wmd_check"},},},
--  {value="AZEL",        bkgrounded = false, init_pos = {-4*1.0/5,  0.0*0.80/2.5}, align="LeftCenter",   ctrls={{"POD_wmd_azel_text"},{"POD_wmd_check"},},},
    {value="TRAIN_CMBT",  bkgrounded = true , init_pos = {-4*1.0/5, -2.5*0.80/2.5}, align="LeftCenter",   ctrls={{"POD_wmd_arm_state"},{"POD_wmd_check"},},},
}

for i=1, #(info_txt) do
    text_strpoly                = CreateElement "ceStringPoly"
    text_strpoly.material       = MFCD_FONT_W
    text_strpoly.stringdefs     = MFCD_STRINGDEFS_DEF
    text_strpoly.init_pos       = info_txt[i].init_pos
    text_strpoly.alignment      = info_txt[i].align

    if info_txt[i].stringdefs then
        text_strpoly.stringdefs = info_txt[i].stringdefs
    end
    if info_txt[i].ctrls == nil then
        info_txt[i].ctrls = {}
    end
    
    if info_txt[i].bkgrounded then
        text_strpoly.BackgroundMaterial = MFCD_MATERIAL_BLACK
        info_txt[i].ctrls[#info_txt[i].ctrls + 1] = {"string_background_color", 0,0,0}
    end
    
    if info_txt[i].ctrls then
        text_strpoly.controllers = info_txt[i].ctrls
    end

    if info_txt[i].value ~= nil then
        text_strpoly.value = info_txt[i].value
    else
        text_strpoly.value = "INFO" .. i
    end
    AddToUpper(text_strpoly)
    text_strpoly = nil
end

local CS = 0.025
local LS = 5/8

local MFCD_TEX_IND1  = "mfcd_tex_ind1"
local MFCD_TEX_IND1_SIZE_X = 2048
local MFCD_TEX_IND1_SIZE_Y = 2048

local tex_polys = {
    { -- gain +
        material = MFCD_TEX_IND1,
        init_pos={MFCD_BOX3_L_VERT_X, MFCD_FONT_LR2_Y},
        vertices = {{113.333/2000, 113.333/2000}, {113.333/2000, -113.333/2000}, {-113.333/2000, -113.333/2000}, {-113.333/2000, 113.333/2000}},
        tex_coords = MFCD_tex_coord(1196, 1596, 68, 68, MFCD_TEX_IND1_SIZE_X, MFCD_TEX_IND1_SIZE_Y),
        ctrls = {{'POD_wmd_check'}, {"mfcd_isedit_show", 0}},
    },
    { -- gain -
        material = MFCD_TEX_IND1,
        init_pos={MFCD_BOX3_L_VERT_X, MFCD_FONT_LR3_Y},
        vertices = {{113.333/2000, 113.333/2000}, {113.333/2000, -113.333/2000}, {-113.333/2000, -113.333/2000}, {-113.333/2000, 113.333/2000}},
        tex_coords = MFCD_tex_coord(1196, 1664, 68, 68, MFCD_TEX_IND1_SIZE_X, MFCD_TEX_IND1_SIZE_Y),
        ctrls = {{'POD_wmd_check'}, {"mfcd_isedit_show", 0}},
    },
    { -- level +
        material = MFCD_TEX_IND1,
        init_pos={MFCD_BOX3_L_VERT_X, MFCD_FONT_LR4_Y},
        vertices = {{113.333/2000, 113.333/2000}, {113.333/2000, -113.333/2000}, {-113.333/2000, -113.333/2000}, {-113.333/2000, 113.333/2000}},
        tex_coords = MFCD_tex_coord(1196, 1596, 68, 68, MFCD_TEX_IND1_SIZE_X, MFCD_TEX_IND1_SIZE_Y),
        ctrls = {{'POD_wmd_check'}, {"mfcd_isedit_show", 0}},
    },
    { -- level -
        material = MFCD_TEX_IND1,
        init_pos={MFCD_BOX3_L_VERT_X, MFCD_FONT_LR5_Y},
        vertices = {{113.333/2000, 113.333/2000}, {113.333/2000, -113.333/2000}, {-113.333/2000, -113.333/2000}, {-113.333/2000, 113.333/2000}},
        tex_coords = MFCD_tex_coord(1196, 1664, 68, 68, MFCD_TEX_IND1_SIZE_X, MFCD_TEX_IND1_SIZE_Y),
        ctrls = {{'POD_wmd_check'}, {"mfcd_isedit_show", 0}},
    },

    {
        init_pos={0, 0, 0}, vertices = {{0.25, 0.005}, {0.25, -0.005}, {-0.25, -0.005}, {-0.25, 0.005}},
        material = WHITE, tex_coords = MFCD_tex_coord(140, 330, 278 - 140, 338 - 330, 1080, 1080),
        ctrls={{"POD_wmd_TDC"}, {"POD_wmd_check"},},
    }, -- 十字横线
    {
        init_pos={0, 0, 0}, vertices = {{0.005, 0.25}, {0.005, -0.25}, {-0.005, -0.25}, {-0.005, 0.25}}, 
        material = WHITE, tex_coords = MFCD_tex_coord(140, 350, 143 - 140, 443 - 350, 1080, 1080),
        ctrls={{"POD_wmd_TDC"}, {"POD_wmd_check"},},
    }, -- 十字竖线
    
    {
        init_pos={-0.25, 0.25, 0}, vertices = {{CS, CS}, {CS, -CS}, {-CS, -CS}, {-CS, CS}}, 
        material = WHITE, tex_coords = MFCD_tex_coord(107, 326, 125 - 107, 344 - 326, 1080, 1080),
        ctrls={{"POD_wmd_check_lock", 1.0,-1.0, CS},{"POD_wmd_check"},},
    }, -- 左上角
    {
        init_pos={ 0.25, 0.25, 0}, vertices = {{CS, CS}, {CS, -CS}, {-CS, -CS}, {-CS, CS}},
        material = WHITE, tex_coords = MFCD_tex_coord(114, 442, 132 - 114, 460 - 442, 1080, 1080),
        ctrls={{"POD_wmd_check_lock", 1.0, 1.0, CS},{"POD_wmd_check"},},
    }, -- 右上角
    {
        init_pos={-0.25,-0.25, 0}, vertices = {{CS, CS}, {CS, -CS}, {-CS, -CS}, {-CS, CS}},
        material = WHITE, tex_coords = MFCD_tex_coord(107, 450, 125 - 107, 468 - 450, 1080, 1080),
        ctrls={{"POD_wmd_check_lock",-1.0,-1.0, CS},{"POD_wmd_check"},},
    }, -- 左下角
    {
        init_pos={ 0.25,-0.25, 0}, vertices = {{CS, CS}, {CS, -CS}, {-CS, -CS}, {-CS, CS}},
        material = WHITE, tex_coords = MFCD_tex_coord(114, 334, 132 - 114, 352 - 334, 1080, 1080),
        ctrls={{"POD_wmd_check_lock", -1.0,1.0, CS},{"POD_wmd_check"},},
    }, -- 右下角
    {
        init_pos={0, 0, 0}, vertices = {{0.01, 0.01}, {0.01, -0.01}, {-0.01, -0.01}, {-0.01, 0.01}},
        material = WHITE, tex_coords = MFCD_tex_coord(107, 366, 117 - 107, 376 - 366, 1080, 1080),
        ctrls={{"POD_wmd_sa_point"},{"POD_wmd_check"},},
    }, -- tdc标
}
local tex_poly
for i=1, #(tex_polys) do
    tex_poly              = CreateElement "ceTexPoly"
    tex_poly.material     = WHITE
    if tex_polys[i].material ~= nil then
        tex_poly.material = tex_polys[i].material
    end
    tex_poly.vertices     = tex_polys[i].vertices
    tex_poly.tex_coords   = tex_polys[i].tex_coords
    tex_poly.init_pos     = {0, 0, 0}

    if tex_polys[i].init_pos ~= nil then
        tex_poly.init_pos = tex_polys[i].init_pos
    end
    
    if tex_polys[i].ctrls  then
        tex_poly.controllers = tex_polys[i].ctrls
    end
    
    tex_poly.indices     = DEF_BOX_INDICES
    AddToUpper(tex_poly)
    tex_poly = nil
end

-- 中心跳动的方框
local wmd7_designate_box           = CreateElement "ceSimpleLineObject"
wmd7_designate_box.material        = MFCD_MATERIAL_WHITE
wmd7_designate_box.width           = 0.005
wmd7_designate_box.init_pos        = {0, 0, 0}
wmd7_designate_box.controllers     = {{"POD_wmd_designate_box", 0.5, 0.75, 0.5}, {'POD_wmd_video_check'}, }
AddToUpper(wmd7_designate_box)

-- el指示
local sym_hw = 150/2000
local sym_hh = 100/2000
tex_poly                = CreateElement "ceTexPoly"
tex_poly.material       = MFCD_TEX_IND4
tex_poly.tex_coords     = MFCD_tex_coord(1136, 442, 90, 60, TEX_SIZE_X, TEX_SIZE_Y)
tex_poly.indices        = DEF_BOX_INDICES
tex_poly.vertices       = {{ sym_hw,  sym_hh},
                           { sym_hw, -sym_hh},
                           {-sym_hw, -sym_hh},
                           {-sym_hw,  sym_hh},}
tex_poly.init_pos       = {-1.0, 0, 0}
tex_poly.controllers    = {{"POD_wmd_azel", 1}, {"mfcd_isedit_show", 0}}
tex_poly.isdraw         = false
tex_poly.use_mipfilter  = true
tex_poly.additive_alpha = false
AddToUpper(tex_poly)
tex_poly = nil

-- az指示
local sym_hw = 113.333/2000
local sym_hh = 136.667/2000
tex_poly                = CreateElement "ceTexPoly"
tex_poly.material       = MFCD_TEX_IND4
tex_poly.tex_coords     = MFCD_tex_coord(1136, 502, 68, 82, TEX_SIZE_X, TEX_SIZE_Y)
tex_poly.indices        = DEF_BOX_INDICES
tex_poly.vertices       = {{ sym_hw,  sym_hh},
                           { sym_hw, -sym_hh},
                           {-sym_hw, -sym_hh},
                           {-sym_hw,  sym_hh},}
tex_poly.init_pos       = {0, -0.8875, 0}
tex_poly.controllers    = {{"POD_wmd_azel", 2}, {"mfcd_isedit_show", 0}}
tex_poly.isdraw         = false
tex_poly.use_mipfilter  = true
tex_poly.additive_alpha = false
AddToUpper(tex_poly)
tex_poly = nil
----
