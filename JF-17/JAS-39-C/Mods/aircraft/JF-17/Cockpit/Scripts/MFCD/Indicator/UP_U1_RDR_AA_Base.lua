
dofile(LockOn_Options.script_path .. "MFCD/Indicator/UP_U1_RDR_Base.lua")


-- 
texs = {
    {-- 雷达框
        cx = 0, cy = 0, hw = 1666.67/2000, hh = 1666.67/2000, ulx = 0, uly = 0, w = 1000, h = 1000,
        mat = MFCD_TEX_IND4, state_tex = true,
        multi_tex = {
            MFCD_tex_coord(0,    0, 1000, 1000, TEX_SIZE_X, TEX_SIZE_Y), -- AA
            --MFCD_tex_coord(0, 1000, 1000, 1000, TEX_SIZE_X, TEX_SIZE_Y), -- AG
        },
        ctrls = {--[[{"rdr_frame_type"},]]{"rdr_state_draw"}},
    },
    {-- 上三角
        cx = MFCD_BOX3_R_VERT_X, cy = MFCD_FONT_LR1_Y, hw = 113.333/2000, hh = 113.333/2000, ulx = 1196, uly = 1596, w = 68, h = 68,
        mat = MFCD_TEX_IND1,
        ctrls = {{"rdr_state_draw"}},
    },
    {-- 下三角
        cx = MFCD_BOX3_R_VERT_X, cy = MFCD_FONT_LR2_Y, hw = 113.333/2000, hh = 113.333/2000, ulx = 1196, uly = 1664, w = 68, h = 68,
        mat = MFCD_TEX_IND1,
        ctrls = {{"rdr_state_draw"}},
    },
    
    {-- 雷达天线el位置 指示符 T
        cx = -730/1000, cy = 0, hw = 150/2000, hh = 100/2000, ulx = 1136, uly = 442, w = 90, h = 60,
        mat = MFCD_TEX_IND4, name = "rdr_aa_el_sym",
        ctrls = {{"rdr_atenna_beam_el"}},
    },
    {-- 雷达天线az位置 指示符 T 一直有，因此传递参数0
        cx = 0, cy = -740/1000, hw = 113.333/2000, hh = 136.667/2000, ulx = 1136, uly = 502, w = 68, h = 82,
        mat = MFCD_TEX_IND4, name = "rdr_aa_az_sym",
        ctrls = {{"rdr_aa_atenna_beam_az"}}, --parent_element = "",
    },
    
    {-- 雷达天线az扫描范围左 垂直虚线
        cx = 0, cy = 0, hw = 113.333/2000, hh = 1536.667/2000, ulx = 1068, uly = 0, w = 68, h = 922,
        mat = MFCD_TEX_IND4,
        ctrls = {{"rdr_aa_atenna_beam_az_limit", -1}}, --parent_element = "",
    },
    {-- 雷达天线az扫描范围右 垂直虚线
        cx = 0, cy = 0, hw = 113.333/2000, hh = 1536.667/2000, ulx = 1068, uly = 0, w = 68, h = 922,
        mat = MFCD_TEX_IND4,
        ctrls = {{"rdr_aa_atenna_beam_az_limit",  1}}, --parent_element = "",
    },
    
    {-- TDC游标
        cx = 0, cy = -740/1000, hw = 246.667/2000, hh = 246.667/2000, ulx = 0, uly = 592, w = 148, h = 148,
        mat = MFCD_TEX_IND3, name = "rdr_tdc_sym", ctrls = {{"rdr_tdc", 0}},
    },
    
    {-- 雷达锁定hpt 指示符 垂直实线
        cx = 0, cy = 0, hw = 113.333/2000, hh = 1536.667/2000, ulx = 1000, uly = 0, w = 68, h = 922,
        mat = MFCD_TEX_IND4, name = "rdr_aa_beam_az_hpt_bar", state_tex = true,
        multi_tex = {
            MFCD_tex_coord(1000,    0,  68, 922, TEX_SIZE_X, TEX_SIZE_Y), -- solid
            MFCD_tex_coord(1068,    0,  68, 922, TEX_SIZE_X, TEX_SIZE_Y), -- dashed
        },
        ctrls = {{"rdr_aa_locked_hpt_spt", 0}},
    },
    {-- 雷达锁定spt 指示符 垂直实线
        cx = 0, cy = 0, hw = 113.333/2000, hh = 1536.667/2000, ulx = 1000, uly = 0, w = 68, h = 922,
        mat = MFCD_TEX_IND4, name = "rdr_aa_beam_az_spt_bar", state_tex = true,
        multi_tex = {
            MFCD_tex_coord(1000,    0,  68, 922, TEX_SIZE_X, TEX_SIZE_Y), -- solid
            MFCD_tex_coord(1068,    0,  68, 922, TEX_SIZE_X, TEX_SIZE_Y), -- dashed
        },
        ctrls = {{"rdr_aa_locked_hpt_spt", 1}},
    },
    

    {-- dlz.dMIN
        cx = 0, cy = -740/1000, hw = 146.667/2000, hh = 126.667/2000, ulx = 1136, uly = 366, w = 88, h = 76,
        mat = MFCD_TEX_IND4_G, ctrls = {{"rdr_aa_dlz", 0.0, 0}}, parent_element = "rdr_aa_beam_az_hpt_bar",
    },
    {-- dlz.dMAX
        cx = 0, cy = -740/1000, hw = 146.667/2000, hh = 126.667/2000, ulx = 1136, uly = 290, w = 88, h = 76,
        mat = MFCD_TEX_IND4_G, ctrls = {{"rdr_aa_dlz", 2.0, 0}}, parent_element = "rdr_aa_beam_az_hpt_bar",
    },
    {-- dlz.dNEZ
        cx = 0, cy = -740/1000, hw = 146.667/2000, hh = 126.667/2000, ulx = 1224, uly = 290, w = 88, h = 76,
        mat = MFCD_TEX_IND4_G, ctrls = {{"rdr_aa_dlz", 3.0, 0}}, parent_element = "rdr_aa_beam_az_hpt_bar",
    },
    
    
    {-- pip dot
        cx = 0, cy = 0, hw = 246.667/2000, hh = 246.667/2000, ulx = 888, uly = 0, w = 148, h = 148,
        mat = MFCD_TEX_IND3_G, ctrls = {{"rdr_aa_pip_dot"}},
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
    {-- 雷达当前显示距离
        cx = MFCD_FONT_R_HORI_X, cy = (MFCD_FONT_LR1_Y + MFCD_FONT_LR2_Y) / 2, align = "RightCenter", strdefs = MFCD_STRINGDEFS_DEF_X08,
        ctrls = {{"rdr_range"}},
    },
    
    {-- 雷达天线 当前线数, 雷达当前PRF
        cx = -0.70, cy = -0.70, align = "LeftCenter", strdefs = MFCD_STRINGDEFS_DEF_X08,
        ctrls = {{"rdr_aa_line_prf"}},
    },
    {-- 雷达el上的扫描俯仰
        cx = 0.06, cy = 0, mat = MFCD_FONT_G, value = "13", align = "LeftCenter", strdefs = MFCD_STRINGDEFS_DEF_X06,
        ctrls = {{"rdr_el_sym_num"}}, parent = "rdr_aa_el_sym",
    },
    
    
    {-- 雷达TDC上的扫描高度范围
        cx = 0.06, cy = 0, mat = MFCD_FONT_G, value = "25\n\n\n13", align = "LeftCenter", strdefs = MFCD_STRINGDEFS_DEF_X06,
        ctrls = {{"rdr_tdc_aa_el_num"}}, parent = "rdr_tdc_sym",
    },
    {-- 雷达TDC上的接近率
        cx = -0.06, cy = 0, mat = MFCD_FONT_G, value = "63", align = "RightCenter", strdefs = MFCD_STRINGDEFS_DEF_X06,
        ctrls = {{"rdr_tdc_aa_vs_rate"}}, parent = "rdr_tdc_sym",
    },
    
    
    {-- HPT到TDC的方位距离
        cx = -665/1000, cy = -560/1000, mat = MFCD_FONT_G, value = "3.5 259.9D", align = "LeftCenter", strdefs = MFCD_STRINGDEFS_DEF_X08,
        ctrls = {{"rdr_aa_hpt2tdc_data"}},
    },
    
    {-- HPT信息
        cx = 725/1000, cy = (MFCD_FONT_LR4_Y + MFCD_FONT_LR5_Y) / 2, mat = MFCD_FONT_G, value = "XX.XNM\nX:XX\n+XXXX KTS\nXR", align = "RightTop", strdefs = MFCD_STRINGDEFS_DEF_X08, isdraw = false,
        ctrls = {{"rdr_aa_hpt_bug_info"}},
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


-- 雷达天线el范围
rdr_beam_el_range                 = CreateElement "ceSimpleLineObject"
rdr_beam_el_range.name            = "rdr_beam_el_range"
rdr_beam_el_range.material        = MFCD_MATERIAL_DEF
rdr_beam_el_range.width           = 0.015
rdr_beam_el_range.init_pos        = {0, 0, 0}
rdr_beam_el_range.controllers     = {{"rdr_atenna_beam_el_range", -740/1000 + 0.015/2}} --  + rdr_beam_el_range.width/2
AddToUpper(rdr_beam_el_range)

-- ASE环
rdr_ase_circle             = CreateElement "ceSimpleLineObject"
rdr_ase_circle.name        = "rdr_aa_ase_circle"
rdr_ase_circle.material    = MFCD_MATERIAL_DEF
rdr_ase_circle.width       = 0.005
rdr_ase_circle.init_pos    = {0, 0, 0}
rdr_ase_circle.controllers = {{"rdr_aa_ase_circle", 72}}
AddToUpper(rdr_ase_circle)

--============================================================--

dofile(LockOn_Options.script_path .. "MFCD/Indicator/UP_U1_RDR_AA_Contact.lua")

--[[
MAX_CONTACTS = SA_CONTACT_NUM_SHARED
MAX_HISTORY  = 4
hh           = 246.667/2000

for c = 0, (MAX_CONTACTS-1) do
    for h = (MAX_HISTORY-1), 0, -1 do
        -- 目标模板
        tex_poly          = CreateElement "ceTexPoly"
        tex_poly.name     = 'rdr_contact_' .. tostring(c) .. '_' .. tostring(h)

        tex_poly.material     = MFCD_TEX_IND3
        tex_poly.init_pos     = {0, -rdr_frame_length_half, 0}
        --tex_poly.tex_coords = MFCD_tex_coord(304, 368, 366-304, 431-368, BASIC_TEX_SIZE_X, BASIC_TEX_SIZE_Y)
        tex_poly.vertices     = { {hh, hh}, {hh,-hh}, {-hh,-hh}, {-hh,hh}, }
        tex_poly.indices      = DEF_BOX_INDICES
        --
        tex_poly.state_tex_coords = {
            MFCD_tex_coord( 148,    0, 148, 148, TEX_SIZE_X, TEX_SIZE_Y), -- 0 实心正方形 -- RAW
            MFCD_tex_coord( 296,  592, 148, 148, TEX_SIZE_X, TEX_SIZE_Y), -- 1 空心三角 (Skip)
            MFCD_tex_coord( 444,  592, 148, 148, TEX_SIZE_X, TEX_SIZE_Y), -- 2 空心圆 (Skip)
            
            MFCD_tex_coord( 296,    0, 148, 148, TEX_SIZE_X, TEX_SIZE_Y), -- 3 空心三角形 -- Track File
            MFCD_tex_coord( 592,    0, 148, 148, TEX_SIZE_X, TEX_SIZE_Y), -- 4 空心圆形 -- Track File
            MFCD_tex_coord( 296,  444, 148, 148, TEX_SIZE_X, TEX_SIZE_Y), -- 5 空心菱形 -- JAM
            
            MFCD_tex_coord( 148,    0, 148, 148, TEX_SIZE_X, TEX_SIZE_Y), -- 6 实心正方形 (Skip)
            MFCD_tex_coord( 296,  592, 148, 148, TEX_SIZE_X, TEX_SIZE_Y), -- 7 空心三角 (Skip)
            MFCD_tex_coord( 444,  592, 148, 148, TEX_SIZE_X, TEX_SIZE_Y), -- 8 空心圆 (Skip)
            
            MFCD_tex_coord( 444,    0, 148, 148, TEX_SIZE_X, TEX_SIZE_Y), -- 9 实心三角形 -- SPT
            MFCD_tex_coord( 740,    0, 148, 148, TEX_SIZE_X, TEX_SIZE_Y), --10 实心圆形 -- SPT
            MFCD_tex_coord( 148,  444, 148, 148, TEX_SIZE_X, TEX_SIZE_Y), --11 实心菱形
            
            MFCD_tex_coord(   0,    0, 148, 148, TEX_SIZE_X, TEX_SIZE_Y), --12 圆内三角 -- HPT
        }

        tex_poly.controllers     = {{"rdr_update_contact_aa", c, h}}
        tex_poly.isdraw          = false
        tex_poly.use_mipfilter   = true
        tex_poly.additive_alpha  = false
        tex_poly.h_clip_relation = h_clip_relations.COMPARE
        tex_poly.level           = RDR_LEVEL
        AddToUpper(tex_poly)
        
        -- alt str
        rdr_contact_alt_str                 = CreateElement "ceStringPoly"
        rdr_contact_alt_str.material        = MFCD_FONT_W
        rdr_contact_alt_str.stringdefs      = MFCD_STRINGDEFS_DEF_X04
        rdr_contact_alt_str.alignment       = "LeftCenter"
        rdr_contact_alt_str.init_pos        = {0.25*hh, -0.25*hh}
        rdr_contact_alt_str.value           = "00"
        rdr_contact_alt_str.parent_element  = tex_poly.name
        rdr_contact_alt_str.controllers     = {{"rdr_contact_aa_alt_str", c, h}}
        rdr_contact_alt_str.h_clip_relation = h_clip_relations.COMPARE
        rdr_contact_alt_str.level           = RDR_LEVEL
        AddToUpper(rdr_contact_alt_str)
        rdr_contact_alt_str = nil

        tex_poly = nil
    end
    
end



-- 当前航路点
current_wpt                 = CreateElement "ceTexPoly"
current_wpt.name            = 'rdr_aa_current_wpt'
current_wpt.material        = MFCD_TEX_IND3_W
current_wpt.init_pos        = {0, -rdr_frame_length_half, 0}
current_wpt.tex_coords      = MFCD_tex_coord(1036, 0, 148, 148, TEX_SIZE_X, TEX_SIZE_Y)
current_wpt.vertices        = { {hh, hh}, {hh,-hh}, {-hh,-hh}, {-hh,hh}, }
current_wpt.indices         = DEF_BOX_INDICES
current_wpt.controllers     = {{"rdr_update_current_wpt", 0}, {"rdr_declutter_check"}}
current_wpt.isdraw          = true
current_wpt.use_mipfilter   = true
current_wpt.additive_alpha  = false
current_wpt.h_clip_relation = h_clip_relations.COMPARE
current_wpt.level           = RDR_LEVEL
AddToUpper(current_wpt)

current_wpt_id                 = CreateElement "ceStringPoly"
current_wpt_id.name            = 'rdr_current_wpt_id'
current_wpt_id.material        = MFCD_FONT_W
current_wpt_id.stringdefs      = MFCD_STRINGDEFS_DEF_X04
current_wpt_id.alignment       = "CenterCenter"
current_wpt_id.init_pos        = {0, 0}
current_wpt_id.value           = "00"
current_wpt_id.controllers     = {{"rdr_update_current_wpt_id"}, {"rdr_declutter_check"}}
current_wpt_id.parent_element  = current_wpt.name
current_wpt_id.isdraw          = true
current_wpt_id.use_mipfilter   = true
current_wpt_id.additive_alpha  = false
current_wpt_id.h_clip_relation = h_clip_relations.COMPARE
current_wpt_id.level           = RDR_LEVEL
AddToUpper(current_wpt_id)
]]
