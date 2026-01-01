addHMDText("AoA", {-140.5, 55.5}, base, nil, nil, nil, nil, "@", nil, strdefs.alpha)
addHMDTextParam(nil, {6, -1}, "AoA", nil, nil, nil, nil, "AoA", align.LC)



addHMDText("AT", {-122.5, 12}, base, nil, nil, {"AUTOTHROTTLE_ONOFF"}, {{ctrl.compareNum, 0, 1}}, "AT")

addHMDText(nil, {22.5}, "AT", nil, nil, {"AUTOTHROTTLE_MODE"}, {{ctrl.compareNum, 0, 0.5}}, "12", align.RC)
addHMDText(nil, {22.5}, "AT", nil, nil, {"AUTOTHROTTLE_MODE"}, {{ctrl.compareNum, 0, 1}}, "14", align.RC)


addHMDTextParam(nil, {-100}, base, nil, nil, nil, nil, "txtCAS", align.RC)
addHMDSimpleLine(nil, {-83}, nil, base, nil, nil, {"HUDDeclutt"}, {{ctrl.compareNum, 0, 0}}, nil, {{-15, 4.1}, {0, 0}, {-15, -4.1}})


addHMDText("Mach", {-134, -13}, base, nil, nil, {"HUDDeclutt", "machDecimals"}, {{ctrl.compareNum, 0, 0}, {ctrl.inRange, 1, 1, 999}}, "M")
addHMDTextParam(nil, {5.14}, "Mach", nil, nil, {"machWhole", "HMDBrightness"}, {{ctrl.inRange, 0, 0.995, 9}, {ctrl.text, 0}, {ctrl.opacity, 1}}, nil, align.LC, {"%.2f"})
addHMDText(nil, {14}, "Mach", nil, nil, {"machDecimals"}, {{ctrl.inRange, 0, 1, 99.5}}, ".")
addHMDTextParam(nil, {17}, "Mach", nil, nil, {"machDecimals", "HMDBrightness"}, {{ctrl.inRange, 0, 1, 99.5}, {ctrl.text, 0}, {ctrl.opacity, 1}}, nil, align.LC, {"%.0f"})


addHMDText("GS", {-134, -26}, base, nil, nil, {"HMDMode", "currentPhase", "HUDDeclutt"}, {{ctrl.inRange, 0, -0.1, 1.1}, {ctrl.inRange, 1, 6.9, 8.9}, {ctrl.compareNum, 2, 0}}, "GS")
addHMDTextParam(nil, {34}, "GS", nil, nil, nil, nil, "txtGS", align.RC)



addHMDSimpleLine(nil, {107}, nil, base, nil, nil, {"altitudeDeclutt"}, {{ctrl.compareNum, 0, 0}}, nil, {{-15, 4.1}, {0, 0}, {-15, -4.1}}) -- Altitude index
addHMDSimple("altBase", nil, nil, base, nil, nil, {"altitudeDeclutt", "altTape"}, {{ctrl.compareNum, 0, 0}, {ctrl.moveY, 1, -0.000175659}})
addHMDBox("altMask", {132, 0}, nil, "altBase", hcr.rw, lvl.mask, {"altTape"}, {{ctrl.moveY, 0, 0.000175659}}, 81, 64, materials.HUDMask, true)


addHMDText(nil, {105, -2.3}, "altBase", nil, lvl.mask, {"altMode", "terrainAlt"}, {{ctrl.compareNum, 0, 1}, {ctrl.moveY, 1, 0.000175659}}, "77", nil, strdefs.seventyseven)


local hundredsOffsetY = -2

for i = 1, 3 do
	local longAltLine = addHMDSimpleLine("longAltLine_" .. i, {110}, nil, "altBase", nil, lvl.mask, {"HMDLongAltLine_" .. i}, {{ctrl.moveY, 0, 0.000175659}}, nil, {{0}, {13}})
	copyElement(longAltLine, {"element_params", "vertices"}, {{"HMDShortAltLine_" .. i, "HMDBrightness"}, {{0}, {6.5}}})

	addHMDTextParam(nil, {17}, "longAltLine_" .. i, nil, lvl.mask, nil, nil, "HMDAltBig_" .. i, align.LC)
	addHMDTextParam(nil, {-21.5, hundredsOffsetY}, "longAltLine_" .. i, nil, lvl.mask, {"HMDAltBig_" .. i, "HMDAltSmallStr_" .. i, "HMDAltSmall_" .. i}, {{ctrl.inRange, 0, 9, 100}, {ctrl.inRange, 1, -.1, 9.1}, {ctrl.text, 2}}, nil, align.LC, {"%s"}, strdefs.hundreds)
	addHMDTextParam(nil, {-29, hundredsOffsetY}, "longAltLine_" .. i, nil, lvl.mask, {"HMDAltBig_" .. i, "HMDAltSmallStr_" .. i, "HMDAltSmall_" .. i}, {{ctrl.inRange, 0, 0, 10}, {ctrl.inRange, 1, -.1, 9.1}, {ctrl.text, 2}}, nil, align.LC, {"%s"}, strdefs.hundreds)
end


addHMDText(nil, {129, -43}, base, nil, nil, {"altitudeDeclutt", "altMode"}, {{ctrl.compareNum, 0, 0}, {ctrl.compareNum, 1, 2}}, "R")


local decluttAltInd = addHMDText(nil, {130, 15}, base, nil, nil, {"altitudeDeclutt", "altMode"}, {{ctrl.compareNum, 0, 1}, {ctrl.compareNum, 1, 1}}, "A")
local dA            = addHMDTextParam(nil, {0, -15}, decluttAltInd, nil, nil, nil, nil, "txtAlt")

copyElement(decluttAltInd, {"name", "value", "controllers"}, {"Declutt_Ralt", "RA", {{ctrl.compareNum, 0, 1}, {ctrl.compareNum, 1, 2}, {ctrl.opacity, 2}}})
copyElement(dA, {"parent_element", "element_params"}, {"Declutt_Ralt", {"txtRalt"}})



addHMDSimple("Status_Bar", {0, -166}, nil, base, nil, nil, {"currentPhase", "PULLUPQUE"}, {{ctrl.inRange, 0, 6.9, 9.9}, {ctrl.inRange, 1, -1, 999999}})

addHMDText(nil, {0, -10}, "Status_Bar", nil, nil, {"landingMode"}, {{ctrl.compareNum, 0, 1}}, "L")


local GCWY = 180
addHMDSimple("GCW_Base", nil, nil, base, nil, nil, {"rollRad", "currentPhase"}, {{ctrl.rotate, 0, 1}, {ctrl.inRange, 1, 5.9, 9.9}})

local GCWLL = addHMDSimpleLine(nil, nil, nil, "GCW_Base", hcr.rw, nil, {"PULLUPQUE", "PULLMORE"}, {{ctrl.inRange, 0, -10000, 0}, {ctrl.inRange, 1, -0.99, 0.5}}, nil, {{-52, 40 - GCWY}, {-52, 0 - GCWY}, {-32.17, 0 - GCWY}})
copyElement(GCWLL, {"vertices"}, {{{-46, 40 - GCWY}, {-46, 2.8 - GCWY}, {-32.17, 2.8 - GCWY}}})
copyElement(GCWLL, {"vertices"}, {{{11.25, 2.8 - GCWY}, {-11.25, 2.8 - GCWY}}})
copyElement(GCWLL, {"vertices"}, {{{11.25, 0 - GCWY}, {-11.25, 0 - GCWY}}})
copyElement(GCWLL, {"vertices"}, {{{46, 40 - GCWY}, {46, 2.8 - GCWY}, {32.17, 2.8 - GCWY}}})
copyElement(GCWLL, {"vertices"}, {{{52, 40 - GCWY}, {52, 0 - GCWY}, {32.17, 0 - GCWY}}})

local GCWLArrow = copyElement(GCWLL, {"init_pos", "vertices", "controllers"}, {{0, -2}, {{-54.5, 35 - GCWY}, {-49, 50 - GCWY}, {-43.5, 35 - GCWY}, {-54.5, 35 - GCWY}}, {{ctrl.inRange, 0, -10000, 0}, {ctrl.moveY, 0, -0.00001}, {ctrl.inRange, 1, -0.99, 0.5}, {ctrl.opacity, 2}}})
copyElement(GCWLArrow, {"vertices"}, {{{54.5, 35 - GCWY}, {49, 50 - GCWY}, {43.5, 35 - GCWY}, {54.5, 35 - GCWY}}})



local aILeftLine = addHMDSimpleLine(nil, {-attIndRadius}, nil, base, nil, nil, nil, nil, nil, {{-18, 0}, {-6, 0}})
copyElement(aILeftLine, {"init_pos", "vertices"}, {{attIndRadius}, {{6, 0}, {18, 0}}})


addHMDSimpleLine(nil, nil, nil, base, nil, nil, {"rollRad"}, {{ctrl.rotate, 0, 1}}, nil, {{-4, -attIndRadius + 8.1}, {0, -attIndRadius + 0.6}, {4, -attIndRadius + 8.1}})


local attIndBase = addHMDSimple(nil, nil, nil, base, nil, nil, {"rollRad"}, {{ctrl.rotate, 0, 1}})
copyElement(attIndBase, {"name"}, {"Att_Ind_Base2"})

local aIMaskRight = addHMDCircle(nil, nil, {-180}, attIndBase, hcr.rw, lvl.alt, {"HMDPitch"}, {{ctrl.rotate, 0, math.rad(1)}}, attIndRadius + 1.5, attIndRadius, 180, 18, materials.HUDMask, true)
local aIR         = addHMDCircle(nil, nil, nil, "Att_Ind_Base2", nil, lvl.alt, nil, nil, attIndRadius + 1.5, attIndRadius, 180, 18)

copyElement(aIMaskRight, {"init_rot", "parent_element", "level", "controllers"}, {{0}, "Att_Ind_Base2", lvl.alt2, {{ctrl.rotate, 0, -math.rad(1)}}})
copyElement(aIR, {"init_rot", "level"}, {{180}, lvl.alt2})


copyElement(aILeftLine, {"init_pos", "vertices"}, {{0, -attIndRadius}, {{-4, -10}, {0, -2.5}, {4, -10}}})