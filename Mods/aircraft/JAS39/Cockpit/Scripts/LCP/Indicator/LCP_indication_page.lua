dofile(LockOn_Options.script_path.."MFD/Indicator/MFD_def.lua")

LCP_BASE 					= CreateElement "ceSimple"
LCP_BASE.init_pos			= {0,0}
LCP_BASE.name				= create_guid_string()
LCP_BASE.element_params 	= {"MAINPOWER"}
LCP_BASE.controllers    	= {{"parameter_compare_with_number",0, 1}}
AddElement(LCP_BASE)


GlowEffect 				= CreateElement "ceMeshPoly"
GlowEffect.name 			= create_guid_string()
GlowEffect.primitivetype 	= "triangles"
GlowEffect.vertices	   	= { {-1.0 , 1.0 }, { 1.0,1.0}, { 1.0,-1.0}, {-1.0,-1.0}, }
GlowEffect.indices			= {0, 1, 2, 0, 2, 3}
GlowEffect.init_pos		= {0, 0, 0}
GlowEffect.material		= MakeMaterial(nil,{0, 255, 0, 8})	--RGBA
GlowEffect.parent_element	= LCP_BASE.name
GlowEffect.h_clip_relation  = h_clip_relations.REWRITE_LEVEL
GlowEffect.level			= LCP_DEFAULT_LEVEL
--GlowEffect.change_opacity	= false
--GlowEffect.collimated 		= false
GlowEffect.isvisible		= true
GlowEffect.element_params    = {"LCP_BRIGHTNESS" }
GlowEffect.controllers       = {{"opacity_using_parameter", 0}}
Add(GlowEffect)

local AlignLeft = -0.75


add_text_with_opacity("INS FULL PERF OK", AlignLeft, 0.305,"LCP_BRIGHTNESS", LCP_BASE, "Gripen_Font_LCP", lcp_strdefs_digit, "LeftLeft")
add_text_with_opacity("INS ALIGNMENT", AlignLeft, 0.2,"LCP_BRIGHTNESS", LCP_BASE, "Gripen_Font_LCP", lcp_strdefs_digit, "LeftLeft")
add_text_with_opacity("INS ALIGN TIME: 0", AlignLeft, 0.095,"LCP_BRIGHTNESS", LCP_BASE, "Gripen_Font_LCP", lcp_strdefs_digit, "LeftLeft")
add_text_with_opacity("INS EPE RATE  : 0", AlignLeft, -0.01,"LCP_BRIGHTNESS", LCP_BASE, "Gripen_Font_LCP", lcp_strdefs_digit, "LeftLeft")
text_param_with_opacity(AlignLeft, -0.2, "LCP_BRIGHTNESS", "LCP_LAT", "%0.23s", LCP_BASE, lcp_strdefs_digit, "Gripen_Font_LCP", "LeftLeft")
text_param_with_opacity(AlignLeft, -0.305, "LCP_BRIGHTNESS", "LCP_LON", "%0.23s", LCP_BASE, lcp_strdefs_digit, "Gripen_Font_LCP", "LeftLeft")
