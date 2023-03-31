

--[[
scale = 2
aspect = 0.9
local xcor = 0.022



EMGY_PAGE 			= CreateElement "ceSimple"
EMGY_PAGE.init_pos	= {0,0}
EMGY_PAGE.name		= create_guid_string()
EMGY_PAGE.element_params = {"RD_EMGY_MODE", "MAINPOWER"}
EMGY_PAGE.controllers    = {{"parameter_compare_with_number",0, 1}, {"parameter_compare_with_number", 1, 1}}
AddElement(EMGY_PAGE)		


local Light_Black_Background 			= CreateElement "ceMeshPoly"
Light_Black_Background.name 			= create_guid_string()
Light_Black_Background.primitivetype 	= "triangles"
Light_Black_Background.vertices	   		= { {-1.0 , 1.4 }, { 1.0,1.4}, { 1.0,-1.4}, {-1.0,-1.4}, }
Light_Black_Background.indices			= {0, 1, 2, 0, 2, 3}
Light_Black_Background.init_pos			= {0, 0, 0}
Light_Black_Background.material			= MakeMaterial(nil,{5, 5, 5,255})	--RGBA
Light_Black_Background.parent_element	= EMGY_PAGE.name
Light_Black_Background.h_clip_relation  = h_clip_relations.REWRITE_LEVEL
Light_Black_Background.level			= MFD_DEFAULT_LEVEL
Light_Black_Background.change_opacity	= false
Light_Black_Background.collimated 		= false
Light_Black_Background.isvisible		= true
Light_Black_Background.element_params 	= {"RD_BRIGHTNESS"}
Light_Black_Background.controllers    	= {{"opacity_using_parameter", 0}}
Add(Light_Black_Background)


--ADI ball
adi_background_mask 				= AddCircle(-0.01, 0.277, 0.47, 1, true)
adi_background_mask.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL  
adi_background_mask.level			= MFD_DEFAULT_LEVEL
adi_background_mask.material		= MakeMaterial(nil,{0, 0, 0,255})	--RGBA
adi_background_mask.isvisible		= false
adi_background_mask.parent_element	= EMGY_PAGE.name
AddElement2(adi_background_mask)


adi_background_mask2 				 = AddCircle(-0.01, 0.24, 0.47, 1, true)
adi_background_mask2.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL  
adi_background_mask2.level			 = MFD_DEFAULT_LEVEL
adi_background_mask2.material		= MakeMaterial(nil,{0, 0, 0,255})	--RGBA
adi_background_mask2.isvisible		 = false
adi_background_mask2.parent_element	 = EMGY_PAGE.name
AddElement2(adi_background_mask2)	

local ADI_BASE 				= CreateElement "ceSimple"		-- Ball background
ADI_BASE.init_pos			= {0, 0.195+0.06}
ADI_BASE.name				= create_guid_string()
ADI_BASE.h_clip_relation 	= h_clip_relations.DECREASE_IF_LEVEL  
ADI_BASE.level           	= MFD_DEFAULT_LEVEL + 1
ADI_BASE.parent_element	 	= EMGY_PAGE.name
ADI_BASE.element_params 	= {"ADI_ROLL",}
ADI_BASE.controllers		= {{"rotate_using_parameter" ,0, 1},}
AddElement2(ADI_BASE)	

local ADI_EMGY_BACKGROUND			= create_mfd_tex_3300(ADI_BACKGROUND_EMGY, 0, 0, 3072, 1920,1.4*1.611)
ADI_EMGY_BACKGROUND.name			= create_guid_string()
ADI_EMGY_BACKGROUND.init_pos		= {0.62, 0}
ADI_EMGY_BACKGROUND.parent_element	= ADI_BASE.name
ADI_EMGY_BACKGROUND.h_clip_relation = h_clip_relations.DECREASE_IF_LEVEL  
ADI_EMGY_BACKGROUND.level           = MFD_DEFAULT_LEVEL + 1
ADI_EMGY_BACKGROUND.element_params  = {"RD_BRIGHTNESS","ADI_ATTITUDE"}
ADI_EMGY_BACKGROUND.controllers		= {JAS_Bright[1],JAS_Bright[2],JAS_Bright[3],JAS_Bright[4],JAS_Bright[5],JAS_Bright[6],JAS_Bright[7],JAS_Bright[8],JAS_Bright[9],JAS_Bright[10],JAS_Bright[11],JAS_Bright[12],JAS_Bright[13],JAS_Bright[14],JAS_Bright[15], JAS_Bright[16],JAS_Bright[17],JAS_Bright[18],JAS_Bright[19],JAS_Bright[20],{"move_up_down_using_parameter",1, 0.036}}
AddElement2(ADI_EMGY_BACKGROUND)

local ADI_EMGY_FRAME			= create_mfd_tex(ADI_FRAME_EMGY, 10, 15, 1260, 1260,0.92)
ADI_EMGY_FRAME.name				= create_guid_string()
ADI_EMGY_FRAME.init_pos			= {0, 0.270}
ADI_EMGY_FRAME.parent_element	= EMGY_PAGE.name
ADI_EMGY_FRAME.element_params   = {"RD_BRIGHTNESS"}
ADI_EMGY_FRAME.controllers	 	= {JAS_Bright[1],JAS_Bright[2],JAS_Bright[3],JAS_Bright[4],JAS_Bright[5],JAS_Bright[6],JAS_Bright[7],JAS_Bright[8],JAS_Bright[9],JAS_Bright[10],JAS_Bright[11],JAS_Bright[12],JAS_Bright[13],JAS_Bright[14],JAS_Bright[15], JAS_Bright[16],JAS_Bright[17],JAS_Bright[18],JAS_Bright[19],JAS_Bright[20]}
AddElement(ADI_EMGY_FRAME)	

local ADI_EMGY_ATTITUDE				= create_mfd_tex(ADI_FRAME_EMGY, 1400, 905 , 1915, 985,0.92)
ADI_EMGY_ATTITUDE.name				= create_guid_string()
ADI_EMGY_ATTITUDE.init_pos			= {0, 0.23}
ADI_EMGY_ATTITUDE.parent_element	= EMGY_PAGE.name
ADI_EMGY_ATTITUDE.element_params    = {"RD_BRIGHTNESS"}
ADI_EMGY_ATTITUDE.controllers	    = {JAS_Bright[1],JAS_Bright[2],JAS_Bright[3],JAS_Bright[4],JAS_Bright[5],JAS_Bright[6],JAS_Bright[7],JAS_Bright[8],JAS_Bright[9],JAS_Bright[10],JAS_Bright[11],JAS_Bright[12],JAS_Bright[13],JAS_Bright[14],JAS_Bright[15], JAS_Bright[16],JAS_Bright[17],JAS_Bright[18],JAS_Bright[19],JAS_Bright[20]}
AddElement(ADI_EMGY_ATTITUDE)	

local ADI_EMGY_ROLL_MARKER				= create_mfd_tex(ADI_FRAME_EMGY, 1975, 0, 2038, 1143.27-110, 1.0 )
ADI_EMGY_ROLL_MARKER.name				= create_guid_string()
ADI_EMGY_ROLL_MARKER.init_pos			= {-0.0065, 0}
ADI_EMGY_ROLL_MARKER.parent_element		= ADI_EMGY_FRAME.name	
ADI_EMGY_ROLL_MARKER.element_params 	= {"RD_BRIGHTNESS","ADI_ROLL",}
ADI_EMGY_ROLL_MARKER.controllers		= {JAS_Bright[1],JAS_Bright[2],JAS_Bright[3],JAS_Bright[4],JAS_Bright[5],JAS_Bright[6],JAS_Bright[7],JAS_Bright[8],JAS_Bright[9],JAS_Bright[10],JAS_Bright[11],JAS_Bright[12],JAS_Bright[13],JAS_Bright[14],JAS_Bright[15], JAS_Bright[16],JAS_Bright[17],JAS_Bright[18],JAS_Bright[19],JAS_Bright[20],{"rotate_using_parameter" ,1, 1},}
AddElement(ADI_EMGY_ROLL_MARKER)
--****************** RPM Gauge
 
local rpm_indicator				= create_mfd_tex_3k(MFD_ELEMENTS_PDD_WHITE,275, 860, 1035, 1610)
rpm_indicator.name				= create_guid_string()
rpm_indicator.init_pos			= {-0.58, -0.8}
rpm_indicator.parent_element 	= EMGY_PAGE.name
rpm_indicator.element_params 	= {"RD_BRIGHTNESS","RD_ENG_TOGGLE"}
rpm_indicator.controllers		= {JAS_Bright[1],JAS_Bright[2],JAS_Bright[3],JAS_Bright[4],JAS_Bright[5],JAS_Bright[6],JAS_Bright[7],JAS_Bright[8],JAS_Bright[9],JAS_Bright[10],JAS_Bright[11],JAS_Bright[12],JAS_Bright[13],JAS_Bright[14],JAS_Bright[15], JAS_Bright[16],JAS_Bright[17],JAS_Bright[18],JAS_Bright[19],JAS_Bright[20], {"parameter_compare_with_number", 1, 1}}
AddElement(rpm_indicator)	

local rpm_needle 			= create_mfd_tex(MFD_ELEMENTS_D, 463, 824, 674, 855, 1.3, 473 )
rpm_needle.name				= create_guid_string()
rpm_needle.init_pos			= {0.053, -0.040}
rpm_needle.init_rot			= {-90, 0}
rpm_needle.element_params 	= {"RD_BRIGHTNESS", "RPM_NEEDLE"}
rpm_needle.controllers		= {JAS_Bright[1],JAS_Bright[2],JAS_Bright[3],JAS_Bright[4],JAS_Bright[5],JAS_Bright[6],JAS_Bright[7],JAS_Bright[8],JAS_Bright[9],JAS_Bright[10],JAS_Bright[11],JAS_Bright[12],JAS_Bright[13],JAS_Bright[14],JAS_Bright[15], JAS_Bright[16],JAS_Bright[17],JAS_Bright[18],JAS_Bright[19],JAS_Bright[20], {"rotate_using_parameter" ,1, -math.rad(300)/100},}
rpm_needle.parent_element	= rpm_indicator.name
AddElement(rpm_needle)


local Digital_rpm = white_text_param_with_brightness(0.16, -0.19, "RPM_PARAM_U", "%02.0f", rpm_indicator, mfd_strdefs_digit, "Gripen_Font_WHITE", "LeftCenter")

local Digital_rpm_100 = add_text_with_brightness("1", 0.12, -0.19, rpm_indicator , "Gripen_Font_WHITE", mfd_strdefs_digit, "LeftCenter")
Digital_rpm_100.element_params  = {"RPM_PARAM"}
Digital_rpm_100.controllers     = {{"parameter_in_range" ,0,0.9,1.1} }


-- Engine temp

local tgt_indicator				= create_mfd_tex_3k(MFD_ELEMENTS_PDD_WHITE,1075, 860, 2000, 1583)
tgt_indicator.name				= create_guid_string()
tgt_indicator.init_pos			= {0.15, -0.8}
tgt_indicator.parent_element 	= EMGY_PAGE.name
tgt_indicator.element_params 	= {"RD_BRIGHTNESS","RD_ENG_TOGGLE"}
tgt_indicator.controllers	 	= {JAS_Bright[1],JAS_Bright[2],JAS_Bright[3],JAS_Bright[4],JAS_Bright[5],JAS_Bright[6],JAS_Bright[7],JAS_Bright[8],JAS_Bright[9],JAS_Bright[10],JAS_Bright[11],JAS_Bright[12],JAS_Bright[13],JAS_Bright[14],JAS_Bright[15], JAS_Bright[16],JAS_Bright[17],JAS_Bright[18],JAS_Bright[19],JAS_Bright[20], {"parameter_compare_with_number", 1, 1}}
AddElement(tgt_indicator)	

local tgt_needle 			= create_mfd_tex(MFD_ELEMENTS_D, 463, 824, 674, 855, 1.3, 473 )
tgt_needle.name				= create_guid_string()
tgt_needle.init_pos			= {0.000, -0.048}
tgt_needle.init_rot			= {-90, 0}
tgt_needle.element_params 	= {"RD_BRIGHTNESS", "TGT_NEEDLE",}
tgt_needle.controllers		= { JAS_Bright[1],JAS_Bright[2],JAS_Bright[3],JAS_Bright[4],JAS_Bright[5],JAS_Bright[6],JAS_Bright[7],JAS_Bright[8],JAS_Bright[9],JAS_Bright[10],JAS_Bright[11],JAS_Bright[12],JAS_Bright[13],JAS_Bright[14],JAS_Bright[15], JAS_Bright[16],JAS_Bright[17],JAS_Bright[18],JAS_Bright[19],JAS_Bright[20],{"rotate_using_parameter" ,1, -math.rad(179/680)}}
tgt_needle.parent_element	= tgt_indicator.name
AddElement(tgt_needle)	

local Digital_TGT = white_text_param_with_brightness(0.09, -0.2, "TGT_PARAM", "%02.0f", tgt_indicator, mfd_strdefs_digit, "Gripen_Font_WHITE", "LeftCenter")

--white_text_param_with_brightness(-0.5, -0.2, "CUR_MACH", "%0.2f", EMGY_PAGE, mfd_strdefs_digit, "Gripen_Font_WHITE")
local Mach_text_EMGY = add_text_with_brightness("M", -0.72, -0.2, EMGY_PAGE, "Gripen_Font_WHITE" )


local Mach_indicator 				= CreateElement "ceStringPoly"
Mach_indicator.name 				= create_guid_string()
Mach_indicator.parent_element		= EMGY_PAGE.name
Mach_indicator.material				= fonts["Gripen_Font_WHITE"]
Mach_indicator.init_pos 			= {-0.5, -0.2}
Mach_indicator.alignment 			= "LeftCenter"
Mach_indicator.stringdefs 			= mfd_strdefs_digit
Mach_indicator.formats 				= {"%0.0f","%s"}
Mach_indicator.element_params 		= {"RD_BRIGHTNESS","MACH_B"}
Mach_indicator.controllers 			= {JAS_Bright[1],JAS_Bright[2],JAS_Bright[3],JAS_Bright[4],JAS_Bright[5],JAS_Bright[6],JAS_Bright[7],JAS_Bright[8],JAS_Bright[9],JAS_Bright[10],JAS_Bright[11],JAS_Bright[12],JAS_Bright[13],JAS_Bright[14],JAS_Bright[15], JAS_Bright[16],JAS_Bright[17],JAS_Bright[18],JAS_Bright[19],JAS_Bright[20],{"text_using_parameter",1,0},{"parameter_in_range" ,1, 3, 99.5}}
AddElement(Mach_indicator)

add_text_with_brightness(".", -0.011, 0, Mach_indicator, "Gripen_Font_WHITE",mfd_strdefs_digit )

local Mach_indicator2 				= CreateElement "ceStringPoly"
Mach_indicator2.name 				= create_guid_string()
Mach_indicator2.parent_element		= EMGY_PAGE.name
Mach_indicator2.material			= fonts["Gripen_Font_WHITE"]
Mach_indicator2.init_pos 			= {-0.568, -0.2}
Mach_indicator2.alignment 			= "LeftCenter"
Mach_indicator2.stringdefs 			= mfd_strdefs_digit
Mach_indicator2.formats 			= {"%0.2f","%s"}
Mach_indicator2.element_params 		= {"RD_BRIGHTNESS","MACH_A"}
Mach_indicator2.controllers 		= {JAS_Bright[1],JAS_Bright[2],JAS_Bright[3],JAS_Bright[4],JAS_Bright[5],JAS_Bright[6],JAS_Bright[7],JAS_Bright[8],JAS_Bright[9],JAS_Bright[10],JAS_Bright[11],JAS_Bright[12],JAS_Bright[13],JAS_Bright[14],JAS_Bright[15], JAS_Bright[16],JAS_Bright[17],JAS_Bright[18],JAS_Bright[19],JAS_Bright[20],{"text_using_parameter",1},{"parameter_in_range" ,1, 0.995, 3}}
AddElement(Mach_indicator2)






white_text_param_with_brightness(-0.5, 0.7, "CUR_AOA", "%0.0f", EMGY_PAGE, mfd_strdefs_digit, "Gripen_Font_WHITE")

local ALFA_SYMBOL_EMGY			 = create_mfd_tex(ADI_FRAME_EMGY, 1795, 435 , 1875, 510,0.80)
ALFA_SYMBOL_EMGY.name			 = create_guid_string()
ALFA_SYMBOL_EMGY.init_pos		 = {-0.72, 0.7}
ALFA_SYMBOL_EMGY.parent_element	 = EMGY_PAGE.name
ALFA_SYMBOL_EMGY.element_params  = {"RD_BRIGHTNESS"}
ALFA_SYMBOL_EMGY.controllers	 = {JAS_Bright[1],JAS_Bright[2],JAS_Bright[3],JAS_Bright[4],JAS_Bright[5],JAS_Bright[6],JAS_Bright[7],JAS_Bright[8],JAS_Bright[9],JAS_Bright[10],JAS_Bright[11],JAS_Bright[12],JAS_Bright[13],JAS_Bright[14],JAS_Bright[15], JAS_Bright[16],JAS_Bright[17],JAS_Bright[18],JAS_Bright[19],JAS_Bright[20]}
AddElement(ALFA_SYMBOL_EMGY)

local FuelSquare			= create_mfd_tex(ADI_FRAME_EMGY, 1400, 12 , 1775, 380,0.82)
FuelSquare.name				= create_guid_string()
FuelSquare.init_pos			= {0.75, 1.20}
FuelSquare.parent_element	= EMGY_PAGE.name
FuelSquare.element_params   = {"RD_BRIGHTNESS"}
FuelSquare.controllers	 	= {JAS_Bright[1],JAS_Bright[2],JAS_Bright[3],JAS_Bright[4],JAS_Bright[5],JAS_Bright[6],JAS_Bright[7],JAS_Bright[8],JAS_Bright[9],JAS_Bright[10],JAS_Bright[11],JAS_Bright[12],JAS_Bright[13],JAS_Bright[14],JAS_Bright[15], JAS_Bright[16],JAS_Bright[17],JAS_Bright[18],JAS_Bright[19],JAS_Bright[20]}
AddElement(FuelSquare)

FUEL_TXT = add_text_with_brightness("FUEL", 0.755, 1.275, EMGY_PAGE, "Gripen_Font_WHITE", mfd_strdefs_digit_f )
FUEL_TXT_D = white_text_param_with_brightness(-0.021,-0.15 , "FUEL", "%0.0f", FUEL_TXT, mfd_strdefs_digit_f, "Gripen_Font_WHITE")
add_text_with_brightness("%", 0.115,0, FUEL_TXT_D, "Gripen_Font_WHITE", mfd_strdefs_digit_b )

	
local AIRSPEED_EMGY_SCALE			= create_mfd_tex(ADI_FRAME_EMGY, 1870, 1070 , 1925, 1855,1)
AIRSPEED_EMGY_SCALE.name			= create_guid_string()
AIRSPEED_EMGY_SCALE.init_pos		= {-0.65, 0.25}
AIRSPEED_EMGY_SCALE.parent_element	= EMGY_PAGE.name
AIRSPEED_EMGY_SCALE.element_params  = {"RD_BRIGHTNESS"}
AIRSPEED_EMGY_SCALE.controllers	    = {JAS_Bright[1],JAS_Bright[2],JAS_Bright[3],JAS_Bright[4],JAS_Bright[5],JAS_Bright[6],JAS_Bright[7],JAS_Bright[8],JAS_Bright[9],JAS_Bright[10],JAS_Bright[11],JAS_Bright[12],JAS_Bright[13],JAS_Bright[14],JAS_Bright[15], JAS_Bright[16],JAS_Bright[17],JAS_Bright[18],JAS_Bright[19],JAS_Bright[20]}
AddElement(AIRSPEED_EMGY_SCALE)
 
local AIRSPEED_EMGY_ARROW			= create_mfd_tex(ADI_FRAME_EMGY, 1748, 1497 , 1807, 1555,1)
AIRSPEED_EMGY_ARROW.name			= create_guid_string()
AIRSPEED_EMGY_ARROW.init_pos		= {-0.657, -0.241}
AIRSPEED_EMGY_ARROW.parent_element	= EMGY_PAGE.name
AIRSPEED_EMGY_ARROW.element_params  = {"RD_BRIGHTNESS","EMGY_IAS"}
AIRSPEED_EMGY_ARROW.controllers	    = {JAS_Bright[1],JAS_Bright[2],JAS_Bright[3],JAS_Bright[4],JAS_Bright[5],JAS_Bright[6],JAS_Bright[7],JAS_Bright[8],JAS_Bright[9],JAS_Bright[10],JAS_Bright[11],JAS_Bright[12],JAS_Bright[13],JAS_Bright[14],JAS_Bright[15], JAS_Bright[16],JAS_Bright[17],JAS_Bright[18],JAS_Bright[19],JAS_Bright[20],{"move_up_down_using_parameter", 1, 0.0001079*1.1125}}
AddElement(AIRSPEED_EMGY_ARROW)

AIRSPEED_EMGY_READOUT = white_text_param_with_brightness(-0.15,0.0 , "CURR_IAS", "%0.0f", AIRSPEED_EMGY_ARROW, mfd_strdefs_digit, "Gripen_Font_WHITE") 


local HEADING_TAPE_EMGY_MASK				 = CreateElement "ceSimpleLineObject"
HEADING_TAPE_EMGY_MASK.name			 		 = create_guid_string()
HEADING_TAPE_EMGY_MASK.material				 = MakeMaterial(nil, {0,100,0, 255})
HEADING_TAPE_EMGY_MASK.width		 		 = 0.4
HEADING_TAPE_EMGY_MASK.vertices	 			 = {{0, 0.25}, {0,0}}
HEADING_TAPE_EMGY_MASK.init_pos       		 = {0, 1.12}
HEADING_TAPE_EMGY_MASK.h_clip_relation 		 = h_clip_relations.INCREASE_IF_LEVEL  
HEADING_TAPE_EMGY_MASK.level				 = MFD_DEFAULT_LEVEL  
HEADING_TAPE_EMGY_MASK.isvisible			 = false
HEADING_TAPE_EMGY_MASK.parent_element 		 = EMGY_PAGE.name
AddElement2(HEADING_TAPE_EMGY_MASK)

local HEADING_ARROW_EMGY			= create_mfd_tex(ADI_FRAME_EMGY, 1748, 1497 , 1807, 1555,1)
HEADING_ARROW_EMGY.name				= create_guid_string()
HEADING_ARROW_EMGY.init_pos			= {0, 1.115}
HEADING_ARROW_EMGY.init_rot			= {90, 0}
HEADING_ARROW_EMGY.parent_element	= EMGY_PAGE.name
HEADING_ARROW_EMGY.element_params   = {"RD_BRIGHTNESS"}
HEADING_ARROW_EMGY.controllers	    = {JAS_Bright[1],JAS_Bright[2],JAS_Bright[3],JAS_Bright[4],JAS_Bright[5],JAS_Bright[6],JAS_Bright[7],JAS_Bright[8],JAS_Bright[9],JAS_Bright[10],JAS_Bright[11],JAS_Bright[12],JAS_Bright[13],JAS_Bright[14],JAS_Bright[15], JAS_Bright[16],JAS_Bright[17],JAS_Bright[18],JAS_Bright[19],JAS_Bright[20]}
AddElement(HEADING_ARROW_EMGY)

local HEADING_TAPE_EMGY				= create_mfd_tex_3300(EMGY_HEADING_WHITE, 0, 37, 3072, 107,1.4*1.611)
HEADING_TAPE_EMGY.name				= create_guid_string()
HEADING_TAPE_EMGY.init_pos			= {1.26, 1.19}
HEADING_TAPE_EMGY.parent_element	= EMGY_PAGE.name
HEADING_TAPE_EMGY.h_clip_relation 	= h_clip_relations.DECREASE_IF_LEVEL  
HEADING_TAPE_EMGY.level           	= MFD_DEFAULT_LEVEL + 1
HEADING_TAPE_EMGY.element_params  	= { "RD_BRIGHTNESS","EMGY_HEADING"}
HEADING_TAPE_EMGY.controllers	 	= {JAS_Bright[1],JAS_Bright[2],JAS_Bright[3],JAS_Bright[4],JAS_Bright[5],JAS_Bright[6],JAS_Bright[7],JAS_Bright[8],JAS_Bright[9],JAS_Bright[10],JAS_Bright[11],JAS_Bright[12],JAS_Bright[13],JAS_Bright[14],JAS_Bright[15], JAS_Bright[16],JAS_Bright[17],JAS_Bright[18],JAS_Bright[19],JAS_Bright[20], {"move_left_right_using_parameter",1, -0.00061001} }
AddElement2(HEADING_TAPE_EMGY)

local MAG_text = add_text_with_brightness("MAG", 0.215,0.215, HEADING_ARROW_EMGY, "Gripen_Font_WHITE", mfd_strdefs_digit_XS )
MAG_text.init_rot			= {-90, 0}


local ALTITUDE_SCALE_EMGY_MASK				 	 = CreateElement "ceSimpleLineObject"
ALTITUDE_SCALE_EMGY_MASK.name			 		 = create_guid_string()
ALTITUDE_SCALE_EMGY_MASK.material				 = MakeMaterial(nil, {0,100,0, 255})
ALTITUDE_SCALE_EMGY_MASK.width		 		 	 = 0.20
ALTITUDE_SCALE_EMGY_MASK.vertices	 			 = {{0, 0.5}, {0,0}}
ALTITUDE_SCALE_EMGY_MASK.init_pos       		 = {1, 0.29}
ALTITUDE_SCALE_EMGY_MASK.init_rot				 = {90, 0}
ALTITUDE_SCALE_EMGY_MASK.h_clip_relation 		 = h_clip_relations.INCREASE_IF_LEVEL  
ALTITUDE_SCALE_EMGY_MASK.level				 	 = MFD_DEFAULT_LEVEL  
ALTITUDE_SCALE_EMGY_MASK.isvisible			 	 = false
ALTITUDE_SCALE_EMGY_MASK.parent_element 		 = EMGY_PAGE.name
AddElement2(ALTITUDE_SCALE_EMGY_MASK)


local ALTITUDE_SCALE_EMGY				= create_mfd_tex_3300(EMGY_HEADING_WHITE, 0, 251, 3072 , 415,2.5)
ALTITUDE_SCALE_EMGY.name				= create_guid_string()
ALTITUDE_SCALE_EMGY.init_pos			= {0.8, 2.458}
ALTITUDE_SCALE_EMGY.init_rot			= {90, 0}
ALTITUDE_SCALE_EMGY.parent_element		= EMGY_PAGE.name
ALTITUDE_SCALE_EMGY.h_clip_relation 	= h_clip_relations.DECREASE_IF_LEVEL  
ALTITUDE_SCALE_EMGY.level           	= MFD_DEFAULT_LEVEL + 1
ALTITUDE_SCALE_EMGY.element_params  	= { "RD_BRIGHTNESS","EMGY_ALTITUDE"}
ALTITUDE_SCALE_EMGY.controllers	 		= {JAS_Bright[1],JAS_Bright[2],JAS_Bright[3],JAS_Bright[4],JAS_Bright[5],JAS_Bright[6],JAS_Bright[7],JAS_Bright[8],JAS_Bright[9],JAS_Bright[10],JAS_Bright[11],JAS_Bright[12],JAS_Bright[13],JAS_Bright[14],JAS_Bright[15], JAS_Bright[16],JAS_Bright[17],JAS_Bright[18],JAS_Bright[19],JAS_Bright[20], {"move_left_right_using_parameter",1, -0.00001903} }
AddElement2(ALTITUDE_SCALE_EMGY)

local ALTITUDE_SCALE_EMGY2				= create_mfd_tex_3300(EMGY_HEADING_WHITE, 0, 438, 3072, 602,2.5)
ALTITUDE_SCALE_EMGY2.name				= create_guid_string()
ALTITUDE_SCALE_EMGY2.init_pos			= {0.8, 7.1288}
ALTITUDE_SCALE_EMGY2.init_rot			= {90, 0}
ALTITUDE_SCALE_EMGY2.parent_element		= EMGY_PAGE.name
ALTITUDE_SCALE_EMGY2.h_clip_relation 	= h_clip_relations.DECREASE_IF_LEVEL  
ALTITUDE_SCALE_EMGY2.level           	= MFD_DEFAULT_LEVEL + 1
ALTITUDE_SCALE_EMGY2.element_params  	= { "RD_BRIGHTNESS","EMGY_ALTITUDE"}
ALTITUDE_SCALE_EMGY2.controllers	 		= {JAS_Bright[1],JAS_Bright[2],JAS_Bright[3],JAS_Bright[4],JAS_Bright[5],JAS_Bright[6],JAS_Bright[7],JAS_Bright[8],JAS_Bright[9],JAS_Bright[10],JAS_Bright[11],JAS_Bright[12],JAS_Bright[13],JAS_Bright[14],JAS_Bright[15], JAS_Bright[16],JAS_Bright[17],JAS_Bright[18],JAS_Bright[19],JAS_Bright[20], {"move_left_right_using_parameter",1, -0.00001903} }
AddElement2(ALTITUDE_SCALE_EMGY2)

local ALTITUDE_SCALE_EMGY3				= create_mfd_tex_3300(EMGY_HEADING_WHITE, 0, 632 , 3072, 796,2.5)
ALTITUDE_SCALE_EMGY3.name				= create_guid_string()
ALTITUDE_SCALE_EMGY3.init_pos			= {0.8, 11.687}
ALTITUDE_SCALE_EMGY3.init_rot			= {90, 0}
ALTITUDE_SCALE_EMGY3.parent_element		= EMGY_PAGE.name
ALTITUDE_SCALE_EMGY3.h_clip_relation 	= h_clip_relations.DECREASE_IF_LEVEL  
ALTITUDE_SCALE_EMGY3.level           	= MFD_DEFAULT_LEVEL + 1
ALTITUDE_SCALE_EMGY3.element_params  	= { "RD_BRIGHTNESS","EMGY_ALTITUDE"}
ALTITUDE_SCALE_EMGY3.controllers	 		= {JAS_Bright[1],JAS_Bright[2],JAS_Bright[3],JAS_Bright[4],JAS_Bright[5],JAS_Bright[6],JAS_Bright[7],JAS_Bright[8],JAS_Bright[9],JAS_Bright[10],JAS_Bright[11],JAS_Bright[12],JAS_Bright[13],JAS_Bright[14],JAS_Bright[15], JAS_Bright[16],JAS_Bright[17],JAS_Bright[18],JAS_Bright[19],JAS_Bright[20], {"move_left_right_using_parameter",1, -0.00001903} }
AddElement2(ALTITUDE_SCALE_EMGY3)

local ALTITUDE_SCALE_EMGY4				= create_mfd_tex_3300(EMGY_HEADING_WHITE, 0, 886 , 3072, 991,2.5)
ALTITUDE_SCALE_EMGY4.name				= create_guid_string()
ALTITUDE_SCALE_EMGY4.init_pos			= {0.8, 16.244}
ALTITUDE_SCALE_EMGY4.init_rot			= {90, 0}
ALTITUDE_SCALE_EMGY4.parent_element		= EMGY_PAGE.name
ALTITUDE_SCALE_EMGY4.h_clip_relation 	= h_clip_relations.DECREASE_IF_LEVEL  
ALTITUDE_SCALE_EMGY4.level           	= MFD_DEFAULT_LEVEL + 1
ALTITUDE_SCALE_EMGY4.element_params  	= { "RD_BRIGHTNESS","EMGY_ALTITUDE"}
ALTITUDE_SCALE_EMGY4.controllers	 		= {JAS_Bright[1],JAS_Bright[2],JAS_Bright[3],JAS_Bright[4],JAS_Bright[5],JAS_Bright[6],JAS_Bright[7],JAS_Bright[8],JAS_Bright[9],JAS_Bright[10],JAS_Bright[11],JAS_Bright[12],JAS_Bright[13],JAS_Bright[14],JAS_Bright[15], JAS_Bright[16],JAS_Bright[17],JAS_Bright[18],JAS_Bright[19],JAS_Bright[20], {"move_left_right_using_parameter",1, -0.00001903} }
AddElement2(ALTITUDE_SCALE_EMGY4)


local ALTITUDE_EMGY_ARROW			= create_mfd_tex(ADI_FRAME_EMGY, 1748, 1497 , 1807, 1555,1)
ALTITUDE_EMGY_ARROW.name			= create_guid_string()
ALTITUDE_EMGY_ARROW.init_pos		= {0.645, 0.2935}
ALTITUDE_EMGY_ARROW.parent_element	= EMGY_PAGE.name
ALTITUDE_EMGY_ARROW.element_params  = {"RD_BRIGHTNESS"}
ALTITUDE_EMGY_ARROW.controllers	    = {JAS_Bright[1],JAS_Bright[2],JAS_Bright[3],JAS_Bright[4],JAS_Bright[5],JAS_Bright[6],JAS_Bright[7],JAS_Bright[8],JAS_Bright[9],JAS_Bright[10],JAS_Bright[11],JAS_Bright[12],JAS_Bright[13],JAS_Bright[14],JAS_Bright[15], JAS_Bright[16],JAS_Bright[17],JAS_Bright[18],JAS_Bright[19],JAS_Bright[20]}
AddElement(ALTITUDE_EMGY_ARROW)

local VSI_SCALE_EMGY			= create_mfd_tex(AAR_LDP_WHITE_COLOR, 1500, 737 , 1730, 1330,1)
VSI_SCALE_EMGY.name				= create_guid_string()
VSI_SCALE_EMGY.init_pos			= {0.7, -0.7}
VSI_SCALE_EMGY.parent_element	= EMGY_PAGE.name
VSI_SCALE_EMGY.element_params  = {"RD_BRIGHTNESS", "RD_VSI_TOGGLE"}
VSI_SCALE_EMGY.controllers	    = {JAS_Bright[1],JAS_Bright[2],JAS_Bright[3],JAS_Bright[4],JAS_Bright[5],JAS_Bright[6],JAS_Bright[7],JAS_Bright[8],JAS_Bright[9],JAS_Bright[10],JAS_Bright[11],JAS_Bright[12],JAS_Bright[13],JAS_Bright[14],JAS_Bright[15], JAS_Bright[16],JAS_Bright[17],JAS_Bright[18],JAS_Bright[19],JAS_Bright[20],{"parameter_compare_with_number",1, 1}}
AddElement(VSI_SCALE_EMGY) 

local VSI_SCALE_EMGY_ARROW			= create_mfd_tex(AAR_LDP_WHITE_COLOR, 1314, 960 , 1354, 1000,1)
VSI_SCALE_EMGY_ARROW.name			= create_guid_string()
VSI_SCALE_EMGY_ARROW.init_pos		= {0.59, -0.703}
VSI_SCALE_EMGY_ARROW.parent_element	= EMGY_PAGE.name
VSI_SCALE_EMGY_ARROW.element_params  = {"RD_BRIGHTNESS", "EMGY_VS", "RD_VSI_TOGGLE"}
VSI_SCALE_EMGY_ARROW.controllers	 = {JAS_Bright[1],JAS_Bright[2],JAS_Bright[3],JAS_Bright[4],JAS_Bright[5],JAS_Bright[6],JAS_Bright[7],JAS_Bright[8],JAS_Bright[9],JAS_Bright[10],JAS_Bright[11],JAS_Bright[12],JAS_Bright[13],JAS_Bright[14],JAS_Bright[15], JAS_Bright[16],JAS_Bright[17],JAS_Bright[18],JAS_Bright[19],JAS_Bright[20],{"move_up_down_using_parameter", 1, 0.000010875},{"parameter_compare_with_number",2, 1}}
AddElement(VSI_SCALE_EMGY_ARROW)

local DISPLAY_TEMP_EMGY			= create_mfd_tex(AAR_LDP_WHITE_COLOR, 495, 131 , 755, 208,1.5)
DISPLAY_TEMP_EMGY.name				= create_guid_string()
DISPLAY_TEMP_EMGY.init_pos			= {0, -0.36}
DISPLAY_TEMP_EMGY.parent_element	= EMGY_PAGE.name
DISPLAY_TEMP_EMGY.element_params  = {"RD_BRIGHTNESS", "RD_TEMP_TOGGLE"}
DISPLAY_TEMP_EMGY.controllers	    = {JAS_Bright[1],JAS_Bright[2],JAS_Bright[3],JAS_Bright[4],JAS_Bright[5],JAS_Bright[6],JAS_Bright[7],JAS_Bright[8],JAS_Bright[9],JAS_Bright[10],JAS_Bright[11],JAS_Bright[12],JAS_Bright[13],JAS_Bright[14],JAS_Bright[15], JAS_Bright[16],JAS_Bright[17],JAS_Bright[18],JAS_Bright[19],JAS_Bright[20],{"parameter_compare_with_number",1, 1}}
AddElement(DISPLAY_TEMP_EMGY)








local FONT_SIZE = 0.64

local EMGY			= create_mfd_tex(ADI_FRAME_EMGY, 0, 1270, 125 , 1700,FONT_SIZE) 
EMGY.name			= create_guid_string()
EMGY.init_pos		= {-0.96+xcor, 1.1575}
EMGY.parent_element	= EMGY_PAGE.name
EMGY.element_params  = {"RD_BRIGHTNESS"}
EMGY.controllers	    = {JAS_Bright[1],JAS_Bright[2],JAS_Bright[3],JAS_Bright[4],JAS_Bright[5],JAS_Bright[6],JAS_Bright[7],JAS_Bright[8],JAS_Bright[9],JAS_Bright[10],JAS_Bright[11],JAS_Bright[12],JAS_Bright[13],JAS_Bright[14],JAS_Bright[15], JAS_Bright[16],JAS_Bright[17],JAS_Bright[18],JAS_Bright[19],JAS_Bright[20]}
AddElement(EMGY)

local EMGY_BOX				= create_mfd_tex(NAV_WHEEL_WHITE, 1950, 215, 2042 , 646, FONT_SIZE) 	-- 4 Letter box
EMGY_BOX.name				= create_guid_string()
EMGY_BOX.init_pos			= {-0.9698+xcor, 1.15}
EMGY_BOX.parent_element		= EMGY_PAGE.name
EMGY_BOX.element_params 	= {"RD_BRIGHTNESS","RD_EMGY_MODE"}
EMGY_BOX.controllers   		= {JAS_Bright[1],JAS_Bright[2],JAS_Bright[3],JAS_Bright[4],JAS_Bright[5],JAS_Bright[6],JAS_Bright[7],JAS_Bright[8],JAS_Bright[9],JAS_Bright[10],JAS_Bright[11],JAS_Bright[12],JAS_Bright[13],JAS_Bright[14],JAS_Bright[15], JAS_Bright[16],JAS_Bright[17],JAS_Bright[18],JAS_Bright[19],JAS_Bright[20],{"parameter_compare_with_number",1, 1}}
AddElement(EMGY_BOX)

local NORM			= create_mfd_tex(ADI_FRAME_EMGY, 1415, 435, 1482 , 825,FONT_SIZE) 
NORM.name			= create_guid_string()
NORM.init_pos		= {-0.91+xcor, 1.1495}
NORM.parent_element	= EMGY_PAGE.name
NORM.element_params  = {"RD_BRIGHTNESS"}
NORM.controllers	    = {JAS_Bright[1],JAS_Bright[2],JAS_Bright[3],JAS_Bright[4],JAS_Bright[5],JAS_Bright[6],JAS_Bright[7],JAS_Bright[8],JAS_Bright[9],JAS_Bright[10],JAS_Bright[11],JAS_Bright[12],JAS_Bright[13],JAS_Bright[14],JAS_Bright[15], JAS_Bright[16],JAS_Bright[17],JAS_Bright[18],JAS_Bright[19],JAS_Bright[20]}
AddElement(NORM)

local TEMP			= create_mfd_tex(ADI_FRAME_EMGY, 1512 , 435, 1582 , 825,FONT_SIZE) 
TEMP.name			= create_guid_string()
TEMP.init_pos		= {-0.968+xcor, -0.30125}
TEMP.parent_element	= EMGY_PAGE.name
TEMP.element_params  = {"RD_BRIGHTNESS"}
TEMP.controllers	    = {JAS_Bright[1],JAS_Bright[2],JAS_Bright[3],JAS_Bright[4],JAS_Bright[5],JAS_Bright[6],JAS_Bright[7],JAS_Bright[8],JAS_Bright[9],JAS_Bright[10],JAS_Bright[11],JAS_Bright[12],JAS_Bright[13],JAS_Bright[14],JAS_Bright[15], JAS_Bright[16],JAS_Bright[17],JAS_Bright[18],JAS_Bright[19],JAS_Bright[20]}
AddElement(TEMP)

local TEMP_BOX				= create_mfd_tex(NAV_WHEEL_WHITE, 1950, 215, 2042 , 646, FONT_SIZE) 	-- 4 Letter box
TEMP_BOX.name				= create_guid_string()
TEMP_BOX.init_pos			= {-0.9698+xcor, -0.30}
TEMP_BOX.parent_element		= EMGY_PAGE.name
TEMP_BOX.element_params 	= {"RD_BRIGHTNESS", "RD_TEMP_TOGGLE"}
TEMP_BOX.controllers   		= {JAS_Bright[1],JAS_Bright[2],JAS_Bright[3],JAS_Bright[4],JAS_Bright[5],JAS_Bright[6],JAS_Bright[7],JAS_Bright[8],JAS_Bright[9],JAS_Bright[10],JAS_Bright[11],JAS_Bright[12],JAS_Bright[13],JAS_Bright[14],JAS_Bright[15], JAS_Bright[16],JAS_Bright[17],JAS_Bright[18],JAS_Bright[19],JAS_Bright[20],{"parameter_compare_with_number",1, 1}} --
AddElement(TEMP_BOX)

local ENG			= create_mfd_tex(ADI_FRAME_EMGY, 1699, 435, 1768 , 727,FONT_SIZE) 
ENG.name			= create_guid_string()
ENG.init_pos		= {-0.968+xcor, -0.60125}
ENG.parent_element	= EMGY_PAGE.name
ENG.element_params  = {"RD_BRIGHTNESS"}
ENG.controllers	    = {JAS_Bright[1],JAS_Bright[2],JAS_Bright[3],JAS_Bright[4],JAS_Bright[5],JAS_Bright[6],JAS_Bright[7],JAS_Bright[8],JAS_Bright[9],JAS_Bright[10],JAS_Bright[11],JAS_Bright[12],JAS_Bright[13],JAS_Bright[14],JAS_Bright[15], JAS_Bright[16],JAS_Bright[17],JAS_Bright[18],JAS_Bright[19],JAS_Bright[20]}
AddElement(ENG)

local ENG_BOX				= create_mfd_tex(NAV_WHEEL_WHITE, 1850, 215, 1942 , 552, FONT_SIZE) 	-- 3 Letter box
ENG_BOX.name				= create_guid_string()
ENG_BOX.init_pos			= {-0.968+xcor, -0.60}
ENG_BOX.parent_element		= EMGY_PAGE.name
ENG_BOX.element_params 		= {"RD_BRIGHTNESS","RD_ENG_TOGGLE"}
ENG_BOX.controllers   		= {JAS_Bright[1],JAS_Bright[2],JAS_Bright[3],JAS_Bright[4],JAS_Bright[5],JAS_Bright[6],JAS_Bright[7],JAS_Bright[8],JAS_Bright[9],JAS_Bright[10],JAS_Bright[11],JAS_Bright[12],JAS_Bright[13],JAS_Bright[14],JAS_Bright[15], JAS_Bright[16],JAS_Bright[17],JAS_Bright[18],JAS_Bright[19],JAS_Bright[20], {"parameter_compare_with_number", 1, 1}} --,{"parameter_compare_with_number",1, 1}
AddElement(ENG_BOX)

local VSI			= create_mfd_tex(ADI_FRAME_EMGY, 1606, 435, 1679 , 727,FONT_SIZE) 
VSI.name			= create_guid_string()
VSI.init_pos		= {0.968-xcor, -0.60125}
VSI.parent_element	= EMGY_PAGE.name
VSI.element_params  = {"RD_BRIGHTNESS"}
VSI.controllers	    = {JAS_Bright[1],JAS_Bright[2],JAS_Bright[3],JAS_Bright[4],JAS_Bright[5],JAS_Bright[6],JAS_Bright[7],JAS_Bright[8],JAS_Bright[9],JAS_Bright[10],JAS_Bright[11],JAS_Bright[12],JAS_Bright[13],JAS_Bright[14],JAS_Bright[15], JAS_Bright[16],JAS_Bright[17],JAS_Bright[18],JAS_Bright[19],JAS_Bright[20]}
AddElement(VSI)

local VSI_BOX				= create_mfd_tex(NAV_WHEEL_WHITE, 1850, 215, 1942 , 552, FONT_SIZE) 	-- 3 Letter box
VSI_BOX.name				= create_guid_string()
VSI_BOX.init_pos			= {0.968-xcor, -0.60}
VSI_BOX.parent_element		= EMGY_PAGE.name
VSI_BOX.element_params 		= {"RD_BRIGHTNESS","RD_VSI_TOGGLE"}
VSI_BOX.controllers   		= {JAS_Bright[1],JAS_Bright[2],JAS_Bright[3],JAS_Bright[4],JAS_Bright[5],JAS_Bright[6],JAS_Bright[7],JAS_Bright[8],JAS_Bright[9],JAS_Bright[10],JAS_Bright[11],JAS_Bright[12],JAS_Bright[13],JAS_Bright[14],JAS_Bright[15], JAS_Bright[16],JAS_Bright[17],JAS_Bright[18],JAS_Bright[19],JAS_Bright[20],{"parameter_compare_with_number",1, 1}} --
AddElement(VSI_BOX)
]]--


