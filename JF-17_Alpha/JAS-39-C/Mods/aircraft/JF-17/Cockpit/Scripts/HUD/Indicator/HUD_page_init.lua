dofile(LockOn_Options.common_script_path .. "devices_defs.lua")
dofile(LockOn_Options.script_path .. "materials.lua")

indicator_type = indicator_types.COLLIMATOR
purposes       = {render_purpose.GENERAL, render_purpose.HUD_ONLY_VIEW}

-- debugGUI = true

-- 子页面 id
HUD_PAGE_BASE       = 0
HUD_PAGE_OFF        = 1
HUD_PAGE_NORMAL     = 2
HUD_PAGE_GRID       = 3

page_subsets  = {
  [HUD_PAGE_BASE]        = LockOn_Options.script_path .. "HUD/Indicator/HUD_BASE.lua",    -- 底层页面
  [HUD_PAGE_OFF]         = LockOn_Options.script_path .. "HUD/Indicator/HUD_OFF.lua",     -- 关机页面
  [HUD_PAGE_NORMAL]      = LockOn_Options.script_path .. "HUD/Indicator/HUD_NORMAL.lua", -- 正常条件显示内容
  [HUD_PAGE_GRID]        = LockOn_Options.script_path .. "HUD/Indicator/HUD_GRID.lua",    -- 备用模式
}

-- 页面
HUD_PAGESET_OFF    = 0
HUD_PAGESET_NORMAL = 1
HUD_PAGESET_GRID   = 2
HUD_PAGESET_TEST   = 3 -- to be removed

pages = {
    [HUD_PAGESET_OFF]    = { HUD_PAGE_BASE, HUD_PAGE_OFF },        -- 关机模式 页面集
    [HUD_PAGESET_NORMAL] = { HUD_PAGE_BASE, HUD_PAGE_NORMAL, },    -- 正常模式 页面集
    [HUD_PAGESET_GRID]   = { HUD_PAGE_BASE, HUD_PAGE_GRID },       -- 备用模式 页面集
    [HUD_PAGESET_TEST]   = { HUD_PAGE_GENERAL },                   -- 单页测试
}

init_pageID = HUD_PAGESET_NORMAL

mat_tbl = {
    "hud_tex_ind1",
    "hud_tex_ind2",
    
    "hud_mesh_def",
    "hud_mesh_base1",
    "hud_mesh_base2",
    
    "hud_tex_clip",
    "hud_line_dashed_def",
    
    "hud_font_def",
    "hud_font_g",
    "hud_font_b",
    "hud_font_w",
    "hud_font_r",
}

brightness_sensitive_materials = mat_tbl
opacity_sensitive_materials    = mat_tbl
color_sensitive_materials      = mat_tbl

is_colored   = true
day_color    = {0, 1.0, 0.1}
night_color  = {0, 0.1, 0.01}
