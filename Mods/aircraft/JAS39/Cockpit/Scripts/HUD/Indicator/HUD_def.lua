dofile(LockOn_Options.common_script_path .. "Fonts/symbols_locale.lua")
dofile(LockOn_Options.common_script_path .. "Fonts/fonts_cmn.lua")
dofile(LockOn_Options.common_script_path .. "elements_defs.lua")
dofile(LockOn_Options.script_path .. "Indicator/Common_Defs.lua")



SetScale(MILLYRADIANS)



mult = .600005 -- correct??

fov2MilRad = 230


HUDLvls = {
	def    = 4,
	mask   = 5,
	noclip = 3,
	alt    = 6,
	alt2   = 7
}

HUDStrdefs = {
	std                     = {.007, .007, 0, 0},
	headingLine             = {.005, .005, .008, .008},
	altitudeSmall           = {.005, .005, 0, 0},
	pitchDigit              = {.006, .006, 0, 0},
	alpha                   = {.0085, .0085, 0, 0},
	half                    = {.005, .005, 0, 0},
	whenYouCantFindTheDigit = {.1, .1, 0, 0},
	hundreds                = {.0042, .0042, 0, 0},
	seventyseven            = {.77 * .007, .77 * .007, 0, 0}
}



--- Converts degrees to millyradians
function d2Mr(degrees)
	return math.rad(degrees) * 1000
end


--- Adds a "ceSimple" element to the HUD.
--- @param name string The name of the element.
--- @param pos table The initial position of the element.
--- @param rot table The initial rotation of the element.
--- @param parentElement string|userdata The parent element of the element.
--- @param hClip string The clipping relation of the element.
--- @param level number The level of the element.
--- @param elementParams table The param handles of the element.
--- @param controllers table The controllers of the element.
--- @return Element ceSimple The created "ceSimple" element.
function addHUDSimple(name, pos, rot, parentElement, hClip, level, elementParams, controllers)
	return addSimple(name, pos, rot, parentElement, hClip, level or HUDLvls.def, elementParams, controllers, "HUD")
end


--- Adds a "ceMeshPoly" element to the HUD.
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
function addHUDMeshPoly(name, pos, rot, parentElement, hClip, level, elementParams, controllers, vertices, indices, material, isMask)
	return addMeshPoly(name, pos, rot, parentElement, hClip, level or HUDLvls.def, elementParams, controllers, vertices, indices, material or materials.green, isMask, "HUD")
end

--- Adds a "ceMeshPoly" element with the shape of a circle to the HUD.
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
function addHUDCircle(name, pos, rot, parentElement, hClip, level, elementParams, controllers, outerRadius, innerRadius, arc, res, material, isMask)
	return addCircle(name, pos, rot, parentElement, hClip, level or HUDLvls.def, elementParams, controllers, outerRadius, innerRadius, arc, res, material or materials.green, isMask, "HUD")
end

--- Adds a "ceSimpleLineObject" element to the HUD.
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
function addHUDSimpleLine(name, pos, rot, parentElement, hClip, level, elementParams, controllers, width, vertices, material, isMask)
	return addSimpleLine(name, pos, rot, parentElement, hClip, level or HUDLvls.def, elementParams, controllers, width or .5, vertices, material or materials.green, isMask, "HUD")
end

--- Adds a "ceSimpleLineObject" element with a width and height instead of vertices to the HUD.
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
function addHUDBox(name, pos, rot, parentElement, hClip, level, elementParams, controllers, width, height, material, isMask)
	return addBox(name, pos, rot, parentElement, hClip, level or HUDLvls.def, elementParams, controllers, width, height, material or materials.green, isMask, "HUD")
end


--- Adds a "ceStringPoly" element with static text to the HUD.
--- @param name string The name of the element.
--- @param pos table The initial position of the element.
--- @param parentElement string|userdata The parent element of the element.
--- @param hClip string The clipping relation of the element.
--- @param level number The level of the element.
--- @param elementParams table The param handles of the element.
--- @param controllers table The controllers of the element.
--- @param text string The text to display in the element.
--- @param alignment string The alignment of the text (default is align.CC).
--- @param stringdef table The text size for the text (default is HUDStrdefs.std).
--- @return table ceStringPoly The created "ceStringPoly" element.
function addHUDText(name, pos, parentElement, hClip, level, elementParams, controllers, text, alignment, stringdef)
	return addText(name, pos, nil, parentElement, hClip, level or HUDLvls.def, elementParams, controllers, text, alignment, stringdef or HUDStrdefs.std, newFonts.HUD, "HUD")
end

--- Adds a "ceStringPoly" element with a changable text (param handle) to the HUD.
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
--- @param stringdef table The text size for the text (default is HUDStrdefs.std).
--- @return table ceStringPoly The created "ceStringPoly" element.
function addHUDTextParam(name, pos, parentElement, hClip, level, elementParams, controllers, textParam, alignment, format, stringdef)
	return addTextParam(name, pos, nil, parentElement, hClip, level or HUDLvls.def, elementParams, controllers, textParam, alignment, format, stringdef or HUDStrdefs.std, newFonts.HUD, "HUD")
end