dofile(LockOn_Options.script_path .. "MFCD/avMFCD.lua")
dofile(LockOn_Options.script_path .. "MFCD/MFCDs_defs.lua")


local page_root = create_page_root()

MFCD_TEX_IND1    = "mfcd_tex_ind1"
MFCD_TEX_IND1_W  = "mfcd_tex_ind1_w"
MFCD_TEX_IND1_G  = "mfcd_tex_ind1_g"
MFCD_TEX_IND1_Y  = "mfcd_tex_ind1_y"
MFCD_TEX_IND1_R  = "mfcd_tex_ind1_r"

MFCD_TEX_IND2    = "mfcd_tex_ind2"
MFCD_TEX_IND2_W  = "mfcd_tex_ind2_w"
MFCD_TEX_IND2_G  = "mfcd_tex_ind2_g"
MFCD_TEX_IND2_Y  = "mfcd_tex_ind2_y"
MFCD_TEX_IND2_R  = "mfcd_tex_ind2_r"

MFCD_TEX_IND3    = "mfcd_tex_ind3"
MFCD_TEX_IND3_W  = "mfcd_tex_ind3_w"
MFCD_TEX_IND3_G  = "mfcd_tex_ind3_g"
MFCD_TEX_IND3_BL = "mfcd_tex_ind3_bl"
MFCD_TEX_IND3_Y  = "mfcd_tex_ind3_y"
MFCD_TEX_IND3_R  = "mfcd_tex_ind3_r"

TEX_SIZE_X = 2048
TEX_SIZE_Y = 2048

HSD_NAV_LEVEL = PAGE_LEVEL_HSD

-- for sym display range
HSD_NAV_LEVEL_SHIFT = 1


-----------==========================================


----[[ 前向 ]]

FWD_COMP_BIAS  = -306.667/1000 -- -0.36
FWD_COMP_BIAS  = -0.3125

------[[ 移动地图 ]]

local tv_render_clip           = CreateElement "ceMeshPoly"
tv_render_clip.name            = create_guid_string()
tv_render_clip.material        = MFCD_MATERIAL_W_BASE
tv_render_clip.primitivetype   = "triangles"
tv_render_clip.init_pos        = {0, FWD_COMP_BIAS, 0}
tv_render_clip.vertices        = {{-1,  1.2}, 
                                  { 1,  1.2},
                                  { 1, -1.5}, 
                                  {-1, -1.5}}
tv_render_clip.indices         = DEF_BOX_INDICES --{0,1,2,0,2,3 }
tv_render_clip.h_clip_relation = h_clip_relations.REWRITE_LEVEL
tv_render_clip.level           = HSD_NAV_LEVEL - 1
tv_render_clip.isdraw          = true
tv_render_clip.isvisible       = false
tv_render_clip.use_mipfilter   = true
--tv_render_clip.additive_alpha  = true
tv_render_clip.collimated      = false
tv_render_clip.additive_alpha    = true
AddToUpper(tv_render_clip)


-- TODO: vertices非正规正方形, 需仔细确定相应的贴图坐标
-- 贴图 (0,0) -> (1,1) 映射到 {{-hw,  hw}, { hw,  hw}, { hw, -hw}, {-hw, -hw}}, 需算比例

-- TODO: 贴图覆盖 OSB 文字
local hw = 1.5

if use_new_mmap_material then
    local verts  = {{-1,  1.2}, { 1,  1.2}, { 1, -1.5}, {-1, -1.5}}
    local TV_RENDER             = CreateElement "ceTexPoly"
    TV_RENDER.name              = "TV_RENDER"
    TV_RENDER.init_pos          = {0, FWD_COMP_BIAS, 0}
    TV_RENDER.vertices          = verts
    TV_RENDER.tex_coords        = {{0.5 - 1/3, 0.1},
                                   {0.5 + 1/3, 0.1},
                                   {0.5 + 1/3, 1},
                                   {0.5 - 1/3, 1}}
    TV_RENDER.indices           = DEF_BOX_INDICES
    TV_RENDER.material          = "DMAP_Material_" .. tostring(GetRenderTarget()) -- 自定义材质
    TV_RENDER.controllers       = {{"check_map_onoff"},}
    TV_RENDER.level             = HSD_NAV_LEVEL - 1
    TV_RENDER.h_clip_relation   = h_clip_relations.COMPARE
    TV_RENDER.additive_alpha    = true
    AddToUpper(TV_RENDER)
else
    local verts  = {{-hw,  hw}, { hw,  hw}, { hw, -hw}, {-hw, -hw}}
    local TV_RENDER             = CreateElement "ceTexPoly"
    TV_RENDER.name              = "TV_RENDER"
    TV_RENDER.init_pos          = {0, FWD_COMP_BIAS, 0}
    TV_RENDER.vertices          = verts
    TV_RENDER.tex_coords        = {{0,0},{1,0},{1,1},{0,1}}
    TV_RENDER.indices           = DEF_BOX_INDICES
    TV_RENDER.material        = "render_target_" .. tostring(GetRenderTarget() + 1)
    TV_RENDER.controllers       = {{"check_map_onoff"},}
    TV_RENDER.level             = HSD_NAV_LEVEL - 1
    TV_RENDER.h_clip_relation   = h_clip_relations.COMPARE
    TV_RENDER.additive_alpha    = true
    AddToUpper(TV_RENDER)
end

---------===============================================

--OSB
local osb_txt = {
    --{value="HSD",     init_pos={MFCD_FONT_UD1_X,    MFCD_FONT_U_Y}, align="CenterCenter"},
    {value="TRU",     init_pos={MFCD_FONT_UD5_X,    MFCD_FONT_U_Y},   align="CenterCenter", ctrls={{"hsd_hdg_type"}}},
    
    {value="R\nW\nR", init_pos={MFCD_FONT_L_VERT_X, MFCD_FONT_LR2_Y}, align="LeftCenter",  ctrls={{"update_rwr_state_txt"}}},
    {value="M\nA\nP", init_pos={MFCD_FONT_R_VERT_X, MFCD_FONT_LR4_Y}, align="RightCenter",},
    {value="T\nC\nN", init_pos={MFCD_FONT_R_VERT_X, MFCD_FONT_LR5_Y}, align="RightCenter", ctrls={{"hsd_osb_tcn_rej"}}},
    
    -- for DL
    {value="EVP", init_pos={MFCD_FONT_UD2_X, MFCD_FONT_U_Y}, align="CenterCenter", ctrls={{"hsd_dl_osb"}}},
    {value="ALT", init_pos={MFCD_FONT_UD4_X, MFCD_FONT_U_Y}, align="CenterCenter", ctrls={{"hsd_dl_osb"}}},
    
    {value="T\nR\nK", init_pos={MFCD_FONT_R_VERT_X, MFCD_FONT_LR3_Y}, align="RightCenter", ctrls={{"hsd_dl_osb"}}},
    
    {value="G\nN\nD", init_pos={MFCD_FONT_L_VERT_X, MFCD_FONT_LR1_Y}, align="LeftCenter", ctrls={{"hsd_dl_osb"}}},
    {value="U\nN\nK", init_pos={MFCD_FONT_L_VERT_X, MFCD_FONT_LR3_Y}, align="LeftCenter", ctrls={{"hsd_dl_osb"}}},
    {value="A\nE\nW", init_pos={MFCD_FONT_L_VERT_X, MFCD_FONT_LR4_Y}, align="LeftCenter", ctrls={{"hsd_dl_osb"}}},
    {value="F\nR\nD", init_pos={MFCD_FONT_L_VERT_X, MFCD_FONT_LR5_Y}, align="LeftCenter", ctrls={{"hsd_dl_osb"}}},
}

for i=1, #(osb_txt) do
    local text_strpoly      = CreateElement "ceStringPoly"
    text_strpoly.material   = MFCD_FONT_DEF
    text_strpoly.stringdefs = MFCD_STRINGDEFS_DEF_X08
    text_strpoly.init_pos   = osb_txt[i].init_pos
    text_strpoly.alignment  = osb_txt[i].align
    text_strpoly.value      = osb_txt[i].value
    if osb_txt[i].ctrls then
        text_strpoly.controllers = osb_txt[i].ctrls
    end
    text_strpoly.level      = HSD_NAV_LEVEL
    AddToUpper(text_strpoly)
    text_strpoly = nil
end


-- local
local texs_local = {
    ---- DL
    -- Top OSB box
    {-- EVP
        cx = MFCD_FONT_UD2_X, cy = MFCD_FONT_U_Y, hw = 116/160 * 266.667/2000, hh = 133.333/2000, ulx =   72, uly = 1770, w = 116, h = 80,
        ctrls = {{"hsd_dl_osb_box", 1}},
    },
    {-- ALT
        cx = MFCD_FONT_UD4_X, cy = MFCD_FONT_U_Y, hw = 116/160 * 266.667/2000, hh = 133.333/2000, ulx =   72, uly = 1770, w = 116, h = 80,
        ctrls = {{"hsd_dl_osb_box", 2}},
    },
    -- Left OSB box
    {-- GND
        cx = MFCD_BOX3_L_VERT_X, cy = MFCD_FONT_LR1_Y, hw = 120/2000, hh = 144/176 * 293.333/2000, ulx =   0, uly = 1770, w = 72, h = 144,
        ctrls = {{"hsd_dl_osb_box", 4}},
    },
    {-- UNK
        cx = MFCD_BOX3_L_VERT_X, cy = MFCD_FONT_LR3_Y, hw = 120/2000, hh = 144/176 * 293.333/2000, ulx =   0, uly = 1770, w = 72, h = 144,
        ctrls = {{"hsd_dl_osb_box", 5}},
    },
    {-- AEW
        cx = MFCD_BOX3_L_VERT_X, cy = MFCD_FONT_LR4_Y, hw = 120/2000, hh = 144/176 * 293.333/2000, ulx =   0, uly = 1770, w = 72, h = 144,
        ctrls = {{"hsd_dl_osb_box", 6}},
    },
    {-- FRD
        cx = MFCD_BOX3_L_VERT_X, cy = MFCD_FONT_LR5_Y, hw = 120/2000, hh = 144/176 * 293.333/2000, ulx =   0, uly = 1770, w = 72, h = 144,
        ctrls = {{"hsd_dl_osb_box", 7}},
    },

    -- Right OSB
    {-- TRK
        cx = MFCD_BOX3_R_VERT_X, cy = MFCD_FONT_LR3_Y, hw = 120/2000, hh = 144/176 * 293.333/2000, ulx =   0, uly = 1770, w = 72, h = 144,
        ctrls = {{"hsd_dl_osb_box", 3}},
    },
    {-- MAP
        cx = MFCD_BOX3_R_VERT_X, cy = MFCD_FONT_LR4_Y, hw = 120/2000, hh = 144/176 * 293.333/2000, ulx =   0, uly = 1770, w = 72, h = 144,
        ctrls = {{"hsd_mmap_box"}},
    },
    {-- TCN
        cx = MFCD_BOX3_R_VERT_X, cy = MFCD_FONT_LR5_Y, hw = 120/2000, hh = 144/176 * 293.333/2000, ulx =   0, uly = 1770, w = 72, h = 144,
        ctrls = {{"hsd_tcn_rej_box"}},
    },
}

for i=1, #(texs_local) do
    tex_poly            = CreateElement "ceTexPoly"
    tex_poly.material   = MFCD_TEX_IND2
    tex_poly.init_pos   = {texs_local[i].cx, texs_local[i].cy, 0}
    tex_poly.vertices   = {{ texs_local[i].hw, texs_local[i].hh},
                           { texs_local[i].hw,-texs_local[i].hh},
                           {-texs_local[i].hw,-texs_local[i].hh},
                           {-texs_local[i].hw, texs_local[i].hh},}
    tex_poly.indices    = DEF_BOX_INDICES
    
    if texs_local[i].mat then
        tex_poly.material = texs_local[i].mat
    end
    if texs_local[i].state_tex then
        tex_poly.state_tex_coords = texs_local[i].multi_tex
    else    
        tex_poly.tex_coords = MFCD_tex_coord(texs_local[i].ulx, texs_local[i].uly, texs_local[i].w, texs_local[i].h, TEX_SIZE_X, TEX_SIZE_Y)
    end
    
    if texs_local[i].name then
        tex_poly.name = texs_local[i].name
    end
    if texs_local[i].parent_element then
        tex_poly.parent_element = texs_local[i].parent_element
    end
    
    if texs_local[i].ctrls then
        tex_poly.controllers = texs_local[i].ctrls
    end

    AddToUpper(tex_poly)
    tex_poly = nil
end

-- 上三角
local label_delta_u      = CreateElement "ceTexPoly"
label_delta_u.material   = MFCD_TEX_IND1
label_delta_u.tex_coords = MFCD_tex_coord(1196, 1596, 68, 68, TEX_SIZE_X, TEX_SIZE_Y)
label_delta_u.vertices   = {{ 113.333/2000,  113.333/2000},
                            { 113.333/2000, -113.333/2000},
                            {-113.333/2000, -113.333/2000},
                            {-113.333/2000,  113.333/2000}}
label_delta_u.indices    = DEF_BOX_INDICES
label_delta_u.init_pos   = {MFCD_BOX3_R_VERT_X, MFCD_FONT_LR1_Y, 0}
label_delta_u.level      = HSD_NAV_LEVEL
AddToUpper(label_delta_u)
label_delta_u = nil

-- 下三角
local label_delta_d      = CreateElement "ceTexPoly"
label_delta_d.material   = MFCD_TEX_IND1
label_delta_d.tex_coords = MFCD_tex_coord(1196, 1664, 68, 68, TEX_SIZE_X, TEX_SIZE_Y)
label_delta_d.vertices   = {{ 113.333/2000,  113.333/2000},
                            { 113.333/2000, -113.333/2000},
                            {-113.333/2000, -113.333/2000},
                            {-113.333/2000,  113.333/2000}}
label_delta_d.indices    = DEF_BOX_INDICES
label_delta_d.init_pos   = {MFCD_BOX3_R_VERT_X, MFCD_FONT_LR2_Y, 0}
label_delta_d.level      = HSD_NAV_LEVEL
AddToUpper(label_delta_d)
label_delta_d = nil

-- 比例尺
local compass_scale          = CreateElement "ceStringPoly"
compass_scale.material       = MFCD_FONT_DEF
compass_scale.stringdefs     = MFCD_STRINGDEFS_DEF_X08
compass_scale.init_pos       = {MFCD_FONT_R_HORI_X, 466.667/1000, 0}
compass_scale.alignment      = "RightCenter"
compass_scale.formats        = {"%.0f","%s"}
compass_scale.value          = "0"
--compass_scale.element_params = {"ASM_WPT_SCALE_VAL"}
compass_scale.controllers    = {{"hsd_range_text"}}
compass_scale.level          = HSD_NAV_LEVEL
AddToUpper(compass_scale)

---------====================================================================

--[[ 前向 Mask ]]
fwd_square_clip                 = CreateElement "ceMeshPoly"
fwd_square_clip.name            = create_guid_string()
fwd_square_clip.material        = MFCD_MATERIAL_W_BASE
fwd_square_clip.primitivetype   = "triangles"
fwd_square_clip.init_pos        = {0, 0, 0}
fwd_square_clip.vertices        = {{ 1573.333/2000,  0.8875},
                                   { 1573.333/2000, -1526.667/2000},
                                   {-1573.333/2000, -1526.667/2000},
                                   {-1573.333/2000,  0.8875}}
fwd_square_clip.indices         = DEF_BOX_INDICES --{0,1,2,0,2,3 }
fwd_square_clip.h_clip_relation = h_clip_relations.REWRITE_LEVEL
fwd_square_clip.level           = HSD_NAV_LEVEL + 1
fwd_square_clip.isdraw          = true
fwd_square_clip.isvisible       = false
fwd_square_clip.use_mipfilter   = true
fwd_square_clip.additive_alpha  = true
fwd_square_clip.collimated      = false
AddToUpper(fwd_square_clip)


-- 前向罗盘
local fwd_compass           = CreateElement "ceTexPoly"
fwd_compass.name            = create_guid_string()
fwd_compass.material        = MFCD_TEX_IND2
fwd_compass.tex_coords      = MFCD_tex_coord(288, 816, 1232, 1232, TEX_SIZE_X, TEX_SIZE_Y)
fwd_compass.vertices        = {{ 2053.333/2000,  2053.333/2000},
                               { 2053.333/2000, -2053.333/2000},
                               {-2053.333/2000, -2053.333/2000},
                               {-2053.333/2000,  2053.333/2000}}
fwd_compass.indices         = DEF_BOX_INDICES
fwd_compass.level           = HSD_NAV_LEVEL + 1
fwd_compass.init_pos        = {0, FWD_COMP_BIAS, 0}
fwd_compass.controllers     = {{"compass_elem_rotate", 1.0},{"hsd_dl_rej_hidden"}}
fwd_compass.h_clip_relation = h_clip_relations.COMPARE
fwd_compass.isdraw          = true
fwd_compass.isvisible       = true
fwd_compass.use_mipfilter   = true
fwd_compass.additive_alpha  = true
fwd_compass.collimated      = false
AddToUpper(fwd_compass)

local fwd_compass_out           = CreateElement "ceTexPoly"
fwd_compass_out.name            = create_guid_string()
fwd_compass_out.material        = MFCD_TEX_IND3
fwd_compass_out.tex_coords      = MFCD_tex_coord(816, 816, 1232, 1232, TEX_SIZE_X, TEX_SIZE_Y)
fwd_compass_out.vertices        = {{ 2053.333/2000,  2053.333/2000},
                                   { 2053.333/2000, -2053.333/2000},
                                   {-2053.333/2000, -2053.333/2000},
                                   {-2053.333/2000,  2053.333/2000}}
fwd_compass_out.indices         = DEF_BOX_INDICES
fwd_compass_out.level           = HSD_NAV_LEVEL + 1
fwd_compass_out.init_pos        = {0, FWD_COMP_BIAS, 0}
fwd_compass_out.controllers     = {{"compass_elem_rotate", 1.0},{"hsd_dl_rej_but_keep"}}
fwd_compass_out.h_clip_relation = h_clip_relations.COMPARE
fwd_compass_out.isdraw          = false
fwd_compass_out.isvisible       = true
fwd_compass_out.use_mipfilter   = true
fwd_compass_out.additive_alpha  = true
fwd_compass_out.collimated      = false
AddToUpper(fwd_compass_out)

-- 自己
local ac_sym           = CreateElement "ceTexPoly"
ac_sym.material        = MFCD_TEX_IND2
ac_sym.tex_coords      = MFCD_tex_coord(886, 716, 100, 100, TEX_SIZE_X, TEX_SIZE_Y)
ac_sym.vertices        = {{ 166.667/2000,  166.667/2000},
                          { 166.667/2000, -166.667/2000},
                          {-166.667/2000, -166.667/2000},
                          {-166.667/2000,  166.667/2000}}
ac_sym.indices         = DEF_BOX_INDICES
ac_sym.level           = HSD_NAV_LEVEL + 1
ac_sym.init_pos        = {0, FWD_COMP_BIAS, 0}
ac_sym.h_clip_relation = h_clip_relations.COMPARE
--ac_sym.controllers     = {{"hsd_dl_rej_hidden"}}
ac_sym.isdraw          = true
ac_sym.isvisible       = true
ac_sym.use_mipfilter   = true
ac_sym.additive_alpha  = true
ac_sym.collimated      = false
AddToUpper(ac_sym)

-- 航向标记
local hdg_sym           = CreateElement "ceTexPoly"
hdg_sym.material        = MFCD_TEX_IND2
hdg_sym.tex_coords      = MFCD_tex_coord(986, 732, 40, 84, TEX_SIZE_X, TEX_SIZE_Y)
hdg_sym.vertices        = {{ 66.667/2000,  140/2000},
                           { 66.667/2000, -140/2000},
                           {-66.667/2000, -140/2000},
                           {-66.667/2000,  140/2000}}
hdg_sym.indices         = DEF_BOX_INDICES
hdg_sym.level           = HSD_NAV_LEVEL + 1
hdg_sym.init_pos        = {0, 600/1000, 0}
hdg_sym.h_clip_relation = h_clip_relations.COMPARE
hdg_sym.controllers     = {{"hsd_dl_rej_hidden"}}
hdg_sym.isdraw          = true
hdg_sym.isvisible       = true
hdg_sym.use_mipfilter   = true
hdg_sym.additive_alpha  = true
hdg_sym.collimated      = false
AddToUpper(hdg_sym)

local route_text_poly       = CreateElement "ceStringPoly"
route_text_poly.name        = "route_text_poly"
route_text_poly.material    = MFCD_FONT_G
route_text_poly.stringdefs  = MFCD_STRINGDEFS_DEF_X08
route_text_poly.alignment   = "LeftCenter"
route_text_poly.init_pos    = {-0.81, 0.68, 0}
route_text_poly.level           = HSD_NAV_LEVEL + 1
--route_text_poly.h_clip_relation = h_clip_relations.COMPARE
route_text_poly.controllers     = {{"nav_route_text"}}
route_text_poly.formats         = {"%s"}
route_text_poly.value           = "0 NM\n000"
route_text_poly.isdraw          = true
route_text_poly.use_mipfilter   = true
route_text_poly.additive_alpha  = false
AddToUpper(route_text_poly)



-- 前向罗盘 东南西北
local eswn_scale = 0.41
local eswn = {"N", "E", "S", "W"}
for i = 1,4 do
    local dval = i-1
    local mx = eswn_scale*math.sin(dval/2*math.pi)
    local my = eswn_scale*math.cos(dval/2*math.pi)
    compass_eswn                = CreateElement "ceStringPoly"
    compass_eswn.name           = create_guid_string()
    compass_eswn.parent_element = fwd_compass.name
    compass_eswn.material       = MFCD_FONT_G
    compass_eswn.stringdefs     = MFCD_STRINGDEFS_DEF
    compass_eswn.level          = HSD_NAV_LEVEL + 1
    compass_eswn.init_pos       = {0, 0, 0}
    compass_eswn.alignment      = "CenterCenter"
    compass_eswn.value          = eswn[i]
    compass_eswn.controllers    = {{"move", mx*GetScale(), my*GetScale(), 0},
                                   {"compass_elem_rotate", -1.0},{"hsd_dl_rej_hidden"}}
    AddToUpper(compass_eswn)
end

-- 前向罗盘刻度数值
local comp_mark_scale = 1.06
for comp_mark = 1,12 do
    local dval = 3*(comp_mark-1)
    local mx = comp_mark_scale*math.sin(dval/18*math.pi)
    local my = comp_mark_scale*math.cos(dval/18*math.pi)
    compass_mark                 = CreateElement "ceStringPoly"
    compass_mark.name            = create_guid_string()
    compass_mark.parent_element  = fwd_compass.name
    compass_mark.material        = MFCD_FONT_G
    compass_mark.stringdefs      = MFCD_STRINGDEFS_DEF_X08
    compass_mark.level           = HSD_NAV_LEVEL + 1
    compass_mark.init_pos        = {0, 0, 0}
    compass_mark.alignment       = "CenterCenter"
    --compass_mark.formats         = {"%02.0f","%s"}
    compass_mark.value           = dval*10
    compass_mark.controllers     = {{"move", mx*GetScale(), my*GetScale(), 0},
                                    {"compass_elem_rotate", -1.0},
                                    {"hsd_hdg_boxclip", 0.15}}
    compass_mark.h_clip_relation = h_clip_relations.COMPARE
    compass_mark.isdraw          = true
    compass_mark.isvisible       = true
    compass_mark.use_mipfilter   = true
    compass_mark.additive_alpha  = true
    compass_mark.collimated      = false
    AddToUpper(compass_mark)
end




---- 实际动态符号显示区域
local hsd_range_base           = CreateElement "ceMeshPoly"
hsd_range_base.name            = create_guid_string()
hsd_range_base.material        = MFCD_MATERIAL_W_BASE
hsd_range_base.primitivetype   = "triangles"
hsd_range_base.init_pos        = {0, 0, 0}
--hsd_range_base.init_pos        = {0, 0, 0}
hsd_range_base.h_clip_relation = h_clip_relations.REWRITE_LEVEL
hsd_range_base.level           = HSD_NAV_LEVEL + 1 + HSD_NAV_LEVEL_SHIFT
hsd_range_base.isdraw          = true
hsd_range_base.isvisible       = false
hsd_range_base.use_mipfilter   = true
hsd_range_base.additive_alpha  = true
hsd_range_base.collimated      = false
--set_circle(hsd_range_base, 0.90 * 1.05, 0, 360, 36)
hsd_range_base.vertices        = {{ 0.9,  0.88},
                                  { 0.9, -0.88},
                                  {-0.9, -0.88},
                                  {-0.9,  0.88}}
hsd_range_base.indices         = DEF_BOX_INDICES
AddToUpper(hsd_range_base)

local hsd_range_clip           = CreateElement "ceMeshPoly"
hsd_range_clip.name            = create_guid_string()
hsd_range_clip.material        = MFCD_MATERIAL_W_BASE
hsd_range_clip.primitivetype   = "triangles"
hsd_range_clip.init_pos        = {0, 0, 0}
--hsd_range_clip.init_pos        = {0, 0, 0}
hsd_range_clip.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
hsd_range_clip.level           = HSD_NAV_LEVEL + 1 + HSD_NAV_LEVEL_SHIFT
hsd_range_clip.isdraw          = true
hsd_range_clip.isvisible       = false
hsd_range_clip.use_mipfilter   = true
hsd_range_clip.additive_alpha  = true
hsd_range_clip.collimated      = false
--set_circle(hsd_range_clip, 0.90 * 1.05, 0, 360, 36)
hsd_range_clip.vertices        = {{ 0.9,  0.88},
                                  { 0.9, -0.88},
                                  {-0.9, -0.88},
                                  {-0.9,  0.88}}
hsd_range_clip.indices         = DEF_BOX_INDICES
AddToUpper(hsd_range_clip)

----[[ SA RWR/MAWS/DL/RDR ]]
dofile(LockOn_Options.script_path .. "MFCD/Indicator/UP_L1_HSD_SA.lua")

----[[ TGT ]]
dofile(LockOn_Options.script_path .. "MFCD/Indicator/UP_L1_HSD_TGT.lua")

----[[ Nav ]]
dofile(LockOn_Options.script_path .. "MFCD/Indicator/UP_L1_HSD_NAV.lua")



local route_crs_sym           = CreateElement "ceTexPoly"
route_crs_sym.material        = MFCD_TEX_IND2
route_crs_sym.tex_coords      = MFCD_tex_coord(1060, 214, 64, 416, TEX_SIZE_X, TEX_SIZE_Y)
route_crs_sym.vertices        = {{ 106.667/2000,  693.333/2000},
                                 { 106.667/2000, -693.333/2000},
                                 {-106.667/2000, -693.333/2000},
                                 {-106.667/2000,  693.333/2000}}
route_crs_sym.indices         = DEF_BOX_INDICES
route_crs_sym.init_pos        = {0, FWD_COMP_BIAS, 0}
route_crs_sym.level           = HSD_NAV_LEVEL + 2 + HSD_NAV_LEVEL_SHIFT
route_crs_sym.h_clip_relation = h_clip_relations.COMPARE
route_crs_sym.isdraw          = true
route_crs_sym.isvisible       = true
route_crs_sym.use_mipfilter   = true
route_crs_sym.additive_alpha  = true
route_crs_sym.collimated      = false
route_crs_sym.controllers     = {{"nav_route_crs"},}
AddToUpper(route_crs_sym)


-------------------------------------------------------
---- 航向框 [两个，一个用于覆盖，一个用于边线]
local hdg_box_bias = 743.333/1000 -- 0.68

local hdg_box_base           = CreateElement "ceMeshPoly"
hdg_box_base.name            = create_guid_string()
hdg_box_base.material        = MFCD_MATERIAL_WHITE_Y
hdg_box_base.primitivetype   = "triangles"
hdg_box_base.init_pos        = {0, hdg_box_bias, 0}
hdg_box_base.vertices        = {{ 143.333/2000,  80/2000},
                                { 143.333/2000, -80/2000},
                                {-143.333/2000, -80/2000},
                                {-143.333/2000,  80/2000}}
hdg_box_base.indices         = DEF_BOX_INDICES
hdg_box_base.h_clip_relation = h_clip_relations.REWRITE_LEVEL
hdg_box_base.level           = HSD_NAV_LEVEL + 3 + HSD_NAV_LEVEL_SHIFT
hdg_box_base.isdraw          = true
hdg_box_base.isvisible       = false
hdg_box_base.use_mipfilter   = true
hdg_box_base.additive_alpha  = false
hdg_box_base.collimated      = false
AddToUpper(hdg_box_base)
hdg_box_base = nil

-- 航向框Mask
local hdg_box_clip           = CreateElement "ceMeshPoly"
hdg_box_clip.name            = create_guid_string()
hdg_box_clip.material        = MFCD_MATERIAL_GREEN
hdg_box_clip.primitivetype   = "triangles"
hdg_box_clip.vertices        = {{ 143.333/2000,  80/2000},
                                { 143.333/2000, -80/2000},
                                {-143.333/2000, -80/2000},
                                {-143.333/2000,  80/2000}}         
hdg_box_clip.indices         = DEF_BOX_INDICES --{0,1,2,0,2,3 }
hdg_box_clip.init_pos        = {0, hdg_box_bias, 0}
hdg_box_clip.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
hdg_box_clip.level           = HSD_NAV_LEVEL + 2 + HSD_NAV_LEVEL_SHIFT
hdg_box_clip.isdraw          = true
hdg_box_clip.isvisible       = false
hdg_box_clip.use_mipfilter   = true
hdg_box_clip.additive_alpha  = true
hdg_box_clip.collimated      = false
AddToUpper(hdg_box_clip)
hdg_box_clip = nil


-- 航向框边线
local hdg_box_frame           = CreateElement "ceTexPoly"
hdg_box_frame.material        = MFCD_TEX_IND2
hdg_box_frame.tex_coords      = MFCD_tex_coord(1026, 730, 124, 86, TEX_SIZE_X, TEX_SIZE_Y)
hdg_box_frame.vertices        = {{ 206.667/2000,  143.333/2000},
                                 { 206.667/2000, -143.333/2000},
                                 {-206.667/2000, -143.333/2000},
                                 {-206.667/2000,  143.333/2000}}
hdg_box_frame.indices         = DEF_BOX_INDICES
hdg_box_frame.init_pos        = {0, hdg_box_bias, 0} -- 815/1000
--hdg_box_frame.level           = HSD_NAV_LEVEL + 3
--hdg_box_frame.h_clip_relation = h_clip_relations.COMPARE
hdg_box_frame.isdraw          = true
hdg_box_frame.isvisible       = true
hdg_box_frame.use_mipfilter   = true
hdg_box_frame.additive_alpha  = true
hdg_box_frame.collimated      = false
AddToUpper(hdg_box_frame)


-- 当前航向
local hdg_box_value           = CreateElement "ceStringPoly"
hdg_box_value.name            = "nav_hdg_box_value"
hdg_box_value.material        = MFCD_FONT_G
hdg_box_value.stringdefs      = MFCD_STRINGDEFS_DEF_X08
hdg_box_value.init_pos        = {0, hdg_box_bias, 0}
hdg_box_value.alignment       = "CenterCenter"
hdg_box_value.formats         = {"%03.0f","%s"}
hdg_box_value.level           = HSD_NAV_LEVEL + 3 + HSD_NAV_LEVEL_SHIFT
hdg_box_value.h_clip_relation = h_clip_relations.COMPARE
hdg_box_value.value           = "0"
hdg_box_value.controllers     = {{"hsd_hdg_value"},}
AddToUpper(hdg_box_value)
-----------------------------------------------------------
----------------------------------------------------------

local osb_txt = {
    {
        value="D2",  init_pos={MFCD_FONT_UD2_X, MFCD_FONT_D_Y}, alignment="CenterCenter",
        controller = {{"DOWN_osb_d2_txt"}, --[[{"apply_contrast"}]]}, level = PAGE_LEVEL_DATA,
    },
    {
        value="SOI", init_pos={MFCD_FONT_UD3_X, MFCD_FONT_D_Y}, alignment="CenterCenter",
        controller = {{"BASE_isSOI"}, --[[{"apply_contrast"}]]}, level = PAGE_LEVEL_DATA,
    }, --I'm SOI indicator
    {
        value="D4",  init_pos={MFCD_FONT_UD4_X, MFCD_FONT_D_Y}, alignment="CenterCenter",
        controller = {{"DOWN_osb_d4_txt"}, --[[{"apply_contrast"}]]}, level = PAGE_LEVEL_DATA,
    },
}

local text_strpoly
for i=1, #(osb_txt) do
    text_strpoly                 = CreateElement "ceStringPoly"
    text_strpoly.material        = MFCD_FONT_DEF
    text_strpoly.stringdefs      = MFCD_STRINGDEFS_DEF_X08
    text_strpoly.init_pos        = osb_txt[i].init_pos
    text_strpoly.alignment       = osb_txt[i].alignment
    text_strpoly.controllers     = osb_txt[i].controller
    --text_strpoly.parent_element  = page_root.name
    if osb_txt[i].level then
        text_strpoly.level       = osb_txt[i].level
    end
    text_strpoly.isdraw          = true
    text_strpoly.isvisible       = true
    text_strpoly.h_clip_relation = h_clip_relations.REWRITE_LEVEL
    AddElementObject(text_strpoly)
    text_strpoly = nil
end
