dofile(LockOn_Options.script_path.."MFD/Indicator/MFD_def.lua")

UCP_BASE 					= CreateElement "ceSimple"
UCP_BASE.init_pos			= {0,0}
UCP_BASE.name				= create_guid_string()
UCP_BASE.element_params 	= {"MAINPOWER"}
UCP_BASE.controllers    	= {{"parameter_compare_with_number",0, 1}}
AddElement(UCP_BASE)

GlowEffect 				= CreateElement "ceMeshPoly"
GlowEffect.name 			= create_guid_string()
GlowEffect.primitivetype 	= "triangles"
GlowEffect.vertices	   	= { {-1.0 , 1.5 }, { 1.0,1.5}, { 1.0,-1.5}, {-1.0,-1.5}, }
GlowEffect.indices			= {0, 1, 2, 0, 2, 3}
GlowEffect.init_pos		= {0, 0, 0}
GlowEffect.material		= MakeMaterial(nil,{0, 255, 0, 3})	--RGBA
GlowEffect.parent_element	= UCP_BASE.name
GlowEffect.h_clip_relation  = h_clip_relations.REWRITE_LEVEL
GlowEffect.level			= UCP_DEFAULT_LEVEL
--GlowEffect.change_opacity	= false
--GlowEffect.collimated 		= false
GlowEffect.isvisible		= true
GlowEffect.element_params    = {"UCP_BRIGHTNESS" }
GlowEffect.controllers       = {{"opacity_using_parameter", 0}}
Add(GlowEffect)



local RowMargin = -0.5

for i = -5, -1 do
	local j = math.abs(i)

	text_param_with_opacity(-1, 1.35 - RowMargin * i, "UCP_BRIGHTNESS", "UCP_ROW"..j, "%0.23s", UCP_BASE, ucp_strdefs_digit, "Gripen_Font_UCP", "LeftLeft")

end
