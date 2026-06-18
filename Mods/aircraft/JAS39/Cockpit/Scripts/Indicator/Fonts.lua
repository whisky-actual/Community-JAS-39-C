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


local MFDXPixel = 88
local MFDYPixel = 144

local MFDFont = {
	texture    = fontPath .. "Gripen_Font_MFD",
	size       = {10, 10},
	resolution = {1440, 1440},
	default    = {MFDXPixel, MFDYPixel},
	chars      = {
		{32,  MFDXPixel,       MFDYPixel}, -- space
		{48,  MFDXPixel,       MFDYPixel}, -- 0
		{49,  MFDXPixel,       MFDYPixel}, -- 1
		{50,  MFDXPixel,       MFDYPixel}, -- 2
		{51,  MFDXPixel,       MFDYPixel}, -- 3
		{52,  MFDXPixel,       MFDYPixel}, -- 4
		{53,  MFDXPixel,       MFDYPixel}, -- 5
		{54,  MFDXPixel,       MFDYPixel}, -- 6
		{55,  MFDXPixel,       MFDYPixel}, -- 7
		{56,  MFDXPixel,       MFDYPixel}, -- 8
		{57,  MFDXPixel,       MFDYPixel}, -- 9

		{64,  MFDXPixel,       MFDYPixel}, -- Alpha -> @

		{65,  MFDXPixel,       MFDYPixel}, -- A
		{66,  MFDXPixel,       MFDYPixel}, -- B
		{67,  MFDXPixel,       MFDYPixel}, -- C
		{68,  MFDXPixel,       MFDYPixel}, -- D
		{69,  MFDXPixel,       MFDYPixel}, -- E
		{70,  MFDXPixel,       MFDYPixel}, -- F
		{71,  MFDXPixel,       MFDYPixel}, -- G
		{72,  MFDXPixel,       MFDYPixel}, -- H
		{73,  MFDXPixel,       MFDYPixel}, -- I
		{74,  MFDXPixel,       MFDYPixel}, -- J
		{75,  MFDXPixel,       MFDYPixel}, -- K
		{76,  MFDXPixel,       MFDYPixel}, -- L
		{77,  MFDXPixel,       MFDYPixel}, -- M
		{78,  MFDXPixel,       MFDYPixel}, -- N
		{79,  MFDXPixel,       MFDYPixel}, -- O
		{80,  MFDXPixel,       MFDYPixel}, -- P
		{81,  MFDXPixel,       MFDYPixel}, -- Q
		{82,  MFDXPixel,       MFDYPixel}, -- R
		{83,  MFDXPixel,       MFDYPixel}, -- S
		{84,  MFDXPixel,       MFDYPixel}, -- T
		{85,  MFDXPixel,       MFDYPixel}, -- U
		{86,  MFDXPixel,       MFDYPixel}, -- V
		{87,  MFDXPixel,       MFDYPixel}, -- W
		{88,  MFDXPixel,       MFDYPixel}, -- X
		{89,  MFDXPixel,       MFDYPixel}, -- Y
		{90,  MFDXPixel,       MFDYPixel}, -- Z

		{42,  MFDXPixel,       MFDYPixel}, -- *
		{43,  MFDXPixel,       MFDYPixel}, -- +
		{45,  MFDXPixel,       MFDYPixel}, -- -
		{47,  MFDXPixel,       MFDYPixel}, -- /
		{92,  MFDXPixel,       MFDYPixel}, -- \
		{40,  MFDXPixel,       MFDYPixel}, -- (
		{41,  MFDXPixel,       MFDYPixel}, -- )
		{91,  MFDXPixel,       MFDYPixel}, -- [
		{93,  MFDXPixel,       MFDYPixel}, -- ]
		{123, MFDXPixel,       MFDYPixel}, -- {
		{125, MFDXPixel,       MFDYPixel}, -- }
		{60,  MFDXPixel,       MFDYPixel}, -- <
		{62,  MFDXPixel,       MFDYPixel}, -- >
		{61,  MFDXPixel,       MFDYPixel}, -- =
		{63,  MFDXPixel,       MFDYPixel}, -- ?
		{124, MFDXPixel,       MFDYPixel}, -- |
		{33,  MFDXPixel,       MFDYPixel}, -- !
		{35,  MFDXPixel,       MFDYPixel}, -- #
		{37,  MFDXPixel,       MFDYPixel}, -- %
		{94,  MFDXPixel,       MFDYPixel}, -- ^
		{38,  MFDXPixel,       MFDYPixel}, -- &
		{96,  MFDXPixel,       MFDYPixel}, -- o -- degree, change its ascii code to 96 ', original 248 (out of index)
		{46,  MFDXPixel * 0.5, MFDYPixel * 0.6}, -- .
		{58,  MFDXPixel,       MFDYPixel}, -- :
		{44,  MFDXPixel,       MFDYPixel}, -- ,
		{126, MFDXPixel,       MFDYPixel}, -- cursor -> ~
		{95,  MFDXPixel,       MFDYPixel}, -- _

		{39,  MFDXPixel,       MFDYPixel}, -- '
		{34,  MFDXPixel,       MFDYPixel}, -- "
		{127, MFDXPixel,       MFDYPixel}, -- delta

		{97,  MFDXPixel,       MFDYPixel}, -- a
		{98,  MFDXPixel,       MFDYPixel}, -- b
		{99,  MFDXPixel,       MFDYPixel}, -- c
		{100, MFDXPixel,       MFDYPixel}, -- d
		{101, MFDXPixel,       MFDYPixel}, -- e
		{102, MFDXPixel,       MFDYPixel}, -- f
		{103, MFDXPixel,       MFDYPixel}, -- g
		{104, MFDXPixel,       MFDYPixel}, -- h
		{105, MFDXPixel,       MFDYPixel}, -- i
		{106, MFDXPixel,       MFDYPixel}, -- j
		{107, MFDXPixel,       MFDYPixel}, -- k
		{108, MFDXPixel,       MFDYPixel}, -- l
		{109, MFDXPixel,       MFDYPixel}, -- m
		{110, MFDXPixel,       MFDYPixel}, -- n
		{111, MFDXPixel,       MFDYPixel}, -- o
		{112, MFDXPixel,       MFDYPixel}, -- p
		{113, MFDXPixel,       MFDYPixel}, -- q
		{114, MFDXPixel,       MFDYPixel}, -- r
		{115, MFDXPixel,       MFDYPixel}, -- s
		{116, MFDXPixel,       MFDYPixel}, -- t
		{117, MFDXPixel,       MFDYPixel}, -- u
		{118, MFDXPixel,       MFDYPixel}, -- v
		{119, MFDXPixel,       MFDYPixel}, -- w
		{120, MFDXPixel,       MFDYPixel}, -- x
		{121, MFDXPixel,       MFDYPixel}, -- y
		{122, MFDXPixel,       MFDYPixel} -- z, use last ascii code

	}
}


newFonts = {}
newFonts.HUD = MakeFont(HUDFont, colors.green)

for name, color in pairs(colors) do
	newFonts["MFD_" .. name] = MakeFont(MFDFont, color)
end


-- for name, icolor in pairs(colors) do
-- 	newFonts[name] = MakeFont(HUDFont, icolor)
-- end