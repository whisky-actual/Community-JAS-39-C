dofile(LockOn_Options.common_script_path .. "Fonts/symbols_locale.lua")
dofile(LockOn_Options.common_script_path .. "Fonts/fonts_cmn.lua")
dofile(LockOn_Options.common_script_path .. "elements_defs.lua")
dofile(LockOn_Options.script_path .. "Indicator/Common_Defs.lua")



SetScale(MILLYRADIANS)



base = "HMD_Base"

attIndRadius = 200

aimingCircleRadius = math.rad(2) * 1000

speedscaleHeight = 42.6733

mult = 0.739292 -- correct??


lvl = {
	def    = 4,
	mask   = 5,
	noclip = 3,
	alt    = 6,
	alt2   = 7
}

strdefs = {
	std                     = {0.01, 0.01},
	alpha                   = {0.012, 0.012, 0, 0},
	half                    = {0.005, 0.005, 0, 0},
	whenYouCantFindTheDigit = {0.1, 0.1, 0, 0},
	hundreds                = {0.006, 0.006, 0, 0},
	seventyseven            = {0.0077, 0.0077, 0, 0}
}



--- Adds a "ceSimple" element to the HMD.
--- @param name string The name of the element.
--- @param pos table The initial position of the element.
--- @param rot table The initial rotation of the element.
--- @param parentElement string|userdata The parent element of the element.
--- @param hClip string The clipping relation of the element.
--- @param level number The level of the element.
--- @param elementParams table The param handles of the element.
--- @param controllers table The controllers of the element.
--- @return Element ceSimple The created "ceSimple" element.
function addHMDSimple(name, pos, rot, parentElement, hClip, level, elementParams, controllers)
	return addSimple(name, pos, rot, parentElement, hClip, level or lvl.def, elementParams, controllers, "HMD")
end


--- Adds a "ceMeshPoly" element to the HMD.
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
--- @return table ceMeshPoly The created "ceMeshPoly" element.
function addHMDMeshPoly(name, pos, rot, parentElement, hClip, level, elementParams, controllers, vertices, indices, material, isMask)
	return addMeshPoly(name, pos, rot, parentElement, hClip, level or lvl.def, elementParams, controllers, vertices, indices, material or materials.green, isMask, "HMD")
end

--- Adds a "ceMeshPoly" element with the shape of a circle to the HMD.
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
--- @return table ceMeshPoly The created "ceMeshPoly" element with the shape of a circle.
function addHMDCircle(name, pos, rot, parentElement, hClip, level, elementParams, controllers, outerRadius, innerRadius, arc, res, material, isMask)
	return addCircle(name, pos, rot, parentElement, hClip, level or lvl.def, elementParams, controllers, outerRadius, innerRadius, arc, res, material or materials.green, isMask, "HMD")
end

--- Adds a "ceSimpleLineObject" element to the HMD.
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
--- @return table simpleLine The created "ceSimpleLineObject" element.
function addHMDSimpleLine(name, pos, rot, parentElement, hClip, level, elementParams, controllers, width, vertices, material, isMask)
	return addSimpleLine(name, pos, rot, parentElement, hClip, level or lvl.def, elementParams, controllers, width or .5, vertices, material or materials.green, isMask, "HMD")
end

--- Adds a "ceSimpleLineObject" element with a width and height instead of vertices to the HMD.
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
--- @return table ceSimpleLineObject The created "ceSimpleLineObject" element with a width and height.
function addHMDBox(name, pos, rot, parentElement, hClip, level, elementParams, controllers, width, height, material, isMask)
	return addBox(name, pos, rot, parentElement, hClip, level or lvl.def, elementParams, controllers, width, height, material or materials.green, isMask, "HMD")
end


--- Adds a "ceStringPoly" element with static text to the HMD.
--- @param name string The name of the element.
--- @param pos table The initial position of the element.
--- @param parentElement string|userdata The parent element of the element.
--- @param hClip string The clipping relation of the element.
--- @param level number The level of the element.
--- @param elementParams table The param handles of the element.
--- @param controllers table The controllers of the element.
--- @param text string The text to display in the element.
--- @param alignment string The alignment of the text (default is align.CC).
--- @param stringdef table The text size for the text (default is strdefs.std).
--- @return table ceStringPoly The created "ceStringPoly" element.
function addHMDText(name, pos, parentElement, hClip, level, elementParams, controllers, text, alignment, stringdef)
	return addText(name, pos, nil, parentElement, hClip, level or lvl.def, elementParams, controllers, text, alignment, stringdef or strdefs.std, newFonts.HUD, "HMD")
end

--- Adds a "ceStringPoly" element with a changable text (param handle) to the HMD.
--- @param name string The name of the element.
--- @param pos table The initial position of the element.
--- @param parentElement string|userdata The parent element of the element.
--- @param hClip string The clipping relation of the element.
--- @param level number The level of the element.
--- @param elementParams table The param handles of the element.
--- @param controllers table The controllers of the element.
--- @param textParam string The param handle to use for the text.
--- @param alignment string The alignment of the text (default is align.CC).
--- @param format table The formats for the text (default is {"%.0f"}, use {"%s"} for param handles that are strings).
--- @param stringdef table The text size for the text (default is strdefs.std).
--- @return table ceStringPoly The created "ceStringPoly" element.
function addHMDTextParam(name, pos, parentElement, hClip, level, elementParams, controllers, textParam, alignment, format, stringdef)
	return addTextParam(name, pos, nil, parentElement, hClip, level or lvl.def, elementParams, controllers, textParam, alignment, format, stringdef or strdefs.std, newFonts.HUD, "HMD")
end