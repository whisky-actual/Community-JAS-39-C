dofile(LockOn_Options.common_script_path .. "Fonts/symbols_locale.lua")
dofile(LockOn_Options.common_script_path .. "Fonts/fonts_cmn.lua")
dofile(LockOn_Options.common_script_path .. "elements_defs.lua")
dofile(LockOn_Options.script_path .. "Indicator/Materials.lua")



local fontPath = LockOn_Options.script_path .. "Resources/fonts/"


local HUDXPixel = 88
local HUDYPixel = 144

local HUDFont = {
	texture    = fontPath .. "Gripen_Font_HUD",
	size       = {10, 10},
	resolution = {1440, 1440},
	default    = {HUDXPixel, HUDYPixel},
	chars      = {
		{32,  HUDXPixel,        HUDYPixel}, -- space
		{48,  HUDXPixel,        HUDYPixel}, -- 0
		{49,  HUDXPixel * 0.8,  HUDYPixel}, -- 1
		{50,  HUDXPixel,        HUDYPixel}, -- 2
		{51,  HUDXPixel,        HUDYPixel}, -- 3
		{52,  HUDXPixel,        HUDYPixel}, -- 4
		{53,  HUDXPixel,        HUDYPixel}, -- 5
		{54,  HUDXPixel,        HUDYPixel}, -- 6
		{55,  HUDXPixel,        HUDYPixel}, -- 7
		{56,  HUDXPixel,        HUDYPixel}, -- 8
		{57,  HUDXPixel,        HUDYPixel}, -- 9

		{64,  HUDXPixel,        HUDYPixel}, -- Alpha -> @

		{65,  HUDXPixel,        HUDYPixel}, -- A
		{66,  HUDXPixel,        HUDYPixel}, -- B
		{67,  HUDXPixel,        HUDYPixel}, -- C
		{68,  HUDXPixel,        HUDYPixel}, -- D
		{69,  HUDXPixel,        HUDYPixel}, -- E
		{70,  HUDXPixel,        HUDYPixel}, -- F
		{71,  HUDXPixel,        HUDYPixel}, -- G
		{72,  HUDXPixel,        HUDYPixel}, -- H
		{73,  HUDXPixel,        HUDYPixel}, -- I
		{74,  HUDXPixel,        HUDYPixel}, -- J
		{75,  HUDXPixel,        HUDYPixel}, -- K
		{76,  HUDXPixel,        HUDYPixel}, -- L
		{77,  HUDXPixel,        HUDYPixel}, -- M
		{78,  HUDXPixel,        HUDYPixel}, -- N
		{79,  HUDXPixel,        HUDYPixel}, -- O
		{80,  HUDXPixel,        HUDYPixel}, -- P
		{81,  HUDXPixel,        HUDYPixel}, -- Q
		{82,  HUDXPixel,        HUDYPixel}, -- R
		{83,  HUDXPixel,        HUDYPixel}, -- S
		{84,  HUDXPixel,        HUDYPixel}, -- T
		{85,  HUDXPixel,        HUDYPixel}, -- U
		{86,  HUDXPixel,        HUDYPixel}, -- V
		{87,  HUDXPixel,        HUDYPixel}, -- W
		{88,  HUDXPixel,        HUDYPixel}, -- X
		{89,  HUDXPixel,        HUDYPixel}, -- Y
		{90,  HUDXPixel,        HUDYPixel}, -- Z

		{42,  HUDXPixel,        HUDYPixel},  -- *
		{43,  HUDXPixel,        HUDYPixel},  -- +
		{45,  HUDXPixel,        HUDYPixel},  -- -
		{47,  HUDXPixel,        HUDYPixel},  -- /
		{92,  HUDXPixel,        HUDYPixel},  -- \
		{40,  HUDXPixel,        HUDYPixel},  -- (
		{41,  HUDXPixel,        HUDYPixel},  -- )
		{91,  HUDXPixel,        HUDYPixel},  -- [
		{93,  HUDXPixel,        HUDYPixel},  -- ]
		{123, HUDXPixel,        HUDYPixel},  -- {
		{125, HUDXPixel,        HUDYPixel},  -- }
		{60,  HUDXPixel,        HUDYPixel},  -- <
		{62,  HUDXPixel,        HUDYPixel},  -- >
		{61,  HUDXPixel,        HUDYPixel},  -- =
		{63,  HUDXPixel,        HUDYPixel},  -- ?
		{124, HUDXPixel,        HUDYPixel},  -- |
		{33,  HUDXPixel,        HUDYPixel},  -- !
		{35,  HUDXPixel,        HUDYPixel},  -- #
		{37,  HUDXPixel,        HUDYPixel},  -- %
		{94,  HUDXPixel,        HUDYPixel},  -- ^
		{38,  HUDXPixel,        HUDYPixel},  -- &
		{96,  HUDXPixel,        HUDYPixel},  -- o -- degree, change its ascii code to 96 ', original 248 (out of index)
		{46,  HUDXPixel * 0.65, HUDYPixel * 0.65}, -- .
		{58,  HUDXPixel,        HUDYPixel},  -- :
		{44,  HUDXPixel,        HUDYPixel},  -- ,
		{126, HUDXPixel,        HUDYPixel},  -- cursor -> ~
		{95,  HUDXPixel,        HUDYPixel},  -- _

		{39,  HUDXPixel,        HUDYPixel}, -- '
		{34,  HUDXPixel,        HUDYPixel}, -- "
		-- {32, HUDXPixel, HUDYPixel}, -- [space]

		{127, HUDXPixel,        HUDYPixel} -- delta, use last ascii code
	}
}


newFonts = {}
newFonts.HUD = MakeFont(HUDFont, colors.green)

-- for name, icolor in pairs(colors) do
-- 	newFonts[name] = MakeFont(HUDFont, icolor)
-- end