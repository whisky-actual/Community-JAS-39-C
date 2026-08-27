-- =============================
-- ========== RD Base ==========
-- =============================
addRDSimple("Main_RD_Pages", nil, nil, base) -- TODO: Add controllers for EMGY



addRDSimple("Clock_Parent", {.78, 1.335}, nil, "Main_RD_Pages", hcr.rw, nil) -- TODO: Clock should be smaller

local clockSeconds = addRDTextParam(
	nil, {.09}, nil, "Clock_Parent", nil, nil, nil, nil, "SECONDSTIME", nil, {"%02.0f"},
	strdefs.small
)
local clockComma = addRDText(nil, {.05}, nil, "Clock_Parent", nil, nil, nil, nil, ",", nil, strdefs.small)
copyElement(clockSeconds, {"init_pos", "element_params"}, {{0}, {"MINUTESTIME"}})
copyElement(clockComma, {"init_pos"}, {{-.035 * halfWidth}})
copyElement(clockSeconds, {"init_pos", "element_params"}, {{-.085 * halfWidth}, {"HOURTIME"}})



addRDSimple("CURS_Triangles", nil, nil, "Main_RD_Pages", nil, nil, nil, nil)


local SOIMarkW = .065 / 2
local SOIMarkUpperX = .98075 - SOIMarkW
local SOIMarkUpperY = .97625 * halfHeight / halfWidth
local SOIMarkLowerX = SOIMarkUpperX + .0025
local SOIMarkLowerY = -SOIMarkUpperY + .03775

local SOIMark = addRDMeshPoly(
	nil, {SOIMarkUpperX, SOIMarkUpperY}, {270}, "CURS_Triangles", hcr.rw, nil, nil, nil,
	{{-SOIMarkW, -SOIMarkW}, {-SOIMarkW, SOIMarkW}, {SOIMarkW, SOIMarkW}}, {0, 1, 2}, materials["MFDGreen"]
)
copyElement(SOIMark, {"init_pos", "init_rot"}, {{-SOIMarkUpperX * halfWidth, SOIMarkUpperY * halfWidth}, {0}})
copyElement(SOIMark, {"init_pos", "init_rot"}, {{SOIMarkLowerX * halfWidth, SOIMarkLowerY * halfWidth}, {180}})
copyElement(SOIMark, {"init_pos", "init_rot"}, {{(-SOIMarkLowerX + .008) * halfWidth, (SOIMarkLowerY - .0019) * halfWidth}, {90}})




local EMGYText = addRDText(nil, SK1, nil, "Main_RD_Pages", nil, nil, nil, nil, "E\nM\nG\nY", align.LC)

addRDTextBox(
	nil, {SK3[1] + TBOffsets.x3, SK3[2] + TBOffsets.y3}, nil, "Main_RD_Pages", nil, nil, nil, nil, nil,
	nil, nil, false, {"masterMode"}, {{ctrl.compareNum, 0, 1}}, "A/A"
)
addRDTextBox(
	nil, {SK3[1] + TBOffsets.x3, SK3[2]}, nil, "Main_RD_Pages", nil, nil, nil, nil, nil, nil,
	nil, false, {"masterMode"}, {{ctrl.compareNum, 0, 2}}, "A/S"
)
addRDTextBox(
	nil, {SK3[1] + TBOffsets.x3, SK3[2] - TBOffsets.y3}, nil, "Main_RD_Pages", nil, nil, nil, nil, nil,
	nil, nil, false, {"masterMode"}, {{ctrl.compareNum, 0, 3}}, "RCE"
)

copyElement(EMGYText, {"init_pos", "value"}, {{SK7[1] * halfWidth, SK7[2] * halfWidth}, "M\nE\nN\nU"})

addRDTextBox(
	nil, {SK6[1] + TBOffsets.x3 - .035, SK6[2]}, nil, "Main_RD_Pages", nil, nil, nil, nil, nil, nil,
	nil, true, nil, nil, "C\nU\nR\nS"
)



-- ==============================
-- ========== RDR Page ==========
-- ==============================
addRDSimple("RDR_Page", nil, nil, "Main_RD_Pages", nil, nil, {"RDPage"}, {{ctrl.compareNum, 0, 1}})



local INITText = copyElement(EMGYText, {"init_pos", "value", "parent_element"}, {{SK2[1] * halfWidth, SK2[2] * halfWidth}, "I\nN\nI\nT", "RDR_Page"})

addRDTextBox(
	nil, {SK4[1] + TBOffsets.x2, SK4[2] + TBOffsets.y4}, nil, "RDR_Page", nil, nil, nil, nil, nil,
	nil, nil, false, {"radarPRF"}, {{ctrl.compareNum, 0, 3}}, "XA"
)
addRDTextBox(
	nil, {SK4[1] + TBOffsets.x2, SK4[2] + TBOffsets.y4I}, nil, "RDR_Page", nil, nil, nil, nil, nil,
	nil, nil, false, {"radarPRF"}, {{ctrl.compareNum, 0, 3}}, "LR"
)
addRDTextBox(
	nil, {SK4[1] + TBOffsets.x2, SK4[2] - TBOffsets.y4I}, nil, "RDR_Page", nil, nil, nil, nil, nil,
	nil, nil, false, {"radarPRF"}, {{ctrl.compareNum, 0, 3}}, "MP"
)
addRDTextBox(
	nil, {SK4[1] + TBOffsets.x2, SK4[2] - TBOffsets.y4}, nil, "RDR_Page", nil, nil, nil, nil, nil,
	nil, nil, false, {"radarPRF"}, {{ctrl.compareNum, 0, 3}}, "LP" -- TODO: Make PRF control
)

copyElement(INITText, {"init_pos", "value"}, {{SK5[1] * halfWidth, SK5[2] * halfWidth}, "H\nR\nE\nS"})

addRDTextBox(
	nil, {SK7[1] + TBOffsets.x2 * 2, SK7[2] + .0275}, nil, "RDR_Page", nil, nil, nil, nil, nil,
	nil, nil, true, nil, nil, "R\nD\nR"
)

copyElement(INITText, {"init_pos", "value"}, {{SK8[1] * halfWidth, SK8[2] * halfWidth}, "SAVE"})

copyElement(INITText, {"init_pos", "value"}, {{SK9[1] * halfWidth, SK9[2] * halfWidth}, "XIMG"})

copyElement(INITText, {"init_pos", "value"}, {{SK10[1] * halfWidth, SK10[2] * halfWidth}, "FREZ"})

copyElement(INITText, {"init_pos", "value"}, {{SK11[1] * halfWidth, SK11[2] * halfWidth}, "ID"})

copyElement(INITText, {"init_pos", "value"}, {{SK12[1] * halfWidth, SK12[2] * halfWidth}, "CORR"})

addRDTextBox(
	nil, {SK14[1] + .015, SK14[2]}, nil, "RDR_Page", nil, nil, nil, nil, nil,
	nil, nil, true, nil, nil, "B\nS\nC\nP"
)
addRDTextBox(
	nil, {SK14[1] - TBOffsets.x2, SK14[2] + .035}, nil, "RDR_Page", nil, nil, nil, nil, nil,
	nil, nil, true, nil, nil, "P\nP\nI"
)

addRDTextBox(
	nil, {SK16[1] + .015, SK16[2]}, nil, "RDR_Page", nil, nil, nil, nil, nil,
	nil, nil, true, nil, nil, "S\nN\nS\nR"
)

copyElement(INITText, {"init_pos", "value"}, {{SK17[1] * halfWidth, SK17[2] * halfWidth}, "A\n/\nL"})

copyElement(INITText, {"init_pos", "value"}, {{SK18[1] * halfWidth, SK18[2] * halfWidth}, "G\nC\nS"})

copyElement(INITText, {"init_pos", "value"}, {{SK20[1] * halfWidth, SK20[2] * halfWidth}, "G\nR\nN\nD"})
addRDTextBox(
	nil, {SK20[1] - TBOffsets.x2, SK20[2] + .0275}, nil, "RDR_Page", nil, nil, nil, nil, nil,
	nil, nil, true, nil, nil, "A\nI\nR"
)



-- ========== Altitude scope ==========
-- Width: 628px = 2
-- Height: 837px
-- Altitude scope height from middle: 249px
local halfAltScpH = .516 / 2 -- TODO: Fix a more correct alt scope height
local halfAltScpW = 1.7 / 2
local altScpY = .8 + halfAltScpH -- TODO: Fix a more correct alt scope y pos
local altScpX = .0320366 / 2

local normLineThickness = lineThickness / halfWidth

local altScpBGH = halfAltScpH + normLineThickness
local altScpBGW = halfAltScpW + normLineThickness
local altScpBGTopW = 1.76201 / 2
local altScpSideLinesW = .01373

local altScpFullRangeDist = 1.5881
local altScpFullRangeX = -altScpBGW + altScpFullRangeDist
local halfAltScpHalfRangeX = -altScpBGW + .791762

addRDBox("Alt_Scope_BG", {altScpX, altScpY}, nil, "RDR_Page", nil, nil, nil, nil, altScpBGW * 2, altScpBGH * 2)
addRDSimpleLine(
	nil, {0, altScpBGH - normLineThickness / 2}, nil, "Alt_Scope_BG", nil, nil, nil, nil, nil,
	{{-altScpBGTopW}, {altScpBGTopW}}
)

addRDBox(
	"Alt_Scope", nil, nil, "Alt_Scope_BG", hcr.rw, lvls.mask, nil, nil, halfAltScpW * 2, halfAltScpH * 2,
	materials["MFDLightBlue"]
)

local tmpCounter = 0

for i = -2 / 3, 2 / 3, 1 / 3 do
	local longLine = tmpCounter == 1 or tmpCounter == 3

	addRDSimpleLine(
		nil, {-halfAltScpW - normLineThickness / 2, i * halfAltScpH}, nil, "Alt_Scope_BG", hcr.rw, nil, nil, nil, nil,
		longLine and {{-altScpSideLinesW}, {altScpSideLinesW}} or {{0}, {altScpSideLinesW}}
	)

	addRDSimpleLine(
		nil, {halfAltScpW + normLineThickness / 2, i * halfAltScpH}, nil, "Alt_Scope_BG", hcr.rw, nil, nil, nil, nil,
		longLine and {{-altScpSideLinesW}, {altScpSideLinesW}} or {{-altScpSideLinesW}, {0}}
	)

	tmpCounter = tmpCounter + 1
end

for i = 1, 7 do
	if i ~= 4 then
		addRDSimpleLine(
			nil, {-halfAltScpW - normLineThickness / 2 + i * (altScpFullRangeDist / 8), -altScpBGH}, nil, "Alt_Scope_BG", hcr.rw, nil, nil,
			nil, nil, (i % 2 == 0) and {{0}, {0, altScpSideLinesW * 2}} or {{0}, {0, altScpSideLinesW}}
		)
	end
end


local ownShipSize = 1.1

addRDSimpleLine( -- TODO: Fix ctrl.moveX multiplier so it works no matter the altitude scope height
	"Alt_Scope_Ownship", {-halfAltScpW, -halfAltScpH}, {270}, "Alt_Scope_BG", hcr.rw, nil, {"EMGY_ALTITUDE"},
	{{ctrl.moveX, 0, -altInFtGain}}, nil, {{0}, {-.019411 * ownShipSize, -.055 * ownShipSize}, {.019411 * ownShipSize, -.055 * ownShipSize}, {0}}, materials["black"]
)


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

		local scanHeight = math.tan(elevation) * (range * (altScpFullRangeDist / (halfAltScpW * 2.1)) * 6076.12 * .00000855) -- TODO: Fix the ....85 so it works no matter the altitude scope height

		addRDMeshPoly( -- TODO: Make sure it rotates correctly
			nil, nil, {90}, "Alt_Scope_Ownship", nil, lvls.mask, {"RDRFullRange", "SCAN_ZONE_VOLUME_ELEVATION", "RDRAntennaElSymb"},
			{{ctrl.compareNum, 0, range}, {ctrl.inRange, 1, (elevation) - .01, (elevation) + .01}, {ctrl.rotate, 2, 1}},
			{{0}, {halfAltScpW * 2.1, -scanHeight}, {halfAltScpW * 2.1, scanHeight}}, {0, 1, 2}, materials["MFDBeige"]
		)
	end
end

for i = 1, 2 do
	addRDSimpleLine( -- TODO: Fix so there isn't space between top and line, and setPoint muliplier to works no matter the altitude scope height, incl in Radar device
		nil, nil, {90}, "Alt_Scope_Ownship", nil, lvls.mask,
		i == 1 and {"RDRElLimUpperX", "RDRElLimUpperY"} or {"RDRElLimLowerX", "RDRElLimLowerY"}, {{ctrl.setPoint, 1, 0, 1, .155, .00000072}}
	)
end

addRDSimpleLine(
	nil, nil, {90}, "Alt_Scope_Ownship", hcr.rw, nil, nil, nil, nil, {{0}, {altScpFullRangeDist / 16}},
	materials["black"]
)


addRDBox("Alt_Scope_Full_Range", {altScpFullRangeX}, nil, "Alt_Scope_BG", nil, lvls.mask, nil, nil, nil, altScpBGH * 2)
addRDTextParam(
	nil, {.01, .03 - altScpBGH}, nil, "Alt_Scope_Full_Range", nil, lvls.mask, nil, nil, "RDRFullRange",
	align.LC
)

addRDBox("Alt_Scope_Half_Range", {halfAltScpHalfRangeX}, nil, "Alt_Scope_BG", nil, lvls.mask, nil, nil, nil, altScpBGH * 2)
addRDTextParam(
	nil, {.01, .03 - altScpBGH}, nil, "Alt_Scope_Half_Range", nil, lvls.mask, nil, nil, "RDRHalfRange",
	align.LC
)



-- ========== Information segment ==========



-- ========== Bscope ==========

local scpSize = 1.6 / 2
local halfScpW = 0.8 / 2
local scpX = 0
local scpY = -0.4
local scpBG = scpSize + normLineThickness
local scpBGTopW = scpBG + .05 

local scpFullRangeDist = scpSize * 2

addRDBox("Scope_BG", {scpX, scpY}, nil, "RDR_Page", nil, nil, nil, nil, scpBG * 2, scpBG * 2)
addRDSimpleLine(
	nil, {0, scpBG - normLineThickness / 2}, nil, "Scope_BG", nil, nil, nil, nil, nil,
	{{-scpBGTopW}, {scpBGTopW}}
)

addRDBox(
	"Scope", nil, nil, "Scope_BG", hcr.rw, lvls.mask, nil, nil, scpSize * 2, scpSize * 2,
	materials["MFDLightBlue"]
)
addRDBox("scanbox", {0, 0}, nil, "Scope_BG", hcr.rw, lvls.mask, nil, nil, scpSize * 1, scpSize * 2, materials["MFDBeige"])



-- Side azimuth tick marks from alt scope
local tmpCounter = 0
for i = -2 / 3, 2 / 3, 1 / 3 do
	local longLine = tmpCounter == 1 or tmpCounter == 3

	addRDSimpleLine(
		nil, {-scpSize - normLineThickness / 2, i * scpSize}, nil, "Scope_BG", hcr.rw, nil, nil, nil, nil,
		longLine and {{-altScpSideLinesW}, {altScpSideLinesW}} or {{0}, {altScpSideLinesW}}
	)

	addRDSimpleLine(
		nil, {scpSize + normLineThickness / 2, i * scpSize}, nil, "Scope_BG", hcr.rw, nil, nil, nil, nil,
		longLine and {{-altScpSideLinesW}, {altScpSideLinesW}} or {{-altScpSideLinesW}, {0}}
	)

	tmpCounter = tmpCounter + 1
end

-- Range tick marks along the bottom (range = 0 at bottom, increasing upward)
for i = 1, 7 do
	if i ~= 4 then
		addRDSimpleLine(
			nil, {-scpSize - normLineThickness / 2 + i * (scpFullRangeDist / 8), -scpBG}, nil, "Scope_BG", hcr.rw, nil, nil,
			nil, nil, (i % 2 == 0) and {{0}, {0, altScpSideLinesW * 2}} or {{0}, {0, altScpSideLinesW}}
		)
	end
end

-- Range labels, now as horizontal bands stacked vertically instead of side-by-side bars

local scpRangeMargin = .1 

local scpFullRangeY = scpSize - scpRangeMargin
local scpHalfRangeY = -scpBG + ((scpFullRangeY - (-scpBG)) / 2)
addRDBox("Scope_Full_Range", {0, scpFullRangeY}, nil, "Scope_BG", nil, lvls.mask, nil, nil, scpBG * 2, normLineThickness * 1)
addRDTextParam(
	nil, {.01 - scpBG, .03}, nil, "Scope_Full_Range", nil, lvls.mask, nil, nil, "RDRFullRange",
	align.LC
)

addRDBox("Scope_Half_Range", {0, scpHalfRangeY}, nil, "Scope_BG", nil, lvls.mask, nil, nil, scpBG * 2, normLineThickness * 1)
addRDTextParam(
	nil, {.01 - scpBG, .03}, nil, "Scope_Half_Range", nil, lvls.mask, nil, nil, "RDRHalfRange",
	align.LC
)

-- ========== PPI scope ==========



-- ========== Contacts ==========
-- local AirContactScale = (.025 * width) / 2
local cursorGain = .08292
local altScpRangeGain = 396.75
local ScpRangeGain = 0.2
local ScpAzimuthGain = 3
local bsXGain = 0.043
local bsYGain = 0.012

local normContactScale = .025
local prioContactScale = (.03 * width) / 2
-- prifContactScale = AirContactScale
-- normContactScale = prifContactScale * .75


local houseVerts = {{-normContactScale, normContactScale}, {normContactScale, normContactScale}, {normContactScale, -normContactScale}, {-normContactScale, -normContactScale}, {0, normContactScale * 2}}
local BhouseVerts = {{-normContactScale, normContactScale}, {normContactScale, normContactScale}, {normContactScale, -normContactScale}, {-normContactScale, -normContactScale}, {0, normContactScale * 2}}
local houseInds = {0, 4, 1, 0, 1, 2, 0, 2, 3}
local RWRLineThickness = .007



local function makeCircle(radius, segments)
	local verts = {{0, 0}} -- center point, needed for the triangle fan
	local inds = {}

	for i = 0, segments do
		local angle = (i / segments) * 2 * math.pi
		table.insert(verts, {math.cos(angle) * radius, math.sin(angle) * radius})
	end

	for i = 1, segments do
		table.insert(inds, 0)
		table.insert(inds, i)
		table.insert(inds, i + 1)
	end

	return verts, inds
end

local circleVerts, circleInds = makeCircle(normContactScale, 12)
local bcircleVerts, bcircleInds = makeCircle(normContactScale, 12)


local function copyVerts(verts)
	local copy = {}

	for i, vert in ipairs(verts) do
		copy[i] = {vert[1], vert[2]}
	end

	for i = #verts, 1, -1 do
		verts[i] = nil
	end

	return copy
end




local function createFriendlyContact(n)
	local i
	local contactSTR

	if n < 10 then
		i = "_0" .. n .. "_"
	else
		i = "_" .. n .. "_"
	end

	contactSTR = "RADAR_CONTACT" .. i

	--[[
	local contact           = CreateElement "ceMeshPoly"
	contact.primitivetype   = "triangles"
	contact.name            = create_guid_string()
	contact.material        = MakeMaterial(nil, {25, 100, 25, 255})
	contact.parent_element  = ContactBase.name
	contact.vertices        = houseVerts
	contact.indices         = houseInds
	contact.init_pos        = {0, 0}
	contact.element_params  = {"RADAR_CONTACT" .. i .. "RDX", "RADAR_CONTACT" .. i .. "RDY", "RADAR_CONTACT" .. i .. "TIME", "RADAR_CONTACT" .. i .. "relHdg"}
	contact.controllers     = {{"move_left_right_using_parameter", 0, cursorGain}, {"move_up_down_using_parameter", 1, cursorGain}, {"parameter_in_range", 2, 0, 3.1}, {"rotate_using_parameter", 3, 1}}
	contact.use_mipfilter   = true
	contact.additive_alpha  = false
	contact.change_opacity  = false
	contact.h_clip_relation = h_clip_relations.REWRITE_LEVEL
	contact.level           = MFD_DEFAULT_LEVEL
	Add(contact)

	local altReadout           = green_text_param_with_cd_brightness(0, -.06, "RADAR_CONTACT" .. i .. "altK", "%.0f", contact, {.005, .005, 0, 0}, "Gripen_Font_HL_Green")
	altReadout.h_clip_relation = h_clip_relations.REWRITE_LEVEL
	altReadout.level           = MFD_DEFAULT_LEVEL

	local contactVelvec          = CreateElement "ceSimpleLineObject"
	contactVelvec.name           = create_guid_string()
	contactVelvec.material       = MakeMaterial(nil, {25, 100, 25, 255})
	contactVelvec.parent_element = contact.name
	contactVelvec.width          = RWRLineThickness / 2
	contactVelvec.vertices       = {{0}, {0}}
	contactVelvec.element_params = {"RADAR_CONTACT" .. i .. "RDVelvec", "ONE"}
	contactVelvec.controllers    = {{"line_object_set_point_using_parameters", 1, 1, 0, 0, cursorGain}}
	AddElement(contactVelvec)
	]]--



	addRDMeshPoly(
		"Alt_Scope_Contact" .. i, {-halfAltScpW, -halfAltScpH}, nil, "Alt_Scope", hcr.rw, nil,
		{contactSTR .. "altScpRange", contactSTR .. "alt", contactSTR .. "pitch", contactSTR .. "FRIENDLY"},
		{{ctrl.moveX, 0, altScpRangeGain}, {ctrl.moveY, 1, altInFtGain}, {ctrl.rotate, 2, 1}, {ctrl.compareNum, 3, 1}}, copyVerts(houseVerts), houseInds, materials["MFDGreen"]
	)
	addRDSimpleLine(
		nil, nil, nil, "Alt_Scope_Contact" .. i, hcr.rw, nil, {contactSTR .. "altScpVelvec", "ONE"},
		{{ctrl.setPoint, 1, 1, 0, 0, altScpRangeGain}}, nil, nil, materials["MFDGreen"]
	)

	addRDMeshPoly(
		"B_Scope_Contact" .. i, {0, -scpSize}, nil, "Scope_BG", hcr.rw, nil,
		{contactSTR .. "BSX", contactSTR .. "BSY", contactSTR .. "FRIENDLY", contactSTR .. "isFresh"},
		{{ctrl.moveX, 0, 0.08}, {ctrl.moveY, 1, 0.08}, {ctrl.compareNum, 2, 1}, {ctrl.compareNum, 3, 1}},
		copyVerts(houseVerts), houseInds, materials["MFDGreen"]
	)
	addRDSimpleLine(
	nil, nil, nil, "B_Scope_Contact" .. i, hcr.rw, nil, {contactSTR .. "BSHdg"},
	{{ctrl.rotate, 0, 1}}, nil, {{0, 0}, {0, .06}}, materials["MFDGreen"]
	)

	
	--[[
	




	local altScpPrio1Line           = CreateElement "ceSimpleLineObject"
	altScpPrio1Line.name            = create_guid_string()
	altScpPrio1Line.material        = MakeMaterial(nil, {0, 0, 0, 255})
	altScpPrio1Line.parent_element  = RDRAltScpBg.name
	altScpPrio1Line.width           = lineThickness / 2
	altScpPrio1Line.vertices        = {{0, -altScpBgH + lineThickness}, {0, altScpBgH - lineThickness}}
	-- altScpPrio1Line.element_params  = {"RADAR_CONTACT" .. i .. "altScpVelvec", "ONE"}
	-- altScpPrio1Line.controllers     = {{"line_object_set_point_using_parameters", 1, 1, 0, 0, cursorGain}}
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





	local altScpContact           = CreateElement "ceMeshPoly"
	altScpContact.primitivetype   = "triangles"
	altScpContact.name            = create_guid_string()
	altScpContact.material        = MakeMaterial(nil, {25, 100, 25, 255})
	altScpContact.parent_element  = RDRAltScp.name
	altScpContact.vertices        = houseVerts
	altScpContact.indices         = houseInds
	altScpContact.init_pos        = {-halfAltScpW, -halfAltScpH}
	altScpContact.element_params  = {"RADAR_CONTACT" .. i .. "altScpRange", "RADAR_CONTACT" .. i .. "alt", "RADAR_CONTACT" .. i .. "TIME", "RADAR_CONTACT" .. i .. "pitch"}
	altScpContact.controllers     = {{"move_left_right_using_parameter", 0, altScpRangeGain}, {"move_up_down_using_parameter", 1, altInFtGain}, {"parameter_in_range", 2, 0, 3.1}, {"rotate_using_parameter", 3, 1}}
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
	altScpContactVelvec.controllers     = {{"line_object_set_point_using_parameters", 1, 1, 0, 0, altScpRangeGain}}
	altScpContactVelvec.h_clip_relation = h_clip_relations.REWRITE_LEVEL
	altScpContactVelvec.level           = MFD_DEFAULT_LEVEL
	Add(altScpContactVelvec)
	--]]
end

local function createThreatContact(n)
	local i
	local enemycontactSTR

	if n < 10 then
		i = "_0" .. n .. "_"
	else
		i = "_" .. n .. "_"
	end

	enemycontactSTR = "RADAR_CONTACT" .. i

	-- Alt scope

	addRDMeshPoly(
		"Alt_Scope_Enemy" .. i, {-halfAltScpW, -halfAltScpH}, nil, "Alt_Scope", hcr.rw, nil,
		{enemycontactSTR .. "altScpRange", enemycontactSTR .. "alt", enemycontactSTR .. "FRIENDLY"},
		{{ctrl.moveX, 0, altScpRangeGain}, {ctrl.moveY, 1, altInFtGain}, {ctrl.compareNum, 2, 0}},
		copyVerts(circleVerts), circleInds, materials["red"]
	)






	--[[addRDMeshPoly(
		"Alt_Scope_Enemy" .. i, {0, -scpSize}, nil, "Scope_BG", hcr.rw, nil,
		{contactSTR .. "altScpRange", contactSTR .. "alt", contactSTR .. "FRIENDLY"},
		{{ctrl.moveX, 1, altScpRangeGain}, {ctrl.moveY, 0, altInFtGain}, {ctrl.compareNum, 2, 0}},
		circleVerts, circleInds, materials["MFDRed"]
	)]]

	-- B-scope
	addRDMeshPoly(
		"B_Scope_Enemy" .. i, {0, -scpSize}, nil, "Scope_BG", hcr.rw, nil,
		{enemycontactSTR .. "BSX", enemycontactSTR .. "BSY", enemycontactSTR .. "FRIENDLY"},
		{{ctrl.moveX, 0, 0.12}, {ctrl.moveY, 1, 0.08}, {ctrl.compareNum, 2, 0}},
		copyVerts(bcircleVerts), circleInds, materials["red"]
	)
	addRDSimpleLine(
	nil, nil, nil, "B_Scope_Enemy" .. i, hcr.rw, nil, {enemycontactSTR .. "BSHdg"},
	{{ctrl.rotate, 0, 1}}, nil, {{0, 0}, {0, .06}}, materials["red"]
	)

end

for n = 1, 99 do
	createFriendlyContact(n)
	createThreatContact(n)
end



-- ========== radar cursor ==========

addRDMeshPoly(
	nil, {0, -scpSize}, nil, "Scope_BG", hcr.rw, nil, {"Cursor_Y", "Cursor_X"},
	{{ctrl.moveY, 0, 0.079}, {ctrl.moveX, 1, 0.083}},
	{{-.004, -.07}, {.004, -.07}, {-.004, -.02}, {.004, -.02}, {-.004, .02}, {.004, .02}, {-.004, .07}, {.004, .07}, {-.004, -.004}, {.004, -.004}, {-.004, .004}, {.004, .004}, {-.074, -.004},
		{-.018, -.004}, {-.074, .004}, {-.018, .004}, {.074, .004}, {.018, .004}, {.074, -.004}, {.018, -.004}
	}, {0, 1, 2, 3, 2, 1, 4, 5, 6, 7, 6, 5, 8, 9, 10, 11, 10, 9, 12, 13, 14, 15, 14, 13, 16, 17, 18, 19, 18, 17}, materials["black"]
)

