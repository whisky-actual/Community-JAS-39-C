dofile(LockOn_Options.common_script_path .. "Fonts/symbols_locale.lua")
dofile(LockOn_Options.common_script_path .. "Fonts/fonts_cmn.lua")
dofile(LockOn_Options.common_script_path .. "elements_defs.lua")


-- To make colors accurate. Take the RGB here (as sRGB_8): https://davengrace.com/dave/cspace/
-- And take the numbers of sRGB [0,1] (liniear) and multiply by 255. The alpha is always 255.
colors = {
	red          = {255, 0, 0, 255},
	green        = {0, 255, 0, 255},
	blue         = {0, 0, 255, 255},
	lightBlue    = {0, 255 * .5, 255, 255},
	white        = {255, 255, 255, 255},
	black        = {0, 0, 0, 255},
	gray         = {128, 128, 128, 255},
	yellow       = {255, 255, 0, 255},
	cyan         = {0, 255, 255, 255},
	magenta      = {255, 0, 255, 255},
	orange       = {255, 255 * .3529, 0, 255},
	HUDMask      = {255, 0, 0, 255 / 2},
	MFDBeige     = {1 * 255, .913098 * 255, .584078 * 255, 255},
	MFDBGGray    = {.603827 * 255, .603827 * 255, .603827 * 255, 255}, -- Background
	MFDFGGray    = {.15 * 255, .15 * 255, .15 * 255, 255},          -- Foreground
	MFDLightBlue = {0.584078417891164 * 255, 0.806952257669252 * 255, 0.982250550333117 * 255, 255},
	MFDGreen     = {0, (2 / 3) * 255, .0196078431372549 * 255, 255}
}


materials = {}

for name, color in pairs(colors) do
	materials[name] = MakeMaterial(nil, color)
end

--[[
local texturePath = LockOn_Options.script_path .. "Indicator/Textures/Displays/"

missileIcons = MakeMaterial(texturePath .. "/F_23_Missile_Icons", colors.white)
--]]