local gettext = require("i_18n")
_ = gettext.translate



TYPEPlane = 1
TYPESearchRadar = 2
TYPEEWR = 3
TYPESEA = 4
TYPEMissile = 5

MaxThreats = 20

 
MFD_RWR 			= CreateElement "ceSimple"
MFD_RWR.init_pos	= {0.075, 0.575}
MFD_RWR.name		= create_guid_string()
MFD_RWR.element_params = {"LD_UPPER", "RWRPOWER_STATE", "mainpower", "LD_EMGY_MODE"}
MFD_RWR.controllers    = {{"parameter_compare_with_number",0, 2}, {"parameter_compare_with_number",1, 1}, {"parameter_compare_with_number",2, 1} , {"parameter_compare_with_number",3, 0}}
MFD_RWR.material			= MakeMaterial(nil,{0, 220, 0, 255})
MFD_RWR.isvisible		 = true
AddRWRElement(MFD_RWR)

local OuterRWRRadius = 0.6
local InnerRWRRadius = 0.3
local RWRLineThickness = 0.0075


RWR_mask					= CreateElement "ceMeshPoly"
RWR_mask.name 				= create_guid_string()
RWR_mask.primitivetype		= "triangles"
RWR_mask.init_pos			= {0, 0}
RWR_mask.init_rot			= {0, 0}
RWR_mask.material 			= MakeMaterial(nil,{0, 0, 0,255})
RWR_mask.parent_element		= MFD_RWR.name
	set_circle(RWR_mask, OuterRWRRadius, 0, 360 , 36)
RWR_mask.additive_alpha	= false
RWR_mask.isvisible	= false
AddElement(RWR_mask)

RWR_Outer					= CreateElement "ceMeshPoly"
RWR_Outer.name 				= create_guid_string()
RWR_Outer.primitivetype		= "triangles"
RWR_Outer.init_pos			= {0, 0}
RWR_Outer.init_rot			= {0, 0}
RWR_Outer.material 			= MakeMaterial(nil,{0, 0, 0,255})
RWR_Outer.parent_element		= MFD_RWR.name
	set_circle(RWR_Outer, OuterRWRRadius, OuterRWRRadius - RWRLineThickness, 360 , 36)
RWR_Outer.additive_alpha	= false
AddElement(RWR_Outer)


RWR_Inner					= CreateElement "ceMeshPoly"
RWR_Inner.name 				= create_guid_string()
RWR_Inner.primitivetype		= "triangles"
RWR_Inner.init_pos			= {0, 0}
RWR_Inner.init_rot			= {0, 0}
RWR_Inner.material 			= MakeMaterial(nil,{0, 0, 0,255})
RWR_Inner.parent_element	= MFD_RWR.name
	set_circle(RWR_Inner, InnerRWRRadius, InnerRWRRadius - RWRLineThickness, 360 , 36)
RWR_Inner.additive_alpha	= false
AddElement(RWR_Inner)

local RWR_Cross 			= CreateElement "ceMeshPoly"
RWR_Cross.name 				= create_guid_string()
RWR_Cross.primitivetype 	= "triangles"
RWR_Cross.vertices	   		= {{-RWRLineThickness / 2, OuterRWRRadius}, {RWRLineThickness / 2, InnerRWRRadius}, { -RWRLineThickness / 2, InnerRWRRadius}, { RWRLineThickness / 2, OuterRWRRadius},
							   {-RWRLineThickness / 2, -OuterRWRRadius}, {RWRLineThickness / 2, -InnerRWRRadius}, { -RWRLineThickness / 2, -InnerRWRRadius}, { RWRLineThickness / 2, -OuterRWRRadius},
							   {OuterRWRRadius, -RWRLineThickness / 2}, {InnerRWRRadius, RWRLineThickness / 2}, { InnerRWRRadius, -RWRLineThickness / 2 }, {OuterRWRRadius, RWRLineThickness / 2 },
							   {-OuterRWRRadius, -RWRLineThickness / 2}, {-InnerRWRRadius, RWRLineThickness / 2}, { -InnerRWRRadius, -RWRLineThickness / 2 }, {-OuterRWRRadius, RWRLineThickness / 2 }}
RWR_Cross.indices			= {0, 1, 2,	    0, 1, 3,
							   8, 9, 10,    8, 9, 11,
							   4, 5, 6,     4, 5, 7,
							   12, 13, 14,  12, 13, 15}
RWR_Cross.init_pos			= {0, 0, 0}
RWR_Cross.material			= MakeMaterial(nil,{0, 0, 0,255})	--RGBA 222, 203, 110, 255
RWR_Cross.parent_element	= MFD_RWR.name
RWR_Cross.h_clip_relation	= h_clip_relations.REWRITE_LEVEL
RWR_Cross.level				= MFD_DEFAULT_LEVEL
RWR_Cross.isvisible			= true
AddElement2(RWR_Cross)


local CompassRadius = 0.69
local CompassNumberRadius = 0.69 + 0.03
local RWRLineLength = 0.05


RWRCompassBase 			= CreateElement "ceSimple"
RWRCompassBase.init_pos	= {0, 0}
RWRCompassBase.init_rot	= {90, 0}
RWRCompassBase.name		= create_guid_string()
RWRCompassBase.parent_element	= MFD_RWR.name
RWRCompassBase.element_params = {"HEADING_HUD"}
RWRCompassBase.controllers    = {{"rotate_using_parameter", 0, math.rad(1)}}
RWRCompassBase.isvisible		 = false
AddRWRElement(RWRCompassBase)


for i = -360, 0, 5 do
	
	if i %10 == 0 then
		RWRLineLength = 0.04
	else
		RWRLineLength = 0.02
	end



	HeadingLine 					= CreateElement "ceMeshPoly"
	HeadingLine.name 				= create_guid_string()
	HeadingLine.primitivetype 		= "triangles"
	HeadingLine.vertices			= {{(-RWRLineThickness * 0.5), RWRLineLength}, {(RWRLineThickness * 0.5) , RWRLineLength}, {(RWRLineThickness * 0.5), 0}, {(-RWRLineThickness * 0.5), 0}}
	HeadingLine.material			= MakeMaterial(nil,{0, 0, 0,255})
	HeadingLine.indices				= {0,1,2 , 0,2,3}
	HeadingLine.init_pos			= { CompassRadius * math.cos(math.rad(i)) , CompassRadius * math.sin(math.rad(i)), 0 }	-- placing segments as a function of iteration step
	HeadingLine.init_rot			= {i + 90, 0 , 0}	
	HeadingLine.h_clip_relation		= h_clip_relations.REWRITE_LEVEL  	--INCREASE_IF_LEVEL  
	HeadingLine.level  		 		= MFD_DEFAULT_LEVEL
	HeadingLine.use_mipfilter		= true
	HeadingLine.additive_alpha		= false
	HeadingLine.parent_element		= RWRCompassBase.name
	Add(HeadingLine)


	if i %30 == 0 and i > -360 then
		j = math.abs(i / 10)

		if j < 10 then
			j = "0"..j
		end

		CompassNumber          = add_text(j, CompassNumberRadius * math.cos(math.rad(i)) , CompassNumberRadius * math.sin(math.rad(i)), RWRCompassBase, "Gripen_Font_black", mfd_strdefs_digit_S)
		CompassNumber.init_rot = {270 + i, 0}
	end

end

local ownShip          = CreateElement "ceSimpleLineObject"
ownShip.name           = create_guid_string()
ownShip.material       = MakeMaterial(nil,{0, 0, 0,255})
ownShip.parent_element = MFD_RWR.name
ownShip.width          = RWRLineThickness/2
ownShip.vertices       = {{0, 0.0275}, {0}, {-0.019411, -0.055}, {0.019411, -0.055}, {0}} --Radius: 0.058325 (√(0.055^2 + ((0.051764 ÷ 2) × 0.75)^2)
AddElement(ownShip)

local ownShipRadius = CreateElement "ceMeshPoly"
ownShipRadius.name           = create_guid_string()
ownShipRadius.material       = MakeMaterial(nil,{0, 0, 0,255})
ownShipRadius.parent_element = MFD_RWR.name
ownShipRadius.isvisible	  = false
set_circle(ownShipRadius, 0.058325 + RWRLineThickness/2, 0.058325 + RWRLineThickness, 360 , 36)
AddElement(ownShipRadius)



----------------------------------------------------------------------------

function RWR_SYMBOL(i)
	local RWRConactRotBase          = CreateElement "ceSimple"
	RWRConactRotBase.name           = "RWR_Contact_" .. i .. "Base"
	RWRConactRotBase.parent_element = MFD_RWR.name
	RWRConactRotBase.element_params = {"RWR_CONTACT" .. i .. "AZIMUTH", "RWR_CONTACT" .. i .. "POWER"}
	RWRConactRotBase.controllers    = {{"rotate_using_parameter",0, 1}, {"parameter_in_range",1, 0, 1.1}}
	AddRWRElement(RWRConactRotBase)

	local airPowerBase           = Copy(RWRConactRotBase)
	airPowerBase.name           = "RWR_Contact_" .. i .. "Air_Power_Base"
	airPowerBase.init_pos       = {0, OuterRWRRadius + 0.115}
	airPowerBase.parent_element = RWRConactRotBase.name
	airPowerBase.element_params = {"RWR_CONTACT" .. i .. "POWER", "RWR_CONTACT" .. i .. "Medium"}
	airPowerBase.controllers    = {{"move_up_down_using_parameter",0, -0.0495}, {"parameter_compare_with_number",1, 1}}
	AddRWRElement(airPowerBase)

	local airOval          = CreateElement "ceMeshPoly"
	aoval.name           = create_guid_string()
	aoval.material       = materials["RWRYELLOW"]
	aoval.parent_element = "RWR_Contact_" .. i .. "Power_Base"
	aoval.element_params = {"RWR_CONTACT" .. i .. "CURPRIORITY", "RWR_CONTACT" .. i .. "Medium"}
	aoval.controllers    = {{"change_color_when_parameter_equal_to_number",0, 1, 0.98039, 0, 0.00784}, {"parameter_compare_with_number",1, 1}}
	set_oval(aoval, 0.030991, 0.030991 - 0.006198, 360, 12, 1.8)
	AddRWRElement(aoval)

	local goval          = CreateElement "ceMeshPoly"
	goval.name           = create_guid_string()
	goval.material       = materials["RWRYELLOW"]
	goval.parent_element = "RWR_Contact_" .. i .. "Power_Base"
	goval.element_params = {"RWR_CONTACT" .. i .. "CURPRIORITY", "RWR_CONTACT" .. i .. "GENERAL_TYPE", "RWR_CONTACT" .. i .. "AZIMUTH"}
	goval.controllers    = {{"change_color_when_parameter_equal_to_number",0, 1, 0.98039, 0, 0.00784}, {"parameter_compare_with_number",1, 2}, {"rotate_using_parameter",2, -1}}
	set_oval(goval, 0.030991, 0.030991 - 0.006198, 360, 12, 1.8)
	AddRWRElement(goval)

	local alockOval          = Copy(aoval)
	alockOval.element_params = {"RWR_CONTACT" .. i .. "LOCK", "RWR_CONTACT" .. i .. "CURPRIORITY", "RWR_CONTACT" .. i .. "GENERAL_TYPE"}
	alockOval.controllers    = {{"parameter_compare_with_number",0, 1}, {"change_color_when_parameter_equal_to_number",1, 1, 0.98039, 0, 0.00784}, {"parameter_compare_with_number",2, 1}}
	set_oval(alockOval, 0.030991, 0, 360, 12, 1.8)
	AddRWRElement(alockOval)

	local glockOval          = Copy(aoval)
	glockOval.element_params = {"RWR_CONTACT" .. i .. "LOCK", "RWR_CONTACT" .. i .. "CURPRIORITY", "RWR_CONTACT" .. i .. "GENERAL_TYPE", "RWR_CONTACT" .. i .. "AZIMUTH"}
	glockOval.controllers    = {{"parameter_compare_with_number",0, 1}, {"change_color_when_parameter_equal_to_number",1, 1, 0.98039, 0, 0.00784}, {"parameter_compare_with_number",2, 2}, {"rotate_using_parameter",3, -1}}
	set_oval(glockOval, 0.030991, 0, 360, 12, 1.8)
	AddRWRElement(glockOval)

	local nameQ2          = CreateElement "ceStringPoly"
	nameQ2.name           = create_guid_string()
	nameQ2.material       = fonts["Gripen_Font_Yellow"]
	nameQ2.init_pos       = {0, -0.055}
	nameQ2.stringdefs     = mfd_strdefs_digit_XXS
	nameQ2.alignment      = "CenterTop"
	nameQ2.parent_element = "RWR_Contact_" .. i .. "Power_Base"
	nameQ2.formats        = {"%s"}
	nameQ2.element_params = {"RWR_CONTACT" .. i .. "AZIMUTH", "RWR_CONTACT" .. i .. "UNIT_TYPE_SYM", "RWR_CONTACT" .. i .. "CURPRIORITY"}
	nameQ2.controllers    = {{"parameter_in_range",0, -1, math.rad(90)}, {"text_using_parameter",1}, {"change_color_when_parameter_equal_to_number",2, 1, 0.98039, 0, 0.00784}}
	AddRWRElement(nameQ2)

	local nameQ34       = Copy(nameQ2)
	nameQ34.init_pos    = {0, 0.055}
	nameQ34.init_rot    = {180}
	nameQ34.controllers = {{"parameter_in_range",0, math.rad(90), math.rad(270)}, {"text_using_parameter",1}, {"change_color_when_parameter_equal_to_number",2, 1, 0.98039, 0, 0.00784}}
	AddRWRElement(nameQ34)

	local nameQ1       = Copy(nameQ2)
	nameQ1.controllers = {{"parameter_in_range",0, math.rad(270), math.rad(361)}, {"text_using_parameter",1}, {"change_color_when_parameter_equal_to_number",2, 1, 0.98039, 0, 0.00784}}
	AddRWRElement(nameQ1)

	local missileLine          = Copy(ownShip)
	missileLine.init_pos	   = {0, -0.115}
	missileLine.material       = materials["RWRYELLOW"]
	missileLine.parent_element = "RWR_Contact_" .. i .. "Power_Base"
	missileLine.vertices       = {{-0.019411, 0.6475}, {0, 0.5925}, {0.019411, 0.6475}, {0, 0.5925}, {0, 0.058325 + RWRLineThickness}}
	missileLine.element_params = {"RWR_CONTACT" .. i .. "Signal", "RWR_CONTACT" .. i .. "CURPRIORITY"}
	missileLine.controllers    = {{"parameter_compare_with_number",0, 3}, {"change_color_when_parameter_equal_to_number",1, 1, 0.98039, 0, 0.00784}}
	AddRWRElement(missileLine)

	--[[RWR_CONTACTOval                = CreateElement "ceMeshPoly"
	RWR_CONTACTOval.name           = create_guid_string()
	RWR_CONTACTOval.material       = materials["RWRYELLOW"]
	RWR_CONTACTOval.parent_element = pparent.name
	RWR_CONTACTOval.element_params = {"TRWR_CONTACT" .. index .. "CURPRIORITY"}
	RWR_CONTACTOval.controllers    = {{"change_color_when_parameter_equal_to_number",0, 1, 0.98039, 0, 0.00784}}
	set_oval(RWR_CONTACTOval, 0.028, 0.0215, 360, 15, 1.9)
	AddRWRElement(RWR_CONTACTOval)

	RWRSTT                = CreateElement "ceMeshPoly"
	RWRSTT.name           = create_guid_string()
	RWRSTT.material       = materials["RWRYELLOW"]
	RWRSTT.parent_element = pparent.name
	RWRSTT.element_params = {"TRWR_CONTACT" .. index .. "LOCK", "TRWR_CONTACT" .. index .. "CURPRIORITY"}
	RWRSTT.controllers    = {{"parameter_compare_with_number",0, 1}, {"change_color_when_parameter_equal_to_number",1, 1, 0.98039, 0, 0.00784}}
	set_oval(RWRSTT, 0.028, 0, 360, 15, 1.9)
	AddRWRElement(RWRSTT)



	local RWR_CONTACTSTRQ2          = CreateElement "ceStringPoly"
	RWR_CONTACTSTRQ2.name           = create_guid_string()
	RWR_CONTACTSTRQ2.init_pos       = {0, -0.08}
	RWR_CONTACTSTRQ2.material       = fonts["Gripen_Font_Yellow"]
	RWR_CONTACTSTRQ2.parent_element = RWR_CONTACTOval.name
	RWR_CONTACTSTRQ2.stringdefs     = mfd_strdefs_digit_XXS
	RWR_CONTACTSTRQ2.alignment      = "CenterCenter"
	RWR_CONTACTSTRQ2.formats        = {"%s"}
	RWR_CONTACTSTRQ2.element_params = {"TRWR_CONTACT" .. index .. "AZ", "TRWR_CONTACT" .. index .. "UNIT_TYPE_SYM", "TRWR_CONTACT" .. index .. "CURPRIORITY"}
	RWR_CONTACTSTRQ2.controllers    = {{"parameter_in_range",0, math.rad(-999), math.rad(90)}, {"text_using_parameter",1}, {"change_color_when_parameter_equal_to_number",2, 1, 0.98039, 0, 0.00784}}
	AddRWRElement(RWR_CONTACTSTRQ2)

	local RWR_CONTACTSTRQ34       = Copy(RWR_CONTACTSTRQ2)
	RWR_CONTACTSTRQ34.init_pos    = {0, 0.08}
	RWR_CONTACTSTRQ34.init_rot    = {180}
	RWR_CONTACTSTRQ34.controllers = {{"parameter_in_range",0, math.rad(90), math.rad(270)}, {"text_using_parameter",1}, {"change_color_when_parameter_equal_to_number",2, 1, 0.98039, 0, 0.00784}}
	AddRWRElement(RWR_CONTACTSTRQ34)

	local RWR_CONTACTSTRQ1       = Copy(RWR_CONTACTSTRQ2)
	RWR_CONTACTSTRQ1.controllers = {{"parameter_in_range",0, math.rad(270), math.rad(999)}, {"text_using_parameter",1}, {"change_color_when_parameter_equal_to_number",2, 1, 0.98039, 0, 0.00784}}
	AddRWRElement(RWR_CONTACTSTRQ1)

	local missileLine          = Copy(ownShip)
	missileLine.material       = materials["RWRYELLOW"]
	missileLine.parent_element = pparent.parent_element
	missileLine.vertices       = {{-0.019411, 0.6475}, {0, 0.5925}, {0.019411, 0.6475}, {0, 0.5925}, {0, 0.058325 + RWRLineThickness}}
	missileLine.element_params = {"TRWR_CONTACT" .. index .. "SIGNAL", "TRWR_CONTACT" .. index .. "CURPRIORITY"}
	missileLine.controllers    = {{"parameter_compare_with_number",0, 3}, {"change_color_when_parameter_equal_to_number",1, 1, 0.98039, 0, 0.00784}}
	AddElement(missileLine)--]]
end

for ia = 1, MaxThreats do
	local i = ""
	if ia  < 10 then
		i = "_0".. ia .."_"
	else
		i = "_".. ia .."_"
	end


	--[[local RWR_CONTACTRotBase          = CreateElement "ceSimple"
	RWR_CONTACTRotBase.name           = "RWR_Contact_" .. i .. "Rot_Base"
	RWR_CONTACTRotBase.parent_element = MFD_RWR.name
	RWR_CONTACTRotBase.element_params = {"TRWR_CONTACT" .. i .. "AZ", "TRWR_CONTACT" .. i .. "POWER"}
	RWR_CONTACTRotBase.controllers    = {{"rotate_using_parameter",0, 1}, {"parameter_in_range",1, 0, 1.1}}
	AddRWRElement(RWR_CONTACTRotBase)

	local RWRCPowerB          = Copy(RWR_CONTACTRotBase)
	RWRCPowerB.name           = "RWR_Contact_" .. i .. "Power_Base"
	RWRCPowerB.init_pos       = {0, OuterRWRRadius + 0.058325}
	RWRCPowerB.parent_element = RWR_CONTACTRotBase.name
	RWRCPowerB.element_params = {"TRWR_CONTACT" .. i .. "POWER"}
	RWRCPowerB.controllers    = {{"move_up_down_using_parameter",0, -0.05}}
	AddRWRElement(RWRCPowerB)--]]

	RWR_SYMBOL(i)
	--RWR_SYMBOL(TYPESearchRadar, i)
	--RWR_SYMBOL(TYPEEWR, i)
	--RWR_SYMBOL(TYPESEA, i)
	--RWR_SYMBOL(TYPEMissile, i)
	--RWR_SYMBOL(RWR_Air_Contact_Base, TYPESearchRadar, "RWRSAM", i)
	--RWR_SYMBOL(RWR_Air_Contact_Base, TYPEEWR, "RWRSAM", i)
	--RWR_SYMBOL(RWR_Air_Contact_Base, TYPEEWR, "RWREWR", i)
	--RWR_SYMBOL(RWR_Air_Contact_Base, TYPESEA, "RWRSEA", i)
	--RWR_SYMBOL(RWR_Air_Contact_Base, TYPEMissile, nil, i)
end