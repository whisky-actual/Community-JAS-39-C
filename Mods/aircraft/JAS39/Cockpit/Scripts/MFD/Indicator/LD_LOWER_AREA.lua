
TAN_LD_MASTER 			= CreateElement "ceSimple"
TAN_LD_MASTER.init_pos	= {0,0}
TAN_LD_MASTER.name		= create_guid_string()
TAN_LD_MASTER.element_params = {"LD_EMGY_MODE", "MAINPOWER"}
TAN_LD_MASTER.controllers    = {{"parameter_compare_with_number",0, 0}, {"parameter_compare_with_number", 1, 1}}
AddElement(TAN_LD_MASTER)


--===================================================================================================================================================================================
--	[G] general flight info, ADI ball, speedo, altimeter
--===================================================================================================================================================================================
GENERAL_PAGE 			= CreateElement "ceSimple"
GENERAL_PAGE.init_pos	= {0,0}
GENERAL_PAGE.name		= create_guid_string()
GENERAL_PAGE.parent_element	= TAN_LD_MASTER.name
GENERAL_PAGE.element_params = {"LD_LOWER"}
GENERAL_PAGE.controllers    = {{"parameter_compare_with_number",0, 1}}
AddElement(GENERAL_PAGE)

--ADI ball
adi_background_mask = AddCircle(-0.007, -0.76, 0.34, 1, true)
adi_background_mask.h_clip_relation = h_clip_relations.DECREASE_IF_LEVEL  
adi_background_mask.level			 = MFD_DEFAULT_LEVEL
adi_background_mask.material		= MakeMaterial(nil,{0, 0, 0,255})	--RGBA
adi_background_mask.isvisible		 = false
adi_background_mask.parent_element	= GENERAL_PAGE.name
AddElement2(adi_background_mask)	

adi_background_mask2 = AddCircle(-0.007, -0.795, 0.34, 1, true)
adi_background_mask2.h_clip_relation = h_clip_relations.DECREASE_IF_LEVEL  
adi_background_mask2.level			 = MFD_DEFAULT_LEVEL
adi_background_mask2.material		= MakeMaterial(nil,{0, 0, 0,255})	--RGBA
adi_background_mask2.isvisible		 = false
adi_background_mask2.parent_element	= GENERAL_PAGE.name
AddElement2(adi_background_mask2)

adi_background_base 				= CreateElement "ceSimple"
adi_background_base.init_pos		= {0, -0.77}
adi_background_base.name			= create_guid_string()
adi_background_base.h_clip_relation = h_clip_relations.DECREASE_IF_LEVEL  
adi_background_base.level           = MFD_DEFAULT_LEVEL - 1
adi_background_base.parent_element	 = GENERAL_PAGE.name
adi_background_base.element_params 	= {"ADI_ROLL",}
adi_background_base.controllers		= {{"rotate_using_parameter" ,0, 1},}
AddElement2(adi_background_base)	

local adi_background			= create_mfd_tex_3300(ADI_BACKGROUND_B, 0, 0, 3072, 1920,1.6*1.372)
adi_background.name			= create_guid_string()
adi_background.init_pos		= {1.25, 0}
adi_background.parent_element	= adi_background_base.name
adi_background.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL    
adi_background.level           = MFD_DEFAULT_LEVEL - 1
adi_background.element_params  = { "LD_BRIGHTNESS", "ADI_PITCH", "HEADING"}
adi_background.controllers	 = {JAS_Bright[1],JAS_Bright[2],JAS_Bright[3],JAS_Bright[4],JAS_Bright[5],JAS_Bright[6],JAS_Bright[7],JAS_Bright[8],JAS_Bright[9],JAS_Bright[10],JAS_Bright[11],JAS_Bright[12],JAS_Bright[13],JAS_Bright[14],JAS_Bright[15], JAS_Bright[16],JAS_Bright[17],JAS_Bright[18],JAS_Bright[19],JAS_Bright[20], {"move_up_down_using_parameter",1, 0.036}, {"move_left_right_using_parameter",2, -0.0005982} }
AddElement2(adi_background)

-- Circle around the ADI
local adi_indicator				= create_mfd_tex(ADI_FRAME_B, 0, 0, 1270, 1270,0.67)
adi_indicator.name				= create_guid_string()
adi_indicator.init_pos			= {0, -0.77}
adi_indicator.parent_element	= GENERAL_PAGE.name
adi_indicator.element_params  = {"LD_BRIGHTNESS"}
adi_indicator.controllers	 = {JAS_Bright[1],JAS_Bright[2],JAS_Bright[3],JAS_Bright[4],JAS_Bright[5],JAS_Bright[6],JAS_Bright[7],JAS_Bright[8],JAS_Bright[9],JAS_Bright[10],JAS_Bright[11],JAS_Bright[12],JAS_Bright[13],JAS_Bright[14],JAS_Bright[15], JAS_Bright[16],JAS_Bright[17],JAS_Bright[18],JAS_Bright[19],JAS_Bright[20]}
AddElement(adi_indicator)
	
-- Attitude marker
local adi_Attitude				= create_mfd_VELVEC(ADI_VEELOCITYVECTOR, 20, 55, 354, 285,1)
adi_Attitude.name				= create_guid_string()
adi_Attitude.init_pos			= {0, -0.77}
adi_Attitude.parent_element		= GENERAL_PAGE.name
adi_Attitude.element_params 	= {"VELVEC_HUD_Y","VELVEC_HUD_X"}
adi_Attitude.controllers    	= { {"move_up_down_using_parameter",0, 0.036}, {"move_left_right_using_parameter",1, 0.036}}
AddElement(adi_Attitude)
	
--Roll marker
local adi_roll				= create_mfd_tex(ADI_FRAME_B, 1975, 0, 2038, 1143.27, 0.65 )
adi_roll.name				= create_guid_string()
adi_roll.init_pos			= {-0.005, 0}
adi_roll.parent_element		= adi_indicator.name
adi_roll.element_params 	= {"LD_BRIGHTNESS", "ADI_ROLL",}
adi_roll.controllers		= {JAS_Bright[1],JAS_Bright[2],JAS_Bright[3],JAS_Bright[4],JAS_Bright[5],JAS_Bright[6],JAS_Bright[7],JAS_Bright[8],JAS_Bright[9],JAS_Bright[10],JAS_Bright[11],JAS_Bright[12],JAS_Bright[13],JAS_Bright[14],JAS_Bright[15], JAS_Bright[16],JAS_Bright[17],JAS_Bright[18],JAS_Bright[19],JAS_Bright[20],{"rotate_using_parameter" ,1, 1}}
AddElement(adi_roll)

local alfa_g_box			= create_mfd_tex(NAV_WHEEL_BLACK, 1640, 0, 2048, 212,0.9)
alfa_g_box.name				= create_guid_string()
alfa_g_box.init_pos			= {-0.7, -1.0}
alfa_g_box.parent_element	= GENERAL_PAGE.name
AddElement(alfa_g_box)

local G_indicator = add_text_param(0.04, -0.04, "CUR_G", "%0.1f", alfa_g_box, mfd_strdefs_digit, "Gripen_Font_black")

local ALFA_indicator = add_text_param(0, 0.04, "CUR_AOA", "%0.0f", alfa_g_box, mfd_strdefs_digit, "Gripen_Font_black")

-- Speedo

local speedometer_kts			= create_mfd_tex_3k(MFD_ELEMENTS_PDD, 1, 1, 850, 844, 1.0)
speedometer_kts.name			= create_guid_string()
speedometer_kts.init_pos		= {-0.61, -0.5}
speedometer_kts.parent_element	= GENERAL_PAGE.name	
AddElement(speedometer_kts)	


local speedometer_needle 			= create_mfd_tex_3k(MFD_ELEMENTS_PDD, 82, 2230, 353, 2272, 1.0 , -57 ,2260 + ((2243-2230)/2)  )
speedometer_needle.name				= create_guid_string()
speedometer_needle.init_pos			= {-0.61, -0.5}
speedometer_needle.init_rot			= {90, 0}
speedometer_needle.parent_element	= GENERAL_PAGE.name
speedometer_needle.element_params   = {"CUR_IAS"}
speedometer_needle.controllers	 	= {{"rotate_using_parameter" ,0, -math.rad(360)/1000},}
AddElement(speedometer_needle)

add_text("M", 0, 0.05, speedometer_kts, "Gripen_Font_black", mfd_strdefs_digit_S )

Mach_indicator 				= CreateElement "ceStringPoly"
Mach_indicator.name 				= create_guid_string()
Mach_indicator.parent_element		= speedometer_kts.name
Mach_indicator.material				= fonts["Gripen_Font_black"]
Mach_indicator.init_pos 			= {0, -0.04}
Mach_indicator.alignment 			= "LeftCenter"
Mach_indicator.stringdefs 			= mfd_strdefs_digit_S
Mach_indicator.formats 				= {"%0.0f","%s"}
Mach_indicator.element_params 		= {"MACH_B"}
Mach_indicator.controllers 			= {{"text_using_parameter",0,0},{"parameter_in_range" ,0, 3, 99.5}}
AddElement(Mach_indicator)

add_text(".", -0.0115, 0, Mach_indicator, "Gripen_Font_black",mfd_strdefs_digit_S )

Mach_indicator2 				= CreateElement "ceStringPoly"
Mach_indicator2.name 				= create_guid_string()
Mach_indicator2.parent_element		= speedometer_kts.name
Mach_indicator2.material			= fonts["Gripen_Font_black"]
Mach_indicator2.init_pos 			= {-0.059, -0.04}
Mach_indicator2.alignment 			= "LeftCenter"
Mach_indicator2.stringdefs 			= mfd_strdefs_digit_S
Mach_indicator2.formats 			= {"%0.2f","%s"}
Mach_indicator2.element_params 		= {"MACH_A"}
Mach_indicator2.controllers 		= {{"text_using_parameter",0,0},{"parameter_in_range" ,0, 0.995, 3}}
AddElement(Mach_indicator2)

-- Altimeter

local Altimeter_Feet		= create_mfd_tex_3k(MFD_ELEMENTS_PDD,860, 0, 1700, 844, 1.0)
Altimeter_Feet.name			= create_guid_string()
Altimeter_Feet.init_pos		= {0.6, -0.5}
Altimeter_Feet.parent_element	= GENERAL_PAGE.name	
AddElement(Altimeter_Feet)	

local Altimeter_Needle 				= create_mfd_tex(MFD_ELEMENTS, 464, 798, 600, 822, 1.1 , 378 , 794 + ((822-796)/2))
Altimeter_Needle.name				= create_guid_string()
Altimeter_Needle.init_pos			= {0.6, -0.5}
Altimeter_Needle.init_rot			= {90, 0}
Altimeter_Needle.parent_element		= GENERAL_PAGE.name	
Altimeter_Needle.element_params  	= { "ALTITUDE_H"}
Altimeter_Needle.controllers	 	= {{"rotate_using_parameter" ,0, -math.rad(360)/1000},}
AddElement(Altimeter_Needle)

add_text_param(-0.048, 0     , "ALTITUDE_T", "%02.0f", Altimeter_Feet, mfd_strdefs_text, "Gripen_Font_black")
add_text_param( 0.07, -0.006, "ALTITUDE_H", "%03.0f", Altimeter_Feet, mfd_strdefs_digit, "Gripen_Font_black")

--===================================================================================================================================================================================
--	[M] Monitor, backup systems, like a small EMGY page.
--===================================================================================================================================================================================

MONITOR_PAGE 			= CreateElement "ceSimple"
MONITOR_PAGE.init_pos	= {0,0}
MONITOR_PAGE.name		= create_guid_string()
MONITOR_PAGE.parent_element	= TAN_LD_MASTER.name
MONITOR_PAGE.element_params = {"LD_LOWER"}
MONITOR_PAGE.controllers    = {{"parameter_compare_with_number",0, 2}}
AddElement(MONITOR_PAGE)

local EMGY_MONITOR_text = add_text("EMGY MONITOR", -0.7,-0.33, MONITOR_PAGE, "Gripen_Font_black", mfd_strdefs_digit_XS )


--ADI ball
adi_background_mask = AddCircle(-0.007, -0.76, 0.34, 1, true)
adi_background_mask.h_clip_relation = h_clip_relations.DECREASE_IF_LEVEL  
adi_background_mask.level			 = MFD_DEFAULT_LEVEL
adi_background_mask.material		= MakeMaterial(nil,{0, 0, 0,255})	--RGBA
adi_background_mask.isvisible		 = false
adi_background_mask.parent_element	= MONITOR_PAGE.name
AddElement2(adi_background_mask)	

adi_background_mask2 = AddCircle(-0.007, -0.795, 0.34, 1, true)
adi_background_mask2.h_clip_relation = h_clip_relations.DECREASE_IF_LEVEL  
adi_background_mask2.level			 = MFD_DEFAULT_LEVEL
adi_background_mask2.material		= MakeMaterial(nil,{0, 0, 0,255})	--RGBA
adi_background_mask2.isvisible		 = false
adi_background_mask2.parent_element	= MONITOR_PAGE.name
AddElement2(adi_background_mask2)

adi_background_base 				= CreateElement "ceSimple"
adi_background_base.init_pos		= {0, -0.77}
adi_background_base.name			= create_guid_string()
adi_background_base.h_clip_relation = h_clip_relations.DECREASE_IF_LEVEL  
adi_background_base.level           = MFD_DEFAULT_LEVEL - 1
adi_background_base.parent_element	 = MONITOR_PAGE.name
adi_background_base.element_params 	= {"ADI_ROLL",}
adi_background_base.controllers		= {{"rotate_using_parameter" ,0, 1},}
AddElement2(adi_background_base)	

local adi_background			= create_mfd_tex_3300(ADI_BACKGROUND_MONITOR, 0, 0, 3072, 1920,1.6*1.372)
adi_background.name			= create_guid_string()
adi_background.init_pos		= {0.597, -0.01}
adi_background.parent_element	= adi_background_base.name
adi_background.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL    
adi_background.level           = MFD_DEFAULT_LEVEL - 1
adi_background.element_params  = { "LD_BRIGHTNESS", "ADI_ATTITUDE"}
adi_background.controllers	 = {JAS_Bright[1],JAS_Bright[2],JAS_Bright[3],JAS_Bright[4],JAS_Bright[5],JAS_Bright[6],JAS_Bright[7],JAS_Bright[8],JAS_Bright[9],JAS_Bright[10],JAS_Bright[11],JAS_Bright[12],JAS_Bright[13],JAS_Bright[14],JAS_Bright[15], JAS_Bright[16],JAS_Bright[17],JAS_Bright[18],JAS_Bright[19],JAS_Bright[20], {"move_up_down_using_parameter",1, 0.036} }
AddElement2(adi_background)

-- Circle around the ADI
local adi_indicator				= create_mfd_tex(ADI_FRAME_B, 0, 0, 1270, 1270,0.67)
adi_indicator.name				= create_guid_string()
adi_indicator.init_pos			= {0, -0.77}
adi_indicator.parent_element	= MONITOR_PAGE.name
adi_indicator.element_params  = {"LD_BRIGHTNESS"}
adi_indicator.controllers	 = {JAS_Bright[1],JAS_Bright[2],JAS_Bright[3],JAS_Bright[4],JAS_Bright[5],JAS_Bright[6],JAS_Bright[7],JAS_Bright[8],JAS_Bright[9],JAS_Bright[10],JAS_Bright[11],JAS_Bright[12],JAS_Bright[13],JAS_Bright[14],JAS_Bright[15], JAS_Bright[16],JAS_Bright[17],JAS_Bright[18],JAS_Bright[19],JAS_Bright[20]}
AddElement(adi_indicator)
	
-- Attitude marker
local ADI_MONITOR_ATTITUDE				= create_mfd_tex(AAR_LDP_BLACK, 1512, 1508 , 2019, 1578,0.8)
ADI_MONITOR_ATTITUDE.name				= create_guid_string()
ADI_MONITOR_ATTITUDE.init_pos			= {-0.008, -0.8}
ADI_MONITOR_ATTITUDE.parent_element		= MONITOR_PAGE.name
ADI_MONITOR_ATTITUDE.element_params    = {"LD_BRIGHTNESS"}
ADI_MONITOR_ATTITUDE.controllers	    = {JAS_Bright[1],JAS_Bright[2],JAS_Bright[3],JAS_Bright[4],JAS_Bright[5],JAS_Bright[6],JAS_Bright[7],JAS_Bright[8],JAS_Bright[9],JAS_Bright[10],JAS_Bright[11],JAS_Bright[12],JAS_Bright[13],JAS_Bright[14],JAS_Bright[15], JAS_Bright[16],JAS_Bright[17],JAS_Bright[18],JAS_Bright[19],JAS_Bright[20]}
AddElement(ADI_MONITOR_ATTITUDE)
	
--Roll marker
local adi_roll				= create_mfd_tex(ADI_FRAME_B, 1975, 0, 2038, 1143.27, 0.65 )
adi_roll.name				= create_guid_string()
adi_roll.init_pos			= {-0.005, 0}
adi_roll.parent_element		= adi_indicator.name
adi_roll.element_params 	= {"LD_BRIGHTNESS", "ADI_ROLL",}
adi_roll.controllers		= {JAS_Bright[1],JAS_Bright[2],JAS_Bright[3],JAS_Bright[4],JAS_Bright[5],JAS_Bright[6],JAS_Bright[7],JAS_Bright[8],JAS_Bright[9],JAS_Bright[10],JAS_Bright[11],JAS_Bright[12],JAS_Bright[13],JAS_Bright[14],JAS_Bright[15], JAS_Bright[16],JAS_Bright[17],JAS_Bright[18],JAS_Bright[19],JAS_Bright[20],{"rotate_using_parameter" ,1, 1}}
AddElement(adi_roll)

local HEADING_TAPE_MONITOR_MASK					 = CreateElement "ceSimpleLineObject"
HEADING_TAPE_MONITOR_MASK.name			 		 = create_guid_string()
HEADING_TAPE_MONITOR_MASK.material				 = MakeMaterial(nil, {0,100,0, 255})
HEADING_TAPE_MONITOR_MASK.width		 			 = 0.32
HEADING_TAPE_MONITOR_MASK.vertices	 			 = {{0, 0.12}, {0,0}}
HEADING_TAPE_MONITOR_MASK.init_pos       		 = {0, -0.375}
HEADING_TAPE_MONITOR_MASK.h_clip_relation 		 = h_clip_relations.INCREASE_IF_LEVEL  
HEADING_TAPE_MONITOR_MASK.level					 = MFD_DEFAULT_LEVEL  
HEADING_TAPE_MONITOR_MASK.isvisible				 = false
HEADING_TAPE_MONITOR_MASK.parent_element 		 = MONITOR_PAGE.name
AddElement2(HEADING_TAPE_MONITOR_MASK)

local HEADING_TAPE_MONITOR				= create_mfd_tex_3300(EMGY_HEADING_BLACK, 0, 148, 3072, 218,1.4*1.611)
HEADING_TAPE_MONITOR.name				= create_guid_string()
HEADING_TAPE_MONITOR.init_pos			= {1.2495, -0.31}
HEADING_TAPE_MONITOR.parent_element		= MONITOR_PAGE.name
HEADING_TAPE_MONITOR.h_clip_relation 	= h_clip_relations.DECREASE_IF_LEVEL  
HEADING_TAPE_MONITOR.level           	= MFD_DEFAULT_LEVEL + 1
HEADING_TAPE_MONITOR.element_params  	= {"EMGY_HEADING"}
HEADING_TAPE_MONITOR.controllers	 	= {{"move_left_right_using_parameter",0, -0.00061001} }
AddElement2(HEADING_TAPE_MONITOR)

local HEADING_ARROW_EMGY			= create_mfd_tex(ADI_FRAME_B, 1748, 1497 , 1807, 1555,0.75)
HEADING_ARROW_EMGY.name				= create_guid_string()
HEADING_ARROW_EMGY.init_pos			= {-0.009, -0.37}
HEADING_ARROW_EMGY.init_rot			= {90, 0}
HEADING_ARROW_EMGY.parent_element	= MONITOR_PAGE.name
HEADING_ARROW_EMGY.element_params    = {"LD_BRIGHTNESS"}
HEADING_ARROW_EMGY.controllers	    = {JAS_Bright[1],JAS_Bright[2],JAS_Bright[3],JAS_Bright[4],JAS_Bright[5],JAS_Bright[6],JAS_Bright[7],JAS_Bright[8],JAS_Bright[9],JAS_Bright[10],JAS_Bright[11],JAS_Bright[12],JAS_Bright[13],JAS_Bright[14],JAS_Bright[15], JAS_Bright[16],JAS_Bright[17],JAS_Bright[18],JAS_Bright[19],JAS_Bright[20]}
AddElement(HEADING_ARROW_EMGY)

local MAG_text = add_text("MAG", -0.315,-0.039, HEADING_TAPE_MONITOR_MASK, "Gripen_Font_black", mfd_strdefs_digit_XS )

AIRSPEED_MONITOR_SCALE			= create_mfd_tex(ADI_FRAME_B, 1870, 1070 , 1925, 1855,0.69)
AIRSPEED_MONITOR_SCALE.name			= create_guid_string()
AIRSPEED_MONITOR_SCALE.init_pos		= {-0.5, -0.7925}
AIRSPEED_MONITOR_SCALE.parent_element	= MONITOR_PAGE.name
AIRSPEED_MONITOR_SCALE.element_params    = {"LD_BRIGHTNESS"}
AIRSPEED_MONITOR_SCALE.controllers	    = {JAS_Bright[1],JAS_Bright[2],JAS_Bright[3],JAS_Bright[4],JAS_Bright[5],JAS_Bright[6],JAS_Bright[7],JAS_Bright[8],JAS_Bright[9],JAS_Bright[10],JAS_Bright[11],JAS_Bright[12],JAS_Bright[13],JAS_Bright[14],JAS_Bright[15], JAS_Bright[16],JAS_Bright[17],JAS_Bright[18],JAS_Bright[19],JAS_Bright[20]}
AddElement(AIRSPEED_MONITOR_SCALE)
 
AIRSPEED_MONITOR_ARROW			= create_mfd_tex(ADI_FRAME_B, 1748, 1497 , 1807, 1555,0.75)
AIRSPEED_MONITOR_ARROW.name				= create_guid_string()
AIRSPEED_MONITOR_ARROW.init_pos			= {-0.505, -1.1353}
AIRSPEED_MONITOR_ARROW.parent_element	= MONITOR_PAGE.name
AIRSPEED_MONITOR_ARROW.element_params   = {"LD_BRIGHTNESS","EMGY_IAS",}
AIRSPEED_MONITOR_ARROW.controllers	    = {JAS_Bright[1],JAS_Bright[2],JAS_Bright[3],JAS_Bright[4],JAS_Bright[5],JAS_Bright[6],JAS_Bright[7],JAS_Bright[8],JAS_Bright[9],JAS_Bright[10],JAS_Bright[11],JAS_Bright[12],JAS_Bright[13],JAS_Bright[14],JAS_Bright[15], JAS_Bright[16],JAS_Bright[17],JAS_Bright[18],JAS_Bright[19],JAS_Bright[20], {"move_up_down_using_parameter", 1, 0.0000835}}
AddElement(AIRSPEED_MONITOR_ARROW)

AIRSPEED_MONITOR_READOUT = add_text_param(-0.08,0.0 , "CURR_IAS", "%0.0f", AIRSPEED_MONITOR_ARROW, mfd_strdefs_digit_XS, "Gripen_Font_black") 

ALFA_SYMBOL_MONITOR					 = create_mfd_tex(ADI_FRAME_B, 1795, 435 , 1875, 510,0.6)
ALFA_SYMBOL_MONITOR.name			 = create_guid_string()
ALFA_SYMBOL_MONITOR.init_pos		 = {-0.53, -0.499}
ALFA_SYMBOL_MONITOR.parent_element	 = MONITOR_PAGE.name
ALFA_SYMBOL_MONITOR.element_params 	 = {"LD_BRIGHTNESS"}
ALFA_SYMBOL_MONITOR.controllers	 	 = {JAS_Bright[1],JAS_Bright[2],JAS_Bright[3],JAS_Bright[4],JAS_Bright[5],JAS_Bright[6],JAS_Bright[7],JAS_Bright[8],JAS_Bright[9],JAS_Bright[10],JAS_Bright[11],JAS_Bright[12],JAS_Bright[13],JAS_Bright[14],JAS_Bright[15], JAS_Bright[16],JAS_Bright[17],JAS_Bright[18],JAS_Bright[19],JAS_Bright[20]}
AddElement(ALFA_SYMBOL_MONITOR)


Mach_indicatorMonitor 						= CreateElement "ceStringPoly"
Mach_indicatorMonitor.name 					= create_guid_string()
Mach_indicatorMonitor.parent_element		= MONITOR_PAGE.name
Mach_indicatorMonitor.material				= fonts["Gripen_Font_black"]
Mach_indicatorMonitor.init_pos 				= {-0.45, -1.12}
Mach_indicatorMonitor.alignment 			= "LeftCenter"
Mach_indicatorMonitor.stringdefs 			= mfd_strdefs_digit_XS
Mach_indicatorMonitor.formats 				= {"%0.0f","%s"}
Mach_indicatorMonitor.element_params 		= {"MACH_B"}
Mach_indicatorMonitor.controllers 			= {{"text_using_parameter",0,0},{"parameter_in_range" ,0, 3, 99.5}}
AddElement(Mach_indicatorMonitor)

add_text(".", -0.008, 0, Mach_indicatorMonitor, "Gripen_Font_black",mfd_strdefs_digit_XS )

Mach_indicatorMonitor2 						= CreateElement "ceStringPoly"
Mach_indicatorMonitor2.name 				= create_guid_string()
Mach_indicatorMonitor2.parent_element		= MONITOR_PAGE.name
Mach_indicatorMonitor2.material				= fonts["Gripen_Font_black"]
Mach_indicatorMonitor2.init_pos 			= {-0.497, -1.12}
Mach_indicatorMonitor2.alignment 			= "LeftCenter"
Mach_indicatorMonitor2.stringdefs 			= mfd_strdefs_digit_XS
Mach_indicatorMonitor2.formats 				= {"%0.2f","%s"}
Mach_indicatorMonitor2.element_params 		= {"MACH_A"}
Mach_indicatorMonitor2.controllers 			= {{"text_using_parameter",0,0},{"parameter_in_range" ,0, 0.995, 3}}
AddElement(Mach_indicatorMonitor2)

--[[
add_text_param(-0.40, -1.12, "CUR_MACH", "%0.2f", MONITOR_PAGE, mfd_strdefs_digit_XS, "Gripen_Font_black")
--]]
Mach_text_MONITOR = add_text("M", -0.55, -1.12, MONITOR_PAGE, "Gripen_Font_black", mfd_strdefs_digit_XS)


add_text_param(-0.45, -0.499, "CUR_AOA", "%0.0f", MONITOR_PAGE, mfd_strdefs_digit_XS, "Gripen_Font_black")









RPM_ELEMENT_MONITOR		= create_mfd_tex (MFD_ELEMENTS_PDD,523, 928, 680, 1064, 1)
RPM_ELEMENT_MONITOR.name			= create_guid_string()
RPM_ELEMENT_MONITOR.init_pos		= {-0.755, -0.85}
RPM_ELEMENT_MONITOR.parent_element	= MONITOR_PAGE.name
AddElement(RPM_ELEMENT_MONITOR)

RPM_TEXT_MONITOR		= create_mfd_tex (MFD_ELEMENTS_PDD,266, 600, 384, 655, 1)
RPM_TEXT_MONITOR.name			= create_guid_string()
RPM_TEXT_MONITOR.init_pos		= {-0.90, -0.855}
RPM_TEXT_MONITOR.parent_element	= MONITOR_PAGE.name
AddElement(RPM_TEXT_MONITOR)

local MONITOR_rpm = add_text_param(-0.015, -0.002, "RPM_PARAM_U", "%02.0f", RPM_ELEMENT_MONITOR, mfd_strdefs_digit_S, "Gripen_Font_black", "LeftCenter")

local MONITOR_rpm_100 = add_text("1", -0.045, -0.001, RPM_ELEMENT_MONITOR , "Gripen_Font_black", mfd_strdefs_digit_S, "LeftCenter")
MONITOR_rpm_100.element_params  = {"RPM_PARAM"}
MONITOR_rpm_100.controllers     = {{"parameter_in_range" ,0,0.9,1.1} }

TGT_ELEMENT_MONITOR		= create_mfd_tex (MFD_ELEMENTS_PDD,523, 928, 680, 1064, 1)
TGT_ELEMENT_MONITOR.name			= create_guid_string()
TGT_ELEMENT_MONITOR.init_pos		= {-0.755, -1.05}
TGT_ELEMENT_MONITOR.parent_element	= MONITOR_PAGE.name
AddElement(TGT_ELEMENT_MONITOR)

TGT_TEXT_MONITOR		= create_mfd_tex (MFD_ELEMENTS_PDD,760, 600, 860, 655, 1)
TGT_TEXT_MONITOR.name			= create_guid_string()
TGT_TEXT_MONITOR.init_pos		= {-0.89, -1.055}
TGT_TEXT_MONITOR.parent_element	= MONITOR_PAGE.name
AddElement(TGT_TEXT_MONITOR)

local MONITOR_TGT = add_text_param(-0.05, -0.002, "TGT_PARAM", "%02.0f", TGT_ELEMENT_MONITOR, mfd_strdefs_digit_S, "Gripen_Font_black", "LeftCenter")

ALTITUDE_SCALE_MONITOR_MASK				 		     = CreateElement "ceSimpleLineObject"
ALTITUDE_SCALE_MONITOR_MASK.name			 		 = create_guid_string()
ALTITUDE_SCALE_MONITOR_MASK.material				 = MakeMaterial(nil, {0,100,0, 255})
ALTITUDE_SCALE_MONITOR_MASK.width		 		 	 = 0.20
ALTITUDE_SCALE_MONITOR_MASK.vertices	 			 = {{0, 0.5}, {0,0}}
ALTITUDE_SCALE_MONITOR_MASK.init_pos       		 	 = {0.875, -0.71-0.072}
ALTITUDE_SCALE_MONITOR_MASK.init_rot				 = {90, 0}
ALTITUDE_SCALE_MONITOR_MASK.h_clip_relation 		 = h_clip_relations.INCREASE_IF_LEVEL
ALTITUDE_SCALE_MONITOR_MASK.level				 	 = MFD_DEFAULT_LEVEL
ALTITUDE_SCALE_MONITOR_MASK.isvisible			 	 = false
ALTITUDE_SCALE_MONITOR_MASK.parent_element 			 = MONITOR_PAGE.name
AddElement2(ALTITUDE_SCALE_MONITOR_MASK)

ALTITUDE_SCALE_MONITOR_MASK2				 		 = CreateElement "ceSimpleLineObject"
ALTITUDE_SCALE_MONITOR_MASK2.name			 		 = create_guid_string()
ALTITUDE_SCALE_MONITOR_MASK2.material				 = MakeMaterial(nil, {0,100,0, 255})
ALTITUDE_SCALE_MONITOR_MASK2.width		 		 	 = 0.20
ALTITUDE_SCALE_MONITOR_MASK2.vertices	 			 = {{0, 0.5}, {0,0}}
ALTITUDE_SCALE_MONITOR_MASK2.init_pos       		 = {0.875, -0.71-0.072}
ALTITUDE_SCALE_MONITOR_MASK2.init_rot				 = {90, 0}
ALTITUDE_SCALE_MONITOR_MASK2.h_clip_relation 		 = h_clip_relations.INCREASE_IF_LEVEL
ALTITUDE_SCALE_MONITOR_MASK2.level				 	 = MFD_DEFAULT_LEVEL +1
ALTITUDE_SCALE_MONITOR_MASK2.isvisible			 	 = false
ALTITUDE_SCALE_MONITOR_MASK2.parent_element 		 = MONITOR_PAGE.name
AddElement2(ALTITUDE_SCALE_MONITOR_MASK2)

ALTITUDE_SCALE_MONITOR					= create_mfd_tex_3300(EMGY_HEADING_BLACK, 0, 1050, 3072, 1214,2.5)
ALTITUDE_SCALE_MONITOR.name				= create_guid_string()
ALTITUDE_SCALE_MONITOR.init_pos			= {0.65, 1.458-0.072}
ALTITUDE_SCALE_MONITOR.init_rot			= {90, 0}
ALTITUDE_SCALE_MONITOR.parent_element	= MONITOR_PAGE.name
ALTITUDE_SCALE_MONITOR.h_clip_relation 	= h_clip_relations.DECREASE_IF_LEVEL  
ALTITUDE_SCALE_MONITOR.level           	= MFD_DEFAULT_LEVEL +2
ALTITUDE_SCALE_MONITOR.element_params  	= { "LD_BRIGHTNESS","EMGY_ALTITUDE"}
ALTITUDE_SCALE_MONITOR.controllers	 	= {JAS_Bright[1],JAS_Bright[2],JAS_Bright[3],JAS_Bright[4],JAS_Bright[5],JAS_Bright[6],JAS_Bright[7],JAS_Bright[8],JAS_Bright[9],JAS_Bright[10],JAS_Bright[11],JAS_Bright[12],JAS_Bright[13],JAS_Bright[14],JAS_Bright[15], JAS_Bright[16],JAS_Bright[17],JAS_Bright[18],JAS_Bright[19],JAS_Bright[20], {"move_left_right_using_parameter",1, -0.00001903} }
AddElement2(ALTITUDE_SCALE_MONITOR)

ALTITUDE_SCALE_MONITOR2						= create_mfd_tex_3300(EMGY_HEADING_BLACK, 0, 1237, 3072, 1401,2.5)
ALTITUDE_SCALE_MONITOR2.name				= create_guid_string()
ALTITUDE_SCALE_MONITOR2.init_pos			= {0.65, 6.1288-0.072}
ALTITUDE_SCALE_MONITOR2.init_rot			= {90, 0}
ALTITUDE_SCALE_MONITOR2.parent_element		= MONITOR_PAGE.name
ALTITUDE_SCALE_MONITOR2.h_clip_relation 	= h_clip_relations.DECREASE_IF_LEVEL  
ALTITUDE_SCALE_MONITOR2.level           	= MFD_DEFAULT_LEVEL + 2
ALTITUDE_SCALE_MONITOR2.element_params  	= { "LD_BRIGHTNESS","EMGY_ALTITUDE"}
ALTITUDE_SCALE_MONITOR2.controllers	 		= {JAS_Bright[1],JAS_Bright[2],JAS_Bright[3],JAS_Bright[4],JAS_Bright[5],JAS_Bright[6],JAS_Bright[7],JAS_Bright[8],JAS_Bright[9],JAS_Bright[10],JAS_Bright[11],JAS_Bright[12],JAS_Bright[13],JAS_Bright[14],JAS_Bright[15], JAS_Bright[16],JAS_Bright[17],JAS_Bright[18],JAS_Bright[19],JAS_Bright[20], {"move_left_right_using_parameter",1, -0.00001903} }
AddElement2(ALTITUDE_SCALE_MONITOR2)

ALTITUDE_SCALE_MONITOR3						= create_mfd_tex_3300(EMGY_HEADING_BLACK, 0, 1431 , 3072, 1594,2.5)
ALTITUDE_SCALE_MONITOR3.name				= create_guid_string()
ALTITUDE_SCALE_MONITOR3.init_pos			= {0.65, 10.687-0.072}
ALTITUDE_SCALE_MONITOR3.init_rot			= {90, 0}
ALTITUDE_SCALE_MONITOR3.parent_element		= MONITOR_PAGE.name
ALTITUDE_SCALE_MONITOR3.h_clip_relation 	= h_clip_relations.DECREASE_IF_LEVEL  
ALTITUDE_SCALE_MONITOR3.level           	= MFD_DEFAULT_LEVEL + 2
ALTITUDE_SCALE_MONITOR3.element_params  	= { "LD_BRIGHTNESS","EMGY_ALTITUDE"}
ALTITUDE_SCALE_MONITOR3.controllers	 		= {JAS_Bright[1],JAS_Bright[2],JAS_Bright[3],JAS_Bright[4],JAS_Bright[5],JAS_Bright[6],JAS_Bright[7],JAS_Bright[8],JAS_Bright[9],JAS_Bright[10],JAS_Bright[11],JAS_Bright[12],JAS_Bright[13],JAS_Bright[14],JAS_Bright[15], JAS_Bright[16],JAS_Bright[17],JAS_Bright[18],JAS_Bright[19],JAS_Bright[20], {"move_left_right_using_parameter",1, -0.00001903} }
AddElement2(ALTITUDE_SCALE_MONITOR3)

ALTITUDE_SCALE_MONITOR4						= create_mfd_tex_3300(EMGY_HEADING_BLACK, 0, 1627 , 3072, 1790,2.5)
ALTITUDE_SCALE_MONITOR4.name				= create_guid_string()
ALTITUDE_SCALE_MONITOR4.init_pos			= {0.65, 15.244-0.072}
ALTITUDE_SCALE_MONITOR4.init_rot			= {90, 0}
ALTITUDE_SCALE_MONITOR4.parent_element		= MONITOR_PAGE.name
ALTITUDE_SCALE_MONITOR4.h_clip_relation 	= h_clip_relations.DECREASE_IF_LEVEL  
ALTITUDE_SCALE_MONITOR4.level           	= MFD_DEFAULT_LEVEL + 2
ALTITUDE_SCALE_MONITOR4.element_params  	= { "LD_BRIGHTNESS","EMGY_ALTITUDE"}
ALTITUDE_SCALE_MONITOR4.controllers	 		= {JAS_Bright[1],JAS_Bright[2],JAS_Bright[3],JAS_Bright[4],JAS_Bright[5],JAS_Bright[6],JAS_Bright[7],JAS_Bright[8],JAS_Bright[9],JAS_Bright[10],JAS_Bright[11],JAS_Bright[12],JAS_Bright[13],JAS_Bright[14],JAS_Bright[15], JAS_Bright[16],JAS_Bright[17],JAS_Bright[18],JAS_Bright[19],JAS_Bright[20], {"move_left_right_using_parameter",1, -0.00001903} }
AddElement2(ALTITUDE_SCALE_MONITOR4)

ALTITUDE_MONITOR_ARROW			= create_mfd_tex(ADI_FRAME_B, 1748, 1497 , 1807, 1555,0.75)
ALTITUDE_MONITOR_ARROW.name				= create_guid_string()
ALTITUDE_MONITOR_ARROW.init_pos			= {0.5, -0.7075-0.072}
ALTITUDE_MONITOR_ARROW.parent_element	= MONITOR_PAGE.name
ALTITUDE_MONITOR_ARROW.element_params    = {"LD_BRIGHTNESS"}
ALTITUDE_MONITOR_ARROW.controllers	    = {JAS_Bright[1],JAS_Bright[2],JAS_Bright[3],JAS_Bright[4],JAS_Bright[5],JAS_Bright[6],JAS_Bright[7],JAS_Bright[8],JAS_Bright[9],JAS_Bright[10],JAS_Bright[11],JAS_Bright[12],JAS_Bright[13],JAS_Bright[14],JAS_Bright[15], JAS_Bright[16],JAS_Bright[17],JAS_Bright[18],JAS_Bright[19],JAS_Bright[20]}
AddElement(ALTITUDE_MONITOR_ARROW)


MONITOR_FUEL_BOX					= create_mfd_tex(ADI_FRAME_B, 1400, 12 , 1775, 380,0.50)
MONITOR_FUEL_BOX.name				= create_guid_string()
MONITOR_FUEL_BOX.init_pos			= {-0.72, -0.50}
MONITOR_FUEL_BOX.parent_element		= MONITOR_PAGE.name
MONITOR_FUEL_BOX.element_params    = {"LD_BRIGHTNESS"}
MONITOR_FUEL_BOX.controllers	    = {JAS_Bright[1],JAS_Bright[2],JAS_Bright[3],JAS_Bright[4],JAS_Bright[5],JAS_Bright[6],JAS_Bright[7],JAS_Bright[8],JAS_Bright[9],JAS_Bright[10],JAS_Bright[11],JAS_Bright[12],JAS_Bright[13],JAS_Bright[14],JAS_Bright[15], JAS_Bright[16],JAS_Bright[17],JAS_Bright[18],JAS_Bright[19],JAS_Bright[20]}

AddElement(MONITOR_FUEL_BOX)

FUEL_TEXT_MONITOR = add_text("FUEL", -0.715, -0.45, MONITOR_PAGE, "Gripen_Font_black", mfd_strdefs_digit_S )

FUEL_TXT_D = add_text_param(-0.02, -0.1 , "FUEL", "%0.0f", FUEL_TEXT_MONITOR, mfd_strdefs_digit_S, "Gripen_Font_black")
add_text("%", 0.075,0, FUEL_TXT_D, "Gripen_Font_black", mfd_strdefs_digit_S )





--===================================================================================================================================================================================
--	[E] engine info, rpm + temp
--===================================================================================================================================================================================

ENGINE_PAGE 			= CreateElement "ceSimple"
ENGINE_PAGE.init_pos	= {0,0}
ENGINE_PAGE.name		= create_guid_string()
ENGINE_PAGE.parent_element	= TAN_LD_MASTER.name
ENGINE_PAGE.element_params = {"LD_LOWER"}
ENGINE_PAGE.controllers    = {{"parameter_compare_with_number",0, 3}}
AddElement(ENGINE_PAGE)

-- Engine RPM

local rpm_indicator		= create_mfd_tex_3k(MFD_ELEMENTS_PDD,275, 860, 1035, 1610)
rpm_indicator.name			= create_guid_string()
rpm_indicator.init_pos		= {-0.58, -0.8}
rpm_indicator.parent_element = ENGINE_PAGE.name
AddElement(rpm_indicator)	

local rpm_needle 		= create_mfd_tex(MFD_ELEMENTS_DARK, 463, 824, 674, 855, 1.3, 473 )
rpm_needle.name			= create_guid_string()
rpm_needle.init_pos		= {0.053, -0.040}
rpm_needle.element_params 	= {"RPM_NEEDLE",}
rpm_needle.init_rot		= {-90, 0}
rpm_needle.controllers		= {{"rotate_using_parameter" ,0, -math.rad(300)/100},}
rpm_needle.parent_element	= rpm_indicator.name
AddElement(rpm_needle)


local Digital_rpm = add_text_param(0.16, -0.19, "RPM_PARAM_U", "%02.0f", rpm_indicator, mfd_strdefs_digit, "Gripen_Font_black", "LeftCenter")

local Digital_rpm_100 = add_text("1", 0.12, -0.19, rpm_indicator , "Gripen_Font_black", mfd_strdefs_digit, "LeftCenter")
Digital_rpm_100.element_params  = {"RPM_PARAM"}
Digital_rpm_100.controllers     = {{"parameter_in_range" ,0,0.9,1.1} }


-- Engine temp

local tgt_indicator		= create_mfd_tex_3k(MFD_ELEMENTS_PDD,1075, 860, 2000, 1583)
tgt_indicator.name			= create_guid_string()
tgt_indicator.init_pos		= {0.15, -0.8}
tgt_indicator.parent_element = ENGINE_PAGE.name
AddElement(tgt_indicator)	

local tgt_needle 		= create_mfd_tex(MFD_ELEMENTS_DARK, 463, 824, 674, 855, 1.3, 473 )
tgt_needle.name			= create_guid_string()
tgt_needle.init_pos		= {0.000, -0.048}
tgt_needle.init_rot		= {-90, 0}
tgt_needle.element_params 	= {"TGT_NEEDLE",}
tgt_needle.controllers		= {{"rotate_using_parameter" ,0, -math.rad(179/680)}}
tgt_needle.parent_element	= tgt_indicator.name
AddElement(tgt_needle)	

local Digital_TGT = add_text_param(0.09, -0.2, "TGT_PARAM", "%02.0f", tgt_indicator, mfd_strdefs_digit, "Gripen_Font_black", "LeftCenter")



--===================================================================================================================================================================================
--	STATIC OBJECTS, stuff that stays the same across pages
--===================================================================================================================================================================================
Ycor = 0.02
local STORE_SCALE = 0.9

local Stores_WINGS			= create_mfd_tex(STORES_WHITE_COLOR,135, 1740, 1920, 1832, STORE_SCALE)
Stores_WINGS.name			= create_guid_string()
Stores_WINGS.init_pos		= {-0.00,-1.25+Ycor }
Stores_WINGS.parent_element	= TAN_LD_MASTER.name
Stores_WINGS.element_params = {"LD_BRIGHTNESS","STORES_TOGGLE" }
Stores_WINGS.controllers    = {JAS_Bright[1],JAS_Bright[2],JAS_Bright[3],JAS_Bright[4],JAS_Bright[5],JAS_Bright[6],JAS_Bright[7],JAS_Bright[8],JAS_Bright[9],JAS_Bright[10],JAS_Bright[11],JAS_Bright[12],JAS_Bright[13],JAS_Bright[14],JAS_Bright[15], JAS_Bright[16],JAS_Bright[17],JAS_Bright[18],JAS_Bright[19],JAS_Bright[20],{"parameter_compare_with_number",1, 1}}
AddElement(Stores_WINGS)

local Stores_GUN_XF		= create_mfd_tex(STORES_BLACK,810, 1570, 1240, 1740, STORE_SCALE)
Stores_GUN_XF.name			= create_guid_string()
Stores_GUN_XF.init_pos		= {-0.0025,-1.235+Ycor }
Stores_GUN_XF.parent_element	= TAN_LD_MASTER.name
Stores_GUN_XF.element_params = {"STORES_TOGGLE"}
Stores_GUN_XF.controllers    = {{"parameter_compare_with_number",0, 1}}
AddElement(Stores_GUN_XF)

local Stores_WPN_BOXES		= create_mfd_tex(STORES_BLACK,35, 1960, 2020, 2045, STORE_SCALE)
Stores_WPN_BOXES.name			= create_guid_string()
Stores_WPN_BOXES.init_pos		= {-0.00,-1.31+Ycor }
Stores_WPN_BOXES.parent_element	= TAN_LD_MASTER.name
Stores_WPN_BOXES.element_params = {"STORES_TOGGLE"}
Stores_WPN_BOXES.controllers    = {{"parameter_compare_with_number",0, 1}}
AddElement(Stores_WPN_BOXES)

local MASS_LIVE				= create_mfd_tex(STORES_BLACK, 830, 610, 975, 680, STORE_SCALE)
MASS_LIVE.name				= create_guid_string()
MASS_LIVE.init_pos			= {-0.48,-1.1833+Ycor}
MASS_LIVE.parent_element	= TAN_LD_MASTER.name
MASS_LIVE.element_params 	= {"STORES_TOGGLE", "MASS_PARAM"}
MASS_LIVE.controllers    	= { {"parameter_compare_with_number",0, 1}, {"parameter_compare_with_number",1, 1} }	
AddElement(MASS_LIVE)

local MASS_STBY				= create_mfd_tex(STORES_BLACK, 820, 710, 1000, 775, STORE_SCALE)
MASS_STBY.name				= create_guid_string()
MASS_STBY.init_pos			= {-0.48,-1.1833+Ycor}
MASS_STBY.parent_element	= TAN_LD_MASTER.name
MASS_STBY.element_params 	= {"STORES_TOGGLE", "MASS_PARAM"}
MASS_STBY.controllers    	= { {"parameter_compare_with_number",0, 1}, {"parameter_compare_with_number",1, 0} }	
AddElement(MASS_STBY)

local MASS_SAFE				= create_mfd_tex(STORES_BLACK, 820, 800, 1000, 875, STORE_SCALE)
MASS_SAFE.name				= create_guid_string()
MASS_SAFE.init_pos			= {-0.48,-1.1833+Ycor}
MASS_SAFE.parent_element	= TAN_LD_MASTER.name
MASS_SAFE.element_params 	= {"STORES_TOGGLE", "MASS_PARAM"}
MASS_SAFE.controllers    	= { {"parameter_compare_with_number",0, 1}, {"parameter_compare_with_number",1, -1} }	
AddElement(MASS_SAFE)

local tan_offset = 1005	--  Tan text is 1005 px to the right of black text in the dds

local Tip_Left_init_pos = {-0.7325,-1.313+Ycor }
local Outer_Left_init_pos = {-0.455,-1.313+Ycor }
local Inner_Left_init_pos = {-0.18,-1.313+Ycor }
local Tip_Right_init_pos = {0.7225,-1.313+Ycor }
local Outer_Right_init_pos = {0.445,-1.313+Ycor }
local Inner_Right_init_pos = {0.1675,-1.313+Ycor }


-- =====================================================================================================
--  Left Wingtip	[   ]
-- =====================================================================================================
-- wpn_LeftTip_Black
local A9L_LT_B			= create_mfd_tex(STORES_BLACK, 0, 0, 200, 100, STORE_SCALE*1.15)
A9L_LT_B.name			= create_guid_string()
A9L_LT_B.init_pos		= Tip_Left_init_pos
A9L_LT_B.parent_element	= TAN_LD_MASTER.name
A9L_LT_B.element_params = {"STORES_TOGGLE", "WINGTIP_L_LOADOUT"}
A9L_LT_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.505,0.515} }	
AddElement(A9L_LT_B)

local A9M_LT_B			= create_mfd_tex(STORES_BLACK, 0, 100, 200, 200, STORE_SCALE*1.15)
A9M_LT_B.name			= create_guid_string()
A9M_LT_B.init_pos		= Tip_Left_init_pos
A9M_LT_B.parent_element	= TAN_LD_MASTER.name
A9M_LT_B.element_params = {"STORES_TOGGLE", "WINGTIP_L_LOADOUT"}
A9M_LT_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.515,0.525} }
AddElement(A9M_LT_B)

local A9X_LT_B			= create_mfd_tex(STORES_BLACK, 0, 200, 200,300, STORE_SCALE*1.15)
A9X_LT_B.name			= create_guid_string()
A9X_LT_B.init_pos		= Tip_Left_init_pos
A9X_LT_B.parent_element	= TAN_LD_MASTER.name
A9X_LT_B.element_params = {"STORES_TOGGLE", "WINGTIP_L_LOADOUT"}
A9X_LT_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.525,0.535} }
AddElement(A9X_LT_B)

local IRIS_LT_B		= create_mfd_tex(STORES_BLACK, 0, 300, 200, 400, STORE_SCALE*1.15)
IRIS_LT_B.name			= create_guid_string()
IRIS_LT_B.init_pos		= Tip_Left_init_pos
IRIS_LT_B.parent_element	= TAN_LD_MASTER.name
IRIS_LT_B.element_params = {"STORES_TOGGLE", "WINGTIP_L_LOADOUT"}
IRIS_LT_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.135,0.145} }
AddElement(IRIS_LT_B)

local PYTH_LT_B		= create_mfd_tex(STORES_BLACK, 0, 400, 200, 500, STORE_SCALE*1.15)
PYTH_LT_B.name			= create_guid_string()
PYTH_LT_B.init_pos		= Tip_Left_init_pos
PYTH_LT_B.parent_element	= TAN_LD_MASTER.name
PYTH_LT_B.element_params = {"STORES_TOGGLE", "WINGTIP_L_LOADOUT"}
PYTH_LT_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.145,0.155} }
AddElement(PYTH_LT_B)

local ADRT_LT_B		= create_mfd_tex(STORES_BLACK, 0, 500, 200, 600, STORE_SCALE*1.15)
ADRT_LT_B.name			= create_guid_string()
ADRT_LT_B.init_pos		= Tip_Left_init_pos
ADRT_LT_B.parent_element	= TAN_LD_MASTER.name
ADRT_LT_B.element_params = {"STORES_TOGGLE", "WINGTIP_L_LOADOUT"}
ADRT_LT_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.155,0.165} }
AddElement(ADRT_LT_B)

local A132_LT_B		= create_mfd_tex(STORES_BLACK, 0, 600, 200,700, STORE_SCALE*1.15)
A132_LT_B.name			= create_guid_string()
A132_LT_B.init_pos		= Tip_Left_init_pos
A132_LT_B.parent_element	= TAN_LD_MASTER.name
A132_LT_B.element_params = {"STORES_TOGGLE", "WINGTIP_L_LOADOUT"}
A132_LT_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.165,0.175} }
AddElement(A132_LT_B)



-- =====================================================================================================
-- Left outer				[   ]
-- =====================================================================================================
-- wpn_LeftOuter_Black
local A9L_LO_B			= create_mfd_tex(STORES_BLACK, 0, 0, 200, 100, STORE_SCALE*1.15)
A9L_LO_B.name			= create_guid_string()
A9L_LO_B.init_pos		= Outer_Left_init_pos
A9L_LO_B.parent_element	= TAN_LD_MASTER.name
A9L_LO_B.element_params = {"STORES_TOGGLE", "OUTER_PYLON_L_LOADOUT"}
A9L_LO_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.505,0.515} }	
AddElement(A9L_LO_B)

local A9M_LO_B			= create_mfd_tex(STORES_BLACK, 0, 100, 200, 200, STORE_SCALE*1.15)
A9M_LO_B.name			= create_guid_string()
A9M_LO_B.init_pos		= Outer_Left_init_pos
A9M_LO_B.parent_element	= TAN_LD_MASTER.name
A9M_LO_B.element_params = {"STORES_TOGGLE", "OUTER_PYLON_L_LOADOUT"}
A9M_LO_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.515,0.525} }
AddElement(A9M_LO_B)

local A9X_LO_B			= create_mfd_tex(STORES_BLACK, 0, 200, 200,300, STORE_SCALE*1.15)
A9X_LO_B.name			= create_guid_string()
A9X_LO_B.init_pos		= Outer_Left_init_pos
A9X_LO_B.parent_element	= TAN_LD_MASTER.name
A9X_LO_B.element_params = {"STORES_TOGGLE", "OUTER_PYLON_L_LOADOUT"}
A9X_LO_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.525,0.535} }
AddElement(A9X_LO_B)

local IRIS_LO_B		= create_mfd_tex(STORES_BLACK, 0, 300, 200, 400, STORE_SCALE*1.15)
IRIS_LO_B.name			= create_guid_string()
IRIS_LO_B.init_pos		= Outer_Left_init_pos
IRIS_LO_B.parent_element	= TAN_LD_MASTER.name
IRIS_LO_B.element_params = {"STORES_TOGGLE", "OUTER_PYLON_L_LOADOUT"}
IRIS_LO_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.135,0.145} }
AddElement(IRIS_LO_B)

local PYTH_LO_B		= create_mfd_tex(STORES_BLACK, 0, 400, 200, 500, STORE_SCALE*1.15)
PYTH_LO_B.name			= create_guid_string()
PYTH_LO_B.init_pos		= Outer_Left_init_pos
PYTH_LO_B.parent_element	= TAN_LD_MASTER.name
PYTH_LO_B.element_params = {"STORES_TOGGLE", "OUTER_PYLON_L_LOADOUT"}
PYTH_LO_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.145,0.155} }
AddElement(PYTH_LO_B)

local ADRT_LO_B		= create_mfd_tex(STORES_BLACK, 0, 500, 200, 600, STORE_SCALE*1.15)
ADRT_LO_B.name			= create_guid_string()
ADRT_LO_B.init_pos		= Outer_Left_init_pos
ADRT_LO_B.parent_element	= TAN_LD_MASTER.name
ADRT_LO_B.element_params = {"STORES_TOGGLE", "OUTER_PYLON_L_LOADOUT"}
ADRT_LO_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.155,0.165} }
AddElement(ADRT_LO_B)

local A132_LO_B		= create_mfd_tex(STORES_BLACK, 0, 600, 200,700, STORE_SCALE*1.15)
A132_LO_B.name			= create_guid_string()
A132_LO_B.init_pos		= Outer_Left_init_pos
A132_LO_B.parent_element	= TAN_LD_MASTER.name
A132_LO_B.element_params = {"STORES_TOGGLE", "OUTER_PYLON_L_LOADOUT"}
A132_LO_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.165,0.175} }
AddElement(A132_LO_B)

local M120B_LO_B		= create_mfd_tex(STORES_BLACK, 200, 0, 400,100, STORE_SCALE*1.15)
M120B_LO_B.name			= create_guid_string()
M120B_LO_B.init_pos		= Outer_Left_init_pos
M120B_LO_B.parent_element	= TAN_LD_MASTER.name
M120B_LO_B.element_params = {"STORES_TOGGLE", "OUTER_PYLON_L_LOADOUT"}
M120B_LO_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.175, 0.185} }
AddElement(M120B_LO_B)

local M120C5_LO_B		= create_mfd_tex(STORES_BLACK, 200,100, 400,200, STORE_SCALE*1.15)
M120C5_LO_B.name			= create_guid_string()
M120C5_LO_B.init_pos		= Outer_Left_init_pos
M120C5_LO_B.parent_element	= TAN_LD_MASTER.name
M120C5_LO_B.element_params = {"STORES_TOGGLE", "OUTER_PYLON_L_LOADOUT"}
M120C5_LO_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.185, 0.195} }
AddElement(M120C5_LO_B)

local M120C7_LO_B		= create_mfd_tex(STORES_BLACK, 200,200, 400,300, STORE_SCALE*1.15)
M120C7_LO_B.name			= create_guid_string()
M120C7_LO_B.init_pos		= Outer_Left_init_pos
M120C7_LO_B.parent_element	= TAN_LD_MASTER.name
M120C7_LO_B.element_params = {"STORES_TOGGLE", "OUTER_PYLON_L_LOADOUT"}
M120C7_LO_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.195, 0.205} }
AddElement(M120C7_LO_B)

local DRBY_LO_B			= create_mfd_tex(STORES_BLACK, 200,400, 400,500, STORE_SCALE*1.15)
DRBY_LO_B.name			= create_guid_string()
DRBY_LO_B.init_pos		= Outer_Left_init_pos
DRBY_LO_B.parent_element	= TAN_LD_MASTER.name
DRBY_LO_B.element_params = {"STORES_TOGGLE", "OUTER_PYLON_L_LOADOUT"}
DRBY_LO_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.205, 0.215} }
AddElement(DRBY_LO_B)

local METR_LO_B		= create_mfd_tex(STORES_BLACK, 200, 300, 400, 400, STORE_SCALE*1.15)
METR_LO_B.name			= create_guid_string()
METR_LO_B.init_pos		= Outer_Left_init_pos
METR_LO_B.parent_element	= TAN_LD_MASTER.name
METR_LO_B.element_params = {"STORES_TOGGLE", "OUTER_PYLON_L_LOADOUT"}
METR_LO_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.215, 0.225} }
AddElement(METR_LO_B)

local AP70_LO_B		= create_mfd_tex(STORES_BLACK, 800, 100, 1000, 200, STORE_SCALE*1.15)
AP70_LO_B.name			= create_guid_string()
AP70_LO_B.init_pos		= Outer_Left_init_pos
AP70_LO_B.parent_element	= TAN_LD_MASTER.name
AP70_LO_B.element_params = {"STORES_TOGGLE", "OUTER_PYLON_L_LOADOUT"}
AP70_LO_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.625,0.635} }
AddElement(AP70_LO_B)

local HE70_LO_B		= create_mfd_tex(STORES_BLACK, 800, 200, 1000, 300, STORE_SCALE*1.15)
HE70_LO_B.name			= create_guid_string()
HE70_LO_B.init_pos		= Outer_Left_init_pos
HE70_LO_B.parent_element	= TAN_LD_MASTER.name
HE70_LO_B.element_params = {"STORES_TOGGLE", "OUTER_PYLON_L_LOADOUT"}
HE70_LO_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.635,0.645} }
AddElement(HE70_LO_B)

local H65_LO_B			= create_mfd_tex(STORES_BLACK, 400,0, 600, 100, STORE_SCALE*1.15)
H65_LO_B.name			= create_guid_string()
H65_LO_B.init_pos		= Outer_Left_init_pos
H65_LO_B.parent_element	= TAN_LD_MASTER.name
H65_LO_B.element_params = {"STORES_TOGGLE", "OUTER_PYLON_L_LOADOUT"}
H65_LO_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.645,0.655} }
AddElement(H65_LO_B)

local K65_LO_B			= create_mfd_tex(STORES_BLACK, 400,100, 600, 200, STORE_SCALE*1.15)
K65_LO_B.name			= create_guid_string()
K65_LO_B.init_pos		= Outer_Left_init_pos
K65_LO_B.parent_element	= TAN_LD_MASTER.name
K65_LO_B.element_params = {"STORES_TOGGLE", "OUTER_PYLON_L_LOADOUT"}
K65_LO_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.655,0.665} }
AddElement(K65_LO_B)

local BMST_LO_B			= create_mfd_tex(STORES_BLACK,  400,203, 600, 300, STORE_SCALE*1.15)
BMST_LO_B.name			= create_guid_string()
BMST_LO_B.init_pos		= Outer_Left_init_pos
BMST_LO_B.parent_element	= TAN_LD_MASTER.name
BMST_LO_B.element_params = {"STORES_TOGGLE", "OUTER_PYLON_L_LOADOUT"}
BMST_LO_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.665,0.675} }
AddElement(BMST_LO_B)

local M71LD_LO_B			= create_mfd_tex(STORES_BLACK, 800 , 0, 1000, 100, STORE_SCALE*1.15)
M71LD_LO_B.name				= create_guid_string()
M71LD_LO_B.init_pos			= Outer_Left_init_pos
M71LD_LO_B.parent_element	= TAN_LD_MASTER.name
M71LD_LO_B.element_params 	= {"STORES_TOGGLE", "OUTER_PYLON_L_LOADOUT"}
M71LD_LO_B.controllers    	= { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.675,0.685} }
AddElement(M71LD_LO_B)

local FF82_LO_B			= create_mfd_tex(STORES_BLACK, 400 , 800, 600, 900, STORE_SCALE*1.15)
FF82_LO_B.name			= create_guid_string()
FF82_LO_B.init_pos		= Outer_Left_init_pos
FF82_LO_B.parent_element	= TAN_LD_MASTER.name
FF82_LO_B.element_params = {"STORES_TOGGLE", "OUTER_PYLON_L_LOADOUT"}
FF82_LO_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.685,0.695} }
AddElement(FF82_LO_B)

local FF83_LO_B			= create_mfd_tex(STORES_BLACK, 400 , 900, 600, 1000, STORE_SCALE*1.15)
FF83_LO_B.name			= create_guid_string()
FF83_LO_B.init_pos		= Outer_Left_init_pos
FF83_LO_B.parent_element	= TAN_LD_MASTER.name
FF83_LO_B.element_params = {"STORES_TOGGLE", "OUTER_PYLON_L_LOADOUT"}
FF83_LO_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.6905,0.705} }
AddElement(FF83_LO_B)

local GB12_LO_B			= create_mfd_tex(STORES_BLACK, 600 , 200, 800, 300, STORE_SCALE*1.15)
GB12_LO_B.name			= create_guid_string()
GB12_LO_B.init_pos		= Outer_Left_init_pos
GB12_LO_B.parent_element	= TAN_LD_MASTER.name
GB12_LO_B.element_params = {"STORES_TOGGLE", "OUTER_PYLON_L_LOADOUT"}
GB12_LO_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.715,0.725} }
AddElement(GB12_LO_B)

local GB16_LO_B			= create_mfd_tex(STORES_BLACK, 600 , 300, 800, 400, STORE_SCALE*1.15) 
GB16_LO_B.name			= create_guid_string()
GB16_LO_B.init_pos		= Outer_Left_init_pos
GB16_LO_B.parent_element	= TAN_LD_MASTER.name
GB16_LO_B.element_params = {"STORES_TOGGLE", "OUTER_PYLON_L_LOADOUT"}
GB16_LO_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.725,0.735} }
AddElement(GB16_LO_B)

local GB39_LO_B			= create_mfd_tex(STORES_BLACK, 600 , 795, 800, 900, STORE_SCALE*1.15)
GB39_LO_B.name			= create_guid_string()
GB39_LO_B.init_pos		= Outer_Left_init_pos
GB39_LO_B.parent_element	= TAN_LD_MASTER.name
GB39_LO_B.element_params = {"STORES_TOGGLE", "OUTER_PYLON_L_LOADOUT"}
GB39_LO_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.745,0.755} }
AddElement(GB39_LO_B)

local GB38_LO_B			= create_mfd_tex(STORES_BLACK, 600 , 700, 800, 800, STORE_SCALE*1.15)
GB38_LO_B.name			= create_guid_string()
GB38_LO_B.init_pos		= Outer_Left_init_pos
GB38_LO_B.parent_element	= TAN_LD_MASTER.name
GB38_LO_B.element_params = {"STORES_TOGGLE", "OUTER_PYLON_L_LOADOUT"}
GB38_LO_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.755,0.765} }
AddElement(GB38_LO_B)

local GB32_LO_B			= create_mfd_tex(STORES_BLACK, 600 , 600, 800, 700, STORE_SCALE*1.15)
GB32_LO_B.name			= create_guid_string()
GB32_LO_B.init_pos		= Outer_Left_init_pos
GB32_LO_B.parent_element	= TAN_LD_MASTER.name
GB32_LO_B.element_params = {"STORES_TOGGLE", "OUTER_PYLON_L_LOADOUT"}
GB32_LO_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.765,0.775} }
AddElement(GB32_LO_B)

local GB49_LO_B			= create_mfd_tex(STORES_BLACK, 600 , 900, 800, 1000, STORE_SCALE*1.15)
GB49_LO_B.name			= create_guid_string()
GB49_LO_B.init_pos		= Outer_Left_init_pos
GB49_LO_B.parent_element	= TAN_LD_MASTER.name
GB49_LO_B.element_params = {"STORES_TOGGLE", "OUTER_PYLON_L_LOADOUT"}
GB49_LO_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.795,0.805} }
AddElement(GB49_LO_B)

local MAR1_LO_B			= create_mfd_tex(STORES_BLACK, 400 ,300, 600, 400, STORE_SCALE*1.15)
MAR1_LO_B.name			= create_guid_string()
MAR1_LO_B.init_pos		= Outer_Left_init_pos
MAR1_LO_B.parent_element	= TAN_LD_MASTER.name
MAR1_LO_B.element_params = {"STORES_TOGGLE", "OUTER_PYLON_L_LOADOUT"}
MAR1_LO_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.805,0.815} }
AddElement(MAR1_LO_B)

local DWST_LO_B			= create_mfd_tex(STORES_BLACK, 400 ,700, 600, 800, STORE_SCALE*1.15)
DWST_LO_B.name			= create_guid_string()
DWST_LO_B.init_pos		= Outer_Left_init_pos
DWST_LO_B.parent_element	= TAN_LD_MASTER.name
DWST_LO_B.element_params = {"STORES_TOGGLE", "OUTER_PYLON_L_LOADOUT"}
DWST_LO_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.815,0.825} }
AddElement(DWST_LO_B)

local DWSA_LO_B			= create_mfd_tex(STORES_BLACK, 400 ,600, 600, 700, STORE_SCALE*1.15)
DWSA_LO_B.name			= create_guid_string()
DWSA_LO_B.init_pos		= Outer_Left_init_pos
DWSA_LO_B.parent_element	= TAN_LD_MASTER.name
DWSA_LO_B.element_params = {"STORES_TOGGLE", "OUTER_PYLON_L_LOADOUT"}
DWSA_LO_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.825,0.835} }
AddElement(DWSA_LO_B)

local RB15_LO_B			= create_mfd_tex(STORES_BLACK, 400 ,400, 600, 500, STORE_SCALE*1.15)
RB15_LO_B.name			= create_guid_string()
RB15_LO_B.init_pos		= Outer_Left_init_pos
RB15_LO_B.parent_element	= TAN_LD_MASTER.name
RB15_LO_B.element_params = {"STORES_TOGGLE", "OUTER_PYLON_L_LOADOUT"}
RB15_LO_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.835,0.845} }
AddElement(RB15_LO_B)

local SPEAR3_LO_B			= create_mfd_tex(STORES_BLACK, 200 ,500, 400, 600, STORE_SCALE*1.15)
SPEAR3_LO_B.name			= create_guid_string()
SPEAR3_LO_B.init_pos		= Outer_Left_init_pos
SPEAR3_LO_B.parent_element	= TAN_LD_MASTER.name
SPEAR3_LO_B.element_params = {"STORES_TOGGLE", "OUTER_PYLON_L_LOADOUT"}
SPEAR3_LO_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.919,0.921} }
AddElement(SPEAR3_LO_B)

local SPEAREW_LO_B			= create_mfd_tex(STORES_BLACK, 200 ,600, 400, 700, STORE_SCALE*1.15)
SPEAREW_LO_B.name			= create_guid_string()
SPEAREW_LO_B.init_pos		= Outer_Left_init_pos
SPEAREW_LO_B.parent_element	= TAN_LD_MASTER.name
SPEAREW_LO_B.element_params = {"STORES_TOGGLE", "OUTER_PYLON_L_LOADOUT"}
SPEAREW_LO_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.929,0.931} }
AddElement(SPEAREW_LO_B)

M71HD_LO_B					= create_mfd_tex(STORES_BLACK, 800, 900, 1000, 1000, STORE_SCALE*1.15)
M71HD_LO_B.name				= create_guid_string()
M71HD_LO_B.init_pos			= Outer_Left_init_pos
M71HD_LO_B.parent_element	= TAN_LD_MASTER.name
M71HD_LO_B.element_params 	= {"STORES_TOGGLE", "OUTER_PYLON_L_LOADOUT"}
M71HD_LO_B.controllers    	= { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.909,0.911} }
AddElement(M71HD_LO_B)


-- =====================================================================================================
-- Left inner							[   ]
-- =====================================================================================================
-- wpn_LeftInner_Black
local A9L_LI_B			= create_mfd_tex(STORES_BLACK, 0, 0, 200, 100, STORE_SCALE*1.15)
A9L_LI_B.name			= create_guid_string()
A9L_LI_B.init_pos		= Inner_Left_init_pos
A9L_LI_B.parent_element	= TAN_LD_MASTER.name
A9L_LI_B.element_params = {"STORES_TOGGLE", "INNER_PYLON_L_LOADOUT"}
A9L_LI_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.505,0.515} }	
AddElement(A9L_LI_B)

local A9M_LI_B			= create_mfd_tex(STORES_BLACK, 0, 100, 200, 200, STORE_SCALE*1.15)
A9M_LI_B.name			= create_guid_string()
A9M_LI_B.init_pos		= Inner_Left_init_pos
A9M_LI_B.parent_element	= TAN_LD_MASTER.name
A9M_LI_B.element_params = {"STORES_TOGGLE", "INNER_PYLON_L_LOADOUT"}
A9M_LI_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.515,0.525} }
AddElement(A9M_LI_B)

local A9X_LI_B			= create_mfd_tex(STORES_BLACK, 0, 200, 200,300, STORE_SCALE*1.15)
A9X_LI_B.name			= create_guid_string()
A9X_LI_B.init_pos		= Inner_Left_init_pos
A9X_LI_B.parent_element	= TAN_LD_MASTER.name
A9X_LI_B.element_params = {"STORES_TOGGLE", "INNER_PYLON_L_LOADOUT"}
A9X_LI_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.525,0.535} }
AddElement(A9X_LI_B)

local IRIS_LI_B		= create_mfd_tex(STORES_BLACK, 0, 300, 200, 400, STORE_SCALE*1.15)
IRIS_LI_B.name			= create_guid_string()
IRIS_LI_B.init_pos		= Inner_Left_init_pos
IRIS_LI_B.parent_element	= TAN_LD_MASTER.name
IRIS_LI_B.element_params = {"STORES_TOGGLE", "INNER_PYLON_L_LOADOUT"}
IRIS_LI_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.135,0.145} }
AddElement(IRIS_LI_B)

local PYTH_LI_B		= create_mfd_tex(STORES_BLACK, 0, 400, 200, 500, STORE_SCALE*1.15)
PYTH_LI_B.name			= create_guid_string()
PYTH_LI_B.init_pos		= Inner_Left_init_pos
PYTH_LI_B.parent_element	= TAN_LD_MASTER.name
PYTH_LI_B.element_params = {"STORES_TOGGLE", "INNER_PYLON_L_LOADOUT"}
PYTH_LI_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.145,0.155} }
AddElement(PYTH_LI_B)

local ADRT_LI_B		= create_mfd_tex(STORES_BLACK, 0, 500, 200, 600, STORE_SCALE*1.15)
ADRT_LI_B.name			= create_guid_string()
ADRT_LI_B.init_pos		= Inner_Left_init_pos
ADRT_LI_B.parent_element	= TAN_LD_MASTER.name
ADRT_LI_B.element_params = {"STORES_TOGGLE", "INNER_PYLON_L_LOADOUT"}
ADRT_LI_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.155,0.165} }
AddElement(ADRT_LI_B)

local A132_LI_B		= create_mfd_tex(STORES_BLACK, 0, 600, 200,700, STORE_SCALE*1.15)
A132_LI_B.name			= create_guid_string()
A132_LI_B.init_pos		= Inner_Left_init_pos
A132_LI_B.parent_element	= TAN_LD_MASTER.name
A132_LI_B.element_params = {"STORES_TOGGLE", "INNER_PYLON_L_LOADOUT"}
A132_LI_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.165,0.175} }
AddElement(A132_LI_B)

local M120B_LI_B		= create_mfd_tex(STORES_BLACK, 200, 0, 400,100, STORE_SCALE*1.15)
M120B_LI_B.name			= create_guid_string()
M120B_LI_B.init_pos		= Inner_Left_init_pos
M120B_LI_B.parent_element	= TAN_LD_MASTER.name
M120B_LI_B.element_params = {"STORES_TOGGLE", "INNER_PYLON_L_LOADOUT"}
M120B_LI_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.175, 0.185} }
AddElement(M120B_LI_B)

local M120C5_LI_B		= create_mfd_tex(STORES_BLACK, 200,100, 400,200, STORE_SCALE*1.15)
M120C5_LI_B.name			= create_guid_string()
M120C5_LI_B.init_pos		= Inner_Left_init_pos
M120C5_LI_B.parent_element	= TAN_LD_MASTER.name
M120C5_LI_B.element_params = {"STORES_TOGGLE", "INNER_PYLON_L_LOADOUT"}
M120C5_LI_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.185, 0.195} }
AddElement(M120C5_LI_B)

local M120C7_LI_B		= create_mfd_tex(STORES_BLACK, 200,200, 400,300, STORE_SCALE*1.15)
M120C7_LI_B.name			= create_guid_string()
M120C7_LI_B.init_pos		= Inner_Left_init_pos
M120C7_LI_B.parent_element	= TAN_LD_MASTER.name
M120C7_LI_B.element_params = {"STORES_TOGGLE", "INNER_PYLON_L_LOADOUT"}
M120C7_LI_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.195, 0.205} }
AddElement(M120C7_LI_B)

local DRBY_LI_B			= create_mfd_tex(STORES_BLACK, 200,400, 400,500, STORE_SCALE*1.15)
DRBY_LI_B.name			= create_guid_string()
DRBY_LI_B.init_pos		= Inner_Left_init_pos
DRBY_LI_B.parent_element	= TAN_LD_MASTER.name
DRBY_LI_B.element_params = {"STORES_TOGGLE", "INNER_PYLON_L_LOADOUT"}
DRBY_LI_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.205, 0.215} }
AddElement(DRBY_LI_B)

local METR_LI_B		= create_mfd_tex(STORES_BLACK, 200,300, 400,400, STORE_SCALE*1.15)
METR_LI_B.name			= create_guid_string()
METR_LI_B.init_pos		= Inner_Left_init_pos
METR_LI_B.parent_element	= TAN_LD_MASTER.name
METR_LI_B.element_params = {"STORES_TOGGLE", "INNER_PYLON_L_LOADOUT"}
METR_LI_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.215, 0.225} }
AddElement(METR_LI_B)

local AP70_LI_B		= create_mfd_tex(STORES_BLACK, 800, 100, 1000, 200, STORE_SCALE*1.15)
AP70_LI_B.name			= create_guid_string()
AP70_LI_B.init_pos		= Inner_Left_init_pos
AP70_LI_B.parent_element	= TAN_LD_MASTER.name
AP70_LI_B.element_params = {"STORES_TOGGLE", "INNER_PYLON_L_LOADOUT"}
AP70_LI_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.625,0.635} }
AddElement(AP70_LI_B)

local HE70_LI_B		= create_mfd_tex(STORES_BLACK, 800, 200, 1000, 300, STORE_SCALE*1.15)
HE70_LI_B.name			= create_guid_string()
HE70_LI_B.init_pos		= Inner_Left_init_pos
HE70_LI_B.parent_element	= TAN_LD_MASTER.name
HE70_LI_B.element_params = {"STORES_TOGGLE", "INNER_PYLON_L_LOADOUT"}
HE70_LI_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.635,0.645} }
AddElement(HE70_LI_B)

local H65_LI_B			= create_mfd_tex(STORES_BLACK, 400,0, 600, 100, STORE_SCALE*1.15)
H65_LI_B.name			= create_guid_string()
H65_LI_B.init_pos		= Inner_Left_init_pos
H65_LI_B.parent_element	= TAN_LD_MASTER.name
H65_LI_B.element_params = {"STORES_TOGGLE", "INNER_PYLON_L_LOADOUT"}
H65_LI_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.645,0.655} }
AddElement(H65_LI_B)

local K65_LI_B			= create_mfd_tex(STORES_BLACK, 400,100, 600, 200, STORE_SCALE*1.15)
K65_LI_B.name			= create_guid_string()
K65_LI_B.init_pos		= Inner_Left_init_pos
K65_LI_B.parent_element	= TAN_LD_MASTER.name
K65_LI_B.element_params = {"STORES_TOGGLE", "INNER_PYLON_L_LOADOUT"}
K65_LI_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.655,0.665} }
AddElement(K65_LI_B)

local BMST_LI_B			= create_mfd_tex(STORES_BLACK, 400,203, 600, 300, STORE_SCALE*1.15)
BMST_LI_B.name			= create_guid_string()
BMST_LI_B.init_pos		= Inner_Left_init_pos
BMST_LI_B.parent_element	= TAN_LD_MASTER.name
BMST_LI_B.element_params = {"STORES_TOGGLE", "INNER_PYLON_L_LOADOUT"}
BMST_LI_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.665,0.675} }
AddElement(BMST_LI_B)


local M71LD_LI_B			= create_mfd_tex(STORES_BLACK, 800 , 0, 1000, 100, STORE_SCALE*1.15)
M71LD_LI_B.name				= create_guid_string()
M71LD_LI_B.init_pos			= Inner_Left_init_pos
M71LD_LI_B.parent_element	= TAN_LD_MASTER.name
M71LD_LI_B.element_params 	= {"STORES_TOGGLE", "INNER_PYLON_L_LOADOUT"}
M71LD_LI_B.controllers    	= { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.675,0.685} }
AddElement(M71LD_LI_B)

local FF82_LI_B			= create_mfd_tex(STORES_BLACK, 400 , 800, 600, 900, STORE_SCALE*1.15)
FF82_LI_B.name			= create_guid_string()
FF82_LI_B.init_pos		= Inner_Left_init_pos
FF82_LI_B.parent_element	= TAN_LD_MASTER.name
FF82_LI_B.element_params = {"STORES_TOGGLE", "INNER_PYLON_L_LOADOUT"}
FF82_LI_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.685,0.695} }
AddElement(FF82_LI_B)

local FF83_LI_B			= create_mfd_tex(STORES_BLACK, 400 , 900, 600, 1000, STORE_SCALE*1.15)
FF83_LI_B.name			= create_guid_string()
FF83_LI_B.init_pos		= Inner_Left_init_pos
FF83_LI_B.parent_element	= TAN_LD_MASTER.name
FF83_LI_B.element_params = {"STORES_TOGGLE", "INNER_PYLON_L_LOADOUT"}
FF83_LI_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.6905,0.705} }
AddElement(FF83_LI_B)

local FF84_LI_B			= create_mfd_tex(STORES_BLACK, 600 , 0, 800, 100, STORE_SCALE*1.15)
FF84_LI_B.name			= create_guid_string()
FF84_LI_B.init_pos		= Inner_Left_init_pos
FF84_LI_B.parent_element	= TAN_LD_MASTER.name
FF84_LI_B.element_params = {"STORES_TOGGLE", "INNER_PYLON_L_LOADOUT"}
FF84_LI_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.705,0.715} }
AddElement(FF84_LI_B)

local GB12_LI_B			= create_mfd_tex(STORES_BLACK, 600 , 200, 800, 300, STORE_SCALE*1.15)
GB12_LI_B.name			= create_guid_string()
GB12_LI_B.init_pos		= Inner_Left_init_pos
GB12_LI_B.parent_element	= TAN_LD_MASTER.name
GB12_LI_B.element_params = {"STORES_TOGGLE", "INNER_PYLON_L_LOADOUT"}
GB12_LI_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.715,0.725} }
AddElement(GB12_LI_B)

local GB16_LI_B			= create_mfd_tex(STORES_BLACK, 600 , 300, 800, 400, STORE_SCALE*1.15) 
GB16_LI_B.name			= create_guid_string()
GB16_LI_B.init_pos		= Inner_Left_init_pos
GB16_LI_B.parent_element	= TAN_LD_MASTER.name
GB16_LI_B.element_params = {"STORES_TOGGLE", "INNER_PYLON_L_LOADOUT"}
GB16_LI_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.725,0.735} }
AddElement(GB16_LI_B)

local GB10_LI_B			= create_mfd_tex(STORES_BLACK, 600 , 100, 800, 200, STORE_SCALE*1.15) 
GB10_LI_B.name			= create_guid_string()
GB10_LI_B.init_pos		= Inner_Left_init_pos
GB10_LI_B.parent_element	= TAN_LD_MASTER.name
GB10_LI_B.element_params = {"STORES_TOGGLE", "INNER_PYLON_L_LOADOUT"}
GB10_LI_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.735,0.745} }
AddElement(GB10_LI_B)

local GB39_LI_B			= create_mfd_tex(STORES_BLACK, 600 , 795, 800, 900, STORE_SCALE*1.15)
GB39_LI_B.name			= create_guid_string()
GB39_LI_B.init_pos		= Inner_Left_init_pos
GB39_LI_B.parent_element	= TAN_LD_MASTER.name
GB39_LI_B.element_params = {"STORES_TOGGLE", "INNER_PYLON_L_LOADOUT"}
GB39_LI_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.745,0.755} }
AddElement(GB39_LI_B)

local GB38_LI_B			= create_mfd_tex(STORES_BLACK, 600 , 700, 800, 800, STORE_SCALE*1.15)
GB38_LI_B.name			= create_guid_string()
GB38_LI_B.init_pos		= Inner_Left_init_pos
GB38_LI_B.parent_element	= TAN_LD_MASTER.name
GB38_LI_B.element_params = {"STORES_TOGGLE", "INNER_PYLON_L_LOADOUT"}
GB38_LI_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.755,0.765} }
AddElement(GB38_LI_B)

local GB32_LI_B			= create_mfd_tex(STORES_BLACK, 600 , 600, 800, 700, STORE_SCALE*1.15)
GB32_LI_B.name			= create_guid_string()
GB32_LI_B.init_pos		= Inner_Left_init_pos
GB32_LI_B.parent_element	= TAN_LD_MASTER.name
GB32_LI_B.element_params = {"STORES_TOGGLE", "INNER_PYLON_L_LOADOUT"}
GB32_LI_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.765,0.775} }
AddElement(GB32_LI_B)

local GB31_LI_B			= create_mfd_tex(STORES_BLACK, 600 , 400, 800, 500, STORE_SCALE*1.15)
GB31_LI_B.name			= create_guid_string()
GB31_LI_B.init_pos		= Inner_Left_init_pos
GB31_LI_B.parent_element	= TAN_LD_MASTER.name
GB31_LI_B.element_params = {"STORES_TOGGLE", "INNER_PYLON_L_LOADOUT"}
GB31_LI_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.775,0.785} }
AddElement(GB31_LI_B)

local G31B_LI_B			= create_mfd_tex(STORES_BLACK, 600 , 500, 800, 600, STORE_SCALE*1.15)
G31B_LI_B.name			= create_guid_string()
G31B_LI_B.init_pos		= Inner_Left_init_pos
G31B_LI_B.parent_element	= TAN_LD_MASTER.name
G31B_LI_B.element_params = {"STORES_TOGGLE", "INNER_PYLON_L_LOADOUT"}
G31B_LI_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.785,0.795} }
AddElement(G31B_LI_B)

local GB49_LI_B			= create_mfd_tex(STORES_BLACK, 600 , 900, 800, 1000, STORE_SCALE*1.15)
GB49_LI_B.name			= create_guid_string()
GB49_LI_B.init_pos		= Inner_Left_init_pos
GB49_LI_B.parent_element	= TAN_LD_MASTER.name
GB49_LI_B.element_params = {"STORES_TOGGLE", "INNER_PYLON_L_LOADOUT"}
GB49_LI_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.795,0.805} }
AddElement(GB49_LI_B)

local MAR1_LI_B			= create_mfd_tex(STORES_BLACK, 400 ,300, 600, 400, STORE_SCALE*1.15)
MAR1_LI_B.name			= create_guid_string()
MAR1_LI_B.init_pos		= Inner_Left_init_pos
MAR1_LI_B.parent_element	= TAN_LD_MASTER.name
MAR1_LI_B.element_params = {"STORES_TOGGLE", "INNER_PYLON_L_LOADOUT"}
MAR1_LI_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.805,0.815} }
AddElement(MAR1_LI_B)

local DWST_LI_B			= create_mfd_tex(STORES_BLACK, 400 ,700, 600, 800, STORE_SCALE*1.15)
DWST_LI_B.name			= create_guid_string()
DWST_LI_B.init_pos		= Inner_Left_init_pos
DWST_LI_B.parent_element	= TAN_LD_MASTER.name
DWST_LI_B.element_params = {"STORES_TOGGLE", "INNER_PYLON_L_LOADOUT"}
DWST_LI_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.815,0.825} }
AddElement(DWST_LI_B)

local DWSA_LI_B			= create_mfd_tex(STORES_BLACK, 400 ,600, 600, 700, STORE_SCALE*1.15)
DWSA_LI_B.name			= create_guid_string()
DWSA_LI_B.init_pos		= Inner_Left_init_pos
DWSA_LI_B.parent_element	= TAN_LD_MASTER.name
DWSA_LI_B.element_params = {"STORES_TOGGLE", "INNER_PYLON_L_LOADOUT"}
DWSA_LI_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.825,0.835} }
AddElement(DWSA_LI_B)

local RB15_LI_B			= create_mfd_tex(STORES_BLACK, 400 ,400, 600, 500, STORE_SCALE*1.15)
RB15_LI_B.name			= create_guid_string()
RB15_LI_B.init_pos		= Inner_Left_init_pos
RB15_LI_B.parent_element	= TAN_LD_MASTER.name
RB15_LI_B.element_params = {"STORES_TOGGLE", "INNER_PYLON_L_LOADOUT"}
RB15_LI_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.835,0.845} }
AddElement(RB15_LI_B)

local STRM_LI_B			= create_mfd_tex(STORES_BLACK, 400 ,500, 600, 600, STORE_SCALE*1.15)
STRM_LI_B.name			= create_guid_string()
STRM_LI_B.init_pos		= Inner_Left_init_pos
STRM_LI_B.parent_element	= TAN_LD_MASTER.name
STRM_LI_B.element_params = {"STORES_TOGGLE", "INNER_PYLON_L_LOADOUT"}
STRM_LI_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.845,0.855} }
AddElement(STRM_LI_B)

local XF11_LI_B			= create_mfd_tex(STORES_BLACK, 800 ,300, 1000,400, STORE_SCALE*1.15)
XF11_LI_B.name			= create_guid_string()
XF11_LI_B.init_pos		= Inner_Left_init_pos
XF11_LI_B.parent_element	= TAN_LD_MASTER.name
XF11_LI_B.element_params = {"STORES_TOGGLE", "INNER_PYLON_L_LOADOUT"}
XF11_LI_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.895,0.905} }
AddElement(XF11_LI_B)

local SPEAR3_LI_B			= create_mfd_tex(STORES_BLACK, 200 ,500, 400, 600, STORE_SCALE*1.15)
SPEAR3_LI_B.name			= create_guid_string()
SPEAR3_LI_B.init_pos		= Inner_Left_init_pos
SPEAR3_LI_B.parent_element	= TAN_LD_MASTER.name
SPEAR3_LI_B.element_params = {"STORES_TOGGLE", "INNER_PYLON_L_LOADOUT"}
SPEAR3_LI_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.919,0.921} }
AddElement(SPEAR3_LI_B)

local SPEAREW_LI_B			= create_mfd_tex(STORES_BLACK, 200 ,600, 400, 700, STORE_SCALE*1.15)
SPEAREW_LI_B.name			= create_guid_string()
SPEAREW_LI_B.init_pos		= Inner_Left_init_pos
SPEAREW_LI_B.parent_element	= TAN_LD_MASTER.name
SPEAREW_LI_B.element_params = {"STORES_TOGGLE", "INNER_PYLON_L_LOADOUT"}
SPEAREW_LI_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.929,0.931} }
AddElement(SPEAREW_LI_B)

KEPD_LI_B					= create_mfd_tex(STORES_BLACK, 200 ,700, 400, 800, STORE_SCALE*1.15)
KEPD_LI_B.name				= create_guid_string()
KEPD_LI_B.init_pos			= Inner_Left_init_pos
KEPD_LI_B.parent_element	= TAN_LD_MASTER.name
KEPD_LI_B.element_params	= {"STORES_TOGGLE", "INNER_PYLON_L_LOADOUT"}
KEPD_LI_B.controllers    	= { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.939,0.941} }
AddElement(KEPD_LI_B)

M71HD_LI_B					= create_mfd_tex(STORES_BLACK, 800, 900, 1000, 1000, STORE_SCALE*1.15)
M71HD_LI_B.name				= create_guid_string()
M71HD_LI_B.init_pos			= Inner_Left_init_pos
M71HD_LI_B.parent_element	= TAN_LD_MASTER.name
M71HD_LI_B.element_params	= {"STORES_TOGGLE", "INNER_PYLON_L_LOADOUT"}
M71HD_LI_B.controllers    	= { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.909,0.911} }
AddElement(M71HD_LI_B)


-- Centerline pylon 	==================================================================================================




-- Cheek pylon 	==================================================================================================
local LDP			= create_mfd_tex(STORES_BLACK, 800 ,500, 1000,600, STORE_SCALE*1.15)
LDP.name			= create_guid_string()
LDP.init_pos		= {0.08,-1.195 }
LDP.parent_element	= TAN_LD_MASTER.name
LDP.element_params = {"STORES_TOGGLE", "CHEEK_PYLON_LOADOUT"}
LDP.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.855,0.865} }
AddElement(LDP)

-- =====================================================================================================
-- Right inner										[   ]
-- =====================================================================================================
-- wpn_RightInner_Black
local A9L_RI_B			= create_mfd_tex(STORES_BLACK, 0, 0, 200, 100, STORE_SCALE*1.15)
A9L_RI_B.name			= create_guid_string()
A9L_RI_B.init_pos		= Inner_Right_init_pos
A9L_RI_B.parent_element	= TAN_LD_MASTER.name
A9L_RI_B.element_params = {"STORES_TOGGLE", "INNER_PYLON_R_LOADOUT"}
A9L_RI_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.505,0.515} }	
AddElement(A9L_RI_B)

local A9M_RI_B			= create_mfd_tex(STORES_BLACK, 0, 100, 200, 200, STORE_SCALE*1.15)
A9M_RI_B.name			= create_guid_string()
A9M_RI_B.init_pos		= Inner_Right_init_pos
A9M_RI_B.parent_element	= TAN_LD_MASTER.name
A9M_RI_B.element_params = {"STORES_TOGGLE", "INNER_PYLON_R_LOADOUT"}
A9M_RI_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.515,0.525} }
AddElement(A9M_RI_B)

local A9X_RI_B			= create_mfd_tex(STORES_BLACK, 0, 200, 200,300, STORE_SCALE*1.15)
A9X_RI_B.name			= create_guid_string()
A9X_RI_B.init_pos		= Inner_Right_init_pos
A9X_RI_B.parent_element	= TAN_LD_MASTER.name
A9X_RI_B.element_params = {"STORES_TOGGLE", "INNER_PYLON_R_LOADOUT"}
A9X_RI_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.525,0.535} }
AddElement(A9X_RI_B)

local IRIS_RI_B		= create_mfd_tex(STORES_BLACK, 0, 300, 200, 400, STORE_SCALE*1.15)
IRIS_RI_B.name			= create_guid_string()
IRIS_RI_B.init_pos		= Inner_Right_init_pos
IRIS_RI_B.parent_element	= TAN_LD_MASTER.name
IRIS_RI_B.element_params = {"STORES_TOGGLE", "INNER_PYLON_R_LOADOUT"}
IRIS_RI_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.135,0.145} }
AddElement(IRIS_RI_B)

local PYTH_RI_B		= create_mfd_tex(STORES_BLACK, 0, 400, 200, 500, STORE_SCALE*1.15)
PYTH_RI_B.name			= create_guid_string()
PYTH_RI_B.init_pos		= Inner_Right_init_pos
PYTH_RI_B.parent_element	= TAN_LD_MASTER.name
PYTH_RI_B.element_params = {"STORES_TOGGLE", "INNER_PYLON_R_LOADOUT"}
PYTH_RI_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.145,0.155} }
AddElement(PYTH_RI_B)

local ADRT_RI_B		= create_mfd_tex(STORES_BLACK, 0, 500, 200, 600, STORE_SCALE*1.15)
ADRT_RI_B.name			= create_guid_string()
ADRT_RI_B.init_pos		= Inner_Right_init_pos
ADRT_RI_B.parent_element	= TAN_LD_MASTER.name
ADRT_RI_B.element_params = {"STORES_TOGGLE", "INNER_PYLON_R_LOADOUT"}
ADRT_RI_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.155,0.165} }
AddElement(ADRT_RI_B)

local A132_RI_B		= create_mfd_tex(STORES_BLACK, 0, 600, 200,700, STORE_SCALE*1.15)
A132_RI_B.name			= create_guid_string()
A132_RI_B.init_pos		= Inner_Right_init_pos
A132_RI_B.parent_element	= TAN_LD_MASTER.name
A132_RI_B.element_params = {"STORES_TOGGLE", "INNER_PYLON_R_LOADOUT"}
A132_RI_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.165,0.175} }
AddElement(A132_RI_B)

local M120B_RI_B		= create_mfd_tex(STORES_BLACK, 200, 0, 400,100, STORE_SCALE*1.15)
M120B_RI_B.name			= create_guid_string()
M120B_RI_B.init_pos		= Inner_Right_init_pos
M120B_RI_B.parent_element	= TAN_LD_MASTER.name
M120B_RI_B.element_params = {"STORES_TOGGLE", "INNER_PYLON_R_LOADOUT"}
M120B_RI_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.175, 0.185} }
AddElement(M120B_RI_B)

local M120C5_RI_B		= create_mfd_tex(STORES_BLACK, 200,100, 400,200, STORE_SCALE*1.15)
M120C5_RI_B.name			= create_guid_string()
M120C5_RI_B.init_pos		= Inner_Right_init_pos
M120C5_RI_B.parent_element	= TAN_LD_MASTER.name
M120C5_RI_B.element_params = {"STORES_TOGGLE", "INNER_PYLON_R_LOADOUT"}
M120C5_RI_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.185, 0.195} }
AddElement(M120C5_RI_B)

local M120C7_RI_B		= create_mfd_tex(STORES_BLACK, 200,200, 400,300, STORE_SCALE*1.15)
M120C7_RI_B.name			= create_guid_string()
M120C7_RI_B.init_pos		= Inner_Right_init_pos
M120C7_RI_B.parent_element	= TAN_LD_MASTER.name
M120C7_RI_B.element_params = {"STORES_TOGGLE", "INNER_PYLON_R_LOADOUT"}
M120C7_RI_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.195, 0.205} }
AddElement(M120C7_RI_B)

local DRBY_RI_B			= create_mfd_tex(STORES_BLACK, 200,400, 400,500, STORE_SCALE*1.15)
DRBY_RI_B.name			= create_guid_string()
DRBY_RI_B.init_pos		= Inner_Right_init_pos
DRBY_RI_B.parent_element	= TAN_LD_MASTER.name
DRBY_RI_B.element_params = {"STORES_TOGGLE", "INNER_PYLON_R_LOADOUT"}
DRBY_RI_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.205, 0.215} }
AddElement(DRBY_RI_B)

local METR_RI_B		= create_mfd_tex(STORES_BLACK, 200,300, 400,400, STORE_SCALE*1.15)
METR_RI_B.name			= create_guid_string()
METR_RI_B.init_pos		= Inner_Right_init_pos
METR_RI_B.parent_element	= TAN_LD_MASTER.name
METR_RI_B.element_params = {"STORES_TOGGLE", "INNER_PYLON_R_LOADOUT"}
METR_RI_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.215, 0.225} }
AddElement(METR_RI_B)

local AP70_RI_B		= create_mfd_tex(STORES_BLACK, 800, 100, 1000, 200, STORE_SCALE*1.15)
AP70_RI_B.name			= create_guid_string()
AP70_RI_B.init_pos		= Inner_Right_init_pos
AP70_RI_B.parent_element	= TAN_LD_MASTER.name
AP70_RI_B.element_params = {"STORES_TOGGLE", "INNER_PYLON_R_LOADOUT"}
AP70_RI_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.625,0.635} }
AddElement(AP70_RI_B)

local HE70_RI_B		= create_mfd_tex(STORES_BLACK, 800, 200, 1000, 300, STORE_SCALE*1.15)
HE70_RI_B.name			= create_guid_string()
HE70_RI_B.init_pos		= Inner_Right_init_pos
HE70_RI_B.parent_element	= TAN_LD_MASTER.name
HE70_RI_B.element_params = {"STORES_TOGGLE", "INNER_PYLON_R_LOADOUT"}
HE70_RI_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.635,0.645} }
AddElement(HE70_RI_B)

local H65_RI_B			= create_mfd_tex(STORES_BLACK, 400,0, 600, 100, STORE_SCALE*1.15)
H65_RI_B.name			= create_guid_string()
H65_RI_B.init_pos		= Inner_Right_init_pos
H65_RI_B.parent_element	= TAN_LD_MASTER.name
H65_RI_B.element_params = {"STORES_TOGGLE", "INNER_PYLON_R_LOADOUT"}
H65_RI_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.645,0.655} }
AddElement(H65_RI_B)

local K65_RI_B			= create_mfd_tex(STORES_BLACK, 400,100, 600, 200, STORE_SCALE*1.15)
K65_RI_B.name			= create_guid_string()
K65_RI_B.init_pos		= Inner_Right_init_pos
K65_RI_B.parent_element	= TAN_LD_MASTER.name
K65_RI_B.element_params = {"STORES_TOGGLE", "INNER_PYLON_R_LOADOUT"}
K65_RI_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.655,0.665} }
AddElement(K65_RI_B)

local BMST_RI_B			= create_mfd_tex(STORES_BLACK, 400,203, 600, 300, STORE_SCALE*1.15)
BMST_RI_B.name			= create_guid_string()
BMST_RI_B.init_pos		= Inner_Right_init_pos
BMST_RI_B.parent_element	= TAN_LD_MASTER.name
BMST_RI_B.element_params = {"STORES_TOGGLE", "INNER_PYLON_R_LOADOUT"}
BMST_RI_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.665,0.675} }
AddElement(BMST_RI_B)


local M71LD_RI_B			= create_mfd_tex(STORES_BLACK, 800 , 0, 1000, 100, STORE_SCALE*1.15)
M71LD_RI_B.name			= create_guid_string()
M71LD_RI_B.init_pos		= Inner_Right_init_pos
M71LD_RI_B.parent_element	= TAN_LD_MASTER.name
M71LD_RI_B.element_params = {"STORES_TOGGLE", "INNER_PYLON_R_LOADOUT"}
M71LD_RI_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.675,0.685} }
AddElement(M71LD_RI_B)

local FF82_RI_B			= create_mfd_tex(STORES_BLACK, 400 , 800, 600, 900, STORE_SCALE*1.15)
FF82_RI_B.name			= create_guid_string()
FF82_RI_B.init_pos		= Inner_Right_init_pos
FF82_RI_B.parent_element	= TAN_LD_MASTER.name
FF82_RI_B.element_params = {"STORES_TOGGLE", "INNER_PYLON_R_LOADOUT"}
FF82_RI_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.685,0.695} }
AddElement(FF82_RI_B)

local FF83_RI_B			= create_mfd_tex(STORES_BLACK, 400 , 900, 600, 1000, STORE_SCALE*1.15)
FF83_RI_B.name			= create_guid_string()
FF83_RI_B.init_pos		= Inner_Right_init_pos
FF83_RI_B.parent_element	= TAN_LD_MASTER.name
FF83_RI_B.element_params = {"STORES_TOGGLE", "INNER_PYLON_R_LOADOUT"}
FF83_RI_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.6905,0.705} }
AddElement(FF83_RI_B)

local FF84_RI_B			= create_mfd_tex(STORES_BLACK, 600 , 0, 800, 100, STORE_SCALE*1.15)
FF84_RI_B.name			= create_guid_string()
FF84_RI_B.init_pos		= Inner_Right_init_pos
FF84_RI_B.parent_element	= TAN_LD_MASTER.name
FF84_RI_B.element_params = {"STORES_TOGGLE", "INNER_PYLON_R_LOADOUT"}
FF84_RI_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.705,0.715} }
AddElement(FF84_RI_B)

local GB12_RI_B			= create_mfd_tex(STORES_BLACK, 600 , 200, 800, 300, STORE_SCALE*1.15)
GB12_RI_B.name			= create_guid_string()
GB12_RI_B.init_pos		= Inner_Right_init_pos
GB12_RI_B.parent_element	= TAN_LD_MASTER.name
GB12_RI_B.element_params = {"STORES_TOGGLE", "INNER_PYLON_R_LOADOUT"}
GB12_RI_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.715,0.725} }
AddElement(GB12_RI_B)

local GB16_RI_B			= create_mfd_tex(STORES_BLACK, 600 , 300, 800, 400, STORE_SCALE*1.15) 
GB16_RI_B.name			= create_guid_string()
GB16_RI_B.init_pos		= Inner_Right_init_pos
GB16_RI_B.parent_element	= TAN_LD_MASTER.name
GB16_RI_B.element_params = {"STORES_TOGGLE", "INNER_PYLON_R_LOADOUT"}
GB16_RI_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.725,0.735} }
AddElement(GB16_RI_B)

local GB10_RI_B			= create_mfd_tex(STORES_BLACK, 600 , 100, 800, 200, STORE_SCALE*1.15) 
GB10_RI_B.name			= create_guid_string()
GB10_RI_B.init_pos		= Inner_Right_init_pos
GB10_RI_B.parent_element	= TAN_LD_MASTER.name
GB10_RI_B.element_params = {"STORES_TOGGLE", "INNER_PYLON_R_LOADOUT"}
GB10_RI_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.735,0.745} }
AddElement(GB10_RI_B)

local GB39_RI_B			= create_mfd_tex(STORES_BLACK, 600 , 795, 800, 900, STORE_SCALE*1.15)
GB39_RI_B.name			= create_guid_string()
GB39_RI_B.init_pos		= Inner_Right_init_pos
GB39_RI_B.parent_element	= TAN_LD_MASTER.name
GB39_RI_B.element_params = {"STORES_TOGGLE", "INNER_PYLON_R_LOADOUT"}
GB39_RI_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.745,0.755} }
AddElement(GB39_RI_B)

local GB38_RI_B			= create_mfd_tex(STORES_BLACK, 600 , 700, 800, 800, STORE_SCALE*1.15)
GB38_RI_B.name			= create_guid_string()
GB38_RI_B.init_pos		= Inner_Right_init_pos
GB38_RI_B.parent_element	= TAN_LD_MASTER.name
GB38_RI_B.element_params = {"STORES_TOGGLE", "INNER_PYLON_R_LOADOUT"}
GB38_RI_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.755,0.765} }
AddElement(GB38_RI_B)

local GB32_RI_B			= create_mfd_tex(STORES_BLACK, 600 , 600, 800, 700, STORE_SCALE*1.15)
GB32_RI_B.name			= create_guid_string()
GB32_RI_B.init_pos		= Inner_Right_init_pos
GB32_RI_B.parent_element	= TAN_LD_MASTER.name
GB32_RI_B.element_params = {"STORES_TOGGLE", "INNER_PYLON_R_LOADOUT"}
GB32_RI_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.765,0.775} }
AddElement(GB32_RI_B)

local GB31_RI_B			= create_mfd_tex(STORES_BLACK, 600 , 400, 800, 500, STORE_SCALE*1.15)
GB31_RI_B.name			= create_guid_string()
GB31_RI_B.init_pos		= Inner_Right_init_pos
GB31_RI_B.parent_element	= TAN_LD_MASTER.name
GB31_RI_B.element_params = {"STORES_TOGGLE", "INNER_PYLON_R_LOADOUT"}
GB31_RI_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.775,0.785} }
AddElement(GB31_RI_B)

local G31B_RI_B			= create_mfd_tex(STORES_BLACK, 600 , 500, 800, 600, STORE_SCALE*1.15)
G31B_RI_B.name			= create_guid_string()
G31B_RI_B.init_pos		= Inner_Right_init_pos
G31B_RI_B.parent_element	= TAN_LD_MASTER.name
G31B_RI_B.element_params = {"STORES_TOGGLE", "INNER_PYLON_R_LOADOUT"}
G31B_RI_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.785,0.795} }
AddElement(G31B_RI_B)

local GB49_RI_B			= create_mfd_tex(STORES_BLACK, 600 , 900, 800, 1000, STORE_SCALE*1.15)
GB49_RI_B.name			= create_guid_string()
GB49_RI_B.init_pos		= Inner_Right_init_pos
GB49_RI_B.parent_element	= TAN_LD_MASTER.name
GB49_RI_B.element_params = {"STORES_TOGGLE", "INNER_PYLON_R_LOADOUT"}
GB49_RI_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.795,0.805} }
AddElement(GB49_RI_B)

local MAR1_RI_B			= create_mfd_tex(STORES_BLACK, 400 ,300, 600, 400, STORE_SCALE*1.15)
MAR1_RI_B.name			= create_guid_string()
MAR1_RI_B.init_pos		= Inner_Right_init_pos
MAR1_RI_B.parent_element	= TAN_LD_MASTER.name
MAR1_RI_B.element_params = {"STORES_TOGGLE", "INNER_PYLON_R_LOADOUT"}
MAR1_RI_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.805,0.815} }
AddElement(MAR1_RI_B)

local DWST_RI_B			= create_mfd_tex(STORES_BLACK, 400 ,700, 600, 800, STORE_SCALE*1.15)
DWST_RI_B.name			= create_guid_string()
DWST_RI_B.init_pos		= Inner_Right_init_pos
DWST_RI_B.parent_element	= TAN_LD_MASTER.name
DWST_RI_B.element_params = {"STORES_TOGGLE", "INNER_PYLON_R_LOADOUT"}
DWST_RI_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.815,0.825} }
AddElement(DWST_RI_B)

local DWSA_RI_B			= create_mfd_tex(STORES_BLACK, 400 ,600, 600, 700, STORE_SCALE*1.15)
DWSA_RI_B.name			= create_guid_string()
DWSA_RI_B.init_pos		= Inner_Right_init_pos
DWSA_RI_B.parent_element	= TAN_LD_MASTER.name
DWSA_RI_B.element_params = {"STORES_TOGGLE", "INNER_PYLON_R_LOADOUT"}
DWSA_RI_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.825,0.835} }
AddElement(DWSA_RI_B)

local RB15_RI_B			= create_mfd_tex(STORES_BLACK, 400 ,400, 600, 500, STORE_SCALE*1.15)
RB15_RI_B.name			= create_guid_string()
RB15_RI_B.init_pos		= Inner_Right_init_pos
RB15_RI_B.parent_element	= TAN_LD_MASTER.name
RB15_RI_B.element_params = {"STORES_TOGGLE", "INNER_PYLON_R_LOADOUT"}
RB15_RI_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.835,0.845} }
AddElement(RB15_RI_B)

local STRM_RI_B			= create_mfd_tex(STORES_BLACK, 400 ,500, 600, 600, STORE_SCALE*1.15)
STRM_RI_B.name			= create_guid_string()
STRM_RI_B.init_pos		= Inner_Right_init_pos
STRM_RI_B.parent_element	= TAN_LD_MASTER.name
STRM_RI_B.element_params = {"STORES_TOGGLE", "INNER_PYLON_R_LOADOUT"}
STRM_RI_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.845,0.855} }
AddElement(STRM_RI_B)

local XF11_RI_B			= create_mfd_tex(STORES_BLACK, 800 ,300, 1000,400, STORE_SCALE*1.15)
XF11_RI_B.name			= create_guid_string()
XF11_RI_B.init_pos		= Inner_Right_init_pos
XF11_RI_B.parent_element	= TAN_LD_MASTER.name
XF11_RI_B.element_params = {"STORES_TOGGLE", "INNER_PYLON_R_LOADOUT"}
XF11_RI_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.895,0.905} }
AddElement(XF11_RI_B)

local SPEAR3_RI_B			= create_mfd_tex(STORES_BLACK, 200 ,500, 400, 600, STORE_SCALE*1.15)
SPEAR3_RI_B.name			= create_guid_string()
SPEAR3_RI_B.init_pos		= Inner_Right_init_pos
SPEAR3_RI_B.parent_element	= TAN_LD_MASTER.name
SPEAR3_RI_B.element_params = {"STORES_TOGGLE", "INNER_PYLON_R_LOADOUT"}
SPEAR3_RI_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.919,0.921} }
AddElement(SPEAR3_RI_B)

local SPEAREW_RI_B			= create_mfd_tex(STORES_BLACK, 200 ,600, 400, 700, STORE_SCALE*1.15)
SPEAREW_RI_B.name			= create_guid_string()
SPEAREW_RI_B.init_pos		= Inner_Right_init_pos
SPEAREW_RI_B.parent_element	= TAN_LD_MASTER.name
SPEAREW_RI_B.element_params = {"STORES_TOGGLE", "INNER_PYLON_R_LOADOUT"}
SPEAREW_RI_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.929,0.931} }
AddElement(SPEAREW_RI_B)

KEPD_RI_B			= create_mfd_tex(STORES_BLACK, 200 ,700, 400, 800, STORE_SCALE*1.15)
KEPD_RI_B.name			= create_guid_string()
KEPD_RI_B.init_pos		= Inner_Right_init_pos
KEPD_RI_B.parent_element	= TAN_LD_MASTER.name
KEPD_RI_B.element_params = {"STORES_TOGGLE", "INNER_PYLON_R_LOADOUT"}
KEPD_RI_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.939,0.941} }
AddElement(KEPD_RI_B)

M71HD_RI_B					= create_mfd_tex(STORES_BLACK, 800, 900, 1000, 1000, STORE_SCALE*1.15)
M71HD_RI_B.name				= create_guid_string()
M71HD_RI_B.init_pos			= Inner_Right_init_pos
M71HD_RI_B.parent_element	= TAN_LD_MASTER.name
M71HD_RI_B.element_params 	= {"STORES_TOGGLE", "INNER_PYLON_R_LOADOUT"}
M71HD_RI_B.controllers    	= { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.909,0.911} }
AddElement(M71HD_RI_B)


-- =====================================================================================================
-- Right outer				[   ]
-- =====================================================================================================
-- wpn_RightOuter_Black
local A9L_RO_B			= create_mfd_tex(STORES_BLACK, 0, 0, 200, 100, STORE_SCALE*1.15)
A9L_RO_B.name			= create_guid_string()
A9L_RO_B.init_pos		= Outer_Right_init_pos
A9L_RO_B.parent_element	= TAN_LD_MASTER.name
A9L_RO_B.element_params = {"STORES_TOGGLE", "OUTER_PYLON_R_LOADOUT"}
A9L_RO_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.505,0.515} }	
AddElement(A9L_RO_B)

local A9M_RO_B			= create_mfd_tex(STORES_BLACK, 0, 100, 200, 200, STORE_SCALE*1.15)
A9M_RO_B.name			= create_guid_string()
A9M_RO_B.init_pos		= Outer_Right_init_pos
A9M_RO_B.parent_element	= TAN_LD_MASTER.name
A9M_RO_B.element_params = {"STORES_TOGGLE", "OUTER_PYLON_R_LOADOUT"}
A9M_RO_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.515,0.525} }
AddElement(A9M_RO_B)

local A9X_RO_B			= create_mfd_tex(STORES_BLACK, 0, 200, 200,300, STORE_SCALE*1.15)
A9X_RO_B.name			= create_guid_string()
A9X_RO_B.init_pos		= Outer_Right_init_pos
A9X_RO_B.parent_element	= TAN_LD_MASTER.name
A9X_RO_B.element_params = {"STORES_TOGGLE", "OUTER_PYLON_R_LOADOUT"}
A9X_RO_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.525,0.535} }
AddElement(A9X_RO_B)

local IRIS_RO_B		= create_mfd_tex(STORES_BLACK, 0, 300, 200, 400, STORE_SCALE*1.15)
IRIS_RO_B.name			= create_guid_string()
IRIS_RO_B.init_pos		= Outer_Right_init_pos
IRIS_RO_B.parent_element	= TAN_LD_MASTER.name
IRIS_RO_B.element_params = {"STORES_TOGGLE", "OUTER_PYLON_R_LOADOUT"}
IRIS_RO_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.135,0.145} }
AddElement(IRIS_RO_B)

local PYTH_RO_B		= create_mfd_tex(STORES_BLACK, 0, 400, 200, 500, STORE_SCALE*1.15)
PYTH_RO_B.name			= create_guid_string()
PYTH_RO_B.init_pos		= Outer_Right_init_pos
PYTH_RO_B.parent_element	= TAN_LD_MASTER.name
PYTH_RO_B.element_params = {"STORES_TOGGLE", "OUTER_PYLON_R_LOADOUT"}
PYTH_RO_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.145,0.155} }
AddElement(PYTH_RO_B)

local ADRT_RO_B		= create_mfd_tex(STORES_BLACK, 0, 500, 200, 600, STORE_SCALE*1.15)
ADRT_RO_B.name			= create_guid_string()
ADRT_RO_B.init_pos		= Outer_Right_init_pos
ADRT_RO_B.parent_element	= TAN_LD_MASTER.name
ADRT_RO_B.element_params = {"STORES_TOGGLE", "OUTER_PYLON_R_LOADOUT"}
ADRT_RO_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.155,0.165} }
AddElement(ADRT_RO_B)

local A132_RO_B		= create_mfd_tex(STORES_BLACK, 0, 600, 200,700, STORE_SCALE*1.15)
A132_RO_B.name			= create_guid_string()
A132_RO_B.init_pos		= Outer_Right_init_pos
A132_RO_B.parent_element	= TAN_LD_MASTER.name
A132_RO_B.element_params = {"STORES_TOGGLE", "OUTER_PYLON_R_LOADOUT"}
A132_RO_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.165,0.175} }
AddElement(A132_RO_B)

local M120B_RO_B		= create_mfd_tex(STORES_BLACK, 200, 0, 400,100, STORE_SCALE*1.15)
M120B_RO_B.name			= create_guid_string()
M120B_RO_B.init_pos		= Outer_Right_init_pos
M120B_RO_B.parent_element	= TAN_LD_MASTER.name
M120B_RO_B.element_params = {"STORES_TOGGLE", "OUTER_PYLON_R_LOADOUT"}
M120B_RO_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.175, 0.185} }
AddElement(M120B_RO_B)

local M120C5_RO_B		= create_mfd_tex(STORES_BLACK, 200,100, 400,200, STORE_SCALE*1.15)
M120C5_RO_B.name			= create_guid_string()
M120C5_RO_B.init_pos		= Outer_Right_init_pos
M120C5_RO_B.parent_element	= TAN_LD_MASTER.name
M120C5_RO_B.element_params = {"STORES_TOGGLE", "OUTER_PYLON_R_LOADOUT"}
M120C5_RO_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.185, 0.195} }
AddElement(M120C5_RO_B)

local M120C7_RO_B		= create_mfd_tex(STORES_BLACK, 200,200, 400,300, STORE_SCALE*1.15)
M120C7_RO_B.name			= create_guid_string()
M120C7_RO_B.init_pos		= Outer_Right_init_pos
M120C7_RO_B.parent_element	= TAN_LD_MASTER.name
M120C7_RO_B.element_params = {"STORES_TOGGLE", "OUTER_PYLON_R_LOADOUT"}
M120C7_RO_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.195, 0.205} }
AddElement(M120C7_RO_B)

local DRBY_RO_B			= create_mfd_tex(STORES_BLACK, 200,400, 400,500, STORE_SCALE*1.15)
DRBY_RO_B.name			= create_guid_string()
DRBY_RO_B.init_pos		= Outer_Right_init_pos
DRBY_RO_B.parent_element	= TAN_LD_MASTER.name
DRBY_RO_B.element_params = {"STORES_TOGGLE", "OUTER_PYLON_R_LOADOUT"}
DRBY_RO_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.205, 0.215} }
AddElement(DRBY_RO_B)

local METR_RO_B		= create_mfd_tex(STORES_BLACK, 200,300, 400,400, STORE_SCALE*1.15)
METR_RO_B.name			= create_guid_string()
METR_RO_B.init_pos		= Outer_Right_init_pos
METR_RO_B.parent_element	= TAN_LD_MASTER.name
METR_RO_B.element_params = {"STORES_TOGGLE", "OUTER_PYLON_R_LOADOUT"}
METR_RO_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.215, 0.225} }
AddElement(METR_RO_B)

local AP70_RO_B		= create_mfd_tex(STORES_BLACK, 800, 100, 1000, 200, STORE_SCALE*1.15)
AP70_RO_B.name			= create_guid_string()
AP70_RO_B.init_pos		= Outer_Right_init_pos
AP70_RO_B.parent_element	= TAN_LD_MASTER.name
AP70_RO_B.element_params = {"STORES_TOGGLE", "OUTER_PYLON_R_LOADOUT"}
AP70_RO_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.625,0.635} }
AddElement(AP70_RO_B)

local HE70_RO_B		= create_mfd_tex(STORES_BLACK, 800, 200, 1000, 300, STORE_SCALE*1.15)
HE70_RO_B.name			= create_guid_string()
HE70_RO_B.init_pos		= Outer_Right_init_pos
HE70_RO_B.parent_element	= TAN_LD_MASTER.name
HE70_RO_B.element_params = {"STORES_TOGGLE", "OUTER_PYLON_R_LOADOUT"}
HE70_RO_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.635,0.645} }
AddElement(HE70_RO_B)

local H65_RO_B			= create_mfd_tex(STORES_BLACK, 400,0, 600, 100, STORE_SCALE*1.15)
H65_RO_B.name			= create_guid_string()
H65_RO_B.init_pos		= Outer_Right_init_pos
H65_RO_B.parent_element	= TAN_LD_MASTER.name
H65_RO_B.element_params = {"STORES_TOGGLE", "OUTER_PYLON_R_LOADOUT"}
H65_RO_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.645,0.655} }
AddElement(H65_RO_B)

local K65_RO_B			= create_mfd_tex(STORES_BLACK, 400,100, 600, 200, STORE_SCALE*1.15)
K65_RO_B.name			= create_guid_string()
K65_RO_B.init_pos		= Outer_Right_init_pos
K65_RO_B.parent_element	= TAN_LD_MASTER.name
K65_RO_B.element_params = {"STORES_TOGGLE", "OUTER_PYLON_R_LOADOUT"}
K65_RO_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.655,0.665} }
AddElement(K65_RO_B)

local BMST_RO_B			= create_mfd_tex(STORES_BLACK, 400,203, 600, 300, STORE_SCALE*1.15)
BMST_RO_B.name			= create_guid_string()
BMST_RO_B.init_pos		= Outer_Right_init_pos
BMST_RO_B.parent_element	= TAN_LD_MASTER.name
BMST_RO_B.element_params = {"STORES_TOGGLE", "OUTER_PYLON_R_LOADOUT"}
BMST_RO_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.665,0.675} }
AddElement(BMST_RO_B)

local M71LD_RO_B			= create_mfd_tex(STORES_BLACK, 800 , 0, 1000, 100, STORE_SCALE*1.15)
M71LD_RO_B.name				= create_guid_string()
M71LD_RO_B.init_pos			= Outer_Right_init_pos
M71LD_RO_B.parent_element	= TAN_LD_MASTER.name
M71LD_RO_B.element_params 	= {"STORES_TOGGLE", "OUTER_PYLON_R_LOADOUT"}
M71LD_RO_B.controllers    	= { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.675,0.685} }
AddElement(M71LD_RO_B)

local FF82_RO_B			= create_mfd_tex(STORES_BLACK, 400 , 800, 600, 900, STORE_SCALE*1.15)
FF82_RO_B.name			= create_guid_string()
FF82_RO_B.init_pos		= Outer_Right_init_pos
FF82_RO_B.parent_element	= TAN_LD_MASTER.name
FF82_RO_B.element_params = {"STORES_TOGGLE", "OUTER_PYLON_R_LOADOUT"}
FF82_RO_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.685,0.695} }
AddElement(FF82_RO_B)

local FF83_RO_B			= create_mfd_tex(STORES_BLACK, 400 , 900, 600, 1000, STORE_SCALE*1.15)
FF83_RO_B.name			= create_guid_string()
FF83_RO_B.init_pos		= Outer_Right_init_pos
FF83_RO_B.parent_element	= TAN_LD_MASTER.name
FF83_RO_B.element_params = {"STORES_TOGGLE", "OUTER_PYLON_R_LOADOUT"}
FF83_RO_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.6905,0.705} }
AddElement(FF83_RO_B)

local GB12_RO_B			= create_mfd_tex(STORES_BLACK, 600 , 200, 800, 300, STORE_SCALE*1.15)
GB12_RO_B.name			= create_guid_string()
GB12_RO_B.init_pos		= Outer_Right_init_pos
GB12_RO_B.parent_element	= TAN_LD_MASTER.name
GB12_RO_B.element_params = {"STORES_TOGGLE", "OUTER_PYLON_R_LOADOUT"}
GB12_RO_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.715,0.725} }
AddElement(GB12_RO_B)

local GB16_RO_B			= create_mfd_tex(STORES_BLACK, 600 , 300, 800, 400, STORE_SCALE*1.15) 
GB16_RO_B.name			= create_guid_string()
GB16_RO_B.init_pos		= Outer_Right_init_pos
GB16_RO_B.parent_element	= TAN_LD_MASTER.name
GB16_RO_B.element_params = {"STORES_TOGGLE", "OUTER_PYLON_R_LOADOUT"}
GB16_RO_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.725,0.735} }
AddElement(GB16_RO_B)

local GB39_RO_B			= create_mfd_tex(STORES_BLACK, 600 , 795, 800, 900, STORE_SCALE*1.15)
GB39_RO_B.name			= create_guid_string()
GB39_RO_B.init_pos		= Outer_Right_init_pos
GB39_RO_B.parent_element	= TAN_LD_MASTER.name
GB39_RO_B.element_params = {"STORES_TOGGLE", "OUTER_PYLON_R_LOADOUT"}
GB39_RO_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.745,0.755} }
AddElement(GB39_RO_B)

local GB38_RO_B			= create_mfd_tex(STORES_BLACK, 600 , 700, 800, 800, STORE_SCALE*1.15)
GB38_RO_B.name			= create_guid_string()
GB38_RO_B.init_pos		= Outer_Right_init_pos
GB38_RO_B.parent_element	= TAN_LD_MASTER.name
GB38_RO_B.element_params = {"STORES_TOGGLE", "OUTER_PYLON_R_LOADOUT"}
GB38_RO_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.755,0.765} }
AddElement(GB38_RO_B)

local GB32_RO_B			= create_mfd_tex(STORES_BLACK, 600 , 600, 800, 700, STORE_SCALE*1.15)
GB32_RO_B.name			= create_guid_string()
GB32_RO_B.init_pos		= Outer_Right_init_pos
GB32_RO_B.parent_element	= TAN_LD_MASTER.name
GB32_RO_B.element_params = {"STORES_TOGGLE", "OUTER_PYLON_R_LOADOUT"}
GB32_RO_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.765,0.775} }
AddElement(GB32_RO_B)

local GB49_RO_B			= create_mfd_tex(STORES_BLACK, 600 , 900, 800, 1000, STORE_SCALE*1.15)
GB49_RO_B.name			= create_guid_string()
GB49_RO_B.init_pos		= Outer_Right_init_pos
GB49_RO_B.parent_element	= TAN_LD_MASTER.name
GB49_RO_B.element_params = {"STORES_TOGGLE", "OUTER_PYLON_R_LOADOUT"}
GB49_RO_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.795,0.805} }
AddElement(GB49_RO_B)

local MAR1_RO_B			= create_mfd_tex(STORES_BLACK, 400 ,300, 600, 400, STORE_SCALE*1.15)
MAR1_RO_B.name			= create_guid_string()
MAR1_RO_B.init_pos		= Outer_Right_init_pos
MAR1_RO_B.parent_element	= TAN_LD_MASTER.name
MAR1_RO_B.element_params = {"STORES_TOGGLE", "OUTER_PYLON_R_LOADOUT"}
MAR1_RO_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.805,0.815} }
AddElement(MAR1_RO_B)

local DWST_RO_B			= create_mfd_tex(STORES_BLACK, 400 ,700, 600, 800, STORE_SCALE*1.15)
DWST_RO_B.name			= create_guid_string()
DWST_RO_B.init_pos		= Outer_Right_init_pos
DWST_RO_B.parent_element	= TAN_LD_MASTER.name
DWST_RO_B.element_params = {"STORES_TOGGLE", "OUTER_PYLON_R_LOADOUT"}
DWST_RO_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.815,0.825} }
AddElement(DWST_RO_B)

local DWSA_RO_B			= create_mfd_tex(STORES_BLACK, 400 ,600, 600, 700, STORE_SCALE*1.15)
DWSA_RO_B.name			= create_guid_string()
DWSA_RO_B.init_pos		= Outer_Right_init_pos
DWSA_RO_B.parent_element	= TAN_LD_MASTER.name
DWSA_RO_B.element_params = {"STORES_TOGGLE", "OUTER_PYLON_R_LOADOUT"}
DWSA_RO_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.825,0.835} }
AddElement(DWSA_RO_B)

local RB15_RO_B			= create_mfd_tex(STORES_BLACK, 400 ,400, 600, 500, STORE_SCALE*1.15)
RB15_RO_B.name			= create_guid_string()
RB15_RO_B.init_pos		= Outer_Right_init_pos
RB15_RO_B.parent_element	= TAN_LD_MASTER.name
RB15_RO_B.element_params = {"STORES_TOGGLE", "OUTER_PYLON_R_LOADOUT"}
RB15_RO_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.835,0.845} }
AddElement(RB15_RO_B)

local SPEAR3_RO_B			= create_mfd_tex(STORES_BLACK, 200 ,500, 400, 600, STORE_SCALE*1.15)
SPEAR3_RO_B.name			= create_guid_string()
SPEAR3_RO_B.init_pos		= Outer_Right_init_pos
SPEAR3_RO_B.parent_element	= TAN_LD_MASTER.name
SPEAR3_RO_B.element_params = {"STORES_TOGGLE", "OUTER_PYLON_R_LOADOUT"}
SPEAR3_RO_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.919,0.921} }
AddElement(SPEAR3_RO_B)

local SPEAREW_RO_B			= create_mfd_tex(STORES_BLACK, 200 ,600, 400, 700, STORE_SCALE*1.15)
SPEAREW_RO_B.name			= create_guid_string()
SPEAREW_RO_B.init_pos		= Outer_Right_init_pos
SPEAREW_RO_B.parent_element	= TAN_LD_MASTER.name
SPEAREW_RO_B.element_params = {"STORES_TOGGLE", "OUTER_PYLON_R_LOADOUT"}
SPEAREW_RO_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.929,0.931} }
AddElement(SPEAREW_RO_B)

M71HD_RO_B					= create_mfd_tex(STORES_BLACK, 800, 900, 1000, 1000, STORE_SCALE*1.15)
M71HD_RO_B.name				= create_guid_string()
M71HD_RO_B.init_pos			= Outer_Right_init_pos
M71HD_RO_B.parent_element	= TAN_LD_MASTER.name
M71HD_RO_B.element_params 	= {"STORES_TOGGLE", "OUTER_PYLON_R_LOADOUT"}
M71HD_RO_B.controllers    	= { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.909,0.911} }
AddElement(M71HD_RO_B)

-- =====================================================================================================
--  Right Wingtip																				[   ]
-- =====================================================================================================
-- wpn_RightTip_Black
local A9L_RT_B			= create_mfd_tex(STORES_BLACK, 0, 0, 200, 100, STORE_SCALE*1.15)
A9L_RT_B.name			= create_guid_string()
A9L_RT_B.init_pos		= Tip_Right_init_pos
A9L_RT_B.parent_element	= TAN_LD_MASTER.name
A9L_RT_B.element_params = {"STORES_TOGGLE", "WINGTIP_R_LOADOUT"}
A9L_RT_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.505,0.515} }	
AddElement(A9L_RT_B)

local A9M_RT_B			= create_mfd_tex(STORES_BLACK, 0, 100, 200, 200, STORE_SCALE*1.15)
A9M_RT_B.name			= create_guid_string()
A9M_RT_B.init_pos		= Tip_Right_init_pos
A9M_RT_B.parent_element	= TAN_LD_MASTER.name
A9M_RT_B.element_params = {"STORES_TOGGLE", "WINGTIP_R_LOADOUT"}
A9M_RT_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.515,0.525} }
AddElement(A9M_RT_B)

local A9X_RT_B			= create_mfd_tex(STORES_BLACK, 0, 200, 200,300, STORE_SCALE*1.15)
A9X_RT_B.name			= create_guid_string()
A9X_RT_B.init_pos		= Tip_Right_init_pos
A9X_RT_B.parent_element	= TAN_LD_MASTER.name
A9X_RT_B.element_params = {"STORES_TOGGLE", "WINGTIP_R_LOADOUT"}
A9X_RT_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.525,0.535} }
AddElement(A9X_RT_B)

local IRIS_RT_B		= create_mfd_tex(STORES_BLACK, 0, 300, 200, 400, STORE_SCALE*1.15)
IRIS_RT_B.name			= create_guid_string()
IRIS_RT_B.init_pos		= Tip_Right_init_pos
IRIS_RT_B.parent_element	= TAN_LD_MASTER.name
IRIS_RT_B.element_params = {"STORES_TOGGLE", "WINGTIP_R_LOADOUT"}
IRIS_RT_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.135,0.145} }
AddElement(IRIS_RT_B)

local PYTH_RT_B		= create_mfd_tex(STORES_BLACK, 0, 400, 200, 500, STORE_SCALE*1.15)
PYTH_RT_B.name			= create_guid_string()
PYTH_RT_B.init_pos		= Tip_Right_init_pos
PYTH_RT_B.parent_element	= TAN_LD_MASTER.name
PYTH_RT_B.element_params = {"STORES_TOGGLE", "WINGTIP_R_LOADOUT"}
PYTH_RT_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.145,0.155} }
AddElement(PYTH_RT_B)

local ADRT_RT_B		= create_mfd_tex(STORES_BLACK, 0, 500, 200, 600, STORE_SCALE*1.15)
ADRT_RT_B.name			= create_guid_string()
ADRT_RT_B.init_pos		= Tip_Right_init_pos
ADRT_RT_B.parent_element	= TAN_LD_MASTER.name
ADRT_RT_B.element_params = {"STORES_TOGGLE", "WINGTIP_R_LOADOUT"}
ADRT_RT_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.155,0.165} }
AddElement(ADRT_RT_B)

local A132_RT_B		= create_mfd_tex(STORES_BLACK, 0, 600, 200,700, STORE_SCALE*1.15)
A132_RT_B.name			= create_guid_string()
A132_RT_B.init_pos		= Tip_Right_init_pos
A132_RT_B.parent_element	= TAN_LD_MASTER.name
A132_RT_B.element_params = {"STORES_TOGGLE", "WINGTIP_R_LOADOUT"}
A132_RT_B.controllers    = { {"parameter_compare_with_number",0, 1}, {"parameter_in_range" ,1,0.165,0.175} }
AddElement(A132_RT_B)








--		==================================================================================================


--FUEL

local fuel_percent		= create_mfd_tex_3k(MFD_ELEMENTS_PDD,1724, 0, 2240, 512 )
fuel_percent.name			= create_guid_string()
fuel_percent.init_pos		= {0.72, -0.99}
fuel_percent.parent_element	= TAN_LD_MASTER.name
fuel_percent.element_params = {"FUEL_IND_TOGGLE_M",}
fuel_percent.controllers    = { {"parameter_compare_with_number",0, 1}}

AddElement(fuel_percent)	

add_text_param(-0.002, 0, "FUEL", "%0.0f", fuel_percent, mfd_strdefs_digit, "Gripen_Font_black")	

--XF, extra fuel tank fuel amount
add_text_param(0.035, -0.035, "XF_FUEL", "%0.0f", Stores_GUN_XF, mfd_strdefs_digit_XS, "Gripen_Font_black")


TAN_Background_Mask 				= CreateElement "ceMeshPoly"
TAN_Background_Mask.name 			= create_guid_string()
TAN_Background_Mask.primitivetype 	= "triangles"
TAN_Background_Mask.vertices	   	= { {-0.925 , 1.4 }, { 0.925,1.4}, { 0.925,-1.4}, {-0.925,-1.4}, }
TAN_Background_Mask.indices			= {0, 1, 2, 0, 2, 3}
TAN_Background_Mask.init_pos		= {0, 0, 0}
TAN_Background_Mask.material		= MakeMaterial(nil,{222, 203, 110,255})	--RGBA
TAN_Background_Mask.parent_element	= TAN_LD_MASTER.name
TAN_Background_Mask.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
TAN_Background_Mask.level			= MFD_DEFAULT_LEVEL
TAN_Background_Mask.isvisible		= false
AddElement2(TAN_Background_Mask)





HORIZON_LINE_base 				= CreateElement "ceSimple"
HORIZON_LINE_base.init_pos		= {0, 0.195}	
HORIZON_LINE_base.name			= create_guid_string()
HORIZON_LINE_base.parent_element	 = TAN_LD_MASTER.name
HORIZON_LINE_base.element_params 	= {"ADI_ROLL", "PULLUPQUE","CURRENT_PHASE_STATIONARY","CURRENT_PHASE_PARKED","CURRENT_PHASE_TAXI",
												"CURRENT_PHASE_TGR","CURRENT_PHASE_ROT","CURRENT_PHASE_TD","CURRENT_PHASE_LR","CURRENT_PHASE_PAL"}
HORIZON_LINE_base.controllers		= {  {"rotate_using_parameter" ,0, 1},{"parameter_in_range", 1, -10000, 0},{"parameter_compare_with_number",2, 0},{"parameter_compare_with_number",3, 0}
,{"parameter_compare_with_number",4, 0} ,{"parameter_compare_with_number",5, 0},{"parameter_compare_with_number",6, 0},{"parameter_compare_with_number",7, 0},{"parameter_compare_with_number",8, 0},{"parameter_compare_with_number",9, 0} }
AddElement3(HORIZON_LINE_base)

HORIZON_LINE			= create_mfd_tex(CENTER_DISPLAY_COLOR, 4, 1664, 1815 , 1668, 2) 
HORIZON_LINE.name			= create_guid_string()
HORIZON_LINE.init_pos		= {0, 0}
HORIZON_LINE.parent_element	= HORIZON_LINE_base.name
HORIZON_LINE.h_clip_relation  = h_clip_relations.DECREASE_IF_LEVEL  
HORIZON_LINE.level			= MFD_DEFAULT_LEVEL + 1
HORIZON_LINE.element_params 	= {"LD_BRIGHTNESS"}
HORIZON_LINE.controllers		= { JAS_Bright[1],JAS_Bright[2],JAS_Bright[3],JAS_Bright[4],JAS_Bright[5],JAS_Bright[6],JAS_Bright[7],JAS_Bright[8],JAS_Bright[9],JAS_Bright[10],JAS_Bright[11],JAS_Bright[12],JAS_Bright[13],JAS_Bright[14],JAS_Bright[15], JAS_Bright[16],JAS_Bright[17],JAS_Bright[18],JAS_Bright[19],JAS_Bright[20]}
AddElement2(HORIZON_LINE)

HORIZON_ALT_A			= create_mfd_tex(CENTER_DISPLAY_COLOR, 1512, 1887, 1571 , 1960, 1) 
HORIZON_ALT_A.name			= create_guid_string()
HORIZON_ALT_A.init_pos		= {0.35, 0.039}
HORIZON_ALT_A.parent_element	= HORIZON_LINE.name
HORIZON_ALT_A.element_params 	= {"LD_BRIGHTNESS"}
HORIZON_ALT_A.controllers		= { JAS_Bright[1],JAS_Bright[2],JAS_Bright[3],JAS_Bright[4],JAS_Bright[5],JAS_Bright[6],JAS_Bright[7],JAS_Bright[8],JAS_Bright[9],JAS_Bright[10],JAS_Bright[11],JAS_Bright[12],JAS_Bright[13],JAS_Bright[14],JAS_Bright[15], JAS_Bright[16],JAS_Bright[17],JAS_Bright[18],JAS_Bright[19],JAS_Bright[20]}
AddElement3(HORIZON_ALT_A)

green_text_param_with_brightness(0.14, 0 , "RAW_RALT", "%0.0f", HORIZON_ALT_A, {0.007,0.007, 0, 0}, "Gripen_Font_HL_Green")


HORIZON_LINE_FPM			= create_mfd_tex(CENTER_DISPLAY_COLOR, 1504, 1717, 1709 , 1818, 2) 
HORIZON_LINE_FPM.name			= create_guid_string()
HORIZON_LINE_FPM.init_pos		= {0, 0.043}
HORIZON_LINE_FPM.parent_element	= HORIZON_LINE.name
HORIZON_LINE_FPM.element_params  = {"CD_BRIGHTNESS", "ADI_ROLL","VELVEC_HUD_Y","VELVEC_HUD_X","ADI_PITCH"}
HORIZON_LINE_FPM.controllers	 = {JAS_Bright[1],JAS_Bright[2],JAS_Bright[3],JAS_Bright[4],JAS_Bright[5],JAS_Bright[6],JAS_Bright[7],JAS_Bright[8],JAS_Bright[9],JAS_Bright[10],JAS_Bright[11],JAS_Bright[12],JAS_Bright[13],JAS_Bright[14],JAS_Bright[15], JAS_Bright[16],JAS_Bright[17],JAS_Bright[18],JAS_Bright[19],JAS_Bright[20], 
									{"rotate_using_parameter" ,1, -1},{"move_up_down_using_parameter",2, 0.036}, {"move_left_right_using_parameter",3, 0.036},{"move_up_down_using_parameter",4, -0.036} }
AddElement3(HORIZON_LINE_FPM)

GROUNDCOLLISION			= create_mfd_tex(CENTER_DISPLAY_COLOR, 1380, 145, 1680 , 298, 1.5) 
GROUNDCOLLISION.name			= create_guid_string()
GROUNDCOLLISION.init_pos		= {0, 0.023}
GROUNDCOLLISION.parent_element	= HORIZON_LINE_FPM.name
GROUNDCOLLISION.element_params  = {"LD_BRIGHTNESS","PULLUPQUE", "ROLL_HUD", "VELVEC_HUD_Y","CURRENT_PHASE_STATIONARY","CURRENT_PHASE_PARKED","CURRENT_PHASE_TAXI",
												"CURRENT_PHASE_TGR","CURRENT_PHASE_ROT","CURRENT_PHASE_TD","CURRENT_PHASE_LR","CURRENT_PHASE_PAL", "PULLMORE"}
GROUNDCOLLISION.controllers	 	= { JAS_Bright[1],JAS_Bright[2],JAS_Bright[3],JAS_Bright[4],JAS_Bright[5],JAS_Bright[6],JAS_Bright[7],JAS_Bright[8],JAS_Bright[9],JAS_Bright[10],JAS_Bright[11],JAS_Bright[12],JAS_Bright[13],JAS_Bright[14],JAS_Bright[15], JAS_Bright[16],JAS_Bright[17],JAS_Bright[18],JAS_Bright[19],JAS_Bright[20],
								  {"parameter_in_range",1, -10000,0},{"rotate_using_parameter" ,2, 1.00},
								  {"move_up_down_using_parameter",3, 0.1} ,{"parameter_compare_with_number",4, 0},{"parameter_compare_with_number",5, 0},
								  {"parameter_compare_with_number",6, 0},{"parameter_compare_with_number",7, 0},{"parameter_compare_with_number",8, 0},
								  {"parameter_compare_with_number",9, 0},{"parameter_compare_with_number",10, 0},{"parameter_compare_with_number",11, 0}, {"parameter_in_range",12, -0.99,0.5} }	
AddElement3(GROUNDCOLLISION)


















