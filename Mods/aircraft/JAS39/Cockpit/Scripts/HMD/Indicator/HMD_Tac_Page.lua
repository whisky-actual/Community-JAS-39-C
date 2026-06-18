for i = 0, 3 do
	addHMDSimpleLine(nil, nil, {45 + i * 90}, base, nil, nil, {"HMDMode", "gunMode", "trigger"}, {{ctrl.inRange, 0, 1.1, 8.1}, {ctrl.compareNum, 1, 0}, {ctrl.compareNum, 2, 1}}, nil, {{0, 0}, {0, 82.5}})
end



for i = 0, 3 do
	addHMDSimpleLine(nil, nil, {45 + i * 90}, base, nil, nil, {"HMDMode"}, {{ctrl.inRange, 0, -0.1, 1.1}}, nil, {{3, 0}, {15, 0}})
end



local ACBase = addHMDCircle(nil, nil, nil, base, nil, nil, {"HMDMode"}, {{ctrl.inRange, 0, 1.1, 8.1}}, 1, 0, 360, 7)

for i = 0, 360, 30 do
	local ACCircles = copyElement(ACBase, {"init_pos"}, {{aimingCircleRadius * math.cos(math.rad(i + 90)), aimingCircleRadius * math.sin(math.rad(i + 90))}})


	if i == 90 or i == 270 then
		addHMDSimpleLine(nil, nil, nil, ACCircles, nil, nil, nil, nil, nil, {{0}, {i == 90 and -5 or 5}})
	end
end


local weaponModes = {"BVR", "VS", "BORE", "HMD", "LGNT", "AG"}

for i = 1, 6 do
	addHMDText(nil, {-17.5, -67.5}, ACBase, nil, nil, {"HMDMode", "gunMode"}, {{ctrl.compareNum, 0, i + 1}, {ctrl.compareNum, 1, 0}}, weaponModes[i])
end

addHMDText(nil, {-17.5, -67.5}, ACBase, nil, nil, {"gunMode"}, {{ctrl.compareNum, 0, 1}}, "GUN")

addHMDText(nil, {17.5, -67.5}, ACBase, nil, nil, {"triggerSafe"}, {{ctrl.compareNum, 0, 0}}, "SAFE")



-- for i = 1, 20 do
-- 	local index = ""
-- 	if i < 10 then
-- 		index = "_0" .. i .. "_"
-- 	else
-- 		index = "_" .. i .. "_"
-- 	end

-- 	local param = "RWR_CONTACT" .. index



-- 	addHMDSimple("HMD_RWR_Contact" .. index, nil, nil, base, nil, nil, {param .. "POWER", param .. "azHMD", param .. "elHMD", "rollRad"}, {{ctrl.inRange, 0, 0, 1.1}, {ctrl.moveX, 1, -.702422}, {ctrl.moveY, 2, .702422}, {ctrl.rotate, 3, 1}})
	
-- 	for j = 0, 7 do
-- 		addHMDSimpleLine(nil, nil, {j * 45}, "HMD_RWR_Contact" .. index, hcr.rw, nil, {param .. "launchBlink"}, {{ctrl.compareNum, 0, 1}}, .003 * 230, {{(.6465 * math.rad(.1 / 2) * 10) * 230}, {(.6465 * math.rad(.3 / 2) * 10) * 230}})
-- 	end
-- end



-- addHMDSimpleLine(nil, {0, 10}, nil, base, hcr.rw, nil, nil, nil, 10, {{-900}, {0}})
-- addHMDSimpleLine(nil, nil, nil, base, hcr.rw, nil, {"ONE"}, {{ctrl.moveX, 0, .702422}}, 10, {{-100 * 1000}, {0}})
-- 
for n = 1, 99 do
	local i

	if n < 10 then
		i = "RADAR_CONTACT_0" .. n .. "_"
	else
		i = "RADAR_CONTACT_" .. n .. "_"
	end

	addHMDSimpleLine(i .. "Box", nil, nil, base, hcr.rw, nil, {i .. "TIME", i .. "HUDEl", i .. "AZIMUTH"}, {{ctrl.inRange, 0, 0, 6}, {ctrl.moveY, 1, mult}, {ctrl.moveX, 2, mult}}, nil, {{-5, 2.5}, {5, 2.5}, {2.5, 2.5}, {2.5, -2.5}, {5, -2.5}, {-5, -2.5}, {-2.5, -2.5}, {-2.5, 2.5}})
	addHMDSimpleLine(nil, {0, 0.25}, nil, i .. "Box", hcr.rw, nil, {i .. "FRIENDLY"}, {{ctrl.compareNum, 0, 1}}, nil, {{-5, 5}, {0, 10}, {5, 5}})
	-- addHMDSimpleLine(nil, nil, nil, base, nil, nil, {i .. "ObjNum", i .. "HMD_CLAMPED", "rollRad", i .. "HMD_AZ", i .. "HMD_EL", i .. "Az", i .. "El"}, {{ctrl.inRange,0, -1, 999}, {ctrl.compareNum,1, 1}, {ctrl.rotate,2, 1}, {ctrl.setPoint,0, 3, 4, mult, mult}, {ctrl.setPoint,1, 5, 6, mult, mult}})
end