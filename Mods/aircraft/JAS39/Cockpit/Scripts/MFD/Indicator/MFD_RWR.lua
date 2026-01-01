-- dofile(LockOn_Options.script_path .. "RWR/RWR_init.lua")

local gettext = require("i_18n")
_ = gettext.translate

TYPEPlane = 1
TYPESearchRadar = 2
TYPEEWR = 3
TYPESEA = 4
TYPEMissile = 5
MaxThreats = 20

MFD_RWR                = CreateElement "ceSimple"
MFD_RWR.init_pos       = {.075, .575}
MFD_RWR.name           = create_guid_string()
MFD_RWR.element_params = {"LD_UPPER", "RWRPower", "mainpower", "LD_EMGY_MODE"}
MFD_RWR.controllers    = {{"parameter_compare_with_number", 0, 2}, {"parameter_compare_with_number", 1, 1}, {"parameter_compare_with_number", 2, 1}, {"parameter_compare_with_number", 3, 0}}
MFD_RWR.material       = MakeMaterial(nil, {0, 220, 0, 255})
MFD_RWR.isvisible      = true
AddRWRElement(MFD_RWR)

local OuterRWRRadius = .6
local InnerRWRRadius = .3
local RWRLineThickness = .0075


RWR_mask                = CreateElement "ceMeshPoly"
RWR_mask.name           = create_guid_string()
RWR_mask.primitivetype  = "triangles"
RWR_mask.material       = MakeMaterial(nil, {0, 0, 0, 255})
RWR_mask.parent_element = MFD_RWR.name
set_circle(RWR_mask, OuterRWRRadius, 0, 360, 36)
RWR_mask.additive_alpha = false
RWR_mask.isvisible = false
AddElement(RWR_mask)

RWR_Outer                = CreateElement "ceMeshPoly"
RWR_Outer.name           = create_guid_string()
RWR_Outer.primitivetype  = "triangles"
RWR_Outer.material       = MakeMaterial(nil, {0, 0, 0, 255})
RWR_Outer.parent_element = MFD_RWR.name
set_circle(RWR_Outer, OuterRWRRadius, OuterRWRRadius - RWRLineThickness, 360, 36)
RWR_Outer.additive_alpha = false
AddElement(RWR_Outer)


RWR_Inner                = CreateElement "ceMeshPoly"
RWR_Inner.name           = create_guid_string()
RWR_Inner.primitivetype  = "triangles"
RWR_Inner.material       = MakeMaterial(nil, {0, 0, 0, 255})
RWR_Inner.parent_element = MFD_RWR.name
set_circle(RWR_Inner, InnerRWRRadius, InnerRWRRadius - RWRLineThickness, 360, 36)
RWR_Inner.additive_alpha = false
AddElement(RWR_Inner)

local RWR_Cross           = CreateElement "ceMeshPoly"
RWR_Cross.name            = create_guid_string()
RWR_Cross.primitivetype   = "triangles"
RWR_Cross.vertices        = {{-RWRLineThickness / 2, OuterRWRRadius}, {RWRLineThickness / 2, InnerRWRRadius}, {-RWRLineThickness / 2, InnerRWRRadius}, {RWRLineThickness / 2, OuterRWRRadius},
	{-RWRLineThickness / 2, -OuterRWRRadius}, {RWRLineThickness / 2, -InnerRWRRadius}, {-RWRLineThickness / 2, -InnerRWRRadius}, {RWRLineThickness / 2, -OuterRWRRadius},
	{OuterRWRRadius,  -RWRLineThickness / 2}, {InnerRWRRadius, RWRLineThickness / 2}, {InnerRWRRadius, -RWRLineThickness / 2}, {OuterRWRRadius, RWRLineThickness / 2},
	{-OuterRWRRadius, -RWRLineThickness / 2}, {-InnerRWRRadius, RWRLineThickness / 2}, {-InnerRWRRadius, -RWRLineThickness / 2}, {-OuterRWRRadius, RWRLineThickness / 2}}
RWR_Cross.indices         = {0, 1, 2, 0, 1, 3,
	8, 9, 10, 8, 9, 11,
	4, 5, 6, 4, 5, 7,
	12, 13, 14, 12, 13, 15}
RWR_Cross.material        = MakeMaterial(nil, {0, 0, 0, 255}) -- RGBA 222, 203, 110, 255
RWR_Cross.parent_element  = MFD_RWR.name
RWR_Cross.h_clip_relation = h_clip_relations.REWRITE_LEVEL
RWR_Cross.level           = MFD_DEFAULT_LEVEL
RWR_Cross.isvisible       = true
AddElement2(RWR_Cross)


local CompassRadius = .69
local CompassNumberRadius = .69 + .03
local RWRLineLength = .05


RWRCompassBase                = CreateElement "ceSimple"
RWRCompassBase.init_rot       = {90, 0}
RWRCompassBase.name           = create_guid_string()
RWRCompassBase.parent_element = MFD_RWR.name
RWRCompassBase.element_params = {"HEADING_HUD"}
RWRCompassBase.controllers    = {{"rotate_using_parameter", 0, math.rad(1)}}
RWRCompassBase.isvisible      = false
AddRWRElement(RWRCompassBase)


for i = -360, 0, 5 do
	if i % 10 == 0 then
		RWRLineLength = .04
	else
		RWRLineLength = .02
	end



	HeadingLine                 = CreateElement "ceMeshPoly"
	HeadingLine.name            = create_guid_string()
	HeadingLine.primitivetype   = "triangles"
	HeadingLine.vertices        = {{(-RWRLineThickness * .5), RWRLineLength}, {(RWRLineThickness * .5), RWRLineLength}, {(RWRLineThickness * .5), 0}, {(-RWRLineThickness * .5), 0}}
	HeadingLine.material        = MakeMaterial(nil, {0, 0, 0, 255})
	HeadingLine.indices         = {0, 1, 2, 0, 2, 3}
	HeadingLine.init_pos        = {CompassRadius * math.cos(math.rad(i)), CompassRadius * math.sin(math.rad(i)), 0} -- placing segments as a function of iteration step
	HeadingLine.init_rot        = {i + 90, 0, 0}
	HeadingLine.h_clip_relation = h_clip_relations.REWRITE_LEVEL -- INCREASE_IF_LEVEL
	HeadingLine.level           = MFD_DEFAULT_LEVEL
	HeadingLine.use_mipfilter   = true
	HeadingLine.additive_alpha  = false
	HeadingLine.parent_element  = RWRCompassBase.name
	Add(HeadingLine)


	if i % 30 == 0 and i > -360 then
		j = math.abs(i / 10)

		if j < 10 then
			j = "0" .. j
		end

		CompassNumber          = add_text(j, CompassNumberRadius * math.cos(math.rad(i)), CompassNumberRadius * math.sin(math.rad(i)), RWRCompassBase, "Gripen_Font_black", mfd_strdefs_digit_S)
		CompassNumber.init_rot = {270 + i, 0}
	end
end

local WPHeadingBase          = CreateElement "ceSimple"
WPHeadingBase.name           = create_guid_string()
WPHeadingBase.parent_element = MFD_RWR.name
WPHeadingBase.element_params = {"nextWPHeading"}
WPHeadingBase.controllers    = {{"rotate_using_parameter", 0, 1}}
WPHeadingBase.isvisible      = false
AddRWRElement(WPHeadingBase)
 
for i = -1, 1 do
	local firstVert = {0}
	if i == 0 then
		firstVert = {0, RWRLineLength}
	end

	local WPHeading          = CreateElement "ceSimpleLineObject"
	WPHeading.name           = create_guid_string()
	WPHeading.material       = MakeMaterial(nil, {0, 0, 255, 255})
	WPHeading.parent_element = WPHeadingBase.name
	WPHeading.width          = RWRLineThickness / 2
	WPHeading.vertices       = {firstVert, {0, -RWRLineLength}}
	WPHeading.init_pos       = {i * .02, CompassRadius}
	AddElement(WPHeading)
end



local ownShip          = CreateElement "ceSimpleLineObject"
ownShip.name           = create_guid_string()
ownShip.material       = MakeMaterial(nil, {0, 0, 0, 255})
ownShip.parent_element = MFD_RWR.name
ownShip.width          = RWRLineThickness / 2
ownShip.vertices       = {{0, .0275}, {0}, {-.019411, -.055}, {.019411, -.055}, {0}} -- Radius: .058325 (√(.055^2 + ((.051764 ÷ 2) × .75)^2)
AddElement(ownShip)

local ownShipRadius          = CreateElement "ceMeshPoly"
ownShipRadius.name           = create_guid_string()
ownShipRadius.material       = MakeMaterial(nil, {0, 0, 0, 255})
ownShipRadius.parent_element = MFD_RWR.name
ownShipRadius.isvisible      = false
set_circle(ownShipRadius, .058325 + RWRLineThickness / 2, .058325 + RWRLineThickness, 360, 36)
AddElement(ownShipRadius)


--- Draws a contact symbol on the RWR
--- @param index string The index of the contact, in the format "_01_", "_02_", ..., "_20_"
local function drawContact(index)
	local baseName = "RWR_Contact_" .. index
	local param = "RWR_CONTACT" .. index



	local rotBase          = CreateElement "ceSimple"
	rotBase.name           = baseName .. "Base"
	rotBase.parent_element = MFD_RWR.name
	rotBase.element_params = {param .. "heading", param .. "POWER"}
	rotBase.controllers    = {{"rotate_using_parameter", 0, -1}, {"parameter_in_range", 1, 0, 1.1}}
	AddRWRElement(rotBase)


	-- Air Contact
	local airPowerBase          = CreateElement "ceSimple"
	airPowerBase.name           = baseName .. "Air_Power_Base"
	airPowerBase.init_pos       = {0, OuterRWRRadius}
	airPowerBase.parent_element = rotBase.name
	airPowerBase.element_params = {param .. "medium", param .. "range"}
	airPowerBase.controllers    = {{"parameter_compare_with_number", 0, 2}, {"move_up_down_using_parameter", 1, 1}} -- -.04
	AddRWRElement(airPowerBase)

	local airOval          = CreateElement "ceMeshPoly"
	airOval.name           = create_guid_string()
	airOval.material       = materials["RWRYELLOW"]
	airOval.parent_element = baseName .. "Air_Power_Base"
	airOval.element_params = {param .. "threat", param .. "launchBlink"}
	airOval.controllers    = {{"change_color_when_parameter_equal_to_number", 0, 1, 1, .011612, .008568}, {"opacity_using_parameter", 1}}
	set_oval(airOval, .030991, .030991 - .006198, 360, 12, 1.8)
	AddRWRElement(airOval)

	local airlockOval          = Copy(airOval)
	airlockOval.element_params = {param .. "SIGNAL", param .. "threat", param .. "launchBlink"}
	airlockOval.controllers    = {{"parameter_compare_with_number", 0, 2}, {"change_color_when_parameter_equal_to_number", 1, 1, 1, .088655, .082282}, {"opacity_using_parameter", 2}}
	set_oval(airlockOval, .030991 - .006198, 0, 360, 12, 1.8)
	AddRWRElement(airlockOval)

	local nameQ2          = CreateElement "ceStringPoly"
	nameQ2.name           = create_guid_string()
	nameQ2.material       = fonts["Gripen_Font_Yellow"]
	nameQ2.init_pos       = {0, -.055}
	nameQ2.stringdefs     = mfd_strdefs_digit_XXS
	nameQ2.alignment      = "CenterTop"
	nameQ2.parent_element = baseName .. "Air_Power_Base"
	nameQ2.formats        = {"%s"}
	nameQ2.element_params = {param .. "heading", param .. "name", param .. "threat"}
	nameQ2.controllers    = {{"parameter_in_range", 0, -1, math.rad(90)}, {"text_using_parameter", 1}, {"change_color_when_parameter_equal_to_number", 2, 1, 1, .011612, .008568}}
	AddRWRElement(nameQ2)

	local nameQ34       = Copy(nameQ2)
	nameQ34.init_pos    = {0, .055}
	nameQ34.init_rot    = {180}
	nameQ34.controllers = {{"parameter_in_range", 0, math.rad(90), math.rad(270)}, {"text_using_parameter", 1}, {"change_color_when_parameter_equal_to_number", 2, 1, 1, .011612, .008568}}
	AddRWRElement(nameQ34)

	local nameQ1       = Copy(nameQ2)
	nameQ1.controllers = {{"parameter_in_range", 0, math.rad(270), math.rad(361)}, {"text_using_parameter", 1}, {"change_color_when_parameter_equal_to_number", 2, 1, 1, .011612, .008568}}
	AddRWRElement(nameQ1)


	-- Ground contact
	local groundPowerBase          = Copy(rotBase)
	groundPowerBase.name           = baseName .. "Ground_Power_Base"
	groundPowerBase.init_pos       = {0, OuterRWRRadius}
	groundPowerBase.parent_element = rotBase.name
	groundPowerBase.element_params = {param .. "range", param .. "medium"}
	groundPowerBase.controllers    = {{"move_up_down_using_parameter", 0, 1}, {"parameter_compare_with_number", 1, 1}}
	AddRWRElement(groundPowerBase)

	local groundOval          = CreateElement "ceMeshPoly"
	groundOval.name           = create_guid_string()
	groundOval.material       = materials["RWRYELLOW"]
	groundOval.parent_element = baseName .. "Ground_Power_Base"
	groundOval.element_params = {param .. "threat", param .. "heading", param .. "launchBlink"}
	groundOval.controllers    = {{"change_color_when_parameter_equal_to_number", 0, 1, 1, .011612, .008568}, {"rotate_using_parameter", 1, 1}, {"opacity_using_parameter", 2}}
	set_oval(groundOval, .030991, .030991 - .006198, 360, 12, 1.8)
	AddRWRElement(groundOval)

	local groundGlockOval          = Copy(groundOval)
	groundGlockOval.element_params = {param .. "SIGNAL", param .. "threat", param .. "heading", param .. "launchBlink"}
	groundGlockOval.controllers    = {{"parameter_compare_with_number", 0, 2}, {"change_color_when_parameter_equal_to_number", 1, 1, 1, .088655, .082282}, {"rotate_using_parameter", 2, 1}, {"opacity_using_parameter", 3}}
	set_oval(groundGlockOval, .030991 - .006198, 0, 360, 12, 1.8)
	AddRWRElement(groundGlockOval)

	local groundText          = CreateElement "ceStringPoly"
	groundText.name           = create_guid_string()
	groundText.material       = fonts["Gripen_Font_Yellow"]
	groundText.init_pos       = {0, -.055}
	groundText.stringdefs     = mfd_strdefs_digit_XXS
	groundText.alignment      = "CenterTop"
	groundText.parent_element = groundOval.name
	groundText.formats        = {"%s"}
	groundText.element_params = {param .. "name", param .. "threat"}
	groundText.controllers    = {{"text_using_parameter", 0, 0}, {"change_color_when_parameter_equal_to_number", 1, 1, 1, .011612, .008568}}
	AddRWRElement(groundText)


	-- Missile line
	local missileLine          = CreateElement "ceSimpleLineObject"
	missileLine.name           = create_guid_string()
	missileLine.material       = materials["RWRYELLOW"]
	missileLine.parent_element = baseName .. "Base"
	missileLine.width          = RWRLineThickness / 2
	missileLine.vertices       = {{-.019411, .6475}, {0, .5925}, {.019411, .6475}, {0, .5925}, {0, .058325 + RWRLineThickness}}
	missileLine.element_params = {param .. "launch", param .. "threat"}
	missileLine.controllers    = {{"parameter_compare_with_number", 0, 1}, {"change_color_when_parameter_equal_to_number", 1, 1, 1, .011612, .008568}}
	AddRWRElement(missileLine)
end

for i = 1, MaxThreats do
	local index = ""
	if i < 10 then
		index = "_0" .. i .. "_"
	else
		index = "_" .. i .. "_"
	end

	drawContact(index)
end

-- drawContact("_21_") -- Test contact