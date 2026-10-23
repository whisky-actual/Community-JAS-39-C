-- HUD Sphere
addHUDSimple("HUD_Pitch", nil, nil, "HUD_Base", nil, nil, {"rollRad", "pitchRad"}, {{ctrl.rotate, 0, 1}, {ctrl.moveY, 1, -mult}})


addHUDSimple("Top_Heading_Base", {0, d2Mr(90)}, nil, "HUD_Pitch", nil, nil, {"heading"}, {{ctrl.rotate, 0, -math.rad(1)}})
addHUDSimple("Bottom_Heading_Base", {0, -d2Mr(90)}, nil, "HUD_Pitch", nil, nil, {"heading"}, {{ctrl.rotate, 0, math.rad(1)}})


local lineThickness = 2
local lineLength = 7.5

for j = 10, 80, 10 do -- TODO: Make the HUD actually project a 3D sphere to 2D.
	local spherify = 1 -- math.cos(math.rad(j)) / math.sin(math.rad(j))
	local radius
	local digitRadius
	local degsEvery

	if j < 50 then
		radius = d2Mr(90 - j) * spherify -- make radius 90 - j degrees
	else
		radius = d2Mr(90 - j)
	end

	digitRadius = radius - 10 -- place digits 10 milliradians above line


	addHUDSimple(
		"Positive_Heading_Base_" .. j, {0, radius + d2Mr(j)}, nil, "HUD_Pitch", nil, nil, {"heading"},
		{{ctrl.rotate, 0, -math.rad(1) / spherify}}
	)

	addHUDCircle(
		"Pitch_Circle_" .. j, nil, nil, "Positive_Heading_Base_" .. j, nil, nil, nil, nil, radius, radius - 1,
		360, 360 / 2.5
	)

	if j < 70 then -- from +10 to +60 degrees, make heading lines every 10 degs, at 70 every 30
		degsEvery = 10 -- / spherify
	else
		degsEvery = 30 -- / spherify
	end

	if j < 80 then                -- and at 80 none
		for i = -180, 180, degsEvery do -- i = outer Circle
			local k = math.rad(i)

			addHUDSimpleLine(
				"Vertical_Heading_Line_" .. j .. "_" .. i, {radius * math.cos(k), radius * math.sin(k)}, {i + 90}, "Positive_Heading_Base_" .. j,
				hcr.decIf, nil, nil, nil, .5, {{0, lineLength}, {0}}
			)
		end

		for i = -185, 165, 20 do
			local k = math.rad(i)

			local pitchAngleReadout = addHUDText(
				nil, {digitRadius * math.cos(k), digitRadius * math.sin(k)}, "Positive_Heading_Base_" .. j, nil,
				nil, nil, nil, "+" .. j, nil, HUDStrdefs.pitchDigit
			)
			pitchAngleReadout.init_rot = {i + 90}
		end
	end
end


local spikeWidth = 12.5
local spikeHeight = 18.75

local spikeMaskOffset = 3.5

for j = -10, -80, -10 do
	local radius = d2Mr(90 + j)
	local digitRadius = radius + 10
	local degsEvery

	if j == -90 then
		degsEvery = 90
	elseif j >= -60 then
		degsEvery = 10
	else
		degsEvery = 30
	end

	for i = -180, 180, degsEvery do -- i = outer Circle
		local k = math.rad(i)

		addHUDSimpleLine(
			"Heading_Spike_" .. j .. "_" .. i, {(radius) * math.cos(k), ((radius) * math.sin(k))}, {i - 90}, "Bottom_Heading_Base",
			hcr.decIf, nil, nil, nil, .5, {{-spikeWidth * .5, -1}, {0, spikeHeight}, {spikeWidth * .5, -1}}
		)

		addHUDMeshPoly(
			"Heading_Spike_Mask_" .. j .. "_" .. i,
			{(radius - spikeMaskOffset * lineThickness) * math.cos(k), ((radius - spikeMaskOffset * lineThickness) * math.sin(k))}, {i - 90},
			"Bottom_Heading_Base", hcr.incIf, nil, nil, nil,
			{
				{(-.5 * spikeWidth + lineThickness) - 1.3, (spikeMaskOffset + lineThickness) - .05}, {(.5 * spikeWidth - lineThickness) + 1.3, (spikeMaskOffset + lineThickness) - .05},
				{(-.5 * spikeWidth + lineThickness) - 1.3, (spikeMaskOffset + lineThickness) + 1.6}, {(.5 * spikeWidth - lineThickness) + 1.3, (spikeMaskOffset + lineThickness) + 1.6}
			}, {0, 1, 2, 3, 2, 1}, nil, true
		)
	end


	addHUDCircle(
		"Pitch_Circle_" .. j, nil, nil, "Bottom_Heading_Base", nil, nil, nil, nil, radius, radius - 1,
		360, 360 / 2.5
	)

	if j >= -80 then
		if j >= -60 then -- from +10 to +60 degrees, make heading lines every 10 degs, at 70 every 30
			degsEvery = 20
		else
			degsEvery = 60
		end

		for k = -175, 175, degsEvery do
			local pitchAngleReadout = addHUDText(
				nil, {(digitRadius * math.cos(math.rad(k))), ((digitRadius * math.sin(math.rad(k))))}, "Bottom_Heading_Base", nil,
				nil, nil, nil, j, nil, HUDStrdefs.pitchDigit
			)
			pitchAngleReadout.init_rot = {k - 90}
		end
	end
end


local radius = math.rad(2) * 1000

for i = 0, 270, 90 do -- i = outer Circle
	addHUDSimpleLine(
		"Heading_Spike_" .. i, {(radius) * math.cos(math.rad(i)), ((radius) * math.sin(math.rad(i)))}, {i - 90}, "Bottom_Heading_Base",
		hcr.decIf, nil, nil, nil, .5, {{-spikeWidth * .5, -1}, {0, spikeHeight}, {spikeWidth * .5, -1}}
	)

	addHUDMeshPoly(
		"Heading_Spike_Mask_" .. i,
		{(radius - spikeMaskOffset * lineThickness) * math.cos(math.rad(i)), ((radius - spikeMaskOffset * lineThickness) * math.sin(math.rad(i)))}, {i - 90},
		"Bottom_Heading_Base", hcr.incIf, nil, nil, nil,
		{
			{(-.5 * spikeWidth + lineThickness) - 1.3, (spikeMaskOffset + lineThickness) - .05}, {(.5 * spikeWidth - lineThickness) + 1.3, (spikeMaskOffset + lineThickness) - .05},
			{(-.5 * spikeWidth + lineThickness) - 1.3, (spikeMaskOffset + lineThickness) + 1.6}, {(.5 * spikeWidth - lineThickness) + 1.3, (spikeMaskOffset + lineThickness) + 1.6}
		}, {0, 1, 2, 3, 2, 1}, nil, true
	)
end

addHUDCircle(
	"Pitch_Circle_Bottom", nil, nil, "Bottom_Heading_Base", nil, nil, nil, nil, radius, radius - 1,
	360, 360 / 2.5
)


addHUDMeshPoly(
	"Zenit_Cross", nil, nil, "Top_Heading_Base", nil, nil, nil, nil,
	{{-math.rad(45) * 100, -.5}, {math.rad(45) * 100, -.5}, {-math.rad(45) * 100, .5}, {math.rad(45) * 100, .5},
		{-.5,                 -math.rad(45) * 100}, {.5, -math.rad(45) * 100}, {-.5, math.rad(45) * 100}, {.5, math.rad(45) * 100}},
	{0, 1, 2, 3, 2, 1,
		4, 5, 6, 7, 6, 5}
)

local zenitN = addHUDText(
	nil, {0, -math.rad(50) * 100}, "Top_Heading_Base", nil, nil, nil, nil, "N.", nil,
	HUDStrdefs.pitchDigit
)
copyElement(zenitN, {"init_pos", "init_rot", "value"}, {{0, math.rad(50) * 100}, {180}, "S."})
copyElement(zenitN, {"init_pos", "init_rot", "value"}, {{-math.rad(50) * 100}, {-90}, "W"})
copyElement(zenitN, {"init_pos", "init_rot", "value"}, {{math.rad(50) * 100}, {90}, "E"})

addHUDSimpleLine(
	"Zenit_Arrow", nil, nil, "Top_Heading_Base", nil, nil, nil, nil, .5,
	{{-1.45, -math.rad(37.5) * 100}, {0, -math.rad(45) * 100}, {1.45, -math.rad(37.5) * 100}}
)


addHUDMeshPoly(
	"Nadir_Cross", nil, nil, "Bottom_Heading_Base", nil, nil, nil, nil,
	{{-math.rad(5) * 100, -.5}, {math.rad(5) * 100, -.5}, {-math.rad(5) * 100, .5}, {math.rad(5) * 100, .5},
		{-.5,                -math.rad(5) * 100}, {.5, -math.rad(5) * 100}, {-.5, math.rad(5) * 100}, {.5, math.rad(5) * 100}},
	{0, 1, 2, 3, 2, 1,
		4, 5, 6, 7, 6, 5}
)

local nadirS = addHUDText(
	nil, {0, -math.rad(35) * 100}, "Bottom_Heading_Base", nil, nil, nil, nil, "S.", nil,
	HUDStrdefs.pitchDigit
)
copyElement(nadirS, {"init_pos", "init_rot", "value"}, {{0, math.rad(35) * 100}, {180}, "N."})
copyElement(nadirS, {"init_pos", "init_rot", "value"}, {{-math.rad(35) * 100}, {90}, "W"})
copyElement(nadirS, {"init_pos", "init_rot", "value"}, {{math.rad(35) * 100}, {-90}, "E"})