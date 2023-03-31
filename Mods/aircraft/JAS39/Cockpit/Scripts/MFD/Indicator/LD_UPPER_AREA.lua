-- {"change_color_when_parameter_equal_to_number", param_nr, number, red, green, blue}
-- {"text_using_parameter", param_nr, format_nr}
-- {"move_left_right_using_parameter", param_nr, gain}
-- {"move_up_down_using_parameter", param_nr, gain}
-- {"opacity_using_parameter", param_nr}
-- {"rotate_using_parameter", param_nr, gain}
-- {"compare_parameters", param1_nr, param2_nr} -- if param1 == param2 then visible
-- {"parameter_in_range", param_nr, greaterthanvalue, lessthanvalue} -- if greaterthanvalue < param < lessthanvalue then visible
-- {"parameter_compare_with_number", param_nr, number} -- if param == number then visible
-- {"draw_argument_in_range", arg_nr, greaterthanvalue, lessthanvalue} -- if greaterthanvalue < arg < lessthanvalue then visible
-- {"line_object_set_point_using_parameters", point_nr, param_x, param_y, gain_x, gain_y} -- applies to ceSimpleLineObject at least


local FONT_SIZE = 0.64

-- LD = Left Display 
TAN_LD_MASTER 					= CreateElement "ceSimple"
TAN_LD_MASTER.init_pos			= {0,0}
TAN_LD_MASTER.name				= create_guid_string()
TAN_LD_MASTER.element_params 	= {"LD_EMGY_MODE", "MAINPOWER"}
TAN_LD_MASTER.controllers    	= {{"parameter_compare_with_number",0, 0}, {"parameter_compare_with_number", 1, 1}}
AddElement(TAN_LD_MASTER)


TAN_Background 					= CreateElement "ceMeshPoly"
TAN_Background.name 			= create_guid_string()
TAN_Background.primitivetype 	= "triangles"
TAN_Background.vertices	   		= { {-1.0 , 1.4 }, { 1.0,1.4}, { 1.0,-1.4}, {-1.0,-1.4}, }
TAN_Background.indices			= {0, 1, 2, 0, 2, 3}
TAN_Background.init_pos			= {0, 0, 0}
TAN_Background.material			= MakeMaterial(nil,{230, 220, 140, 255})	--RGBA
TAN_Background.parent_element	= TAN_LD_MASTER.name
TAN_Background.h_clip_relation  = h_clip_relations.REWRITE_LEVEL
TAN_Background.level			= MFD_DEFAULT_LEVEL
TAN_Background.change_opacity	= false
TAN_Background.collimated 		= false
TAN_Background.isvisible		= true
TAN_Background.element_params 	= {"LD_BRIGHTNESS"}
TAN_Background.controllers    	= {{"opacity_using_parameter", 0}}
Add(TAN_Background)



Clockparent 				= CreateElement "ceMeshPoly"
Clockparent.name 			= create_guid_string()
Clockparent.primitivetype 	= "triangles"
Clockparent.vertices	   	= { {-1.0 , 1.4 }, { 1.0,1.4}, { 1.0,-1.4}, {-1.0,-1.4}, }
Clockparent.indices			= {0, 1, 2, 0, 2, 3}
Clockparent.init_pos		= {0, 0, 0}
Clockparent.material		= MakeMaterial(nil,{0, 0, 0, 0})	--RGBA
Clockparent.parent_element	= TAN_LD_MASTER.name
Clockparent.h_clip_relation  = h_clip_relations.REWRITE_LEVEL
Clockparent.level			= MFD_DEFAULT_LEVEL
Clockparent.change_opacity	= false
Clockparent.collimated 		= false
Clockparent.isvisible		= false
Clockparent.element_params 	= {"LD_UPPER"}
Clockparent.controllers    	= {{"parameter_in_range", 0, 0, 4}}
Add(Clockparent)







add_text_param(0.87, 1.34, "SECONDSTIME", "%02.0f", Clockparent, mfd_strdefs_digit_XS, "Gripen_Font_black")
add_text(",", 0.834, 1.3475, Clockparent, "Gripen_Font_black" )
add_text_param(0.78, 1.34, "MINUTESTIME", "%02.0f", Clockparent, mfd_strdefs_digit_XS, "Gripen_Font_black")
add_text(",", 0.745, 1.3475, Clockparent, "Gripen_Font_black" )
add_text_param(0.695, 1.34, "HOURTIME", "%02.0f", Clockparent, mfd_strdefs_digit_XS, "Gripen_Font_black")



--===================================================================================================================================================================================
-- 			[GEN]PAGE, flight data display			{"opacity_using_parameter" ,1, 20}		"LD_BRIGHTNESS"
--===================================================================================================================================================================================

GEN_PAGE 			= CreateElement "ceSimple"
GEN_PAGE.init_pos		= {0,0}
GEN_PAGE.name			= create_guid_string()
GEN_PAGE.parent_element		= TAN_LD_MASTER.name
GEN_PAGE.element_params 	= {"LD_UPPER"}
GEN_PAGE.controllers    	= {{"parameter_compare_with_number",0, 1}  }
AddElement(GEN_PAGE)


-- Speedo
local speedometer_kts			= create_mfd_tex_3k(MFD_ELEMENTS_PDD, 10, 10, 850, 844)
speedometer_kts.name			= create_guid_string()
speedometer_kts.init_pos		= {-0.55, 0.96}
speedometer_kts.parent_element	= GEN_PAGE.name	
AddElement(speedometer_kts)	


local speedometer_needle 			= create_mfd_tex_3k(MFD_ELEMENTS_PDD, 82, 2230, 353, 2272, nil , -57 ,2260 + ((2243-2230)/2)  )
speedometer_needle.name				= create_guid_string()
speedometer_needle.init_pos			= {-0.547, 0.964}
speedometer_needle.init_rot			= {90, 0}
speedometer_needle.parent_element	= GEN_PAGE.name
speedometer_needle.element_params   = {"CUR_IAS"}
speedometer_needle.controllers	 	= {{"rotate_using_parameter" ,0, -math.rad(360)/1000},}
AddElement(speedometer_needle)

add_text("M", 0, 0.05, speedometer_kts, "Gripen_Font_black" )

--add_text_param(0, -0.04, "CUR_MACH", "%0.2f", speedometer_kts, mfd_strdefs_digit, "Gripen_Font_black")

local Mach_indicator 				= CreateElement "ceStringPoly"
Mach_indicator.name 				= create_guid_string()
Mach_indicator.parent_element		= speedometer_kts.name
Mach_indicator.material				= fonts["Gripen_Font_black"]
Mach_indicator.init_pos 			= {0, -0.04}
Mach_indicator.alignment 			= "LeftCenter"
Mach_indicator.stringdefs 			= mfd_strdefs_digit
Mach_indicator.formats 				= {"%0.0f","%s"}
Mach_indicator.element_params 		= {"MACH_B"}
Mach_indicator.controllers 			= {{"text_using_parameter",0,0},{"parameter_in_range" ,0, 3, 99.5}}
AddElement(Mach_indicator)

add_text(".", -0.011, 0, Mach_indicator, "Gripen_Font_black",mfd_strdefs_digit )

local Mach_indicator2 				= CreateElement "ceStringPoly"
Mach_indicator2.name 				= create_guid_string()
Mach_indicator2.parent_element		= speedometer_kts.name
Mach_indicator2.material			= fonts["Gripen_Font_black"]
Mach_indicator2.init_pos 			= {-0.068, -0.04}
Mach_indicator2.alignment 			= "LeftCenter"
Mach_indicator2.stringdefs 			= mfd_strdefs_digit
Mach_indicator2.formats 			= {"%0.2f","%s"}
Mach_indicator2.element_params 		= {"MACH_A"}
Mach_indicator2.controllers 		= {{"text_using_parameter",0,0},{"parameter_in_range" ,0, 0.995, 3}}
AddElement(Mach_indicator2)







-- Altimeter

local Altimeter_Feet		= create_mfd_tex_3k(MFD_ELEMENTS_PDD,860, 0, 1700, 844)
Altimeter_Feet.name			= create_guid_string()
Altimeter_Feet.init_pos		= {0.55, 0.96}
Altimeter_Feet.parent_element	= GEN_PAGE.name	
AddElement(Altimeter_Feet)	

local Altimeter_Needle = create_mfd_tex(MFD_ELEMENTS_DARK, 464, 798, 600, 822, 1.5 , 378 , 794 + ((822-796)/2)  )
Altimeter_Needle.name			= create_guid_string()
Altimeter_Needle.init_pos		= {0.55, 0.96}
Altimeter_Needle.init_rot		= {90, 0}
Altimeter_Needle.parent_element	= GEN_PAGE.name	
Altimeter_Needle.element_params  = { "ALTITUDE_H"}
Altimeter_Needle.controllers	 	= {{"rotate_using_parameter" ,0, -math.rad(360)/1000},}
AddElement(Altimeter_Needle)

add_text_param(-0.048, 0     , "ALTITUDE_T", "%02.0f", Altimeter_Feet, mfd_strdefs_digit_b, "Gripen_Font_black")
add_text_param( 0.07, -0.006, "ALTITUDE_H", "%03.0f", Altimeter_Feet, mfd_strdefs_digit, "Gripen_Font_black")

-- Radar altimeter
local Radar_altimeter		= create_mfd_tex_3k(MFD_ELEMENTS_PDD,40, 1965, 340, 2042, 1.0)
Radar_altimeter.name			= create_guid_string()
Radar_altimeter.init_pos		= {-0.12, 1.1}
Radar_altimeter.parent_element	= GEN_PAGE.name	
AddElement(Radar_altimeter)

add_text_param( 0.15, 0     , "ALT_ALTITUDE_T", "%02.0f", Radar_altimeter, mfd_strdefs_digit_b, "Gripen_Font_black")
add_text_param( 0.27, -0.006, "ALT_ALTITUDE_H", "%03.0f", Radar_altimeter, mfd_strdefs_digit, "Gripen_Font_black")

--ADI ball
adi_background_mask 				= AddCircle(-0.01, 0.277, 0.47, 1, true)
adi_background_mask.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL  
adi_background_mask.level			= MFD_DEFAULT_LEVEL
adi_background_mask.material		= MakeMaterial(nil,{0, 0, 0,255})	--RGBA
adi_background_mask.isvisible		= false
adi_background_mask.parent_element	= GEN_PAGE.name
AddElement2(adi_background_mask)


adi_background_mask2 				= AddCircle(-0.01, 0.24, 0.47, 1, true)
adi_background_mask2.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL  
adi_background_mask2.level			= MFD_DEFAULT_LEVEL
adi_background_mask2.material		= MakeMaterial(nil,{0, 0, 0,255})	--RGBA
adi_background_mask2.isvisible		= false
adi_background_mask2.parent_element	= GEN_PAGE.name
AddElement2(adi_background_mask2)	

adi_background_base 				= CreateElement "ceSimple"
adi_background_base.init_pos		= {0, 0.270}	
adi_background_base.name			= create_guid_string()
adi_background_base.h_clip_relation = h_clip_relations.DECREASE_IF_LEVEL 
adi_background_base.level           = MFD_DEFAULT_LEVEL + 1
adi_background_base.parent_element	 = GEN_PAGE.name
adi_background_base.element_params 	= {"ADI_ROLL",}
adi_background_base.controllers		= {{"rotate_using_parameter" ,0, 1},}
AddElement2(adi_background_base)	

local adi_background			= create_mfd_tex_3300(ADI_BACKGROUND_B, 0, 0, 3072, 1920,1.4*1.611)
adi_background.name			= create_guid_string()
adi_background.init_pos		= {1.2825, 0}
adi_background.parent_element	= adi_background_base.name
adi_background.h_clip_relation = h_clip_relations.DECREASE_IF_LEVEL  
adi_background.level           = MFD_DEFAULT_LEVEL + 1
adi_background.element_params  = { "LD_BRIGHTNESS", "ADI_PITCH", "HEADING"}
adi_background.controllers	 = {JAS_Bright[1],JAS_Bright[2],JAS_Bright[3],JAS_Bright[4],JAS_Bright[5],JAS_Bright[6],JAS_Bright[7],JAS_Bright[8],JAS_Bright[9],JAS_Bright[10],JAS_Bright[11],JAS_Bright[12],JAS_Bright[13],JAS_Bright[14],JAS_Bright[15], JAS_Bright[16],JAS_Bright[17],JAS_Bright[18],JAS_Bright[19],JAS_Bright[20], {"move_up_down_using_parameter",1, 0.036}, {"move_left_right_using_parameter",2, -0.00061425} }
AddElement2(adi_background)


--{"change_color_when_parameter_equal_to_number", param_nr, number, red, green, blue}

-- Circle around the ADI
local adi_indicator			= create_mfd_tex(ADI_FRAME_B, 0, 0, 1270, 1270,0.92)
adi_indicator.name			= create_guid_string()
adi_indicator.init_pos		= {0, 0.270}
adi_indicator.parent_element	= GEN_PAGE.name
adi_indicator.element_params  = {"LD_BRIGHTNESS"}
adi_indicator.controllers	 = {JAS_Bright[1],JAS_Bright[2],JAS_Bright[3],JAS_Bright[4],JAS_Bright[5],JAS_Bright[6],JAS_Bright[7],JAS_Bright[8],JAS_Bright[9],JAS_Bright[10],JAS_Bright[11],JAS_Bright[12],JAS_Bright[13],JAS_Bright[14],JAS_Bright[15], JAS_Bright[16],JAS_Bright[17],JAS_Bright[18],JAS_Bright[19],JAS_Bright[20]}
AddElement(adi_indicator)

	
-- Attitude marker
local adi_Attitude			= create_mfd_VELVEC(ADI_VEELOCITYVECTOR, 20, 55, 354, 285,1.3)
adi_Attitude.name			= create_guid_string()
adi_Attitude.init_pos		= {0, 0.270}
adi_Attitude.parent_element	= GEN_PAGE.name
adi_Attitude.element_params 	= {"VELVEC_HUD_Y","VELVEC_HUD_X"}
adi_Attitude.controllers    	= { {"move_up_down_using_parameter",0, 0.036}, {"move_left_right_using_parameter",1, 0.036}}
AddElement(adi_Attitude)
	
--Roll marker
local adi_roll				= create_mfd_tex(ADI_FRAME_B, 1975, 0, 2038, 1143.27-110, 1.0 )
adi_roll.name				= create_guid_string()
adi_roll.init_pos			= {-0.0065, 0}
adi_roll.parent_element		= adi_indicator.name	
adi_roll.element_params 	= {"LD_BRIGHTNESS", "ADI_ROLL",}
adi_roll.controllers		= {JAS_Bright[1],JAS_Bright[2],JAS_Bright[3],JAS_Bright[4],JAS_Bright[5],JAS_Bright[6],JAS_Bright[7],JAS_Bright[8],JAS_Bright[9],JAS_Bright[10],JAS_Bright[11],JAS_Bright[12],JAS_Bright[13],JAS_Bright[14],JAS_Bright[15], JAS_Bright[16],JAS_Bright[17],JAS_Bright[18],JAS_Bright[19],JAS_Bright[20],{"rotate_using_parameter" ,1, 1}}
AddElement(adi_roll)


-- Alfa ladder

AOA_bar_mask = create_mfd_tex_3k(MFD_ELEMENTS_PDD,2306, 640, 2356, 1551, 1)
AOA_bar_mask.init_pos			= {-0.825, 0.10}
AOA_bar_mask.h_clip_relation 	= h_clip_relations.INCREASE_IF_LEVEL  
AOA_bar_mask.level			 	= MFD_DEFAULT_LEVEL  
AOA_bar_mask.isvisible		 	= false
AOA_bar_mask.parent_element		= GEN_PAGE.name
AddElement2(AOA_bar_mask)

local AOA_ladder			= create_mfd_tex_3k(MFD_ELEMENTS_PDD,2058, 510, 2285, 1552, 1)
AOA_ladder.name				= create_guid_string()
AOA_ladder.init_pos			= {-0.85, 0.14}
AOA_ladder.parent_element	= GEN_PAGE.name	
AOA_ladder.element_params 	= {"CABIN_TOGGLE", "EPERROR_TOGGLE"}
AOA_ladder.controllers    	= {{"parameter_compare_with_number",0, 0},{"parameter_compare_with_number",1, 0}}
AddElement(AOA_ladder)



local AOA_bar			= create_mfd_tex_3k(MFD_ELEMENTS_PDD,2306, 640, 2356, 1551, 1)
AOA_bar.name			= create_guid_string()
AOA_bar.h_clip_relation = h_clip_relations.DECREASE_IF_LEVEL  
AOA_bar.level           = MFD_DEFAULT_LEVEL + 1
AOA_bar.init_pos		= {0.035, -0.625}
AOA_bar.parent_element	= AOA_ladder.name
AOA_bar.element_params  = {"CUR_AOA"}
AOA_bar.controllers	 = {{"move_up_down_using_parameter",0, 0.00165}}
AddElement2(AOA_bar)

-- G ladder

local G_bar_mask = create_mfd_tex_3k(MFD_ELEMENTS_PDD,2306, 640, 2356, 1551, 1)
G_bar_mask.init_pos		= {-0.625, 0.11}
G_bar_mask.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL  
G_bar_mask.level			 = MFD_DEFAULT_LEVEL  
G_bar_mask.isvisible		 = false
G_bar_mask.parent_element	= GEN_PAGE.name
AddElement2(G_bar_mask)


local G_ladder		= create_mfd_tex_3k(MFD_ELEMENTS_PDD,2490, 9, 2667, 1088, 1)
G_ladder.name			= create_guid_string()
G_ladder.init_pos		= {-0.65, 0.14}
G_ladder.parent_element	= GEN_PAGE.name	
G_ladder.element_params = {"CABIN_TOGGLE"}
G_ladder.controllers    = {{"parameter_compare_with_number",0, 0}}
AddElement(G_ladder)

local G_bar			= create_mfd_tex_3k(MFD_ELEMENTS_PDD,2306, 640, 2356, 1551, 1)
G_bar.name			= create_guid_string()
G_bar.h_clip_relation = h_clip_relations.DECREASE_IF_LEVEL  
G_bar.level           = MFD_DEFAULT_LEVEL + 1
G_bar.init_pos		= {0.020, -0.625}
G_bar.parent_element	= G_ladder.name
G_bar.element_params  = {"CUR_G"}
G_bar.controllers	 = {{"move_up_down_using_parameter",0, 0.00565}}
AddElement2(G_bar)

local THR_bar_mask = create_mfd_tex_3k(MFD_ELEMENTS_PDD,2930, 24, 3000, 1123, 1)
THR_bar_mask.init_pos		= {0.685, 0.18}
THR_bar_mask.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL  
THR_bar_mask.level			 = MFD_DEFAULT_LEVEL 
THR_bar_mask.isvisible		 = false
THR_bar_mask.parent_element	= GEN_PAGE.name
AddElement2(THR_bar_mask)

local Throttle_ladder		= create_mfd_tex_3k(MFD_ELEMENTS_PDD,2675, 12, 2910, 1137, 1)
Throttle_ladder.name			= create_guid_string()
Throttle_ladder.init_pos		= {0.65, 0.18}
Throttle_ladder.parent_element	= GEN_PAGE.name	
AddElement(Throttle_ladder)

local Throttle_bar			= create_mfd_tex_3k(MFD_ELEMENTS_PDD,2930, 24, 2982, 1123, 1.05)
Throttle_bar.name			= create_guid_string()
Throttle_bar.h_clip_relation = h_clip_relations.DECREASE_IF_LEVEL
Throttle_bar.level           = MFD_DEFAULT_LEVEL + 1
Throttle_bar.init_pos		= {0.050, -0.77}
Throttle_bar.parent_element	= Throttle_ladder.name
Throttle_bar.element_params  = {"CUR_TRH"}
Throttle_bar.controllers	 = {{"move_up_down_using_parameter",0, 0.054}}
AddElement2(Throttle_bar)

local EPE_SCALE			= create_mfd_tex(AAR_LDP_BLACK, 5, 500, 170 , 1150,1.10) 
EPE_SCALE.name			= create_guid_string()
EPE_SCALE.init_pos		= {-0.85, 0.14}
EPE_SCALE.parent_element	= GEN_PAGE.name
EPE_SCALE.element_params = {"EPERROR_TOGGLE"}
EPE_SCALE.controllers    = {{"parameter_compare_with_number",0, 1}}
AddElement(EPE_SCALE)

local CAB_bar_mask = create_mfd_tex_3k(MFD_ELEMENTS_PDD,2306, 640, 2356, 1551, 1)
CAB_bar_mask.init_pos			= {-0.808, 0.1265}
CAB_bar_mask.h_clip_relation 	= h_clip_relations.INCREASE_IF_LEVEL  
CAB_bar_mask.level			 	= MFD_DEFAULT_LEVEL 
CAB_bar_mask.isvisible		 	= false
CAB_bar_mask.parent_element		= GEN_PAGE.name
CAB_bar_mask.element_params 	= {"CABIN_TOGGLE"}
CAB_bar_mask.controllers    	= {{"parameter_compare_with_number",0, 1} }
AddElement2(CAB_bar_mask)

local CAB_SCALE			= create_mfd_tex(AAR_LDP_BLACK, 180, 500, 400 , 1180,1.10) 
CAB_SCALE.name			= create_guid_string()
CAB_SCALE.init_pos		= {-0.85, 0.14}
CAB_SCALE.parent_element	= GEN_PAGE.name
CAB_SCALE.element_params = {"CABIN_TOGGLE"}
CAB_SCALE.controllers    = {{"parameter_compare_with_number",0, 1} }
AddElement(CAB_SCALE)

local CAB_bar 				= create_mfd_tex_3k(MFD_ELEMENTS_PDD,2306, 640, 2356, 1551, 1)
CAB_bar.name				= create_guid_string()
CAB_bar.init_pos			= {-0.808, -0.462}
CAB_bar.h_clip_relation 	= h_clip_relations.DECREASE_IF_LEVEL
CAB_bar.level			 	= MFD_DEFAULT_LEVEL + 1
CAB_bar.parent_element		= GEN_PAGE.name
CAB_bar.element_params 		= {"CABIN_TOGGLE", "CAB_PRESSURE"}
CAB_bar.controllers    		= {{"parameter_compare_with_number",0, 1}, {"move_up_down_using_parameter",1, 0.001375} }
AddElement2(CAB_bar)

local OXY_bar_mask 				= create_mfd_tex_3k(MFD_ELEMENTS_PDD,2306, 640, 2356, 1551, 1)
OXY_bar_mask.init_pos			= {-0.6, 0.1265}
OXY_bar_mask.h_clip_relation 	= h_clip_relations.INCREASE_IF_LEVEL  
OXY_bar_mask.level			 	= MFD_DEFAULT_LEVEL 
OXY_bar_mask.isvisible		 	= false
OXY_bar_mask.parent_element		= GEN_PAGE.name
OXY_bar_mask.element_params 	= {"CABIN_TOGGLE"}
OXY_bar_mask.controllers    	= {{"parameter_compare_with_number",0, 1} }
AddElement2(OXY_bar_mask)

local OXY_SCALE				= create_mfd_tex(AAR_LDP_BLACK, 380, 500, 575 , 1180,1.10) 
OXY_SCALE.name				= create_guid_string()
OXY_SCALE.init_pos			= {-0.65, 0.14}
OXY_SCALE.parent_element	= GEN_PAGE.name
OXY_SCALE.element_params 	= {"CABIN_TOGGLE"}
OXY_SCALE.controllers    	= {{"parameter_compare_with_number",0, 1} }
AddElement(OXY_SCALE)


local OXY_bar 				= create_mfd_tex_3k(MFD_ELEMENTS_PDD,2306, 640, 2356, 1551, 1)
OXY_bar.name				= create_guid_string()
OXY_bar.init_pos			= {-0.59, 0.113}
OXY_bar.h_clip_relation 	= h_clip_relations.DECREASE_IF_LEVEL
OXY_bar.level			 	= MFD_DEFAULT_LEVEL + 1
OXY_bar.parent_element		= GEN_PAGE.name
OXY_bar.element_params 		= {"CABIN_TOGGLE"}
OXY_bar.controllers    		= {{"parameter_compare_with_number",0, 1} }
AddElement2(OXY_bar)

--===================================================================================================================================================================================
--	[DEF] PAGE, HSI
--===================================================================================================================================================================================
DEF_PAGE 			= CreateElement "ceSimple"
DEF_PAGE.init_pos	= {0,0}
DEF_PAGE.name		= create_guid_string()
DEF_PAGE.parent_element	= TAN_LD_MASTER.name
DEF_PAGE.element_params = {"LD_UPPER"}
DEF_PAGE.controllers    = {{"parameter_compare_with_number",0, 2}}
AddElement(DEF_PAGE)


hsi_mask = AddCircle(0, 0.55, 0.58, 9, true)
hsi_mask.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL  
hsi_mask.level			 = MFD_DEFAULT_LEVEL  -1
hsi_mask.isvisible		 = false
hsi_mask.parent_element	= DEF_PAGE.name
AddElement2(hsi_mask)

hsi_base 				= CreateElement "ceSimple"
hsi_base.init_pos		= {0, 0.55}
hsi_base.name			= create_guid_string()
hsi_base.h_clip_relation = h_clip_relations.DECREASE_IF_LEVEL  
hsi_base.level           = MFD_DEFAULT_LEVEL - 1
-- AddElement2(hsi_base)	

local hsi_base_HOR			= create_mfd_tex(MFD_ELEMENTS, 1509, 0, 2048, 1913,1.6)
hsi_base_HOR.name			= create_guid_string()
hsi_base_HOR.init_pos		= {0, 0}
hsi_base_HOR.parent_element	= hsi_base.name
hsi_base_HOR.h_clip_relation = h_clip_relations.DECREASE_IF_LEVEL  
hsi_base_HOR.level           = MFD_DEFAULT_LEVEL + 1
-- AddElement2(hsi_base_HOR)

local hsi_indicator			= create_mfd_tex(NAV_WHEEL_BLACK, 1013, 1013, 2045, 2045,1.3)
hsi_indicator.name			= create_guid_string()
hsi_indicator.init_pos		= {0, 0.55}
hsi_indicator.parent_element	= DEF_PAGE.name
AddElement(hsi_indicator)	

local compass_indicator			 = create_mfd_tex(NAV_WHEEL_BLACK, 15, 12, 1042, 1040,1.6)
compass_indicator.name			 = create_guid_string()
compass_indicator.parent_element = DEF_PAGE.name
compass_indicator.init_pos		 = {0, 0.55}
compass_indicator.element_params = {"HEADINGCOMPASS",}
compass_indicator.controllers	 = {{"rotate_using_parameter" ,0, math.rad(360)/360},}
AddElement(compass_indicator)

--CHAFF
CHAFF_COUNTER_MASK			= create_mfd_tex(AAR_LDP_BLACK, 90, 27, 122, 178,1.3)
CHAFF_COUNTER_MASK.name				= create_guid_string()
CHAFF_COUNTER_MASK.init_pos			= {-0.7, 1.2}
CHAFF_COUNTER_MASK.h_clip_relation  = h_clip_relations.INCREASE_IF_LEVEL  
CHAFF_COUNTER_MASK.level			= MFD_DEFAULT_LEVEL  
CHAFF_COUNTER_MASK.isvisible		= false
CHAFF_COUNTER_MASK.parent_element	= DEF_PAGE.name

CHAFF_COUNTER_MASK.element_params 	= {"CHAF_TOGGLE"}
CHAFF_COUNTER_MASK.controllers   	= {{"parameter_compare_with_number",0, 1}}
AddElement2(CHAFF_COUNTER_MASK)


local CHAFF_COUNTER_FRAME				= create_mfd_tex(AAR_LDP_BLACK, 30, 20, 72, 185,1.3)
CHAFF_COUNTER_FRAME.name				= create_guid_string()
CHAFF_COUNTER_FRAME.init_pos			= {-0.7, 1.2}
CHAFF_COUNTER_FRAME.parent_element		= DEF_PAGE.name
CHAFF_COUNTER_FRAME.element_params 		= {"CHAF_TOGGLE"}
CHAFF_COUNTER_FRAME.controllers   		 = {{"parameter_compare_with_number",0, 1}}
AddElement(CHAFF_COUNTER_FRAME)

add_text_param(0.0, -0.135, "CHAFF_COUNT", "%0.0f", CHAFF_COUNTER_FRAME, mfd_strdefs_digit_XS, "Gripen_Font_black")


local CHAFF_COUNTER_BAR				= create_mfd_tex(AAR_LDP_BLACK, 90, 27, 122, 178,1.3)
CHAFF_COUNTER_BAR.name				= create_guid_string()
CHAFF_COUNTER_BAR.h_clip_relation   = h_clip_relations.DECREASE_IF_LEVEL
CHAFF_COUNTER_BAR.level				= MFD_DEFAULT_LEVEL + 1
CHAFF_COUNTER_BAR.init_pos			= {0, -0.182}
CHAFF_COUNTER_BAR.parent_element	= CHAFF_COUNTER_FRAME.name

CHAFF_COUNTER_BAR.element_params 	= {"CHAF_TOGGLE", "CHAFF_COUNT"}
CHAFF_COUNTER_BAR.controllers   	= {{"parameter_compare_with_number",0, 1}, {"move_up_down_using_parameter", 1, 0.00019}}
AddElement2(CHAFF_COUNTER_BAR)


local CHAFF_COUNTER_CH				= create_mfd_tex(AAR_LDP_BLACK, 200, 225, 275, 275,1.3) -- Letters "CH"
CHAFF_COUNTER_CH.name				= create_guid_string()
CHAFF_COUNTER_CH.init_pos			= {-0.7, 1.0}
CHAFF_COUNTER_CH.parent_element		= DEF_PAGE.name
CHAFF_COUNTER_CH.element_params 	= {"CHAF_TOGGLE"}
CHAFF_COUNTER_CH.controllers   		= {{"parameter_compare_with_number",0, 1}}
AddElement(CHAFF_COUNTER_CH)

--FLARES

FLARE_COUNTER_MASK			= create_mfd_tex(AAR_LDP_BLACK, 90, 27, 122, 178,1.3)
FLARE_COUNTER_MASK.name				= create_guid_string()
FLARE_COUNTER_MASK.init_pos			= {-0.8, 1.2}
FLARE_COUNTER_MASK.h_clip_relation  = h_clip_relations.INCREASE_IF_LEVEL  
FLARE_COUNTER_MASK.level			= MFD_DEFAULT_LEVEL  
FLARE_COUNTER_MASK.isvisible		= false
FLARE_COUNTER_MASK.parent_element	= DEF_PAGE.name

FLARE_COUNTER_MASK.element_params 	= {"FLAR_TOGGLE"}
FLARE_COUNTER_MASK.controllers   	= {{"parameter_compare_with_number",0, 1}}
AddElement2(FLARE_COUNTER_MASK)


local FLARE_COUNTER_FRAME				= create_mfd_tex(AAR_LDP_BLACK, 30, 20, 72, 185,1.3)
FLARE_COUNTER_FRAME.name				= create_guid_string()
FLARE_COUNTER_FRAME.init_pos			= {-0.8, 1.2}
FLARE_COUNTER_FRAME.parent_element		= DEF_PAGE.name
FLARE_COUNTER_FRAME.element_params 		= {"FLAR_TOGGLE"}
FLARE_COUNTER_FRAME.controllers   		 = {{"parameter_compare_with_number",0, 1}}
AddElement(FLARE_COUNTER_FRAME)

add_text_param(0.0, -0.135, "FLARE_COUNT", "%0.0f", FLARE_COUNTER_FRAME, mfd_strdefs_digit_XS, "Gripen_Font_black")


local FLARE_COUNTER_BAR				= create_mfd_tex(AAR_LDP_BLACK, 90, 27, 122, 178,1.3)
FLARE_COUNTER_BAR.name				= create_guid_string()
FLARE_COUNTER_BAR.h_clip_relation   = h_clip_relations.DECREASE_IF_LEVEL
FLARE_COUNTER_BAR.level				= MFD_DEFAULT_LEVEL + 1
FLARE_COUNTER_BAR.init_pos			= {0, -0.182}
FLARE_COUNTER_BAR.parent_element	= FLARE_COUNTER_FRAME.name

FLARE_COUNTER_BAR.element_params 	= {"FLAR_TOGGLE", "FLARE_COUNT"}
FLARE_COUNTER_BAR.controllers   	= {{"parameter_compare_with_number",0, 1}, {"move_up_down_using_parameter", 1, 0.00019*2}}
AddElement2(FLARE_COUNTER_BAR)


local FLARE_COUNTER_FL				= create_mfd_tex(AAR_LDP_BLACK, 24, 230, 98, 275,1.3) -- Letters "FL"
FLARE_COUNTER_FL.name				= create_guid_string()
FLARE_COUNTER_FL.init_pos			= {-0.8, 1.0}
FLARE_COUNTER_FL.parent_element		= DEF_PAGE.name
FLARE_COUNTER_FL.element_params 	= {"FLAR_TOGGLE"}
FLARE_COUNTER_FL.controllers   		= {{"parameter_compare_with_number",0, 1}}
AddElement(FLARE_COUNTER_FL)



--===================================================================================================================================================================================
--	[AAR] PAGE, fuel info etc
--===================================================================================================================================================================================
AAR_PAGE 			= CreateElement "ceSimple"
AAR_PAGE.init_pos	= {0,0}
AAR_PAGE.name		= create_guid_string()
AAR_PAGE.parent_element	= TAN_LD_MASTER.name
AAR_PAGE.element_params = {"LD_UPPER"}
AAR_PAGE.controllers    = {{"parameter_compare_with_number",0, 3}}
AddElement(AAR_PAGE)


local fuel_percent		= create_mfd_tex_3k(MFD_ELEMENTS_PDD,1724, 0, 2240, 512, 2.25 )
fuel_percent.name			= create_guid_string()
fuel_percent.init_pos		= {-0.5, 0.925}
fuel_percent.parent_element	= AAR_PAGE.name
AddElement(fuel_percent)

add_text_param(-0.002, 0, "FUEL", "%0.0f", fuel_percent, mfd_strdefs_digit_Large, "Gripen_Font_black")	-- Print fuel state in %, rounded to 0 decimals, using large numbers


local FLOW			= create_mfd_tex(AAR_LDP_WHITE_COLOR, 1680, 10, 2045  , 115,1) 
FLOW.name			= create_guid_string()
FLOW.init_pos		= {0.5, 0.86}
FLOW.parent_element	= AAR_PAGE.name
FLOW.element_params = {"LD_BRIGHTNESS", "NORM_MODE", "FUEL_FLOW"}
FLOW.controllers    = {JAS_Bright[1],JAS_Bright[2],JAS_Bright[3],JAS_Bright[4],JAS_Bright[5],JAS_Bright[6],JAS_Bright[7],JAS_Bright[8],JAS_Bright[9],JAS_Bright[10],JAS_Bright[11],JAS_Bright[12],JAS_Bright[13],JAS_Bright[14],JAS_Bright[15], JAS_Bright[16],JAS_Bright[17],JAS_Bright[18],JAS_Bright[19],JAS_Bright[20], {"parameter_compare_with_number",1, 2}, {"parameter_compare_with_number",2, 1}}
AddElement(FLOW)



local NO_FLOW			= create_mfd_tex(AAR_LDP_WHITE_COLOR, 1680, 120, 2045  , 220,1) 
NO_FLOW.name			= create_guid_string()
NO_FLOW.init_pos		= {0.5, 0.86}
NO_FLOW.parent_element	= AAR_PAGE.name
NO_FLOW.element_params = {"LD_BRIGHTNESS", "NORM_MODE", "FUEL_FLOW"}
NO_FLOW.controllers    = {JAS_Bright[1],JAS_Bright[2],JAS_Bright[3],JAS_Bright[4],JAS_Bright[5],JAS_Bright[6],JAS_Bright[7],JAS_Bright[8],JAS_Bright[9],JAS_Bright[10],JAS_Bright[11],JAS_Bright[12],JAS_Bright[13],JAS_Bright[14],JAS_Bright[15], JAS_Bright[16],JAS_Bright[17],JAS_Bright[18],JAS_Bright[19],JAS_Bright[20],{"parameter_compare_with_number",1, 2}, {"parameter_compare_with_number",2, 0}}
AddElement(NO_FLOW)	

local TO_FILL			= create_mfd_tex(AAR_LDP_BLACK, 1180, 370, 1850  , 480 ,1) 
TO_FILL.name			= create_guid_string()
TO_FILL.init_pos		= {-0.23, 0.35}
TO_FILL.parent_element	= AAR_PAGE.name
AddElement(TO_FILL)

local CONTENTS			= create_mfd_tex(AAR_LDP_BLACK, 1180, 481, 1850  , 610 ,1) 
CONTENTS.name			= create_guid_string()
CONTENTS.init_pos		= {-0.235, 0.175}
CONTENTS.parent_element	= AAR_PAGE.name
AddElement(CONTENTS)





local STATUS			= create_mfd_tex(AAR_LDP_BLACK, 1180, 5, 1687  , 125 ,1)  
STATUS.name				= create_guid_string()
STATUS.init_pos			= {0.5, 1.135}
STATUS.parent_element	= AAR_PAGE.name
AddElement(STATUS)

local REFUEL			= create_mfd_tex(AAR_LDP_BLACK, 1180, 126, 1687  , 245 ,1)  
REFUEL.name				= create_guid_string()
REFUEL.init_pos			= {0.51, 1}
REFUEL.parent_element	= AAR_PAGE.name
REFUEL.element_params = {"NORM_MODE"}
REFUEL.controllers    = {{"parameter_compare_with_number",0, 2}}
AddElement(REFUEL)

local NORMAL			= create_mfd_tex(AAR_LDP_BLACK, 1180, 247, 1687 , 360 , 1)  
NORMAL.name				= create_guid_string()
NORMAL.init_pos			= {0.51, 1}
NORMAL.parent_element	= AAR_PAGE.name
NORMAL.element_params = {"NORM_MODE"}
NORMAL.controllers    = {{"parameter_compare_with_number",0, 1}}
AddElement(NORMAL)



local KG_LARGE				= create_mfd_tex(AAR_LDP_BLACK, 1880, 225, 2040 , 330 , 1)  
KG_LARGE.name					= create_guid_string()
KG_LARGE.init_pos				= {0.6, 0.35}
KG_LARGE.parent_element		= AAR_PAGE.name
KG_LARGE.element_params 		= {"UNIT_MODE"}
KG_LARGE.controllers   		= {{"parameter_compare_with_number",0, 4}}
AddElement(KG_LARGE)

local KG_LARGE_2				= create_mfd_tex(AAR_LDP_BLACK, 1880, 225, 2040 , 330 , 1)  
KG_LARGE_2.name					= create_guid_string()
KG_LARGE_2.init_pos				= {0.6, 0.175}
KG_LARGE_2.parent_element		= AAR_PAGE.name
KG_LARGE_2.element_params 		= {"UNIT_MODE"}
KG_LARGE_2.controllers   		= {{"parameter_compare_with_number",0, 4}}
AddElement(KG_LARGE_2)

local LB_LARGE					= create_mfd_tex(AAR_LDP_BLACK, 1880, 335, 2040 , 445 , 1)  
LB_LARGE.name					= create_guid_string()
LB_LARGE.init_pos				= {0.6, 0.35}
LB_LARGE.parent_element			= AAR_PAGE.name
LB_LARGE.element_params 		= {"UNIT_MODE"}
LB_LARGE.controllers   			= {{"parameter_compare_with_number",0, 3}}
AddElement(LB_LARGE)

local LB_LARGE_2					= create_mfd_tex(AAR_LDP_BLACK, 1880, 335, 2040 , 445 , 1)  
LB_LARGE_2.name						= create_guid_string()
LB_LARGE_2.init_pos					= {0.6, 0.175}
LB_LARGE_2.parent_element			= AAR_PAGE.name
LB_LARGE_2.element_params 			= {"UNIT_MODE"}
LB_LARGE_2.controllers   			= {{"parameter_compare_with_number",0, 3}}
AddElement(LB_LARGE_2)

local L_LARGE				= create_mfd_tex(AAR_LDP_BLACK, 1880, 446, 2040 , 555 , 1)  
L_LARGE.name				= create_guid_string()
L_LARGE.init_pos			= {0.6, 0.35}
L_LARGE.parent_element	= AAR_PAGE.name
L_LARGE.element_params 	= {"UNIT_MODE"}
L_LARGE.controllers   	= {{"parameter_compare_with_number",0, 2}}
AddElement(L_LARGE)

local L_LARGE_2				= create_mfd_tex(AAR_LDP_BLACK, 1880, 446, 2040 , 555 , 1)  
L_LARGE_2.name				= create_guid_string()
L_LARGE_2.init_pos			= {0.6, 0.175}
L_LARGE_2.parent_element		= AAR_PAGE.name
L_LARGE_2.element_params 		= {"UNIT_MODE"}
L_LARGE_2.controllers   		= {{"parameter_compare_with_number",0, 2}}
AddElement(L_LARGE_2)

local PCT_LARGE					= create_mfd_tex(AAR_LDP_BLACK, 1880, 560, 2040 , 660 , 1)  
PCT_LARGE.name					= create_guid_string()
PCT_LARGE.init_pos				= {0.6, 0.35}
PCT_LARGE.parent_element		= AAR_PAGE.name
PCT_LARGE.element_params 		= {"UNIT_MODE"}
PCT_LARGE.controllers   		= {{"parameter_compare_with_number",0, 1}}
AddElement(PCT_LARGE)

local PCT_LARGE_2					= create_mfd_tex(AAR_LDP_BLACK, 1880, 560, 2040 , 660 , 1)  
PCT_LARGE_2.name					= create_guid_string()
PCT_LARGE_2.init_pos				= {0.6, 0.175}
PCT_LARGE_2.parent_element			= AAR_PAGE.name
PCT_LARGE_2.element_params 			= {"UNIT_MODE"}
PCT_LARGE_2.controllers   			= {{"parameter_compare_with_number",0, 1}}
AddElement(PCT_LARGE_2)

add_text_param(0.55, 0, "FUEL_TO_FILL", "%0.0f", TO_FILL, mfd_strdefs_digit_Large, "Gripen_Font_black")

add_text_param(0.55, 0, "FUEL_CONTENTS", "%0.0f", CONTENTS, mfd_strdefs_digit_Large, "Gripen_Font_black")


--add_text("REFUEL", 0.5, 1, AAR_PAGE , "Gripen_Font_black", mfd_strdefs_digit_Large, "CenterCenter")
--===================================================================================================================================================================================
--	[LDP] PAGE, litening pod
--===================================================================================================================================================================================
LDP_PAGE 			= CreateElement "ceSimple"
LDP_PAGE.init_pos	= {0,0}
LDP_PAGE.name		= create_guid_string()
LDP_PAGE.parent_element	= TAN_LD_MASTER.name
LDP_PAGE.element_params = {"LD_UPPER"}
LDP_PAGE.controllers    = {{"parameter_compare_with_number",0, 4}}
AddElement(LDP_PAGE)

local SYMB_XHAIR				= create_mfd_tex(AAR_LDP_WHITE_COLOR, 20, 1340, 720 , 2030, 1.33) 	
SYMB_XHAIR.name					= create_guid_string()
SYMB_XHAIR.init_pos				= {0.014, 0.570, 0.05}
SYMB_XHAIR.parent_element		= TAN_LD_MASTER.name
SYMB_XHAIR.h_clip_relation    	= h_clip_relations.REWRITE_LEVEL
SYMB_XHAIR.level				= MFD_DEFAULT_LEVEL
SYMB_XHAIR.element_params 		= {"LD_BRIGHTNESS", "SYMB_TOGGLE", "SRCH_TRCK_MODE","LD_UPPER"}
SYMB_XHAIR.controllers   		= {JAS_Bright[1],JAS_Bright[2],JAS_Bright[3],JAS_Bright[4],JAS_Bright[5],JAS_Bright[6],JAS_Bright[7],JAS_Bright[8],JAS_Bright[9],JAS_Bright[10],JAS_Bright[11],JAS_Bright[12],JAS_Bright[13],JAS_Bright[14],JAS_Bright[15], JAS_Bright[16],JAS_Bright[17],JAS_Bright[18],JAS_Bright[19],JAS_Bright[20],{"parameter_compare_with_number",1, 1}, {"parameter_compare_with_number",2, 1},{"parameter_compare_with_number",3, 4}}
AddElement2(SYMB_XHAIR)

local SYMB_XHAIR_SMALL				= create_mfd_tex(AAR_LDP_WHITE_COLOR, 20, 1340, 720 , 2030, 0.5) 	
SYMB_XHAIR_SMALL.name				= create_guid_string()
SYMB_XHAIR_SMALL.init_pos			= {0.014, 0.570,0.05}
SYMB_XHAIR_SMALL.parent_element		= TAN_LD_MASTER.name
SYMB_XHAIR_SMALL.h_clip_relation    = h_clip_relations.REWRITE_LEVEL
SYMB_XHAIR_SMALL.level				= MFD_DEFAULT_LEVEL
SYMB_XHAIR_SMALL.element_params 	= {"LD_BRIGHTNESS", "SYMB_TOGGLE", "SRCH_TRCK_MODE","LD_UPPER"}
SYMB_XHAIR_SMALL.controllers   		= {JAS_Bright[1],JAS_Bright[2],JAS_Bright[3],JAS_Bright[4],JAS_Bright[5],JAS_Bright[6],JAS_Bright[7],JAS_Bright[8],JAS_Bright[9],JAS_Bright[10],JAS_Bright[11],JAS_Bright[12],JAS_Bright[13],JAS_Bright[14],JAS_Bright[15], JAS_Bright[16],JAS_Bright[17],JAS_Bright[18],JAS_Bright[19],JAS_Bright[20],{"parameter_compare_with_number",1, 1}, {"parameter_compare_with_number",2, 2},{"parameter_compare_with_number",3, 4}}
AddElement2(SYMB_XHAIR_SMALL)

local FLIR_HOT				= create_mfd_tex(AAR_LDP_BLACK, 270, 1220, 570 , 1268, 1.25) 	
FLIR_HOT.name				= create_guid_string()
FLIR_HOT.init_pos			= {0.0225, 1.29,}
FLIR_HOT.parent_element		= TAN_LD_MASTER.name
FLIR_HOT.element_params 	= {"WHOT_TOGGLE"}
FLIR_HOT.controllers   		= {{"parameter_compare_with_number",0, 1}}
AddElement(FLIR_HOT)

local M_LASER				= create_mfd_tex(AAR_LDP_WHITE_COLOR, 10, 1225, 210 , 1275, 1.25) 	
M_LASER.name				= create_guid_string()
M_LASER.init_pos			= {-0.4, 0.15,}
M_LASER.parent_element		= TAN_LD_MASTER.name
M_LASER.element_params 		= {"LD_BRIGHTNESS", "MLAS_TOGGLE", "LD_UPPER"}
M_LASER.controllers   		= {JAS_Bright[1],JAS_Bright[2],JAS_Bright[3],JAS_Bright[4],JAS_Bright[5],JAS_Bright[6],JAS_Bright[7],JAS_Bright[8],JAS_Bright[9],JAS_Bright[10],JAS_Bright[11],JAS_Bright[12],JAS_Bright[13],JAS_Bright[14],JAS_Bright[15], JAS_Bright[16],JAS_Bright[17],JAS_Bright[18],JAS_Bright[19],JAS_Bright[20],{"parameter_compare_with_number",1, 1},{"parameter_compare_with_number",2, 4}}
AddElement(M_LASER)

local LDP_Background 				= create_mfd_tex(LDP_BACKGROUND, 30, 5, 1255 , 1085, 1.569)
LDP_Background.name 				= create_guid_string()
LDP_Background.init_pos				= {0.0155, 0.5555, 0.025 }
LDP_Background.parent_element		= LDP_PAGE.name
LDP_Background.h_clip_relation 		= h_clip_relations.NULL
LDP_Background.level				= MFD_DEFAULT_LEVEL
LDP_Background.element_params 		= {"BOST_TOGGLE"}
LDP_Background.controllers   		= {{"parameter_compare_with_number",0, 0} }
LDP_Background.change_opacity		= false
LDP_Background.collimated 			= false
LDP_Background.isvisible			= true
Add(LDP_Background)


local LDP_Background_Boost 					= create_mfd_tex(CENTER_DISPLAY_COLOR, 30, 5, 1255 , 1085, 1.569)
LDP_Background_Boost.name 					= create_guid_string()
LDP_Background_Boost.init_pos				= {0.0155, 0.5555, 0.025 }
LDP_Background_Boost.parent_element			= LDP_PAGE.name
LDP_Background_Boost.h_clip_relation 		= h_clip_relations.NULL
LDP_Background_Boost.level					= MFD_DEFAULT_LEVEL
LDP_Background_Boost.element_params 		= {"LD_BRIGHTNESS","BOST_TOGGLE"}
LDP_Background_Boost.controllers   			= {JAS_Bright[1],JAS_Bright[2],JAS_Bright[3],JAS_Bright[4],JAS_Bright[5],JAS_Bright[6],JAS_Bright[7],JAS_Bright[8],JAS_Bright[9],JAS_Bright[10],JAS_Bright[11],JAS_Bright[12],JAS_Bright[13],JAS_Bright[14],JAS_Bright[15], JAS_Bright[16],JAS_Bright[17],JAS_Bright[18],JAS_Bright[19],JAS_Bright[20],{"parameter_compare_with_number",1, 1} }
LDP_Background_Boost.change_opacity			= false
LDP_Background_Boost.collimated 			= false
LDP_Background_Boost.isvisible				= true
Add(LDP_Background_Boost)



--===================================================================================================================================================================================

--Auto throttle on/off indicator

local Auto_throttle_ind = add_text("AT", -0.92, 1.33, TAN_LD_MASTER , "Gripen_Font_black", MFD_strdefs_text, "CenterCenter")
Auto_throttle_ind.element_params  = {"AUTOTHROTTLE_ONOFF"}
Auto_throttle_ind.controllers     = {{"parameter_in_range" ,0,0.9,1.1}  }
--Auto throttle mode 12 AoA
local Auto_throttle_mode12 = add_text("12", -0.82, 1.33, TAN_LD_MASTER , "Gripen_Font_black", MFD_strdefs_text, "CenterCenter")
Auto_throttle_mode12.element_params  = {"AUTOTHROTTLE_MODE"}
Auto_throttle_mode12.controllers     = {{"parameter_in_range" ,0,0.4,0.6} }
--Auto throttle mode 14 AoA
local Auto_throttle_mode14 = add_text("14", -0.82, 1.33, TAN_LD_MASTER , "Gripen_Font_black", MFD_strdefs_text, "CenterCenter")
Auto_throttle_mode14.element_params  = {"AUTOTHROTTLE_MODE"}
Auto_throttle_mode14.controllers     = {{"parameter_in_range" ,0,0.9,1.1} }

local xcor = 0.022


-- all pages
local EMGY			= create_mfd_tex(LD_LABLES, 0, 1270, 125 , 1700,FONT_SIZE) 
EMGY.name			= create_guid_string()
EMGY.init_pos		= {-0.967+xcor, 1.15}
EMGY.parent_element	= TAN_LD_MASTER.name
AddElement(EMGY)	

local CURS			= create_mfd_tex(LD_LABLES, 320, 1270, 400 , 1700,FONT_SIZE) 
CURS.name			= create_guid_string()
CURS.init_pos		= {-0.97+xcor, -0.30}
CURS.parent_element	= TAN_LD_MASTER.name
AddElement(CURS)

--[[
local CURS_BOX			= create_mfd_tex(NAV_WHEEL_BLACK, 1950, 215, 2042 , 646, FONT_SIZE) 	-- 4 Letter box
CURS_BOX.name				= create_guid_string()
CURS_BOX.init_pos			= {-0.97, -0.3075}
CURS_BOX.parent_element		= TAN_LD_MASTER.name
CURS_BOX.element_params 	= {"CURSOR_TOGGLE"}
CURS_BOX.controllers   		= {{"parameter_compare_with_number",0, 1}}
AddElement(CURS_BOX)
--]]

local MENU			= create_mfd_tex(LD_LABLES, 425, 1630, 500 , 2030,FONT_SIZE) 
MENU.name			= create_guid_string()
MENU.init_pos		= {-0.97+xcor, -0.60}
MENU.parent_element	= TAN_LD_MASTER.name
AddElement(MENU)

local MENU_GEN			= create_mfd_tex(NAV_WHEEL_BLACK, 445, 1465, 545 , 1805,FONT_SIZE) 
MENU_GEN.name			= create_guid_string()
MENU_GEN.init_pos		= {-0.92+xcor, -0.58}
MENU_GEN.parent_element	= GEN_PAGE.name
AddElement(MENU_GEN)

local MENU_DEF			= create_mfd_tex(NAV_WHEEL_BLACK, 555, 1465, 655 , 1805,FONT_SIZE) 
MENU_DEF.name			= create_guid_string()
MENU_DEF.init_pos		= {-0.92+xcor, -0.58}
MENU_DEF.parent_element	= DEF_PAGE.name
AddElement(MENU_DEF)

local MENU_AAR			= create_mfd_tex(NAV_WHEEL_BLACK, 445, 1110, 545 , 1458,FONT_SIZE) 
MENU_AAR.name			= create_guid_string()
MENU_AAR.init_pos		= {-0.92+xcor, -0.5744}
MENU_AAR.parent_element	= AAR_PAGE.name
AddElement(MENU_AAR)

local MENU_LDP			= create_mfd_tex(NAV_WHEEL_BLACK, 555, 1110, 655 , 1460,FONT_SIZE) 
MENU_LDP.name			= create_guid_string()
MENU_LDP.init_pos		= {-0.92+xcor, -0.58}
MENU_LDP.parent_element	= LDP_PAGE.name
AddElement(MENU_LDP)

local AD			= create_mfd_tex(LD_LABLES, 225, 1725, 305 , 1915, FONT_SIZE) 
AD.name				= create_guid_string()
AD.init_pos			= {0.96-xcor, -0.60}
AD.parent_element	= TAN_LD_MASTER.name
AddElement(AD)

local AD_BOX			= create_mfd_tex(NAV_WHEEL_BLACK, 1745, 215, 1840 , 443, FONT_SIZE) 	-- 2 Letter box
AD_BOX.name				= create_guid_string()
AD_BOX.init_pos			= {0.9635-0.024, -0.60}
AD_BOX.parent_element		= TAN_LD_MASTER.name
AD_BOX.element_params 	= {"ALTITUDE_MODE"}
AD_BOX.controllers   		= {{"parameter_compare_with_number",0, 1}}
AddElement(AD_BOX)

local RALT			= create_mfd_tex(LD_LABLES, 540, 1630, 608 , 2025, FONT_SIZE) 
RALT.name				= create_guid_string()
RALT.init_pos			= {0.915-xcor, -0.66}
RALT.parent_element	= TAN_LD_MASTER.name
AddElement(RALT)

local RALT_BOX			= create_mfd_tex(NAV_WHEEL_BLACK, 1950, 215, 2042 , 646, FONT_SIZE) 	-- 4 Letter box
RALT_BOX.name				= create_guid_string()
RALT_BOX.init_pos			= {0.9140-0.025, -0.66}
RALT_BOX.parent_element		= TAN_LD_MASTER.name
RALT_BOX.element_params 	= {"ALTITUDE_MODE"}
RALT_BOX.controllers   		= {{"parameter_compare_with_number",0, 2}}
AddElement(RALT_BOX)


local GME			= create_mfd_tex(LD_LABLES, 425, 1295, 500 , 1592, FONT_SIZE) 
GME.name				= create_guid_string()
GME.init_pos			= {0.9592-xcor, -0.32}
GME.parent_element	= TAN_LD_MASTER.name
AddElement(GME)

local G_BOX				= create_mfd_tex(NAV_WHEEL_BLACK, 1650, 215, 1742 , 335, FONT_SIZE) 	-- 1 Letter box
G_BOX.name				= create_guid_string()
G_BOX.init_pos			= {0.958-xcor, -0.26}
G_BOX.parent_element	= TAN_LD_MASTER.name
G_BOX.element_params 	= {"LD_LOWER"}
G_BOX.controllers   		= {{"parameter_compare_with_number",0, 1}}
AddElement(G_BOX)

local M_BOX				= create_mfd_tex(NAV_WHEEL_BLACK, 1650, 215, 1742 , 335, FONT_SIZE) 	-- 1 Letter box
M_BOX.name				= create_guid_string()
M_BOX.init_pos			= {0.958-xcor, -0.322}
M_BOX.parent_element	= TAN_LD_MASTER.name
M_BOX.element_params 	= {"LD_LOWER"}
M_BOX.controllers   		= {{"parameter_compare_with_number",0, 2}}
AddElement(M_BOX)

local E_BOX				= create_mfd_tex(NAV_WHEEL_BLACK, 1650, 215, 1742 , 335, FONT_SIZE) 	-- 1 Letter box
E_BOX.name				= create_guid_string()
E_BOX.init_pos			= {0.958-xcor, -0.3825}
E_BOX.parent_element	= TAN_LD_MASTER.name
E_BOX.element_params 	= {"LD_LOWER"}
E_BOX.controllers   	= {{"parameter_compare_with_number",0, 3}}
AddElement(E_BOX)

local STOR			= create_mfd_tex(LD_LABLES, 638, 1630, 708 , 2025, FONT_SIZE) 
STOR.name				= create_guid_string()
STOR.init_pos			= {0.96-xcor, -0.04}
STOR.parent_element	= TAN_LD_MASTER.name
AddElement(STOR)

local STOR_BOX			= create_mfd_tex(NAV_WHEEL_BLACK, 1950, 215, 2042 , 646, FONT_SIZE) 
STOR_BOX.name				= create_guid_string()
STOR_BOX.init_pos			= {0.957-xcor, -0.04}
STOR_BOX.parent_element	= TAN_LD_MASTER.name
STOR_BOX.element_params = {"STORES_TOGGLE"}
STOR_BOX.controllers    = {{"parameter_compare_with_number",0, 1}}
AddElement(STOR_BOX)


-- GEN PAGE BUTTON LABLES
local HUD			= create_mfd_tex(LD_LABLES, 0, 1730, 110 , 2025,FONT_SIZE) 
HUD.name			= create_guid_string()
HUD.init_pos		= {-0.97+xcor, 0.84}
HUD.parent_element	= GEN_PAGE.name
AddElement(HUD)	

--[[
local HUD_BOX			= create_mfd_tex(NAV_WHEEL_BLACK, 1850, 215, 1945 , 555,FONT_SIZE) 
HUD_BOX.name			= create_guid_string()
HUD_BOX.init_pos		= {-0.97, 0.84}
HUD_BOX.parent_element	= GEN_PAGE.name
HUD_BOX.element_params = {"HUD_ON_MFD_TOGGLE"}
HUD_BOX.controllers    = {{"parameter_compare_with_number",0, 1}}
AddElement(HUD_BOX)
--]]

local CAB			= create_mfd_tex(LD_LABLES, 120, 1270, 210 , 1590,FONT_SIZE) 
CAB.name			= create_guid_string()
CAB.init_pos		= {-0.97+xcor, 0.56}
CAB.parent_element	= GEN_PAGE.name
AddElement(CAB)	

local CAB_BOX			= create_mfd_tex(NAV_WHEEL_BLACK, 1850, 215, 1945 , 555,FONT_SIZE) 
CAB_BOX.name			= create_guid_string()
CAB_BOX.init_pos		= {-0.9675+xcor, 0.55}
CAB_BOX.parent_element	= GEN_PAGE.name
CAB_BOX.element_params = {"CABIN_TOGGLE"}
CAB_BOX.controllers    = {{"parameter_compare_with_number",0, 1}}
AddElement(CAB_BOX)


local EPE			= create_mfd_tex(LD_LABLES, 120, 1730, 210 , 2025,FONT_SIZE) 
EPE.name			= create_guid_string()
EPE.init_pos		= {-0.97+xcor, 0.26}
EPE.parent_element	= GEN_PAGE.name	
AddElement(EPE)	

local EPE_BOX			= create_mfd_tex(NAV_WHEEL_BLACK, 1850, 215, 1945 , 555,FONT_SIZE) 
EPE_BOX.name			= create_guid_string()
EPE_BOX.init_pos		= {-0.9675+xcor, 0.26}
EPE_BOX.parent_element	= GEN_PAGE.name
EPE_BOX.element_params = {"EPERROR_TOGGLE"}
EPE_BOX.controllers    = {{"parameter_compare_with_number",0, 1}}
AddElement(EPE_BOX)

local ECON			= create_mfd_tex(LD_LABLES, 225, 1270, 300 , 1700,FONT_SIZE) 
ECON.name			= create_guid_string()
ECON.init_pos		= {-0.97+xcor, -0.03}
ECON.parent_element	= GEN_PAGE.name	
AddElement(ECON)

local ECON_BOX			= create_mfd_tex(NAV_WHEEL_BLACK, 1950, 215, 2042 , 646, FONT_SIZE) 
ECON_BOX.name				= create_guid_string()
ECON_BOX.init_pos			= {-0.97+xcor, -0.035}
ECON_BOX.parent_element	= GEN_PAGE.name	
ECON_BOX.element_params = {"ECON_TOGGLE"}
ECON_BOX.controllers    = {{"parameter_compare_with_number",0, 1}}
AddElement(ECON_BOX)	

local TRUE			= create_mfd_tex(LD_LABLES, 850, 1635, 925 , 2025, FONT_SIZE) 
TRUE.name				= create_guid_string()
TRUE.init_pos			= {0.96-0.01, 1.1}
TRUE.parent_element	= GEN_PAGE.name
AddElement(TRUE)

local TRUE_BOX			= create_mfd_tex(NAV_WHEEL_BLACK, 1950, 215, 2042 , 646, FONT_SIZE) 
TRUE_BOX.name				= create_guid_string()
TRUE_BOX.init_pos			= {0.9575-0.0115, 1.102}
TRUE_BOX.parent_element	= GEN_PAGE.name	
TRUE_BOX.element_params = {"HEADING_MODE"}
TRUE_BOX.controllers    = {{"parameter_compare_with_number",0, 1}}
AddElement(TRUE_BOX)

local MAG			= create_mfd_tex(LD_LABLES, 535, 1295, 605 , 1594, FONT_SIZE) 
MAG.name				= create_guid_string()
MAG.init_pos			= {0.91-0.01, 1.125}
MAG.parent_element	= GEN_PAGE.name
AddElement(MAG)

local MAG_BOX			= create_mfd_tex(NAV_WHEEL_BLACK, 1850, 215, 1945 , 555,FONT_SIZE) 
MAG_BOX.name			= create_guid_string()
MAG_BOX.init_pos		= {0.912-0.0125, 1.125}
MAG_BOX.parent_element	= GEN_PAGE.name
MAG_BOX.element_params = {"HEADING_MODE"}
MAG_BOX.controllers    = {{"parameter_compare_with_number",0, 2}}
AddElement(MAG_BOX)


-- DEF PAGE BUTTON LABLES
local EWS			= create_mfd_tex(LD_LABLES, 760, 1300, 840 , 1593,FONT_SIZE) 
EWS.name			= create_guid_string()
EWS.init_pos		= {-0.97+xcor, 0.84}
EWS.parent_element	= DEF_PAGE.name
AddElement(EWS)

local AS			= create_mfd_tex(LD_LABLES, 646, 1305, 732 , 1495,FONT_SIZE) 
AS.name			= create_guid_string()
AS.init_pos		= {-0.92+xcor, 0.865}
AS.parent_element	= DEF_PAGE.name
AddElement(AS)

--[[
local A_BOX				= create_mfd_tex(NAV_WHEEL_BLACK, 1650, 215, 1742 , 335, FONT_SIZE) 	-- 1 Letter box
A_BOX.name				= create_guid_string()
A_BOX.init_pos			= {-0.923, 0.8975}
A_BOX.parent_element	= DEF_PAGE.name
A_BOX.element_params 	= {"EWS_MODE"}
A_BOX.controllers   	= {{"parameter_compare_with_number",0, 2}}
AddElement(A_BOX)

local S_BOX				= create_mfd_tex(NAV_WHEEL_BLACK, 1650, 215, 1742 , 335, FONT_SIZE) 	-- 1 Letter box
S_BOX.name				= create_guid_string()
S_BOX.init_pos			= {-0.923, 0.83775}
S_BOX.parent_element	= DEF_PAGE.name
S_BOX.element_params 	= {"EWS_MODE"}
S_BOX.controllers   	= {{"parameter_compare_with_number",0, 1}}
AddElement(S_BOX)
--]]

local FLAR			= create_mfd_tex(LD_LABLES, 957, 1640, 1020 , 2025,FONT_SIZE) 
FLAR.name			= create_guid_string()
FLAR.init_pos		= {-0.97+xcor, 0.56}
FLAR.parent_element	= DEF_PAGE.name
AddElement(FLAR)

local FLAR_OFF			= create_mfd_tex(NAV_WHEEL_BLACK, 1220, 650, 1445 , 743 ,FONT_SIZE) 
FLAR_OFF.name			= create_guid_string()
FLAR_OFF.init_pos		= {-0.878+xcor, 0.54}
FLAR_OFF.parent_element	= DEF_PAGE.name
AddElement(FLAR_OFF)

local FLAR_OFF_BOX				= create_mfd_tex(NAV_WHEEL_BLACK, 1590, 650, 1860 , 770, FONT_SIZE) 	-- 3  Letter horizontal box
FLAR_OFF_BOX.name				= create_guid_string()
FLAR_OFF_BOX.init_pos			= {-0.8773+xcor, 0.54}
FLAR_OFF_BOX.parent_element	= DEF_PAGE.name
FLAR_OFF_BOX.element_params 	= {"FLAR_TOGGLE"}
FLAR_OFF_BOX.controllers   	= {{"parameter_compare_with_number",0, 0}}
AddElement(FLAR_OFF_BOX)

local FLAR_ON			= create_mfd_tex(NAV_WHEEL_BLACK, 1225, 750, 1370 , 850 ,FONT_SIZE) 
FLAR_ON.name			= create_guid_string()
FLAR_ON.init_pos		= {-0.903+xcor, 0.60}
FLAR_ON.parent_element	= DEF_PAGE.name
AddElement(FLAR_ON)

local FLAR_ON_BOX				= create_mfd_tex(NAV_WHEEL_BLACK, 1861, 650, 2045 , 770, FONT_SIZE) 	-- 2  Letter horizontal box
FLAR_ON_BOX.name				= create_guid_string()
FLAR_ON_BOX.init_pos			= {-0.900+xcor, 0.6025}
FLAR_ON_BOX.parent_element		= DEF_PAGE.name
FLAR_ON_BOX.element_params 		= {"FLAR_TOGGLE"}
FLAR_ON_BOX.controllers   		= {{"parameter_compare_with_number",0, 1}}
AddElement(FLAR_ON_BOX)

local CHAF			= create_mfd_tex(LD_LABLES, 1044, 1640, 1120 , 2025,FONT_SIZE) 
CHAF.name			= create_guid_string()
CHAF.init_pos		= {-0.97+xcor, 0.26}
CHAF.parent_element	= DEF_PAGE.name
AddElement(CHAF)

local CHAF_OFF			= create_mfd_tex(NAV_WHEEL_BLACK, 1220, 650, 1445 , 743 ,FONT_SIZE) 
CHAF_OFF.name			= create_guid_string()
CHAF_OFF.init_pos		= {-0.88+xcor, 0.24}
CHAF_OFF.parent_element	= DEF_PAGE.name
AddElement(CHAF_OFF)

local CHAF_OFF_BOX				= create_mfd_tex(NAV_WHEEL_BLACK, 1590, 650, 1860 , 770, FONT_SIZE) 	-- 3  Letter horizontal box
CHAF_OFF_BOX.name				= create_guid_string()
CHAF_OFF_BOX.init_pos			= {-0.8773+xcor, 0.24}
CHAF_OFF_BOX.parent_element		= DEF_PAGE.name
CHAF_OFF_BOX.element_params 	= {"CHAF_TOGGLE"}
CHAF_OFF_BOX.controllers   		= {{"parameter_compare_with_number",0, 0}}
AddElement(CHAF_OFF_BOX)

local CHAF_ON			= create_mfd_tex(NAV_WHEEL_BLACK, 1225, 750, 1370 , 850 ,FONT_SIZE) 
CHAF_ON.name			= create_guid_string()
CHAF_ON.init_pos		= {-0.902+xcor, 0.30}
CHAF_ON.parent_element	= DEF_PAGE.name
AddElement(CHAF_ON)

local CHAF_ON_BOX				= create_mfd_tex(NAV_WHEEL_BLACK, 1861, 650, 2045 , 770, FONT_SIZE) 	-- 2  Letter horizontal box
CHAF_ON_BOX.name				= create_guid_string()
CHAF_ON_BOX.init_pos			= {-0.900+xcor, 0.3025}
CHAF_ON_BOX.parent_element		= DEF_PAGE.name
CHAF_ON_BOX.element_params 		= {"CHAF_TOGGLE"}
CHAF_ON_BOX.controllers   		= {{"parameter_compare_with_number",0, 1}}
AddElement(CHAF_ON_BOX)

local SCAL			= create_mfd_tex(LD_LABLES, 1155, 1300, 1225 , 1700 ,FONT_SIZE) 
SCAL.name			= create_guid_string()
SCAL.init_pos		= {-0.97+xcor, -0.02}
SCAL.parent_element	= DEF_PAGE.name
AddElement(SCAL)

-- 	TODO SCALES


-- AAR PAGE BUTTON LABLES

local NORM			= create_mfd_tex(NAV_WHEEL_BLACK, 1025, 10, 1130 , 400 ,FONT_SIZE) 
NORM.name			= create_guid_string()
NORM.init_pos		= {-0.97+xcor, 0.26}
NORM.parent_element	= AAR_PAGE.name
AddElement(NORM)

local NORM_BOX				= create_mfd_tex(NAV_WHEEL_BLACK, 1950, 215, 2042 , 646, FONT_SIZE) 
NORM_BOX.name				= create_guid_string()
NORM_BOX.init_pos			= {-0.965+xcor, 0.2575}
NORM_BOX.parent_element		= AAR_PAGE.name	
NORM_BOX.element_params 	= {"NORM_MODE"}
NORM_BOX.controllers    	= {{"parameter_compare_with_number",0, 1}}
AddElement(NORM_BOX)

local REF			= create_mfd_tex(NAV_WHEEL_BLACK, 1125, 10, 1225 , 302 ,FONT_SIZE) 
REF.name			= create_guid_string()
REF.init_pos		= {-0.91+xcor, 0.29}
REF.parent_element	= AAR_PAGE.name
AddElement(REF)

local REF_BOX			= create_mfd_tex(NAV_WHEEL_BLACK, 1850, 215, 1945 , 555,FONT_SIZE) 
REF_BOX.name			= create_guid_string()
REF_BOX.init_pos		= {-0.91+xcor, 0.2875}
REF_BOX.parent_element	= AAR_PAGE.name
REF_BOX.element_params = {"NORM_MODE"}
REF_BOX.controllers    = {{"parameter_compare_with_number",0, 2}}
AddElement(REF_BOX)

local UNIT				= create_mfd_tex(NAV_WHEEL_BLACK, 1210, 1, 1319 , 400, FONT_SIZE) 
UNIT.name				= create_guid_string()
UNIT.init_pos			= {0.97-xcor, 0.26}
UNIT.parent_element		=  AAR_PAGE.name
AddElement(UNIT)

local KG				= create_mfd_tex(NAV_WHEEL_BLACK, 1390, 1, 1550 , 110, FONT_SIZE) 
KG.name					= create_guid_string()
KG.init_pos				= {0.89-xcor, 0.345}
KG.parent_element		=  AAR_PAGE.name
AddElement(KG)

local KG_BOX				= create_mfd_tex(NAV_WHEEL_BLACK, 1861, 650, 2045 , 770, FONT_SIZE) 	-- 2  Letter horizontal box
KG_BOX.name					= create_guid_string()
KG_BOX.init_pos				= {0.8975-xcor, 0.342}
KG_BOX.parent_element		= AAR_PAGE.name
KG_BOX.element_params 		= {"UNIT_MODE"}
KG_BOX.controllers   		= {{"parameter_compare_with_number",0, 4}}
AddElement(KG_BOX)

local LB				= create_mfd_tex(NAV_WHEEL_BLACK, 1390, 111, 1550 , 205, FONT_SIZE) 
LB.name					= create_guid_string()
LB.init_pos				= {0.89-xcor, 0.28}
LB.parent_element		=  AAR_PAGE.name
AddElement(LB)

local LB_BOX				= create_mfd_tex(NAV_WHEEL_BLACK, 1861, 650, 2045 , 770, FONT_SIZE) 	-- 2  Letter horizontal box
LB_BOX.name					= create_guid_string()
LB_BOX.init_pos				= {0.8975-xcor, 0.277}
LB_BOX.parent_element		= AAR_PAGE.name
LB_BOX.element_params 		= {"UNIT_MODE"}
LB_BOX.controllers   		= {{"parameter_compare_with_number",0, 3}}
AddElement(LB_BOX)

local L					= create_mfd_tex(NAV_WHEEL_BLACK, 1465, 210, 1540 , 300, FONT_SIZE) 
L.name					= create_guid_string()
L.init_pos				= {0.91-xcor, 0.215}
L.parent_element		=  AAR_PAGE.name
AddElement(L)

local L_BOX				= create_mfd_tex(NAV_WHEEL_BLACK, 1650, 215, 1742 , 335, FONT_SIZE) 	-- 1 Letter box
L_BOX.name				= create_guid_string()
L_BOX.init_pos			= {0.9175-xcor, 0.215}
L_BOX.parent_element	= AAR_PAGE.name
L_BOX.element_params 	= {"UNIT_MODE"}
L_BOX.controllers   	= {{"parameter_compare_with_number",0, 2}}
AddElement(L_BOX)


local PCT					= create_mfd_tex(NAV_WHEEL_BLACK, 1465, 310, 1540 , 400, FONT_SIZE) 
PCT.name					= create_guid_string()
PCT.init_pos				= {0.91-xcor, 0.15}
PCT.parent_element			=  AAR_PAGE.name
AddElement(PCT)

local PCT_BOX				= create_mfd_tex(NAV_WHEEL_BLACK, 1650, 215, 1742 , 335, FONT_SIZE) 	-- 1 Letter box
PCT_BOX.name				= create_guid_string()
PCT_BOX.init_pos			= {0.9175-xcor, 0.15}
PCT_BOX.parent_element		= AAR_PAGE.name
PCT_BOX.element_params 		= {"UNIT_MODE"}
PCT_BOX.controllers   		= {{"parameter_compare_with_number",0, 1}}
AddElement(PCT_BOX)
-- LDP PAGE BUTTON LABLES

local MLAS			= create_mfd_tex(NAV_WHEEL_BLACK, 35, 1410, 110 , 1810,FONT_SIZE) 
MLAS.name			= create_guid_string()
MLAS.init_pos		= {-0.97+xcor, 0.84}
MLAS.parent_element	= LDP_PAGE.name
AddElement(MLAS)

local MLAS_BOX				= create_mfd_tex(NAV_WHEEL_BLACK, 1950, 215, 2042 , 646, FONT_SIZE) 
MLAS_BOX.name				= create_guid_string()
MLAS_BOX.init_pos			= {-0.97+xcor, 0.84}
MLAS_BOX.parent_element		= LDP_PAGE.name	
MLAS_BOX.element_params 	= {"MLAS_TOGGLE"}
MLAS_BOX.controllers    	= {{"parameter_compare_with_number",0, 1}}
AddElement(MLAS_BOX)

local SYMB			= create_mfd_tex(NAV_WHEEL_BLACK, 125, 1080, 225 , 1495,FONT_SIZE) 
SYMB.name			= create_guid_string()
SYMB.init_pos		= {-0.97+xcor, 0.56}
SYMB.parent_element	= LDP_PAGE.name
AddElement(SYMB)

local SYMB_BOX				= create_mfd_tex(NAV_WHEEL_BLACK, 1950, 215, 2042 , 646, FONT_SIZE) 
SYMB_BOX.name				= create_guid_string()
SYMB_BOX.init_pos			= {-0.9725+xcor, 0.5575}
SYMB_BOX.parent_element		= LDP_PAGE.name	
SYMB_BOX.element_params 	= {"SYMB_TOGGLE"}
SYMB_BOX.controllers    	= {{"parameter_compare_with_number",0, 1}}
AddElement(SYMB_BOX)


local SRCH			= create_mfd_tex(NAV_WHEEL_BLACK, 125, 1510, 225 , 1910,FONT_SIZE) 
SRCH.name			= create_guid_string()
SRCH.init_pos		= {-0.97+xcor, 0.26}
SRCH.parent_element	= LDP_PAGE.name
AddElement(SRCH)	

local SRCH_BOX				= create_mfd_tex(NAV_WHEEL_BLACK, 1950, 215, 2042 , 646, FONT_SIZE) 
SRCH_BOX.name				= create_guid_string()
SRCH_BOX.init_pos			= {-0.975+xcor, 0.2575}
SRCH_BOX.parent_element		= LDP_PAGE.name	
SRCH_BOX.element_params 	= {"SRCH_TRCK_MODE"}
SRCH_BOX.controllers    	= {{"parameter_compare_with_number",0, 1}}
AddElement(SRCH_BOX)

local TRCK			= create_mfd_tex(NAV_WHEEL_BLACK, 225, 1080, 325 , 1495,FONT_SIZE) 
TRCK.name			= create_guid_string()
TRCK.init_pos		= {-0.97+xcor, -0.02}
TRCK.parent_element	= LDP_PAGE.name
AddElement(TRCK)

local TRCK_BOX				= create_mfd_tex(NAV_WHEEL_BLACK, 1950, 215, 2042 , 646, FONT_SIZE) 
TRCK_BOX.name				= create_guid_string()
TRCK_BOX.init_pos			= {-0.975+xcor, -0.0225}
TRCK_BOX.parent_element		= LDP_PAGE.name	
TRCK_BOX.element_params 	= {"SRCH_TRCK_MODE"}
TRCK_BOX.controllers    	= {{"parameter_compare_with_number",0, 2}}
AddElement(TRCK_BOX)

local BOST			= create_mfd_tex(NAV_WHEEL_BLACK, 225, 1510, 325 , 1910,FONT_SIZE) 
BOST.name			= create_guid_string()
BOST.init_pos		= {0.97-xcor, 0.56}
BOST.parent_element	= LDP_PAGE.name
AddElement(BOST)

local SYMB_BOX				= create_mfd_tex(NAV_WHEEL_BLACK, 1950, 215, 2042 , 646, FONT_SIZE) 
SYMB_BOX.name				= create_guid_string()
SYMB_BOX.init_pos			= {0.9625-xcor, 0.56}
SYMB_BOX.parent_element		= LDP_PAGE.name	
SYMB_BOX.element_params 	= {"BOST_TOGGLE"}
SYMB_BOX.controllers    	= {{"parameter_compare_with_number",0, 1}}
AddElement(SYMB_BOX)


local WHOT			= create_mfd_tex(NAV_WHEEL_BLACK, 325, 1080, 425 , 1495,FONT_SIZE) 
WHOT.name			= create_guid_string()
WHOT.init_pos		= {0.97-xcor, 0.84}
WHOT.parent_element	= LDP_PAGE.name
AddElement(WHOT)

local WHOT_BOX				= create_mfd_tex(NAV_WHEEL_BLACK, 1950, 215, 2042 , 646, FONT_SIZE) 
WHOT_BOX.name				= create_guid_string()
WHOT_BOX.init_pos			= {0.9655-xcor, 0.8375}
WHOT_BOX.parent_element		= LDP_PAGE.name	
WHOT_BOX.element_params 	= {"WHOT_TOGGLE"}
WHOT_BOX.controllers    	= {{"parameter_compare_with_number",0, 1}}
AddElement(WHOT_BOX)


local IFB			= create_mfd_tex(NAV_WHEEL_BLACK, 325, 1510, 425 , 1820,FONT_SIZE) 
IFB.name			= create_guid_string()
IFB.init_pos		= {0.97-xcor, 1.15}
IFB.parent_element	= LDP_PAGE.name
AddElement(IFB)

--[[
local IFB_BOX			= create_mfd_tex(NAV_WHEEL_BLACK, 1850, 215, 1945 , 555,FONT_SIZE) 
IFB_BOX.name			= create_guid_string()
IFB_BOX.init_pos		= {0.97, 1.15}
IFB_BOX.parent_element	= LDP_PAGE.name
IFB_BOX.element_params = {"IFB_TOGGLE"}
IFB_BOX.controllers    = {{"parameter_compare_with_number",0, 1}}
AddElement(IFB_BOX)
--]]