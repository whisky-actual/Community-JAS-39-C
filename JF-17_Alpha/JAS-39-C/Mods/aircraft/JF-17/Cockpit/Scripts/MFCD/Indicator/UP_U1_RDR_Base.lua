
RDR_LEVEL = PAGE_LEVEL_RDR

MFCD_TEX_IND1   = "mfcd_tex_ind1"
MFCD_TEX_IND2   = "mfcd_tex_ind2"
MFCD_TEX_IND3   = "mfcd_tex_ind3"
MFCD_TEX_IND3_W = "mfcd_tex_ind3_w"
MFCD_TEX_IND4   = "mfcd_tex_ind4"
MFCD_TEX_IND4_W = "mfcd_tex_ind4_w"
MFCD_TEX_IND4_G = "mfcd_tex_ind4_g"
MFCD_TEX_IND5   = "mfcd_tex_ind5"
MFCD_TEX_IND5_W = "mfcd_tex_ind5_w"

TEX_SIZE_X = 2048
TEX_SIZE_Y = 2048

rdr_frame_length_half = 0.74

rdr_frame_box_clip           = CreateElement "ceMeshPoly"
rdr_frame_box_clip.name            = "rdr_frame_box_clip"
rdr_frame_box_clip.material        = MFCD_MATERIAL_W_BASE
rdr_frame_box_clip.primitivetype   = "triangles"
rdr_frame_box_clip.init_pos        = {0, 0, 0}
rdr_frame_box_clip.vertices        = {{-rdr_frame_length_half,  rdr_frame_length_half}, 
                                      { rdr_frame_length_half,  rdr_frame_length_half},
                                      { rdr_frame_length_half, -rdr_frame_length_half}, 
                                      {-rdr_frame_length_half, -rdr_frame_length_half}}
rdr_frame_box_clip.indices         = DEF_BOX_INDICES --{0,1,2,0,2,3 }
rdr_frame_box_clip.h_clip_relation = h_clip_relations.REWRITE_LEVEL
rdr_frame_box_clip.level           = RDR_LEVEL
rdr_frame_box_clip.isdraw          = true
rdr_frame_box_clip.isvisible       = false
rdr_frame_box_clip.use_mipfilter   = true
--rdr_frame_box_clip.additive_alpha  = true
rdr_frame_box_clip.collimated      = false
rdr_frame_box_clip.additive_alpha  = true
AddToUpper(rdr_frame_box_clip)


radar_frame_center_y = -rdr_frame_length_half

--[[
radar_base            = CreateElement "ceMeshPoly" -- untextured shape
radar_base.name             = create_guid_string()
radar_base.primitivetype    = "lines"
radar_base.material         = MFCD_MATERIAL_DEF
radar_base.vertices         = {{0.75, 0.75}, { 0.75,-0.75}, { -0.75,-0.75}, {-0.75,0.75},}
radar_base.indices          = {0,1,1,2,2,3,3,0}
AddToUpper(radar_base)
]]

myplane           = CreateElement "ceSimple"
myplane.isvisible = false
myplane.init_pos  = {0, radar_frame_center_y}
AddToUpper(myplane)

-- 自己飞机定位点
function AddToMyPlane(elem)
    elem.parent_element = myplane.name
    AddElementObject(elem)
end


strs_ac = {
    {-- STATE Label
        cx = 0, cy = MFCD_FONT_LR3_Y, value = "RDR OFF", alignment = "CenterTop", strdef = MFCD_STRINGDEFS_DEF_X15,
        ctrls = {{"rdr_state_label"}},
    },
}


for i=1, #(strs_ac) do
    text_strpoly            = CreateElement "ceStringPoly"
    text_strpoly.material   = MFCD_FONT_DEF
    text_strpoly.stringdefs = MFCD_STRINGDEFS_DEF
    text_strpoly.init_pos   = {strs_ac[i].cx, strs_ac[i].cy, 0}
    text_strpoly.alignment  = "CenterCenter"
    
    if strs_ac[i].strdef then
        text_strpoly.stringdefs     = strs_ac[i].strdef
    end
    if strs_ac[i].alignment then
        text_strpoly.alignment      = strs_ac[i].alignment
    end
    if strs_ac[i].formats then
        text_strpoly.formats        = strs_ac[i].formats
    end
    if strs_ac[i].params then
        text_strpoly.element_params = strs_ac[i].params
    end
    if strs_ac[i].ctrls then
        text_strpoly.controllers    = strs_ac[i].ctrls
    end
    if strs_ac[i].value then
        text_strpoly.value          = strs_ac[i].value
    end
    AddToUpper(text_strpoly)
    text_strpoly = nil
end


-- 
texs = {
    
    {-- fpm
        cx = 0, cy = 0, hw = 250/2000, hh = 250/2000, ulx = 1136, uly = 140, w = 150, h = 150,
        mat = MFCD_TEX_IND4,
        ctrls = {{"rdr_fpm"}},
    },
    {-- 水平线
        cx = 0, cy = 0, hw = 986.667/2000, hh = 233.333/2000, ulx = 1136, uly = 0, w = 592, h = 140,
        mat = MFCD_TEX_IND4,
        ctrls = {{"rdr_horizon"}},
    },
    
    {-- rdy disable X
        cx = -0.18, cy = MFCD_FONT_LR5_Y - 5/8 * (MFCD_FONT_LR4_Y - MFCD_FONT_LR5_Y),
        hw = 126.667/2000, hh = 126.667/2000, ulx = 1912, uly = 86, w = 76, h = 76,
        mat = MFCD_TEX_IND1, tex_sx = TEX_SIZE_X, tex_sy = TEX_SIZE_Y,
        ctrls = {{"rdr_prog_la_state_mark"}},
    },
    
    -- OSB state
    {-- iff
        cx = (MFCD_FONT_UD3_X + MFCD_FONT_UD4_X) / 2, cy = MFCD_FONT_U_Y, hw = 116/160 * 266.667/2000, hh = 133.333/2000, ulx =   72, uly = 1770, w = 116, h = 80, mat = MFCD_TEX_IND2, state_tex = false,
        multi_tex = {
            MFCD_tex_coord(  72, 1770, 116,  80, TEX_SIZE_X, TEX_SIZE_Y), -- frame
            MFCD_tex_coord(1816, 1808, 116,  80, TEX_SIZE_X, TEX_SIZE_Y), -- slash
        },
        ctrls = {{"rdr_iff_state"}},
    },
}

for i=1, #(texs) do
    tex_poly            = CreateElement "ceTexPoly"
    tex_poly.material   = MFCD_TEX_IND3
    tex_poly.init_pos   = {texs[i].cx, texs[i].cy, 0}
    tex_poly.vertices   = {{ texs[i].hw, texs[i].hh},
                           { texs[i].hw,-texs[i].hh},
                           {-texs[i].hw,-texs[i].hh},
                           {-texs[i].hw, texs[i].hh},}
    tex_poly.indices    = DEF_BOX_INDICES
    
    if texs[i].mat then
        tex_poly.material = texs[i].mat
    end
    if texs[i].state_tex then
        tex_poly.state_tex_coords = texs[i].multi_tex
    else    
        tex_poly.tex_coords = MFCD_tex_coord(texs[i].ulx, texs[i].uly, texs[i].w, texs[i].h, TEX_SIZE_X, TEX_SIZE_Y)
    end
    
    if texs[i].name then
        tex_poly.name = texs[i].name
    end
    if texs[i].parent_element then
        tex_poly.parent_element = texs[i].parent_element
    end
    
    if texs[i].ctrls then
        tex_poly.controllers = texs[i].ctrls
    end

    AddToUpper(tex_poly)
    tex_poly = nil
end


texts = {
    
    -- OSB TOP
    {-- 雷达当前工作模式
        cx = MFCD_FONT_UD1_X, cy = MFCD_FONT_U_Y, align = "CenterCenter", strdefs = MFCD_STRINGDEFS_DEF_X08,
        ctrls = {{"rdr_main_mode"}},
    },
    {-- 雷达当前工作子模式
        cx = MFCD_FONT_UD2_X, cy = MFCD_FONT_U_Y, align = "CenterCenter", strdefs = MFCD_STRINGDEFS_DEF_X08,
        ctrls = {{"rdr_sub_mode"}},
    },
    
    {-- IFF开关状态
        cx = (MFCD_FONT_UD3_X + MFCD_FONT_UD4_X)/2, value = "IFF", cy = MFCD_FONT_U_Y, strdefs = MFCD_STRINGDEFS_DEF_X08,
        ctrls = {{"rdr_state_draw"}},
    },
    {-- 雷达CNTL
        cx = MFCD_FONT_UD5_X, cy = MFCD_FONT_U_Y, value = "CNTL", align = "CenterCenter", strdefs = MFCD_STRINGDEFS_DEF_X08,
        ctrls = {{"rdr_state_draw"}},
    },
    
    {-- WPN LA STATE
        cx = -0.24, cy = MFCD_FONT_LR5_Y - 5/8 * (MFCD_FONT_LR4_Y - MFCD_FONT_LR5_Y), value = "RDY", align = "LeftCenter",
        ctrls = {{"sms_prog_la_state_text"}, {"rdr_state_draw"}},
    },
    
    {-- 本机速度
        cx = -740/1000, cy = -760/1000, value = "355", align = "LeftTop", strdefs = MFCD_STRINGDEFS_DEF_X08,
        ctrls = {{"rdr_ac_param_str", 0}},
    },
    {-- 本机航向
        cx =    0/1000, cy = -760/1000, value = "129", align = "CenterTop", strdefs = MFCD_STRINGDEFS_DEF_X08,
        ctrls = {{"rdr_ac_param_str", 1}},
    },
    {-- 本机高度
        cx =  740/1000, cy = -760/1000, value = "12355", align = "RightTop", strdefs = MFCD_STRINGDEFS_DEF_X08,
        ctrls = {{"rdr_ac_param_str", 2}},
    },
}

for i=1, #(texts) do
    text_strpoly            = CreateElement "ceStringPoly"
    text_strpoly.material   = MFCD_FONT_DEF
    text_strpoly.stringdefs = MFCD_STRINGDEFS_DEF
    text_strpoly.init_pos   = {texts[i].cx, texts[i].cy, 0}
    text_strpoly.alignment  = "CenterCenter"
    
    if texts[i].mat then
        text_strpoly.material       = texts[i].mat
    end    
    if texts[i].align then
        text_strpoly.alignment      = texts[i].align
    end
    if texts[i].strdefs then
        text_strpoly.stringdefs     = texts[i].strdefs
    end
    if texts[i].ctrls then
        text_strpoly.controllers    = texts[i].ctrls
    end
    if texts[i].value then
        text_strpoly.value          = texts[i].value
    end
    if texts[i].parent then
        text_strpoly.parent_element = texts[i].parent
    end
    if texts[i].isdraw then
        text_strpoly.isdraw         = texts[i].isdraw
    end
    
    AddToUpper(text_strpoly)
    text_strpoly = nil
end

