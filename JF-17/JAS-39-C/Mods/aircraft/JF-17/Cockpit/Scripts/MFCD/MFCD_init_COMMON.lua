dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.script_path .. "materials.lua")
dofile(LockOn_Options.script_path .. "utils.lua")

indicator_type = indicator_types.COMMON
purposes       = {render_purpose.GENERAL, render_purpose.HUD_ONLY_VIEW}

local mfcd_page_path = LockOn_Options.script_path .. "MFCD/Indicator/"
dofile(mfcd_page_path .. "../MFCD_pageID_defs.lua")

-- 子页面源定义
page_subsets = {
    [SUB_PAGE_ID.ELEMENTSET_BASE        ] = mfcd_page_path .. "FULL_BASE.lua",
    [SUB_PAGE_ID.ELEMENTSET_OFF         ] = mfcd_page_path .. "UP_OFF.lua",
    [SUB_PAGE_ID.ELEMENTSET_NOAUX       ] = mfcd_page_path .. "UP_NOAUX.lua",
    [SUB_PAGE_ID.ELEMENTSET_MAIN_MENU   ] = mfcd_page_path .. "UP_MainMenu.lua",

    [SUB_PAGE_ID.ELEMENTSET_RDR_AA      ] = mfcd_page_path .. "UP_U1_RDR_AA.lua",
    [SUB_PAGE_ID.ELEMENTSET_RDR_AA_CNTL ] = mfcd_page_path .. "UP_U1_RDR_AA_CNTL.lua",
    
    [SUB_PAGE_ID.ELEMENTSET_RDR_AG      ] = mfcd_page_path .. "UP_U1_RDR_AG.lua",
    [SUB_PAGE_ID.ELEMENTSET_RDR_AG_CNTL ] = mfcd_page_path .. "UP_U1_RDR_AG_CNTL.lua",
    
    [SUB_PAGE_ID.ELEMENTSET_RDR_MODE    ] = mfcd_page_path .. "UP_U1_RDR_Mode.lua",
    
    [SUB_PAGE_ID.ELEMENTSET_INS         ] = mfcd_page_path .. "UP_U2_INS.lua",
    [SUB_PAGE_ID.ELEMENTSET_TACAN       ] = mfcd_page_path .. "UP_U3_TACAN.lua",
    [SUB_PAGE_ID.ELEMENTSET_TACAN_LIST  ] = mfcd_page_path .. "UP_U3_TACAN_Prog.lua",
    [SUB_PAGE_ID.ELEMENTSET_APR         ] = mfcd_page_path .. "UP_U4_APR.lua",
    [SUB_PAGE_ID.ELEMENTSET_POD         ] = mfcd_page_path .. "UP_U5_POD.lua",
    [SUB_PAGE_ID.ELEMENTSET_POD_WMD7    ] = mfcd_page_path .. "UP_POD_WMD7.lua",
    [SUB_PAGE_ID.ELEMENTSET_POD_SPJ     ] = mfcd_page_path .. "UP_POD_SPJ.lua",
    [SUB_PAGE_ID.ELEMENTSET_POD_IRST    ] = mfcd_page_path .. "UP_POD_IRST.lua",
    [SUB_PAGE_ID.ELEMENTSET_POD_TVIR    ] = mfcd_page_path .. "UP_POD_TVIR.lua",
    [SUB_PAGE_ID.ELEMENTSET_POD_ARM     ] = mfcd_page_path .. "UP_POD_ARM.lua",
    [SUB_PAGE_ID.ELEMENTSET_POD_MIL     ] = mfcd_page_path .. "UP_POD_MIL.lua",
    
    [SUB_PAGE_ID.ELEMENTSET_SMS_AA      ] = mfcd_page_path .. "UP_R1_SMS_AA.lua",
    [SUB_PAGE_ID.ELEMENTSET_SMS_AA_WPN  ] = mfcd_page_path .. "UP_R1_SMS_AA_Wpn.lua",
    [SUB_PAGE_ID.ELEMENTSET_SMS_AA_LIM  ] = mfcd_page_path .. "UP_R1_SMS_AA_Limiter.lua",
    [SUB_PAGE_ID.ELEMENTSET_SMS_AA_GS   ] = mfcd_page_path .. "UP_R1_SMS_AA_Gunsight.lua",
    
    [SUB_PAGE_ID.ELEMENTSET_SMS_AG      ] = mfcd_page_path .. "UP_R1_SMS_AG.lua",
    [SUB_PAGE_ID.ELEMENTSET_SMS_AG_MODE ] = mfcd_page_path .. "UP_R1_SMS_AG_Mode.lua",
    [SUB_PAGE_ID.ELEMENTSET_SMS_AG_WPN  ] = mfcd_page_path .. "UP_R1_SMS_AG_Wpn.lua",
    [SUB_PAGE_ID.ELEMENTSET_SMS_AG_FUZE ] = mfcd_page_path .. "UP_R1_SMS_AG_Fuze.lua",
    [SUB_PAGE_ID.ELEMENTSET_SMS_AG_QTY  ] = mfcd_page_path .. "UP_R1_SMS_AG_Qty.lua",
    [SUB_PAGE_ID.ELEMENTSET_SMS_AG_INTV ] = mfcd_page_path .. "UP_R1_SMS_AG_Intv.lua",
    [SUB_PAGE_ID.ELEMENTSET_SMS_AG_CFG  ] = mfcd_page_path .. "UP_R1_SMS_AG_Profile.lua",
    
    [SUB_PAGE_ID.ELEMENTSET_SMS_PROG    ] = mfcd_page_path .. "UP_R1_SMS_Prog.lua",
    
    [SUB_PAGE_ID.ELEMENTSET_SMS_LOAD       ] = mfcd_page_path .. "UP_R1_SMS_Load.lua",
    [SUB_PAGE_ID.ELEMENTSET_SMS_LOAD_TYPE  ] = mfcd_page_path .. "UP_R1_SMS_Load_Type.lua",
    [SUB_PAGE_ID.ELEMENTSET_SMS_LOAD_WPN   ] = mfcd_page_path .. "UP_R1_SMS_Load_Wpn.lua",
    
    [SUB_PAGE_ID.ELEMENTSET_SMS_JET     ] = mfcd_page_path .. "UP_R1_SMS_Jet.lua",
    
    [SUB_PAGE_ID.ELEMENTSET_CMBT        ] = mfcd_page_path .. "UP_R2_CMBT.lua",
    [SUB_PAGE_ID.ELEMENTSET_BIT         ] = mfcd_page_path .. "UP_R3_BIT.lua",
    [SUB_PAGE_ID.ELEMENTSET_CHKLS       ] = mfcd_page_path .. "UP_R4_CHKLS.lua",
    [SUB_PAGE_ID.ELEMENTSET_PFL         ] = mfcd_page_path .. "UP_R5_PFL.lua",
    [SUB_PAGE_ID.ELEMENTSET_HSD         ] = mfcd_page_path .. "UP_L1_HSD.lua",
    [SUB_PAGE_ID.ELEMENTSET_EFIS        ] = mfcd_page_path .. "UP_L2_EFIS.lua",
    
    [SUB_PAGE_ID.ELEMENTSET_DOWN_OFF       ] = mfcd_page_path .. "DOWN_OFF.lua",
    [SUB_PAGE_ID.ELEMENTSET_DOWN_BLANK     ] = mfcd_page_path .. "DOWN_BLANK.lua",
    [SUB_PAGE_ID.ELEMENTSET_DOWN_MAIN_MENU ] = mfcd_page_path .. "DOWN_MainMenu.lua",
    [SUB_PAGE_ID.ELEMENTSET_DOWN_EPI1      ] = mfcd_page_path .. "DOWN_EPI1.lua",
    [SUB_PAGE_ID.ELEMENTSET_DOWN_EPI2      ] = mfcd_page_path .. "DOWN_EPI2.lua",
    [SUB_PAGE_ID.ELEMENTSET_DOWN_SMS       ] = mfcd_page_path .. "DOWN_SMS.lua",
    [SUB_PAGE_ID.ELEMENTSET_DOWN_AFD       ] = mfcd_page_path .. "DOWN_AFINFO.lua",
    [SUB_PAGE_ID.ELEMENTSET_DOWN_CLINK     ] = mfcd_page_path .. "DOWN_CLINK.lua",
    [SUB_PAGE_ID.ELEMENTSET_DOWN_AG_PARAM  ] = mfcd_page_path .. "DOWN_AG_DATA.lua",

    [SUB_PAGE_ID.ELEMENTSET_DATA        ] = mfcd_page_path .. "UP_L4_DATA.lua",
    [SUB_PAGE_ID.ELEMENTSET_DATA_AS     ] = mfcd_page_path .. "UP_DATA_AS.lua",
    [SUB_PAGE_ID.ELEMENTSET_DATA_DST    ] = mfcd_page_path .. "UP_DATA_DST.lua",
    [SUB_PAGE_ID.ELEMENTSET_DATA_DTC    ] = mfcd_page_path .. "UP_DATA_DTC.lua",
    [SUB_PAGE_ID.ELEMENTSET_DATA_ENG    ] = mfcd_page_path .. "UP_DATA_ENG.lua",
    [SUB_PAGE_ID.ELEMENTSET_DATA_FCS    ] = mfcd_page_path .. "UP_DATA_FCS.lua",
    [SUB_PAGE_ID.ELEMENTSET_DATA_SPCHK  ] = mfcd_page_path .. "UP_DATA_SPCHK.lua",
    [SUB_PAGE_ID.ELEMENTSET_DATA_NAV    ] = mfcd_page_path .. "UP_DATA_NAV.lua",
    [SUB_PAGE_ID.ELEMENTSET_DATA_RLS    ] = mfcd_page_path .. "UP_DATA_RLS.lua",
    [SUB_PAGE_ID.ELEMENTSET_DATA_FUEL   ] = mfcd_page_path .. "UP_DATA_FUEL.lua",
    
    [SUB_PAGE_ID.ELEMENTSET_CLINK       ] = mfcd_page_path .. "UP_L3_CLINK.lua",
    [SUB_PAGE_ID.ELEMENTSET_CLINK_LIST  ] = mfcd_page_path .. "UP_L3_CLINK_List.lua",
    
    [SUB_PAGE_ID.ELEMENTSET_EDIT        ] = mfcd_page_path .. "UP_EDIT.lua",
    
}

-- 页面定义
pages = {
    [PAGE_ID.PAGE_ID_OFF            ] = {SUB_PAGE_ID.ELEMENTSET_BASE, },
    [PAGE_ID.PAGE_ID_NOAUX          ] = {SUB_PAGE_ID.ELEMENTSET_BASE, SUB_PAGE_ID.ELEMENTSET_NOAUX,},
    [PAGE_ID.PAGE_ID_MAIN_MENU      ] = {SUB_PAGE_ID.ELEMENTSET_BASE, SUB_PAGE_ID.ELEMENTSET_MAIN_MENU, SUB_PAGE_ID.ELEMENTSET_DOWN_MAIN_MENU},
    [PAGE_ID.PAGE_ID_RDR_AA         ] = {SUB_PAGE_ID.ELEMENTSET_BASE, SUB_PAGE_ID.ELEMENTSET_RDR_AA, SUB_PAGE_ID.ELEMENTSET_DOWN_SMS},
    [PAGE_ID.PAGE_ID_RDR_AG         ] = {SUB_PAGE_ID.ELEMENTSET_BASE, SUB_PAGE_ID.ELEMENTSET_RDR_AG, SUB_PAGE_ID.ELEMENTSET_DOWN_SMS},
    [PAGE_ID.PAGE_ID_INS            ] = {SUB_PAGE_ID.ELEMENTSET_BASE, SUB_PAGE_ID.ELEMENTSET_INS},
    [PAGE_ID.PAGE_ID_TACAN          ] = {SUB_PAGE_ID.ELEMENTSET_BASE, SUB_PAGE_ID.ELEMENTSET_TACAN},
    [PAGE_ID.PAGE_ID_APR            ] = {SUB_PAGE_ID.ELEMENTSET_BASE, SUB_PAGE_ID.ELEMENTSET_APR},
    [PAGE_ID.PAGE_ID_POD            ] = {SUB_PAGE_ID.ELEMENTSET_BASE, SUB_PAGE_ID.ELEMENTSET_POD},
    [PAGE_ID.PAGE_ID_SMS            ] = {SUB_PAGE_ID.ELEMENTSET_BASE, SUB_PAGE_ID.ELEMENTSET_SMS_MAIN},
    [PAGE_ID.PAGE_ID_CMBT           ] = {SUB_PAGE_ID.ELEMENTSET_BASE, SUB_PAGE_ID.ELEMENTSET_CMBT},
    [PAGE_ID.PAGE_ID_BIT            ] = {SUB_PAGE_ID.ELEMENTSET_BASE, SUB_PAGE_ID.ELEMENTSET_BIT},
    [PAGE_ID.PAGE_ID_CHKLS          ] = {SUB_PAGE_ID.ELEMENTSET_BASE, SUB_PAGE_ID.ELEMENTSET_CHKLS},
    [PAGE_ID.PAGE_ID_PFL            ] = {SUB_PAGE_ID.ELEMENTSET_BASE, SUB_PAGE_ID.ELEMENTSET_PFL},
    [PAGE_ID.PAGE_ID_HSD            ] = {SUB_PAGE_ID.ELEMENTSET_BASE, SUB_PAGE_ID.ELEMENTSET_HSD, SUB_PAGE_ID.ELEMENTSET_DOWN_AFD},
    [PAGE_ID.PAGE_ID_EFIS           ] = {SUB_PAGE_ID.ELEMENTSET_BASE, SUB_PAGE_ID.ELEMENTSET_EFIS, SUB_PAGE_ID.ELEMENTSET_DOWN_EPI1},
    [PAGE_ID.PAGE_ID_CLNK           ] = {SUB_PAGE_ID.ELEMENTSET_BASE, SUB_PAGE_ID.ELEMENTSET_CLNK},
    [PAGE_ID.PAGE_ID_DATA           ] = {SUB_PAGE_ID.ELEMENTSET_BASE, SUB_PAGE_ID.ELEMENTSET_DATA},

}

-- init_pageID = PAGE_ID.PAGE_ID_OFF

--used_render_mask = LockOn_Options.script_path .. "../Textures/IndicationTextures/mask_MFCD_day.dds" --"interleave" --default mask for TV
used_render_mask = "interleave" --default mask for TV


mat_tbl = {
    "mfcd_tex_basic",
    "mfcd_tex_basic_w",
    "mfcd_tex_basic_wy",
    "mfcd_tex_basic_g",
    "mfcd_tex_basic_d",
        
    "mfcd_tex_ind1",
    "mfcd_tex_ind1_g",
    "mfcd_tex_ind1_w",
    "mfcd_tex_ind1_wy",
    "mfcd_tex_ind1_y",
    "mfcd_tex_ind1_r",
    
    "mfcd_tex_ind2",
    "mfcd_tex_ind2_g",
    "mfcd_tex_ind2_w",
    "mfcd_tex_ind2_wy",
    "mfcd_tex_ind2_y",
    "mfcd_tex_ind2_r",
    
    "mfcd_tex_ind3",
    "mfcd_tex_ind3_g",
    "mfcd_tex_ind3_w",
    "mfcd_tex_ind3_wy",
    "mfcd_tex_ind3_y",
    "mfcd_tex_ind3_r",
    "mfcd_tex_ind3_bl",
    
    "mfcd_tex_ind4",
    "mfcd_tex_ind4_g",
    "mfcd_tex_ind4_w",
    "mfcd_tex_ind4_wy",
    "mfcd_tex_ind4_y",
    "mfcd_tex_ind4_r",
    
    "mfcd_tex_ind5",
    "mfcd_tex_ind5_g",
    "mfcd_tex_ind5_w",
    "mfcd_tex_ind5_wy",
    "mfcd_tex_ind5_y",
    "mfcd_tex_ind5_r",
    
    "mfcd_mesh_def",
    "mfcd_mesh_r",
    "mfcd_mesh_g",
    "mfcd_mesh_b",
    "mfcd_mesh_bl",
    "mfcd_mesh_d",
    "mfcd_mesh_w",
    "mfcd_mesh_wy",
    "mfcd_mesh_p",
    "mfcd_mesh_y",
    "mfcd_mesh_sky",
    "mfcd_mesh_gnd",
    "mfcd_mesh_boxbase",
    "mfcd_mesh_whitebase",
    
    "mfcd_font_def",
    "mfcd_font_g",
    "mfcd_font_dg",
    "mfcd_font_b",
    "mfcd_font_w",
    "mfcd_font_wy",
    "mfcd_font_d",
    "mfcd_font_r",
	
	"mfcd_line_dashed_def",
	"mfcd_line_dashed_r",
	"mfcd_line_dashed_w",
	"mfcd_line_dashed_y",
	
	"mfcd_wpn_font_def",
	"mfcd_wpn_font_g",
	"mfcd_wpn_font_dg",
	"mfcd_wpn_font_b",
	"mfcd_wpn_font_w",
	"mfcd_wpn_font_wy",
	"mfcd_wpn_font_d",
	"mfcd_wpn_font_r",
}

-- MFCD Colors
brightness_sensitive_materials = mat_tbl
opacity_sensitive_materials    = mat_tbl
color_sensitive_materials      = {
    "mfcd_tex_basic",
    "mfcd_tex_basic_g",
    
    "mfcd_tex_ind1",
    "mfcd_tex_ind1_g",
    
    "mfcd_tex_ind2",
    "mfcd_tex_ind2_g",
    
    "mfcd_tex_ind3",
    "mfcd_tex_ind3_g",
    
    "mfcd_tex_ind4",
    "mfcd_tex_ind4_g",
    
    "mfcd_tex_ind5",
    "mfcd_tex_ind5_g",
    
    "mfcd_mesh_def",
    "mfcd_mesh_g",
    
    "mfcd_font_def",
    "mfcd_font_g",
    "mfcd_font_dg",
    
    "mfcd_wpn_font_def",
    "mfcd_wpn_font_g",    
    --"mfcd_wpn_svg_font_def",
}

is_colored         = true

color_green_day    = {0.0, 1.0, 0.3}		--{0.1, 1.0, 0.5}
color_green_night  = {0.0, 0.25, 0.075}		--{0.025, 0.25, 0.125}

color_blue_day     = {0.1, 1.0, 0.5}
color_blue_night   = {0.025, 0.25, 0.125}

color_yellow_day   = {0.8, 0.6, 0}
color_yellow_night = {0.2, 0.15, 0}

color_orange_day   = {0.8, 0.4, 0}
color_orange_night = {0.2, 0.1, 0}

color_red_day      = {0.8, 0, 0}
color_red_night    = {0.2, 0, 0}

color_red2_day     = {0.8, 0, 0}
color_red2_night   = {0.2, 0, 0}

color_white_day    = {1, 1, 1}
color_white_night  = {0.25, 0.25, 0.25}

color_sky_day      = {0.08, 0.32, 0.64}
color_sky_night    = {0, 0, 0}

color_gnd_day      = {0.16, 0.02, 0.04}
color_gnd_night    = {0.0, 0.125, 0.048}	--{0.013, 0.125, 0.063}

-- HUD only view diplacement
function MFCD_set_screenspace_displacement(aspect, left_center_right, zoom_value)
    local w = LockOn_Options.screen.width;
    local h = LockOn_Options.screen.height;
    
    if LockOn_Options.screen.oculus_rift then 
        local ui_x,ui_y,ui_w,ui_h = get_UIMainView()
        w = ui_w;
        h = ui_h;
    end    

    local x0 = 0
    local w0 = 0.5 * h
    
    local aspect     =     aspect or 1
    local zoom_value = zoom_value or 1
    local default_width  = w0

    if default_width > h then
       default_width = h
    end
    
    if default_width > 0.5 * w then
       default_width = 0.5 * w
    end
    
    default_width = default_width * math.abs(zoom_value)
    local default_height = default_width / aspect
    local default_y      = h - default_height
    local default_x      = w - default_width - x0
    
    if left_center_right == -1 then -- left
        default_x   = x0
    else
        if left_center_right == 0 then -- center
            default_x = default_x /2
        end
    end

    dedicated_viewport           = {default_x,default_y,default_width,default_height}
    dedicated_viewport_arcade = {default_x, 0        ,default_width,default_height}
end

