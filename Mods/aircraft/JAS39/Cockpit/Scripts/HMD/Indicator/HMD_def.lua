dofile(LockOn_Options.common_script_path .. "Fonts/symbols_locale.lua")
dofile(LockOn_Options.common_script_path .. "Fonts/fonts_cmn.lua")
dofile(LockOn_Options.common_script_path .. "elements_defs.lua")



SetScale(MILLYRADIANS)



aimingCircleRadius = math.rad(2) * 1000

attIndRadius = 200

base = "HMD_Base"

speedscaleHeight = 42.6733

mult = 0.739292 --correct??



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


lvl = {
	def    = 4, 
	mask   = 5, 
	noclip = 3, 
	alt    = 6, 
	alt2   = 7
}


matl = {
	g    = {0, 255, 0, 255}, 
	mG   = MakeMaterial(nil, {0, 255, 0, 255}), 
	mask = MakeMaterial(nil, {255, 0, 0, 255/2})
}


strdef = {
	std                     = {0.01, 0.01}, 
	alpha                   = {0.012, 0.012, 0, 0}, 
	half                    = {0.005, 0.005, 0, 0}, 
	whenYouCantFindTheDigit = {0.1, 0.1, 0, 0}, 
	hundreds                = {0.006, 0.006, 0, 0},
	seventyseven            = {0.0077, 0.0077, 0, 0}
}



--Fonts
local HMDXPixel = 88
local HMDYPixel = 144

local gripenFont = {
    texture = LockOn_Options.script_path .. "Resources/fonts/Gripen_Font_HUD", 
    size        = {10, 10}, 
    resolution  = {1440, 1440}, 
    default     = {HMDXPixel, HMDYPixel}, 
    chars       = {
        {32, HMDXPixel, HMDYPixel}, -- space
        {48, HMDXPixel, HMDYPixel}, -- 0
        {49, HMDXPixel * 0.8, HMDYPixel}, -- 1
        {50, HMDXPixel, HMDYPixel}, -- 2
        {51, HMDXPixel, HMDYPixel}, -- 3
        {52, HMDXPixel, HMDYPixel}, -- 4
        {53, HMDXPixel, HMDYPixel}, -- 5
        {54, HMDXPixel, HMDYPixel}, -- 6
        {55, HMDXPixel, HMDYPixel}, -- 7
        {56, HMDXPixel, HMDYPixel}, -- 8
        {57, HMDXPixel, HMDYPixel}, -- 9

        {64, HMDXPixel, HMDYPixel}, -- Alpha -> @

        {65, HMDXPixel, HMDYPixel}, -- A
        {66, HMDXPixel, HMDYPixel}, -- B
        {67, HMDXPixel, HMDYPixel}, -- C
        {68, HMDXPixel, HMDYPixel}, -- D
        {69, HMDXPixel, HMDYPixel}, -- E
        {70, HMDXPixel, HMDYPixel}, -- F
        {71, HMDXPixel, HMDYPixel}, -- G
        {72, HMDXPixel, HMDYPixel}, -- H
        {73, HMDXPixel, HMDYPixel}, -- I
        {74, HMDXPixel, HMDYPixel}, -- J
        {75, HMDXPixel, HMDYPixel}, -- K
        {76, HMDXPixel, HMDYPixel}, -- L
        {77, HMDXPixel, HMDYPixel}, -- M
        {78, HMDXPixel, HMDYPixel}, -- N
        {79, HMDXPixel, HMDYPixel}, -- O
        {80, HMDXPixel, HMDYPixel}, -- P
        {81, HMDXPixel, HMDYPixel}, -- Q
        {82, HMDXPixel, HMDYPixel}, -- R
        {83, HMDXPixel, HMDYPixel}, -- S
        {84, HMDXPixel, HMDYPixel}, -- T
        {85, HMDXPixel, HMDYPixel}, -- U
        {86, HMDXPixel, HMDYPixel}, -- V
        {87, HMDXPixel, HMDYPixel}, -- W
        {88, HMDXPixel, HMDYPixel}, -- X
        {89, HMDXPixel, HMDYPixel}, -- Y
        {90, HMDXPixel, HMDYPixel}, -- Z
         
        {42, HMDXPixel, HMDYPixel}, -- *
        {43, HMDXPixel, HMDYPixel}, -- +
        {45, HMDXPixel, HMDYPixel}, -- -
        {47, HMDXPixel, HMDYPixel}, -- /
        {92, HMDXPixel, HMDYPixel}, -- \
        {40, HMDXPixel, HMDYPixel}, -- (
        {41, HMDXPixel, HMDYPixel}, -- )
        {91, HMDXPixel, HMDYPixel}, -- [
        {93, HMDXPixel, HMDYPixel}, -- ]
        {123, HMDXPixel, HMDYPixel}, -- {
        {125, HMDXPixel, HMDYPixel}, -- }
        {60, HMDXPixel, HMDYPixel}, -- <
        {62, HMDXPixel, HMDYPixel}, -- >
        {61, HMDXPixel, HMDYPixel}, -- =
        {63, HMDXPixel, HMDYPixel}, -- ?
        {124, HMDXPixel, HMDYPixel}, -- |
        {33, HMDXPixel, HMDYPixel}, -- !
        {35, HMDXPixel, HMDYPixel}, -- #
        {37, HMDXPixel, HMDYPixel}, -- %
        {94, HMDXPixel, HMDYPixel}, -- ^
        {38, HMDXPixel, HMDYPixel}, -- &
        {96, HMDXPixel, HMDYPixel}, -- o -- degree, change its ascii code to 96 ', original 248 (out of index)
        {46, HMDXPixel * 0.65, HMDYPixel * 0.65}, -- .
        {58, HMDXPixel, HMDYPixel}, -- :
        {44, HMDXPixel, HMDYPixel}, -- ,
        {126, HMDXPixel, HMDYPixel}, -- cursor -> ~
        {95, HMDXPixel, HMDYPixel}, -- _
        
        {39, HMDXPixel, HMDYPixel}, -- '
        {34, HMDXPixel, HMDYPixel}, -- "
        --{32, HMDXPixel, HMDYPixel}, -- [space]
        
        {127, HMDXPixel, HMDYPixel}, -- delta, use last ascii code
    }
}


font = MakeFont(gripenFont, matl.g, "gripenFontGreen")



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

function setCommonHMDProperties(obj, name, pos, rot, parentElement, hClip, level, elementParams, controllers, isMask)
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
	setHMDBrightness(obj, elementParams, controllers)
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