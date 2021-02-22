dofile(LockOn_Options.script_path .. "MFCD/MFCDs_defs.lua")

MFCD_TEX_IND1    = "mfcd_tex_ind1"
MFCD_TEX_IND1_W  = "mfcd_tex_ind1_w"
MFCD_TEX_IND3    = "mfcd_tex_ind3"
MFCD_TEX_IND4    = "mfcd_tex_ind4"
MFCD_TEX_IND5    = "mfcd_tex_ind5"
MFCD_TEX_IND5_W  = "mfcd_tex_ind5_w"

TEX_SIZE_X = 2048
TEX_SIZE_Y = 2048


local hw      = 1.0
local verts   ={{-hw,  hw},
                { hw,  hw},
                { hw, -hw},
                {-hw, -hw}}

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
TV_RENDER.material        = "AKG_Material_"..tostring(GetRenderTarget())
TV_RENDER.level           = PAGE_LEVEL_POD
TV_RENDER.h_clip_relation = h_clip_relations.COMPARE
TV_RENDER.controllers     = {{'POD_link_check_video'},}
AddToUpper(TV_RENDER)

local osb_txt = {
    {value="DLPOD",   init_pos={MFCD_FONT_UD1_X, MFCD_FONT_U_Y},       align="CenterCenter",},
    {value="NAR",   init_pos={MFCD_FONT_UD2_X, MFCD_FONT_U_Y},       align="CenterCenter", ctrls={{"POD_link_narrow"},{"POD_link_check"},}}, --宽窄视场
    {value="AUTO",  init_pos={MFCD_FONT_UD3_X, MFCD_FONT_U_Y},       align="CenterCenter", ctrls={{"POD_link_autolock"},{"POD_link_check"},}}, --自动锁定/手工引导

    {value="MODE",  init_pos={MFCD_FONT_UD4_X,    MFCD_FONT_U_Y},    align="CenterCenter", ctrls={{"POD_link_mode"},{"POD_link_check"},}},
    {value="M1",    init_pos={MFCD_FONT_R_HORI_X, MFCD_FONT_LR1_Y},  align="RightCenter",  ctrls={{"POD_link_weaponIndex", 0},}},
    {value="M2",    init_pos={MFCD_FONT_R_HORI_X, MFCD_FONT_LR2_Y},  align="RightCenter",  ctrls={{"POD_link_weaponIndex", 1},}},

    {value="WPT",   init_pos={MFCD_FONT_L_HORI_X, (MFCD_FONT_LR1_Y+MFCD_FONT_LR2_Y)/2},    align="LeftCenter",   ctrls={{"POD_link_wpt"},{"POD_link_check_cruise"},}}, --wpt
    {value="CRUS",  init_pos={MFCD_FONT_L_HORI_X, MFCD_FONT_LR3_Y},  align="LeftCenter",   ctrls={{"POD_link_mim"},{"POD_link_check"},}}, --巡航/MIM
    
    {value="GAIN",  init_pos={MFCD_FONT_L_HORI_X, (MFCD_FONT_LR4_Y+MFCD_FONT_LR5_Y)/2},  align="LeftCenter",   ctrls={{"POD_mil_params", 1.0},{"POD_link_check"},}}, --gain
    {value="LEVEL", init_pos={MFCD_FONT_R_HORI_X, (MFCD_FONT_LR4_Y+MFCD_FONT_LR5_Y)/2},  align="RightCenter",  ctrls={{"POD_mil_params", 2.0},{"POD_link_check"},}}, --level
}


for i=1, #(osb_txt) do
    text_strpoly                    = CreateElement "ceStringPoly"
    text_strpoly.material           = MFCD_FONT_W
    text_strpoly.BackgroundMaterial = MakeMaterial(nil, MFCD_COLOR_BLACK)
    text_strpoly.stringdefs         = MFCD_STRINGDEFS_DEF
    text_strpoly.init_pos           = osb_txt[i].init_pos
    text_strpoly.alignment          = osb_txt[i].align

    if osb_txt[i].ctrls == nil then
        osb_txt[i].ctrls = {}
    end
    osb_txt[i].ctrls[#osb_txt[i].ctrls + 1] = {"string_background_color", 0,0,0}
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
    {value="state",         init_pos = {     0.0,            0.0}, align="CenterCenter", ctrls={{"POD_link_state_txt"},}, stringdefs = MFCD_STRINGDEFS_DEF,},
    {value="ll_coord",      init_pos = {-3.5*1.0/5, 2.0*0.80/2.5}, align="LeftCenter",   ctrls={{"POD_link_weapn_latlong"},{"POD_link_check"},},},
    {value="range",         init_pos = {-3.5*1.0/5, 1.5*0.80/2.5}, align="LeftCenter",   ctrls={{"POD_link_weapn_range_to_aimpoint"},{"POD_link_check"},},},
    {value="heading_range", init_pos = {-0*1.0/5,   2.0*0.80/2.5}, align="CenterCenter", ctrls={{"POD_link_weapn_heading"},{"POD_link_check"},}},
    {value="flight_time",   init_pos = { 1*1.0/5,   1.5*0.80/2.5}, align="LeftCenter",   ctrls={{"POD_link_weapn_flytime"},{"POD_link_check"},},},
    {value="no_video",      init_pos = {     0.0,            0.0}, align="CenterCenter", ctrls={{"POD_link_no_video_txt"},},},
}
for i=1, #(info_txt) do
    text_strpoly                = CreateElement "ceStringPoly"
    text_strpoly.material       = MFCD_FONT_W
    text_strpoly.stringdefs     = MFCD_STRINGDEFS_DEF
    text_strpoly.init_pos       = info_txt[i].init_pos
    text_strpoly.alignment      = info_txt[i].align

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

-- 
local tex_polys = {
    { -- gain +
        init_pos={MFCD_BOX3_L_VERT_X, MFCD_FONT_LR4_Y},
        vertices = {{113.333/2000, 113.333/2000}, {113.333/2000, -113.333/2000}, {-113.333/2000, -113.333/2000}, {-113.333/2000, 113.333/2000}},
        mat = MFCD_TEX_IND1, tex_coords = MFCD_tex_coord(1196, 1596, 68, 68, TEX_SIZE_X, TEX_SIZE_Y),
        ctrls = {{'POD_link_check_video'},},
    },
    { -- gain -
        init_pos={MFCD_BOX3_L_VERT_X, MFCD_FONT_LR5_Y},
        vertices = {{113.333/2000, 113.333/2000}, {113.333/2000, -113.333/2000}, {-113.333/2000, -113.333/2000}, {-113.333/2000, 113.333/2000}},
        mat = MFCD_TEX_IND1, tex_coords = MFCD_tex_coord(1196, 1664, 68, 68, TEX_SIZE_X, TEX_SIZE_Y),
        ctrls = {{'POD_link_check_video'},},
    },
    { -- level +
        init_pos={MFCD_BOX3_R_VERT_X, MFCD_FONT_LR4_Y},
        vertices = {{113.333/2000, 113.333/2000}, {113.333/2000, -113.333/2000}, {-113.333/2000, -113.333/2000}, {-113.333/2000, 113.333/2000}},
        mat = MFCD_TEX_IND1, tex_coords = MFCD_tex_coord(1196, 1596, 68, 68, TEX_SIZE_X, TEX_SIZE_Y),
        ctrls = {{'POD_link_check_video'},},
    },
    { -- level -
        init_pos={MFCD_BOX3_R_VERT_X, MFCD_FONT_LR5_Y},
        vertices = {{113.333/2000, 113.333/2000}, {113.333/2000, -113.333/2000}, {-113.333/2000, -113.333/2000}, {-113.333/2000, 113.333/2000}},
        mat = MFCD_TEX_IND1, tex_coords = MFCD_tex_coord(1196, 1664, 68, 68, TEX_SIZE_X, TEX_SIZE_Y),
        ctrls = {{'POD_link_check_video'},},
    },

    { -- 上一航路点
        init_pos={MFCD_BOX3_L_VERT_X, MFCD_FONT_LR1_Y},
        vertices = {{113.333/2000, 113.333/2000}, {113.333/2000, -113.333/2000}, {-113.333/2000, -113.333/2000}, {-113.333/2000, 113.333/2000}},
        mat = MFCD_TEX_IND1, tex_coords = MFCD_tex_coord(1196, 1596, 68, 68, TEX_SIZE_X, TEX_SIZE_Y),
        ctrls = {{'POD_link_check_cruise'},},
    },
    { -- 下一航路点
        init_pos={MFCD_BOX3_L_VERT_X, MFCD_FONT_LR2_Y},
        vertices = {{113.333/2000, 113.333/2000}, {113.333/2000, -113.333/2000}, {-113.333/2000, -113.333/2000}, {-113.333/2000, 113.333/2000}},
        mat = MFCD_TEX_IND1, tex_coords = MFCD_tex_coord(1196, 1664, 68, 68, TEX_SIZE_X, TEX_SIZE_Y),
        ctrls = {{'POD_link_check_cruise'},},
    },
    
    {
        init_pos={0, 0, 0}, vertices = {{0.05, 0.05}, {0.05, -0.05}, {-0.05, -0.05}, {-0.05, 0.05}},
        --mat = MFCD_TEX_IND1_W, tex_coords = MFCD_tex_coord(1016, 288, 8, 8, TEX_SIZE_X, TEX_SIZE_Y),
        mat = MFCD_TEX_IND5_W, tex_coords = MFCD_tex_coord( 279,  1094, 100, 100, TEX_SIZE_X, TEX_SIZE_Y),
        ctrls = {{"linkpod_cmd_ppos"}, {"POD_link_check_video"},},
    }, -- 指令位置
    
    { -- 大十字中间空
        init_pos={0, 0},
        vertices = {{1200/2000, 1200/2000}, {1200/2000, -1200/2000}, {-1200/2000, -1200/2000}, {-1200/2000, 1200/2000}},
        mat = MFCD_TEX_IND5_W, tex_coords = MFCD_tex_coord( 661,  852, 719, 719, TEX_SIZE_X, TEX_SIZE_Y),
        ctrls = {{'POD_link_check_video'},},
    },
    { -- 小矩形框
        init_pos={0, 0},
        vertices = {{663.333/2000, 663.333/2000}, {663.333/2000, -663.333/2000}, {-663.333/2000, -663.333/2000}, {-663.333/2000, 663.333/2000}},
        mat = MFCD_TEX_IND5_W, tex_coords = MFCD_tex_coord(1242,  453, 398, 398, TEX_SIZE_X, TEX_SIZE_Y),
        ctrls = {{'POD_link_check_narrow'}, {'POD_link_check_video'},},
    },
    
    --[[
    { -- 小十字中间带点
        init_pos={0, 0},
        vertices = {{426/2000, 426/2000}, {426/2000, -426/2000}, {-426/2000, -426/2000}, {-426/2000, 426/2000}},
        mat = MFCD_TEX_IND5_W, tex_coords = MFCD_tex_coord( 893,  176, 256, 256, TEX_SIZE_X, TEX_SIZE_Y),
        ctrls = {{'POD_link_check_video'},},
        
    },
    ]]
    --[[
    { -- 大长方形框
        init_pos={0, 0},
        vertices = {{1200/2000, 663.333/2000}, {1200/2000, -663.333/2000}, {-1200/2000, -663.333/2000}, {-1200/2000, 663.333/2000}},
        mat = MFCD_TEX_IND5_W, tex_coords = MFCD_tex_coord(1242,   55, 720, 398, TEX_SIZE_X, TEX_SIZE_Y),
        ctrls = {{'POD_link_check_video'},},
    },
    ]]
}

local tex_poly
for i=1, #(tex_polys) do
    tex_poly             = CreateElement "ceTexPoly"
    tex_poly.material    = MFCD_TEX_IND5
    if tex_polys[i].mat ~= nil then
        tex_poly.material = tex_polys[i].mat
    end
    tex_poly.indices     = DEF_BOX_INDICES
    tex_poly.vertices    = tex_polys[i].vertices
    tex_poly.tex_coords  = tex_polys[i].tex_coords
    tex_poly.init_pos    = {0, 0, 0}

    if tex_polys[i].init_pos ~= nil then
        tex_poly.init_pos = tex_polys[i].init_pos
    end
    
    if tex_polys[i].ctrls ~= nil then
        tex_poly.controllers = tex_polys[i].ctrls
    end

    AddToUpper(tex_poly)
    tex_poly = nil
end

