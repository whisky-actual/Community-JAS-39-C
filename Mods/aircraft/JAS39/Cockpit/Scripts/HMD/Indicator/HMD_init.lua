dofile(LockOn_Options.common_script_path .. "ViewportHandling.lua") 
dofile(LockOn_Options.common_script_path .. "devices_defs.lua")



indicator_type = indicator_types.HELMET
purposes       = {render_purpose.GENERAL, render_purpose.HUD_ONLY_VIEW}


base = 1

page_subsets = {[base] = LockOn_Options.script_path .. "HMD/Indicator/HMD_Base_Page.lua"}
pages        = {{base}}


init_pageID = 1