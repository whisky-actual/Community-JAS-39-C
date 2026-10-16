addHUDSimple("Moving_Sides", nil, nil, "HUD_Base", nil, nil, {"HUDSidesX", "HUDSidesY"}, {{ctrl.moveX, 0, mult}, {ctrl.moveY, 1, mult}})


local leftSideX = -d2Mr(7.767) -- Distance from the velvec/center to the right most element (ex: landing speed) of the speed tape column
local leftSideWidth = d2Mr(2.75)
local leftSideHeight = d2Mr(8.5)

addHUDBox( -- TODO: Make this clip out from the HUD Sphere
	"Left_Side", {leftSideX - leftSideWidth / 2}, nil, "Moving_Sides", nil, nil, {"HUDDeclutt"}, {{ctrl.compareNum, 0, 0}}, leftSideWidth,
	leftSideHeight, materials.HUDMask, true
)

addHUDText("AoA_@", {-17, 65}, "Left_Side", nil, nil, nil, nil, "@", nil, HUDStrdefs.alpha)
addHUDTextParam("AoA_Readout", {20, -1}, "AoA_@", nil, nil, nil, nil, "AoA", align.RC)

addHUDText("G_G", {-17, 50}, "Left_Side", nil, nil, nil, nil, "G")
addHUDTextParam(
	"G_Readout", {12}, "G_G", nil, nil, nil, nil, "CUR_G", align.LC,
	{"%.1f"}
)


local speedTapeHeight = d2Mr(5)
local speedTapeWidth = d2Mr(.7)

addHUDBox(
	"Speed_Tape_Mask", {leftSideWidth / 2 - speedTapeWidth / 2}, nil, "Left_Side", hcr.inc, HUDLvls.mask, nil, nil, speedTapeWidth,
	speedTapeHeight, materials.HUDMask2, true
)

addHUDSimpleLine(
	"Speed_Tape_Arrow", {-1}, nil, "Speed_Tape_Mask", nil, HUDLvls.mask, nil, nil, nil,
	{{-speedTapeWidth / 2, 3.25}, {0}, {-speedTapeWidth / 2, -3.25}}
)

addHUDSimpleLine(
	"Speed_Tape_Accelerate_Ind", {-speedTapeWidth / 2 + .25, 2.75}, nil, "Speed_Tape_Mask", nil, HUDLvls.mask, {"ONE", "ACC"},
	{{ctrl.inRange, 1, 0, 999}, {ctrl.setPoint, 1, 0, 1, 0, .0001203}}, nil, nil
)
addHUDSimpleLine(
	"Speed_Tape_Decelerate_Ind", {-speedTapeWidth / 2 + .25, -2.75}, nil, "Speed_Tape_Mask", nil, HUDLvls.mask, {"ONE", "DEACC"},
	{{ctrl.inRange, 1, 0, 999}, {ctrl.setPoint, 1, 0, 1, 0, -.0001203}}, nil, nil
)


addHUDSimple("Speed_Tape_Line_Base", nil, nil, "Speed_Tape_Mask", nil, nil, {"CAS"}, {{ctrl.moveY, 0, -.0001203}})

local speedTapeUpperLine = addHUDSimpleLine(
	nil, nil, nil, "Speed_Tape_Line_Base", nil, HUDLvls.mask, {"transonicUpper"},
	{{ctrl.moveY, 0, .0001203}}, nil, {{0, -.5}, {0, 200}}
)
addHUDSimpleLine(
	"Speed_Tape_Lower_Mask", nil, nil, "Speed_Tape_Line_Base", hcr.incIf, HUDLvls.mask, nil, nil,
	.6, {{0, -.5}, {0, -999}}, materials.HUDMask3, true
)
copyElement(speedTapeUpperLine, {"element_params", "vertices"}, {{"transonicLower", "HUDBrightness"}, {{0, -200}, {0}}})


for i = 0, 28, 1 do
	addHUDSimpleLine(
		"Speed_Tape_Mark_" .. i, {0, i * 10}, nil, "Speed_Tape_Line_Base", nil, HUDLvls.mask, nil, nil, nil,
		{{0}, {-speedTapeWidth / 4}}
	)
end

-- addHUDSimpleLine(
-- "Speed_Tape_Min_Speed", {0, -44.84}, nil, "Speed_Tape_Line_Base", hcr.decIf, HUDLvls.mask, nil, nil, .46,
-- {{0, 0}, {2.3, 0}, {4.6, 0}, {4.6, 4.6}}
-- )
-- addHUDSimpleLine(
-- "Speed_Tape_L_Speed", {0, -64.9}, nil, "Speed_Tape_Line_Base", hcr.decIf, HUDLvls.mask, {"ROTATE_SPEED"}, {{ctrl.moveY, 1, .0001203}},
-- .46, {{0, 0}, {2.3, 0}, {4.6, 0}, {4.6, 4.6}}
-- )


addHUDTextParam("CAS_Readout", {-(speedTapeWidth / 2 + 2.5)}, "Speed_Tape_Mask", nil, nil, nil, nil, "textCAS", align.RC)

addHUDText(
	"AT_Ind", {2, 10}, "CAS_Readout", nil, nil, {"AUTOTHROTTLE_ONOFF"},
	{{ctrl.inRange, 0, .9, 1.1}}, "AT  ", align.RC
)
local AT12 = addHUDText(
	nil, {-2}, "AT_Ind", nil, nil, {"AUTOTHROTTLE_MODE"},
	{{ctrl.inRange, 0, .4, .6}}, "  12", align.RC
)
copyElement(AT12, {"controllers", "value"}, {{{ctrl.inRange, 0, .8, 1.1}}, "  14"})


addHUDText("Mach_M", {-17, -53}, "Left_Side", nil, nil, {"machDecimals"}, {{ctrl.inRange, 0, 1, 999}}, "M")
addHUDTextParam(
	"Mach_Whole_Readout", {5.14}, "Mach_M", nil, nil, {"machWhole"}, {{ctrl.inRange, 0, .995, 9}}, "machWhole",
	align.LC, {"%.2f"}
)
addHUDText("Mach_Comma", {13.07}, "Mach_M", nil, nil, {"machDecimals"}, {{ctrl.inRange, 0, 1, 99.5}}, ".")
addHUDTextParam("Mach_Dec_Readout", {3}, "Mach_Comma", nil, nil, nil, nil, "machDecimals", align.LC, {"%.0f"})

addHUDText(
	"GS_GS", {-17, -64}, "Left_Side", nil, nil, {"weaponsMode", "CURRENT_PHASE"}, {{ctrl.compareNum, 0, -1}, {ctrl.inRange, 1, 6.9, 8.9}},
	"GS"
)
addHUDTextParam("GS_Readout", {30.5}, "GS_GS", nil, nil, nil, nil, "txtGS", align.RC)
























local rightSideX = d2Mr(7.767) -- Distance from the velvec/center to the right most element (ex: landing speed) of the speed tape column
local rightSideWidth = d2Mr(2.75)
local rightSideHeight = d2Mr(8.5) -- Change to be more accurate

addHUDBox( -- TODO: Make this clip out from the HUD Sphere
	"Right_Side", {rightSideX + rightSideWidth / 2}, nil, "Moving_Sides", nil, nil, {"HUDDeclutt"}, {{ctrl.compareNum, 0, 0}},
	rightSideWidth, rightSideHeight, materials.HUDMask, true
)


local altitudeTapeHeight = d2Mr(5)
local altitudeTapeWidth = rightSideWidth
local altitudeTapeMult = -altitudeTapeHeight * .0006

addHUDBox(
	"Altitude_Tape_Mask", {altitudeTapeWidth / 2 - rightSideWidth / 2}, nil, "Right_Side", hcr.inc, HUDLvls.mask, {"altitudeDeclutt"},
	{{ctrl.compareNum, 0, 0}}, altitudeTapeWidth, altitudeTapeHeight, materials.HUDMask2, true
)

addHUDSimpleLine(
	"Altitude_Tape_Arrow", {-18.5}, nil, "Altitude_Tape_Mask", nil, HUDLvls.mask, nil, nil, nil,
	{{-speedTapeWidth / 2, 3.25}, {0}, {-speedTapeWidth / 2, -3.25}}
)
addHUDTextParam("Alt_Tape_Alt_Readout", {-8}, "Altitude_Tape_Arrow", nil, nil, {"HUDAltReadoutShow"}, {{ctrl.compareNum, 0, 1}}, "HUDAltReadout", align.RC)

addHUDSimple(
	"Altitude_Tape_Moving_Base", nil, nil, "Altitude_Tape_Mask", nil, HUDLvls.mask, {"altTape"},
	{{ctrl.moveY, 0, -0}}
)

-- addHUDText(
-- "Altitude_Tape_Terrain_Height", {-18.5, -2.3}, "Altitude_Tape_Moving_Base", nil, HUDLvls.mask, {"altMode", "terrainAlt"},
-- {{ctrl.compareNum, 0, 1}, {ctrl.moveY, 1, .000175659}}, "77", nil, HUDStrdefs.seventyseven
-- )

for i = 1, 2 do
	local zeroAltLine = addHUDSimpleLine(
		nil, {-17}, nil, "Altitude_Tape_Moving_Base", nil, i == 1 and HUDLvls.mask, {"zeroAltLine"}, {{ctrl.moveY, 0, altitudeTapeMult}},
		nil, {{0}, {6.5}}
	)
	addHUDBox(
		"Altitude_Tape_Zero_Altitude_Vertical_Line", nil, nil, zeroAltLine, nil, i == 1 and HUDLvls.mask, nil, nil, 1,
		5
	)
	addHUDText("Altitude_tape_Zero_Text", {8}, zeroAltLine, nil, i == 1 and HUDLvls.mask, nil, nil, "0", align.LC)
end

for i = 1, 9 do
	addHUDSimple(
		"Alt_Tape_Line_" .. i .. "_Base", {-17}, nil, "Altitude_Tape_Mask", nil, nil, {"HUDAltLineY_" .. i},
		{{ctrl.moveY, 0, -altitudeTapeMult}}
	)

	addHUDSimpleLine(
		"Alt_Tape_Line_" .. i .. "_Long", nil, nil, "Alt_Tape_Line_" .. i .. "_Base", nil, HUDLvls.mask, {"HUDAltLineIsShort_" .. i},
		{{ctrl.compareNum, 0, 0}}, nil, {{0}, {6.5}}
	)
	addHUDSimpleLine(
		"Alt_Tape_Line_" .. i .. "_Short", nil, nil, "Alt_Tape_Line_" .. i .. "_Base", nil, HUDLvls.mask, {"HUDAltLineIsShort_" .. i},
		{{ctrl.compareNum, 0, 1}}, nil, {{0}, {6.5 / 2}}
	)

	addHUDTextParam(
		"Alt_Tape_" .. i .. "_Text_Thousands_L", {21}, "Alt_Tape_Line_" .. i .. "_Base", nil, HUDLvls.mask, {"HUDAltLineTextKAvail_" .. i},
		{{ctrl.compareNum, 0, 1}}, "HUDAltLineTextKL_" .. i, align.RC
	)
	addHUDTextParam(
		"Alt_Tape_" .. i .. "_Text_Thousands_S", {-32.5, -1.55}, "Alt_Tape_" .. i .. "_Text_Thousands_L", nil, HUDLvls.mask, nil, nil,
		"HUDAltLineTextKS_" .. i, align.LC, {"%s"}, HUDStrdefs.hundreds
	)
end
-- TODO: 
-- Fix text <1000 ft
-- Add 77 - dissapears if RALT >= 30 000 ft
-- Add runway altitude box for future functionality.
-- If in landing mode - show altitude readout under 10 000 ft, 100 ft resolution? (check panda vid)
-- Fix alt tape height, seems to be unevevn (larger above arrow)


-- local hundredsOffsetY = -1.75
--
-- for i = 1, 3 do
-- local longAltLine = copyElement(zeroAltLine, {"element_params", "controllers"}, {{"HMDShortAltLine_" .. i, "HUDBrightness"}, {{ctrl.moveY, 0, .000175659}}})
--
-- copyElement(longAltLine, {"element_params", "vertices"}, {{"HMDShortAltLine_" .. i, "HUDBrightness"}, {{0}, {3.25}}})
--
-- addHUDTextParam(nil, {10}, longAltLine, nil, HUDLvls.mask, nil, nil, "HMDAltBig_" .. i, align.LC)
-- addHUDTextParam(
-- nil, {-21.5, hundredsOffsetY}, longAltLine, nil, HUDLvls.mask, {"HMDAltBig_" .. i, "HMDAltSmallStr_" .. i},
-- {{ctrl.inRange, 0, 9, 100}, {ctrl.inRange, 1, -.1, 9.1}}, "HMDAltSmall_" .. i, align.LC, {"%s"}, HUDStrdefs.hundreds
-- )
-- addHUDTextParam(
-- nil, {-29, hundredsOffsetY}, longAltLine, nil, HUDLvls.mask, {"HMDAltBig_" .. i, "HMDAltSmallStr_" .. i, "HMDAltSmall_" .. i},
-- {{ctrl.inRange, 0, 0, 10}, {ctrl.inRange, 1, -.1, 9.1}, {ctrl.text, 2}}, nil, align.LC, {"%s"}, HUDStrdefs.hundreds
-- )
-- end


--[[
addHUDText(
	"Alt_Mode_Ind", {.58 * fov2MilRad, -.5 * fov2MilRad}, "Moving_Sides", nil, nil, {"altMode", "RadarAltAvail", "HUDDeclutt", "ALT_77"},
	{{ctrl.inRange, 0, 1.9, 2.1}, {ctrl.inRange, 1, .9, 1.1}, {ctrl.compareNum, 2, 0}, {ctrl.moveY, 3, .00001}}, "77", nil, HUDStrdefs.seventyseven
)


addHUDSimple(
	"Alt_Tape_Base", {0, 173}, nil, "Moving_Sides", nil, nil, {"ALTITUDE_HUD", "HUDDeclutt"},
	{{ctrl.moveY, 0, -.00020944}, {ctrl.compareNum, 1, 0}}
)

addHUDTextParam(
	"Ralt_Readout", {.528 * fov2MilRad, -.282 * fov2MilRad}, "Moving_Sides", hcr.rw, nil, {"TEXT_RALT", "HUDDeclutt", "altMode"},
	{{ctrl.inRange, 0, 0, 10000}, {ctrl.compareNum, 1, 0}, {ctrl.compareNum, 2, 2}}, "TEXT_RALT", align.RC
)


local thousandsOffsetX = .655 * fov2MilRad
local thousandsOffsetY = -1 * fov2MilRad

local hundredsOffsetX = .72 * fov2MilRad
local hundredsOffsetY = -1.0075 * fov2MilRad
local altLineOffset = .15 * fov2MilRad
-- local altTextOffset = .149955
local altTextOffset = math.rad(2) * 1000

local counter = -1
local hundreds = 0
local Thousands = 0

for i = 0, 810 do
	-- AltitudeLine 						= CreateElement "ceMeshPoly"
	-- AltitudeLine.name 					= create_guid_string()
	-- AltitudeLine.primitivetype 			= "triangles"
	-- AltitudeLine.vertices				= {{-headinglineThickness, hdgLineHeight}, {headinglineThickness, hdgLineHeight}, {headinglineThickness, 0}, {-headinglineThickness, 0}}
	-- AltitudeLine.material				= MakeMaterial(nil,{0, 255, 0,255})
	-- AltitudeLine.indices				= {0,1,2 , 0,2,3}
	-- AltitudeLine.init_pos				= { 0, altTextOffset * i }	-- placing segments as a function of iteration step
	-- AltitudeLine.init_rot				= {90, 0 , 0}	
	-- AltitudeLine.h_clip_relation		= h_clip_relations.INCREASE_IF_LEVEL--DECREASE_IF_LEVEL  	--INCREASE_IF_LEVEL
	-- AltitudeLine.level  		 		= HUD_DEFAULT_LEVEL --+ 1
	-- AltitudeLine.use_mipfilter			= true
	-- AltitudeLine.additive_alpha			= true
	-- AltitudeLine.collimated				= true
	-- AltitudeLine.parent_element			= "Alt_Tape_Base".name
	-- AltitudeLine.blend_mode 			= blend_mode.IBM_REGULAR_ADDITIVE_ALPHA
	-- AltitudeLine.ScreenType				= Stype
	-- AltitudeLine.element_params			= {"HUDBrightness"}
	-- AltitudeLine.controllers			= {{ctrl.opacity ,0}}	
	-- Add(AltitudeLine)

	counter = counter + 1

	if counter == 10 then
		counter = 0
		Thousands = Thousands + 1
	end

	hundreds = counter

	if Thousands < 1 then
		if hundreds == 0 then
			addHUDText(
				"Hundreds_" .. hundreds, {hundredsOffsetX, hundredsOffsetY + i * altTextOffset, 0.1}, "Alt_Tape_Base", hcr.decIf, HUDLvls.mask, nil,
				nil, hundreds
			)
		else
			addHUDText(
				"Hundreds_" .. hundreds .. "00", {hundredsOffsetX, hundredsOffsetY + i * altTextOffset, 0.1}, "Alt_Tape_Base", hcr.decIf, HUDLvls.mask, nil,
				nil, hundreds
			)
		end
	elseif Thousands >= 1 and Thousands < 10 then
		local hundredsOffsetX = .705 * fov2MilRad

		addHUDText(
			"Thousands_" .. Thousands, {thousandsOffsetX, thousandsOffsetY + i * altTextOffset, 0.1}, "Alt_Tape_Base", hcr.decIf, HUDLvls.mask, nil,
			nil, Thousands
		)

		addHUDText(
			"Hundreds_2_" .. hundreds .. "00", {hundredsOffsetX, hundredsOffsetY + i * altTextOffset, 0.1}, "Alt_Tape_Base", hcr.decIf, HUDLvls.mask, nil,
			nil, hundreds .. "00", nil, HUDStrdefs.altitudeSmall
		)
	else
		local hundredsOffsetX = .725 * fov2MilRad

		addHUDText(
			"Thousands_2_" .. Thousands, {thousandsOffsetX, thousandsOffsetY + i * altTextOffset, 0.1}, "Alt_Tape_Base", hcr.decIf, HUDLvls.mask, nil,
			nil, Thousands
		)

		addHUDText(
			"Hundreds_3_" .. hundreds .. "00", {hundredsOffsetX, hundredsOffsetY + i * altTextOffset, 0.1}, "Alt_Tape_Base", hcr.decIf, HUDLvls.mask, nil,
			nil, hundreds .. "00", nil, HUDStrdefs.altitudeSmall
		)
	end
end

addHUDSimple(
	"Terrain_Alt_Box", {.68 * fov2MilRad, -.62 * fov2MilRad}, nil, "Moving_Sides", nil, nil, {"ALTITUDE_HUD", "HUDDeclutt"},
	{{ctrl.inRange, 0, 1000, 81000}, {ctrl.compareNum, 1, 0}}
)
-- local TerrainAltitudeBox          = Hud_Horizon_Line(HUD_HORIZON, 1861, 969, 2296, 1116, .8 * fov2MilRad)
-- TerrainAltitudeBox.name           = create_guid_string()
-- TerrainAltitudeBox.init_pos       = {.68 * fov2MilRad, -.62 * fov2MilRad, 0}
-- TerrainAltitudeBox.init_rot       = {0, 0, 0}
-- TerrainAltitudeBox.parent_element = "Moving_Sides"
-- TerrainAltitudeBox.element_params = {"HUDBrightness", "ALTITUDE_HUD", "HUDDeclutt"}
-- TerrainAltitudeBox.controllers    = {{ctrl.opacity, 0}, {ctrl.inRange, 1, 1000, 81000}, {ctrl.compareNum, 2, 0}}
-- AddHudElement(TerrainAltitudeBox)

addHUDTextParam("Terrain_Alt_Readout", {0, .028}, "Terrain_Alt_Box", nil, nil, nil, nil, "TERRAIN_ALT")


addHUDSimple("Alt_A2G_Base", {.65 * fov2MilRad}, nil, "Moving_Sides", nil, nil, {"weaponsMode"}, {{ctrl.compareNum, 0, 4}})

addHUDText("Alt_A2G_A", {0, -.1 * fov2MilRad}, "Alt_A2G_Base", nil, nil, nil, nil, "A")
addHUDTextParam("Alt_A2G_Readout", {0, -.2 * fov2MilRad}, "Alt_A2G_Base", nil, nil, nil, nil, "ALTITUDE_HUD")
--]]












dofile(LockOn_Options.script_path .. "HUD/Indicator/HUD_Sphere.lua")
























addHUDSimple("Lower_Bar", {0, -254.17}, nil, "HUD_Base", nil, nil, {"DSI_STATE", "DSI_UP"}, {{ctrl.compareNum, 0, 1}, {ctrl.moveY, 1, .175}})

addHUDText(nil, {-138}, "Lower_Bar", nil, nil, {"landingMode"}, {{ctrl.compareNum, 0, 1}}, "L")

addHUDText(nil, {-20}, "Lower_Bar", nil, nil, {"RADAR_MODE"}, {{ctrl.inRange, 0, .9, 3.1}}, "RDR")

addHUDTextParam(
	nil, {100}, "Lower_Bar", nil, nil, {"selectedPylon"}, {{ctrl.inRange, 0, -.9, 10.9}}, "selectedPylonName",
	nil, {"%s"}
)
addHUDText(nil, {115}, "Lower_Bar", nil, nil, {"selectedPylon"}, {{ctrl.compareNum, 0, 11}}, "G   ", align.RC)
addHUDTextParam(nil, {115}, "Lower_Bar", nil, nil, {"selectedPylon"}, {{ctrl.compareNum, 0, 11}}, "ammoCount", align.RC)


-- HUD_Aiming_Circle_Range_R = add_text_hud("R", 40, 0, "Lower_Bar", "Gripen_Font_green", HUD_Normal_Size)
-- HUD_Aiming_Circle_Range_R.element_params = {"HUDBrightness", "RADAR_STT_RANGE_NM"}
-- HUD_Aiming_Circle_Range_R.controllers    = {{ctrl.opacity,0}, {ctrl.inRange,1, 0, 999}}
-- HUD_Aiming_Circle_Range                = add_text_hud_param(45, 0, "HUDBrightness", "RADAR_STT_RANGE_NM", "%.1f", "Lower_Bar", HUD_Normal_Size, "Gripen_Font_green", "LeftCenter")
-- HUD_Aiming_Circle_Range.element_params = {"HUDBrightness", "RADAR_STT_RANGE_NM"}
-- HUD_Aiming_Circle_Range.controllers    = {{ctrl.opacity,0}, {ctrl.inRange,1, 0, 999}, {ctrl.text,1}}



addHUDSimple("VelVec", nil, nil, "HUD_Base", nil, nil, {"velVecHUDY", "velVecHUDX"}, {{ctrl.moveY, 0, mult}, {ctrl.moveX, 1, mult}})


local aimingCircle = addHUDCircle(
	nil, nil, nil, "VelVec", nil, nil, {"weaponsMode"}, {{ctrl.inRange, 0, .9, 4.1}}, .5,
	0, 360, 8
)

local aimingCircleLeftGunLine = addHUDSimpleLine(
	nil, nil, nil, aimingCircle, nil, nil, {"weaponsMode", "rollRad"},
	{{ctrl.compareNum, 0, 3}, {ctrl.rotate, 1, 1}}, nil, {{-17.5, -7}, {-17.5, 7}}
)
copyElement(aimingCircleLeftGunLine, {"vertices"}, {{{17.5, -7}, {17.5, 7}}})
copyElement(
	aimingCircleLeftGunLine, {"parent_element", "element_params", "controllers"}, {"HUD_Base", {"HUDBrightness", "weaponsMode", "WS_GUN_PIPER_AZIMUTH", "WS_GUN_PIPER_ELEVATION", "velVecHUDY", "velVecHUDX"},
		{{ctrl.opacity, 0}, {ctrl.compareNum, 1, 3}, {ctrl.setPoint, 0, 5, 4, mult, mult}, {ctrl.setPoint, 1, 2, 3, mult, mult}}}
)

for i = 0, 360, 30 do
	local angle = math.rad(i + 90)
	local name = "Aiming_Circle_Circles_" .. i + 90

	copyElement(aimingCircle, {"name", "init_pos"}, {name, {40 * math.cos(angle), 40 * math.sin(angle)}})

	if i == 90 then
		addHUDSimpleLine(nil, nil, nil, name, nil, nil, nil, nil, nil, {{0}, {-7}})
	elseif i == 270 then
		addHUDSimpleLine(nil, nil, nil, name, nil, nil, nil, nil, nil, {{0}, {7}})
	end
end

local minRange = 30
local angleMinRange = math.rad(180 + minRange)
local aimingCircleMinRange = addHUDSimpleLine(
	nil, {40 * math.cos(angleMinRange), 40 * math.sin(angleMinRange)}, {-90 + minRange}, aimingCircle, nil, nil,
	nil, nil, nil, {{0, -1}, {0, -4.8}, {2.5, -4.8}}
)

get_param_handle("RADAR_STT_RANGE_CARROT_RANGE"):set(.6)
for i = 0, 999, 1 do
	addHUDCircle(nil, nil, {90, 180}, aimingCircle, nil, nil, {"RADAR_STT_RANGE_CARROT_RANGE"}, {{ctrl.inRange, 0, (i - 1) / 180, i / 180}}, 41, 39.1, i, 186)
end

addHUDSimple(
	"Aiming_Circle_Carret_Range", nil, {-90}, aimingCircle, nil, nil, {"RADAR_STT_RANGE_CARROT_RANGE"},
	{{ctrl.rotate, 0, math.rad(360) / 2}}
)
copyElement(
	aimingCircleMinRange, {"init_pos", "init_rot", "vertices"}, {
		{0}, {0},
		{
			{-2 + (40 * math.sin(math.rad(180))), 7 + (40 * math.cos(math.rad(180)))}, {0 + (40 * math.sin(math.rad(180))), 2.1 + (40 * math.cos(math.rad(180)))},
			{2 + (40 * math.sin(math.rad(180))),  7 + (40 * math.cos(math.rad(180)))}
		}
	}
)

local innerOuterRange = 163
local angleIORange = math.rad(180 + innerOuterRange)
copyElement(
	aimingCircleMinRange, {"init_pos", "init_rot", "vertices"}, {{40 * math.cos(angleIORange), 40 * math.sin(angleIORange)}, {-90 + innerOuterRange}, {
		{0, -1}, {0, -4.8}, {-2.5, -4.8}, {2.5, -4.8}
	}}
)

addHUDTextParam(
	nil, {0, -65}, aimingCircle, nil, nil, {"RADAR_STT_RANGE_NM"}, {{ctrl.inRange, 0, 0, 999}}, "RADAR_STT_RANGE_NM",
	nil, {"%.1f"}
)
addHUDText(nil, {25, -80}, aimingCircle, nil, nil, {"triggerSafe"}, {{ctrl.compareNum, 0, 0}}, "SAFE")

addHUDTextParam(
	nil, {-25, -80}, aimingCircle, nil, nil, {"selectedPylon"}, {{ctrl.inRange, 0, -.9, 10.9}}, "selectedPylonName",
	nil, {"%s"}
)
addHUDText(nil, {-10, -80}, aimingCircle, nil, nil, {"selectedPylon"}, {{ctrl.compareNum, 0, 11}}, "G   ", align.RC)
addHUDTextParam(nil, {-10, -80}, aimingCircle, nil, nil, {"selectedPylon"}, {{ctrl.compareNum, 0, 11}}, "ammoCount", align.RC)



copyElement(
	aimingCircleLeftGunLine, {"parent_element", "element_params", "controllers", "vertices"}, {
		"HUD_Base",
		{"HUDBrightness", "RADAR_MODE", "RADAR_STT_ELEVATION", "RADAR_STT_AZIMUTH", "rollRad"}, {{ctrl.opacity, 0}, {ctrl.compareNum, 1, 3}, {ctrl.moveY, 2, mult}, {ctrl.moveX, 3, mult}, {ctrl.rotate, 4, 1}},
		{{-6, 2},         {-6, 8},      {6, 8},                {6, 2}}
	}
)

addHUDSimpleLine( -- TODO: Fix
	nil, nil, nil, "HUD_Base", hcr.rw, nil, {"rollRad", "WS_IR_MISSILE_TARGET_AZIMUTH", "WS_IR_MISSILE_TARGET_ELEVATION"},
	{{ctrl.rotate, 0, 0}, {ctrl.moveX, 1, mult}, {ctrl.moveY, 2, mult}}, nil, {{-5, 0}, {-3, -6.25}, {3, -6.25}, {5, 0}}
)



addHUDMeshPoly(
	"Trigger_X", {0, -57.5}, {45}, "Moving_Sides", nil, nil, {"trigger"}, {{ctrl.compareNum, 0, 1}},
	{{-.5, -110}, {.5, -110}, {-.5, 110}, {.5, 110}, {-110, -.5}, {-110, .5}, {110, -.5}, {110, .5}}, {0, 1, 2, 3, 2, 1, 4, 5, 6, 7, 6, 5}
)



addHUDMeshPoly(
	"Takeoff_Lines", nil, nil, "HUD_Pitch", nil, nil, {"CURRENT_PHASE_CO", "CURRENT_PHASE_PAL", "landingMode"},
	{{ctrl.compareNum, 0, 0}, {ctrl.compareNum, 1, 0}, {ctrl.compareNum, 2, 0}},
	{{-67.4, .5}, {-66, .5}, {-67.4, math.rad(4300)}, {-66, math.rad(4300)}, -- Left line.
		{67.4,  .5}, {66, .5}, {67.4, math.rad(4300)}, {66, math.rad(4300)}}, -- Right line.
	{0, 1, 2, 3, 2, 1,
		4, 5, 6, 7, 6, 5}
)



addHUDMeshPoly(
	"VelVec_Horizontal_Lines", nil, nil, "VelVec", nil, nil, {"CURRENT_PHASE", "VV_LimitedLower", "VV_LimitedUpper", "weaponsMode"},
	{{ctrl.inRange, 0, 5.9, 9.9}, {ctrl.compareNum, 1, 0}, {ctrl.compareNum, 2, 0}, {ctrl.compareNum, 3, -1}},
	{{-19, -.5}, {-5.4, -.5}, {-19, .5}, {-5.4, .5},
		{19,  -.5}, {5.4, -.5}, {19, .5}, {5.4, .5}},
	{0, 1, 2, 3, 2, 1,
		4, 5, 6, 7, 6, 5}
)
addHUDCircle(
	"VelVec_Circle", nil, nil, "VelVec", nil, nil, {"CURRENT_PHASE", "VV_LimitedLower", "VV_LimitedUpper", "weaponsMode"},
	{{ctrl.inRange, 0, 5.9, 9.9}, {ctrl.compareNum, 1, 0}, {ctrl.compareNum, 2, 0}, {ctrl.compareNum, 3, -1}}, 5.5, 4.1, 360, 25
)
addHUDSimpleLine(
	"VelVec_Vertical_Line", {0, -16.8}, nil, "VelVec", nil, nil, {"HUD_VELVEC_VER_LINE_POS", "HUD_VELVEC_VER_LINE_BLINK"},
	{{ctrl.moveY, 0, 14 * .001}, {ctrl.inRange, 1, -.1, .5}}, nil, {{0, 4.075}, {0, 14.075}}
)

addHUDMeshPoly(
	"VelVec_Horizontal_Lines_Limited", nil, nil, "VelVec", nil, nil, {"VV_LimitedLower", "weaponsMode"},
	{{ctrl.compareNum, 0, 1}, {ctrl.compareNum, 1, -1}},
	{{-19, -.5}, {-8, -.5}, {-19, .5}, {-8, .5},
		{19,  -.5}, {8, -.5}, {19, .5}, {8, .5}},
	{0, 1, 2, 3, 2, 1,
		4, 5, 6, 7, 6, 5}
)
addHUDTextParam(
	"VelVec_Limited_AoA_Readout", nil, "VelVec_Horizontal_Lines_Limited", nil, nil, {"CURRENT_PHASE"}, {{ctrl.inRange, 0, 6.9, 8.9}},
	"AoA"
)



addHUDMeshPoly(
	"Altitude_Keeping_Boxes", nil, nil, "HUD_Pitch", nil, nil, {"ALT_HOLD"}, {{ctrl.compareNum, 0, 1}},
	{{-77.426504, -27.97108}, {-76.026504, -27.97108}, {-77.426504, -.5}, {-76.026504, -.5}, -- Left box.
		{-66,        -27.97108}, {-76.026504, -26.57108}, {-66, -26.57108},
		{-67.4,     -26.57108}, {-67.4, -.5}, {-66, -.5},
		{77.426504, -27.97108}, {76.026504, -27.97108}, {77.426504, -.5}, {76.026504, -.5}, -- Right box.
		{66,   -27.97108}, {76.026504, -26.57108}, {66, -26.57108},
		{67.4, -26.57108}, {67.4, -.5}, {66, -.5}},
	{0, 1, 2, 3, 2, 1, -- Left box.
		1, 4, 5, 6, 5, 4,
		7, 6, 8, 9, 8, 6,
		10, 11, 12, 13, 12, 11, -- Right box.
		11, 14, 15, 16, 15, 14,
		17, 16, 18, 19, 18, 16}
)
addHUDMeshPoly(
	"Altitude_Keeping_Boxes_Cs", nil, nil, "VelVec", nil, nil, {"rollRad", "AutoPilotMode"}, {{ctrl.rotate, 0, 1}, {ctrl.compareNum, 1, -2}},
	{{-77.426504, -.5}, {-66, -.5}, {-77.426504, .5}, {-66, .5}, -- Left C.
		{-77.426504, -27.97108}, {-76.026504, -27.97108}, {-76.026504, -.5},
		{-66,       -27.97108}, {-76.026504, -26.57108}, {-66, -26.57108},
		{77.426504, -.5}, {66, -.5}, {77.426504, .5}, {66, .5}, -- Right C.
		{77.426504, -27.97108}, {76.026504, -27.97108}, {76.026504, -.5},
		{66,        -27.97108}, {76.026504, -26.57108}, {66, -26.57108}},
	{0, 1, 2, 3, 2, 1, -- Left C.
		4, 5, 0, 6, 0, 5,
		5, 7, 8, 9, 8, 7,
		10, 11, 12, 13, 12, 11, -- Right C.
		14, 15, 10, 16, 10, 15,
		15, 17, 18, 19, 18, 17}
)


addHUDMeshPoly(
	"Horizon_Lines", nil, nil, "HUD_Pitch", nil, nil, nil, nil,
	{{-9999, -.5}, {-66, -.5}, {-9999, .5}, {-66, .5}, -- 72.3064976 instead of 66???
		{9999,  -.5}, {66, -.5}, {9999, .5}, {66, .5}},
	{0, 1, 2, 3, 2, 1,
		4, 5, 6, 7, 6, 5}
)


addHUDMeshPoly(
	"Glide_Slope", {0, math.rad(-2.86) * 1000}, nil, "HUD_Pitch", nil, nil, {"landingMode", "GLIDE_SLOPE_MOVE"},
	{{ctrl.compareNum, 0, 1}, {ctrl.moveY, 1, mult}},
	{{-90, -.5}, {-20, -.5}, {-90, .5}, {-20, .5},
		{90,  -.5}, {20, -.5}, {90, .5}, {20, .5}},
	{0, 1, 2, 3, 2, 1,
		4, 5, 6, 7, 6, 5}
)


--[[
local headingTapeWidth = math.rad(5) * 1000 / 2

addHUDMeshPoly(
	"Heading_Tape_Mask", {0, math.rad(2.75) * 1000}, nil, "Moving_Sides", hcr.incIf, nil, {"weaponsMode"},
	{{ctrl.compareNum, 0, -1}}, {{-headingTapeWidth, -.04 * fov2MilRad}, {headingTapeWidth, -.04 * fov2MilRad}, {headingTapeWidth, -.17 * fov2MilRad}, {-headingTapeWidth, -.17 * fov2MilRad}},
	{0, 1, 2, 0, 2, 3}, nil, true
)

addHUDSimple("Heading_Tape_Base", nil, nil, "Moving_Sides", nil, nil, {"HEADING"}, {{ctrl.moveX, 0, -.0020944}})

local headingLineSpacing = math.rad(1) * 1000
local headinglineThickness = .46

for i = -4, 76 do -- make 4 extra lines on each side of north, north is 0. 34 <18> 02
	local j
	local hdgLineHeight

	if i < 0 then
		j = 36 + (i / 2)
	elseif i > 70 then
		j = (i - 72) / 2
	else
		j = i / 2
	end

	if j < 10 then
		j = "0" .. j
	end

	if i % 2 == 0 then
		hdgLineHeight = math.rad(.5) * 1000

		addHUDText("Heading_Digit_" .. j, {headingLineSpacing * i, 33, .1}, "Heading_Tape_Base", hcr.decIf, HUDLvls.mask, nil, nil, j)
	else
		hdgLineHeight = math.rad(.25) * 1000
	end


	addHUDMeshPoly(
		"Heading_Line_" .. j, {headingLineSpacing * i, 18}, nil, "Heading_Tape_Base", hcr.decIf, HUDLvls.mask, nil, nil,
		{{-headinglineThickness, hdgLineHeight}, {headinglineThickness, hdgLineHeight}, {headinglineThickness, 0}, {-headinglineThickness, 0}}, {0, 1, 2, 0, 2, 3}
	)
end

-- local HeadingScaleArrow           = Hud_Horizon_Line(HUD_HORIZON, 793, 987, 912, 1106, .5 * fov2MilRad)
-- HeadingScaleArrow.name            = create_guid_string()
-- HeadingScaleArrow.init_pos        = {0, math.rad(.82) * 1000, 0}
-- HeadingScaleArrow.parent_element  = "Moving_Sides"
-- HeadingScaleArrow.h_clip_relation = h_clip_relations.DECREASE_IF_LEVEL
-- HeadingScaleArrow.level           = HUD_DEFAULT_LEVEL + 1
-- HeadingScaleArrow.element_params  = {"HUDBrightness"}
-- HeadingScaleArrow.controllers     = {{ctrl.opacity, 0}}
-- AddHudElement3(HeadingScaleArrow)

addHUDText("Heading_Mode_T", {-.30 * fov2MilRad, .15 * fov2MilRad}, "Moving_Sides", nil, nil, {"headingMode"}, {{ctrl.compareNum, 0, 1}}, "T")
addHUDText("Heading_Mode_M", {-.30 * fov2MilRad, .15 * fov2MilRad}, "Moving_Sides", nil, nil, {"headingMode"}, {{ctrl.compareNum, 0, 2}}, "M")

--]]

addHUDText(
	"Horizon_Line_Dots", {.03025 * fov2MilRad, 2.5}, "HUD_Pitch", nil, nil, {"heading"}, {{ctrl.moveX, 0, -.0110555}},
	"!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!,,,,!",
	-- lol
	nil, HUDStrdefs.headingLine
)







addHUDSimple("Alt_Declutt_Base", {.33 * fov2MilRad, -.25 * fov2MilRad}, nil, "Moving_Sides", nil, nil, {"HUDDeclutt"}, {{ctrl.compareNum, 0, 1}})

addHUDText("Alt_Declutt_Alt", {0, -.1 * fov2MilRad}, "Alt_Declutt_Base", nil, nil, {"altMode"}, {{ctrl.compareNum, 0, 1}}, "ALT")
addHUDTextParam(
	"Alt_Declutt_Alt_Readout", {0, -.16 * fov2MilRad}, "Alt_Declutt_Base", nil, nil, {"altMode"}, {{ctrl.compareNum, 0, 1}},
	"TEXT_ALT"
)

addHUDText("Alt_Declutt_Ralt", {0, -.1 * fov2MilRad}, "Alt_Declutt_Base", nil, nil, {"altMode"}, {{ctrl.compareNum, 0, 2}}, "RALT")
addHUDTextParam(
	"Alt_Declutt_Ralt_Readout", {0, -.16 * fov2MilRad}, "Alt_Declutt_Base", nil, nil, {"altMode"}, {{ctrl.compareNum, 0, 2}},
	"TEXT_RALT"
)


addHUDTextParam("Declutted_CAS_Readout", {-.66 * fov2MilRad, -.16 * fov2MilRad}, "Alt_Declutt_Base", nil, nil, nil, nil, "textCAS")

addHUDText(
	"Declutted_AT_Ind", {-.7 * fov2MilRad, -.1 * fov2MilRad}, "Alt_Declutt_Base", nil, nil, {"AUTOTHROTTLE_ONOFF"},
	{{ctrl.inRange, 0, .9, 1.1}}, "AT"
)
addHUDText(
	"Declutted_AT_12_Ind", {-.63 * fov2MilRad, -.1 * fov2MilRad}, "Alt_Declutt_Base", nil, nil, {"AUTOTHROTTLE_MODE"},
	{{ctrl.inRange, 0, .4, .6}}, "12"
)
addHUDText(
	"Declutted_AT_12_Ind", {-.63 * fov2MilRad, -.1 * fov2MilRad}, "Alt_Declutt_Base", nil, nil, {"AUTOTHROTTLE_MODE"},
	{{ctrl.inRange, 0, .9, 1.1}}, "14"
)


addHUDTextParam(
	"Declutted_AoA_Readout", {-.724 * fov2MilRad, -1.255 * fov2MilRad}, "HUD_Base", nil, nil, {"HUDDeclutt"}, {{ctrl.compareNum, 0, 1}},
	"AoA"
)
addHUDText("Declutted_AoA_@", {-.81 * fov2MilRad, -1.255 * fov2MilRad}, "HUD_Base", nil, nil, {"HUDDeclutt"}, {{ctrl.compareNum, 0, 1}},
		   "@"
)

addHUDTextParam(
	"Declutted_G_Readout", {-.724 * fov2MilRad, -305.9}, "HUD_Base", nil, nil, {"HUDDeclutt"}, {{ctrl.compareNum, 0, 1}},
	"CUR_G", nil, {"%.1f"}
)
addHUDText("Declutted_G_G", {-.81 * fov2MilRad, -305.9}, "HUD_Base", nil, nil, {"HUDDeclutt"}, {{ctrl.compareNum, 0, 1}},
		   "G"
)



addHUDSimple(
	"GCW_Base", nil, nil, "VelVec_Vertical_Line", hcr.decIf, HUDLvls.mask, {"rollRad", "PULLUPQUE", "CURRENT_PHASE"},
	{{ctrl.rotate, 0, 1}, {ctrl.moveY, 1, -.0004}, {ctrl.inRange, 2, 5.9, 9.9}}
)
local GCWLeftGround = addHUDSimpleLine(
	nil, nil, nil, "GCW_Base", nil, nil, {"GROUNDSYMB"}, {{ctrl.compareNum, 0, 0}}, nil,
	{{-54, 4.2}, {-54, 0}, {-33.17, 0}}
)
copyElement(GCWLeftGround, {"vertices"}, {{{12.25, 0}, {-12.25, 0}}})
copyElement(GCWLeftGround, {"vertices"}, {{{54, 4.2}, {54, 0}, {33.17, 0}}})
local GCWLeftLeft = copyElement(
	GCWLeftGround, {"element_params", "controllers", "vertices"},
	{{"HUDBrightness", "GROUNDSYMB", "PULLUPQUE", "PULLMORE"}, {{ctrl.opacity, 0}, {ctrl.compareNum, 1, 0}, {ctrl.inRange, 2, -10000, 0}, {ctrl.inRange, 3, -.99, .5}}, {{54, 4.2}, {54, 0}, {33.17, 0}}}
)
copyElement(GCWLeftLeft, {"vertices"}, {{{-47, 40}, {-47, 4.2}, {-33.17, 4.2}}})
copyElement(GCWLeftLeft, {"vertices"}, {{{12.25, 4.2}, {-12.25, 4.2}}})
copyElement(GCWLeftLeft, {"vertices"}, {{{47, 40}, {47, 4.2}, {33.17, 4.2}}})
copyElement(GCWLeftLeft, {"vertices"}, {{{54, 40}, {54, 4.2}}})
local GCWLeftArrow = copyElement(
	GCWLeftLeft, {"init_pos", "element_params", "controllers", "vertices"},
	{
		{0,                 -2}, {"HUDBrightness", "GROUNDSYMB", "PULLUPQUE", "PULLMORE"},
		{{ctrl.opacity, 0}, {ctrl.compareNum, 1, 0}, {ctrl.inRange, 2, -10000, 0}, {ctrl.moveY, 2, -.00001}, {ctrl.inRange, 3, -.99, .5}}, {{-56, 35}, {-5.5, 50}, {-45, 35}, {-56, 35}}
	}
)
copyElement(GCWLeftArrow, {"vertices"}, {{{56, 35}, {5.5, 50}, {45, 35}, {56, 35}}})