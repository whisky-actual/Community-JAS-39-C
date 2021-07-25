
scale = 2
aspect = 0.9

mfd_PAGE1 			= CreateElement "ceSimple"
mfd_PAGE1.init_pos	= {0,0}
mfd_PAGE1.name		= create_guid_string()
AddElement(mfd_PAGE1)	

local mach_indicator		= create_mfd_tex(MFD_ELEMENTS_D, 3, 460, 460, 916)
mach_indicator.name			= create_guid_string()
mach_indicator.init_pos		= {-0.61, -0.5}
mach_indicator.parent_element	= mfd_PAGE1.name	
AddElement(mach_indicator)		

local mach_needle = create_mfd_tex(MFD_ELEMENTS_D, 464, 779, 596, 793,nil , 380 , 779 + ((793-779)/2)  )
mach_needle.name			= create_guid_string()
mach_needle.init_pos		= {0, 0}
mach_needle.init_rot		= {90, 0}
mach_needle.parent_element	= mach_indicator.name	
mach_needle.element_params  = { "CUR_IAS"}
mach_needle.controllers	 	= {{"rotate_using_parameter" ,0, -math.rad(360)/1000},}
AddElement(mach_needle)

add_text("M", 0, 0.05, mach_indicator, "FONT_WHITE" )
add_text_param(0, -0.04, "CUR_MACH", "%0.2f", mach_indicator, mfd_strdefs_digit, "FONT_WHITE")

local alti_indicator		= create_mfd_tex(MFD_ELEMENTS_D,3, 0, 460, 456)
alti_indicator.name			= create_guid_string()
alti_indicator.init_pos		= {0.6, -0.5}
alti_indicator.parent_element	= mfd_PAGE1.name	
AddElement(alti_indicator)	

local alti_needle = create_mfd_tex(MFD_ELEMENTS_D, 464, 796, 600, 822, nil , 378 , 794 + ((822-796)/2)  )
alti_needle.name			= create_guid_string()
alti_needle.init_pos		= {0, 0}
alti_needle.init_rot		= {90, 0}
alti_needle.parent_element	= alti_indicator.name	
alti_needle.element_params  = { "ALT_BARO_H"}
alti_needle.controllers	 	= {{"rotate_using_parameter" ,0, -math.rad(360)/1000},}
AddElement(alti_needle)

add_text_param(-0.048, 0     , "ALT_BARO_T", "%02.0f", alti_indicator, mfd_strdefs_digit_b, "FONT_WHITE")
add_text_param( 0.065, -0.006, "ALT_BARO_H", "%03.0f", alti_indicator, mfd_strdefs_digit, "FONT_WHITE")

local fuel_indicator		= create_mfd_tex(MFD_ELEMENTS_D,461, 2, 918, 458, 0.9)
fuel_indicator.name			= create_guid_string()
fuel_indicator.init_pos		= {0.7, -1.04}
fuel_indicator.parent_element	= mfd_PAGE1.name	
AddElement(fuel_indicator)	

add_text_param(0, 0, "FUEL", "%0.0f", fuel_indicator, mfd_strdefs_digit, "FONT_WHITE")

--****************** ADI

adi_HOR_mask = AddCircle(0, -0.82, 0.34, 9, true)
adi_HOR_mask.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL  
adi_HOR_mask.level			 = MFD_DEFAULT_LEVEL  
adi_HOR_mask.isvisible		 = false
adi_HOR_mask.parent_element	= mfd_PAGE1.name
AddElement2(adi_HOR_mask)	

adi_hor_base 				= CreateElement "ceSimple"
adi_hor_base.init_pos		= {0, -0.82}
adi_hor_base.name			= create_guid_string()
adi_hor_base.h_clip_relation = h_clip_relations.DECREASE_IF_LEVEL  
adi_hor_base.level           = MFD_DEFAULT_LEVEL + 1
adi_hor_base.parent_element	= mfd_PAGE1.name
adi_hor_base.element_params  = {"ADI_PITCH"}
adi_hor_base.controllers	 = {{"move_up_down_using_parameter",0, 0.06}}
AddElement2(adi_hor_base)	

local adi_HOR			= create_mfd_tex(MFD_ELEMENTS_D, 1509, 0, 2048, 1913,1.6)
adi_HOR.name			= create_guid_string()
adi_HOR.init_pos		= {0, 0}
adi_HOR.parent_element	= adi_hor_base.name
adi_HOR.h_clip_relation = h_clip_relations.DECREASE_IF_LEVEL  
adi_HOR.level           = MFD_DEFAULT_LEVEL + 1
adi_HOR.element_params 	= {"ADI_ROLL",}
adi_HOR.controllers		= {{"rotate_using_parameter" ,0, 1},}
AddElement2(adi_HOR)

local adi_indicator			= create_mfd_tex_sq(MFD_ELEMENTS_D, 465, 460, 924, 692,1.6)
adi_indicator.name			= create_guid_string()
adi_indicator.init_pos		= {0, -0.65}
adi_indicator.parent_element	= mfd_PAGE1.name
AddElement(adi_indicator)	

local adi_pht			= create_mfd_tex(MFD_ELEMENTS_D, 463, 698, 605, 774,1.6)
adi_pht.name			= create_guid_string()
adi_pht.init_pos		= {0, -0.8}
adi_pht.parent_element	= mfd_PAGE1.name
AddElement(adi_pht)	

--******************

hsi_mask = AddCircle(0, 0.55, 0.58, 9, true)
hsi_mask.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL  
hsi_mask.level			 = MFD_DEFAULT_LEVEL  
hsi_mask.isvisible		 = false
hsi_mask.parent_element	= mfd_PAGE1.name
AddElement2(hsi_mask)

hsi_base 				= CreateElement "ceSimple"
hsi_base.init_pos		= {0, 0.55}
hsi_base.name			= create_guid_string()
hsi_base.h_clip_relation = h_clip_relations.DECREASE_IF_LEVEL  
hsi_base.level           = MFD_DEFAULT_LEVEL + 1
-- AddElement2(hsi_base)	

local hsi_base_HOR			= create_mfd_tex(MFD_ELEMENTS_D, 1509, 0, 2048, 1913,1.6)
hsi_base_HOR.name			= create_guid_string()
hsi_base_HOR.init_pos		= {0, 0}
hsi_base_HOR.parent_element	= hsi_base.name
hsi_base_HOR.h_clip_relation = h_clip_relations.DECREASE_IF_LEVEL  
hsi_base_HOR.level           = MFD_DEFAULT_LEVEL + 1
-- AddElement2(hsi_base_HOR)

local hsi_indicator			= create_mfd_tex(MFD_ELEMENTS_D, 3, 916, 668, 1584,1.65)
hsi_indicator.name			= create_guid_string()
hsi_indicator.init_pos		= {0, 0.55}
hsi_indicator.parent_element	= mfd_PAGE1.name
AddElement(hsi_indicator)	

local compass_indicator			 = create_mfd_tex(MFD_ELEMENTS_D, 675, 916, 1505, 1746,1.88)		--675, 916, 1495, 1746,1.88)
compass_indicator.name			 = create_guid_string()
compass_indicator.parent_element = mfd_PAGE1.name
compass_indicator.init_pos		 = {-0.02, 0.55}
compass_indicator.element_params = {"MAGNATICHEADINGCOMPASS",}
compass_indicator.controllers	 = {{"rotate_using_parameter" ,0, math.rad(360)/360},}
AddElement(compass_indicator)