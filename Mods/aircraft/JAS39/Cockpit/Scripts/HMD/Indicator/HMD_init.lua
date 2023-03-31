dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.common_script_path.."ViewportHandling.lua") 

indicator_type 	= indicator_types.HELMET	
purposes 	   	= {render_purpose.GENERAL} 

BASE    = 1 

page_subsets  = {
	[BASE]    		= LockOn_Options.script_path.."HMD/Indicator/HMD_base_page.lua",   
}
pages = {
	{ BASE, }, 
 
}

init_pageID = 1 




