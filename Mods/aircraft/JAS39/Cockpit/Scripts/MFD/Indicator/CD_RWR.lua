dofile(LockOn_Options.script_path .. "MFD/Indicator/MFD_def.lua")
_ = gettext.translate


MaxThreats = 20

local OuterRWRRadius = .78
local RWRLineThickness = .0075

MFD_RWR                = CreateElement "ceSimple"
MFD_RWR.init_pos       = {0, -.15}
MFD_RWR.name           = create_guid_string()
MFD_RWR.element_params = {"mainpower", "RWRPower", "CD_EMGY_MODE", "CD_FIX_TOGGLE"}
MFD_RWR.controllers    = {{"parameter_compare_with_number", 0, 1}, {"parameter_compare_with_number", 1, 1}, {"parameter_compare_with_number", 2, 0}, {"parameter_compare_with_number", 3, 0}}
MFD_RWR.material       = MakeMaterial(nil, {0, 220, 0, 255})
MFD_RWR.isvisible      = true
AddRWRElement(MFD_RWR)
----------------------------------------------------------------------------

-----------------------------------------------------------
-- List contact possition
-----------------------------------------------------------
T_P1                = CreateElement "ceSimple"
T_P1.init_pos       = {.06, -.05}
T_P1.name           = create_guid_string()
T_P1.parent_element = MFD_RWR.name
T_P1.controllers    = {{"parameter_in_range", 0, 1.9, 2.1}}
AddRWRElement(T_P1)

T_P2                = CreateElement "ceSimple"
T_P2.init_pos       = {.06, -.05}
T_P2.name           = create_guid_string()
T_P2.parent_element = MFD_RWR.name
T_P2.controllers    = {{"parameter_in_range", 0, 1.9, 2.1}}
AddRWRElement(T_P2)
-----------------------------------------------------------
-- List contact possition
-----------------------------------------------------------
rwr_pos_cd = 1
for ia = 1, 5 do
	local i = ""

	if ia < 10 then
		i = "_0" .. ia .. "_"
	else
		i = "_" .. ia .. "_"
	end

	local RWR_threats      = CreateElement "ceStringPoly"
	RWR_threats.name       = create_guid_string()
	RWR_threats.material   = fonts["Gripen_Font_black"]
	RWR_threats.init_pos   = {-1.00, (-1.00 + .35) - (rwr_pos_cd * .075), 0}
	RWR_threats.stringdefs = mfd_strdefs_digit_XS
	RWR_threats.alignment  = "LeftTop"
	RWR_threats.formats    = {"%s"}
	if ia <= 5 then
		RWR_threats.parent_element = T_P1.name
	else
		RWR_threats.parent_element = T_P2.name
	end
	RWR_threats.element_params = {"RWR_CONTACT" .. i .. "UNIT_TYPE", "RWR_CONTACT" .. i .. "POWER"}
	RWR_threats.controllers    = {{"text_using_parameter", 0, 0}, {"parameter_in_range", 1, 0, 1.1}, {"opacity_using_parameter", 2}}
	AddRWRElement(RWR_threats)
	----------------------
	rwr_pos_cd = rwr_pos_cd + 1
	if rwr_pos_cd > 5 then
		rwr_pos_cd = 1
	end
end


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
	AddRWRElement2(rotBase)


	-- Air Contact
	local airPowerBase          = CreateElement "ceSimple"
	airPowerBase.name           = baseName .. "Air_Power_Base"
	airPowerBase.init_pos       = {0, OuterRWRRadius}
	airPowerBase.parent_element = rotBase.name
	airPowerBase.element_params = {param .. "medium", param .. "range"}
	airPowerBase.controllers    = {{"parameter_compare_with_number", 0, 2}, {"move_up_down_using_parameter", 1, 1}} -- -.04
	AddRWRElement2(airPowerBase)

	local airOval          = CreateElement "ceMeshPoly"
	airOval.name           = create_guid_string()
	airOval.material       = materials["RWRYELLOW"]
	airOval.parent_element = baseName .. "Air_Power_Base"
	airOval.element_params = {param .. "threat", param .. "launchBlink"}
	airOval.controllers    = {{"change_color_when_parameter_equal_to_number", 0, 1, 1, .011612, .008568}, {"opacity_using_parameter", 1}}
	set_oval(airOval, .030991, .030991 - .006198, 360, 12, 1.8)
	AddRWRElement2(airOval)

	local airlockOval          = Copy(airOval)
	airlockOval.element_params = {param .. "SIGNAL", param .. "threat", param .. "launchBlink"}
	airlockOval.controllers    = {{"parameter_compare_with_number", 0, 2}, {"change_color_when_parameter_equal_to_number", 1, 1, 1, .088655, .082282}, {"opacity_using_parameter", 2}}
	set_oval(airlockOval, .030991 - .006198, 0, 360, 12, 1.8)
	AddRWRElement2(airlockOval)

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
	AddRWRElement2(nameQ2)

	local nameQ34       = Copy(nameQ2)
	nameQ34.init_pos    = {0, .055}
	nameQ34.init_rot    = {180}
	nameQ34.controllers = {{"parameter_in_range", 0, math.rad(90), math.rad(270)}, {"text_using_parameter", 1}, {"change_color_when_parameter_equal_to_number", 2, 1, 1, .011612, .008568}}
	AddRWRElement2(nameQ34)

	local nameQ1       = Copy(nameQ2)
	nameQ1.controllers = {{"parameter_in_range", 0, math.rad(270), math.rad(361)}, {"text_using_parameter", 1}, {"change_color_when_parameter_equal_to_number", 2, 1, 1, .011612, .008568}}
	AddRWRElement2(nameQ1)


	-- Ground contact
	local groundPowerBase          = Copy(rotBase)
	groundPowerBase.name           = baseName .. "Ground_Power_Base"
	groundPowerBase.init_pos       = {0, OuterRWRRadius}
	groundPowerBase.parent_element = rotBase.name
	groundPowerBase.element_params = {param .. "range", param .. "medium"}
	groundPowerBase.controllers    = {{"move_up_down_using_parameter", 0, 1}, {"parameter_compare_with_number", 1, 1}}
	AddRWRElement2(groundPowerBase)

	local groundOval          = CreateElement "ceMeshPoly"
	groundOval.name           = create_guid_string()
	groundOval.material       = materials["RWRYELLOW"]
	groundOval.parent_element = baseName .. "Ground_Power_Base"
	groundOval.element_params = {param .. "threat", param .. "heading", param .. "launchBlink"}
	groundOval.controllers    = {{"change_color_when_parameter_equal_to_number", 0, 1, 1, .011612, .008568}, {"rotate_using_parameter", 1, 1}, {"opacity_using_parameter", 2}}
	set_oval(groundOval, .030991, .030991 - .006198, 360, 12, 1.8)
	AddRWRElement2(groundOval)

	local groundGlockOval          = Copy(groundOval)
	groundGlockOval.element_params = {param .. "SIGNAL", param .. "threat", param .. "heading", param .. "launchBlink"}
	groundGlockOval.controllers    = {{"parameter_compare_with_number", 0, 2}, {"change_color_when_parameter_equal_to_number", 1, 1, 1, .088655, .082282}, {"rotate_using_parameter", 2, 1}, {"opacity_using_parameter", 3}}
	set_oval(groundGlockOval, .030991 - .006198, 0, 360, 12, 1.8)
	AddRWRElement2(groundGlockOval)

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
	AddRWRElement2(groundText)


	-- Missile line
	local missileLine          = CreateElement "ceSimpleLineObject"
	missileLine.name           = create_guid_string()
	missileLine.material       = materials["RWRYELLOW"]
	missileLine.parent_element = baseName .. "Base"
	missileLine.width          = RWRLineThickness / 2
	missileLine.vertices       = {{0, 1}, {0, .072906 + RWRLineThickness}}
	missileLine.element_params = {param .. "launch", param .. "threat"}
	missileLine.controllers    = {{"parameter_compare_with_number", 0, 1}, {"change_color_when_parameter_equal_to_number", 1, 1, 1, .011612, .008568}}
	AddRWRElement2(missileLine)
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


local AirContactScale = 0.05 / 2
local CursorGain = 0.08292



local ContactBase           = CreateElement "ceMeshPoly"
ContactBase.name            = create_guid_string()
ContactBase.primitivetype   = "triangles"
ContactBase.indices         = {0, 1, 2, 0, 2, 3}
ContactBase.material        = MakeMaterial(nil, {100, 0, 0, 100}) -- RGBA
ContactBase.parent_element  = MFD_RWR.name
ContactBase.h_clip_relation = h_clip_relations.DECREASE_IF_LEVEL
ContactBase.level           = MFD_DEFAULT_LEVEL + 1
ContactBase.change_opacity  = false
ContactBase.collimated      = false
ContactBase.isvisible       = false
Add(ContactBase)

function Waypoints(i)
	local WP          = CreateElement "ceMeshPoly"
	WP.primitivetype  = "triangles"
	WP.name           = "Waypoint" .. i
	WP.material       = MakeMaterial(nil, {0, 0, 255, 255})
	WP.parent_element = ContactBase.name
	set_circle(WP, AirContactScale, AirContactScale - 0.007, 360, 8)
	WP.init_pos        = {0, 0}
	WP.element_params  = {"WP_" .. i .. "_CDX", "WP_" .. i .. "_CDY", "WP_" .. i .. "_distance", "HEADING"}
	WP.controllers     = {{"move_left_right_using_parameter", 0, CursorGain}, {"move_up_down_using_parameter", 1, CursorGain}, {"parameter_in_range", 2, 1, 9999999999}, {"rotate_using_parameter", 3, math.rad(1)}}
	WP.h_clip_relation = h_clip_relations.DECREASE_IF_LEVEL
	WP.level           = MFD_DEFAULT_LEVEL + 1
	Add(WP)

	for j = 0, 3 do
		local WPPOI           = CreateElement "ceSimpleLineObject"
		WPPOI.name            = create_guid_string()
		WPPOI.material        = MakeMaterial(nil, {0, 0, 255, 255})
		WPPOI.parent_element  = "Waypoint" .. i
		WPPOI.init_rot        = {90 * j + 45}
		WPPOI.vertices        = {{AirContactScale - 0.005}, {AirContactScale + .03}}
		WPPOI.width           = .0035
		WPPOI.element_params  = {"nextWPName", "WP_" .. i .. "_name"}
		WPPOI.controllers     = {{"compare_parameters", 0, 1}} -- First time using this controller lol, maybe it isn't useless.
		WPPOI.h_clip_relation = h_clip_relations.DECREASE_IF_LEVEL
		WPPOI.level           = MFD_DEFAULT_LEVEL + 1
		Add(WPPOI)
	end


	local WPnum_readout           = blue_text_param_with_cd_brightness(-.025, 0, "WP_" .. i .. "_name", "%.3s", WP, {0.005, 0.005, 0, 0}, "Gripen_Font_HL_Blue", "RightCenter")
	WPnum_readout.h_clip_relation = h_clip_relations.DECREASE_IF_LEVEL
	WPnum_readout.level           = MFD_DEFAULT_LEVEL + 1

	local wpLine           = CreateElement "ceSimpleLineObject"
	wpLine.name            = create_guid_string()
	wpLine.material        = MakeMaterial(nil, {0, 0, 255, 255})
	wpLine.parent_element  = ContactBase.name
	wpLine.vertices        = {{0}, {0}}
	wpLine.width           = .0035
	wpLine.element_params  = {"WP_" .. i .. "_CDX", "WP_" .. i .. "_CDY", "WP_" .. i + 1 .. "_CDX", "WP_" .. i + 1 .. "_CDY", "WP_" .. i + 1 .. "_distance"}
	wpLine.controllers     = {{"line_object_set_point_using_parameters", 0, 0, 1, CursorGain, CursorGain}, {"line_object_set_point_using_parameters", 1, 2, 3, CursorGain, CursorGain}, {"parameter_in_range", 4, 1, 9999999999}}
	wpLine.h_clip_relation = h_clip_relations.DECREASE_IF_LEVEL
	wpLine.level           = MFD_DEFAULT_LEVEL + 1
	Add(wpLine)
end

for i = 1, 39 do
	Waypoints(i)
end



local ownShip          = CreateElement "ceSimpleLineObject"
ownShip.name           = create_guid_string()
ownShip.material       = MakeMaterial(nil, {25, 100, 25, 255})
ownShip.parent_element = MFD_RWR.name
ownShip.width          = RWRLineThickness / 2
ownShip.vertices       = {{0}, {-.019411 * 1.25, -.055 * 1.25}, {.019411 * 1.25, -.055 * 1.25}, {0}}
ownShip.element_params = {"CD_FIX_TOGGLE"}
ownShip.controllers    = {{"parameter_compare_with_number", 0, 0}}
AddElement(ownShip)

local ownShipRadius          = CreateElement "ceMeshPoly"
ownShipRadius.name           = create_guid_string()
ownShipRadius.material       = MakeMaterial(nil, {0, 0, 0, 255})
ownShipRadius.parent_element = MFD_RWR.name
ownShipRadius.isvisible      = false
set_circle(ownShipRadius, .072906 + RWRLineThickness / 2, .072906 + RWRLineThickness, 360, 36)
AddElement(ownShipRadius)

local ownShipVelvec          = CreateElement "ceSimpleLineObject"
ownShipVelvec.name           = create_guid_string()
ownShipVelvec.material       = MakeMaterial(nil, {25, 100, 25, 255})
ownShipVelvec.parent_element = ownShip.name
ownShipVelvec.width          = RWRLineThickness / 2
ownShipVelvec.vertices       = {{0}, {0}}
ownShipVelvec.element_params = {"CDVelvec", "ONE"}
ownShipVelvec.controllers    = {{"line_object_set_point_using_parameters", 1, 1, 0, 0, CursorGain}}
AddElement(ownShipVelvec)



-- Distance scale
local scaleLine           = CreateElement "ceSimpleLineObject"
scaleLine.name            = create_guid_string()
scaleLine.material        = MakeMaterial(nil, {0, 0, 0, 255})
scaleLine.width           = RWRLineThickness / 2
scaleLine.init_pos        = {.83, .15}
scaleLine.parent_element  = MFD_RWR.name
scaleLine.vertices        = {{0, -1.5}, {0, 1.5}}
scaleLine.h_clip_relation = h_clip_relations.DECREASE_IF_LEVEL
scaleLine.level           = MFD_DEFAULT_LEVEL + 1
AddRWRElement(scaleLine)


for i = -60, 115, 5 do
	local distanceMarker           = CreateElement "ceSimpleLineObject"
	distanceMarker.name            = create_guid_string()
	distanceMarker.material        = MakeMaterial(nil, {0, 0, 0, 255})
	distanceMarker.width           = RWRLineThickness / 2
	distanceMarker.init_pos        = {0, -.15} -- Nice coincidence, isn't perfect but works for now.
	distanceMarker.parent_element  = scaleLine.name
	distanceMarker.vertices        = {{0}, {-.025}}
	distanceMarker.h_clip_relation = h_clip_relations.DECREASE_IF_LEVEL
	distanceMarker.level           = MFD_DEFAULT_LEVEL + 1
	distanceMarker.element_params  = {"distScale_" .. i}
	distanceMarker.controllers     = {{"move_up_down_using_parameter", 0, CursorGain}}
	AddRWRElement(distanceMarker)

	local j = math.abs(i)

	if not (j == 15 or j == 30 or j == 35 or j == 45 or j == 55) then
		local controllerRange = {}

		if j == 0 then
			controllerRange = {0, 80.1}
		elseif j == 5 then
			controllerRange = {0, 10.1}
		elseif j == 10 then
			controllerRange = {0, 20.1}
		elseif j == 25 or j == 50 or j == 75 or j == 100 then
			controllerRange = {40.1, 80.1}
		else
			controllerRange = {0, 40.1}
		end

		local distanceMarkerNum          = CreateElement "ceStringPoly"
		distanceMarkerNum.name           = create_guid_string()
		distanceMarkerNum.material       = fonts["Gripen_Font_black"]
		distanceMarkerNum.init_pos       = {-.05}
		distanceMarkerNum.stringdefs     = mfd_strdefs_digit_S
		distanceMarkerNum.alignment      = "RightCenter"
		distanceMarkerNum.parent_element = distanceMarker.name
		distanceMarkerNum.value          = tostring(j)
		distanceMarkerNum.formats        = {"%s"}
		distanceMarkerNum.element_params = {"CD_SCALE_SYM"}
		distanceMarkerNum.controllers    = {{"parameter_in_range", 0, controllerRange[1], controllerRange[2]}}
		AddRWRElement2(distanceMarkerNum)
	end
end