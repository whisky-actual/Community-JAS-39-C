dofile(LockOn_Options.script_path .. "MFCD/MFCDs_defs.lua")

local page_root = create_page_root()

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
--TV_RENDER.material        = "render_target_"..tostring(GetRenderTarget() + 1)
TV_RENDER.material        = "AGRadar_Material_" .. tostring(GetRenderTarget())
TV_RENDER.level           = RDR_LEVEL
TV_RENDER.h_clip_relation = h_clip_relations.COMPARE
TV_RENDER.controllers     = {{'rdr_video_check'},}

AddToUpper(TV_RENDER)

texs = {
    {-- 雷达框
        cx = 0, cy = 0, hw = 1666.67/2000, hh = 1666.67/2000, ulx = 0, uly = 0, w = 1000, h = 1000,
        mat = MFCD_TEX_IND4, state_tex = true,
        multi_tex = {
            MFCD_tex_coord(0,    0, 1000, 1000, TEX_SIZE_X, TEX_SIZE_Y), -- AA
            MFCD_tex_coord(0, 1000, 1000, 1000, TEX_SIZE_X, TEX_SIZE_Y), -- AG
        },
        ctrls = {{"rdr_frame_type"}, {"rdr_declutter_check"},},
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

---- 文字部分
local texts = {
    
    -- left
    {
        cx = MFCD_FONT_L_HORI_X, cy = MFCD_FONT_LR1_Y, value = "1", alignment = "LeftCenter", -- TODO: controller
        ctrls = {{"rdr_mode_list", 0}},
    },
    {
        cx = MFCD_FONT_L_HORI_X, cy = MFCD_FONT_LR2_Y, value = "2", alignment = "LeftCenter", -- TODO: controller
        ctrls = {{"rdr_mode_list", 1}},
    },
    {
        cx = MFCD_FONT_L_HORI_X, cy = MFCD_FONT_LR3_Y, value = "3", alignment = "LeftCenter", -- TODO: controller
        ctrls = {{"rdr_mode_list", 2}},
    },
    {
        cx = MFCD_FONT_L_HORI_X, cy = MFCD_FONT_LR4_Y, value = "4", alignment = "LeftCenter", -- TODO: controller
        ctrls = {{"rdr_mode_list", 3}},
    },
    {
        cx = MFCD_FONT_L_HORI_X, cy = MFCD_FONT_LR5_Y, value = "5", alignment = "LeftCenter", -- TODO: controller
        ctrls = {{"rdr_mode_list", 4}},
    },
    
    -- right
    {
        cx = MFCD_FONT_R_HORI_X, cy = MFCD_FONT_LR1_Y, value = "6", alignment = "RightCenter", -- TODO: controller
        ctrls = {{"rdr_mode_list", 5}},
    },
    {
        cx = MFCD_FONT_R_HORI_X, cy = MFCD_FONT_LR2_Y, value = "7", alignment = "RightCenter", -- TODO: controller
        ctrls = {{"rdr_mode_list", 6}},
    },
    {
        cx = MFCD_FONT_R_HORI_X, cy = MFCD_FONT_LR3_Y, value = "8", alignment = "RightCenter", -- TODO: controller
        ctrls = {{"rdr_mode_list", 7}},
    },
    {
        cx = MFCD_FONT_R_HORI_X, cy = MFCD_FONT_LR4_Y, value = "9", alignment = "RightCenter", -- TODO: controller
        ctrls = {{"rdr_mode_list", 8}},
    },
    {
        cx = MFCD_FONT_R_HORI_X, cy = MFCD_FONT_LR5_Y, value = "10", alignment = "RightCenter", -- TODO: controller
        ctrls = {{"rdr_mode_list", 9}},
    },
}

for i=1, #(texts) do
    text_strpoly            = CreateElement "ceStringPoly"
    text_strpoly.material   = MFCD_FONT_DEF
    text_strpoly.stringdefs = MFCD_STRINGDEFS_DEF
    text_strpoly.init_pos   = {texts[i].cx, texts[i].cy, 0}
    text_strpoly.alignment  = "CenterCenter"
    
    if texts[i].name then
        text_strpoly.name           = texts[i].name
    end
    
    if texts[i].alignment then
        text_strpoly.alignment      = texts[i].alignment
    end    
    if texts[i].formats then
        text_strpoly.formats        = texts[i].formats
    end
    if texts[i].params then
        text_strpoly.element_params = texts[i].params
    end
    if texts[i].ctrls then
        text_strpoly.controllers    = texts[i].ctrls
    end
    if texts[i].value then
        text_strpoly.value          = texts[i].value
    end
    AddToUpper(text_strpoly)
    text_strpoly = nil
end

--
dofile(LockOn_Options.script_path .. "MFCD/Indicator/UP_U1_RDR_AA_Contact.lua")

dofile(LockOn_Options.script_path .. "MFCD/Indicator/UP_U1_RDR_AG_Contact.lua")

