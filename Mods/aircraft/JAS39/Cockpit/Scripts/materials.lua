--dofile(LockOn_Options.script_path.."fonts.lua")
dofile(LockOn_Options.common_script_path.."Fonts/fonts_cmn.lua")

-------MATERIALS-------
materials = {}
materials["DBG_GREY"]    = {5, 5, 5, 255}
materials["DBG_BLACK"]   = {0, 0, 0, 255}
materials["DBG_BLUE"]    = {0, 0, 100, 255}
materials["DBG_GREEN"]   = {0, 80, 0, 255}
materials["DBG_RED"]     = {255, 0, 0, 255}
materials["DBG_WHITE"]   = {255, 255, 255, 120}
materials["DBG_CYAN"]    = {1, 244, 244, 255}

materials["DBG_CLEAR"]   = {0, 0, 0, 0}
materials["BLOB_COLOR"] = {0,128,0,192}
materials["TEST_MATERIAL"] 	= {17,80,7,20}
materials["RADAR_GRID"] = {0,100,0,192}
materials["RADAR_SCRIBE"] = {0,200,0,192}
materials["GUNSIGHT_GLASS"] = {0,120,0,128}
materials["TEST_COLOR"] = {50,250,0,255}
materials["HUD_DAY_COLOR"]          = {0,200,0,200}

materials["N_MATERIAL"] 	= {255,255,255,255}

local BASIC_IND_TEX_PATH        = LockOn_Options.script_path .. "../Textures/ADI/"  --定义屏幕贴图路径
-------TEXTURES-------
textures = {}
-- textures["BLOB_TEXTURE"] = {"radar_blob.dds",materials["BLOB_COLOR"]}
textures["TEST_TEXTURE"] = {"test4.dds", materials["TEST_COLOR"]}
textures["SIGNAL_ADI"] 	 = {BASIC_IND_TEX_PATH.."basic_ADI_center_signal.tga", materials["N_MATERIAL"]}
-- textures["PAGE1"] 	 = {BASIC_IND_TEX_PATH.."basic_ADI_center_signal.tga", materials["N_MATERIAL"]}
textures["PAGE1"] 	 = {BASIC_IND_TEX_PATH.."page1.png", materials["N_MATERIAL"]}
textures["PAGE2"] 	 = {BASIC_IND_TEX_PATH.."page2.png", materials["N_MATERIAL"]}

local ADI_IND_TEX_PATH        = LockOn_Options.script_path .. "../Textures/ADI/"  --定义屏幕贴图路径
textures["BASIC_ADI"] 	 = {ADI_IND_TEX_PATH.."basic_ADI_background.tga", materials["N_MATERIAL"]}
textures["SPEED_ADI"] 	 = {ADI_IND_TEX_PATH.."adi_airspeed.png", materials["N_MATERIAL"]}


local IndicationFontPath = LockOn_Options.script_path.."../Textures/Fonts/"
-------------------------------------------------------
-------FONTS-------
fontdescription = {}

stringdefs = {0.012,0.75 * 0.012, 0, 0}
mfd_stringdefs = {0.012,0.75 * 0.012, 0, 0}

mfd_str_arw = {0.008,0.008, 0, 0}
mfd_str_btn = {0.006,0.006, 0, 0}
mfd_str_wrn = {0.006,0.006, 0, 0}
mfd_str_mfd_ind = {0.005,0.0026, 0, 0}

MPCD_size_mult = 2
MPCD_xsize = 29 * MPCD_size_mult
MPCD_ysize = 64 * MPCD_size_mult

fontdescription["font_MPCD"] = {
	texture		= IndicationFontPath.."font_MFD.dds",
	size		= {8, 8},
	resolution	= {1024, 1024},
	default		= {MPCD_xsize, MPCD_ysize},
	chars		= {
		[1]   = {64,  MPCD_xsize, MPCD_ysize}, -- @ == ©
		[2]   = {18,  MPCD_xsize, MPCD_ysize}, -- ^ == \18
		[3]   = {20,  MPCD_xsize, MPCD_ysize}, -- ¶ == [] == \20
		[4]   = {26,  MPCD_xsize, MPCD_ysize}, -- > == -> == \26
		[5]   = {27,  MPCD_xsize, MPCD_ysize}, -- < == <- == \27
		[6]   = {31,  MPCD_xsize, MPCD_ysize}, -- SPARE 
		[7]   = {126, MPCD_xsize, MPCD_ysize}, -- ~
		[8]   = {32,  MPCD_xsize, MPCD_ysize}, -- [space]
		[9]   = {33,  MPCD_xsize, MPCD_ysize}, -- !
		[10]  = {35,  MPCD_xsize, MPCD_ysize}, -- #
		[11]  = {40,  MPCD_xsize, MPCD_ysize}, -- (
		[12]  = {41,  MPCD_xsize, MPCD_ysize}, -- )
		[13]  = {42,  MPCD_xsize, MPCD_ysize}, -- *
		[14]  = {43,  MPCD_xsize, MPCD_ysize}, -- +
		[15]  = {45,  MPCD_xsize, MPCD_ysize}, -- -
		[16]  = {46,  MPCD_xsize, MPCD_ysize}, -- .
		[17]  = {47,  MPCD_xsize, MPCD_ysize}, -- /
		[18]  = {48,  MPCD_xsize, MPCD_ysize}, -- 0
		[19]  = {49,  MPCD_xsize, MPCD_ysize}, -- 1
		[20]  = {50,  MPCD_xsize, MPCD_ysize}, -- 2
		[21]  = {51,  MPCD_xsize, MPCD_ysize}, -- 3
		[22]  = {52,  MPCD_xsize, MPCD_ysize}, -- 4
		[23]  = {53,  MPCD_xsize, MPCD_ysize}, -- 5
		[24]  = {54,  MPCD_xsize, MPCD_ysize}, -- 6
		[25]  = {55,  MPCD_xsize, MPCD_ysize}, -- 7
		[26]  = {56,  MPCD_xsize, MPCD_ysize}, -- 8
		[27]  = {57,  MPCD_xsize, MPCD_ysize}, -- 9
		[28]  = {58,  MPCD_xsize, MPCD_ysize}, -- :
		[29]  = {61,  MPCD_xsize, MPCD_ysize}, -- =
		[30]  = {63,  MPCD_xsize, MPCD_ysize}, -- ?
		[31]  = {65,  MPCD_xsize, MPCD_ysize}, -- A
		[32]  = {66,  MPCD_xsize, MPCD_ysize}, -- B
		[33]  = {67,  MPCD_xsize, MPCD_ysize}, -- C
		[34]  = {68,  MPCD_xsize, MPCD_ysize}, -- D
		[35]  = {69,  MPCD_xsize, MPCD_ysize}, -- E
		[36]  = {70,  MPCD_xsize, MPCD_ysize}, -- F
		[37]  = {71,  MPCD_xsize, MPCD_ysize}, -- G
		[38]  = {72,  MPCD_xsize, MPCD_ysize}, -- H
		[39]  = {73,  MPCD_xsize, MPCD_ysize}, -- I
		[40]  = {74,  MPCD_xsize, MPCD_ysize}, -- J
		[41]  = {75,  MPCD_xsize, MPCD_ysize}, -- K
		[42]  = {76,  MPCD_xsize, MPCD_ysize}, -- L
		[43]  = {77,  MPCD_xsize, MPCD_ysize}, -- M
		[44]  = {78,  MPCD_xsize, MPCD_ysize}, -- N
		[45]  = {79,  MPCD_xsize, MPCD_ysize}, -- O
		[46]  = {80,  MPCD_xsize, MPCD_ysize}, -- P
		[47]  = {81,  MPCD_xsize, MPCD_ysize}, -- Q
		[48]  = {82,  MPCD_xsize, MPCD_ysize}, -- R
		[49]  = {83,  MPCD_xsize, MPCD_ysize}, -- S
		[50]  = {84,  MPCD_xsize, MPCD_ysize}, -- T
		[51]  = {85,  MPCD_xsize, MPCD_ysize}, -- U
		[52]  = {86,  MPCD_xsize, MPCD_ysize}, -- V
		[53]  = {87,  MPCD_xsize, MPCD_ysize}, -- W
		[54]  = {88,  MPCD_xsize, MPCD_ysize}, -- X
		[55]  = {89,  MPCD_xsize, MPCD_ysize}, -- Y
		[56]  = {90,  MPCD_xsize, MPCD_ysize}, -- Z
		[57]  = {91,  MPCD_xsize, MPCD_ysize}, -- [
		[58]  = {93,  MPCD_xsize, MPCD_ysize}, -- ] 
		[59]  = {124, MPCD_xsize, MPCD_ysize}, -- | == ¦
		[60]  = {38,  MPCD_xsize, MPCD_ysize}, -- & == +- 
		[61]  = {59,  MPCD_xsize, MPCD_ysize}, -- ; == ° 
		[62]  = {95,  MPCD_xsize, MPCD_ysize}, -- _
		[63]  = {37,  MPCD_xsize, MPCD_ysize},-- %
		[64]  = {24,  MPCD_xsize, MPCD_ysize},-- alpha α
	}
}

fontdescription["font_HUD"] = {
	texture		= IndicationFontPath.."font_HUD.dds",
	size		= {8, 8},
	resolution	= {1024, 1024},
	default		= {MPCD_xsize, MPCD_ysize},
	chars		= {
		[1]   = {64,  MPCD_xsize, MPCD_ysize}, -- @ == ©
		[2]   = {18,  MPCD_xsize, MPCD_ysize}, -- ^ == \18
		[3]   = {20,  MPCD_xsize, MPCD_ysize}, -- ¶ == [] == \20
		[4]   = {26,  MPCD_xsize, MPCD_ysize}, -- > == -> == \26
		[5]   = {27,  MPCD_xsize, MPCD_ysize}, -- < == <- == \27
		[6]   = {31,  MPCD_xsize, MPCD_ysize}, -- SPARE 
		[7]   = {126, MPCD_xsize, MPCD_ysize}, -- ~
		[8]   = {32,  MPCD_xsize, MPCD_ysize}, -- [space]
		[9]   = {33,  MPCD_xsize, MPCD_ysize}, -- !
		[10]  = {35,  MPCD_xsize, MPCD_ysize}, -- #
		[11]  = {40,  MPCD_xsize, MPCD_ysize}, -- (
		[12]  = {41,  MPCD_xsize, MPCD_ysize}, -- )
		[13]  = {42,  MPCD_xsize, MPCD_ysize}, -- *
		[14]  = {43,  MPCD_xsize, MPCD_ysize}, -- +
		[15]  = {45,  MPCD_xsize, MPCD_ysize}, -- -
		[16]  = {46,  MPCD_xsize, MPCD_ysize}, -- .
		[17]  = {47,  MPCD_xsize, MPCD_ysize}, -- /
		[18]  = {48,  MPCD_xsize, MPCD_ysize}, -- 0
		[19]  = {49,  MPCD_xsize, MPCD_ysize}, -- 1
		[20]  = {50,  MPCD_xsize, MPCD_ysize}, -- 2
		[21]  = {51,  MPCD_xsize, MPCD_ysize}, -- 3
		[22]  = {52,  MPCD_xsize, MPCD_ysize}, -- 4
		[23]  = {53,  MPCD_xsize, MPCD_ysize}, -- 5
		[24]  = {54,  MPCD_xsize, MPCD_ysize}, -- 6
		[25]  = {55,  MPCD_xsize, MPCD_ysize}, -- 7
		[26]  = {56,  MPCD_xsize, MPCD_ysize}, -- 8
		[27]  = {57,  MPCD_xsize, MPCD_ysize}, -- 9
		[28]  = {58,  MPCD_xsize, MPCD_ysize}, -- :
		[29]  = {61,  MPCD_xsize, MPCD_ysize}, -- =
		[30]  = {63,  MPCD_xsize, MPCD_ysize}, -- ?
		[31]  = {65,  MPCD_xsize, MPCD_ysize}, -- A
		[32]  = {66,  MPCD_xsize, MPCD_ysize}, -- B
		[33]  = {67,  MPCD_xsize, MPCD_ysize}, -- C
		[34]  = {68,  MPCD_xsize, MPCD_ysize}, -- D
		[35]  = {69,  MPCD_xsize, MPCD_ysize}, -- E
		[36]  = {70,  MPCD_xsize, MPCD_ysize}, -- F
		[37]  = {71,  MPCD_xsize, MPCD_ysize}, -- G
		[38]  = {72,  MPCD_xsize, MPCD_ysize}, -- H
		[39]  = {73,  MPCD_xsize, MPCD_ysize}, -- I
		[40]  = {74,  MPCD_xsize, MPCD_ysize}, -- J
		[41]  = {75,  MPCD_xsize, MPCD_ysize}, -- K
		[42]  = {76,  MPCD_xsize, MPCD_ysize}, -- L
		[43]  = {77,  MPCD_xsize, MPCD_ysize}, -- M
		[44]  = {78,  MPCD_xsize, MPCD_ysize}, -- N
		[45]  = {79,  MPCD_xsize, MPCD_ysize}, -- O
		[46]  = {80,  MPCD_xsize, MPCD_ysize}, -- P
		[47]  = {81,  MPCD_xsize, MPCD_ysize}, -- Q
		[48]  = {82,  MPCD_xsize, MPCD_ysize}, -- R
		[49]  = {83,  MPCD_xsize, MPCD_ysize}, -- S
		[50]  = {84,  MPCD_xsize, MPCD_ysize}, -- T
		[51]  = {85,  MPCD_xsize, MPCD_ysize}, -- U
		[52]  = {86,  MPCD_xsize, MPCD_ysize}, -- V
		[53]  = {87,  MPCD_xsize, MPCD_ysize}, -- W
		[54]  = {88,  MPCD_xsize, MPCD_ysize}, -- X
		[55]  = {89,  MPCD_xsize, MPCD_ysize}, -- Y
		[56]  = {90,  MPCD_xsize, MPCD_ysize}, -- Z
		[57]  = {91,  MPCD_xsize, MPCD_ysize}, -- [
		[58]  = {93,  MPCD_xsize, MPCD_ysize}, -- ] 
		[59]  = {124, MPCD_xsize, MPCD_ysize}, -- | == ¦
		[60]  = {38,  MPCD_xsize, MPCD_ysize}, -- & == +- 
		[61]  = {59,  MPCD_xsize, MPCD_ysize}, -- ; == ° 
		[62]  = {95,  MPCD_xsize, MPCD_ysize}, -- _
		[63]  = {37,  MPCD_xsize, MPCD_ysize},-- %
		[64]  = {24,  MPCD_xsize, MPCD_ysize},-- alpha α
	}
}


    fonts = {}
    fonts["font_kneeboard"]			= {fontdescription_cmn["font_general_loc"], 10, {0,0,0,255}}
    fonts["font_kneeboard_hint"]	= {fontdescription_cmn["font_general_loc"], 10, {255,0,0,255}}
	fonts["mpcd_font_base"]			= {fontdescription["font_MPCD"], 10, materials["TEST_COLOR"]}
	fonts["hud_font_base"]			= {fontdescription["font_HUD"], 10, materials["DBG_WHITE"] }
	fonts["hud_font_base_green"]			= {fontdescription["font_HUD"], 10, materials["DBG_GREEN"] }
	
	fonts["red_font_MPCD"]			= {fontdescription["font_HUD"], 10, materials["DBG_RED"] }
	fonts["white_font_MPCD"]		= {fontdescription["font_HUD"], 10, materials["DBG_WHITE"] }
	fonts["black_font_MPCD"]		= {fontdescription["font_HUD"], 10, materials["DBG_BLACK"] }
	fonts["green_font_MPCD"]		= {fontdescription["font_HUD"], 10, materials["DBG_GREEN"] }
	fonts["cyan_font_MPCD"]			= {fontdescription["font_HUD"], 10, materials["DBG_CYAN"] }


-- force preload resources to avoid freeze on start (list of texture files)
--[[
preload_texture =
{
}
--]]