dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.common_script_path.."ViewportHandling.lua") 

indicator_type = indicator_types.COMMON
purposes       = {render_purpose.GENERAL, render_purpose.MFD_ONLY_VIEW}

BASE    = 1 

page_subsets  = {
	[BASE]    		= LockOn_Options.script_path.."UCP/Indicator/UCP_base_page.lua",   
}
pages = {
	{ BASE, }, 
 
}

init_pageID = 1 




