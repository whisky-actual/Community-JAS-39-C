local width = 2

dofile(LockOn_Options.script_path .. "Indicator/Materials.lua")
dofile(LockOn_Options.script_path .. "utils.lua")


TAN_RD_MASTER                = CreateElement "ceSimple"
TAN_RD_MASTER.init_pos       = {0, 0}
TAN_RD_MASTER.name           = create_guid_string()
TAN_RD_MASTER.element_params = {"pruttRD_EMGY_MODE", "mainpower"}
TAN_RD_MASTER.controllers    = {{"parameter_compare_with_number", 0, 0}, {"parameter_compare_with_number", 1, 1}}
AddElement(TAN_RD_MASTER)



GRAY_Background                 = CreateElement "ceMeshPoly"
GRAY_Background.name            = create_guid_string()
GRAY_Background.primitivetype   = "triangles"
GRAY_Background.vertices        = {{-1.0, 1.4}, {1.0, 1.4}, {1.0, -1.4}, {-1.0, -1.4}}
GRAY_Background.indices         = {0, 1, 2, 0, 2, 3}
GRAY_Background.init_pos        = {0, 0, 0}
GRAY_Background.material        = materials["MFDBGGray"]
GRAY_Background.parent_element  = TAN_RD_MASTER.name
GRAY_Background.h_clip_relation = h_clip_relations.REWRITE_LEVEL
GRAY_Background.level           = MFD_DEFAULT_LEVEL
GRAY_Background.change_opacity  = true
GRAY_Background.collimated      = false
GRAY_Background.isvisible       = true
-- GRAY_Background.element_params 	= {"RD_BRIGHTNESS"}
-- GRAY_Background.controllers    	= {{"opacity_using_parameter", 0}}
Add(GRAY_Background)

-- TAN_Background_Mask.element_params 		= {"mainpower"}
-- TAN_Background_Mask.controllers    		= {{"Electric_Main_bus_A_115200VAC",0, 1}}


TAN_Background_Mask                 = CreateElement "ceMeshPoly"
TAN_Background_Mask.name            = create_guid_string()
TAN_Background_Mask.primitivetype   = "triangles"
TAN_Background_Mask.vertices        = {{-0.925, 1.4}, {0.925, 1.4}, {0.925, -0.9}, {-0.925, -0.9}}
TAN_Background_Mask.indices         = {0, 1, 2, 0, 2, 3}
TAN_Background_Mask.init_pos        = {0, 0, 0}
TAN_Background_Mask.material        = MakeMaterial(nil, {222, 203, 110, 255}) -- RGBA
TAN_Background_Mask.parent_element  = TAN_RD_MASTER.name
TAN_Background_Mask.level           = MFD_DEFAULT_LEVEL
TAN_Background_Mask.isvisible       = false
TAN_Background_Mask.use_mipfilter   = true
TAN_Background_Mask.additive_alpha  = false
TAN_Background_Mask.change_opacity  = false
TAN_Background_Mask.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
TAN_Background_Mask.level           = MFD_DEFAULT_LEVEL + 1
Add(TAN_Background_Mask)


local xcor = 0.022

Clockparent                 = CreateElement "ceMeshPoly"
Clockparent.name            = create_guid_string()
Clockparent.primitivetype   = "triangles"
Clockparent.vertices        = {{0.5, 1.4}, {1.0, 1.4}, {1.0, 1.3}, {0.5, 1.3}}
Clockparent.indices         = {0, 1, 2, 0, 2, 3}
Clockparent.init_pos        = {0, 0, 0}
Clockparent.material        = MakeMaterial(nil, {0, 0, 100, 100}) -- RGBA
Clockparent.parent_element  = TAN_RD_MASTER.name
Clockparent.h_clip_relation = h_clip_relations.REWRITE_LEVEL
Clockparent.level           = MFD_DEFAULT_LEVEL
Clockparent.change_opacity  = false
Clockparent.collimated      = false
Clockparent.isvisible       = false
-- Clockparent.element_params 	= {"LD_UPPER"}
-- Clockparent.controllers    	= {{"parameter_in_range", 0, 0, 4}}
Add(Clockparent)


local RD_CURSOR           = CreateElement "ceMeshPoly"
RD_CURSOR.name            = "RD_CURSOR"
RD_CURSOR.primitivetype   = "triangles"
RD_CURSOR.material        = MakeMaterial(nil, {0, 0, 0, 255})
RD_CURSOR.init_pos        = {-2, 0}
RD_CURSOR.vertices        = {{-0.004, -0.07}, {0.004, -0.07}, {-0.004, -0.02}, {0.004, -0.02}, {-0.004, 0.02}, {0.004, 0.02}, {-0.004, 0.07}, {0.004, 0.07}, {-0.004, -0.004}, {0.004, -0.004}, {-0.004, 0.004}, {0.004, 0.004}, {-0.074, -0.004}, {-0.018, -0.004}, {-0.074, 0.004}, {-0.018, 0.004}, {0.074, 0.004}, {0.018, 0.004}, {0.074, -0.004}, {0.018, -0.004}}
RD_CURSOR.indices         = {0, 1, 2, 3, 2, 1, 4, 5, 6, 7, 6, 5, 8, 9, 10, 11, 10, 9, 12, 13, 14, 15, 14, 13, 16, 17, 18, 19, 18, 17}
RD_CURSOR.h_clip_relation = h_clip_relations.REWRITE_LEVEL
RD_CURSOR.parent_element  = TAN_RD_MASTER.name
RD_CURSOR.level           = MFD_DEFAULT_LEVEL
RD_CURSOR.element_params  = {"Cursor_Y", "Cursor_X"}
RD_CURSOR.controllers     = {{"move_up_down_using_parameter", 0, CursorGain}, {"move_left_right_using_parameter", 1, CursorGain}, {"parameter_in_range", 1, 1, 3.01}}
Add(RD_CURSOR)


add_text_param(0.87, 1.34, "SECONDSTIME", "%02.0f", Clockparent, mfd_strdefs_digit_XS, "Gripen_Font_black")
add_text(",", 0.834, 1.3475, Clockparent, "Gripen_Font_black")
add_text_param(0.78, 1.34, "MINUTESTIME", "%02.0f", Clockparent, mfd_strdefs_digit_XS, "Gripen_Font_black")
add_text(",", 0.745, 1.3475, Clockparent, "Gripen_Font_black")
add_text_param(0.695, 1.34, "HOURTIME", "%02.0f", Clockparent, mfd_strdefs_digit_XS, "Gripen_Font_black")


local EMGY = add_text([[E
M
G
Y]], -0.967 + 0.022, 1.125, TAN_RD_MASTER, "Gripen_Font_black", mfd_strdefs_digit_S)

local MENU = add_text([[M
E
N
U]], -0.97 + 0.022, -0.565, TAN_RD_MASTER, "Gripen_Font_black", mfd_strdefs_digit_S)

local MENU_BOX       = make_softkey_box(3.05, -0.92 + 0.022, -0.535, 0, TAN_RD_MASTER, "RDPage")
MENU_BOX.controllers = {{parameter_in_range, 0, 0.9, 4.1}}
AddElement(MENU_BOX)

local CURS = add_text([[C
U
R
S]], -0.97 + xcor, -0.302, TAN_LD_MASTER, "Gripen_Font_black", mfd_strdefs_digit_S)


local RDSubPage = add_text([[A/A
A/S
RCE
]], -0.97 + 0.07, 0.56, GEN_PAGE, "Gripen_Font_black", mfd_strdefs_digit_S)

local AA_BOX       = make_softkey_box(2, -0.97 + 0.07, 0.65, 90, TAN_RD_MASTER, "masterMode")
AA_BOX.controllers = {{"parameter_compare_with_number", 0, 0}}
AddElement(AA_BOX)

local AS_BOX       = make_softkey_box(2, -0.97 + 0.07, 0.59, 90, TAN_RD_MASTER, "masterMode")
AS_BOX.controllers = {{"parameter_compare_with_number", 0, 1}}
AddElement(AS_BOX)

local RCE_BOX       = make_softkey_box(2, -0.97 + 0.07, 0.53, 90, TAN_RD_MASTER, "masterMode")
RCE_BOX.controllers = {{"parameter_compare_with_number", 0, 2}}
AddElement(RCE_BOX)


-- ================================= R D R ===========================================================================================
local RDRPage          = CreateElement "ceSimple"
RDRPage.name           = create_guid_string()
RDRPage.parent_element = TAN_RD_MASTER.name
RDRPage.element_params = {"RDPage"}
RDRPage.controllers    = {{"parameter_compare_with_number", 0, 1}}
AddElement(RDRPage)

local RDRWidth = 1.73455 / 2
local lineThickness = 0.006
-- local lineThickness = .0075 -- Same as RWR

-- Width: 437px = 2
-- 36px x offset
local altScpH = .512584 / 2
local altScpW = 1.707094 / 2
local altScpY = .787185 + altScpH
local altScpX = .0320366 / 2

local altScpBgH = altScpH + lineThickness
local altScpBgW = altScpW + lineThickness
local altScpBgTopW = 1.76201 / 2
local altScpSideLinesW = .01373

local altScpFullRangeDist = 1.5881
local altScpFullRangeX = -altScpBgW + altScpFullRangeDist
local altScpHalfRangeX = -altScpBgW + .791762


local RDRAltScpBg          = CreateElement "ceMeshPoly"
RDRAltScpBg.name           = create_guid_string()
RDRAltScpBg.primitivetype  = "triangles"
RDRAltScpBg.vertices       = {{-altScpBgW, -altScpBgH}, {altScpBgW, -altScpBgH}, {altScpBgW, altScpH}, {-altScpBgW, altScpH}}
RDRAltScpBg.indices        = {0, 1, 2, 0, 2, 3}
RDRAltScpBg.init_pos       = {altScpX, altScpY}
RDRAltScpBg.material       = materials["MFDFGGray"]
RDRAltScpBg.parent_element = RDRPage.name
AddElement2(RDRAltScpBg)

local RDRAltScp           = CreateElement "ceMeshPoly"
RDRAltScp.name            = create_guid_string()
RDRAltScp.primitivetype   = "triangles"
RDRAltScp.vertices        = {{-altScpW, -altScpH}, {altScpW, -altScpH}, {altScpW, altScpH}, {-altScpW, altScpH}}
RDRAltScp.indices         = {0, 1, 2, 0, 2, 3}
RDRAltScp.material        = materials["MFDLightBlue"] -- MakeMaterial(nil, {110, 187, 255, 255}) -- RGBA 222, 203, 110, 255
RDRAltScp.parent_element  = RDRAltScpBg.name
RDRAltScp.level           = MFD_DEFAULT_LEVEL + 1
RDRAltScp.h_clip_relation = h_clip_relations.REWRITE_LEVEL
AddElement2(RDRAltScp)


local RDRAltScpBgTop          = CreateElement "ceSimpleLineObject"
RDRAltScpBgTop.init_pos       = {0, altScpBgH - lineThickness / 2}
RDRAltScpBgTop.material       = materials["MFDFGGray"]
RDRAltScpBgTop.width          = lineThickness / 2
RDRAltScpBgTop.parent_element = RDRAltScpBg.name
RDRAltScpBgTop.vertices       = {{-altScpBgTopW}, {altScpBgTopW}}
AddElement(RDRAltScpBgTop)

local tmpCounter = 0
for i = -2 / 3, 2 / 3, 1 / 3 do
	local RDRAltScpLeftSideLines          = CreateElement "ceSimpleLineObject"
	RDRAltScpLeftSideLines.init_pos       = {-altScpW - lineThickness / 2, i * altScpH}
	RDRAltScpLeftSideLines.material       = materials["MFDFGGray"]
	RDRAltScpLeftSideLines.width          = lineThickness / 2
	RDRAltScpLeftSideLines.parent_element = RDRAltScpBg.name
	if tmpCounter == 1 or tmpCounter == 3 then
		RDRAltScpLeftSideLines.vertices = {{-altScpSideLinesW}, {altScpSideLinesW}}
	else
		RDRAltScpLeftSideLines.vertices = {{0}, {altScpSideLinesW}}
	end
	AddElement(RDRAltScpLeftSideLines)

	local RDRAltScpRightSideLines          = CreateElement "ceSimpleLineObject"
	RDRAltScpRightSideLines.init_pos       = {altScpW + lineThickness / 2, i * altScpH}
	RDRAltScpRightSideLines.material       = materials["MFDFGGray"]
	RDRAltScpRightSideLines.width          = lineThickness / 2
	RDRAltScpRightSideLines.parent_element = RDRAltScpBg.name
	if tmpCounter == 1 or tmpCounter == 3 then
		RDRAltScpRightSideLines.vertices = {{-altScpSideLinesW}, {altScpSideLinesW}}
	else
		RDRAltScpRightSideLines.vertices = {{-altScpSideLinesW}, {0}}
	end
	RDRAltScpRightSideLines.h_clip_relation = h_clip_relations.REWRITE_LEVEL
	AddElement2(RDRAltScpRightSideLines)

	tmpCounter = tmpCounter + 1
end

for i = 1, 7 do
	if i ~= 4 then
		local RDRAltScpBottomLines          = CreateElement "ceSimpleLineObject"
		RDRAltScpBottomLines.init_pos       = {-altScpW - lineThickness / 2 + i * (altScpFullRangeDist / 8), -altScpBgH}
		RDRAltScpBottomLines.material       = materials["MFDFGGray"]
		RDRAltScpBottomLines.width          = lineThickness / 2
		RDRAltScpBottomLines.parent_element = RDRAltScpBg.name
		if i % 2 == 0 then
			RDRAltScpBottomLines.vertices = {{0}, {0, altScpSideLinesW * 2}}
		else
			RDRAltScpBottomLines.vertices = {{0}, {0, altScpSideLinesW}}
		end
		RDRAltScpBottomLines.h_clip_relation = h_clip_relations.REWRITE_LEVEL
		AddElement2(RDRAltScpBottomLines)
	end
end

local ownShip          = CreateElement "ceSimpleLineObject"
ownShip.name           = create_guid_string()
ownShip.material       = MakeMaterial(nil, {0, 0, 0, 255})
ownShip.parent_element = RDRAltScpBg.name
ownShip.width          = lineThickness / 1.5
ownShip.init_rot       = {270}
ownShip.init_pos       = {-altScpW, -altScpH}
ownShip.vertices       = {{0}, {-.019411 * 1, -.055 * 1}, {.019411 * 1, -.055 * 1}, {0}}
ownShip.element_params = {"EMGY_ALTITUDE"}
ownShip.controllers    = {{"move_left_right_using_parameter", 0, -.00000071}}
AddElement(ownShip)

for i = 2, 5 do
	local range = 5 * 2^i

	for j = 1, 3 do
		local elevation

		if j == 1 then
			elevation = math.rad(2.5)
		elseif j == 2 then
			elevation = math.rad(5)
		elseif j == 3 then
			elevation = math.rad(10)
		end

		local scanHeight = math.tan(elevation) * (range * (altScpFullRangeDist / (altScpW * 2.1)) * 6076.12 * .00000855)

		local RDRAltScpScan           = CreateElement "ceMeshPoly" -- Radar altitude scope scan zone
		RDRAltScpScan.name            = create_guid_string()
		RDRAltScpScan.primitivetype   = "triangles"
		RDRAltScpScan.vertices        = {{0}, {altScpW * 2.1, -scanHeight}, {altScpW * 2.1, scanHeight}}
		RDRAltScpScan.indices         = {0, 1, 2}
		RDRAltScpScan.material        = materials["MFDBeige"]
		RDRAltScpScan.parent_element  = ownShip.name
		RDRAltScpScan.init_rot        = {90}
		RDRAltScpScan.level           = MFD_DEFAULT_LEVEL + 1
		RDRAltScpScan.h_clip_relation = h_clip_relations.COMPARE
		RDRAltScpScan.element_params  = {"RDRFullRange", "SCAN_ZONE_VOLUME_ELEVATION", "RDRAntennaElSymb"}
		RDRAltScpScan.controllers     = {{"parameter_compare_with_number", 0, range}, {"parameter_in_range", 1, (elevation) - .01, (elevation) + .01}, {"rotate_using_parameter", 2, 1}}
		AddElement2(RDRAltScpScan)
	end
end

for i = 1, 2 do
	local RDRElLim           = CreateElement "ceSimpleLineObject" -- Radar elevation limits
	RDRElLim.name            = create_guid_string()
	RDRElLim.material        = materials["MFDFGGray"]
	RDRElLim.parent_element  = ownShip.name
	RDRElLim.width           = lineThickness / 2
	RDRElLim.vertices        = {{0}, {0}}
	RDRElLim.init_rot        = {90}
	RDRElLim.level           = MFD_DEFAULT_LEVEL + 1
	RDRElLim.h_clip_relation = h_clip_relations.COMPARE
	if i == 1 then
		RDRElLim.element_params = {"RDRElLimUpperX", "RDRElLimUpperY"}
	else
		RDRElLim.element_params = {"RDRElLimLowerX", "RDRElLimLowerY"}
	end
	RDRElLim.controllers = {{"line_object_set_point_using_parameters", 1, 0, 1, .155, .00000072}} -- Fix so there isn't sapce between top and line
	AddElement2(RDRElLim)
end

local ownShipVelvec          = CreateElement "ceSimpleLineObject"
ownShipVelvec.name           = create_guid_string()
ownShipVelvec.material       = MakeMaterial(nil, {0, 0, 0, 255})
ownShipVelvec.parent_element = ownShip.name
ownShipVelvec.width          = lineThickness / 1.5
ownShipVelvec.vertices       = {{0}, {altScpFullRangeDist / 16}}
ownShipVelvec.init_rot       = {90}
AddElement(ownShipVelvec)


local RDRAltScpFullRange          = CreateElement "ceSimpleLineObject"
RDRAltScpFullRange.init_pos       = {altScpFullRangeX}
RDRAltScpFullRange.material       = materials["MFDFGGray"]
RDRAltScpFullRange.width          = lineThickness / 2
RDRAltScpFullRange.parent_element = RDRAltScpBg.name
RDRAltScpFullRange.vertices       = {{0, -altScpBgH}, {0, altScpBgH}}
AddElement(RDRAltScpFullRange)

add_text_param(.01, .03 - altScpBgH, "RDRFullRange", nil, RDRAltScpFullRange, mfd_strdefs_digit_S, "Gripen_Font_black", "LeftCenter")

local altScpHalfRange          = CreateElement "ceSimpleLineObject"
altScpHalfRange.init_pos       = {altScpHalfRangeX}
altScpHalfRange.material       = materials["MFDFGGray"]
altScpHalfRange.width          = lineThickness / 2
altScpHalfRange.parent_element = RDRAltScpBg.name
altScpHalfRange.vertices       = {{0, -altScpBgH}, {0, altScpBgH}}
AddElement(altScpHalfRange)

add_text_param(.01, .03 - altScpBgH, "RDRHalfRange", nil, altScpHalfRange, mfd_strdefs_digit_S, "Gripen_Font_black", "LeftCenter")


-----------------------------------------



local RadarPPIScopeBackground           = CreateElement "ceMeshPoly"
RadarPPIScopeBackground.name            = create_guid_string()
RadarPPIScopeBackground.primitivetype   = "triangles"
RadarPPIScopeBackground.vertices        = {{0, -1.25}, {-RDRWidth, 0.175}, {-RDRWidth, -1.25}, {RDRWidth, -1.25}, {RDRWidth, 0.175}}
RadarPPIScopeBackground.indices         = {0, 1, 2, 0, 3, 4}
RadarPPIScopeBackground.init_pos        = {0, 0, 0}
RadarPPIScopeBackground.material        = MakeMaterial(nil, {0, 0, 0, 255}) -- RGBA 222, 203, 110, 255
RadarPPIScopeBackground.parent_element  = RDRPage.name
RadarPPIScopeBackground.h_clip_relation = h_clip_relations.REWRITE_LEVEL
RadarPPIScopeBackground.level           = MFD_DEFAULT_LEVEL
RadarPPIScopeBackground.isvisible       = true
AddElement2(RadarPPIScopeBackground)

RadarPPIScopeBackground                = CreateElement "ceMeshPoly"
RadarPPIScopeBackground.name           = create_guid_string()
RadarPPIScopeBackground.primitivetype  = "triangles"
RadarPPIScopeBackground.init_pos       = {0, -1.25}
RadarPPIScopeBackground.init_rot       = {30, 0}
RadarPPIScopeBackground.material       = MakeMaterial(nil, {0, 0, 0, 255})
RadarPPIScopeBackground.parent_element = RDRPage.name
set_circle(RadarPPIScopeBackground, (1.425 + lineThickness) / 0.866, 0, 60, 60)
RadarPPIScopeBackground.additive_alpha = false
AddElement(RadarPPIScopeBackground)

--------------------------------------------------------------------------------------------

ownShipY = -1.25




local RadarPPIScope           = CreateElement "ceMeshPoly"
RadarPPIScope.name            = create_guid_string()
RadarPPIScope.primitivetype   = "triangles"
RadarPPIScope.vertices        = {{0, -1.25}, {-RDRWidth, 0.175}, {-RDRWidth, -1.25}, {RDRWidth, -1.25}, {RDRWidth, 0.175}}
RadarPPIScope.indices         = {0, 1, 2, 0, 3, 4}
RadarPPIScope.init_pos        = {0, 0, 0}
RadarPPIScope.material        = MakeMaterial(nil, {110, 187, 255, 255}) -- RGBA 222, 203, 110, 255
RadarPPIScope.parent_element  = RDRPage.name
RadarPPIScope.h_clip_relation = h_clip_relations.REWRITE_LEVEL
RadarPPIScope.level           = MFD_DEFAULT_LEVEL
RadarPPIScope.isvisible       = true
-- RadarPPIScope.element_params 	= {"RD_BRIGHTNESS"}
-- RadarPPIScope.controllers    	= {{"opacity_using_parameter", 0}}
AddElement2(RadarPPIScope)

RadarPPIScope                = CreateElement "ceMeshPoly"
RadarPPIScope.name           = create_guid_string()
RadarPPIScope.primitivetype  = "triangles"
RadarPPIScope.init_pos       = {0, -1.25}
RadarPPIScope.init_rot       = {30, 0}
RadarPPIScope.material       = MakeMaterial(nil, {110, 187, 255, 255})
RadarPPIScope.parent_element = RDRPage.name
-- RadarPPIScope.element_params	= {"RD_BRIGHTNESS"}
-- RadarPPIScope.controllers		= {{"opacity_using_parameter", 0, 1 }}
set_circle(RadarPPIScope, 1.425 / 0.866, 0, 60, 60)
RadarPPIScope.additive_alpha = false
AddElement(RadarPPIScope)



ScanAzimuthBackground                = CreateElement "ceMeshPoly"
ScanAzimuthBackground.name           = create_guid_string()
ScanAzimuthBackground.primitivetype  = "triangles"
ScanAzimuthBackground.init_pos       = {0, -1.25}
ScanAzimuthBackground.init_rot       = {30, 0}
ScanAzimuthBackground.material       = MakeMaterial(nil, {1.25, 1.25, 1.25, 255})
ScanAzimuthBackground.parent_element = RDRPage.name
set_circle(ScanAzimuthBackground, (1.425 + lineThickness) / 0.866, 0, 60, 60)
ScanAzimuthBackground.additive_alpha = false
AddElement(ScanAzimuthBackground)

ScanAzimuth                = CreateElement "ceMeshPoly"
ScanAzimuth.name           = create_guid_string()
ScanAzimuth.primitivetype  = "triangles"
ScanAzimuth.init_pos       = {0, -1.25}
ScanAzimuth.init_rot       = {30, 0}
ScanAzimuth.material       = MakeMaterial(nil, {222, 203, 110, 255})
ScanAzimuth.parent_element = RDRPage.name
-- ScanAzimuth.element_params	= {"RD_BRIGHTNESS"}
-- ScanAzimuth.controllers		= {{"opacity_using_parameter", 0, 1 }}
set_circle(ScanAzimuth, 1.425 / 0.866, 0, 60, 60)
ScanAzimuth.additive_alpha = false
AddElement(ScanAzimuth)





for i = -1, 1, 2 do
	RadarPPIScopeLine                = CreateElement "ceSimpleLineObject"
	RadarPPIScopeLine.init_pos       = {RDRWidth * i, 0.1795}
	RadarPPIScopeLine.material       = MakeMaterial(nil, {0, 0, 0, 255})
	RadarPPIScopeLine.width          = 0.0029
	RadarPPIScopeLine.parent_element = RDRPage.name
	RadarPPIScopeLine.vertices       = {{0, 0}, {0, -0.952}}
	AddElement(RadarPPIScopeLine)

	RadarPPIScopeLine                = CreateElement "ceSimpleLineObject"
	RadarPPIScopeLine.init_pos       = {-0.0015 * i, -1.247}
	RadarPPIScopeLine.init_rot       = {120 * i, 0}
	RadarPPIScopeLine.material       = MakeMaterial(nil, {0, 0, 0, 255})
	RadarPPIScopeLine.width          = 0.0033
	RadarPPIScopeLine.parent_element = RDRPage.name
	RadarPPIScopeLine.vertices       = {{0, 0}, {0, -0.9535}}
	AddElement(RadarPPIScopeLine)


end

RadarPPIScopeFullRange                = CreateElement "ceMeshPoly"
RadarPPIScopeFullRange.name           = create_guid_string()
RadarPPIScopeFullRange.primitivetype  = "triangles"
RadarPPIScopeFullRange.init_pos       = {0, -1.25}
RadarPPIScopeFullRange.init_rot       = {32.75, 0}
RadarPPIScopeFullRange.material       = MakeMaterial(nil, {0, 0, 0, 255})
RadarPPIScopeFullRange.parent_element = RDRPage.name
set_circle(RadarPPIScopeFullRange, 0.925 * 1.425 / 0.866, (0.925 * 1.425 / 0.866) - lineThickness, 65.5, 60)
AddElement(RadarPPIScopeFullRange)

RadarPPIScopeHalfRange                = CreateElement "ceMeshPoly"
RadarPPIScopeHalfRange.name           = create_guid_string()
RadarPPIScopeHalfRange.primitivetype  = "triangles"
RadarPPIScopeHalfRange.init_pos       = {0, -1.25}
RadarPPIScopeHalfRange.init_rot       = {60, 0}
RadarPPIScopeHalfRange.material       = MakeMaterial(nil, {0, 0, 0, 255})
RadarPPIScopeHalfRange.parent_element = RDRPage.name
set_circle(RadarPPIScopeHalfRange, 0.4625 * 1.425 / 0.866, (0.4625 * 1.425 / 0.866) - lineThickness, 120, 60)
AddElement(RadarPPIScopeHalfRange)





local ContactBase           = CreateElement "ceMeshPoly"
ContactBase.name            = create_guid_string()
ContactBase.primitivetype   = "triangles"
ContactBase.vertices        = {{0, 0}, {0, 0}, {0, 0}, {0, 0}}
ContactBase.indices         = {0, 1, 2, 0, 2, 3}
ContactBase.init_pos        = {0, ownShipY, 0}
ContactBase.material        = MakeMaterial(nil, {100, 0, 0, 100}) -- RGBA
ContactBase.parent_element  = RDRPage.name
ContactBase.h_clip_relation = h_clip_relations.DECREASE_IF_LEVEL
ContactBase.level           = MFD_DEFAULT_LEVEL + 1
ContactBase.change_opacity  = false
ContactBase.collimated      = false
ContactBase.isvisible       = false
Add(ContactBase)
--------------------------------------------------------------------------------------------------------------------------------------------------------

-- local AirContactScale = (0.025 * width) / 2
local CursorGain = 0.08292
local ASMult = 396.75

local normContactScale = (.025 * width) / 2
local prioContactScale = (.03 * width) / 2
-- prifContactScale = AirContactScale
-- normContactScale = prifContactScale * 0.75



function EnemyAirContact(n)
	-- local contactBase           = CreateElement "ceSimple"
	-- contactBase.name            = "Enemy_Air_Contact_"..n
	-- contactBase.element_params  = {"TargetInfo_"..n.."_CD_X", "TargetInfo_"..n.."_CD_Y", "TargetInfo_"..n.."_is_sensor_contact", "TargetInfo_"..n.."_Heading",
	-- 							   "TargetInfo_"..n.."_Coalition"}
	-- contactBase.controllers     = {{"move_left_right_using_parameter",0, CursorGain}, {"move_up_down_using_parameter",1, CursorGain}, {"parameter_compare_with_number",2, -1},
	-- 							   {"rotate_using_parameter",3, -1}, {"parameter_compare_with_number",4, 2}}
	----contactBase.use_mipfilter   = true
	----contactBase.additive_alpha  = false
	----contactBase.change_opacity  = false
	----contactBase.h_clip_relation = h_clip_relations.DECREASE_IF_LEVEL
	----contactBase.level           = MFD_DEFAULT_LEVEL + 1
	-- Add(contactBase)


	local contactBase           = CreateElement "ceMeshPoly"
	contactBase.name            = "Enemy_Air_Contact_" .. n
	contactBase.primitivetype   = "triangles"
	contactBase.material        = MakeMaterial(nil, {255, 50, 0, 255})
	contactBase.parent_element  = ContactBase.name
	contactBase.element_params  = {"TargetInfo_" .. n .. "_CD_X", "TargetInfo_" .. n .. "_CD_Y", "TargetInfo_" .. n .. "_is_sensor_contact", "TargetInfo_" .. n .. "_Heading",
		"TargetInfo_" .. n .. "_Coalition"}
	contactBase.controllers     = {{"move_left_right_using_parameter", 0, CursorGain}, {"move_up_down_using_parameter", 1, CursorGain}, {"parameter_compare_with_number", 2, -1},
		{"rotate_using_parameter",          3, -1}, {"parameter_compare_with_number", 4, 2}}
	contactBase.use_mipfilter   = true
	contactBase.additive_alpha  = false
	contactBase.change_opacity  = false
	contactBase.h_clip_relation = h_clip_relations.DECREASE_IF_LEVEL
	contactBase.level           = MFD_DEFAULT_LEVEL + 1
	set_circle(contactBase, normContactScale, 0, 360, 18)
	Add(contactBase)

	local prioCircle          = Copy(contactBase)
	prioCircle.name           = create_guid_string()
	prioCircle.parent_element = "Enemy_Air_Contact_" .. n
	prioCircle.element_params = {"TargetInfo_" .. n .. "_Priority"}
	prioCircle.controllers    = {{"parameter_in_range", 0, 0, 5}}
	set_circle(prioCircle, prifContactScale, 0, 360, 18)
	Add(prioCircle)

	for i = -1, 1, 2 do
		PrioOne                 = CreateElement "ceSimpleLineObject"
		PrioOne.name            = create_guid_string()
		PrioOne.init_pos        = {0, 0}
		PrioOne.init_rot        = {45 * i, 0}
		PrioOne.material        = MakeMaterial(nil, {255, 50, 0, 255})
		PrioOne.width           = 0.0033
		PrioOne.parent_element  = "Enemy_Air_Contact_" .. n
		PrioOne.vertices        = {{0, -0.05}, {0, 0.05}}
		PrioOne.element_params  = {"TargetInfo_" .. n .. "_Priority", "Prif_SelectedNum"}
		PrioOne.controllers     = {{"compare_parameters", 0, 2}} -- if param1 == param2 then visible, }
		PrioOne.use_mipfilter   = true
		PrioOne.additive_alpha  = false
		PrioOne.change_opacity  = false
		PrioOne.h_clip_relation = h_clip_relations.DECREASE_IF_LEVEL
		PrioOne.level           = MFD_DEFAULT_LEVEL + 1
		Add(PrioOne)
	end


	for i = 0, 1000, 50 do
		PositionLine                 = CreateElement "ceSimpleLineObject"
		PositionLine.name            = create_guid_string()
		PositionLine.init_pos        = {0, 0}
		PositionLine.material        = MakeMaterial(nil, {255, 50, 0, 255})
		PositionLine.width           = 0.0033
		PositionLine.parent_element  = "Enemy_Air_Contact_" .. n
		PositionLine.vertices        = {{0, 0}, {0, 0.0004 * i}}
		PositionLine.element_params  = {"TargetInfo_" .. n .. "_Speed"}
		PositionLine.controllers     = {{"parameter_in_range", 0, i - 50, i}}
		PositionLine.use_mipfilter   = true
		PositionLine.additive_alpha  = false
		PositionLine.change_opacity  = false
		PositionLine.h_clip_relation = h_clip_relations.DECREASE_IF_LEVEL
		PositionLine.level           = MFD_DEFAULT_LEVEL + 1
		Add(PositionLine)
	end

	local Alt_readout           = orange_text_param_with_cd_brightness(0, -prifContactScale * 2, "TargetInfo_" .. n .. "_Altitude_KFeet", "%0.0f", contactBase, {0.005, 0.005, 0, 0}, "Gripen_Font_ContactsOrange")
	Alt_readout.h_clip_relation = h_clip_relations.DECREASE_IF_LEVEL
	Alt_readout.level           = MFD_DEFAULT_LEVEL + 1
end

local friendly_verts = {{-normContactScale, normContactScale}, {normContactScale, normContactScale}, {normContactScale, -normContactScale}, {-normContactScale, -normContactScale}, {0, normContactScale * 2}}
local friendly_inds = {0, 4, 1, 0, 1, 2, 0, 2, 3}
local RWRLineThickness = .007
function FriendlyRadarContact(n)
	local i
	if n < 10 then
		i = "_0" .. n .. "_"
	else
		i = "_" .. n .. "_"
	end

	local contact           = CreateElement "ceMeshPoly"
	contact.primitivetype   = "triangles"
	contact.name            = create_guid_string()
	contact.material        = MakeMaterial(nil, {25, 100, 25, 255})
	contact.parent_element  = ContactBase.name
	contact.vertices        = friendly_verts
	contact.indices         = friendly_inds
	contact.init_pos        = {0, 0}
	contact.element_params  = {"RADAR_CONTACT" .. i .. "RDX", "RADAR_CONTACT" .. i .. "RDY", "RADAR_CONTACT" .. i .. "TIME", "RADAR_CONTACT" .. i .. "relHdg"}
	contact.controllers     = {{"move_left_right_using_parameter", 0, CursorGain}, {"move_up_down_using_parameter", 1, CursorGain}, {"parameter_in_range", 2, 0, 3.1}, {"rotate_using_parameter", 3, 1}}
	contact.use_mipfilter   = true
	contact.additive_alpha  = false
	contact.change_opacity  = false
	contact.h_clip_relation = h_clip_relations.REWRITE_LEVEL
	contact.level           = MFD_DEFAULT_LEVEL
	Add(contact)

	local altReadout           = green_text_param_with_cd_brightness(0, -0.06, "RADAR_CONTACT" .. i .. "altK", "%.0f", contact, {0.005, 0.005, 0, 0}, "Gripen_Font_HL_Green")
	altReadout.h_clip_relation = h_clip_relations.REWRITE_LEVEL
	altReadout.level           = MFD_DEFAULT_LEVEL

	local contactVelvec          = CreateElement "ceSimpleLineObject"
	contactVelvec.name           = create_guid_string()
	contactVelvec.material       = MakeMaterial(nil, {25, 100, 25, 255})
	contactVelvec.parent_element = contact.name
	contactVelvec.width          = RWRLineThickness / 2
	contactVelvec.vertices       = {{0}, {0}}
	contactVelvec.element_params = {"RADAR_CONTACT" .. i .. "RDVelvec", "ONE"}
	contactVelvec.controllers    = {{"line_object_set_point_using_parameters", 1, 1, 0, 0, CursorGain}}
	AddElement(contactVelvec)



	local altScpContact           = CreateElement "ceMeshPoly"
	altScpContact.primitivetype   = "triangles"
	altScpContact.name            = create_guid_string()
	altScpContact.material        = MakeMaterial(nil, {25, 100, 25, 255})
	altScpContact.parent_element  = RDRAltScp.name
	altScpContact.vertices        = friendly_verts
	altScpContact.indices         = friendly_inds
	altScpContact.init_pos        = {-altScpW, -altScpH}
	altScpContact.element_params  = {"RADAR_CONTACT" .. i .. "altScpRange", "RADAR_CONTACT" .. i .. "alt", "RADAR_CONTACT" .. i .. "TIME", "RADAR_CONTACT" .. i .. "pitch"}
	altScpContact.controllers     = {{"move_left_right_using_parameter", 0, ASMult}, {"move_up_down_using_parameter", 1, .00000071}, {"parameter_in_range", 2, 0, 3.1}, {"rotate_using_parameter", 3, 1}}
	altScpContact.use_mipfilter   = true
	altScpContact.additive_alpha  = false
	altScpContact.change_opacity  = false
	altScpContact.h_clip_relation = h_clip_relations.REWRITE_LEVEL
	altScpContact.level           = MFD_DEFAULT_LEVEL
	Add(altScpContact)

	local altScpContactVelvec           = CreateElement "ceSimpleLineObject"
	altScpContactVelvec.name            = create_guid_string()
	altScpContactVelvec.material        = MakeMaterial(nil, {25, 100, 25, 255})
	altScpContactVelvec.parent_element  = altScpContact.name
	altScpContactVelvec.width           = RWRLineThickness / 2
	altScpContactVelvec.vertices        = {{0}, {0}}
	altScpContactVelvec.element_params  = {"RADAR_CONTACT" .. i .. "altScpVelvec", "ONE"}
	altScpContactVelvec.controllers     = {{"line_object_set_point_using_parameters", 1, 1, 0, 0, ASMult}}
	altScpContactVelvec.h_clip_relation = h_clip_relations.REWRITE_LEVEL
	altScpContactVelvec.level           = MFD_DEFAULT_LEVEL
	Add(altScpContactVelvec)


	local altScpPrio1Line           = CreateElement "ceSimpleLineObject"
	altScpPrio1Line.name            = create_guid_string()
	altScpPrio1Line.material        = MakeMaterial(nil, {0, 0, 0, 255})
	altScpPrio1Line.parent_element  = RDRAltScpBg.name
	altScpPrio1Line.width           = lineThickness / 2
	altScpPrio1Line.vertices        = {{0, -altScpBgH + lineThickness}, {0, altScpBgH - lineThickness}}
	-- altScpPrio1Line.element_params  = {"RADAR_CONTACT" .. i .. "altScpVelvec", "ONE"}
	-- altScpPrio1Line.controllers     = {{"line_object_set_point_using_parameters", 1, 1, 0, 0, CursorGain}}
	altScpPrio1Line.h_clip_relation = h_clip_relations.REWRITE_LEVEL
	AddElement2(altScpPrio1Line)

	tmpCounter = 0
	for j = -2 / 3, 2 / 3, 1 / 3 do
		local altScpPrio1LineLines          = CreateElement "ceSimpleLineObject"
		altScpPrio1LineLines.init_pos       = {0, j * altScpH}
		altScpPrio1LineLines.material       = materials["black"]
		altScpPrio1LineLines.width          = lineThickness / 2
		altScpPrio1LineLines.parent_element = altScpPrio1Line.name
		if tmpCounter == 1 or tmpCounter == 3 then
			altScpPrio1LineLines.vertices = {{-1.5 * altScpSideLinesW}, {1.5 * altScpSideLinesW}}
		else
			altScpPrio1LineLines.vertices = {{-altScpSideLinesW}, {altScpSideLinesW}}
		end
		altScpPrio1LineLines.h_clip_relation = h_clip_relations.REWRITE_LEVEL
		AddElement2(altScpPrio1LineLines)

		if aboutEqualTo(j, -1 / 3) then
			add_text("20", -.03, j * altScpH, altScpPrio1Line, "Gripen_Font_black", mfd_strdefs_digit_S, "RightCenter")
		elseif aboutEqualTo(j, 1 / 3) then
			add_text("40", -.03, j * altScpH, altScpPrio1Line, "Gripen_Font_black", mfd_strdefs_digit_S, "RightCenter")
		end
		tmpCounter = tmpCounter + 1
	end
end





for n = 0, 99 do
	FriendlyRadarContact(n)
	-- EnemyAirContact(n)
end



local CD_CURSOR           = CreateElement "ceMeshPoly"
CD_CURSOR.name            = "CD_CURSOR"
CD_CURSOR.primitivetype   = "triangles"
CD_CURSOR.material        = MakeMaterial(nil, {0, 0, 0, 255})
CD_CURSOR.init_pos        = {0, 0}
CD_CURSOR.vertices        = {{-0.004, -0.07}, {0.004, -0.07}, {-0.004, -0.02}, {0.004, -0.02}, {-0.004, 0.02}, {0.004, 0.02}, {-0.004, 0.07}, {0.004, 0.07}, {-0.004, -0.004}, {0.004, -0.004}, {-0.004, 0.004}, {0.004, 0.004}, {-0.074, -0.004}, {-0.018, -0.004}, {-0.074, 0.004}, {-0.018, 0.004}, {0.074, 0.004}, {0.018, 0.004}, {0.074, -0.004}, {0.018, -0.004}}
CD_CURSOR.indices         = {0, 1, 2, 3, 2, 1, 4, 5, 6, 7, 6, 5, 8, 9, 10, 11, 10, 9, 12, 13, 14, 15, 14, 13, 16, 17, 18, 19, 18, 17}
CD_CURSOR.h_clip_relation = h_clip_relations.REWRITE_LEVEL
CD_CURSOR.parent_element  = ContactBase.name
CD_CURSOR.level           = MFD_DEFAULT_LEVEL
CD_CURSOR.element_params  = {"CD_CursY", "CD_CursX"}
CD_CURSOR.controllers     = {{"move_up_down_using_parameter", 0, CursorGain}, {"move_left_right_using_parameter", 1, CursorGain}, {"parameter_in_range", 1, -1, 1}}
Add(CD_CURSOR)



ScanzoneBase                 = CreateElement "ceMeshPoly"
ScanzoneBase.name            = create_guid_string()
ScanzoneBase.primitivetype   = "triangles"
ScanzoneBase.vertices        = {{0, 0}, {0, 0}, {0, 0}, {0, 0}}
ScanzoneBase.indices         = {0, 1, 2, 0, 2, 3}
ScanzoneBase.init_pos        = {0, ownShipY, 0}
ScanzoneBase.material        = MakeMaterial(nil, {100, 0, 0, 100}) -- RGBA
ScanzoneBase.parent_element  = RDRPage.name
ScanzoneBase.element_params  = {"SCAN_ZONE_ORIGIN_AZIMUTH"}
ScanzoneBase.controllers     = {{"rotate_using_parameter", 0, 1}}
ScanzoneBase.h_clip_relation = h_clip_relations.DECREASE_IF_LEVEL
ScanzoneBase.level           = MFD_DEFAULT_LEVEL + 1
ScanzoneBase.change_opacity  = false
ScanzoneBase.collimated      = false
ScanzoneBase.isvisible       = false
Add(ScanzoneBase)

for i = -1, 1, 2 do
	local ScanzoneLine           = CreateElement "ceSimpleLineObject"
	ScanzoneLine.init_pos        = {0, 0, 0}
	ScanzoneLine.material        = MakeMaterial(nil, {25, 25, 25, 255})
	ScanzoneLine.width           = 0.0025
	ScanzoneLine.parent_element  = ScanzoneBase.name
	ScanzoneLine.vertices        = {{0, 0}, {0, 1.33}}
	ScanzoneLine.init_rot        = {i * 60, 0, 0}
	ScanzoneLine.use_mipfilter   = true
	ScanzoneLine.additive_alpha  = false
	ScanzoneLine.change_opacity  = false
	ScanzoneLine.h_clip_relation = h_clip_relations.REWRITE_LEVEL
	ScanzoneLine.level           = MFD_DEFAULT_LEVEL + 1
	Add(ScanzoneLine)
end











local MENU_RDR = add_text([[R
D
R]], -0.92 + 0.022, -0.535, RDRPage, "Gripen_Font_black", mfd_strdefs_digit_S)










































-- =============================================== L D P ==============================================================================
LDP_PAGE                = CreateElement "ceSimple"
LDP_PAGE.init_pos       = {0, 0}
LDP_PAGE.name           = create_guid_string()
LDP_PAGE.parent_element = TAN_RD_MASTER.name
LDP_PAGE.element_params = {"RDPage"}
LDP_PAGE.controllers    = {{"parameter_compare_with_number", 0, 2}}
AddElement(LDP_PAGE)

videovertices = {{-0.84, 1}, {0.84, 1}, {0.84, -0.64}, {-0.84, -0.64}}

VideoBackground                = CreateElement "ceTexPoly"
VideoBackground.name           = "VideoBackground"
VideoBackground.vertices       = videovertices
VideoBackground.indices        = {0, 1, 2, 0, 2, 3}
VideoBackground.tex_coords     = {{0, 0}, {1, 0}, {1, 1}, {0, 1}}
VideoBackground.init_pos       = {0, 0}
VideoBackground.material       = materials["BBLACK"]
VideoBackground.parent_element = LDP_PAGE.name
Add(VideoBackground)

FLIR_Video_RD                = CreateElement "ceTexPoly"
FLIR_Video_RD.name           = "FLIR_Video_RD"
FLIR_Video_RD.vertices       = videovertices
FLIR_Video_RD.indices        = {0, 1, 2, 0, 2, 3}
FLIR_Video_RD.tex_coords     = {{0, 0}, {1, 0}, {1, 1}, {0, 1}}
FLIR_Video_RD.material       = "render_target_1"
FLIR_Video_RD.parent_element = LDP_PAGE.name
FLIR_Video_RD.init_pos       = {0, 0}
-- FLIR_Video_RD.element_params	= {"RD_BRIGHTNESS"}
-- FLIR_Video_RD.controllers		= {{"opacity_using_parameter", 0}}
FLIR_Video_RD.isvisible      = true
FLIR_Video_RD.additive_alpha = true
FLIR_Video_RD.use_mipfilter  = true
Add(FLIR_Video_RD)


CompassMask                 = CreateElement "ceTexPoly"
CompassMask.name            = "CompassMask"
CompassMask.vertices        = {{-0.84, 1.21}, {0.84, 1.21}, {0.84, 1.05}, {-0.84, 1.05}}
CompassMask.indices         = {0, 1, 2, 0, 2, 3}
CompassMask.tex_coords      = {{0, 0}, {1, 0}, {1, 1}, {0, 1}}
CompassMask.init_pos        = {0, 0}
CompassMask.material        = MakeMaterial(nil, {0, 100, 0, 100})
CompassMask.parent_element  = LDP_PAGE.name
CompassMask.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
CompassMask.level           = MFD_DEFAULT_LEVEL
CompassMask.isvisible       = false
Add(CompassMask)


CompassLine                = CreateElement "ceSimpleLineObject"
CompassLine.name           = "CompassLine"
CompassLine.init_pos       = {0, 1.10}
CompassLine.material       = materials["BBLACK"]
CompassLine.width          = 0.0045
CompassLine.parent_element = LDP_PAGE.name
CompassLine.vertices       = {{0, -0.84}, {0, 0.84}}
CompassLine.init_rot       = {90, 0, 0}
AddElement(CompassLine)

for i = -43, 6, 1 do

	j = -i

	if j < 0 then
		j = 36 + j
	elseif j >= 36 then
		j = j - 36
	end

	HeadingLine                 = CreateElement "ceSimpleLineObject"
	HeadingLine.init_pos        = {0, 1.15}
	HeadingLine.material        = materials["BBLACK"]
	HeadingLine.width           = 0.0045
	HeadingLine.init_pos        = {0, i / (6 / 0.84)}
	HeadingLine.parent_element  = CompassLine.name
	HeadingLine.vertices        = {{0, 0}, {0.025, 0}}
	HeadingLine.init_rot        = {0, 0, 0}
	HeadingLine.h_clip_relation = h_clip_relations.DECREASE_IF_LEVEL
	HeadingLine.level           = MFD_DEFAULT_LEVEL + 1
	HeadingLine.element_params  = {"HEADING"}
	HeadingLine.controllers     = {{"move_up_down_using_parameter", 0, 0.001169}}
	Add(HeadingLine)

	if j % 3 == 0 then
		if j < 10 then
			k = "0" .. math.abs(j)
		else
			k = math.abs(j)
		end

		local HeadingDigits           = CreateElement "ceStringPoly"
		HeadingDigits.name            = create_guid_string()
		HeadingDigits.material        = fonts["Gripen_Font_black"]
		HeadingDigits.init_pos        = {0.05, 0}
		HeadingDigits.init_rot        = {-90, 0, 0}
		HeadingDigits.stringdefs      = mfd_strdefs_digit_S
		HeadingDigits.alignment       = "CenterCenter"
		HeadingDigits.value           = k
		HeadingDigits.parent_element  = HeadingLine.name
		HeadingDigits.h_clip_relation = h_clip_relations.DECREASE_IF_LEVEL
		HeadingDigits.level           = MFD_DEFAULT_LEVEL + 1
		Add(HeadingDigits)
	end

end

for i = -1, 1, 2 do

	local tilt = 25 * i

	local CompassArrow          = CreateElement "ceSimpleLineObject"
	CompassArrow.init_pos       = {0, 0}
	CompassArrow.material       = materials["BBLACK"]
	CompassArrow.width          = 0.0045
	CompassArrow.parent_element = CompassLine.name
	CompassArrow.vertices       = {{0, 0}, {0, 0.05}}
	CompassArrow.init_rot       = {90 + tilt, 0, 0}
	AddElement(CompassArrow)

end


----------------------------------------------------------------------

local MLAS = add_text([[M
L
A
S]], -0.97 + xcor, 0.84, LDP_PAGE, "Gripen_Font_black", mfd_strdefs_digit_S)

local MLAS_BOX = make_softkey_box(4.1, -0.97 + xcor, 0.84, 0, LDP_PAGE, "MLAS_TOGGLE")
AddElement(MLAS_BOX)

local TRCK = add_text([[T
R
C
K]], -0.97 + xcor, -0.02, LDP_PAGE, "Gripen_Font_black", mfd_strdefs_digit_S)


local TRCK = add_text([[ AREA
PNT
INR]], -0.97 + 0.1, 0.0075, LDP_PAGE, "Gripen_Font_black", mfd_strdefs_digit_S)



local MENU_LDP = add_text([[L
D
P]], -0.92 + 0.022, -0.535, LDP_PAGE, "Gripen_Font_black", mfd_strdefs_digit_S)


local IR = add_text([[I
R]], 0.97 - xcor, 1.15, LDP_PAGE, "Gripen_Font_black", mfd_strdefs_digit_S)

local CCD = add_text([[C
C
D]], 0.97 - 0.07, 1.12, LDP_PAGE, "Gripen_Font_black", mfd_strdefs_digit_S)

local ZONE = add_text([[Z
O
N
E]], 0.97 - xcor, 0.84, LDP_PAGE, "Gripen_Font_black", mfd_strdefs_digit_S)

local CMPS = add_text([[C
M
P
S]], 0.97 - xcor, 0.56, LDP_PAGE, "Gripen_Font_black", mfd_strdefs_digit_S)

local CMPS_BOX = make_softkey_box(4.1, 0.97 - xcor, 0.56, 0, LDP_PAGE, "CMPS_TOGGLE")
AddElement(CMPS_BOX)

local OFST = add_text([[O
F
S
T]], 0.97 - xcor, 0.26, LDP_PAGE, "Gripen_Font_black", mfd_strdefs_digit_S)

local OFST_BOX = make_softkey_box(4.1, 0.97 - xcor, 0.26, 0, LDP_PAGE, "OFST_TOGGLE")
AddElement(OFST_BOX)


local BW_HOT = add_text([[BHOT
WHOT]], -0.15, -1.25, LDP_PAGE, "Gripen_Font_black", mfd_strdefs_digit_S)

local INV_SYMB = add_text([[INV
SYMB]], 0.15, -1.25, LDP_PAGE, "Gripen_Font_black", mfd_strdefs_digit_S)

local GIMB_text = add_text("GIMB", 0.25, -0.7, LDP_PAGE, "Gripen_Font_black", mfd_strdefs_digit_S)
local ELEV_text = add_text("ELEV", 0.25, -0.77, LDP_PAGE, "Gripen_Font_black", mfd_strdefs_digit_S)

add_text_param(0.4, -0.7, "LDP_GIMB", "%03.0f", LDP_PAGE, mfd_strdefs_digit_S, "Gripen_Font_black")
add_text_param(0.4, -0.77, "LDP_ELEV", "%03.0f", LDP_PAGE, mfd_strdefs_digit_S, "Gripen_Font_black")


local LAT_text = add_text("LAT", 0.25, -0.9, LDP_PAGE, "Gripen_Font_black", mfd_strdefs_digit_S)
local LON_text = add_text("LON", 0.25, -0.97, LDP_PAGE, "Gripen_Font_black", mfd_strdefs_digit_S)

add_text_param(0.4, -0.90, "LDP_LAT", "%01.2f", LDP_PAGE, mfd_strdefs_digit_S, "Gripen_Font_black")
add_text_param(0.4, -0.97, "LDP_LON", "%01.2f", LDP_PAGE, mfd_strdefs_digit_S, "Gripen_Font_black")



-- Keep this last to ensure visibility in LDP mode
HORIZON_LINE_base                = CreateElement "ceSimple"
HORIZON_LINE_base.init_pos       = {0, 0.195}
HORIZON_LINE_base.name           = create_guid_string()
-- HORIZON_LINE_base.h_clip_relation	= h_clip_relations.DECREASE_IF_LEVEL
-- HORIZON_LINE_base.level				= MFD_DEFAULT_LEVEL + 1
HORIZON_LINE_base.parent_element = TAN_RD_MASTER.name
HORIZON_LINE_base.element_params = {"RAW_RALT", "ADI_ROLL"}
HORIZON_LINE_base.controllers    = {{"parameter_in_range", 0, -1, 3001}, {"rotate_using_parameter", 1, 1}}
AddElement3(HORIZON_LINE_base)

local HORIZON_LINE           = create_mfd_tex(CENTER_DISPLAY_COLOR, 4, 1664, 1815, 1668, 2)
HORIZON_LINE.name            = create_guid_string()
HORIZON_LINE.init_pos        = {0, 0}
HORIZON_LINE.parent_element  = HORIZON_LINE_base.name
HORIZON_LINE.h_clip_relation = h_clip_relations.DECREASE_IF_LEVEL
HORIZON_LINE.level           = MFD_DEFAULT_LEVEL + 1
-- HORIZON_LINE.element_params 	= {"RD_BRIGHTNESS"}
-- HORIZON_LINE.controllers		= { JAS_Bright[1],JAS_Bright[2],JAS_Bright[3],JAS_Bright[4],JAS_Bright[5],JAS_Bright[6],JAS_Bright[7],JAS_Bright[8],JAS_Bright[9],JAS_Bright[10],JAS_Bright[11],JAS_Bright[12],JAS_Bright[13],JAS_Bright[14],JAS_Bright[15], JAS_Bright[16],JAS_Bright[17],JAS_Bright[18],JAS_Bright[19],JAS_Bright[20]}
AddElement2(HORIZON_LINE)


local HORIZON_ALT_A           = create_mfd_tex(CENTER_DISPLAY_COLOR, 1512, 1887, 1571, 1960, 1)
HORIZON_ALT_A.name            = create_guid_string()
HORIZON_ALT_A.init_pos        = {0.30, 0.039}
HORIZON_ALT_A.parent_element  = HORIZON_LINE.name
HORIZON_ALT_A.h_clip_relation = h_clip_relations.DECREASE_IF_LEVEL
HORIZON_ALT_A.level           = MFD_DEFAULT_LEVEL + 1
-- HORIZON_ALT_A.element_params 	= {"RD_BRIGHTNESS"}
-- HORIZON_ALT_A.controllers		= { JAS_Bright[1],JAS_Bright[2],JAS_Bright[3],JAS_Bright[4],JAS_Bright[5],JAS_Bright[6],JAS_Bright[7],JAS_Bright[8],JAS_Bright[9],JAS_Bright[10],JAS_Bright[11],JAS_Bright[12],JAS_Bright[13],JAS_Bright[14],JAS_Bright[15], JAS_Bright[16],JAS_Bright[17],JAS_Bright[18],JAS_Bright[19],JAS_Bright[20]}
AddElement2(HORIZON_ALT_A)


green_text_param_with_rd_brightness(0.14, 0, "RAW_RALT", "%0.0f", HORIZON_ALT_A, {0.007, 0.007, 0, 0}, "Gripen_Font_HL_Green")


local HORIZON_LINE_FPM          = create_mfd_tex(CENTER_DISPLAY_COLOR, 1504, 1717, 1709, 1818, 2)
HORIZON_LINE_FPM.name           = create_guid_string()
HORIZON_LINE_FPM.init_pos       = {0, 0.043}
HORIZON_LINE_FPM.parent_element = HORIZON_LINE.name
HORIZON_LINE_FPM.element_params = {"ADI_ROLL", "VELVEC_HUD_Y", "VELVEC_HUD_X", "ADI_PITCH"}
HORIZON_LINE_FPM.controllers    = {{"rotate_using_parameter", 0, -1}, {"move_up_down_using_parameter", 1, 0.036}, {"move_left_right_using_parameter", 2, 0.036}, {"move_up_down_using_parameter", 3, -0.036}}
AddElement(HORIZON_LINE_FPM)

local GROUNDCOLLISION          = create_mfd_tex(CENTER_DISPLAY_COLOR, 1380, 145, 1680, 298, 1.5)
GROUNDCOLLISION.name           = create_guid_string()
GROUNDCOLLISION.init_pos       = {0, 0.023}
GROUNDCOLLISION.parent_element = HORIZON_LINE_FPM.name
GROUNDCOLLISION.element_params = {"PULLUPQUE", "ROLL_HUD", "VELVEC_HUD_Y", "CURRENT_PHASE_STATIONARY", "CURRENT_PHASE_PARKED", "CURRENT_PHASE_TAXI",
	"CURRENT_PHASE_TGR", "CURRENT_PHASE_ROT", "CURRENT_PHASE_TD", "CURRENT_PHASE_LR", "CURRENT_PHASE_PAL", "PULLMORE"}
GROUNDCOLLISION.controllers    = {{"parameter_in_range", 0, -10000, 0}, {"rotate_using_parameter", 1, 1.00},
	{"move_up_down_using_parameter", 2, 0.1}, {"parameter_compare_with_number", 3, 0}, {"parameter_compare_with_number", 4, 0},
	{"parameter_compare_with_number", 5, 0}, {"parameter_compare_with_number", 6, 0}, {"parameter_compare_with_number", 7, 0},
	{"parameter_compare_with_number", 8, 0}, {"parameter_compare_with_number", 9, 0}, {"parameter_compare_with_number", 10, 0}, {"parameter_in_range", 11, -0.99, 0.5}}
AddElement(GROUNDCOLLISION)