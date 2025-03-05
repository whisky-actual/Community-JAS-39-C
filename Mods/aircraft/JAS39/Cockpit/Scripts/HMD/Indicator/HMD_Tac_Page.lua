for i = 0, 3 do
	addHMDSimpleLine(nil, nil, {45 + i * 90}, base, nil, nil, {"masterMode", "gunMode", "trigger"}, {{ctrl.inRange,0, 1.1, 8.1}, {ctrl.compareNum,1, 0}, {ctrl.compareNum,2, 1}}, nil, {{0, 0}, {0, 82.5}})
end



for i = 0, 3 do
	addHMDSimpleLine(nil, nil, {45 + i * 90}, base, nil, nil, {"masterMode"}, {{ctrl.inRange,0, -0.1, 1.1}}, nil, {{3, 0}, {15, 0}})
end



local ACBase = addHMDCircle(nil, nil, nil, base, nil, nil, {"masterMode"}, {{ctrl.inRange,0, 1.1, 8.1}}, 1, 0, 360, 7)

for i = 0, 360, 30 do
	local ACCircles = copyHMDElement(ACBase, {"init_pos"}, {{aimingCircleRadius * math.cos(math.rad(i + 90)), aimingCircleRadius * math.sin(math.rad(i + 90))}})


	if i == 90 then
		addHMDSimpleLine(nil, nil, nil, ACCircles, nil, nil, nil, nil, nil, {{0}, {-5}})
	end

	if i == 270 then
		addHMDSimpleLine(nil, nil, nil, ACCircles, nil, nil, nil, nil, nil, {{0}, {5}})
	end
end


local weaponModes = {"BVR", "VS", "BORE", "HMD", "LGNT", "AG"}

for i = 1, 6 do
	addHMDText(nil, {-17.5, -67.5}, ACBase, nil, nil, {"masterMode", "gunMode"}, {{ctrl.compareNum,0, i + 1}, {ctrl.compareNum,1, 0}}, weaponModes[i])
end 

addHMDText(nil, {-17.5, -67.5}, ACBase, nil, nil, {"gunMode"}, {{ctrl.compareNum,0, 1}}, "GUN")

addHMDText(nil, {17.5, -67.5}, ACBase, nil, nil, {"triggerSafe"}, {{ctrl.compareNum,0, 0}}, "SAFE")