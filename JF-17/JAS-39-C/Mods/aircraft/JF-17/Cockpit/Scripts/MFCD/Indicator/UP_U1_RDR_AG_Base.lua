
dofile(LockOn_Options.script_path .. "MFCD/Indicator/UP_U1_RDR_Base.lua")

TV_RENDER                 = CreateElement "ceTexPoly"
TV_RENDER.name            = "TV_RENDER"
TV_RENDER.init_pos        = {0, 0, 0}
TV_RENDER.vertices        = {{-rdr_frame_length_half,  rdr_frame_length_half},
                             { rdr_frame_length_half,  rdr_frame_length_half},
                             { rdr_frame_length_half, -rdr_frame_length_half},
                             {-rdr_frame_length_half, -rdr_frame_length_half}}
TV_RENDER.tex_coords      = {{0,0},{1,0},{1,1},{0,1}}
TV_RENDER.indices         = DEF_BOX_INDICES
--TV_RENDER.material      = "render_target_"..tostring(GetRenderTarget() + 1)
TV_RENDER.material        = "AGRadar_Material_" .. tostring(GetRenderTarget())
TV_RENDER.level           = RDR_LEVEL
TV_RENDER.h_clip_relation = h_clip_relations.COMPARE
TV_RENDER.controllers     = {{'rdr_video_check'},}

AddToUpper(TV_RENDER)

-- 
texs = {
    {-- 雷达框
        cx = 0, cy = 0, hw = 1666.67/2000, hh = 1666.67/2000, ulx = 0, uly = 0, w = 1000, h = 1000,
        mat = MFCD_TEX_IND4, state_tex = true,
        multi_tex = {
            --MFCD_tex_coord(0,    0, 1000, 1000, TEX_SIZE_X, TEX_SIZE_Y), -- AA
            MFCD_tex_coord(0, 1000, 1000, 1000, TEX_SIZE_X, TEX_SIZE_Y), -- AG
        },
        ctrls = {--[[{"rdr_state_draw"}]] {"rdr_declutter_check"},},
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
        cx = -740/1000, cy = 0, hw = 150/2000, hh = 100/2000, ulx = 1136, uly = 442, w = 90, h = 60,
        mat = MFCD_TEX_IND4, name = "rdr_ag_el_sym",
        ctrls = {{"rdr_atenna_beam_el"}},
    },
    --[[{-- 雷达天线az位置 指示符 T 一直有，因此传递参数0
        cx = 0, cy = -740/1000, hw = 113.333/2000, hh = 136.667/2000, ulx = 1136, uly = 502, w = 68, h = 82,
        mat = MFCD_TEX_IND4_W, name = "rdr_ag_az_sym",
        ctrls = {{"rdr_ag_atenna_beam_az"}}, --parent_element = "",
    },]]
    
    --
    {-- TDC游标 竖线 (只属于MAP模式的，slave to 放大范围符号)
        cx = 0, cy = 0, hw = 113.333/2000, hh = 1536.667/2000, ulx = 1000, uly = 0, w = 68, h = 922,
        mat = MFCD_TEX_IND4, name = "rdr_ag_tdc_line_vert", ctrls = {{"rdr_tdc", 1, 1}},
        level = RDR_LEVEL, clip = h_clip_relations.COMPARE,
    },
    {-- TDC游标 横线 (只属于MAP模式的，slave to 放大范围符号)
        cx = 0, cy = -740/1000, hw = 1536.667/2000, hh = 113.333/2000, ulx = 1000, uly = 922, w = 922, h = 68,
        mat = MFCD_TEX_IND4, name = "rdr_ag_tdc_line_hori", ctrls = {{"rdr_tdc", 2, 1}},
        level = RDR_LEVEL, clip = h_clip_relations.COMPARE,
    },
    
    {-- AG雷达TDC，下一级放大范围指示
        cx = 0, cy = -740/1000, hw = 413.333/2000, hh = 413.333/2000, ulx = 1136, uly = 584, w = 248, h = 248,
        mat = MFCD_TEX_IND4, state_tex = true,
        multi_tex = {
            MFCD_tex_coord(1384,  584, 248, 248, TEX_SIZE_X, TEX_SIZE_Y), -- 4x放大符号
            MFCD_tex_coord(1384,  584, 248, 248, TEX_SIZE_X, TEX_SIZE_Y), -- 2x放大符号
            MFCD_tex_coord(1384,  336, 248, 248, TEX_SIZE_X, TEX_SIZE_Y), -- 十字
        },
        name = "rdr_ag_tdc_combo", ctrls = {{"rdr_tdc", 0}},
        level = RDR_LEVEL, clip = h_clip_relations.COMPARE,
    },
    
    -- 增益
    {-- 上三角
        cx = MFCD_BOX3_L_VERT_X, cy = MFCD_FONT_LR4_Y, hw = 113.333/2000, hh = 113.333/2000, ulx = 1196, uly = 1596, w = 68, h = 68,
        mat = MFCD_TEX_IND1,
        ctrls = {{"rdr_state_draw"}},
    },
    {-- 下三角
        cx = MFCD_BOX3_L_VERT_X, cy = MFCD_FONT_LR5_Y, hw = 113.333/2000, hh = 113.333/2000, ulx = 1196, uly = 1664, w = 68, h = 68,
        mat = MFCD_TEX_IND1,
        ctrls = {{"rdr_state_draw"}},
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
    
    
    if texs[i].init_rot then
        tex_poly.init_rot = texs[i].init_rot
    end
    
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

    if texs[i].level then
        tex_poly.level = texs[i].level
    end
    if texs[i].clip then
        tex_poly.h_clip_relation = texs[i].clip
    end
    
    AddToUpper(tex_poly)
    tex_poly = nil
end


lines = {
    {
        init_pos = {0, -740/1000, 0}, ctrls = {{"rdr_ag_atenna_beam_az_limit", -1, 0.8}, {"rdr_declutter_check"}}
    },
    {
        init_pos = {0, -740/1000, 0}, ctrls = {{"rdr_ag_atenna_beam_az_limit",  1, 0.8}, {"rdr_declutter_check"}}
    },
}

for i=1, #(lines) do
    line_obj                 = CreateElement "ceSimpleLineObject"
    line_obj.material        = MFCD_LINE_DEF
    line_obj.tex_params      = {{0, 0.5}, {1, 0.5}, {0.4, 1}}
    line_obj.width           = 0.004
    line_obj.init_pos        = {0, 0, 0}
    
    if lines[i].mat then
        line_obj.material = lines[i].mat
    end
    
    if lines[i].tex_params then
        line_obj.tex_params = lines[i].tex_params
    end
    
    if lines[i].width then
        line_obj.width = lines[i].width
    end
    
    if lines[i].init_pos then
        line_obj.init_pos = lines[i].init_pos
    end
    
    if lines[i].ctrls then
        line_obj.controllers = lines[i].ctrls
    end
    
    line_obj.isdraw          = false
    line_obj.use_mipfilter   = true
    line_obj.additive_alpha  = true
    AddToUpper(line_obj)
    line_obj = nil
end

-- 雷达天线el范围
local rdr_beam_el_range           = CreateElement "ceSimpleLineObject"
rdr_beam_el_range.name            = "rdr_beam_el_range"
rdr_beam_el_range.material        = MFCD_MATERIAL_DEF
rdr_beam_el_range.width           = 0.015
rdr_beam_el_range.init_pos        = {0, 0, 0}
rdr_beam_el_range.controllers     = {{"rdr_atenna_beam_el_range", -740/1000 + 0.015/2}} --  + rdr_beam_el_range.width/2
AddToUpper(rdr_beam_el_range)

texts = {
    {-- 雷达当前显示距离
        cx = MFCD_FONT_R_HORI_X, cy = (MFCD_FONT_LR1_Y + MFCD_FONT_LR2_Y) / 2, align = "RightCenter", strdefs = MFCD_STRINGDEFS_DEF_X08,
        ctrls = {{"rdr_range"}},
    },
    {-- 雷达el上的扫描俯仰角
        cx = 0.06, cy = 0, mat = MFCD_FONT_G, value = "13", align = "LeftCenter", strdefs = MFCD_STRINGDEFS_DEF_X06,
        ctrls = {{"rdr_el_sym_num"}}, parent = "rdr_ag_el_sym",
    },
    --[[
    {-- 雷达天线 当前线数, 雷达当前PRF
        cx = -0.70, cy = -0.70, align = "LeftCenter", strdefs = MFCD_STRINGDEFS_DEF_X08,
        ctrls = {{"rdr_line_prf"}},
    },
    
    {-- 雷达TDC上的扫描高度范围
        cx = 0.06, cy = 0, mat = MFCD_FONT_W, value = "25\n\n\n13", align = "LeftCenter", strdefs = MFCD_STRINGDEFS_DEF_X06,
        ctrls = {{"rdr_tdc_ag_el_num"}}, parent = "rdr_tdc_sym",
    },
    {-- 雷达TDC上的接近率
        cx = -0.06, cy = 0, mat = MFCD_FONT_W, value = "63", align = "RightCenter", strdefs = MFCD_STRINGDEFS_DEF_X06,
        ctrls = {{"rdr_tdc_ag_vs_rate"}}, parent = "rdr_tdc_sym",
    },
    ]]
    {-- 雷达当前增益
        cx = MFCD_FONT_L_HORI_X, cy = (MFCD_FONT_LR4_Y + MFCD_FONT_LR5_Y) / 2, align = "LeftCenter", strdefs = MFCD_STRINGDEFS_DEF_X08,
        ctrls = {{"rdr_map_gain"}},
    },
    
    {-- HPT信息
        cx = 725/1000, cy = -560/1000, mat = MFCD_FONT_G, value = "TOAXX:XX\nXX.XNM", align = "RightTop", strdefs = MFCD_STRINGDEFS_DEF_X08, isdraw = false,
        ctrls = {{"rdr_ag_tgt_info"}},
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


--============================================================--

dofile(LockOn_Options.script_path .. "MFCD/Indicator/UP_U1_RDR_AG_Contact.lua")

--[[
MAX_CONTACTS = SA_CONTACT_NUM_SHARED
MAX_HISTORY  = 4
hh           = 246.667/2000

for c = 0, (MAX_CONTACTS-1) do
    for h = 0, (MAX_HISTORY-1) do
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
            MFCD_tex_coord(1332,    0, 148, 148, TEX_SIZE_X, TEX_SIZE_Y),--0 静态物体
            MFCD_tex_coord(1184,    0, 148, 148, TEX_SIZE_X, TEX_SIZE_Y),--1 移动综合
        }

        tex_poly.controllers     = {{"rdr_update_contact_ag", c, h}}
        tex_poly.isdraw          = false
        tex_poly.use_mipfilter   = true
        tex_poly.additive_alpha  = false
        tex_poly.h_clip_relation = h_clip_relations.COMPARE
        tex_poly.level           = RDR_LEVEL
        AddToUpper(tex_poly)
        
        tex_poly = nil
    end
    
end


-- 锁定的目标
tex_locked                 = CreateElement "ceTexPoly"
tex_locked.name            = 'rdr_contact_ag_locked'
tex_locked.material        = MFCD_TEX_IND3
tex_locked.init_pos        = {0, -rdr_frame_length_half, 0}
tex_locked.tex_coords      = MFCD_tex_coord(1184, 0, 148, 148, TEX_SIZE_X, TEX_SIZE_Y)
tex_locked.vertices        = { {hh, hh}, {hh,-hh}, {-hh,-hh}, {-hh,hh}, }
tex_locked.indices         = DEF_BOX_INDICES
tex_locked.controllers     = {{"rdr_update_contact_ag_locked"}}
tex_locked.level           = RDR_LEVEL
tex_locked.h_clip_relation = h_clip_relations.COMPARE
tex_locked.isdraw          = false
tex_locked.use_mipfilter   = true
tex_locked.additive_alpha  = false
AddToUpper(tex_locked)


tex_locked_hdg                = CreateElement "ceTexPoly"
tex_locked_hdg.name           = 'rdr_contact_ag_locked_hdg'
tex_locked_hdg.material       = MFCD_TEX_IND3
tex_locked_hdg.init_pos       = {0, 0, 0}
tex_locked_hdg.tex_coords     = MFCD_tex_coord(592, 0, 148, 148, TEX_SIZE_X, TEX_SIZE_Y)
tex_locked_hdg.vertices       = { {hh, hh}, {hh,-hh}, {-hh,-hh}, {-hh,hh}, }
tex_locked_hdg.indices        = DEF_BOX_INDICES
tex_locked_hdg.controllers    = {{"rdr_update_contact_ag_locked_hdg"}}
tex_locked_hdg.parent_element = tex_locked.name
tex_locked_hdg.use_mipfilter  = true
tex_locked_hdg.additive_alpha = false
AddToUpper(tex_locked_hdg)


tex_locked_line_vert                 = CreateElement "ceTexPoly"
tex_locked_line_vert.name            = 'rdr_contact_ag_locked_line_vert'
tex_locked_line_vert.material        = MFCD_TEX_IND5_W
tex_locked_line_vert.init_pos        = {0, 0, 0}
tex_locked_line_vert.tex_coords      = MFCD_tex_coord(2012, 0, 36, 1800, TEX_SIZE_X, TEX_SIZE_Y)
tex_locked_line_vert.vertices        = {{ 60/2000, 3000/2000},
                                        { 60/2000,-3000/2000},
                                        {-60/2000,-3000/2000},
                                        {-60/2000, 3000/2000},}
tex_locked_line_vert.indices         = DEF_BOX_INDICES
tex_locked_line_vert.level           = RDR_LEVEL
tex_locked_line_vert.h_clip_relation = h_clip_relations.COMPARE
tex_locked_line_vert.parent_element  = tex_locked.name
tex_locked_line_vert.use_mipfilter   = true
tex_locked_line_vert.additive_alpha  = false
AddToUpper(tex_locked_line_vert)


tex_locked_line_hori                 = CreateElement "ceTexPoly"
tex_locked_line_hori.name            = 'rdr_contact_ag_locked_line_hori'
tex_locked_line_hori.material        = MFCD_TEX_IND5_W
tex_locked_line_hori.init_pos        = {0, 0, 0}
tex_locked_line_hori.tex_coords      = MFCD_tex_coord(0, 2012, 1800, 36, TEX_SIZE_X, TEX_SIZE_Y)
tex_locked_line_hori.vertices        = {{ 3000/2000, 60/2000},
                                        { 3000/2000,-60/2000},
                                        {-3000/2000,-60/2000},
                                        {-3000/2000, 60/2000},}
tex_locked_line_hori.indices         = DEF_BOX_INDICES
tex_locked_line_hori.level           = RDR_LEVEL
tex_locked_line_hori.h_clip_relation = h_clip_relations.COMPARE
tex_locked_line_hori.parent_element  = tex_locked.name
tex_locked_line_hori.use_mipfilter   = true
tex_locked_line_hori.additive_alpha  = false
AddToUpper(tex_locked_line_hori)


-- 当前航路点
current_wpt                 = CreateElement "ceTexPoly"
current_wpt.name            = 'rdr_ag_current_wpt'
current_wpt.material        = MFCD_TEX_IND3_W
current_wpt.init_pos        = {0, -rdr_frame_length_half, 0}
current_wpt.tex_coords      = MFCD_tex_coord(1036, 0, 148, 148, TEX_SIZE_X, TEX_SIZE_Y)
current_wpt.vertices        = { {hh, hh}, {hh,-hh}, {-hh,-hh}, {-hh,hh}, }
current_wpt.indices         = DEF_BOX_INDICES
current_wpt.controllers     = {{"rdr_update_current_wpt", 1}, {"rdr_declutter_check"}}
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
