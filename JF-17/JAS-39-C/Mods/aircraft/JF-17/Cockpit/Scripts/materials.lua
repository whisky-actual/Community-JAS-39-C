dofile(LockOn_Options.common_script_path.."Fonts/symbols_locale.lua")
dofile(LockOn_Options.common_script_path.."Fonts/fonts_cmn.lua")

-- Global Macro
IND_TEX_PATH = LockOn_Options.script_path .. "../Textures/IndicationTextures/"

------- MATERIALS -------

materials = {}
--[[
materials["INDICATION_COMMON_RED"]      = {255, 0, 0, 255}
materials["INDICATION_COMMON_WHITE"]    = {255, 255, 255, 255}
materials["MASK_MATERIAL"]              = {255, 0, 255, 50}

materials["HUD_IND_YELLOW"]             = {243, 116, 13, 255}
materials["INDICATION_COMMON_RED"]      = {255, 0, 0, 255}

materials["LBLUE"]                      = {173, 216, 230, 255}

materials["DBG_GREY"]                   = {25, 25, 25, 255}
materials["DBG_BLACK"]                  = {0, 0, 0, 100}
materials["DBG_RED"]                    = {255, 0, 0, 100}
materials["DBG_GREEN"]                  = {0, 255, 0, 100}
materials["BLACK"]                      = {0, 0, 0, 255}
materials["SIMPLE_WHITE"]               = {255, 255, 255, 255}
materials["PURPLE"]                     = {255, 0, 255, 255}

materials["GENERAL_INFO_GOLD"]          = {255, 197, 3, 255}
materials["YELLOW"]                     = {255, 255, 0, 255}
materials["BLUE"]                       = {255, 0, 0, 255}
materials["RED"]                        = {255, 0, 0, 255}
]]

-- COMMON
materials["IND_COMMON_RED"]      = {204,   0,   0, 255}
materials["DBG_GREY"]            = { 26,  26,  26, 128}
materials["DBG_BLACK"]           = {  0,   0,   0, 128}
materials["DBG_RED"]             = {204,   0,   0, 128}
materials["DBG_GREEN"]           = {  0, 255,  77, 128} --{ 26, 255, 128, 128}
materials["BLACK"]               = {  0,   0,   0, 255}
materials["SIMPLE_WHITE"]        = {204, 204, 204, 255}
materials["PURPLE"]              = {204,   0, 255, 255}

-- HUD
materials["HUD_IND_DEF"]         = {  0, 255,  77, 255} --{ 26, 255, 128, 255}
materials["HUD_IND_CLIP"]        = {  0, 255,  77,   2} --{ 26, 255, 128,   2}
materials["HUD_IND_RED"]         = {204,   0,   0, 255}
materials["HUD_IND_GREEN"]       = {  0, 255,  77, 255} --{ 26, 255, 128, 255}
materials["HUD_IND_BLUE"]        = {  0,  51, 255, 255}
materials["HUD_IND_WHITE"]       = {255, 255, 255, 255}
materials["HUD_IND_YELLOW"]      = {204, 153,   0, 255}
materials["HUD_IND_DARK"]        = {  0,   0,   0, 255}
materials["HUD_IND_HIDE"]        = {  0,   0,   0,   0}

materials["HUD_IND_BASE1"]       = {  0, 255,  77, 255} --{ 26, 255, 128, 255}
materials["HUD_IND_BASE2"]       = {204, 153,   0, 255}

-- MFCDs
materials["MFCD_IND_DEF"]        = {  0, 255,  77, 255} --{ 26, 255, 128, 255}
materials["MFCD_IND_RED"]        = {204,   0,   0, 255}
materials["MFCD_IND_GREEN"]      = {  0, 255,  77, 255} --{ 26, 255, 128, 255}
materials["MFCD_IND_DGREEN"]     = {  0, 255,  77, 255} --{ 26, 255, 128, 255}
materials["MFCD_IND_BLUE"]       = {  0,   0, 255, 255}
materials["MFCD_IND_BLUE_L"]     = { 16,  32, 255, 255}
materials["MFCD_IND_BLACK"]      = {  0,   0,   0, 128}
materials["MFCD_IND_DARK"]       = {  0,   0,   0,  51}
materials["MFCD_IND_WHITE"]      = {255, 255, 255, 255}
materials["MFCD_IND_WHITE_Y"]    = {255, 255, 255, 255}
materials["MFCD_IND_PINK"]       = {255,  26, 204, 255}
materials["MFCD_IND_YELLOW"]     = {204, 153,   0, 255}
materials["MFCD_IND_SKY"]        = { 10,  40,  83,  64}
materials["MFCD_IND_GRND"]       = {  0, 255,  77, 128} --{ 26, 255, 128, 128}
materials["MFCD_IND_BOXBASE"]    = {  0,   0,   0,   0}
materials["MFCD_IND_W_BASE"]     = {  0,   0,   0, 208}

-- UFCP
materials["UFCP_IND_DEF"]        = {  0, 255,  77, 255} --{ 26, 255, 128, 255}
materials["UFCP_IND_CURSOR"]     = {  0, 255,  77, 255} --{ 26, 255, 128, 255}
materials["UFCP_IND_PAGEBASE"]   = {  0, 255,  77, 255} --{ 26, 255, 128, 255}

-- RADIO
materials["RADIO_IND_DEF"]       = {  0, 255,  77, 255} --{ 26, 255, 128, 255}
materials["RADIO_IND_RED"]       = {204,   0,   0, 255}
materials["RADIO_IND_YELLOW"]    = {204, 153,   0, 255}

-- CLOCK
materials["CLOCK_IND_DEF"]       = {  0, 255,  77, 255} --{ 26, 255, 128, 255}
materials["CLOCK_IND_RED"]       = {204,   0,   0, 255}
materials["CLOCK_IND_YELLOW"]    = {204, 153,   0, 255}

------- TEXTURES -------
textures = {}

-- COMMON
textures["ARCADE"]               = {"arcade.tga", materials["IND_COMMON_RED"]}
textures["ARCADE_PUPRLE"]        = {"arcade.tga", materials["PURPLE"]}
textures["ARCADE_WHITE"]         = {"arcade.tga", materials["SIMPLE_WHITE"]}

-- HUD
textures["hud_tex_ind1"]         = {IND_TEX_PATH .. "Indication_HUD_1.dds", materials["HUD_IND_DEF"]}
textures["hud_tex_ind1_r"]       = {IND_TEX_PATH .. "Indication_HUD_1.dds", materials["HUD_IND_RED"]}
textures["hud_tex_ind1_y"]       = {IND_TEX_PATH .. "Indication_HUD_1.dds", materials["HUD_IND_YELLOW"]}

textures["hud_tex_ind2"]         = {IND_TEX_PATH .. "Indication_HUD_2.dds", materials["HUD_IND_DEF"]}
textures["hud_tex_ind2_r"]       = {IND_TEX_PATH .. "Indication_HUD_2.dds", materials["HUD_IND_RED"]}
textures["hud_tex_ind2_y"]       = {IND_TEX_PATH .. "Indication_HUD_2.dds", materials["HUD_IND_YELLOW"]}

textures["hud_tex_clip"]         = {IND_TEX_PATH .. "Indication_HUD_clip.dds", materials["HUD_IND_CLIP"]}

textures["hud_mesh_def"]         = {nil, materials["HUD_IND_DEF"]}
textures["hud_mesh_base1"]       = {nil, materials["HUD_IND_BASE1"]}
textures["hud_mesh_base2"]       = {nil, materials["HUD_IND_BASE2"]}

textures["hud_line_dashed_def"]  = {IND_TEX_PATH .. "Indication_Line_Dashed.dds", materials["HUD_IND_DEF"]}

-- UFCP
textures["ufcd_mesh_def"]        = {nil, materials["UFCP_IND_DEF"]}
textures["ufcd_mesh_cursor"]     = {nil, materials["UFCP_IND_CURSOR"]}
textures["ufcd_mesh_pagebase"]   = {nil, materials["UFCP_IND_PAGEBASE"]}

-- RADIO
textures["radio_mesh_def"]       = {nil, materials["RADIO_IND_DEF"]}
textures["radio_mesh_r"]         = {nil, materials["RADIO_IND_RED"]}
textures["radio_mesh_y"]         = {nil, materials["RADIO_IND_YELLOW"]}

-- Clock
textures["clock_mesh_def"]       = {nil, materials["CLOCK_IND_DEF"]}

-- MFCDs
textures["mfcd_tex_basic"]       = {IND_TEX_PATH .. "label_basic.dds",   materials["MFCD_IND_DEF"]}
textures["mfcd_tex_basic_w"]     = {IND_TEX_PATH .. "label_basic.dds",   materials["MFCD_IND_WHITE"]}
textures["mfcd_tex_basic_wy"]    = {IND_TEX_PATH .. "label_basic.dds",   materials["MFCD_IND_WHITE_Y"]}
textures["mfcd_tex_basic_g"]     = {IND_TEX_PATH .. "label_basic.dds",   materials["MFCD_IND_GREEN"]}
textures["mfcd_tex_basic_d"]     = {IND_TEX_PATH .. "label_basic.dds",   materials["MFCD_IND_DARK"]}
textures["mfcd_tex_basic_bk"]    = {IND_TEX_PATH .. "label_basic.dds",   materials["MFCD_IND_BLACK"]}

-- new ones, will all be replaced by them
textures["mfcd_tex_ind1"]        = {IND_TEX_PATH .. "Indication_MFCD_1.dds", materials["MFCD_IND_DEF"]}
textures["mfcd_tex_ind1_g"]      = {IND_TEX_PATH .. "Indication_MFCD_1.dds", materials["MFCD_IND_GREEN"]}
textures["mfcd_tex_ind1_w"]      = {IND_TEX_PATH .. "Indication_MFCD_1.dds", materials["MFCD_IND_WHITE"]}
textures["mfcd_tex_ind1_wy"]     = {IND_TEX_PATH .. "Indication_MFCD_1.dds", materials["MFCD_IND_WHITE_Y"]}
textures["mfcd_tex_ind1_y"]      = {IND_TEX_PATH .. "Indication_MFCD_1.dds", materials["MFCD_IND_YELLOW"]}
textures["mfcd_tex_ind1_r"]      = {IND_TEX_PATH .. "Indication_MFCD_1.dds", materials["MFCD_IND_RED"]}

textures["mfcd_tex_ind2"]        = {IND_TEX_PATH .. "Indication_MFCD_2.dds", materials["MFCD_IND_DEF"]}
textures["mfcd_tex_ind2_g"]      = {IND_TEX_PATH .. "Indication_MFCD_2.dds", materials["MFCD_IND_GREEN"]}
textures["mfcd_tex_ind2_w"]      = {IND_TEX_PATH .. "Indication_MFCD_2.dds", materials["MFCD_IND_WHITE"]}
textures["mfcd_tex_ind2_wy"]     = {IND_TEX_PATH .. "Indication_MFCD_2.dds", materials["MFCD_IND_WHITE_Y"]}
textures["mfcd_tex_ind2_y"]      = {IND_TEX_PATH .. "Indication_MFCD_2.dds", materials["MFCD_IND_YELLOW"]}
textures["mfcd_tex_ind2_r"]      = {IND_TEX_PATH .. "Indication_MFCD_2.dds", materials["MFCD_IND_RED"]}

textures["mfcd_tex_ind3"]        = {IND_TEX_PATH .. "Indication_MFCD_3.dds", materials["MFCD_IND_DEF"]}
textures["mfcd_tex_ind3_g"]      = {IND_TEX_PATH .. "Indication_MFCD_3.dds", materials["MFCD_IND_GREEN"]}
textures["mfcd_tex_ind3_w"]      = {IND_TEX_PATH .. "Indication_MFCD_3.dds", materials["MFCD_IND_WHITE"]}
textures["mfcd_tex_ind3_wy"]     = {IND_TEX_PATH .. "Indication_MFCD_3.dds", materials["MFCD_IND_WHITE_Y"]}
textures["mfcd_tex_ind3_y"]      = {IND_TEX_PATH .. "Indication_MFCD_3.dds", materials["MFCD_IND_YELLOW"]}
textures["mfcd_tex_ind3_r"]      = {IND_TEX_PATH .. "Indication_MFCD_3.dds", materials["MFCD_IND_RED"]}
textures["mfcd_tex_ind3_bl"]     = {IND_TEX_PATH .. "Indication_MFCD_3.dds", materials["MFCD_IND_BLUE_L"]}

textures["mfcd_tex_ind4"]        = {IND_TEX_PATH .. "Indication_MFCD_4.dds", materials["MFCD_IND_DEF"]}
textures["mfcd_tex_ind4_g"]      = {IND_TEX_PATH .. "Indication_MFCD_4.dds", materials["MFCD_IND_GREEN"]}
textures["mfcd_tex_ind4_w"]      = {IND_TEX_PATH .. "Indication_MFCD_4.dds", materials["MFCD_IND_WHITE"]}
textures["mfcd_tex_ind4_wy"]     = {IND_TEX_PATH .. "Indication_MFCD_4.dds", materials["MFCD_IND_WHITE_Y"]}
textures["mfcd_tex_ind4_y"]      = {IND_TEX_PATH .. "Indication_MFCD_4.dds", materials["MFCD_IND_YELLOW"]}
textures["mfcd_tex_ind4_r"]      = {IND_TEX_PATH .. "Indication_MFCD_4.dds", materials["MFCD_IND_RED"]}

textures["mfcd_tex_ind5"]        = {IND_TEX_PATH .. "Indication_MFCD_5.dds", materials["MFCD_IND_DEF"]}
textures["mfcd_tex_ind5_g"]      = {IND_TEX_PATH .. "Indication_MFCD_5.dds", materials["MFCD_IND_GREEN"]}
textures["mfcd_tex_ind5_w"]      = {IND_TEX_PATH .. "Indication_MFCD_5.dds", materials["MFCD_IND_WHITE"]}
textures["mfcd_tex_ind5_wy"]     = {IND_TEX_PATH .. "Indication_MFCD_5.dds", materials["MFCD_IND_WHITE_Y"]}
textures["mfcd_tex_ind5_y"]      = {IND_TEX_PATH .. "Indication_MFCD_5.dds", materials["MFCD_IND_YELLOW"]}
textures["mfcd_tex_ind5_r"]      = {IND_TEX_PATH .. "Indication_MFCD_5.dds", materials["MFCD_IND_RED"]}

textures["mfcd_line_dashed_def"] = {IND_TEX_PATH .. "Indication_Line_Dashed.dds", materials["MFCD_IND_DEF"]}
textures["mfcd_line_dashed_r"]   = {IND_TEX_PATH .. "Indication_Line_Dashed.dds", materials["MFCD_IND_RED"]}
textures["mfcd_line_dashed_w"]   = {IND_TEX_PATH .. "Indication_Line_Dashed.dds", materials["MFCD_IND_WHITE"]}
textures["mfcd_line_dashed_y"]   = {IND_TEX_PATH .. "Indication_Line_Dashed.dds", materials["MFCD_IND_YELLOW"]}


textures["mfcd_mesh_def"]        = {nil, materials["MFCD_IND_DEF"]}
textures["mfcd_mesh_r"]          = {nil, materials["MFCD_IND_RED"]}
textures["mfcd_mesh_g"]          = {nil, materials["MFCD_IND_GREEN"]}
textures["mfcd_mesh_b"]          = {nil, materials["MFCD_IND_BLUE"]}
textures["mfcd_mesh_bl"]         = {nil, materials["MFCD_IND_BLUE_L"]}
textures["mfcd_mesh_bk"]         = {nil, materials["MFCD_IND_BLACK"]}
textures["mfcd_mesh_d"]          = {nil, materials["MFCD_IND_DARK"]}
textures["mfcd_mesh_w"]          = {nil, materials["MFCD_IND_WHITE"]}
textures["mfcd_mesh_wy"]         = {nil, materials["MFCD_IND_WHITE_Y"]} -- 略带淡黄色
textures["mfcd_mesh_p"]          = {nil, materials["MFCD_IND_PINK"]}
textures["mfcd_mesh_y"]          = {nil, materials["MFCD_IND_YELLOW"]}
textures["mfcd_mesh_sky"]        = {nil, materials["MFCD_IND_SKY"]}
textures["mfcd_mesh_gnd"]        = {nil, materials["MFCD_IND_GRND"]}
textures["mfcd_mesh_boxbase"]    = {nil, materials["MFCD_IND_BOXBASE"]}
textures["mfcd_mesh_whitebase"]  = {nil, materials["MFCD_IND_W_BASE"]}



------- FONTS ----------
fontdescription = {}
fontdescription["font_general_loc"]    = fontdescription_cmn["font_general_loc"]

-- HUD
HUD_X_PIXEL = 88 -- pi
HUD_Y_PIXEL = 144

fontdescription["font_HUD"] = {
    texture     = IND_TEX_PATH .. "font_HUD.dds",
    size        = {10, 10},
    resolution  = {1440, 1440},
    default     = {HUD_X_PIXEL, HUD_Y_PIXEL},
    chars       = {
        {32, HUD_X_PIXEL, HUD_Y_PIXEL}, -- [space]
        {48, HUD_X_PIXEL, HUD_Y_PIXEL}, -- 0
        {49, HUD_X_PIXEL, HUD_Y_PIXEL}, -- 1
        {50, HUD_X_PIXEL, HUD_Y_PIXEL}, -- 2
        {51, HUD_X_PIXEL, HUD_Y_PIXEL}, -- 3
        {52, HUD_X_PIXEL, HUD_Y_PIXEL}, -- 4
        {53, HUD_X_PIXEL, HUD_Y_PIXEL}, -- 5
        {54, HUD_X_PIXEL, HUD_Y_PIXEL}, -- 6
        {55, HUD_X_PIXEL, HUD_Y_PIXEL}, -- 7
        {56, HUD_X_PIXEL, HUD_Y_PIXEL}, -- 8
        {57, HUD_X_PIXEL, HUD_Y_PIXEL}, -- 9

        {64, HUD_X_PIXEL, HUD_Y_PIXEL}, -- Alpha -> @

        -- upper
        {65, HUD_X_PIXEL, HUD_Y_PIXEL}, -- A bold
        {66, HUD_X_PIXEL, HUD_Y_PIXEL}, -- B bold
        {67, HUD_X_PIXEL, HUD_Y_PIXEL}, -- C bold
        {68, HUD_X_PIXEL, HUD_Y_PIXEL}, -- D bold
        {69, HUD_X_PIXEL, HUD_Y_PIXEL}, -- E bold
        {70, HUD_X_PIXEL, HUD_Y_PIXEL}, -- F bold
        {71, HUD_X_PIXEL, HUD_Y_PIXEL}, -- G bold
        {72, HUD_X_PIXEL, HUD_Y_PIXEL}, -- H bold
        {73, HUD_X_PIXEL, HUD_Y_PIXEL}, -- I bold
        {74, HUD_X_PIXEL, HUD_Y_PIXEL}, -- J bold
        {75, HUD_X_PIXEL, HUD_Y_PIXEL}, -- K bold
        {76, HUD_X_PIXEL, HUD_Y_PIXEL}, -- L bold
        {77, HUD_X_PIXEL, HUD_Y_PIXEL}, -- M bold
        {78, HUD_X_PIXEL, HUD_Y_PIXEL}, -- N bold
        {79, HUD_X_PIXEL, HUD_Y_PIXEL}, -- O bold
        {80, HUD_X_PIXEL, HUD_Y_PIXEL}, -- P bold
        {81, HUD_X_PIXEL, HUD_Y_PIXEL}, -- Q bold
        {82, HUD_X_PIXEL, HUD_Y_PIXEL}, -- R bold
        {83, HUD_X_PIXEL, HUD_Y_PIXEL}, -- S bold
        {84, HUD_X_PIXEL, HUD_Y_PIXEL}, -- T bold
        {85, HUD_X_PIXEL, HUD_Y_PIXEL}, -- U bold
        {86, HUD_X_PIXEL, HUD_Y_PIXEL}, -- V bold
        {87, HUD_X_PIXEL, HUD_Y_PIXEL}, -- W bold
        {88, HUD_X_PIXEL, HUD_Y_PIXEL}, -- X bold
        {89, HUD_X_PIXEL, HUD_Y_PIXEL}, -- Y bold
        {90, HUD_X_PIXEL, HUD_Y_PIXEL}, -- Z bold
        
        -- normal replaced by lower case
        --[[
        {65+32, HUD_X_PIXEL, HUD_Y_PIXEL}, -- A -> a
        {66+32, HUD_X_PIXEL, HUD_Y_PIXEL}, -- B
        {67+32, HUD_X_PIXEL, HUD_Y_PIXEL}, -- C
        {68+32, HUD_X_PIXEL, HUD_Y_PIXEL}, -- D
        {69+32, HUD_X_PIXEL, HUD_Y_PIXEL}, -- E
        {70+32, HUD_X_PIXEL, HUD_Y_PIXEL}, -- F
        {71+32, HUD_X_PIXEL, HUD_Y_PIXEL}, -- G
        {72+32, HUD_X_PIXEL, HUD_Y_PIXEL}, -- H
        {73+32, HUD_X_PIXEL, HUD_Y_PIXEL}, -- I
        {74+32, HUD_X_PIXEL, HUD_Y_PIXEL}, -- J
        {75+32, HUD_X_PIXEL, HUD_Y_PIXEL}, -- K
        {76+32, HUD_X_PIXEL, HUD_Y_PIXEL}, -- L
        {77+32, HUD_X_PIXEL, HUD_Y_PIXEL}, -- M
        {78+32, HUD_X_PIXEL, HUD_Y_PIXEL}, -- N
        {79+32, HUD_X_PIXEL, HUD_Y_PIXEL}, -- O
        {80+32, HUD_X_PIXEL, HUD_Y_PIXEL}, -- P
        {81+32, HUD_X_PIXEL, HUD_Y_PIXEL}, -- Q
        {82+32, HUD_X_PIXEL, HUD_Y_PIXEL}, -- R
        {83+32, HUD_X_PIXEL, HUD_Y_PIXEL}, -- S
        {84+32, HUD_X_PIXEL, HUD_Y_PIXEL}, -- T
        {85+32, HUD_X_PIXEL, HUD_Y_PIXEL}, -- U
        {86+32, HUD_X_PIXEL, HUD_Y_PIXEL}, -- V
        {87+32, HUD_X_PIXEL, HUD_Y_PIXEL}, -- W
        {88+32, HUD_X_PIXEL, HUD_Y_PIXEL}, -- X
        {89+32, HUD_X_PIXEL, HUD_Y_PIXEL}, -- Y
        {90+32, HUD_X_PIXEL, HUD_Y_PIXEL}, -- Z -> z
        ]]
         
        {42, HUD_X_PIXEL, HUD_Y_PIXEL}, -- *
        {43, HUD_X_PIXEL, HUD_Y_PIXEL}, -- +
        {45, HUD_X_PIXEL, HUD_Y_PIXEL}, -- -
        {61, HUD_X_PIXEL, HUD_Y_PIXEL}, -- =
        {47, HUD_X_PIXEL, HUD_Y_PIXEL}, -- /
        {92, HUD_X_PIXEL, HUD_Y_PIXEL}, -- \
        {40, HUD_X_PIXEL, HUD_Y_PIXEL}, -- (
        {41, HUD_X_PIXEL, HUD_Y_PIXEL}, -- )
        {91, HUD_X_PIXEL, HUD_Y_PIXEL}, -- [
        {93, HUD_X_PIXEL, HUD_Y_PIXEL}, -- ]
        {123, HUD_X_PIXEL, HUD_Y_PIXEL}, -- {
        {125, HUD_X_PIXEL, HUD_Y_PIXEL}, -- }
        {60, HUD_X_PIXEL, HUD_Y_PIXEL}, -- <
        {62, HUD_X_PIXEL, HUD_Y_PIXEL}, -- >
        {63, HUD_X_PIXEL, HUD_Y_PIXEL}, -- ?
        {124, HUD_X_PIXEL, HUD_Y_PIXEL}, -- |
        {33, HUD_X_PIXEL, HUD_Y_PIXEL}, -- !
        {35, HUD_X_PIXEL, HUD_Y_PIXEL}, -- #
        {37, HUD_X_PIXEL, HUD_Y_PIXEL}, -- %
        {94, HUD_X_PIXEL, HUD_Y_PIXEL}, -- ^
        {38, HUD_X_PIXEL, HUD_Y_PIXEL}, -- &
        {96, HUD_X_PIXEL, HUD_Y_PIXEL}, -- o -- degree, change its ascii code to 96 ', original 248 (out of index)
        {46, HUD_X_PIXEL, HUD_Y_PIXEL}, -- .
        {58, HUD_X_PIXEL, HUD_Y_PIXEL}, -- :        
        {44, HUD_X_PIXEL, HUD_Y_PIXEL}, -- ,
        {95, HUD_X_PIXEL, HUD_Y_PIXEL}, -- _
        
        {127, HUD_X_PIXEL, HUD_Y_PIXEL}, -- delta, use last ascii code
    }
}

-- MFCDs
MFCD_X_PIXEL =  88
MFCD_Y_PIXEL =  144

fontdescription["font_MFCD"] = {
    texture     = IND_TEX_PATH .. "font_MFCD.dds",
    size        = {10, 10},
    resolution  = {1440, 1440},
    default     = {MFCD_X_PIXEL, MFCD_Y_PIXEL},
    chars       = {
        {32, MFCD_X_PIXEL, MFCD_Y_PIXEL}, -- space
        {48, MFCD_X_PIXEL, MFCD_Y_PIXEL}, -- 0
        {49, MFCD_X_PIXEL, MFCD_Y_PIXEL}, -- 1
        {50, MFCD_X_PIXEL, MFCD_Y_PIXEL}, -- 2
        {51, MFCD_X_PIXEL, MFCD_Y_PIXEL}, -- 3
        {52, MFCD_X_PIXEL, MFCD_Y_PIXEL}, -- 4
        {53, MFCD_X_PIXEL, MFCD_Y_PIXEL}, -- 5
        {54, MFCD_X_PIXEL, MFCD_Y_PIXEL}, -- 6
        {55, MFCD_X_PIXEL, MFCD_Y_PIXEL}, -- 7
        {56, MFCD_X_PIXEL, MFCD_Y_PIXEL}, -- 8
        {57, MFCD_X_PIXEL, MFCD_Y_PIXEL}, -- 9

        {64, MFCD_X_PIXEL, MFCD_Y_PIXEL}, -- Alpha -> @

        {65, MFCD_X_PIXEL, MFCD_Y_PIXEL}, -- A
        {66, MFCD_X_PIXEL, MFCD_Y_PIXEL}, -- B
        {67, MFCD_X_PIXEL, MFCD_Y_PIXEL}, -- C
        {68, MFCD_X_PIXEL, MFCD_Y_PIXEL}, -- D
        {69, MFCD_X_PIXEL, MFCD_Y_PIXEL}, -- E
        {70, MFCD_X_PIXEL, MFCD_Y_PIXEL}, -- F
        {71, MFCD_X_PIXEL, MFCD_Y_PIXEL}, -- G
        {72, MFCD_X_PIXEL, MFCD_Y_PIXEL}, -- H
        {73, MFCD_X_PIXEL, MFCD_Y_PIXEL}, -- I
        {74, MFCD_X_PIXEL, MFCD_Y_PIXEL}, -- J
        {75, MFCD_X_PIXEL, MFCD_Y_PIXEL}, -- K
        {76, MFCD_X_PIXEL, MFCD_Y_PIXEL}, -- L
        {77, MFCD_X_PIXEL, MFCD_Y_PIXEL}, -- M
        {78, MFCD_X_PIXEL, MFCD_Y_PIXEL}, -- N
        {79, MFCD_X_PIXEL, MFCD_Y_PIXEL}, -- O
        {80, MFCD_X_PIXEL, MFCD_Y_PIXEL}, -- P
        {81, MFCD_X_PIXEL, MFCD_Y_PIXEL}, -- Q
        {82, MFCD_X_PIXEL, MFCD_Y_PIXEL}, -- R
        {83, MFCD_X_PIXEL, MFCD_Y_PIXEL}, -- S
        {84, MFCD_X_PIXEL, MFCD_Y_PIXEL}, -- T
        {85, MFCD_X_PIXEL, MFCD_Y_PIXEL}, -- U
        {86, MFCD_X_PIXEL, MFCD_Y_PIXEL}, -- V
        {87, MFCD_X_PIXEL, MFCD_Y_PIXEL}, -- W
        {88, MFCD_X_PIXEL, MFCD_Y_PIXEL}, -- X
        {89, MFCD_X_PIXEL, MFCD_Y_PIXEL}, -- Y
        {90, MFCD_X_PIXEL, MFCD_Y_PIXEL}, -- Z
         
        {42, MFCD_X_PIXEL, MFCD_Y_PIXEL}, -- *
        {43, MFCD_X_PIXEL, MFCD_Y_PIXEL}, -- +
        {45, MFCD_X_PIXEL, MFCD_Y_PIXEL}, -- -
        {47, MFCD_X_PIXEL, MFCD_Y_PIXEL}, -- /
        {92, MFCD_X_PIXEL, MFCD_Y_PIXEL}, -- \
        {40, MFCD_X_PIXEL, MFCD_Y_PIXEL}, -- (
        {41, MFCD_X_PIXEL, MFCD_Y_PIXEL}, -- )
        {91, MFCD_X_PIXEL, MFCD_Y_PIXEL}, -- [
        {93, MFCD_X_PIXEL, MFCD_Y_PIXEL}, -- ]
        {123, MFCD_X_PIXEL, MFCD_Y_PIXEL}, -- {
        {125, MFCD_X_PIXEL, MFCD_Y_PIXEL}, -- }
        {60, MFCD_X_PIXEL, MFCD_Y_PIXEL}, -- <
        {62, MFCD_X_PIXEL, MFCD_Y_PIXEL}, -- >
        {61, MFCD_X_PIXEL, MFCD_Y_PIXEL}, -- =
        {63, MFCD_X_PIXEL, MFCD_Y_PIXEL}, -- ?
        {124, MFCD_X_PIXEL, MFCD_Y_PIXEL}, -- |
        {33, MFCD_X_PIXEL, MFCD_Y_PIXEL}, -- !
        {35, MFCD_X_PIXEL, MFCD_Y_PIXEL}, -- #
        {37, MFCD_X_PIXEL, MFCD_Y_PIXEL}, -- %
        {94, MFCD_X_PIXEL, MFCD_Y_PIXEL}, -- ^
        {38, MFCD_X_PIXEL, MFCD_Y_PIXEL}, -- &
        {96, MFCD_X_PIXEL, MFCD_Y_PIXEL}, -- o -- degree, change its ascii code to 96 ', original 248 (out of index)
        {46, MFCD_X_PIXEL, MFCD_Y_PIXEL}, -- .
        {58, MFCD_X_PIXEL, MFCD_Y_PIXEL}, -- :
        {44, MFCD_X_PIXEL, MFCD_Y_PIXEL}, -- ,
        {126, MFCD_X_PIXEL, MFCD_Y_PIXEL}, -- cursor -> ~
        {95, MFCD_X_PIXEL, MFCD_Y_PIXEL}, -- _
        
        {39, MFCD_X_PIXEL, MFCD_Y_PIXEL}, -- '
        {34, MFCD_X_PIXEL, MFCD_Y_PIXEL}, -- "
        --{32, MFCD_X_PIXEL, MFCD_Y_PIXEL}, -- [space]
        
        {127, MFCD_X_PIXEL, MFCD_Y_PIXEL}, -- delta, use last ascii code
    }
}


MFCD_WPN_X_PIXEL =  52
MFCD_WPN_Y_PIXEL =  72

fontdescription["font_MFCD_wpn"] = {
    texture     = IND_TEX_PATH .. "font_MFCD_wpn.dds",
    size        = {8, 8},
    resolution  = {576, 576},
    default     = {MFCD_WPN_X_PIXEL, MFCD_WPN_Y_PIXEL},
    chars       = {
        {32, MFCD_WPN_X_PIXEL, MFCD_WPN_Y_PIXEL}, -- space
        {48, MFCD_WPN_X_PIXEL, MFCD_WPN_Y_PIXEL}, -- 0
        {49, MFCD_WPN_X_PIXEL, MFCD_WPN_Y_PIXEL}, -- 1
        {50, MFCD_WPN_X_PIXEL, MFCD_WPN_Y_PIXEL}, -- 2
        {51, MFCD_WPN_X_PIXEL, MFCD_WPN_Y_PIXEL}, -- 3
        {52, MFCD_WPN_X_PIXEL, MFCD_WPN_Y_PIXEL}, -- 4
        {53, MFCD_WPN_X_PIXEL, MFCD_WPN_Y_PIXEL}, -- 5
        {54, MFCD_WPN_X_PIXEL, MFCD_WPN_Y_PIXEL}, -- 6
        {55, MFCD_WPN_X_PIXEL, MFCD_WPN_Y_PIXEL}, -- 7
        {56, MFCD_WPN_X_PIXEL, MFCD_WPN_Y_PIXEL}, -- 8
        {57, MFCD_WPN_X_PIXEL, MFCD_WPN_Y_PIXEL}, -- 9
        
        {65, MFCD_WPN_X_PIXEL, MFCD_WPN_Y_PIXEL}, -- A
        {66, MFCD_WPN_X_PIXEL, MFCD_WPN_Y_PIXEL}, -- B
        {67, MFCD_WPN_X_PIXEL, MFCD_WPN_Y_PIXEL}, -- C
        {68, MFCD_WPN_X_PIXEL, MFCD_WPN_Y_PIXEL}, -- D
        {69, MFCD_WPN_X_PIXEL, MFCD_WPN_Y_PIXEL}, -- E
        {70, MFCD_WPN_X_PIXEL, MFCD_WPN_Y_PIXEL}, -- F
        {71, MFCD_WPN_X_PIXEL, MFCD_WPN_Y_PIXEL}, -- G
        {72, MFCD_WPN_X_PIXEL, MFCD_WPN_Y_PIXEL}, -- H
        {73, MFCD_WPN_X_PIXEL, MFCD_WPN_Y_PIXEL}, -- I
        {74, MFCD_WPN_X_PIXEL, MFCD_WPN_Y_PIXEL}, -- J
        {75, MFCD_WPN_X_PIXEL, MFCD_WPN_Y_PIXEL}, -- K
        {76, MFCD_WPN_X_PIXEL, MFCD_WPN_Y_PIXEL}, -- L
        {77, MFCD_WPN_X_PIXEL, MFCD_WPN_Y_PIXEL}, -- M
        {78, MFCD_WPN_X_PIXEL, MFCD_WPN_Y_PIXEL}, -- N
        {79, MFCD_WPN_X_PIXEL, MFCD_WPN_Y_PIXEL}, -- O
        {80, MFCD_WPN_X_PIXEL, MFCD_WPN_Y_PIXEL}, -- P
        {81, MFCD_WPN_X_PIXEL, MFCD_WPN_Y_PIXEL}, -- Q
        {82, MFCD_WPN_X_PIXEL, MFCD_WPN_Y_PIXEL}, -- R
        {83, MFCD_WPN_X_PIXEL, MFCD_WPN_Y_PIXEL}, -- S
        {84, MFCD_WPN_X_PIXEL, MFCD_WPN_Y_PIXEL}, -- T
        {85, MFCD_WPN_X_PIXEL, MFCD_WPN_Y_PIXEL}, -- U
        {86, MFCD_WPN_X_PIXEL, MFCD_WPN_Y_PIXEL}, -- V
        {87, MFCD_WPN_X_PIXEL, MFCD_WPN_Y_PIXEL}, -- W
        {88, MFCD_WPN_X_PIXEL, MFCD_WPN_Y_PIXEL}, -- X
        {89, MFCD_WPN_X_PIXEL, MFCD_WPN_Y_PIXEL}, -- Y
        {90, MFCD_WPN_X_PIXEL, MFCD_WPN_Y_PIXEL}, -- Z
        
        {46, MFCD_WPN_X_PIXEL, MFCD_WPN_Y_PIXEL}, -- .
    }
}


-- UFCP
UFCP_X_PIXEL = 80 -- pix
UFCP_Y_PIXEL = 144

fontdescription["font_UFCP"] = {
    texture     = IND_TEX_PATH .. "font_UFCP.dds",
    size        = {8, 8},
    resolution  = {1152, 1152},
    default     = {UFCP_X_PIXEL, UFCP_Y_PIXEL},
    chars       = {
        {32, UFCP_X_PIXEL, UFCP_Y_PIXEL}, -- [space]
        {48, UFCP_X_PIXEL, UFCP_Y_PIXEL}, -- 0
        {49, UFCP_X_PIXEL, UFCP_Y_PIXEL}, -- 1
        {50, UFCP_X_PIXEL, UFCP_Y_PIXEL}, -- 2
        {51, UFCP_X_PIXEL, UFCP_Y_PIXEL}, -- 3
        {52, UFCP_X_PIXEL, UFCP_Y_PIXEL}, -- 4
        {53, UFCP_X_PIXEL, UFCP_Y_PIXEL}, -- 5
        {54, UFCP_X_PIXEL, UFCP_Y_PIXEL}, -- 6
        {55, UFCP_X_PIXEL, UFCP_Y_PIXEL}, -- 7
        {56, UFCP_X_PIXEL, UFCP_Y_PIXEL}, -- 8
        {57, UFCP_X_PIXEL, UFCP_Y_PIXEL}, -- 9
        
        {65, UFCP_X_PIXEL, UFCP_Y_PIXEL}, -- A
        {66, UFCP_X_PIXEL, UFCP_Y_PIXEL}, -- B
        {67, UFCP_X_PIXEL, UFCP_Y_PIXEL}, -- C
        {68, UFCP_X_PIXEL, UFCP_Y_PIXEL}, -- D
        {69, UFCP_X_PIXEL, UFCP_Y_PIXEL}, -- E
        {70, UFCP_X_PIXEL, UFCP_Y_PIXEL}, -- F
        {71, UFCP_X_PIXEL, UFCP_Y_PIXEL}, -- G
        {72, UFCP_X_PIXEL, UFCP_Y_PIXEL}, -- H
        {73, UFCP_X_PIXEL, UFCP_Y_PIXEL}, -- I
        {74, UFCP_X_PIXEL, UFCP_Y_PIXEL}, -- J
        {75, UFCP_X_PIXEL, UFCP_Y_PIXEL}, -- K
        {76, UFCP_X_PIXEL, UFCP_Y_PIXEL}, -- L
        {77, UFCP_X_PIXEL, UFCP_Y_PIXEL}, -- M
        {78, UFCP_X_PIXEL, UFCP_Y_PIXEL}, -- N
        {79, UFCP_X_PIXEL, UFCP_Y_PIXEL}, -- O
        {80, UFCP_X_PIXEL, UFCP_Y_PIXEL}, -- P
        {81, UFCP_X_PIXEL, UFCP_Y_PIXEL}, -- Q
        {82, UFCP_X_PIXEL, UFCP_Y_PIXEL}, -- R
        {83, UFCP_X_PIXEL, UFCP_Y_PIXEL}, -- S
        {84, UFCP_X_PIXEL, UFCP_Y_PIXEL}, -- T
        {85, UFCP_X_PIXEL, UFCP_Y_PIXEL}, -- U
        {86, UFCP_X_PIXEL, UFCP_Y_PIXEL}, -- V
        {87, UFCP_X_PIXEL, UFCP_Y_PIXEL}, -- W
        {88, UFCP_X_PIXEL, UFCP_Y_PIXEL}, -- X
        {89, UFCP_X_PIXEL, UFCP_Y_PIXEL}, -- Y
        {90, UFCP_X_PIXEL, UFCP_Y_PIXEL}, -- Z
        
        {42, UFCP_X_PIXEL, UFCP_Y_PIXEL}, -- *
        {43, UFCP_X_PIXEL, UFCP_Y_PIXEL}, -- +
        {45, UFCP_X_PIXEL, UFCP_Y_PIXEL}, -- -
        {47, UFCP_X_PIXEL, UFCP_Y_PIXEL}, -- /
        {92, UFCP_X_PIXEL, UFCP_Y_PIXEL}, -- \
        {40, UFCP_X_PIXEL, UFCP_Y_PIXEL}, -- (
        {41, UFCP_X_PIXEL, UFCP_Y_PIXEL}, -- )
        {91, UFCP_X_PIXEL, UFCP_Y_PIXEL}, -- [
        {93, UFCP_X_PIXEL, UFCP_Y_PIXEL}, -- ]
        {123, UFCP_X_PIXEL, UFCP_Y_PIXEL}, -- {
        {125, UFCP_X_PIXEL, UFCP_Y_PIXEL}, -- }
        {60, UFCP_X_PIXEL, UFCP_Y_PIXEL}, -- <
        {62, UFCP_X_PIXEL, UFCP_Y_PIXEL}, -- >
        {61, UFCP_X_PIXEL, UFCP_Y_PIXEL}, -- =
        {63, UFCP_X_PIXEL, UFCP_Y_PIXEL}, -- ?
        {127, UFCP_X_PIXEL, UFCP_Y_PIXEL}, -- delta, use last ascii code
        {33, UFCP_X_PIXEL, UFCP_Y_PIXEL}, -- !
        {35, UFCP_X_PIXEL, UFCP_Y_PIXEL}, -- #
        {37, UFCP_X_PIXEL, UFCP_Y_PIXEL}, -- %
        {94, UFCP_X_PIXEL, UFCP_Y_PIXEL}, -- ^
        {38, UFCP_X_PIXEL, UFCP_Y_PIXEL}, -- &
        {96, UFCP_X_PIXEL, UFCP_Y_PIXEL}, -- o -- degree, change its ascii code to 96 ', original 248 (out of index)
        {46, UFCP_X_PIXEL, UFCP_Y_PIXEL}, -- .
        {58, UFCP_X_PIXEL, UFCP_Y_PIXEL}, -- :
        {44, UFCP_X_PIXEL, UFCP_Y_PIXEL}, -- ,
        {126, UFCP_X_PIXEL, UFCP_Y_PIXEL}, -- cursor -> ~
        {95, UFCP_X_PIXEL, UFCP_Y_PIXEL}, -- _
    }
}


-- RADIO
RADIO_X_PIXEL = 88 -- pi
RADIO_Y_PIXEL = 144

fontdescription["font_RADIO"] = {
    texture     = IND_TEX_PATH .. "font_RADIO.dds",
    size        = {10, 10},
    resolution  = {1440, 1440},
    default     = {RADIO_X_PIXEL, RADIO_Y_PIXEL},
    chars       = {
        {32, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- [space]
        {48, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- 0
        {49, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- 1
        {50, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- 2
        {51, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- 3
        {52, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- 4
        {53, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- 5
        {54, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- 6
        {55, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- 7
        {56, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- 8
        {57, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- 9
        
        -- upper
        {65, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- A bold
        {66, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- B bold
        {67, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- C bold
        {68, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- D bold
        {69, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- E bold
        {70, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- F bold
        {71, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- G bold
        {72, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- H bold
        {73, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- I bold
        {74, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- J bold
        {75, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- K bold
        {76, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- L bold
        {77, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- M bold
        {78, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- N bold
        {79, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- O bold
        {80, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- P bold
        {81, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- Q bold
        {82, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- R bold
        {83, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- S bold
        {84, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- T bold
        {85, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- U bold
        {86, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- V bold
        {87, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- W bold
        {88, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- X bold
        {89, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- Y bold
        {90, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- Z bold
        
        -- lower case
        {65+32, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- A -> a
        {66+32, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- B
        {67+32, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- C
        {68+32, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- D
        {69+32, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- E
        {70+32, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- F
        {71+32, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- G
        {72+32, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- H
        {73+32, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- I
        {74+32, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- J
        {75+32, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- K
        {76+32, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- L
        {77+32, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- M
        {78+32, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- N
        {79+32, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- O
        {80+32, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- P
        {81+32, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- Q
        {82+32, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- R
        {83+32, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- S
        {84+32, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- T
        {85+32, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- U
        {86+32, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- V
        {87+32, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- W
        {88+32, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- X
        {89+32, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- Y
        {90+32, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- Z -> z
         
        -- other
        {42, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- *
        {43, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- +
        {45, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- -
        {47, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- /
        {92, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- \
        {40, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- (
        {41, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- )
        {91, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- [
        {93, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- ]
        {123, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- {
        {125, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- }
        {60, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- <
        {62, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- >
        {61, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- =
        {63, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- ?
        {127, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- delta, use last ascii code
        {33, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- !
        {35, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- #
        {37, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- %
        {94, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- ^
        {38, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- &
        {96, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- o -- degree, change its ascii code to 96 ', original 248 (out of index)
        {46, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- .
        {58, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- :        
        {44, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- ,
        {126, RADIO_X_PIXEL, RADIO_X_PIXEL}, -- cursor -> ~
        {95, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- _
        
        {31, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- ↑ large
        {30, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- ↑ med
        {29, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- ↑ small
        {28, RADIO_X_PIXEL, RADIO_Y_PIXEL}, -- ↓ large
        
    }
}


-- DIGITAL CLOCK
DC_X_PIXEL = 38
DC_Y_PIXEL = 65
fontdescription["font_CLOCK"] = {
    texture    = IND_TEX_PATH .. "font_Clock.tga",
    size       = {4, 4},
    resolution = {256, 256},
    default    = {DC_X_PIXEL, DC_Y_PIXEL},
    chars      = {
       {32, DC_X_PIXEL, DC_Y_PIXEL}, -- [space]
       {48, DC_X_PIXEL, DC_Y_PIXEL}, -- 0
       {49, DC_X_PIXEL, DC_Y_PIXEL}, -- 1
       {50, DC_X_PIXEL, DC_Y_PIXEL}, -- 2
       {51, DC_X_PIXEL, DC_Y_PIXEL}, -- 3
       {52, DC_X_PIXEL, DC_Y_PIXEL}, -- 4
       {53, DC_X_PIXEL, DC_Y_PIXEL}, -- 5
       {54, DC_X_PIXEL, DC_Y_PIXEL}, -- 6
       {55, DC_X_PIXEL, DC_Y_PIXEL}, -- 7
       {56, DC_X_PIXEL, DC_Y_PIXEL}, -- 8
       {57, DC_X_PIXEL, DC_Y_PIXEL}, -- 9
       {58,         12, DC_Y_PIXEL}, -- :
       {67, DC_X_PIXEL, DC_Y_PIXEL}, -- C
       {69, DC_X_PIXEL, DC_Y_PIXEL}, -- E
       {84, DC_X_PIXEL, DC_Y_PIXEL}, -- T
    }
}


fonts = {}
-- GENERAL FONTS
--fonts["font_general_keys"]       = {fontdescription["font_general_loc"], 10, {255,75,75,255}}
--fonts["font_hints_kneeboard"]    = {fontdescription["font_general_loc"], 10, {100,0,100,255}}

-- HUD
fonts["hud_font_def"]   = {fontdescription["font_HUD"], 10, materials["HUD_IND_DEF"]}
fonts["hud_font_g"]     = {fontdescription["font_HUD"], 10, materials["HUD_IND_GREEN"]}
fonts["hud_font_b"]     = {fontdescription["font_HUD"], 10, materials["HUD_IND_BLUE"]}
fonts["hud_font_w"]     = {fontdescription["font_HUD"], 10, materials["HUD_IND_WHITE"]}
fonts["hud_font_r"]     = {fontdescription["font_HUD"], 10, materials["HUD_IND_RED"]}

-- MPCDs
fonts["mfcd_font_def"]  = {fontdescription["font_MFCD"], 10, materials["MFCD_IND_DEF"]}
fonts["mfcd_font_g"]    = {fontdescription["font_MFCD"], 10, materials["MFCD_IND_GREEN"]}
fonts["mfcd_font_dg"]   = {fontdescription["font_MFCD"], 10, materials["MFCD_IND_DGREEN"]}
fonts["mfcd_font_b"]    = {fontdescription["font_MFCD"], 10, materials["MFCD_IND_BLUE"]}
fonts["mfcd_font_w"]    = {fontdescription["font_MFCD"], 10, materials["MFCD_IND_WHITE"]}
fonts["mfcd_font_wy"]   = {fontdescription["font_MFCD"], 10, materials["MFCD_IND_WHITE_Y"]}
fonts["mfcd_font_d"]    = {fontdescription["font_MFCD"], 10, materials["MFCD_IND_DARK"]}
fonts["mfcd_font_r"]    = {fontdescription["font_MFCD"], 10, materials["MFCD_IND_RED"]}
fonts["mfcd_font_bk"]   = {fontdescription["font_MFCD"], 10, materials["MFCD_IND_BLACK"]}

fonts["mfcd_wpn_font_def"]  = {fontdescription["font_MFCD_wpn"], 10, materials["MFCD_IND_DEF"]}
fonts["mfcd_wpn_font_g"]    = {fontdescription["font_MFCD_wpn"], 10, materials["MFCD_IND_GREEN"]}
fonts["mfcd_wpn_font_dg"]   = {fontdescription["font_MFCD_wpn"], 10, materials["MFCD_IND_DGREEN"]}
fonts["mfcd_wpn_font_b"]    = {fontdescription["font_MFCD_wpn"], 10, materials["MFCD_IND_BLUE"]}
fonts["mfcd_wpn_font_w"]    = {fontdescription["font_MFCD_wpn"], 10, materials["MFCD_IND_WHITE"]}
fonts["mfcd_wpn_font_wy"]   = {fontdescription["font_MFCD_wpn"], 10, materials["MFCD_IND_WHITE_Y"]}
fonts["mfcd_wpn_font_d"]    = {fontdescription["font_MFCD_wpn"], 10, materials["MFCD_IND_DARK"]}
fonts["mfcd_wpn_font_r"]    = {fontdescription["font_MFCD_wpn"], 10, materials["MFCD_IND_RED"]}

-- test
--fonts["mfcd_wpn_svg_font_def"]  = {fontdescription["font_MFCD_wpn_svg"], 10, materials["MFCD_IND_DEF"]}

-- UFC
fonts["ufcp_font_def"]     = {fontdescription["font_UFCP"], 10, materials["UFCP_IND_DEF"]}
fonts["ufcp_font_cursor"]  = {fontdescription["font_UFCP"], 10, materials["UFCP_IND_CURSOR"]}

-- Radio Panel
fonts["radio_font_def"]     = {fontdescription["font_RADIO"], 10, materials["RADIO_IND_DEF"]}
fonts["radio_font_y"]       = {fontdescription["font_RADIO"], 10, materials["RADIO_IND_YELLOW"]}
fonts["radio_font_cursor"]  = {fontdescription["font_RADIO"], 10, materials["RADIO_IND_DEF"]}

-- Clock
fonts["clock_font_def"]     = {fontdescription["font_CLOCK"], 10, materials["CLOCK_IND_DEF"]}

