dofile(LockOn_Options.common_script_path .. "Fonts/symbols_locale.lua")
dofile(LockOn_Options.common_script_path .. "Fonts/fonts_cmn.lua")
dofile(LockOn_Options.common_script_path .. "elements_defs.lua")



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
	argInRange    = "draw_argument_in_range",                      --{ctrl.argInRange,argNum, greaterThanValue, lessThanValue} If greaterThanValue < argValue < lessThanValue then obj is visible.
	changeColor   = "change_color_when_parameter_equal_to_number", --{ctrl.changeColor,paramNum, num, r, g, b} If paramNum == num then set color to rgb.
	compareNum    = "parameter_compare_with_number",               --{ctrl.compareNum,paramNum, num} If paramValue == num then obj is visible.
	compareParams = "compare_parameters",                          --{ctrl.compare,param1Num, param2Num} If param1Value == param1Value then obj is visible.
	inRange       = "parameter_in_range",                          --{ctrl.inRange,paramNum, greaterThanValue, lessThanValue} If greaterThanValue < paramValue < lessThanValue then obj is visible.
	moveX         = "move_left_right_using_parameter",             --{ctrl.moveX,paramNum, gain} Moves obj 1 gain on the x plane per value.
	moveY         = "move_up_down_using_parameter",                --{ctrl.moveY,paramNum, gain} Moves obj 1 gain on the y plane per value.
	opacity       = "opacity_using_parameter",                     --{ctrl.opacity,paramNum} Changes opacity with value (1 = 100%, 0 = 0%).
	rotate        = "rotate_using_parameter",                      --{ctrl.rotate,paramNum, gain} Rotates obj 1 gain per value.
	setPoint      = "line_object_set_point_using_parameters",      --{ctrl.setPoint,verticeNum, paramX, paramY, gainX, gainY} (ONLY APPLIES TO "ceSimpleLineObject") Moves verticeNum 1 gainX on the x plane per paramXValue + Moves verticeNum 1 gainY on the y plane per paramYValue.
	text          = "text_using_parameter"                         --{ctrl.text,paramNum, formatNum} Prints paramNum value (dunno what formatNum means).
}


hcr = {
	cmp   = h_clip_relations.COMPARE, 
	dec   = h_clip_relations.DECREASE_LEVEL, 
	decIf = h_clip_relations.DECREASE_IF_LEVEL, 
	inc   = h_clip_relations.INCREASE_LEVEL, 
	incIf = h_clip_relations.INCREASE_IF_LEVEL, 
	rw    = h_clip_relations.REWRITE_LEVEL
}


matl = {
	g    = {0, 255, 0, 255}, 
	mG   = MakeMaterial(nil, {0, 255, 0, 255}), 
	mask = MakeMaterial(nil, {255, 0, 0, 255/2})
}



--Fonts
local HUDXPixel = 88
local HUDYPixel = 144

local HUDFont = {
    texture = LockOn_Options.script_path .. "Resources/fonts/Gripen_Font_HUD", 
    size        = {10, 10}, 
    resolution  = {1440, 1440}, 
    default     = {HUDXPixel, HUDYPixel}, 
    chars       = {
        {32, HUDXPixel, HUDYPixel}, -- space
        {48, HUDXPixel, HUDYPixel}, -- 0
        {49, HUDXPixel * 0.8, HUDYPixel}, -- 1
        {50, HUDXPixel, HUDYPixel}, -- 2
        {51, HUDXPixel, HUDYPixel}, -- 3
        {52, HUDXPixel, HUDYPixel}, -- 4
        {53, HUDXPixel, HUDYPixel}, -- 5
        {54, HUDXPixel, HUDYPixel}, -- 6
        {55, HUDXPixel, HUDYPixel}, -- 7
        {56, HUDXPixel, HUDYPixel}, -- 8
        {57, HUDXPixel, HUDYPixel}, -- 9

        {64, HUDXPixel, HUDYPixel}, -- Alpha -> @

        {65, HUDXPixel, HUDYPixel}, -- A
        {66, HUDXPixel, HUDYPixel}, -- B
        {67, HUDXPixel, HUDYPixel}, -- C
        {68, HUDXPixel, HUDYPixel}, -- D
        {69, HUDXPixel, HUDYPixel}, -- E
        {70, HUDXPixel, HUDYPixel}, -- F
        {71, HUDXPixel, HUDYPixel}, -- G
        {72, HUDXPixel, HUDYPixel}, -- H
        {73, HUDXPixel, HUDYPixel}, -- I
        {74, HUDXPixel, HUDYPixel}, -- J
        {75, HUDXPixel, HUDYPixel}, -- K
        {76, HUDXPixel, HUDYPixel}, -- L
        {77, HUDXPixel, HUDYPixel}, -- M
        {78, HUDXPixel, HUDYPixel}, -- N
        {79, HUDXPixel, HUDYPixel}, -- O
        {80, HUDXPixel, HUDYPixel}, -- P
        {81, HUDXPixel, HUDYPixel}, -- Q
        {82, HUDXPixel, HUDYPixel}, -- R
        {83, HUDXPixel, HUDYPixel}, -- S
        {84, HUDXPixel, HUDYPixel}, -- T
        {85, HUDXPixel, HUDYPixel}, -- U
        {86, HUDXPixel, HUDYPixel}, -- V
        {87, HUDXPixel, HUDYPixel}, -- W
        {88, HUDXPixel, HUDYPixel}, -- X
        {89, HUDXPixel, HUDYPixel}, -- Y
        {90, HUDXPixel, HUDYPixel}, -- Z
         
        {42, HUDXPixel, HUDYPixel}, -- *
        {43, HUDXPixel, HUDYPixel}, -- +
        {45, HUDXPixel, HUDYPixel}, -- -
        {47, HUDXPixel, HUDYPixel}, -- /
        {92, HUDXPixel, HUDYPixel}, -- \
        {40, HUDXPixel, HUDYPixel}, -- (
        {41, HUDXPixel, HUDYPixel}, -- )
        {91, HUDXPixel, HUDYPixel}, -- [
        {93, HUDXPixel, HUDYPixel}, -- ]
        {123, HUDXPixel, HUDYPixel}, -- {
        {125, HUDXPixel, HUDYPixel}, -- }
        {60, HUDXPixel, HUDYPixel}, -- <
        {62, HUDXPixel, HUDYPixel}, -- >
        {61, HUDXPixel, HUDYPixel}, -- =
        {63, HUDXPixel, HUDYPixel}, -- ?
        {124, HUDXPixel, HUDYPixel}, -- |
        {33, HUDXPixel, HUDYPixel}, -- !
        {35, HUDXPixel, HUDYPixel}, -- #
        {37, HUDXPixel, HUDYPixel}, -- %
        {94, HUDXPixel, HUDYPixel}, -- ^
        {38, HUDXPixel, HUDYPixel}, -- &
        {96, HUDXPixel, HUDYPixel}, -- o -- degree, change its ascii code to 96 ', original 248 (out of index)
        {46, HUDXPixel * 0.65, HUDYPixel * 0.65}, -- .
        {58, HUDXPixel, HUDYPixel}, -- :
        {44, HUDXPixel, HUDYPixel}, -- ,
        {126, HUDXPixel, HUDYPixel}, -- cursor -> ~
        {95, HUDXPixel, HUDYPixel}, -- _
        
        {39, HUDXPixel, HUDYPixel}, -- '
        {34, HUDXPixel, HUDYPixel}, -- "
        --{32, HUDXPixel, HUDYPixel}, -- [space]
        
        {127, HUDXPixel, HUDYPixel}, -- delta, use last ascii code
    }
}


HUDFont = MakeFont(HUDFont, matl.g, "gripenFontGreen")



function setHMDBrightness(obj, elementParams, controllers)
	if elementParams and controllers then
		elementParams[#elementParams + 1] = "HMDBrightness"
		controllers[#controllers + 1]     = {ctrl.opacity,#elementParams - 1}

		obj.element_params = elementParams
		obj.controllers    = controllers
	else
		obj.element_params = {"HMDBrightness"}
		obj.controllers    = {{ctrl.opacity,0}}
	end
end

function setCommonProperties(obj, name, pos, rot, parentElement, hClip, level, elementParams, controllers, isMask)
	obj.name                   = name or create_guid_string()
	obj.init_pos               = pos or nil
	obj.init_rot               = rot or nil
	if parentElement then
		if type(parentElement) == 'userdata' and parentElement.name then
			obj.parent_element = parentElement.name
		elseif type(parentElement) == 'string' then
			obj.parent_element = parentElement
		end
	end
	obj.h_clip_relation        = hClip or hcr.cmp
	obj.level                  = level or lvl.def
	if isHMD == true then
		setHMDBrightness(obj, elementParams, controllers)
	end
	obj.collimated             = true
	obj.use_mipfilter          = true
	obj.additive_alpha         = true
	obj.blend_mode             = blend_mode.IBM_REGULAR_ADDITIVE_ALPHA
	obj.isvisible              = not isMask
	Add(obj)

	return obj
end


function copyHMDElement(obj, change, value)
	if #change == #value then
		num = #value
	else
		return
	end


    copyObj = Copy(obj)
	for i = 1, num do
    	copyObj[change[i]] = value[i]
	end
    Add(copyObj)

    return copyObj
end


function addHMDSimple(name, pos, rot, parentElement, hClip, level, elementParams, controllers)
	local simple = CreateElement "ceSimple"
	setCommonHMDProperties(simple, name, pos, rot, parentElement, hClip, level, elementParams, controllers)

	return simple
end


function addHMDMeshPoly(name, pos, rot, parentElement, hClip, level, elementParams, controllers, vertices, indices, material, isMask)
	local meshPoly         = CreateElement "ceMeshPoly"
	meshPoly.primitivetype = "triangles"
	meshPoly.vertices      = vertices
	meshPoly.indices       = indices
	meshPoly.material      = material or matl.mG
	setCommonHMDProperties(meshPoly, name, pos, rot, parentElement, hClip, level, elementParams, controllers, isMask)

	return meshPoly
end

function addHMDCircle(name, pos, rot, parentElement, hClip, level, elementParams, controllers, outerRadius, innerRadius, arc, res, material, isMask)
	local circle = {}
	set_circle(circle, outerRadius, innerRadius, arc, res)

	return addHMDMeshPoly(name, pos, rot, parentElement, hClip, level, elementParams, controllers, circle.vertices, circle.indices, material, isMask)
end

function addHMDBox(name, pos, rot, parentElement, hClip, level, elementParams, controllers, width, height, material, isMask)
	local vertices = {{0, height / 2}, {0, -height / 2}}

	return addHMDSimpleLine(name, pos, rot, parentElement, hClip, level, elementParams, controllers, width / 2, vertices, material, isMask)
end

function addHMDSimpleLine(name, pos, rot, parentElement, hClip, level, elementParams, controllers, width, vertices, material, isMask)
	local simpleLine           = CreateElement "ceSimpleLineObject"
	simpleLine.width           = width or 0.5
	simpleLine.vertices        = vertices or {{0}, {0}}
	simpleLine.material        = material or matl.mG
	setCommonHMDProperties(simpleLine, name, pos, rot, parentElement, hClip, level, elementParams, controllers, isMask)

	return simpleLine
end


function addHMDText(name, pos, parentElement, hClip, level, elementParams, controllers, text, alignment, stringdef)
	if alignment == nil then
		alignment = align.CC
	end
	if stringdef == nil then
		stringdef = strdef.std
	end


	local textObj          = CreateElement "ceStringPoly"
	textObj.value          = text
	textObj.alignment      = alignment
	textObj.stringdefs     = stringdef
	textObj.material       = font
	setCommonHMDProperties(textObj, name, pos, nil, parentElement, hClip, level, elementParams, controllers)

	return textObj
end

function addHMDTextParam(name, pos, parentElement, hClip, level, elementParams, controllers, textParam, alignment, format, stringdef)
	if textParam then
		if elementParams and controllers then
			elementParams[#elementParams + 1] = {textParam}
			controllers[#controllers + 1]     = {{ctrl.text,#elementParams - 1}}
		else
			elementParams = {textParam}
			controllers   = {{ctrl.text,0}}
		end
	end


	if format == nil then
		format = {"%.0f"}
	end
	if stringdef == nil then
		stringdef = strdef.std
	end
	if alignment == nil then
		alignment = align.CC
	end


	local textObj      = CreateElement "ceStringPoly"
	textObj.alignment  = alignment
	textObj.stringdefs = stringdef
	textObj.formats    = format
	textObj.material   = font
	setCommonHMDProperties(textObj, name, pos, nil, parentElement, hClip, level, elementParams, controllers)

	return textObj
end