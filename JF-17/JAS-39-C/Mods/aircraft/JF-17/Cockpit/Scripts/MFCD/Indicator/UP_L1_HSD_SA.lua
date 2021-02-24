
----[[ RWR ]]
-- RWR照射模板
rwr_bound_l = fwd_square_clip.vertices[3][1]
rwr_bound_r = fwd_square_clip.vertices[1][1]
rwr_bound_u = fwd_square_clip.vertices[1][2] - FWD_COMP_BIAS
rwr_bound_d = fwd_square_clip.vertices[3][2] - FWD_COMP_BIAS

local hh = 148/106*176.667/2000

local MAX_RWR_CONTACTS = 64
for c = 0, (MAX_RWR_CONTACTS-1) do
    -- 目标符号
    local rwr_sym_poly        = CreateElement "ceTexPoly"
    rwr_sym_poly.init_pos     = {0, FWD_COMP_BIAS, 0}
    rwr_sym_poly.name         = 'rwr_contact_' .. c .. '_0'
    rwr_sym_poly.vertices     = {{hh, hh}, {hh,-hh}, {-hh,-hh}, {-hh,hh},}
    rwr_sym_poly.indices      = DEF_BOX_INDICES

    rwr_sym_poly.material     = MFCD_TEX_IND3
    rwr_sym_poly.state_tex_coords = {
        MFCD_tex_coord( 444,  444, 148, 148, TEX_SIZE_X, TEX_SIZE_Y),--1 空中
        MFCD_tex_coord( 592,  444, 148, 148, TEX_SIZE_X, TEX_SIZE_Y),--2 空中带干扰
        MFCD_tex_coord( 740,  444, 148, 148, TEX_SIZE_X, TEX_SIZE_Y),--3 空中高威胁
        MFCD_tex_coord(   0,  296, 148, 148, TEX_SIZE_X, TEX_SIZE_Y),--4 SAM
        MFCD_tex_coord( 148,  296, 148, 148, TEX_SIZE_X, TEX_SIZE_Y),--5 SAM高威胁
        MFCD_tex_coord( 296,  296, 148, 148, TEX_SIZE_X, TEX_SIZE_Y),--6 高炮
        MFCD_tex_coord( 444,  296, 148, 148, TEX_SIZE_X, TEX_SIZE_Y),--7 高炮高威胁
        MFCD_tex_coord( 592,  296, 148, 148, TEX_SIZE_X, TEX_SIZE_Y),--8 海面
        MFCD_tex_coord( 740,  296, 148, 148, TEX_SIZE_X, TEX_SIZE_Y),--9 海面高威胁
        MFCD_tex_coord( 888,  296, 148, 148, TEX_SIZE_X, TEX_SIZE_Y),--10 导弹
        MFCD_tex_coord(1036,  296, 148, 148, TEX_SIZE_X, TEX_SIZE_Y),--10 导弹UH
        MFCD_tex_coord(1184,  296, 148, 148, TEX_SIZE_X, TEX_SIZE_Y),--10 导弹LH
        MFCD_tex_coord(1900, 1900, 148, 148, TEX_SIZE_X, TEX_SIZE_Y),--11 未知空白
    }
    rwr_sym_poly.level           = HSD_NAV_LEVEL + 2 + HSD_NAV_LEVEL_SHIFT
    rwr_sym_poly.h_clip_relation = h_clip_relations.COMPARE
    rwr_sym_poly.controllers     = {{"rwr_update_contact_sym", rwr_bound_l, rwr_bound_r, rwr_bound_u, rwr_bound_d, c}}
    rwr_sym_poly.isdraw          = false
    rwr_sym_poly.use_mipfilter   = true
    rwr_sym_poly.additive_alpha  = false
    AddToUpper(rwr_sym_poly)
    
    -- 目标识别
    local rwr_text_poly           = CreateElement "ceStringPoly"
    rwr_text_poly.material        = MFCD_FONT_DEF
    rwr_text_poly.stringdefs      = MFCD_STRINGDEFS_DEF_X075
    rwr_text_poly.init_pos        = {0, 0, 0}
    rwr_text_poly.alignment       = "CenterCenter"
    rwr_text_poly.value           = "FA"
    rwr_text_poly.level           = HSD_NAV_LEVEL + 2 + HSD_NAV_LEVEL_SHIFT
    rwr_text_poly.h_clip_relation = h_clip_relations.COMPARE
    rwr_text_poly.controllers     = {{"rwr_update_contact_str", rwr_bound_l, rwr_bound_r, rwr_bound_u, rwr_bound_d, c}}
    rwr_text_poly.parent_element  = rwr_sym_poly.name
    rwr_text_poly.isdraw          = false
    AddToUpper(rwr_text_poly)
    rwr_text_poly = nil
end


----[[ MAWS ]]
local hh = 148/106*176.667/2000

local MAX_MAWS_CONTACTS = 20
for c = 0, (MAX_MAWS_CONTACTS-1) do
    -- 目标符号
    local maws_sym_poly        = CreateElement "ceTexPoly"
    maws_sym_poly.init_pos     = {0, FWD_COMP_BIAS, 0}
    maws_sym_poly.name         = 'maws_contact_' .. c .. '_0'
    maws_sym_poly.vertices     = {{hh, hh}, {hh,-hh}, {-hh,-hh}, {-hh,hh},}
    maws_sym_poly.indices      = DEF_BOX_INDICES

    maws_sym_poly.material     = MFCD_TEX_IND3
    maws_sym_poly.state_tex_coords = {
        MFCD_tex_coord( 888,  296, 148, 148, TEX_SIZE_X, TEX_SIZE_Y),--10 导弹
        MFCD_tex_coord(1036,  296, 148, 148, TEX_SIZE_X, TEX_SIZE_Y),--10 导弹UH
        MFCD_tex_coord(1184,  296, 148, 148, TEX_SIZE_X, TEX_SIZE_Y),--10 导弹LH
        MFCD_tex_coord(1900, 1900, 148, 148, TEX_SIZE_X, TEX_SIZE_Y),--11 未知空白
    }
    maws_sym_poly.controllers     = {{'maws_update_contact_sym', c},}
    maws_sym_poly.level           = HSD_NAV_LEVEL + 2 + HSD_NAV_LEVEL_SHIFT
    maws_sym_poly.h_clip_relation = h_clip_relations.COMPARE
    maws_sym_poly.isdraw          = false
    maws_sym_poly.use_mipfilter   = true
    maws_sym_poly.additive_alpha  = false
    AddToUpper(maws_sym_poly)
    
    -- 目标识别
    local maws_text_poly           = CreateElement "ceStringPoly"
    maws_text_poly.material        = MFCD_FONT_DEF
    maws_text_poly.stringdefs      = MFCD_STRINGDEFS_DEF_X075
    maws_text_poly.init_pos        = {0, 0, 0}
    maws_text_poly.alignment       = "CenterCenter"
    maws_text_poly.value           = " M "
    maws_text_poly.level           = HSD_NAV_LEVEL + 2 + HSD_NAV_LEVEL_SHIFT
    maws_text_poly.h_clip_relation = h_clip_relations.COMPARE
    maws_text_poly.controllers     = {{"maws_update_contact_str", c}}
    maws_text_poly.parent_element  = maws_sym_poly.name
    AddToUpper(maws_text_poly)
    
end



----[[ DL ]]
local hh = 246.667/2000

-- contact
local MAX_DL_CONTACTS = SA_CONTACT_NUM_SHARED
for cat = 0, 2 do
    for c = 0, (MAX_DL_CONTACTS-1) do
        -- 目标模板
        local tex_poly        = CreateElement "ceTexPoly"
        tex_poly.init_pos     = {0, FWD_COMP_BIAS, 0}
        if cat > 0 then
            tex_poly.name     = 'sa_dl_contact_' .. c .. '_' .. cat
        else
            tex_poly.name     = 'sa_rdr_contact_' .. c .. '_0'
        end
        tex_poly.vertices     = {{hh, hh}, {hh,-hh}, {-hh,-hh}, {-hh,hh},}
        tex_poly.indices      = DEF_BOX_INDICES
        --

        tex_poly.material     = MFCD_TEX_IND3
        tex_poly.state_tex_coords = {
            MFCD_tex_coord(   0, 148, 148, 148, TEX_SIZE_X, TEX_SIZE_Y),--0 空心三角形: 敌机
            MFCD_tex_coord( 592, 148, 148, 148, TEX_SIZE_X, TEX_SIZE_Y),--1 空心圆    : 友机
            MFCD_tex_coord( 296, 148, 148, 148, TEX_SIZE_X, TEX_SIZE_Y),--2 空心标签  : 面目标
            
            MFCD_tex_coord( 148, 148, 148, 148, TEX_SIZE_X, TEX_SIZE_Y),--3 空心三角形+横线: 敌机
            MFCD_tex_coord( 740, 148, 148, 148, TEX_SIZE_X, TEX_SIZE_Y),--4 空心圆+横线    : 友机
            MFCD_tex_coord( 444, 148, 148, 148, TEX_SIZE_X, TEX_SIZE_Y),--5 空心标签+横线  : 面目标
        }
        tex_poly.controllers     = {{'sa_dl_rdr_update_contact', cat, c},}
        tex_poly.level           = HSD_NAV_LEVEL + 2 + HSD_NAV_LEVEL_SHIFT
        tex_poly.h_clip_relation = h_clip_relations.COMPARE
        tex_poly.isdraw          = false
        tex_poly.use_mipfilter   = true
        tex_poly.additive_alpha  = false
        AddToUpper(tex_poly)
        
        -- net ID
        local dl_contact_id              = CreateElement 'ceStringPoly'
        dl_contact_id.material           = MFCD_FONT_DEF
        dl_contact_id.stringdefs         = MFCD_STRINGDEFS_DEF_X05
        dl_contact_id.init_pos           = {0, 0, 0}
        dl_contact_id.alignment          = 'CenterCenter'
        dl_contact_id.value              = "00"
        dl_contact_id.level              = HSD_NAV_LEVEL + 2 + HSD_NAV_LEVEL_SHIFT
        dl_contact_id.h_clip_relation    = h_clip_relations.COMPARE
        dl_contact_id.controllers        = {{'sa_dl_rdr_contact_text', cat, c, 0},}
        dl_contact_id.parent_element     = tex_poly.name

        AddToUpper(dl_contact_id)

        -- alt str
        local dl_contact_alt_str           = CreateElement "ceStringPoly"
        dl_contact_alt_str.material        = MFCD_FONT_DEF
        dl_contact_alt_str.stringdefs      = MFCD_STRINGDEFS_DEF_X06
        dl_contact_alt_str.init_pos        = {0.0*hh, -0.6*hh, 0}
        dl_contact_alt_str.alignment       = "CenterCenter"
        dl_contact_alt_str.value           = "00"
        dl_contact_alt_str.level           = HSD_NAV_LEVEL + 2 + HSD_NAV_LEVEL_SHIFT
        dl_contact_alt_str.h_clip_relation = h_clip_relations.COMPARE
        dl_contact_alt_str.controllers     = {{"sa_dl_rdr_contact_text", cat, c, 1}}
        dl_contact_alt_str.parent_element  = tex_poly.name
        AddToUpper(dl_contact_alt_str)
        
        tex_poly = nil
    end
end

---- 包线
my_tgt_assign_line                 = CreateElement "ceSimpleLineObject"
my_tgt_assign_line.name            = "my_tgt_assign_line"
my_tgt_assign_line.material        = MFCD_LINE_YELLOW
my_tgt_assign_line.tex_params      = {{0, 0.5}, {1, 0.5}, {0.4, 1}}
my_tgt_assign_line.width           = 0.004
my_tgt_assign_line.init_pos        = {0, FWD_COMP_BIAS, 0}
my_tgt_assign_line.level           = HSD_NAV_LEVEL + 2 + HSD_NAV_LEVEL_SHIFT
my_tgt_assign_line.h_clip_relation = h_clip_relations.COMPARE
my_tgt_assign_line.controllers     = {{"my_tgt_assign_line", 1.0}}
my_tgt_assign_line.isdraw          = false
my_tgt_assign_line.use_mipfilter   = true
my_tgt_assign_line.additive_alpha  = true
AddToUpper(my_tgt_assign_line)


msl_env_line                 = CreateElement "ceSimpleLineObject"
msl_env_line.name            = "msl_env_line"
--msl_env_line.material        = MFCD_MATERIAL_RED
msl_env_line.material        = MFCD_LINE_RED
msl_env_line.tex_params      = {{0, 0.5}, {1, 0.5}, {0.4, 1}}
msl_env_line.width           = 0.004
msl_env_line.init_pos        = {0, FWD_COMP_BIAS, 0}
msl_env_line.level           = HSD_NAV_LEVEL + 2 + HSD_NAV_LEVEL_SHIFT
msl_env_line.h_clip_relation = h_clip_relations.COMPARE
msl_env_line.controllers     = {{"dl_update_msl_env", 1.0}}
msl_env_line.isdraw          = false
msl_env_line.use_mipfilter   = true
msl_env_line.additive_alpha  = true
AddToUpper(msl_env_line)


rdr_env_line                 = CreateElement "ceSimpleLineObject"
rdr_env_line.name            = "rdr_env_line"
rdr_env_line.material        = MFCD_MATERIAL_DEF
rdr_env_line.width           = 0.004
rdr_env_line.init_pos        = {0, FWD_COMP_BIAS, 0}
rdr_env_line.level           = HSD_NAV_LEVEL + 2 + HSD_NAV_LEVEL_SHIFT
rdr_env_line.h_clip_relation = h_clip_relations.COMPARE
rdr_env_line.controllers     = {{"dl_update_rdr_env", 1.0}}
rdr_env_line.isdraw          = false
rdr_env_line.use_mipfilter   = true
rdr_env_line.additive_alpha  = true
AddToUpper(rdr_env_line)





