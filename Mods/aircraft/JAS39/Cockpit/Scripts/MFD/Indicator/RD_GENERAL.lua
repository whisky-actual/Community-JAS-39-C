TAN_RD_MASTER 					= CreateElement "ceSimple"
TAN_RD_MASTER.init_pos			= {0,0}
TAN_RD_MASTER.name				= create_guid_string()
TAN_RD_MASTER.element_params 	= {"EMGY_MODE", "MAINPOWER"}
TAN_RD_MASTER.controllers    	= {{"parameter_compare_with_number",0, 0}, {"parameter_compare_with_number", 1, 1}}
AddElement(TAN_RD_MASTER)


GRAY_Background 				= CreateElement "ceMeshPoly"
GRAY_Background.name 			= create_guid_string()
GRAY_Background.primitivetype 	= "triangles"
GRAY_Background.vertices	   	= { {-1.0 , 1.4 }, { 1.0,1.4}, { 1.0,-1.4}, {-1.0,-1.4}, }
GRAY_Background.indices			= {0, 1, 2, 0, 2, 3}
GRAY_Background.init_pos		= {0, 0, 0}
GRAY_Background.material		= MakeMaterial(nil,{69, 69, 70,255})	--RGBA
GRAY_Background.parent_element	= TAN_RD_MASTER.name
GRAY_Background.h_clip_relation = h_clip_relations.REWRITE_LEVEL
GRAY_Background.level			= MFD_DEFAULT_LEVEL
GRAY_Background.change_opacity	= false
GRAY_Background.collimated 		= false
GRAY_Background.isvisible		= true
GRAY_Background.element_params 	= {"LD_BRIGHTNESS"}
GRAY_Background.controllers    	= {{"opacity_using_parameter", 0}}
Add(GRAY_Background)

