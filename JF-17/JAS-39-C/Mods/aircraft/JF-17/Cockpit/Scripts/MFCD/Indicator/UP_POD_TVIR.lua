dofile(LockOn_Options.script_path .. "MFCD/MFCDs_defs.lua")

local page_root = create_page_root()

MFCD_TEX_IND3   = "mfcd_tex_ind3"
MFCD_TEX_IND4   = "mfcd_tex_ind4"
MFCD_TEX_IND5   = "mfcd_tex_ind5"
MFCD_TEX_IND5_W = "mfcd_tex_ind5_w"

TEX_SIZE_X = 2048
TEX_SIZE_Y = 2048

local MAX_CONTACTS = 40
local MAX_HISTORY  = 1

local hw     = 1.0
local verts  = {{-hw,  hw},
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
TV_RENDER.material        = "TVIR_Material_" .. tostring(GetRenderTarget())
TV_RENDER.level           = PAGE_LEVEL_POD
TV_RENDER.h_clip_relation = h_clip_relations.COMPARE
TV_RENDER.controllers     = {{'POD_TVIR_video_check'},}
TV_RENDER.isdraw          = true
TV_RENDER.isvisible       = true
AddToUpper(TV_RENDER)

---- OSBs
local osb_txt = {
    {
        name='TVIR_TVIR',  value='TVIR',
        init_pos={MFCD_FONT_UD1_X, MFCD_FONT_U_Y}, align = 'CenterCenter', 
        --ctrls={{'TVIR_SEEKER_tvir',},},
    },
    {
        name='TVIR_ONOFF', value='ON',
        init_pos={MFCD_FONT_UD2_X, MFCD_FONT_U_Y}, align = 'CenterCenter', 
        ctrls={{'TVIR_SEEKER_onoff',},},
    },
    {
        name='TVIR_MODE',  value='MODE',
        init_pos={(MFCD_FONT_UD2_X + MFCD_FONT_UD3_X)/2, MFCD_FONT_U_Y}, align = 'CenterCenter', 
        ctrls={{'TVIR_SEEKER_mode',},},
    },
    {
        name='TVIR_SP',    value='SP',
        init_pos={MFCD_FONT_UD3_X, MFCD_FONT_U_Y}, align = 'CenterCenter', 
        ctrls={{'TVIR_SEEKER_snowplow',},},
    },
    {
        name='TVIR_FOV',   value='WIDE',
        init_pos={MFCD_FONT_UD4_X, MFCD_FONT_U_Y}, align = 'CenterCenter', 
        ctrls={{'TVIR_SEEKER_widenarrow',},},
    },
    {
        name='TVIR_AUTO',  value='AUTO',
        init_pos={MFCD_FONT_UD5_X, MFCD_FONT_U_Y}, align = 'CenterCenter', 
        ctrls={{'TVIR_SEEKER_autolock',},},
    },
    {
        name='TVIR_SIZE',  value="BHOT",
        init_pos={ MFCD_FONT_R_HORI_X, MFCD_FONT_LR1_Y}, align = "RightCenter", 
        ctrls={{'TVIR_SEEKER_invert',},},
    },
    {
        name='TVIR_SIZE',  value="5 M",
        init_pos={ MFCD_FONT_R_HORI_X, MFCD_FONT_LR5_Y}, align = "RightCenter", 
        ctrls={{'TVIR_SEEKER_size',},},
    },
    
    {
        name='TVIR_GAIN',  value="0",
        init_pos={MFCD_FONT_L_HORI_X, (MFCD_FONT_LR1_Y + MFCD_FONT_LR2_Y)/2}, align = "LeftCenter",
        ctrls={{'TVIR_SEEKER_params', 1.0},},
    },
    {
        name='TVIR_LEVEL', value="0",
        init_pos={MFCD_FONT_L_HORI_X, (MFCD_FONT_LR3_Y + MFCD_FONT_LR4_Y)/2}, align = "LeftCenter",
        ctrls={{'TVIR_SEEKER_params', 2.0},},
    },
    {
        name='TVIR_REFCOS', value="RE\nFOCUS",
        init_pos={MFCD_FONT_L_HORI_X, MFCD_FONT_LR5_Y}, align = "LeftCenter",
        ctrls={{'TVIR_SEEKER_check_focusing'},},
    },
    --{value="RES",    init_pos={ MFCD_FONT_R_HORI_X, MFCD_FONT_LR1_Y}, align = "RightCenter", ctrls={},},
    --{value="GAIN",   init_pos={ MFCD_FONT_R_HORI_X, MFCD_FONT_LR2_Y}, align = "RightCenter", ctrls={},},
    --{value="LEVEL",  init_pos={ MFCD_FONT_R_HORI_X, MFCD_FONT_LR3_Y}, align = "RightCenter", ctrls={},},
    --{value="FOCUS",  init_pos={ MFCD_FONT_R_HORI_X, MFCD_FONT_LR4_Y}, align = "RightCenter", ctrls={},},
}

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
    osb_txt[i].ctrls[#osb_txt[i].ctrls + 1] = {'string_background_color', 0, 0, 0}
    text_strpoly.controllers = osb_txt[i].ctrls
    
    if osb_txt[i].value ~= nil then
        text_strpoly.value = osb_txt[i].value
    else
        text_strpoly.value = 'TVIR_OSB_' .. i
    end
    AddToUpper(text_strpoly)
    text_strpoly = nil
end
----

local MFCD_TEX_IND1  = "mfcd_tex_ind1"
local MFCD_TEX_IND1_SIZE_X = 2048
local MFCD_TEX_IND1_SIZE_Y = 2048

local gate_w = 0.1

local texs = {
    { -- gain +
        mat = MFCD_TEX_IND1,
        init_pos={MFCD_BOX3_L_VERT_X, MFCD_FONT_LR1_Y},
        vertices = {{113.333/2000, 113.333/2000}, {113.333/2000, -113.333/2000}, {-113.333/2000, -113.333/2000}, {-113.333/2000, 113.333/2000}},
        tex_coords = MFCD_tex_coord(1196, 1596, 68, 68, MFCD_TEX_IND1_SIZE_X, MFCD_TEX_IND1_SIZE_Y),
        ctrls = {{'POD_TVIR_video_check'},},
    },
    { -- gain -
        mat = MFCD_TEX_IND1,
        init_pos={MFCD_BOX3_L_VERT_X, MFCD_FONT_LR2_Y},
        vertices = {{113.333/2000, 113.333/2000}, {113.333/2000, -113.333/2000}, {-113.333/2000, -113.333/2000}, {-113.333/2000, 113.333/2000}},
        tex_coords = MFCD_tex_coord(1196, 1664, 68, 68, MFCD_TEX_IND1_SIZE_X, MFCD_TEX_IND1_SIZE_Y),
        ctrls = {{'POD_TVIR_video_check'},},
    },
    { -- level +
        mat = MFCD_TEX_IND1,
        init_pos={MFCD_BOX3_L_VERT_X, MFCD_FONT_LR3_Y},
        vertices = {{113.333/2000, 113.333/2000}, {113.333/2000, -113.333/2000}, {-113.333/2000, -113.333/2000}, {-113.333/2000, 113.333/2000}},
        tex_coords = MFCD_tex_coord(1196, 1596, 68, 68, MFCD_TEX_IND1_SIZE_X, MFCD_TEX_IND1_SIZE_Y),
        ctrls = {{'POD_TVIR_video_check'},},
    },
    { -- level -
        mat = MFCD_TEX_IND1,
        init_pos={MFCD_BOX3_L_VERT_X, MFCD_FONT_LR4_Y},
        vertices = {{113.333/2000, 113.333/2000}, {113.333/2000, -113.333/2000}, {-113.333/2000, -113.333/2000}, {-113.333/2000, 113.333/2000}},
        tex_coords = MFCD_tex_coord(1196, 1664, 68, 68, MFCD_TEX_IND1_SIZE_X, MFCD_TEX_IND1_SIZE_Y),
        ctrls = {{'POD_TVIR_video_check'},},
    },
    
    {-- el指示
        cx = -741/1000, cy = 0, hw = 91/2000, hh = 91/2000, ulx = 893, uly = 79, w = 55, h = 55,
        mat = MFCD_TEX_IND5_W, tex_sx = TEX_SIZE_X, tex_sy = TEX_SIZE_Y,
        ctrls = {{"TVIR_SEEKER_azel", 1, 0.35},}, isdraw = false,
    },
    {-- el刻度
        cx = -817/1000, cy = 0, hw = 131/2000, hh = 713/2000, ulx = 814, uly = 79, w = 79, h = 428,
        mat = MFCD_TEX_IND5_W, tex_sx = TEX_SIZE_X, tex_sy = TEX_SIZE_Y,
    },
    
    {-- az指示
        cx = 0, cy = -681/1000, hw = 91/2000, hh = 91/2000, ulx = 1242, uly = 0, w = 55, h = 55,
        mat = MFCD_TEX_IND5_W, tex_sx = TEX_SIZE_X, tex_sy = TEX_SIZE_Y,
        ctrls = {{"TVIR_SEEKER_azel", 2, 0.35},}, isdraw = false,
    },
    {-- az刻度
        cx = 0, cy = -757/1000, hw = 713/2000, hh = 131/2000, ulx = 814, uly = 0, w = 428, h = 79,
        mat = MFCD_TEX_IND5_W, tex_sx = TEX_SIZE_X, tex_sy = TEX_SIZE_Y,
    },
    
    {-- 大框
        cx = 0, cy = 0, hw = 1356/2000, hh = 1356/2000, ulx = 0, uly = 0, w = 814, h = 814,
        mat = MFCD_TEX_IND5_W, tex_sx = TEX_SIZE_X, tex_sy = TEX_SIZE_Y,
        ctrls = {{'TVIR_SEEKER_wideshow', 1.0},},
    },
    {-- 十字
        cx = 0, cy = 0, hw = 1100/2000, hh = 1100/2000, ulx = 0, uly = 814, w = 660, h = 660,
        mat = MFCD_TEX_IND5_W, tex_sx = TEX_SIZE_X, tex_sy = TEX_SIZE_Y,
        ctrls = {{'TVIR_SEEKER_checklock'},},
    },
    
    {-- 左测距线
        cx = 0, cy = 0, hw = (1056 - 1047)/1000, hh = (161 - 92)/1000, ulx = 1047, uly = 92, w = 1056 - 1047, h = 161 - 92,
        mat = MFCD_TEX_IND5_W, tex_sx = TEX_SIZE_X, tex_sy = TEX_SIZE_Y,
        ctrls = {{'TVIR_SEEKER_checksize', -1.0}, {'TVIR_SEEKER_wideshow', 0},},
    },
    {-- 右测距线
        cx = 0, cy = 0, hw = (1056 - 1047)/1000, hh = (161 - 92)/1000, ulx = 1047, uly = 92, w = 1056 - 1047, h = 161 - 92,
        mat = MFCD_TEX_IND5_W, tex_sx = TEX_SIZE_X, tex_sy = TEX_SIZE_Y,
        ctrls = {{'TVIR_SEEKER_checksize',  1.0}, {'TVIR_SEEKER_wideshow', 0},},
    },
    
}

for i=1, #(texs) do
    tex_poly             = CreateElement "ceTexPoly"
    tex_poly.indices     = DEF_BOX_INDICES
    tex_poly.isdraw         = true
    tex_poly.use_mipfilter  = true
    tex_poly.additive_alpha = false
    
    if texs[i].mat then
        tex_poly.material = texs[i].mat
    else
        tex_poly.material = MFCD_TEX_IND1
    end
    
    if texs[i].init_pos ~= nil then
        tex_poly.init_pos = texs[i].init_pos
    else
        tex_poly.init_pos = {texs[i].cx, texs[i].cy, 0}
    end
    
    if texs[i].tex_coords ~= nil then
        tex_poly.tex_coords = texs[i].tex_coords
    else
        tex_poly.tex_coords = MFCD_tex_coord(texs[i].ulx, texs[i].uly, texs[i].w, texs[i].h, texs[i].tex_sx, texs[i].tex_sy)
    end
    
    if texs[i].vertices ~= nil then
        tex_poly.vertices = texs[i].vertices
    else
        tex_poly.vertices = {{ texs[i].hw, texs[i].hh},
                            { texs[i].hw,-texs[i].hh},
                            {-texs[i].hw,-texs[i].hh},
                            {-texs[i].hw, texs[i].hh} }
    end

    if texs[i].params then
        tex_poly.element_params = texs[i].params
    end
    if texs[i].ctrls then
        tex_poly.controllers = texs[i].ctrls
    end
    if texs[i].isdraw then
        tex_poly.isdraw = texs[i].isdraw
    end

    AddToUpper(tex_poly)
end


---- contacts
hh = 148/2000
for c =0, (MAX_CONTACTS-1) do
    for h =0, (MAX_HISTORY-1) do
        -- 目标模板
        tex_poly              = CreateElement "ceTexPoly"
        tex_poly.init_pos     = {0, 0, 0}
        tex_poly.name         = 'TVIR_SEEKER_contact_' .. c .. '_' ..h
        tex_poly.vertices     = { {hh, hh}, {hh,-hh}, {-hh,-hh}, {-hh,hh}, }
        tex_poly.indices      = DEF_BOX_INDICES
        --
        tex_poly.material     = MFCD_TEX_IND5_W
        tex_poly.tex_coords   = MFCD_tex_coord(948, 79, 89, 89, TEX_SIZE_X, TEX_SIZE_Y)
                            
        tex_poly.controllers    = {{'TVIR_SEEKER_update_contact', c, h, hw},}
        tex_poly.isdraw         = false
        tex_poly.use_mipfilter  = true
        tex_poly.additive_alpha = false
        AddToUpper(tex_poly)
        
        tex_poly = nil
    end
end
