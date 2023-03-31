TAN_CD_MASTER 					= CreateElement "ceSimple"
TAN_CD_MASTER.init_pos			= {0,0}
TAN_CD_MASTER.name				= create_guid_string()
TAN_CD_MASTER.element_params 	= {"CD_EMGY_MODE", "MAINPOWER"}
TAN_CD_MASTER.controllers    	= {{"parameter_compare_with_number",0, 0}, {"parameter_compare_with_number", 1, 1}}
AddElement(TAN_CD_MASTER)

GRAY_Background 					= CreateElement "ceMeshPoly"
GRAY_Background.name 			= create_guid_string()
GRAY_Background.primitivetype 	= "triangles"
GRAY_Background.vertices	   		= { {-1.0 , 2 }, { 1.0, 2}, { 1.0,-0.85}, {-1.0,-0.85}, }
GRAY_Background.indices			= {0, 1, 2, 0, 2, 3}
GRAY_Background.init_pos			= {0, -0.6, 0}
GRAY_Background.material			= MakeMaterial(nil,{69, 69, 70,255})	--RGBA
GRAY_Background.parent_element	= TAN_CD_MASTER.name
GRAY_Background.h_clip_relation  = h_clip_relations.REWRITE_LEVEL
GRAY_Background.level			= MFD_DEFAULT_LEVEL
GRAY_Background.change_opacity	= false
GRAY_Background.collimated 		= false
GRAY_Background.isvisible		= true
GRAY_Background.element_params 	= {"CD_BRIGHTNESS"}
GRAY_Background.controllers    	= {{"opacity_using_parameter", 0}}
Add(GRAY_Background)

BLACK_Background 					= CreateElement "ceMeshPoly"
BLACK_Background.name 				= create_guid_string()
BLACK_Background.primitivetype 		= "triangles"
BLACK_Background.vertices	   		= { {-0.905 , 1.4 }, { 0.925,1.4}, { 0.925,-0.9}, {-0.905,-0.9}, }
BLACK_Background.indices			= {0, 1, 2, 0, 2, 3}
BLACK_Background.init_pos			= {0, 0, 0}
BLACK_Background.material			= MakeMaterial(nil,{0, 0, 0,255})	--RGBA
BLACK_Background.parent_element		= TAN_CD_MASTER.name
BLACK_Background.h_clip_relation 	= h_clip_relations.REWRITE_LEVEL
BLACK_Background.level				= MFD_DEFAULT_LEVEL
BLACK_Background.change_opacity		= false
BLACK_Background.collimated 		= false
BLACK_Background.isvisible			= true
BLACK_Background.element_params 	= {"CD_BRIGHTNESS", "CD_FIX_TOGGLE"}
BLACK_Background.controllers    	= {{"opacity_using_parameter", 0}, {"parameter_compare_with_number", 1, 0}}
Add(BLACK_Background)



TAN_Background 					= CreateElement "ceMeshPoly"
TAN_Background.name 			= create_guid_string()
TAN_Background.primitivetype 	= "triangles"
TAN_Background.vertices	   		= { {-0.905 , 1.4 }, { 0.925,1.4}, { 0.925,-0.9}, {-0.905,-0.9}, }
TAN_Background.indices			= {0, 1, 2, 0, 2, 3}
TAN_Background.init_pos			= {0, 0, 0}
TAN_Background.material			= MakeMaterial(nil,{230, 220, 140, 255})	--RGBA
TAN_Background.parent_element	= TAN_CD_MASTER.name
TAN_Background.h_clip_relation  = h_clip_relations.REWRITE_LEVEL
TAN_Background.level			= MFD_DEFAULT_LEVEL
TAN_Background.change_opacity	= false
TAN_Background.collimated 		= false
TAN_Background.isvisible		= true
TAN_Background.element_params 	= {"CD_BRIGHTNESS","CD_FIX_TOGGLE"}
TAN_Background.controllers    	= {{"opacity_using_parameter", 0},{"parameter_compare_with_number",1, 0}}
Add(TAN_Background)

--SmallGray_Background 					= CreateElement "ceMeshPoly"
--SmallGray_Background.name 			= create_guid_string()
--SmallGray_Background.primitivetype 	= "triangles"
--SmallGray_Background.vertices	   		= BLACK_Background.vertices
--SmallGray_Background.indices			= {0, 1, 2, 0, 2, 3}
--SmallGray_Background.init_pos			= {0, 0, 0}
--SmallGray_Background.material			= MakeMaterial(nil,{69, 69, 70,255})	--RGBA
--SmallGray_Background.parent_element	= TAN_CD_MASTER.name
--SmallGray_Background.h_clip_relation  = h_clip_relations.REWRITE_LEVEL
--SmallGray_Background.level			= MFD_DEFAULT_LEVEL
--SmallGray_Background.change_opacity	= false
--SmallGray_Background.collimated 		= false
--SmallGray_Background.isvisible		= true
--SmallGray_Background.element_params 	= {"CD_BRIGHTNESS","CD_FIX_TOGGLE"}
--SmallGray_Background.controllers    	= {{"opacity_using_parameter", 0},{"parameter_compare_with_number",1, 1}}
--Add(SmallGray_Background)


add_text_param(0.57,  1.32, "SECONDSTIME", "%02.0f", TAN_Background, mfd_strdefs_digit_XS, "Gripen_Font_black")
add_text(",", 0.534,  1.3275, TAN_Background, "Gripen_Font_black" )
add_text_param(0.48,  1.32, "MINUTESTIME", "%02.0f", TAN_Background, mfd_strdefs_digit_XS, "Gripen_Font_black")
add_text(",", 0.445,  1.3275, TAN_Background, "Gripen_Font_black" )
add_text_param(0.395, 1.32, "HOURTIME", "%02.0f", TAN_Background, mfd_strdefs_digit_XS, "Gripen_Font_black")


-- On-screen button lables

local FONT_SIZE = 0.64

local EMGY			= create_mfd_tex(LD_LABLES, 0, 1270, 125 , 1700,FONT_SIZE) 
EMGY.name			= create_guid_string()
EMGY.init_pos		= {-0.930, 1.14}
EMGY.parent_element	= TAN_CD_MASTER.name
AddElement(EMGY)

local EWS			= create_mfd_tex(LD_LABLES, 750, 1300, 840 , 1593,FONT_SIZE) 
EWS.name			= create_guid_string()
EWS.init_pos		= {-0.939, 0.533}
EWS.parent_element	= TAN_CD_MASTER.name
AddElement(EWS)

local EWS_BOX				= create_mfd_tex(NAV_WHEEL_BLACK, 1850, 215, 1942 , 552, FONT_SIZE) 	-- 3 Letter box
EWS_BOX.name				= create_guid_string()
EWS_BOX.init_pos			= {-0.940, 0.535}
EWS_BOX.parent_element		= TAN_CD_MASTER.name
EWS_BOX.element_params 		= {"CD_EWS_TOGGLE"}
EWS_BOX.controllers   		= {{"parameter_compare_with_number",0, 1}} --
AddElement(EWS_BOX)

local MSSN			= create_mfd_tex(CENTER_DISPLAY_BLACK, 40, 1120, 120 , 1515,FONT_SIZE) 
MSSN.name			= create_guid_string()
MSSN.init_pos		= {-0.939, 0.25}
MSSN.parent_element	= TAN_CD_MASTER.name
AddElement(MSSN)

local LINK			= create_mfd_tex(CENTER_DISPLAY_BLACK, 240, 1120, 310 , 1515,FONT_SIZE) 
LINK.name			= create_guid_string()
LINK.init_pos		= {-0.939, -0.06}
LINK.parent_element	= TAN_CD_MASTER.name
AddElement(LINK)

local FIX			= create_mfd_tex(CENTER_DISPLAY_BLACK, 350, 1120, 420 , 1515,FONT_SIZE) 
FIX.name			= create_guid_string()
FIX.init_pos		= {-0.939, -0.37}
FIX.parent_element	= TAN_CD_MASTER.name
AddElement(FIX)

local FIX_BOX				= create_mfd_tex(NAV_WHEEL_BLACK, 1850, 215, 1942 , 552, FONT_SIZE) 	-- 3 Letter box
FIX_BOX.name				= create_guid_string()
FIX_BOX.init_pos			= {-0.939, -0.335}
FIX_BOX.parent_element		= TAN_CD_MASTER.name
FIX_BOX.element_params 		= {"CD_FIX_TOGGLE"}
FIX_BOX.controllers   		= {{"parameter_compare_with_number",0, 1}} --
AddElement(FIX_BOX)


local WARN			= create_mfd_tex(CENTER_DISPLAY_BLACK, 765, 1120, 855 , 1515,FONT_SIZE) 
WARN.name			= create_guid_string()
WARN.init_pos		= {-0.939, -0.63}
WARN.parent_element	= TAN_CD_MASTER.name
AddElement(WARN)

local CHKL			= create_mfd_tex(CENTER_DISPLAY_BLACK, 995, 1120, 1070 , 1515,FONT_SIZE) 
CHKL.name			= create_guid_string()
CHKL.init_pos		= {0.96, -0.30}
CHKL.parent_element	= TAN_CD_MASTER.name
AddElement(CHKL)

local MAP			= create_mfd_tex(CENTER_DISPLAY_BLACK, 875, 1118, 955 , 1410,FONT_SIZE) 
MAP.name			= create_guid_string()
MAP.init_pos		= {0.96, -0.02}
MAP.parent_element	= TAN_CD_MASTER.name
AddElement(MAP)


local INFO			= create_mfd_tex(CENTER_DISPLAY_BLACK, 140, 1120, 210 , 1515,FONT_SIZE) 
INFO.name			= create_guid_string()
INFO.init_pos		= {0.96, 0.26}
INFO.parent_element	= TAN_CD_MASTER.name
AddElement(INFO)

local WPN			= create_mfd_tex(CENTER_DISPLAY_BLACK, 650, 1120, 740 , 1444,FONT_SIZE) 
WPN.name			= create_guid_string()
WPN.init_pos		= {0.96, 0.533}
WPN.parent_element	= TAN_CD_MASTER.name
AddElement(WPN)

local LDG			= create_mfd_tex(CENTER_DISPLAY_BLACK, 560, 1120, 622 , 1420,FONT_SIZE)  
LDG.name			= create_guid_string()
LDG.init_pos		= {0.96, 0.833}
LDG.parent_element	= TAN_CD_MASTER.name
AddElement(LDG)
--[[
local LDG_BOX				= create_mfd_tex(NAV_WHEEL_BLACK, 1850, 215, 1942 , 552, FONT_SIZE) 	-- 3 Letter box
LDG_BOX.name				= create_guid_string()
LDG_BOX.init_pos			= {0.96, 0.84}
LDG_BOX.parent_element		= TAN_CD_MASTER.name
LDG_BOX.element_params 		= {"LANDING_MODE"}
LDG_BOX.controllers   		= {{"parameter_compare_with_number",0, 1}} --
AddElement(LDG_BOX)
--]]



local REF			= create_mfd_tex(CENTER_DISPLAY_BLACK, 460, 1120, 530 , 1420,FONT_SIZE)  
REF.name			= create_guid_string()
REF.init_pos		= {0.96, 1.14}
REF.parent_element	= TAN_CD_MASTER.name
AddElement(REF)

local LONLAT_BOX			= create_mfd_tex(CENTER_DISPLAY_BLACK, 40, 1730, 1470 , 2020, 0.6) 
LONLAT_BOX.name			= create_guid_string()
LONLAT_BOX.init_pos		= {0, -1.075}
LONLAT_BOX.parent_element	= TAN_CD_MASTER.name
AddElement(LONLAT_BOX)

add_text_param(-0.14, 0.04, "LAT_DEGREES", "%0.0f", LONLAT_BOX, mfd_strdefs_digit, "Gripen_Font_black")
add_text_param( 0.1, 0.04, "LAT_DECIMALMINUTES", "%0.3f", LONLAT_BOX, mfd_strdefs_digit, "Gripen_Font_black")

add_text_param(-0.14, -0.04, "LON_DEGREES", "%0.0f", LONLAT_BOX, mfd_strdefs_digit, "Gripen_Font_black")
add_text_param( 0.1, -0.04, "LON_DECIMALMINUTES", "%0.3f", LONLAT_BOX, mfd_strdefs_digit, "Gripen_Font_black")

local BEARING_B				= create_mfd_tex(CENTER_DISPLAY_BLACK, 1110, 1235, 1170 , 1337, FONT_SIZE) 
BEARING_B.name				= create_guid_string()
BEARING_B.init_pos			= {0.5, -1.02}
BEARING_B.parent_element	= TAN_CD_MASTER.name
AddElement(BEARING_B)

add_text_param(0.08, -0.005, "NUMERICAL_HEADING", "%0.0f", BEARING_B, mfd_strdefs_digit_S, "Gripen_Font_black")

local DEG_SYMBOL			= create_mfd_tex(CENTER_DISPLAY_BLACK, 1230, 1120, 1270 , 1160, FONT_SIZE) 
DEG_SYMBOL.name				= create_guid_string()
DEG_SYMBOL.init_pos			= {0.65, -1.01}
DEG_SYMBOL.parent_element	= TAN_CD_MASTER.name
AddElement(DEG_SYMBOL)

local ALTITUDE_A			= create_mfd_tex(CENTER_DISPLAY_BLACK, 870, 1210, 960 , 1310, FONT_SIZE) 
ALTITUDE_A.name				= create_guid_string()
ALTITUDE_A.init_pos			= {0.5, -1.17}
ALTITUDE_A.parent_element	= TAN_CD_MASTER.name
AddElement(ALTITUDE_A)

add_text_param(0.12, -0.0055 , "RAW_RALT", "%0.0f", ALTITUDE_A, mfd_strdefs_digit_S, "Gripen_Font_black")


add_text("M", 0.75, -1.17, TAN_CD_MASTER, "Gripen_Font_black", mfd_strdefs_digit_S )

Mach_indicator 				= CreateElement "ceStringPoly"
Mach_indicator.name 				= create_guid_string()
Mach_indicator.parent_element		= TAN_CD_MASTER.name
Mach_indicator.material				= fonts["Gripen_Font_black"]
Mach_indicator.init_pos 			= {0.844, -1.17}
Mach_indicator.alignment 			= "LeftCenter"
Mach_indicator.stringdefs 			= mfd_strdefs_digit_S
Mach_indicator.formats 				= {"%0.0f","%s"}
Mach_indicator.element_params 		= {"MACH_B"}
Mach_indicator.controllers 			= {{"text_using_parameter",0,0},{"parameter_in_range" ,0, 3, 99.5}}
AddElement(Mach_indicator)

add_text(".", -0.0115, 0, Mach_indicator, "Gripen_Font_black",mfd_strdefs_digit_S )

Mach_indicator2 				= CreateElement "ceStringPoly"
Mach_indicator2.name 				= create_guid_string()
Mach_indicator2.parent_element		= TAN_CD_MASTER.name
Mach_indicator2.material			= fonts["Gripen_Font_black"]
Mach_indicator2.init_pos 			= {0.79, -1.17}
Mach_indicator2.alignment 			= "LeftCenter"
Mach_indicator2.stringdefs 			= mfd_strdefs_digit_S
Mach_indicator2.formats 			= {"%0.2f","%s"}
Mach_indicator2.element_params 		= {"MACH_A"}
Mach_indicator2.controllers 		= {{"text_using_parameter",0,0},{"parameter_in_range" ,0, 0.995, 3}}
AddElement(Mach_indicator2)


local XTD				= create_mfd_tex(CENTER_DISPLAY_BLACK, 1330, 1425, 1555 , 1520, FONT_SIZE) 
XTD.name				= create_guid_string()
XTD.init_pos			= {-0.4, 1.32}
XTD.parent_element	= TAN_CD_MASTER.name
AddElement(XTD)

local XTD_METER				= create_mfd_tex(CENTER_DISPLAY_BLACK, 1535, 1120, 1616 , 1195, FONT_SIZE) 
XTD_METER.name				= create_guid_string()
XTD_METER.init_pos			= {-0.53, 1.3125}
XTD_METER.parent_element	= TAN_CD_MASTER.name
AddElement(XTD_METER)

add_text_param(-0.04,0 , "TERRAIN_DATA_ALT", "%0.0f", XTD_METER, mfd_strdefs_digit_S, "Gripen_Font_black")

local TAN_Background_Mask 					= CreateElement "ceMeshPoly"
TAN_Background_Mask.name 			= create_guid_string()
TAN_Background_Mask.primitivetype 	= "triangles"
TAN_Background_Mask.vertices	   		= { {-0.925 , 1.4 }, { 0.925,1.4}, { 0.925,-0.9}, {-0.925,-0.9}, }
TAN_Background_Mask.indices			= {0, 1, 2, 0, 2, 3}
TAN_Background_Mask.init_pos			= {0, 0, 0}
TAN_Background_Mask.material			= MakeMaterial(nil,{222, 203, 110,255})	--RGBA
TAN_Background_Mask.parent_element	= TAN_CD_MASTER.name
TAN_Background_Mask.h_clip_relation  = h_clip_relations.INCREASE_IF_LEVEL
TAN_Background_Mask.level			= MFD_DEFAULT_LEVEL
TAN_Background_Mask.isvisible		= false
AddElement2(TAN_Background_Mask)

local HORIZON_LINE_base 				= CreateElement "ceSimple"
HORIZON_LINE_base.init_pos		= {0, 0.195}	
HORIZON_LINE_base.name			= create_guid_string()
HORIZON_LINE_base.h_clip_relation = h_clip_relations.DECREASE_IF_LEVEL 
HORIZON_LINE_base.level           = MFD_DEFAULT_LEVEL + 1
HORIZON_LINE_base.parent_element	 = TAN_CD_MASTER.name
HORIZON_LINE_base.element_params 	= {"RAW_RALT", "ADI_ROLL"}
HORIZON_LINE_base.controllers		= { {"parameter_in_range", 0, -1, 3001} , {"rotate_using_parameter" ,1, 1}}
AddElement2(HORIZON_LINE_base)

local HORIZON_LINE			= create_mfd_tex(CENTER_DISPLAY_COLOR, 4, 1664, 1815 , 1668, 2) 
HORIZON_LINE.name			= create_guid_string()
HORIZON_LINE.init_pos		= {0, 0}
HORIZON_LINE.parent_element	= HORIZON_LINE_base.name
HORIZON_LINE.h_clip_relation  = h_clip_relations.DECREASE_IF_LEVEL  
HORIZON_LINE.level			= MFD_DEFAULT_LEVEL + 1
HORIZON_LINE.element_params 	= {"CD_BRIGHTNESS"}
HORIZON_LINE.controllers		= { JAS_Bright[1],JAS_Bright[2],JAS_Bright[3],JAS_Bright[4],JAS_Bright[5],JAS_Bright[6],JAS_Bright[7],JAS_Bright[8],JAS_Bright[9],JAS_Bright[10],JAS_Bright[11],JAS_Bright[12],JAS_Bright[13],JAS_Bright[14],JAS_Bright[15], JAS_Bright[16],JAS_Bright[17],JAS_Bright[18],JAS_Bright[19],JAS_Bright[20]}
AddElement2(HORIZON_LINE)


local HORIZON_ALT_A			= create_mfd_tex(CENTER_DISPLAY_COLOR, 1512, 1887, 1571 , 1960, 1) 
HORIZON_ALT_A.name			= create_guid_string()
HORIZON_ALT_A.init_pos		= {0.30, 0.039}
HORIZON_ALT_A.parent_element	= HORIZON_LINE.name
HORIZON_ALT_A.h_clip_relation  = h_clip_relations.DECREASE_IF_LEVEL  
HORIZON_ALT_A.level			= MFD_DEFAULT_LEVEL + 1
HORIZON_ALT_A.element_params 	= {"CD_BRIGHTNESS"}
HORIZON_ALT_A.controllers		= { JAS_Bright[1],JAS_Bright[2],JAS_Bright[3],JAS_Bright[4],JAS_Bright[5],JAS_Bright[6],JAS_Bright[7],JAS_Bright[8],JAS_Bright[9],JAS_Bright[10],JAS_Bright[11],JAS_Bright[12],JAS_Bright[13],JAS_Bright[14],JAS_Bright[15], JAS_Bright[16],JAS_Bright[17],JAS_Bright[18],JAS_Bright[19],JAS_Bright[20]}
AddElement2(HORIZON_ALT_A)

								
green_text_param_with_cd_brightness(0.14, 0 , "RAW_RALT", "%0.0f", HORIZON_ALT_A, {0.007,0.007, 0, 0}, "Gripen_Font_HL_Green")


local HORIZON_LINE_FPM			= create_mfd_tex(CENTER_DISPLAY_COLOR, 1504, 1717, 1709 , 1818, 2) 
HORIZON_LINE_FPM.name			= create_guid_string()
HORIZON_LINE_FPM.init_pos		= {0, 0.043}
HORIZON_LINE_FPM.parent_element	= HORIZON_LINE.name
HORIZON_LINE_FPM.element_params  = {"CD_BRIGHTNESS", "ADI_ROLL","VELVEC_HUD_Y","VELVEC_HUD_X","ADI_PITCH"}
HORIZON_LINE_FPM.controllers	 = {JAS_Bright[1],JAS_Bright[2],JAS_Bright[3],JAS_Bright[4],JAS_Bright[5],JAS_Bright[6],JAS_Bright[7],JAS_Bright[8],JAS_Bright[9],JAS_Bright[10],JAS_Bright[11],JAS_Bright[12],JAS_Bright[13],JAS_Bright[14],JAS_Bright[15], JAS_Bright[16],JAS_Bright[17],JAS_Bright[18],JAS_Bright[19],JAS_Bright[20], 
									{"rotate_using_parameter" ,1, -1},{"move_up_down_using_parameter",2, 0.036}, {"move_left_right_using_parameter",3, 0.036},{"move_up_down_using_parameter",4, -0.036} }
AddElement(HORIZON_LINE_FPM)

local GROUNDCOLLISION			= create_mfd_tex(CENTER_DISPLAY_COLOR, 1380, 145, 1680 , 298, 1.5) 
GROUNDCOLLISION.name			= create_guid_string()
GROUNDCOLLISION.init_pos		= {0, 0.023}
GROUNDCOLLISION.parent_element	= HORIZON_LINE_FPM.name
GROUNDCOLLISION.element_params  = {"CD_BRIGHTNESS","PULLUPQUE", "ROLL_HUD", "VELVEC_HUD_Y","CURRENT_PHASE_STATIONARY","CURRENT_PHASE_PARKED","CURRENT_PHASE_TAXI",
												"CURRENT_PHASE_TGR","CURRENT_PHASE_ROT","CURRENT_PHASE_TD","CURRENT_PHASE_LR","CURRENT_PHASE_PAL", "PULLMORE"}
GROUNDCOLLISION.controllers	 	= { JAS_Bright[1],JAS_Bright[2],JAS_Bright[3],JAS_Bright[4],JAS_Bright[5],JAS_Bright[6],JAS_Bright[7],JAS_Bright[8],JAS_Bright[9],JAS_Bright[10],JAS_Bright[11],JAS_Bright[12],JAS_Bright[13],JAS_Bright[14],JAS_Bright[15], JAS_Bright[16],JAS_Bright[17],JAS_Bright[18],JAS_Bright[19],JAS_Bright[20],
								  {"parameter_in_range",1, -10000,0},{"rotate_using_parameter" ,2, 1.00},
								  {"move_up_down_using_parameter",3, 0.1} ,{"parameter_compare_with_number",4, 0},{"parameter_compare_with_number",5, 0},
								  {"parameter_compare_with_number",6, 0},{"parameter_compare_with_number",7, 0},{"parameter_compare_with_number",8, 0},
								  {"parameter_compare_with_number",9, 0},{"parameter_compare_with_number",10, 0},{"parameter_compare_with_number",11, 0}, {"parameter_in_range",12, -0.99,0.5} }	
AddElement(GROUNDCOLLISION)

local DISTANCE_SCALE			= create_mfd_tex(CENTER_DISPLAY_BLACK, 1850, 0, 2040 , 2048, 1.175) 
DISTANCE_SCALE.name				= create_guid_string()
DISTANCE_SCALE.init_pos			= {0.75, 0.25}
DISTANCE_SCALE.parent_element	= TAN_CD_MASTER.name
DISTANCE_SCALE.h_clip_relation = h_clip_relations.DECREASE_IF_LEVEL 
DISTANCE_SCALE.level           = MFD_DEFAULT_LEVEL + 1
AddElement2(DISTANCE_SCALE)


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

for i = 1, 3 do
local tilt = 0
local pos = {0.0025, -0.1275  }
local verts = { {0,0},{0, 0.1} }
	if i == 1 then		
		tilt = 165
	elseif i == 2 then
		tilt = -165
	else
		tilt = 90
		verts = { {0,0},{0, 0.051764} }
		pos = {0.0025 + 0.051764/2, -0.1 + 0.0075-0.1275  }
	end

local PositionLine				= CreateElement "ceSimpleLineObject"
	PositionLine.init_pos			= pos
	PositionLine.material			= MakeMaterial(nil,{50, 200, 50,255})
	PositionLine.width				= 0.0045
	PositionLine.parent_element		= TAN_CD_MASTER.name
	PositionLine.vertices			= verts
	PositionLine.init_rot			= {tilt, 0, 0}
	PositionLine.element_params    	=  {"CD_BRIGHTNESS", "CD_FIX_TOGGLE"}
	PositionLine.controllers        = {Green_Bright[1],Green_Bright[2],Green_Bright[3],Green_Bright[4],Green_Bright[5],Green_Bright[6],Green_Bright[7],Green_Bright[8],Green_Bright[9],Green_Bright[10],Green_Bright[11],Green_Bright[12],Green_Bright[13],Green_Bright[14],Green_Bright[15], Green_Bright[16],Green_Bright[17],Green_Bright[18],Green_Bright[19],Green_Bright[20],{"parameter_compare_with_number", 1, 0}}
	AddElement(PositionLine)
end

for i = 0, 1500 do 
	PositionLine				= CreateElement "ceSimpleLineObject"
	PositionLine.init_pos			= {0.0025, -0.1275 }
	PositionLine.material			= MakeMaterial(nil,{50, 200, 50,255})
	PositionLine.width				= 0.0045
	PositionLine.parent_element		= TAN_CD_MASTER.name
	PositionLine.vertices			= { {0,0},{0, 0.00108 * i} }
	PositionLine.element_params    =  {"CD_BRIGHTNESS", "CUR_GS", "CD_FIX_TOGGLE"}
	PositionLine.controllers        = {Green_Bright[1],Green_Bright[2],Green_Bright[3],Green_Bright[4],Green_Bright[5],Green_Bright[6],Green_Bright[7],Green_Bright[8],Green_Bright[9],Green_Bright[10],Green_Bright[11],Green_Bright[12],Green_Bright[13],Green_Bright[14],Green_Bright[15], Green_Bright[16],Green_Bright[17],Green_Bright[18],Green_Bright[19],Green_Bright[20], {"parameter_in_range",1, i * 9, i * 10}, {"parameter_compare_with_number", 2, 0}}
	AddElement(PositionLine)
end
