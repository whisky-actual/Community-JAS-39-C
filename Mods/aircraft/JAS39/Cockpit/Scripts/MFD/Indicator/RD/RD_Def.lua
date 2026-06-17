dofile(LockOn_Options.common_script_path .. "Fonts/symbols_locale.lua")
dofile(LockOn_Options.common_script_path .. "Fonts/fonts_cmn.lua")
dofile(LockOn_Options.common_script_path .. "elements_defs.lua")
dofile(LockOn_Options.script_path .. "Indicator/Common_Defs.lua")



halfHeight = GetHalfHeight()
height = halfHeight * 2

halfWidth = GetHalfWidth()
width = halfWidth * 2

leftEdgeX = -.96
SK1 = {leftEdgeX, 1.13}
SK2 = {leftEdgeX, .85}
SK3 = {leftEdgeX, .5575}
SK4 = {leftEdgeX, .275}
SK5 = {leftEdgeX, -.015}
SK6 = {leftEdgeX, -.295}
SK7 = {leftEdgeX, -.5775}

lowerEdgeY = -1.29
SK8 = {-.785, lowerEdgeY}
SK9 = {-.49, lowerEdgeY}
SK10 = {-.2085, lowerEdgeY}
SK11 = {.115, lowerEdgeY}
SK12 = {.365, lowerEdgeY}

rightEdgeX = .935
SK14 = {rightEdgeX, -.5775}
SK16 = {rightEdgeX, -.015}
SK17 = {rightEdgeX, .275}
SK18 = {rightEdgeX, .5575}
SK20 = {rightEdgeX, 1.13}

TBOffsets = {
	x1 = .65 * halfWidth - .01725 * 2,
	x2 = .65 * halfWidth - .01725,
	x3 = .65 * halfWidth,
	y3 = .75 * halfWidth,
	y4 = 1.5 * .75 * halfWidth, -- Outer 2
	y4I = (1.5 * .75 * halfWidth) / 3, -- Inner 2
}

lineThickness = .006 * halfWidth

altInFtGain = .00000071

lvls = { -- RD levels start on 10
	def    = 11,
	mask   = 12,
	noclip = 10
}

strdefs = { -- Font size (vertical_size, horizontal_size, horizontal_spacing, vertical_spacing)
	std                    = {.0049, .0049, 0, -.0002},
	small                  = {.0045, .0045, 0, 0},
	half                   = {.0025, .0025, 0, 0},
	whenYouCantFindTheText = {.1, .1, 0, 0}
}



--- Adds a "ceSimple" element.
--- @param name string The name of the element.
--- @param pos table The initial position of the element.
--- @param rot table The initial rotation of the element.
--- @param parentElement string|userdata The parent element of the element.
--- @param hClip string The clipping relation of the element.
--- @param level number The level of the element.
--- @param elementParams table The parameters of the element.
--- @param controllers table The controllers of the element.
--- @return Element @ The created "ceSimple" element.
function addRDSimple(name, pos, rot, parentElement, hClip, level, elementParams, controllers)
	if pos then for i = 1, 3 do if pos[i] ~= nil then pos[i] = pos[i] * halfWidth end end end

	return addSimple(name, pos, rot, parentElement, hClip, level or lvls.def, elementParams, controllers)
end


--- Adds a "ceMeshPoly" element.
--- @param name string The name of the element.
--- @param pos table The initial position of the element.
--- @param rot table The initial rotation of the element.
--- @param parentElement string|userdata The parent element of the element.
--- @param hClip string The clipping relation of the element.
--- @param level number The level of the element.
--- @param elementParams table The parameters of the element.
--- @param controllers table The controllers of the element.
--- @param vertices table The vertices of the mesh.
--- @param indices table The indices of the mesh.
--- @param material string The material of the mesh.
--- @param isMask boolean Whether the element is invisible or not.
--- @return table The created "ceMeshPoly" element.
function addRDMeshPoly(
	name, pos, rot, parentElement, hClip, level, elementParams, controllers, vertices, indices,
	material, isMask
)
	if pos then for i = 1, 3 do if pos[i] ~= nil then pos[i] = pos[i] * halfWidth end end end

	if vertices then
		for i, vert in ipairs(vertices) do
			for j, coord in ipairs(vert) do
				vertices[i][j] = coord * halfWidth
			end
		end
	end

	return addMeshPoly(name, pos, rot, parentElement, hClip, level or lvls.def, elementParams, controllers, vertices, indices, material or materials["MFDFGGray"], isMask)
end

--- Adds a "ceMeshPoly" element with a circle shape.
--- @param name string The name of the element.
--- @param pos table The initial position of the element.
--- @param rot table The initial rotation of the element.
--- @param parentElement string|userdata The parent element of the element.
--- @param hClip string The clipping relation of the element.
--- @param level number The level of the element.
--- @param elementParams table The parameters of the element.
--- @param controllers table The controllers of the element.
--- @param outerRadius number The outer radius of the circle.
--- @param innerRadius number The inner radius of the circle.
--- @param arc number The arc of the circle in degrees.
--- @param res number The resolution of the circle (number of segments).
--- @param material string The material of the mesh.
--- @param isMask boolean Whether the element is invisible or not.
--- @return table The created "ceMeshPoly" element with a circle shape.
function addRDCircle(
	name, pos, rot, parentElement, hClip, level, elementParams, controllers, outerRadius,
	innerRadius, arc, res, material, isMask
)
	if pos then for i = 1, 3 do if pos[i] ~= nil then pos[i] = pos[i] * halfWidth end end end

	return addCircle(name, pos, rot, parentElement, hClip, level or lvls.def, elementParams, controllers, outerRadius, innerRadius, arc, res, material or materials["MFDFGGray"], isMask)
end

--- Adds a "ceSimpleLineObject" element.
--- @param name string The name of the element.
--- @param pos table The initial position of the element.
--- @param rot table The initial rotation of the element.
--- @param parentElement string|userdata The parent element of the element.
--- @param hClip string The clipping relation of the element.
--- @param level number The level of the element.
--- @param elementParams table The parameters of the element.
--- @param controllers table The controllers of the element.
--- @param iWidth number The width of the line.
--- @param vertices table The vertices of the line.
--- @param material string The material of the line.
--- @param isMask boolean Whether the element is invisible or not.
--- @return table The created "ceSimpleLineObject" element.
function addRDSimpleLine(
	name, pos, rot, parentElement, hClip, level, elementParams, controllers, iWidth, vertices,
	material, isMask
)
	if pos then
		for i = 1, 3 do
			if pos[i] ~= nil then
				pos[i] = pos[i] * halfWidth
			end
		end
	end

	if vertices then
		for i, vert in ipairs(vertices) do
			for j, coord in ipairs(vert) do
				vertices[i][j] = coord * halfWidth
			end
		end
	end

	return addSimpleLine(name, pos, rot, parentElement, hClip, level or lvls.def, elementParams, controllers, iWidth or lineThickness / 2, vertices, material or materials["MFDFGGray"], isMask)
end

--- Adds a "ceSimpleLineObject" element with a width and height instead of vertices.
--- @param name string The name of the element.
--- @param pos table The initial position of the element.
--- @param rot table The initial rotation of the element.
--- @param parentElement string|userdata The parent element of the element.
--- @param hClip string The clipping relation of the element.
--- @param level number The level of the element.
--- @param elementParams table The parameters of the element.
--- @param controllers table The controllers of the element.
--- @param iWidth number The width of the box.
--- @param iHeight number The height of the box.
--- @param material string The material of the box.
--- @param isMask boolean Whether the element is invisible or not.
--- @return table The created "ceSimpleLineObject" element with a width and height.
function addRDBox(
	name, pos, rot, parentElement, hClip, level, elementParams, controllers, iWidth, iHeight,
	material, isMask
)
	if pos then for i = 1, 3 do if pos[i] ~= nil then pos[i] = pos[i] * halfWidth end end end

	if iWidth then iWidth = iWidth * halfWidth end

	return addBox(
		name, pos, rot, parentElement, hClip, level or lvls.def, elementParams, controllers, iWidth or lineThickness, iHeight * halfWidth or width * lineThickness * 2,
		material or materials["MFDFGGray"], isMask
	)
end

--- Adds a "ceStringPoly" element with static text.
--- @param name string The name of the element.
--- @param pos table The initial position of the element.
--- @param rot table The initial rotation of the element.
--- @param parentElement string|userdata The parent element of the element.
--- @param hClip string The clipping relation of the element.
--- @param level number The level of the element.
--- @param elementParams table The parameters of the element.
--- @param controllers table The controllers of the element.
--- @param text string The text to display in the element.
--- @param alignment string The alignment of the text (default is align.CC).
--- @param stringdef table The text size for the text (default is strdefs.std).
--- @param font string The font to use for the text (default is newFonts["MFD_MFDFGGray"]).
--- @return table The created "ceStringPoly" element.
function addRDText(
	name, pos, rot, parentElement, hClip, level, elementParams, controllers, text, alignment,
	stringdef, font
)
	if pos then for i = 1, 3 do if pos[i] ~= nil then pos[i] = pos[i] * halfWidth end end end

	return addText(
		name, pos, rot, parentElement, hClip, level or lvls.def, elementParams, controllers, text or "Lorem Ipsum", alignment, stringdef or strdefs.std,
		font or newFonts["MFD_MFDFGGray"]
	)
end

--- Adds a "ceStringPoly" element with a changable text (parameter).
--- @param name string The name of the element.
--- @param pos table The initial position of the element.
--- @param rot table The initial rotation of the element.
--- @param parentElement string|userdata The parent element of the element.
--- @param hClip string The clipping relation of the element.
--- @param level number The level of the element.
--- @param elementParams table The parameters of the element.
--- @param controllers table The controllers of the element.
--- @param textParam string The parameter to use for the text.
--- @param alignment string The alignment of the text (default is align.CC).
--- @param format table The formats for the text (default is {"%.0f"}, use {"%s"} for parameters that are strings).
--- @param stringdef table The text size for the text (default is strdefs.std).
--- @param font string The font to use for the text (default is newFonts["MFD_MFDFGGray"]).
--- @return table The created "ceStringPoly" element.
function addRDTextParam(
	name, pos, rot, parentElement, hClip, level, elementParams, controllers, textParam,
	alignment, format, stringdef, font
)
	if pos then for i = 1, 3 do if pos[i] ~= nil then pos[i] = pos[i] * halfWidth end end end

	return addTextParam(
		name, pos, rot, parentElement, hClip, level or lvls.def, elementParams, controllers, textParam, alignment, format, stringdef or strdefs.std,
		font or newFonts["MFD_MFDFGGray"]
	)
end


--- Adds a box with text inside it.
--- @param name string The name of the element.
--- @param pos table The initial position of the element.
--- @param rot table The initial rotation of the element.
--- @param parentElement string|userdata The parent element of the element.
--- @param hClip string The clipping relation of the element.
--- @param level number The level of the element.
--- @param elementParams table The parameters of the element.
--- @param controllers table The controllers of the element.
--- @param edgeMaterial string The material of the edge (defualt is materials["MFDFGGray"]).
--- @param iInnerWidth number The inner width of the box (nil will default to text width).
--- @param iInnerHeight number The inner height of the box (nil will default to text height).
--- @param vertical boolean Whether the box should be vertical or not.
--- @param edgeParams table The param handles of the edge.
--- @param edgeControllers table The controllers of the edge.
--- @param text string The text to display inside the box.
--- @param alignment string The alignment of the text (default is align.CC).
--- @param iStringdef table The text size for the text (default is strdefs.std).
--- @param font string The font to use for the text (default is newFonts["MFD_MFDFGGray"]).
--- @return table @The "ceSimple" element which is parent to the box and text.
function addRDTextBox(
	name, pos, rot, parentElement, hClip, level, elementParams, controllers, edgeMaterial,
	iInnerWidth, iInnerHeight, vertical, edgeParams, edgeControllers, text, alignment, iStringdef, font
)
	local stringdef = iStringdef or strdefs.std

	local innerHeight = 0
	local innerWidth  = 0
	local margin      = .00045
	local lengthMult  = stringdef[1] / 2 + margin
	local height      = stringdef[1]
	local boxYOffset  = .00015 / halfWidth

	if iInnerHeight then
		innerHeight = height + iInnerHeight + margin
	else
		innerHeight = height + margin
	end

	if iInnerWidth then
		innerWidth = string.len(text) * lengthMult + iInnerWidth + margin * 2
	else
		innerWidth = string.len(text) * lengthMult + margin * 2
	end

	if vertical then
		local tmp = innerHeight
		innerHeight = innerWidth - margin * 2.5
		innerWidth = tmp - margin * 2.5
	end



	local parent = addRDSimple(name, pos, rot, parentElement, hClip, level, elementParams, controllers)
	local edgeParent = addRDSimple(nil, {0, boxYOffset}, nil, parent, nil, nil, edgeParams, edgeControllers)

	for i = -1, 1, 2 do
		local halfIW = innerWidth / 2
		local xPos = i * halfIW / halfWidth
		local halfIH = innerHeight / 2
		local normHalfIH = halfIH / halfWidth

		local sideLines = addRDSimpleLine(
			nil, {xPos}, nil, edgeParent, nil, nil, nil, nil, nil,
			{{0, -normHalfIH}, {0, normHalfIH}}, edgeMaterial
		)
		copyElement(sideLines, {"init_pos", "vertices"}, {{0, i * halfIH}, {{-halfIW}, {halfIW}}})

		local upperCircles = addRDCircle( -- TODO: Optimize circles, 90 deg arc
			nil, {-xPos, normHalfIH}, nil, edgeParent, nil, nil, nil, nil,
			lineThickness / 2, 0, 360, 10
		)
		copyElement(upperCircles, {"init_pos"}, {{i * -halfIW, -halfIH}})
	end

	addRDText(nil, nil, rot, parent, hClip, level, nil, nil, text, alignment, stringdef, font or newFonts["MFD_MFDFGGray"])

	return parent
end