
--============================================================--

local MAX_CONTACTS = SA_CONTACT_NUM_SHARED
local MAX_HISTORY  = 4
local hh           = 246.667/2000

for c = 0, (MAX_CONTACTS-1) do
    for h = 0, (MAX_HISTORY-1) do
        -- 目标模板
        tex_poly          = CreateElement "ceTexPoly"
        tex_poly.name     = 'rdr_contact_ag_' .. tostring(c) .. '_' .. tostring(h)

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
        
        --[[
        -- alt str
        rdr_contact_alt_str                = CreateElement "ceStringPoly"
        rdr_contact_alt_str.material       = MFCD_FONT_W
        rdr_contact_alt_str.stringdefs     = MFCD_STRINGDEFS_DEF_X04
        rdr_contact_alt_str.alignment      = "LeftCenter"
        rdr_contact_alt_str.init_pos       = {0.25*hh, -0.25*hh}
        rdr_contact_alt_str.value          = "00"
        rdr_contact_alt_str.parent_element = tex_poly.name
        rdr_contact_alt_str.controllers    = {{"rdr_contact_ag_alt_str", c, h}}
        AddToUpper(rdr_contact_alt_str)
        rdr_contact_alt_str = nil
        ]]
        
        tex_poly = nil
    end
    
end


-- 锁定的目标
local tex_locked           = CreateElement "ceTexPoly"
tex_locked.name            = 'rdr_contact_ag_locked'
tex_locked.material        = MFCD_TEX_IND3
tex_locked.init_pos        = {0, -rdr_frame_length_half, 0}
tex_locked.tex_coords      = MFCD_tex_coord(1184, 0, 148, 148, TEX_SIZE_X, TEX_SIZE_Y)
tex_locked.vertices        = { {hh, hh}, {hh,-hh}, {-hh,-hh}, {-hh,hh}, }
tex_locked.indices         = DEF_BOX_INDICES
--[[tex_locked.state_tex_coords = {
    MFCD_tex_coord(1184,    0, 148, 148, TEX_SIZE_X, TEX_SIZE_Y),--0 实心正方形: RWS默认
}]]
tex_locked.controllers     = {{"rdr_update_contact_ag_locked"}}
tex_locked.level           = RDR_LEVEL
tex_locked.h_clip_relation = h_clip_relations.COMPARE
tex_locked.isdraw          = false
tex_locked.use_mipfilter   = true
tex_locked.additive_alpha  = false
AddToUpper(tex_locked)


local tex_locked_hdg          = CreateElement "ceTexPoly"
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


local tex_locked_line_vert           = CreateElement "ceTexPoly"
tex_locked_line_vert.name            = 'rdr_contact_ag_locked_line_vert'
tex_locked_line_vert.material        = MFCD_TEX_IND5
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


local tex_locked_line_hori           = CreateElement "ceTexPoly"
tex_locked_line_hori.name            = 'rdr_contact_ag_locked_line_hori'
tex_locked_line_hori.material        = MFCD_TEX_IND5
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
local current_wpt           = CreateElement "ceTexPoly"
current_wpt.name            = 'rdr_ag_current_wpt'
current_wpt.material        = MFCD_TEX_IND3
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

local current_wpt_id           = CreateElement "ceStringPoly"
current_wpt_id.name            = 'rdr_ag_current_wpt_id'
current_wpt_id.material        = MFCD_FONT_G
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



