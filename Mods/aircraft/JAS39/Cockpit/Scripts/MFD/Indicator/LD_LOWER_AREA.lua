get_param_handle("ADIWPLX"):set(1)
get_param_handle("ADIWPLY"):set(-1)
get_param_handle("ADIWPLL"):set(1)



TAN_LD_MASTER 			= CreateElement "ceSimple"
TAN_LD_MASTER.init_pos	= {0,0}
TAN_LD_MASTER.name		= create_guid_string()
TAN_LD_MASTER.element_params = {"LD_EMGY_MODE", "mainpower"}
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
adi_background.element_params  = {"ADI_PITCH", "HEADING"}
adi_background.controllers	 = {{"move_up_down_using_parameter",0, 0.036}, {"move_left_right_using_parameter",1, -0.0005982} }
AddElement2(adi_background)

-- Circle around the ADI
local adi_indicator				= create_mfd_tex(ADI_FRAME_B, 0, 0, 1270, 1270,0.67)
adi_indicator.name				= create_guid_string()
adi_indicator.init_pos			= {0, -0.77}
adi_indicator.parent_element	= GENERAL_PAGE.name
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
adi_roll.element_params 	= {"ADI_ROLL",}
adi_roll.controllers		= {{"rotate_using_parameter" ,0, 1}}
AddElement(adi_roll)


-- Waypoint direction indicator on ADI ball

local WP          = CreateElement "ceMeshPoly"
WP.primitivetype  = "triangles"
set_circle(WP, 0.03, 0.03 - 0.007, 360, 12)

WP.name           = "TGTWP"
WP.material       = MakeMaterial(nil, {0, 0, 0, 255})
WP.parent_element = adi_Attitude.name
WP.init_pos        = {0, 0}
WP.element_params  = {
	"nextWPADIAzUnclamped",
    "nextWPADIElUnclamped",
    "WP_2_distance",
	"adi_roll",
}
WP.controllers     = {

    {"move_left_right_using_parameter", 0, 0.025},
	{"move_up_down_using_parameter",    1, 0.015},
	{"rotate_using_parameter" ,3, 1},

}
WP.h_clip_relation = h_clip_relations.DECREASE_IF_LEVEL_IF_LEVEL
WP.level           = MFD_DEFAULT_LEVEL - 1

AddElement(WP)

	--"WP_" .. selectedWP:get() .. "_CDX",
    --"WP_" .. selectedWP:get() .. "_CDY",
    --"WP_" .. selectedWP:get() .. "_distance",


local wpLine           = CreateElement "ceSimpleLineObject"
wpLine.name            = create_guid_string()
wpLine.material        = MakeMaterial(nil, {0, 0, 0, 255})
wpLine.parent_element  = WP.name
wpLine.vertices        = {
    {0, 0},
    {0, 0}
}
wpLine.init_pos        = {0, 0}
wpLine.width           = 0.0035

wpLine.element_params  = {"ADIWPLX", "ADIWPLX", "ADIWPLY", "ADIWPLY", "ADIWPLL"}
wpLine.controllers     = {
    {"line_object_set_point_using_parameters", 0, 1, 1, 0.0015, 0.0015},
    {"line_object_set_point_using_parameters", 2, 3, 3, 0.0015, 0.0015},
}

wpLine.h_clip_relation = h_clip_relations.DECREASE_IF_LEVEL
wpLine.level           = WP.level + 1

AddElement(wpLine)

local wpLine2          = CreateElement "ceSimpleLineObject"
wpLine2.name            = create_guid_string()
wpLine2.material        = MakeMaterial(nil, {0, 0, 0, 255})
wpLine2.parent_element  = WP.name
wpLine2.vertices        = {
    {0, 0},
    {0, 0}
}
wpLine2.init_pos        = {0, 0}
wpLine2.width           = 0.0035

wpLine2.element_params  = {"ADIWPLX", "ADIWPLX", "ADIWPLY", "ADIWPLY", "ADIWPLL"}
wpLine2.controllers     = {
    {"line_object_set_point_using_parameters", 0, 3, 1, 0.0015, 0.0015},
    {"line_object_set_point_using_parameters", 2, 1, 3, 0.0015, 0.0015},
}

wpLine2.h_clip_relation = h_clip_relations.DECREASE_IF_LEVEL
wpLine2.level           = WP.level + 1

AddElement(wpLine2)






local alfa_g_box			= create_mfd_tex(NAV_WHEEL_BLACK, 1640, 0, 2048, 212,0.9)
alfa_g_box.name				= create_guid_string()
alfa_g_box.init_pos			= {-0.7, -1.0}
alfa_g_box.parent_element	= GENERAL_PAGE.name
AddElement(alfa_g_box)

local G_indicator = add_text_param(0.04, -0.04, "CUR_G", "%0.1f", alfa_g_box, mfd_strdefs_digit, "Gripen_Font_black")

local ALFA_indicator = add_text_param(0, 0.04, "AoA", "%0.0f", alfa_g_box, mfd_strdefs_digit, "Gripen_Font_black")

-- Speedometer
local Speedometer = MakeDial(-0.61, -0.5, 0.26, 0.1, 180, 540, 0.0075, true, 36, "mainpower", "SPEEDOMETER_IAS", 360, materials["BBLACK"], GENERAL_PAGE.name, MakeMaterial(nil, {5 * 9, 7 * 9, 11 * 9, 175}))

for i = -340, -40, 40 do
	if i == -60 then
		j = i + 25
	else
		j = i
	end
	Speedometer_Nums = add_text(tostring(math.floor(math.abs(i) / 40)), -0.61 + 0.21 * math.cos(math.rad(j + 90)), -0.5 + 0.21 * math.sin(math.rad(j + 90)), GENERAL_PAGE, "Gripen_Font_black", mfd_strdefs_digit_XS)
end

for i = 60, 340, 20 do
	if i == 60 then
		rot = 35
	else
		rot = i
	end

	if i == 60 or i == 80 or i == 100 or i == 140 or i == 180 or i == 220 or i == 260 or i == 300 or rot == 340 then
		vert = 0.035
	else
		vert = 0.045
	end

	Speedometer_Lines                = CreateElement "ceSimpleLineObject"
	Speedometer_Lines.name           = create_guid_string()
	Speedometer_Lines.material       = materials["BBLACK"]
	Speedometer_Lines.vertices       = {{0, 0.06}, {0, vert}}
	Speedometer_Lines.width          = .0025 * 1.25
	Speedometer_Lines.init_pos       = {-0.61 + 0.2 * math.cos(math.rad(-rot + 90)), -0.5 + 0.2 * math.sin(math.rad(-rot + 90))}
	Speedometer_Lines.init_rot       = {-rot}
	Speedometer_Lines.parent_element = GENERAL_PAGE.name
	AddElement(Speedometer_Lines)
end

for i = 35 + 9, 80 - 9, 9 do
	local Speedometer_Lines          = CreateElement "ceSimpleLineObject"
	Speedometer_Lines.name           = create_guid_string()
	Speedometer_Lines.material       = materials["BBLACK"]
	Speedometer_Lines.vertices       = {{0, 0.06}, {0, 0.045}}
	Speedometer_Lines.width          = 0.0025 * 1.25
	Speedometer_Lines.init_pos       = {-0.61 + 0.2 * math.cos(math.rad(-i + 90)), -0.5 + 0.2 * math.sin(math.rad(-i + 90))}
	Speedometer_Lines.init_rot       = {-i}
	Speedometer_Lines.parent_element = GENERAL_PAGE.name
	AddElement(Speedometer_Lines)
end

local speedometer_needle          = create_mfd_tex_3k(MFD_ELEMENTS_PDD, 82, 2230, 353, 2272, 1.0, -57, 2260 + ((2243 - 2230) / 2))
speedometer_needle.name           = create_guid_string()
speedometer_needle.init_pos       = {-0.61, -0.5}
speedometer_needle.init_rot       = {90, 0}
speedometer_needle.parent_element = GENERAL_PAGE.name
speedometer_needle.level          = MFD_DEFAULT_LEVEL - 1
speedometer_needle.element_params = {"SPEEDOMETER_IAS"}
speedometer_needle.controllers    = {{"rotate_using_parameter", 0, -math.rad(1)}}
AddElement(speedometer_needle)

add_text("M", -0.61, -0.46, GENERAL_PAGE, "Gripen_Font_black", mfd_strdefs_digit_S)

Mach_indicator                = CreateElement "ceStringPoly"
Mach_indicator.name           = create_guid_string()
Mach_indicator.parent_element = GENERAL_PAGE.name
Mach_indicator.material       = fonts["Gripen_Font_black"]
Mach_indicator.init_pos       = {-0.61, -0.52}
Mach_indicator.alignment      = "LeftCenter"
Mach_indicator.stringdefs     = mfd_strdefs_digit_S
Mach_indicator.formats        = {"%0.0f", "%s"}
Mach_indicator.element_params = {"MACH_B"}
Mach_indicator.controllers    = {{"text_using_parameter", 0, 0}, {"parameter_in_range", 0, 3, 99.5}}
AddElement(Mach_indicator)

add_text(".", -0.0115, 0, Mach_indicator, "Gripen_Font_black", mfd_strdefs_digit_S)

Mach_indicator2                = CreateElement "ceStringPoly"
Mach_indicator2.name           = create_guid_string()
Mach_indicator2.parent_element = GENERAL_PAGE.name
Mach_indicator2.material       = fonts["Gripen_Font_black"]
Mach_indicator2.init_pos       = {-0.669, -0.52}
Mach_indicator2.alignment      = "LeftCenter"
Mach_indicator2.stringdefs     = mfd_strdefs_digit_S
Mach_indicator2.formats        = {"%0.2f", "%s"}
Mach_indicator2.element_params = {"MACH_A"}
Mach_indicator2.controllers    = {{"text_using_parameter", 0, 0}, {"parameter_in_range", 0, 0.995, 3}}
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
adi_background.element_params  = {"ADI_ATTITUDE"}
adi_background.controllers	 = {{"move_up_down_using_parameter",0, 0.036} }
AddElement2(adi_background)

-- Circle around the ADI
local adi_indicator				= create_mfd_tex(ADI_FRAME_B, 0, 0, 1270, 1270,0.67)
adi_indicator.name				= create_guid_string()
adi_indicator.init_pos			= {0, -0.77}
adi_indicator.parent_element	= MONITOR_PAGE.name
AddElement(adi_indicator)
	
-- Attitude marker
local ADI_MONITOR_ATTITUDE				= create_mfd_tex(AAR_LDP_BLACK, 1512, 1508 , 2019, 1578,0.8)
ADI_MONITOR_ATTITUDE.name				= create_guid_string()
ADI_MONITOR_ATTITUDE.init_pos			= {-0.008, -0.8}
ADI_MONITOR_ATTITUDE.parent_element		= MONITOR_PAGE.name
AddElement(ADI_MONITOR_ATTITUDE)
	
--Roll marker
local adi_roll				= create_mfd_tex(ADI_FRAME_B, 1975, 0, 2038, 1143.27, 0.65 )
adi_roll.name				= create_guid_string()
adi_roll.init_pos			= {-0.005, 0}
adi_roll.parent_element		= adi_indicator.name
adi_roll.element_params 	= {"ADI_ROLL",}
adi_roll.controllers		= {{"rotate_using_parameter" ,0, 1}}
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
AddElement(HEADING_ARROW_EMGY)

local MAG_text = add_text("MAG", -0.315,-0.039, HEADING_TAPE_MONITOR_MASK, "Gripen_Font_black", mfd_strdefs_digit_XS )

AIRSPEED_MONITOR_SCALE			= create_mfd_tex(ADI_FRAME_B, 1870, 1070 , 1925, 1855,0.69)
AIRSPEED_MONITOR_SCALE.name			= create_guid_string()
AIRSPEED_MONITOR_SCALE.init_pos		= {-0.5, -0.7925}
AIRSPEED_MONITOR_SCALE.parent_element	= MONITOR_PAGE.name
AddElement(AIRSPEED_MONITOR_SCALE)
 
AIRSPEED_MONITOR_ARROW			= create_mfd_tex(ADI_FRAME_B, 1748, 1497 , 1807, 1555,0.75)
AIRSPEED_MONITOR_ARROW.name				= create_guid_string()
AIRSPEED_MONITOR_ARROW.init_pos			= {-0.505, -1.1353}
AIRSPEED_MONITOR_ARROW.parent_element	= MONITOR_PAGE.name
AIRSPEED_MONITOR_ARROW.element_params   = {"EMGY_IAS",}
AIRSPEED_MONITOR_ARROW.controllers	    = {{"move_up_down_using_parameter", 0, 0.0000835}}
AddElement(AIRSPEED_MONITOR_ARROW)

AIRSPEED_MONITOR_READOUT = add_text_param(-0.08,0.0 , "txtCAS", "%0.0f", AIRSPEED_MONITOR_ARROW, mfd_strdefs_digit_XS, "Gripen_Font_black") 

ALFA_SYMBOL_MONITOR					 = create_mfd_tex(ADI_FRAME_B, 1795, 435 , 1875, 510,0.6)
ALFA_SYMBOL_MONITOR.name			 = create_guid_string()
ALFA_SYMBOL_MONITOR.init_pos		 = {-0.53, -0.499}
ALFA_SYMBOL_MONITOR.parent_element	 = MONITOR_PAGE.name
AddElement(ALFA_SYMBOL_MONITOR)


Mach_indicatorMonitor 						= CreateElement "ceStringPoly"
Mach_indicatorMonitor.name 					= create_guid_string()
Mach_indicatorMonitor.parent_element		= MONITOR_PAGE.name
Mach_indicatorMonitor.material				= fonts["Gripen_Font_black"]
Mach_indicatorMonitor.init_pos 				= {-0.45, -1.12}
Mach_indicatorMonitor.alignment 			= "LeftCenter"
Mach_indicatorMonitor.stringdefs 			= mfd_strdefs_digit_XS
Mach_indicatorMonitor.formats 				= {"%0.0f","%s"}
Mach_indicatorMonitor.element_params 		= {"machDecimals"}
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
Mach_indicatorMonitor2.element_params 		= {"machWhole"}
Mach_indicatorMonitor2.controllers 			= {{"text_using_parameter",0,0},{"parameter_in_range" ,0, 0.995, 3}}
AddElement(Mach_indicatorMonitor2)

--[[
add_text_param(-0.40, -1.12, "CUR_MACH", "%0.2f", MONITOR_PAGE, mfd_strdefs_digit_XS, "Gripen_Font_black")
--]]
Mach_text_MONITOR = add_text("M", -0.55, -1.12, MONITOR_PAGE, "Gripen_Font_black", mfd_strdefs_digit_XS)


add_text_param(-0.45, -0.499, "AoA", "%0.0f", MONITOR_PAGE, mfd_strdefs_digit_XS, "Gripen_Font_black")









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
ALTITUDE_SCALE_MONITOR.element_params  	= {"EMGY_ALTITUDE"}
ALTITUDE_SCALE_MONITOR.controllers	 	= {{"move_left_right_using_parameter",0, -0.00001903} }
AddElement2(ALTITUDE_SCALE_MONITOR)

ALTITUDE_SCALE_MONITOR2						= create_mfd_tex_3300(EMGY_HEADING_BLACK, 0, 1237, 3072, 1401,2.5)
ALTITUDE_SCALE_MONITOR2.name				= create_guid_string()
ALTITUDE_SCALE_MONITOR2.init_pos			= {0.65, 6.1288-0.072}
ALTITUDE_SCALE_MONITOR2.init_rot			= {90, 0}
ALTITUDE_SCALE_MONITOR2.parent_element		= MONITOR_PAGE.name
ALTITUDE_SCALE_MONITOR2.h_clip_relation 	= h_clip_relations.DECREASE_IF_LEVEL  
ALTITUDE_SCALE_MONITOR2.level           	= MFD_DEFAULT_LEVEL + 2
ALTITUDE_SCALE_MONITOR2.element_params  	= {"EMGY_ALTITUDE"}
ALTITUDE_SCALE_MONITOR2.controllers	 		= {{"move_left_right_using_parameter",1, -0.00001903} }
AddElement2(ALTITUDE_SCALE_MONITOR2)

ALTITUDE_SCALE_MONITOR3						= create_mfd_tex_3300(EMGY_HEADING_BLACK, 0, 1431 , 3072, 1594,2.5)
ALTITUDE_SCALE_MONITOR3.name				= create_guid_string()
ALTITUDE_SCALE_MONITOR3.init_pos			= {0.65, 10.687-0.072}
ALTITUDE_SCALE_MONITOR3.init_rot			= {90, 0}
ALTITUDE_SCALE_MONITOR3.parent_element		= MONITOR_PAGE.name
ALTITUDE_SCALE_MONITOR3.h_clip_relation 	= h_clip_relations.DECREASE_IF_LEVEL  
ALTITUDE_SCALE_MONITOR3.level           	= MFD_DEFAULT_LEVEL + 2
ALTITUDE_SCALE_MONITOR3.element_params  	= {"EMGY_ALTITUDE"}
ALTITUDE_SCALE_MONITOR3.controllers	 		= {{"move_left_right_using_parameter",0, -0.00001903} }
AddElement2(ALTITUDE_SCALE_MONITOR3)

ALTITUDE_SCALE_MONITOR4						= create_mfd_tex_3300(EMGY_HEADING_BLACK, 0, 1627 , 3072, 1790,2.5)
ALTITUDE_SCALE_MONITOR4.name				= create_guid_string()
ALTITUDE_SCALE_MONITOR4.init_pos			= {0.65, 15.244-0.072}
ALTITUDE_SCALE_MONITOR4.init_rot			= {90, 0}
ALTITUDE_SCALE_MONITOR4.parent_element		= MONITOR_PAGE.name
ALTITUDE_SCALE_MONITOR4.h_clip_relation 	= h_clip_relations.DECREASE_IF_LEVEL  
ALTITUDE_SCALE_MONITOR4.level           	= MFD_DEFAULT_LEVEL + 2
ALTITUDE_SCALE_MONITOR4.element_params  	= {"EMGY_ALTITUDE"}
ALTITUDE_SCALE_MONITOR4.controllers	 		= {{"move_left_right_using_parameter",0, -0.00001903} }
AddElement2(ALTITUDE_SCALE_MONITOR4)

ALTITUDE_MONITOR_ARROW			= create_mfd_tex(ADI_FRAME_B, 1748, 1497 , 1807, 1555,0.75)
ALTITUDE_MONITOR_ARROW.name				= create_guid_string()
ALTITUDE_MONITOR_ARROW.init_pos			= {0.5, -0.7075-0.072}
ALTITUDE_MONITOR_ARROW.parent_element	= MONITOR_PAGE.name
AddElement(ALTITUDE_MONITOR_ARROW)


MONITOR_FUEL_BOX					= create_mfd_tex(ADI_FRAME_B, 1400, 12 , 1775, 380,0.50)
MONITOR_FUEL_BOX.name				= create_guid_string()
MONITOR_FUEL_BOX.init_pos			= {-0.72, -0.50}
MONITOR_FUEL_BOX.parent_element		= MONITOR_PAGE.name

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
RPMDial = MakeDial(-.53, -.835, .25, 0, 0, 270, .008, false, 36, "mainpower", "RPM_NEEDLE", 270, materials["BBLACK"], ENGINE_PAGE.name, MakeMaterial(nil, {5 * 9, 7 * 9, 11 * 9, 175})) -- 0, 1.3, 1.3, 200

for i = 0, 240, 30 do
	local RPMDialLines          = CreateElement "ceSimpleLineObject"
	RPMDialLines.name           = create_guid_string()
	RPMDialLines.material       = materials["BBLACK"]
	RPMDialLines.vertices       = {{0, 0}, {0, .02}}
	RPMDialLines.width          = .004
	RPMDialLines.init_pos       = {.25 * math.cos(math.rad(-i + 90)), .25 * math.sin(math.rad(-i + 90))}
	RPMDialLines.init_rot       = {-i}
	RPMDialLines.parent_element = RPMDial.name
	AddElement(RPMDialLines)
end

RPMText          = add_text("RPM%", .175, -.31, RPMDial, "Gripen_Font_black", mfd_strdefs_digit, "CenterCenter")
RPMText.init_rot = {180}

RPMText90          = add_text("90", -.04, -.31, RPMDial, "Gripen_Font_black", mfd_strdefs_digit, "CenterCenter")
RPMText90.init_rot = {180}

RPMText60          = add_text("60", .32, 0, RPMDial, "Gripen_Font_black", mfd_strdefs_digit, "CenterCenter")
RPMText60.init_rot = {180}

RPMNeedle                = create_mfd_tex(MFD_ELEMENTS_DARK, 463, 824, 674, 855, 1.3, 473)
RPMNeedle.name           = create_guid_string()
RPMNeedle.init_rot       = {90}
RPMNeedle.element_params = {"RPM_NEEDLE"}
RPMNeedle.controllers    = {{"rotate_using_parameter", 0, -math.rad(1)}}
RPMNeedle.parent_element = RPMDial.name
AddElement(RPMNeedle)


digitalRPMBox                = CreateElement "ceSimpleLineObject"
digitalRPMBox.name           = create_guid_string()
digitalRPMBox.material       = materials["BBLACK"]
digitalRPMBox.vertices       = {{0}, {0, .045}, {-.095, .045}, {-.095, .07}, {-.173, .07}, {-.173, -.08}, {-.095, -.08}, {-.095, -.045}, {0, -.045}, {0}}
digitalRPMBox.width          = .004
digitalRPMBox.init_pos       = {-.041, .105 + .095 / 2}
digitalRPMBox.parent_element = RPMDial.name
AddElement(digitalRPMBox)

digitalRPM          = add_text_param(-.1075, .15, "RPM_PARAM_U", "%02.0f", RPMDial, mfd_strdefs_digit, "Gripen_Font_black", "LeftCenter")
digitalRPM.init_rot = {180}

digitalRPM100                = add_text("1", -.1075 + .035, .15, RPMDial, "Gripen_Font_black", mfd_strdefs_digit, "LeftCenter")
digitalRPM100.init_rot       = {180}
digitalRPM100.element_params = {"RPM_PARAM"}
digitalRPM100.controllers    = {{"parameter_compare_with_number", 0, 1}}
-- Engine temp
TGTDial = MakeDial(.15, -.835, .25, 0, 0, 270, .008, false, 36, "mainpower", "TGT_NEEDLE", 270, materials["BBLACK"], ENGINE_PAGE.name, MakeMaterial(nil, {5 * 9, 7 * 9, 11 * 9, 175}))

for i = 120, 240, 60 do
	TGTDialLines                = CreateElement "ceSimpleLineObject"
	TGTDialLines.name           = create_guid_string()
	TGTDialLines.material       = materials["BBLACK"]
	TGTDialLines.vertices       = {{0, 0}, {0, .02}}
	TGTDialLines.width          = .004
	TGTDialLines.init_pos       = {.25 * math.cos(math.rad(-i + 90)), .25 * math.sin(math.rad(-i + 90))}
	TGTDialLines.init_rot       = {-i}
	TGTDialLines.parent_element = TGTDial.name
	AddElement(TGTDialLines)
end

TGTText          = add_text("TGT`C", .175, -.31, TGTDial, "Gripen_Font_black", mfd_strdefs_digit, "CenterCenter")
TGTText.init_rot = {180}

TGTText480          = add_text("480", .31, -.155, TGTDial, "Gripen_Font_black", mfd_strdefs_digit, "CenterCenter")
TGTText480.init_rot = {180}

TGTText680          = add_text("680", -.07, -.31, TGTDial, "Gripen_Font_black", mfd_strdefs_digit, "CenterCenter")
TGTText680.init_rot = {180}

TGTText900          = add_text("900", -.31, -.155, TGTDial, "Gripen_Font_black", mfd_strdefs_digit, "CenterCenter")
TGTText900.init_rot = {180}

TGTNeedle                = create_mfd_tex(MFD_ELEMENTS_DARK, 463, 824, 674, 855, 1.3, 473)
TGTNeedle.name           = create_guid_string()
TGTNeedle.init_rot       = {90}
TGTNeedle.element_params = {"TGT_NEEDLE"}
TGTNeedle.controllers    = {{"rotate_using_parameter", 0, -math.rad(1)}}
TGTNeedle.parent_element = TGTDial.name
AddElement(TGTNeedle)


digitalRPMBox                = CreateElement "ceSimpleLineObject"
digitalRPMBox.name           = create_guid_string()
digitalRPMBox.material       = materials["BBLACK"]
digitalRPMBox.vertices       = {{0}, {0, .045}, {-.095, .045}, {-.095, .07}, {-.173, .07}, {-.173, -.08}, {-.095, -.08}, {-.095, -.045}, {0, -.045}, {0}}
digitalRPMBox.width          = .004
digitalRPMBox.init_pos       = {-.041, .105 + .095 / 2}
digitalRPMBox.parent_element = TGTDial.name
AddElement(digitalRPMBox)

digitalTGT          = add_text_param(-.0675, .15, "TGT_PARAM", "%02.0f", TGTDial, mfd_strdefs_digit, "Gripen_Font_black", "LeftCenter")
digitalTGT.init_rot = {180}




--===================================================================================================================================================================================
--	STATIC OBJECTS, stuff that stays the same across pages
--===================================================================================================================================================================================
Ycor = 0.02
local STORE_SCALE = 0.9

local Stores_WINGS			= create_mfd_tex(STORES_WHITE_COLOR,135, 1740, 1920, 1832, STORE_SCALE)
Stores_WINGS.name			= create_guid_string()
Stores_WINGS.init_pos		= {-0.00,-1.25+Ycor }
Stores_WINGS.parent_element	= TAN_LD_MASTER.name
Stores_WINGS.element_params = {"STORES_TOGGLE" }
Stores_WINGS.controllers    = {{"parameter_compare_with_number",0, 1}}
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
MASS_LIVE.element_params 	= {"STORES_TOGGLE", "MASSParam"}
MASS_LIVE.controllers    	= { {"parameter_compare_with_number",0, 1}, {"parameter_compare_with_number",1, 1} }	
AddElement(MASS_LIVE)

local MASS_STBY				= create_mfd_tex(STORES_BLACK, 820, 710, 1000, 775, STORE_SCALE)
MASS_STBY.name				= create_guid_string()
MASS_STBY.init_pos			= {-0.48,-1.1833+Ycor}
MASS_STBY.parent_element	= TAN_LD_MASTER.name
MASS_STBY.element_params 	= {"STORES_TOGGLE", "MASSParam"}
MASS_STBY.controllers    	= { {"parameter_compare_with_number",0, 1}, {"parameter_compare_with_number",1, 0} }	
AddElement(MASS_STBY)

local MASS_SAFE				= create_mfd_tex(STORES_BLACK, 820, 800, 1000, 875, STORE_SCALE)
MASS_SAFE.name				= create_guid_string()
MASS_SAFE.init_pos			= {-0.48,-1.1833+Ycor}
MASS_SAFE.parent_element	= TAN_LD_MASTER.name
MASS_SAFE.element_params 	= {"STORES_TOGGLE", "MASSParam"}
MASS_SAFE.controllers    	= { {"parameter_compare_with_number",0, 1}, {"parameter_compare_with_number",1, -1} }	
AddElement(MASS_SAFE)

local tan_offset = 1005	--  Tan text is 1005 px to the right of black text in the dds

local Tip_Left_init_pos = {-0.7325,-1.313+Ycor }
local Outer_Left_init_pos = {-0.455,-1.313+Ycor }
local Inner_Left_init_pos = {-0.18,-1.313+Ycor }
local Tip_Right_init_pos = {0.7225,-1.313+Ycor }
local Outer_Right_init_pos = {0.445,-1.313+Ycor }
local Inner_Right_init_pos = {0.1675,-1.313+Ycor }


add_text_param(-0.7325, -0.08, "pylonName_1", "%0.4s", Stores_GUN_XF, mfd_strdefs_digit_XS, "Gripen_Font_black")
add_text_param(-0.455, -0.08, "pylonName_3", "%0.4s", Stores_GUN_XF, mfd_strdefs_digit_XS, "Gripen_Font_black")
add_text_param(-0.18, -0.08, "pylonName_5", "%0.4s", Stores_GUN_XF, mfd_strdefs_digit_XS, "Gripen_Font_black")
-- add_text_paramty(-0.7325, -0.08, "pylonName_3", "%0.4s", Stores_GUN_XF, mfd_strdefs_digit_XS, "Gripen_Font_black")
-- add_text_paramty(-0.7325, -0.08, "pylonName_4", "%0.4s", Stores_GUN_XF, mfd_strdefs_digit_XS, "Gripen_Font_black")
add_text_param(0.1675, -0.08, "pylonName_6", "%0.4s", Stores_GUN_XF, mfd_strdefs_digit_XS, "Gripen_Font_black")
add_text_param(0.445, -0.08, "pylonName_4", "%0.4s", Stores_GUN_XF, mfd_strdefs_digit_XS, "Gripen_Font_black")
add_text_param(0.7225, -0.08, "pylonName_2", "%0.4s", Stores_GUN_XF, mfd_strdefs_digit_XS, "Gripen_Font_black")

local SPylon0 = SelectedPylon(-0.7325, -0.08, 0, Stores_GUN_XF.name)
AddElement(SPylon0)
local SPylon1 = SelectedPylon(-0.455, -0.08, 2, Stores_GUN_XF.name)
AddElement(SPylon1)
local SPylon2 = SelectedPylon(-0.178, -0.08, 4, Stores_GUN_XF.name)
AddElement(SPylon2)
local SPylon5 = SelectedPylon(0.1675, -0.08, 5, Stores_GUN_XF.name)
AddElement(SPylon5)
local SPylon6 = SelectedPylon(0.445, -0.08, 3, Stores_GUN_XF.name)
AddElement(SPylon6)
local SPylon7 = SelectedPylon(0.7225, -0.08, 1, Stores_GUN_XF.name)
AddElement(SPylon7)

local stupidList = {1, 3, 5, 6, 4, 2}

for i = 1, #stupidList do
	local x

	if i < 4 then
		x = 0.27625 * i - 1.00833
	elseif i >= 4 then
		x = 0.2775 * i - 0.9425
	end

	local sp = add_text_param(x, -0.08, "pylonName_" .. stupidList[i], "%0.4s", Stores_GUN_XF, mfd_strdefs_digit_XS, "Gripen_Font_MFDBG")
	sp.element_params = {"pylonName_" .. stupidList[i], "selectedPylon"}
	sp.controllers    = {{"text_using_parameter", 0}, {"parameter_compare_with_number", 1, stupidList[i] - 1}}
end

local gunBackground          = CreateElement "ceMeshPoly"
gunBackground.name           = create_guid_string()
gunBackground.primitivetype  = "triangles"
gunBackground.vertices       = {{-0.025, -0.03}, {0.025, -0.03}, {-0.025, 0.03}, {0.025, 0.03}}
gunBackground.indices        = {0,1,2 , 3,2,1}
gunBackground.init_pos       = {-0.14, 0.025}
gunBackground.material       = MakeMaterial(nil, {1 * 255, .913098 * 255, .584078 * 255, 255}) --{1 * 255, .913098 * 255, .584078 * 255, 255}
gunBackground.parent_element = Stores_GUN_XF.name
gunBackground.level          = MFD_DEFAULT_LEVEL - 1
AddElement(gunBackground)

add_text("G   ", -0.0125, 0.025, Stores_GUN_XF, "Gripen_Font_black", gunAmmo_strdefs_digit, "RightCenter")
add_text_param(-0.0125, 0.025, "ammoCount", " %0.0f", Stores_GUN_XF, gunAmmo_strdefs_digit, "Gripen_Font_black", "RightCenter")

local SPylonGun          = CreateElement "ceMeshPoly"
SPylonGun.name           = create_guid_string()
SPylonGun.primitivetype  = "triangles"
SPylonGun.vertices       = {{-0.081, -0.033}, {0.091, -0.033}, {-0.081, 0.034}, {0.091, 0.034}}
SPylonGun.indices        = {0,1,2 , 3,2,1}
SPylonGun.init_pos       = {-0.0875, 0.025}
SPylonGun.material       = MakeMaterial(nil, {0, 0, 0, 255})
SPylonGun.parent_element = Stores_GUN_XF.name
SPylonGun.level          = MFD_DEFAULT_LEVEL -1
SPylonGun.element_params = {"selectedPylon"}
SPylonGun.controllers    = {{"parameter_in_range",0, (11 - 1) + 0.9, 11 + 0.1}}
AddElement(SPylonGun)

local selectedGunG = add_text("G   ", -0.0125, 0.025, Stores_GUN_XF, "Gripen_Font_MFDBG", gunAmmo_strdefs_digit, "RightCenter")
selectedGunG.element_params = {"selectedPylon"}
selectedGunG.controllers    = {{"parameter_in_range", 0, (11 - 1) + 0.9, 11 + 0.1}}

local selectedGunAmmo = add_text_param(-0.0125, 0.025, "ammoCount", " %0.0f", Stores_GUN_XF, gunAmmo_strdefs_digit, "Gripen_Font_MFDBG", "RightCenter")
selectedGunAmmo.element_params = {"ammoCount", "selectedPylon"}
selectedGunAmmo.controllers    = {{"text_using_parameter", 0}, {"parameter_in_range", 1, (11 - 1) + 0.9, 11 + 0.1}}








-- ==================================================================================================
--FUEL
fuelDialInternal = MakeDial(.72, -.99, .2, .08625, 0, 150, .008, true, 15, "FUEL_IND_TOGGLE_M", "dialInternalFuel", 101, materials["BBLACK"], TAN_LD_MASTER.name, MakeMaterial(nil, {5 * 9, 7 * 9, 11 * 9, 175}))
fuelDialXF = MakeDial(.72, -.99, .2, .08625, 360 - 150, 420, .008, true, 21, "FUEL_IND_TOGGLE_M", "dialXFuel", 140, materials["BBLACK"], TAN_LD_MASTER.name, MakeMaterial(nil, {5 * 6, 7 * 6, 11 * 6, 200}))

for i = 360 - 150 + 150, 360 - 150 + 330, 60 do
	local fuelDialLines          = CreateElement "ceSimpleLineObject"
	fuelDialLines.name           = create_guid_string()
	fuelDialLines.material       = materials["BBLACK"]
	fuelDialLines.vertices       = {{0, 0}, {0, -.03}}
	fuelDialLines.width          = .004
	fuelDialLines.init_pos       = {.2 * math.cos(math.rad(-i + 90)), .2 * math.sin(math.rad(-i + 90))}
	fuelDialLines.init_rot       = {-i}
	fuelDialLines.parent_element = fuelDialXF.name
	AddElement(fuelDialLines)
end



fuelPercent = add_text_param(-0.002, 0, "FUEL", "%0.0f", fuelDialInternal, mfd_strdefs_digit, "Gripen_Font_black")
fuelPercent.init_rot = {180}

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
AddElement2(HORIZON_LINE)

HORIZON_ALT_A			= create_mfd_tex(CENTER_DISPLAY_COLOR, 1512, 1887, 1571 , 1960, 1) 
HORIZON_ALT_A.name			= create_guid_string()
HORIZON_ALT_A.init_pos		= {0.35, 0.039}
HORIZON_ALT_A.parent_element	= HORIZON_LINE.name
AddElement3(HORIZON_ALT_A)

green_text_param_with_brightness(0.14, 0 , "RAW_RALT", "%0.0f", HORIZON_ALT_A, {0.007,0.007, 0, 0}, "Gripen_Font_HL_Green")


HORIZON_LINE_FPM			= create_mfd_tex(CENTER_DISPLAY_COLOR, 1504, 1717, 1709 , 1818, 2) 
HORIZON_LINE_FPM.name			= create_guid_string()
HORIZON_LINE_FPM.init_pos		= {0, 0.043}
HORIZON_LINE_FPM.parent_element	= HORIZON_LINE.name
HORIZON_LINE_FPM.element_params  = {"ADI_ROLL","VELVEC_HUD_Y","VELVEC_HUD_X","ADI_PITCH"}
HORIZON_LINE_FPM.controllers	 = {{"rotate_using_parameter" ,0, -1},{"move_up_down_using_parameter",1, 0.036}, {"move_left_right_using_parameter",2, 0.036},{"move_up_down_using_parameter",3, -0.036} }
AddElement3(HORIZON_LINE_FPM)

GROUNDCOLLISION			= create_mfd_tex(CENTER_DISPLAY_COLOR, 1380, 145, 1680 , 298, 1.5) 
GROUNDCOLLISION.name			= create_guid_string()
GROUNDCOLLISION.init_pos		= {0, 0.023}
GROUNDCOLLISION.parent_element	= HORIZON_LINE_FPM.name
GROUNDCOLLISION.element_params  = {"PULLUPQUE", "rollRad", "VELVEC_HUD_Y","CURRENT_PHASE_STATIONARY","CURRENT_PHASE_PARKED","CURRENT_PHASE_TAXI",
												"CURRENT_PHASE_TGR","CURRENT_PHASE_ROT","CURRENT_PHASE_TD","CURRENT_PHASE_LR","CURRENT_PHASE_PAL", "PULLMORE"}
GROUNDCOLLISION.controllers	 	= {{"parameter_in_range",0, -10000,0},{"rotate_using_parameter" ,1, 1.00},
								  {"move_up_down_using_parameter",2, 0.1} ,{"parameter_compare_with_number",3, 0},{"parameter_compare_with_number",4, 0},
								  {"parameter_compare_with_number",5, 0},{"parameter_compare_with_number",6, 0},{"parameter_compare_with_number",7, 0},
								  {"parameter_compare_with_number",8, 0},{"parameter_compare_with_number",9, 0},{"parameter_compare_with_number",10, 0}, {"parameter_in_range",12, -0.99,0.5} }	
AddElement3(GROUNDCOLLISION)