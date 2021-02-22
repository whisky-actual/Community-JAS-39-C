----[[ PP, SPI 等目标信息 ]]

local idx = 0
for idx = 0, 1 do

    -- PP/SPI etc
    tgt_sym_tex                 = CreateElement "ceTexPoly"
    tgt_sym_tex.name            = "tgt_sym_node" .. tostring(idx)
    tgt_sym_tex.material        = MFCD_TEX_IND3
    tgt_sym_tex.init_pos        = {0, FWD_COMP_BIAS, 0}
    tgt_sym_tex.tex_coords      = MFCD_tex_coord(888, 0, 148, 148, TEX_SIZE_X, TEX_SIZE_Y)
    tgt_sym_tex.vertices        = {{ 246.667/2000, 246.667/2000},
                                   { 246.667/2000,-246.667/2000},
                                   {-246.667/2000,-246.667/2000},
                                   {-246.667/2000, 246.667/2000},}
    tgt_sym_tex.indices         = DEF_BOX_INDICES
    tgt_sym_tex.level           = HSD_NAV_LEVEL + 2 + HSD_NAV_LEVEL_SHIFT
    tgt_sym_tex.h_clip_relation = h_clip_relations.COMPARE
    tgt_sym_tex.controllers     = {{"tgt_update_tgt_oap", 0, idx}}
    tgt_sym_tex.isdraw          = false
    tgt_sym_tex.use_mipfilter   = true
    tgt_sym_tex.additive_alpha  = true
    AddToUpper(tgt_sym_tex)
    tgt_sym_tex = nil

    -- DLZ max/min
    tgt_dlz_max                 = CreateElement "ceSimpleLineObject"
    tgt_dlz_max.name            = "tgt_dlz_max" .. tostring(idx)
    tgt_dlz_max.material        = MFCD_MATERIAL_BLUE_L
    tgt_dlz_max.width           = 2/600
    tgt_dlz_max.init_pos        = {0, FWD_COMP_BIAS, 0}
    tgt_dlz_max.level           = HSD_NAV_LEVEL + 2 + HSD_NAV_LEVEL_SHIFT
    tgt_dlz_max.h_clip_relation = h_clip_relations.COMPARE
    tgt_dlz_max.controllers     = {{"tgt_update_tgt_dlz_line", 0, idx}}
    tgt_dlz_max.isdraw          = false
    tgt_dlz_max.use_mipfilter   = true
    tgt_dlz_max.additive_alpha  = true
    AddToUpper(tgt_dlz_max)
    tgt_dlz_max = nil

    tgt_dlz_min                 = CreateElement "ceSimpleLineObject"
    tgt_dlz_min.name            = "tgt_dlz_min" .. tostring(idx)
    tgt_dlz_min.material        = MFCD_MATERIAL_RED
    tgt_dlz_min.width           = 2/600
    tgt_dlz_min.init_pos        = {0, FWD_COMP_BIAS, 0}
    tgt_dlz_min.level           = HSD_NAV_LEVEL + 2 + HSD_NAV_LEVEL_SHIFT
    tgt_dlz_min.h_clip_relation = h_clip_relations.COMPARE
    tgt_dlz_min.controllers     = {{"tgt_update_tgt_dlz_line", 1, idx}}
    tgt_dlz_min.isdraw          = false
    tgt_dlz_min.use_mipfilter   = true
    tgt_dlz_min.additive_alpha  = true
    AddToUpper(tgt_dlz_min)
    tgt_dlz_min = nil

    -- DLZ AZ
    tgt_dlz_imp_az                 = CreateElement "ceSimpleLineObject"
    tgt_dlz_imp_az.name            = "tgt_dlz_imp_az_dashed" .. tostring(idx)
    --tgt_dlz_imp_az.material        = MFCD_MATERIAL_WHITE
    tgt_dlz_imp_az.material        = MFCD_LINE_RED
    tgt_dlz_imp_az.tex_params      = {{0, 0.5}, {1, 0.5}, {0.4, 1}}
    tgt_dlz_imp_az.width           = 0.004
    tgt_dlz_imp_az.init_pos        = {0, FWD_COMP_BIAS, 0}
    tgt_dlz_imp_az.level           = HSD_NAV_LEVEL + 2 + HSD_NAV_LEVEL_SHIFT
    tgt_dlz_imp_az.h_clip_relation = h_clip_relations.COMPARE
    tgt_dlz_imp_az.controllers     = {{"tgt_update_tgt_dlz_imp_az_line", 0, idx}}
    tgt_dlz_imp_az.isdraw          = false
    tgt_dlz_imp_az.use_mipfilter   = true
    tgt_dlz_imp_az.additive_alpha  = true
    AddToUpper(tgt_dlz_imp_az)
    tgt_dlz_imp_az = nil

    tgt_dlz_imp_az                 = CreateElement "ceSimpleLineObject"
    tgt_dlz_imp_az.name            = "tgt_dlz_imp_az_solid" .. tostring(idx)
    tgt_dlz_imp_az.material        = MFCD_MATERIAL_BLUE_L
    --tgt_dlz_imp_az.material        = MFCD_LINE_WHITE
    --tgt_dlz_imp_az.tex_params      = {{0, 0.5}, {1, 0.5}, {0.4, 1}}
    tgt_dlz_imp_az.width           = 0.004
    tgt_dlz_imp_az.init_pos        = {0, FWD_COMP_BIAS, 0}
    tgt_dlz_imp_az.level           = HSD_NAV_LEVEL + 2 + HSD_NAV_LEVEL_SHIFT
    tgt_dlz_imp_az.h_clip_relation = h_clip_relations.COMPARE
    tgt_dlz_imp_az.controllers     = {{"tgt_update_tgt_dlz_imp_az_line", 1, idx}}
    tgt_dlz_imp_az.isdraw          = false
    tgt_dlz_imp_az.use_mipfilter   = true
    tgt_dlz_imp_az.additive_alpha  = true
    AddToUpper(tgt_dlz_imp_az)
    tgt_dlz_imp_az = nil

    -- Target Line
    tgt_line                 = CreateElement "ceSimpleLineObject"
    tgt_line.name            = "tgt_line_dashed" .. tostring(idx)
    --tgt_line.material        = MFCD_MATERIAL_WHITE
    tgt_line.material        = MFCD_LINE_RED
    tgt_line.tex_params      = {{0, 0.5}, {1, 0.5}, {0.4, 1}}
    tgt_line.width           = 0.004
    tgt_line.init_pos        = {0, FWD_COMP_BIAS, 0}
    tgt_line.level           = HSD_NAV_LEVEL + 2 + HSD_NAV_LEVEL_SHIFT
    tgt_line.h_clip_relation = h_clip_relations.COMPARE
    tgt_line.controllers     = {{"tgt_update_line", 0, idx}}
    tgt_line.isdraw          = false
    tgt_line.use_mipfilter   = true
    tgt_line.additive_alpha  = true
    AddToUpper(tgt_line)
    tgt_line = nil

    tgt_line                 = CreateElement "ceSimpleLineObject"
    tgt_line.name            = "tgt_line_solid" .. tostring(idx)
    tgt_line.material        = MFCD_MATERIAL_BLUE_L
    --tgt_line.material        = MFCD_LINE_WHITE
    --tgt_line.tex_params      = {{0, 0.5}, {1, 0.5}, {0.4, 1}}
    tgt_line.width           = 0.004
    tgt_line.init_pos        = {0, FWD_COMP_BIAS, 0}
    tgt_line.level           = HSD_NAV_LEVEL + 2 + HSD_NAV_LEVEL_SHIFT
    tgt_line.h_clip_relation = h_clip_relations.COMPARE
    tgt_line.controllers     = {{"tgt_update_line", 1, idx}}
    tgt_line.isdraw          = false
    tgt_line.use_mipfilter   = true
    tgt_line.additive_alpha  = true
    AddToUpper(tgt_line)
    tgt_line = nil

    ---- OAP
    oap_sym_tex                 = CreateElement "ceTexPoly"
    oap_sym_tex.name            = "oap_sym_node" .. tostring(idx)
    oap_sym_tex.material        = MFCD_TEX_IND3_BL
    oap_sym_tex.init_pos        = {0, FWD_COMP_BIAS, 0}
    oap_sym_tex.tex_coords      = MFCD_tex_coord(296, 444, 148, 148, TEX_SIZE_X, TEX_SIZE_Y)
    oap_sym_tex.vertices        = {{ 246.667/2000, 246.667/2000},
                                   { 246.667/2000,-246.667/2000},
                                   {-246.667/2000,-246.667/2000},
                                   {-246.667/2000, 246.667/2000},}
    oap_sym_tex.indices         = DEF_BOX_INDICES
    oap_sym_tex.level           = HSD_NAV_LEVEL + 2 + HSD_NAV_LEVEL_SHIFT
    oap_sym_tex.h_clip_relation = h_clip_relations.COMPARE
    oap_sym_tex.controllers     = {{"tgt_update_tgt_oap", 1, idx}}
    oap_sym_tex.isdraw          = false
    oap_sym_tex.use_mipfilter   = true
    oap_sym_tex.additive_alpha  = true
    AddToUpper(oap_sym_tex)
    oap_sym_tex = nil

    oap_line                 = CreateElement "ceSimpleLineObject"
    oap_line.name            = "oap_line" .. tostring(idx)
    oap_line.material        = MFCD_MATERIAL_YELLOW
    --[[
    oap_line.material        = MFCD_LINE_RED
    oap_line.tex_params      = {{0, 0.5}, {1, 0.5}, {0.5, 1}}
    ]]
    oap_line.width           = 0.004
    oap_line.init_pos        = {0, FWD_COMP_BIAS, 0}
    oap_line.level           = HSD_NAV_LEVEL + 2 + HSD_NAV_LEVEL_SHIFT
    oap_line.h_clip_relation = h_clip_relations.COMPARE
    oap_line.controllers     = {{"tgt_update_oap_route", 0.044, idx}}
    oap_line.isdraw          = false
    oap_line.use_mipfilter   = true
    oap_line.additive_alpha  = true
    AddToUpper(oap_line)
    oap_line = nil
    
end

local spi_idx = 2
-- SPI
spi_sym_tex                 = CreateElement "ceTexPoly"
spi_sym_tex.name            = "tgt_sym_node" .. tostring(spi_idx)
spi_sym_tex.material        = MFCD_TEX_IND3
spi_sym_tex.init_pos        = {0, FWD_COMP_BIAS, 0}
spi_sym_tex.tex_coords      = MFCD_tex_coord(888, 0, 148, 148, TEX_SIZE_X, TEX_SIZE_Y)
spi_sym_tex.vertices        = {{ 246.667/2000, 246.667/2000},
                               { 246.667/2000,-246.667/2000},
                               {-246.667/2000,-246.667/2000},
                               {-246.667/2000, 246.667/2000},}
spi_sym_tex.indices         = DEF_BOX_INDICES
spi_sym_tex.level           = HSD_NAV_LEVEL + 2 + HSD_NAV_LEVEL_SHIFT
spi_sym_tex.h_clip_relation = h_clip_relations.COMPARE
spi_sym_tex.controllers     = {{"tgt_update_tgt_oap", 0, spi_idx}}
spi_sym_tex.isdraw          = false
spi_sym_tex.use_mipfilter   = true
spi_sym_tex.additive_alpha  = true
AddToUpper(spi_sym_tex)

oap_sym_tex                 = CreateElement "ceTexPoly"
oap_sym_tex.name            = "oap_sym_node" .. tostring(spi_idx)
oap_sym_tex.material        = MFCD_TEX_IND3
oap_sym_tex.init_pos        = {0, FWD_COMP_BIAS, 0}
oap_sym_tex.tex_coords      = MFCD_tex_coord(296, 444, 148, 148, TEX_SIZE_X, TEX_SIZE_Y)
oap_sym_tex.vertices        = {{ 246.667/2000, 246.667/2000},
                               { 246.667/2000,-246.667/2000},
                               {-246.667/2000,-246.667/2000},
                               {-246.667/2000, 246.667/2000},}
oap_sym_tex.indices         = DEF_BOX_INDICES
oap_sym_tex.level           = HSD_NAV_LEVEL + 2 + HSD_NAV_LEVEL_SHIFT
oap_sym_tex.h_clip_relation = h_clip_relations.COMPARE
oap_sym_tex.controllers     = {{"tgt_update_tgt_oap", 1, spi_idx}}
oap_sym_tex.isdraw          = false
oap_sym_tex.use_mipfilter   = true
oap_sym_tex.additive_alpha  = true
AddToUpper(oap_sym_tex)

oap_line                 = CreateElement "ceSimpleLineObject"
oap_line.name            = "oap_line" .. tostring(spi_idx)
oap_line.material        = MFCD_MATERIAL_YELLOW
--[[
oap_line.material        = MFCD_LINE_RED
oap_line.tex_params      = {{0, 0.5}, {1, 0.5}, {0.5, 1}}
]]
oap_line.width           = 0.004
oap_line.init_pos        = {0, FWD_COMP_BIAS, 0}
oap_line.level           = HSD_NAV_LEVEL + 2 + HSD_NAV_LEVEL_SHIFT
oap_line.h_clip_relation = h_clip_relations.COMPARE
oap_line.controllers     = {{"tgt_update_oap_route", 0.044, spi_idx}}
oap_line.isdraw          = false
oap_line.use_mipfilter   = true
oap_line.additive_alpha  = true
AddToUpper(oap_line)

