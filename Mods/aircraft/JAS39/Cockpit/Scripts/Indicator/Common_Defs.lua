dofile(LockOn_Options.common_script_path .. "Fonts/symbols_locale.lua")
dofile(LockOn_Options.common_script_path .. "Fonts/fonts_cmn.lua")
dofile(LockOn_Options.common_script_path .. "elements_defs.lua")
dofile(LockOn_Options.script_path .. "Indicator/Fonts.lua")



align = {
	CB = "CenterBottom",
	CC = "CenterCenter",
	CT = "CenterTop",
	LB = "LeftBottom",
	LC = "LeftCenter",
	LT = "LeftTop",
	RB = "RightBottom",
	RC = "RightCenter",
	RT = "RightTop"
}

ctrl = {
	argInRange    = "draw_argument_in_range",                   -- {ctrl.argInRange, argNum, greaterThanValue, lessThanValue} If greaterThanValue < argValue < lessThanValue then obj is visible.
	changeColor   = "change_color_when_parameter_equal_to_number", -- {ctrl.changeColor, paramNum, num, r, g, b} If paramNum == num then set color to rgb.
	compareNum    = "parameter_compare_with_number",            -- {ctrl.compareNum, paramNum, num} If paramValue == num then obj is visible.
	compareParams = "compare_parameters",                       -- {ctrl.compare, param1Num, param2Num} If param1Value == param1Value then obj is visible.
	inRange       = "parameter_in_range",                       -- {ctrl.inRange, paramNum, greaterThanValue, lessThanValue} If greaterThanValue < paramValue < lessThanValue then obj is visible.
	moveX         = "move_left_right_using_parameter",          -- {ctrl.moveX, paramNum, gain} Moves obj 1 gain on the x plane per value.
	moveY         = "move_up_down_using_parameter",             -- {ctrl.moveY, paramNum, gain} Moves obj 1 gain on the y plane per value.
	opacity       = "opacity_using_parameter",                  -- {ctrl.opacity, paramNum} Changes opacity with value (1 = 100%, 0 = 0%).
	rotate        = "rotate_using_parameter",                   -- {ctrl.rotate, paramNum, gain} Rotates obj 1 gain per value.
	setPoint      = "line_object_set_point_using_parameters",   -- {ctrl.setPoint, verticeNum, paramX, paramY, gainX, gainY} (ONLY APPLIES TO "ceSimpleLineObject") Moves verticeNum 1 gainX on the x plane per paramXValue + Moves verticeNum 1 gainY on the y plane per paramYValue.
	text          = "text_using_parameter"                      -- {ctrl.text, paramNum, formatNum} Prints paramNum value (dunno what formatNum means).
}

hcr = {
	cmp = h_clip_relations.COMPARE,
	dec = h_clip_relations.DECREASE_LEVEL,
	decIf = h_clip_relations.DECREASE_IF_LEVEL,
	inc = h_clip_relations.INCREASE_LEVEL,
	incIf = h_clip_relations.INCREASE_IF_LEVEL,
	rw = h_clip_relations.REWRITE_LEVEL
}

-- strdefs = { -- Font size (vertical_size, horizontal_size, horizontal_spacing, vertical_spacing)
-- 	std = {.005, .005, .0004, 0},
-- 	whenYouCantFindTheText = {.1, .1, 0, 0},
-- 	bold = {.007, .007, .0004, 0},
-- 	small = {.004, .004, .0004, 0},
-- 	xtraSmall = {.00325, .00325, .000325, 0},
-- 	big = {.006, .006, .0004, 0},
-- 	veryBig = {.009, .009, .0004, 0}
-- }



--- Adds brightness control.
--- @param obj Element The element to add brightness control to.
--- @param elementParams table The param handles of the element.
--- @param controllers table The controllers of the element.
--- @param collimationType string The collimation type of the element ("HUD"/"HMD" for collimated elements, nil for non-collimated elements).
function addBrightnessControl(obj, elementParams, controllers, collimationType)
	if elementParams and controllers then
		elementParams[#elementParams+1] = collimationType .. "Brightness"
		controllers[#controllers+1]     = {ctrl.opacity, #elementParams - 1}

		obj.element_params = elementParams
		obj.controllers    = controllers
	else
		obj.element_params = {collimationType .. "Brightness"}
		obj.controllers    = {{ctrl.opacity, 0}}
	end
end

--- Sets properties for an element.
--- @param obj Element The element to set properties for.
--- @param name string The name of the element.
--- @param pos table The initial position of the element.
--- @param rot table The initial rotation of the element.
--- @param parentElement string|userdata The parent element of the element.
--- @param hClip string The clipping relation of the element.
--- @param level number The level of the element.
--- @param elementParams table The param handles of the element.
--- @param controllers table The controllers of the element.
--- @param isMask boolean Whether the element is invisible or not.
--- @param collimationType string The collimation type of the element ("HUD"/"HMD" for collimated elements, nil for non-collimated elements).
--- @return Element obj The element with the set properties.
function setCommonProperties(
	obj, name, pos, rot, parentElement, hClip, level, elementParams, controllers, isMask,
	collimationType
)
	obj.name     = name or create_guid_string()
	obj.init_pos = pos
	obj.init_rot = rot
	if parentElement then
		if type(parentElement) == "userdata" and parentElement.name then
			obj.parent_element = parentElement.name
		elseif type(parentElement) == "string" then
			obj.parent_element = parentElement
		end
	end
	obj.h_clip_relation = hClip or hcr.cmp
	obj.level           = level
	obj.use_mipfilter   = true
	if collimationType then
		obj.collimated     = true
		obj.additive_alpha = true
		obj.blend_mode     = blend_mode.IBM_REGULAR_ADDITIVE_ALPHA
		addBrightnessControl(obj, elementParams, controllers, collimationType)
	else
		obj.collimated     = false
		obj.additive_alpha = false
		obj.blend_mode     = blend_mode.IBM_REGULAR
		obj.element_params = elementParams
		obj.controllers    = controllers
	end
	obj.isvisible = not isMask -- Needs to be after blend_mode setting for some fuckass reason.
	Add(obj)

	return obj
end


--- Copies an element and changes its properties based on the provided param handles.
--- @param obj Element The element to copy.
--- @param change table A table containing the properties to change.
--- @param value table A table containing the new values for the properties.
--- @return table copyObj The copied element with the changed properties.
function copyElement(obj, change, value)
	local num = 0

	if #change == #value then
		num = #value
	else
		return
	end


	local copyObj = Copy(obj)
	for i = 1, num do
		copyObj[change[i]] = value[i]
	end
	Add(copyObj)

	return copyObj
end


--- Adds a "ceSimple" element.
--- @param name string The name of the element.
--- @param pos table The initial position of the element.
--- @param rot table The initial rotation of the element.
--- @param parentElement string|userdata The parent element of the element.
--- @param hClip string The clipping relation of the element.
--- @param level number The level of the element.
--- @param elementParams table The param handles of the element.
--- @param controllers table The controllers of the element.
--- @param collimationType string The collimation type of the element ("HUD"/"HMD" for collimated elements, nil for non-collimated elements).
--- @return Element ceSimple The created "ceSimple" element.
function addSimple(name, pos, rot, parentElement, hClip, level, elementParams, controllers, collimationType)
	local simple = CreateElement "ceSimple"
	setCommonProperties(simple, name, pos, rot, parentElement, hClip, level, elementParams, controllers, false, collimationType)

	return simple
end


--- Adds a "ceMeshPoly" element.
--- @param name string The name of the element.
--- @param pos table The initial position of the element.
--- @param rot table The initial rotation of the element.
--- @param parentElement string|userdata The parent element of the element.
--- @param hClip string The clipping relation of the element.
--- @param level number The level of the element.
--- @param elementParams table The param handles of the element.
--- @param controllers table The controllers of the element.
--- @param vertices table The vertices of the mesh.
--- @param indices table The indices of the mesh.
--- @param material string The material of the mesh.
--- @param isMask boolean Whether the element is invisible or not.
--- @param collimationType string The collimation type of the element ("HUD"/"HMD" for collimated elements, nil for non-collimated elements).
--- @return table ceMeshPoly The created "ceMeshPoly" element.
function addMeshPoly(
	name, pos, rot, parentElement, hClip, level, elementParams, controllers, vertices, indices,
	material, isMask, collimationType
)
	local meshPoly         = CreateElement "ceMeshPoly"
	meshPoly.primitivetype = "triangles"
	meshPoly.vertices      = vertices
	meshPoly.indices       = indices
	meshPoly.material      = material
	setCommonProperties(meshPoly, name, pos, rot, parentElement, hClip, level, elementParams, controllers, isMask, collimationType)

	return meshPoly
end

--- Adds a "ceMeshPoly" element with the shape of a circle.
--- @param name string The name of the element.
--- @param pos table The initial position of the element.
--- @param rot table The initial rotation of the element.
--- @param parentElement string|userdata The parent element of the element.
--- @param hClip string The clipping relation of the element.
--- @param level number The level of the element.
--- @param elementParams table The param handles of the element.
--- @param controllers table The controllers of the element.
--- @param outerRadius number The outer radius of the circle.
--- @param innerRadius number The inner radius of the circle.
--- @param arc number The arc of the circle in degrees.
--- @param res number The resolution of the circle (number of segments).
--- @param material string The material of the mesh.
--- @param isMask boolean Whether the element is invisible or not.
--- @param collimationType string The collimation type of the element ("HUD"/"HMD" for collimated elements, nil for non-collimated elements).
--- @return table ceMeshPoly The created "ceMeshPoly" element with the shape of a circle.
function addCircle(
	name, pos, rot, parentElement, hClip, level, elementParams, controllers, outerRadius,
	innerRadius, arc, res, material, isMask, collimationType
)
	local circle = {}
	set_circle(circle, outerRadius, innerRadius, arc, res)

	return addMeshPoly(name, pos, rot, parentElement, hClip, level, elementParams, controllers, circle.vertices, circle.indices, material, isMask, collimationType)
end

--- Adds a "ceSimpleLineObject" element.
--- @param name string The name of the element.
--- @param pos table The initial position of the element.
--- @param rot table The initial rotation of the element.
--- @param parentElement string|userdata The parent element of the element.
--- @param hClip string The clipping relation of the element.
--- @param level number The level of the element.
--- @param elementParams table The param handles of the element.
--- @param controllers table The controllers of the element.
--- @param width number The width of the line.
--- @param vertices table The vertices of the line.
--- @param material string The material of the line.
--- @param isMask boolean Whether the element is invisible or not.
--- @param collimationType string The collimation type of the element ("HUD"/"HMD" for collimated elements, nil for non-collimated elements).
--- @return table simpleLine The created "ceSimpleLineObject" element.
function addSimpleLine(
	name, pos, rot, parentElement, hClip, level, elementParams, controllers, width, vertices,
	material, isMask, collimationType
)
	local simpleLine    = CreateElement "ceSimpleLineObject"
	simpleLine.width    = width
	simpleLine.vertices = vertices or {{0}, {0}}
	simpleLine.material = material
	setCommonProperties(simpleLine, name, pos, rot, parentElement, hClip, level, elementParams, controllers, isMask, collimationType)

	return simpleLine
end

--- Adds a "ceSimpleLineObject" element with a width and height instead of vertices.
--- @param name string The name of the element.
--- @param pos table The initial position of the element.
--- @param rot table The initial rotation of the element.
--- @param parentElement string|userdata The parent element of the element.
--- @param hClip string The clipping relation of the element.
--- @param level number The level of the element.
--- @param elementParams table The param handles of the element.
--- @param controllers table The controllers of the element.
--- @param width number The width of the box.
--- @param height number The height of the box.
--- @param material string The material of the box.
--- @param isMask boolean Whether the element is invisible or not.
--- @param collimationType string The collimation type of the element ("HUD"/"HMD" for collimated elements, nil for non-collimated elements).
--- @return table ceSimpleLineObject The created "ceSimpleLineObject" element with a width and height.
function addBox(
	name, pos, rot, parentElement, hClip, level, elementParams, controllers, width, height,
	material, isMask, collimationType
)
	return addSimpleLine(name, pos, rot, parentElement, hClip, level, elementParams, controllers, width / 2, {{0, height / 2}, {0, -height / 2}}, material, isMask, collimationType)
end


--- Adds a "ceStringPoly" element with static text.
--- @param name string The name of the element.
--- @param pos table The initial position of the element.
--- @param rot table The initial rotation of the element.
--- @param parentElement string|userdata The parent element of the element.
--- @param hClip string The clipping relation of the element.
--- @param level number The level of the element.
--- @param elementParams table The param handles of the element.
--- @param controllers table The controllers of the element.
--- @param text string The text to display in the element.
--- @param alignment string The alignment of the text (default is align.CC).
--- @param stringdef table The text size for the text (default is strdefs.std).
--- @param font string The font to use for the text.
--- @param collimationType string The collimation type of the element ("HUD"/"HMD" for collimated elements, nil for non-collimated elements).
--- @return table ceStringPoly The created "ceStringPoly" element.
function addText(
	name, pos, rot, parentElement, hClip, level, elementParams, controllers, text, alignment,
	stringdef, font, collimationType
)
	local textObj      = CreateElement "ceStringPoly"
	textObj.value      = text
	textObj.alignment  = alignment or align.CC
	textObj.stringdefs = stringdef
	textObj.material   = font
	setCommonProperties(textObj, name, pos, rot, parentElement, hClip, level, elementParams, controllers, false, collimationType)

	return textObj
end

--- Adds a "ceStringPoly" element with a changable text (param handle).
--- @param name string The name of the element.
--- @param pos table The initial position of the element.
--- @param rot table The initial rotation of the element.
--- @param parentElement string|userdata The parent element of the element.
--- @param hClip string The clipping relation of the element.
--- @param level number The level of the element.
--- @param elementParams table The param handles of the element.
--- @param controllers table The controllers of the element.
--- @param textParam string The param handle to use for the text.
--- @param alignment string The alignment of the text (default is align.CC).
--- @param format table The formats for the text (default is {"%.0f"}, use {"%s"} for param handles that are strings).
--- @param stringdef table The text size for the text (default is strdefs.std).
--- @param font string The font to use for the text.
--- @param collimationType string The collimation type of the element ("HUD"/"HMD" for collimated elements, nil for non-collimated elements).
--- @return table ceStringPoly The created "ceStringPoly" element.
function addTextParam(
	name, pos, rot, parentElement, hClip, level, elementParams, controllers, textParam,
	alignment, format, stringdef, font, collimationType
)
	if textParam and elementParams and controllers then
		elementParams[#elementParams+1] = {textParam}
		controllers[#controllers+1]     = {{ctrl.text, #elementParams - 1}}
	elseif textParam then
		elementParams = {textParam}
		controllers   = {{ctrl.text, 0}}
	end


	local textObj      = CreateElement "ceStringPoly"
	textObj.alignment  = alignment or align.CC
	textObj.stringdefs = stringdef
	textObj.formats    = format or {"%.0f"}
	textObj.material   = font
	setCommonProperties(textObj, name, pos, rot, parentElement, hClip, level, elementParams, controllers, false, collimationType)

	return textObj
end


--- Creates a table with texture coordinates for a texture box.
--- @param ULX integer The upper left X coordinate of the texture.
--- @param ULY integer The upper left Y coordinate of the texture.
--- @param W integer The width of the texture.
--- @param H integer The height of the texture.
--- @param texSizeX integer The width of the texture file.
--- @param texSizeY integer The height of the texture file.
function createTexBox(ULX, ULY, W, H, texSizeX, texSizeY)
	local ux = ULX / texSizeX
	local uy = ULY / texSizeY
	local w  = W / texSizeX
	local h  = H / texSizeY
	return {{ux, uy}, {ux + w, uy}, {ux + w, uy + h}, {ux, uy + h}}
end

--- Adds a "ceTexPoly" element from a texture file.
--- @param name string The name of the element.
--- @param pos table The initial position of the element.
--- @param rot table The initial rotation of the element.
--- @param parentElement string|userdata The parent element of the element.
--- @param hClip string The clipping relation of the element.
--- @param level number The level of the element.
--- @param elementParams table The param handles of the element.
--- @param controllers table The controllers of the element.
--- @param texture table The material defined texture.
--- @param upperLeftX integer The upper left X coordinate of the texture.
--- @param upperLeftY integer The upper left Y coordinate of the texture.
--- @param lowerRightX integer The lower right X coordinate of the texture.
--- @param lowerRightY integer The lower right Y coordinate of the texture.
--- @param scale number The scale of the texture (default is 1).
--- @param centerX integer The center X coordinate of the texture (default is the center of the texture).
--- @param centerY integer The center Y coordinate of the texture (default is the center of the texture).
--- @param isMask boolean Whether the texture is a mask (default is false).
--- @return table The created "ceTexPoly" element.
function addTex(
	name, pos, rot, parentElement, hClip, level, elementParams, controllers, texture, upperLeftX,
	upperLeftY, lowerRightX, lowerRightY, scale, centerX, centerY, isMask
)
	local finalScale = scale or 1

	local milsPerPixel = finalScale / (1024 * 16)
	local width        = lowerRightX - upperLeftX
	local height       = lowerRightY - upperLeftY
	local autoCenterX  = upperLeftX + 0.5 * width
	local autoCenterY  = upperLeftY + 0.5 * height

	local CX            = centerX or autoCenterX
	local CY            = centerY or autoCenterY
	local centerOffSetX = milsPerPixel * (CX - autoCenterX)
	local centerOffSetY = milsPerPixel * (CY - autoCenterY)

	local halfX = 0.47 * width * milsPerPixel
	local halfY = 0.49 * height * milsPerPixel


	local texElement      = CreateElement "ceTexPoly"
	texElement.material   = texture
	texElement.vertices   = {{-halfX - centerOffSetX, halfY + centerOffSetY}, {halfX - centerOffSetX, halfY + centerOffSetY}, {halfX - centerOffSetX, -halfY + centerOffSetY}, {-halfX - centerOffSetX, -halfY + centerOffSetY}}
	texElement.tex_coords = createTexBox(upperLeftX, upperLeftY, width, height, 1042, 1042)
	texElement.indices    = {0, 1, 2, 0, 2, 3}
	setCommonProperties(texElement, name, pos, rot, parentElement, hClip, level, elementParams, controllers, isMask)

	return texElement
end