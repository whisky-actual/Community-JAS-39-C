dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.common_script_path.."ViewportHandling.lua")

indicator_type = indicator_types.COLLIMATOR
purposes = {render_purpose.GENERAL,render_purpose.HUD_ONLY_VIEW}

BASE = 1

page_subsets = {
    [BASE]      = LockOn_Options.script_path.."ADI/Indicator/base_page.lua",
}

pages = {
    { BASE, },
}

init_pageID = 1

update_screenspace_diplacement(SelfWidth/SelfHeight,false)

dedicated_viewport_arcade = dedicated_viewport