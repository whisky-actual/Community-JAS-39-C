TAN_RD_MASTER 					= CreateElement "ceSimple"
TAN_RD_MASTER.init_pos			= {0,0}
TAN_RD_MASTER.name				= create_guid_string()
TAN_RD_MASTER.element_params 	= {"pruttRD_EMGY_MODE", "MAINPOWER"}
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
GRAY_Background.element_params 	= {"RD_BRIGHTNESS"}
GRAY_Background.controllers    	= {{"opacity_using_parameter", 0}}
Add(GRAY_Background)


StaticRD					= create_mfd_tex(RMFD_BACKGRUND, 0, 0, 1550, 2048,1.4)
StaticRD.name				= create_guid_string()
StaticRD.init_pos			= {0.0365,0}
StaticRD.parent_element		= TAN_RD_MASTER.name
StaticRD.element_params		= {"RD_BRIGHTNESS"}
StaticRD.controllers		= {JAS_Bright[1],JAS_Bright[2],JAS_Bright[3],JAS_Bright[4],JAS_Bright[5],JAS_Bright[6],JAS_Bright[7],JAS_Bright[8],JAS_Bright[9],JAS_Bright[10],JAS_Bright[11],JAS_Bright[12],JAS_Bright[13],JAS_Bright[14],JAS_Bright[15], JAS_Bright[16],JAS_Bright[17],JAS_Bright[18],JAS_Bright[19],JAS_Bright[20]}
AddElement(StaticRD)

TAN_Background_Mask 					= CreateElement "ceMeshPoly"
TAN_Background_Mask.name 			= create_guid_string()
TAN_Background_Mask.primitivetype 	= "triangles"
TAN_Background_Mask.vertices	   		= { {-0.925 , 1.4 }, { 0.925,1.4}, { 0.925,-0.9}, {-0.925,-0.9}, }
TAN_Background_Mask.indices			= {0, 1, 2, 0, 2, 3}
TAN_Background_Mask.init_pos			= {0, 0, 0}
TAN_Background_Mask.material			= MakeMaterial(nil,{222, 203, 110,255})	--RGBA
TAN_Background_Mask.parent_element	= TAN_RD_MASTER.name
TAN_Background_Mask.h_clip_relation  = h_clip_relations.INCREASE_IF_LEVEL
TAN_Background_Mask.level			= MFD_DEFAULT_LEVEL
TAN_Background_Mask.isvisible		= false
AddElement2(TAN_Background_Mask)

HORIZON_LINE_base 					= CreateElement "ceSimple"
HORIZON_LINE_base.init_pos			= {0, 0.195}	
HORIZON_LINE_base.name				= create_guid_string()
--HORIZON_LINE_base.h_clip_relation	= h_clip_relations.DECREASE_IF_LEVEL 
--HORIZON_LINE_base.level				= MFD_DEFAULT_LEVEL + 1
HORIZON_LINE_base.parent_element	= TAN_RD_MASTER.name
HORIZON_LINE_base.element_params 	= {"RAW_RALT", "ADI_ROLL"}
HORIZON_LINE_base.controllers		= { {"parameter_in_range", 0, -1, 3001} , {"rotate_using_parameter" ,1, 1}}
AddElement3(HORIZON_LINE_base)

local HORIZON_LINE			= create_mfd_tex(CENTER_DISPLAY_COLOR, 4, 1664, 1815 , 1668, 2) 
HORIZON_LINE.name			= create_guid_string()
HORIZON_LINE.init_pos		= {0, 0}
HORIZON_LINE.parent_element	= HORIZON_LINE_base.name
HORIZON_LINE.h_clip_relation  = h_clip_relations.DECREASE_IF_LEVEL  
HORIZON_LINE.level			= MFD_DEFAULT_LEVEL + 1
HORIZON_LINE.element_params 	= {"RD_BRIGHTNESS"}
HORIZON_LINE.controllers		= { JAS_Bright[1],JAS_Bright[2],JAS_Bright[3],JAS_Bright[4],JAS_Bright[5],JAS_Bright[6],JAS_Bright[7],JAS_Bright[8],JAS_Bright[9],JAS_Bright[10],JAS_Bright[11],JAS_Bright[12],JAS_Bright[13],JAS_Bright[14],JAS_Bright[15], JAS_Bright[16],JAS_Bright[17],JAS_Bright[18],JAS_Bright[19],JAS_Bright[20]}
AddElement2(HORIZON_LINE)


local HORIZON_ALT_A			= create_mfd_tex(CENTER_DISPLAY_COLOR, 1512, 1887, 1571 , 1960, 1) 
HORIZON_ALT_A.name			= create_guid_string()
HORIZON_ALT_A.init_pos		= {0.30, 0.039}
HORIZON_ALT_A.parent_element	= HORIZON_LINE.name
HORIZON_ALT_A.h_clip_relation  = h_clip_relations.DECREASE_IF_LEVEL  
HORIZON_ALT_A.level			= MFD_DEFAULT_LEVEL + 1
HORIZON_ALT_A.element_params 	= {"RD_BRIGHTNESS"}
HORIZON_ALT_A.controllers		= { JAS_Bright[1],JAS_Bright[2],JAS_Bright[3],JAS_Bright[4],JAS_Bright[5],JAS_Bright[6],JAS_Bright[7],JAS_Bright[8],JAS_Bright[9],JAS_Bright[10],JAS_Bright[11],JAS_Bright[12],JAS_Bright[13],JAS_Bright[14],JAS_Bright[15], JAS_Bright[16],JAS_Bright[17],JAS_Bright[18],JAS_Bright[19],JAS_Bright[20]}
AddElement2(HORIZON_ALT_A)

								
green_text_param_with_rd_brightness(0.14, 0 , "RAW_RALT", "%0.0f", HORIZON_ALT_A, {0.007,0.007, 0, 0}, "Gripen_Font_HL_Green")


local HORIZON_LINE_FPM			= create_mfd_tex(CENTER_DISPLAY_COLOR, 1504, 1717, 1709 , 1818, 2) 
HORIZON_LINE_FPM.name			= create_guid_string()
HORIZON_LINE_FPM.init_pos		= {0, 0.043}
HORIZON_LINE_FPM.parent_element	= HORIZON_LINE.name
HORIZON_LINE_FPM.element_params  = {"RD_BRIGHTNESS", "ADI_ROLL","VELVEC_HUD_Y","VELVEC_HUD_X","ADI_PITCH"}
HORIZON_LINE_FPM.controllers	 = {JAS_Bright[1],JAS_Bright[2],JAS_Bright[3],JAS_Bright[4],JAS_Bright[5],JAS_Bright[6],JAS_Bright[7],JAS_Bright[8],JAS_Bright[9],JAS_Bright[10],JAS_Bright[11],JAS_Bright[12],JAS_Bright[13],JAS_Bright[14],JAS_Bright[15], JAS_Bright[16],JAS_Bright[17],JAS_Bright[18],JAS_Bright[19],JAS_Bright[20], 
									{"rotate_using_parameter" ,1, -1},{"move_up_down_using_parameter",2, 0.036}, {"move_left_right_using_parameter",3, 0.036},{"move_up_down_using_parameter",4, -0.036} }
AddElement(HORIZON_LINE_FPM)

local GROUNDCOLLISION			= create_mfd_tex(CENTER_DISPLAY_COLOR, 1380, 145, 1680 , 298, 1.5) 
GROUNDCOLLISION.name			= create_guid_string()
GROUNDCOLLISION.init_pos		= {0, 0.023}
GROUNDCOLLISION.parent_element	= HORIZON_LINE_FPM.name
GROUNDCOLLISION.element_params  = {"RD_BRIGHTNESS","PULLUPQUE", "ROLL_HUD", "VELVEC_HUD_Y","CURRENT_PHASE_STATIONARY","CURRENT_PHASE_PARKED","CURRENT_PHASE_TAXI",
												"CURRENT_PHASE_TGR","CURRENT_PHASE_ROT","CURRENT_PHASE_TD","CURRENT_PHASE_LR","CURRENT_PHASE_PAL", "PULLMORE"}
GROUNDCOLLISION.controllers	 	= { JAS_Bright[1],JAS_Bright[2],JAS_Bright[3],JAS_Bright[4],JAS_Bright[5],JAS_Bright[6],JAS_Bright[7],JAS_Bright[8],JAS_Bright[9],JAS_Bright[10],JAS_Bright[11],JAS_Bright[12],JAS_Bright[13],JAS_Bright[14],JAS_Bright[15], JAS_Bright[16],JAS_Bright[17],JAS_Bright[18],JAS_Bright[19],JAS_Bright[20],
								  {"parameter_in_range",1, -10000,0},{"rotate_using_parameter" ,2, 1.00},
								  {"move_up_down_using_parameter",3, 0.1} ,{"parameter_compare_with_number",4, 0},{"parameter_compare_with_number",5, 0},
								  {"parameter_compare_with_number",6, 0},{"parameter_compare_with_number",7, 0},{"parameter_compare_with_number",8, 0},
								  {"parameter_compare_with_number",9, 0},{"parameter_compare_with_number",10, 0},{"parameter_compare_with_number",11, 0}, {"parameter_in_range",12, -0.99,0.5} }	
AddElement(GROUNDCOLLISION)





