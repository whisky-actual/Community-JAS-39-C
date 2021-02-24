
local ld10_name = 'RB-102 (LD-10)'
local ld10_mass = 199.0
local pylon_mass = 40.0
local pylon_dual_mass = 80.0

local LD_10_warhead = HE_penetrating_warhead(170,203)
LD_10_warhead.cumulative_factor = 2.0
LD_10_warhead.cumulative_thickness = 0.05

local use_agm88_scheme_sead = false

LD_10_ARM = {}

if use_agm88_scheme_sead then

    LD_10_ARM = {
        category        = CAT_MISSILES,
        name            = ld10_name,
        model           = 'ld10',
        user_name       = _(ld10_name),
        wsTypeOfWeapon  = {4,4,8,WSTYPE_PLACEHOLDER},
        mass            = ld10_mass,

        Escort          = 0,
        Head_Type       = 3,
        sigma           = {10, 10, 10},
        M               = ld10_mass,
        H_max           = 25000.0,
        H_min           = -1.0,
        Diam            = 203.0,
        Cx_pil          = 2,
        D_max           = 80000.0,
        D_min           = 700.0,
        Head_Form       = 1,
        Life_Time       = 380.0,
        Nr_max          = 25,
        v_min           = 140.0,
        v_mid           = 900.0,
        Mach_max        = 4.0,
        t_b             = 0.0,
        t_acc           = 3.0,
        t_marsh         = 5.0,
        Range_max       = 280000.0,
        H_min_t         = 1.0,
        Fi_start        = 0.5236,
        Fi_rak          = 3.14152,
        Fi_excort       = 1.05,
        Fi_search       = 1.05,
        OmViz_max       = 0.52,
        exhaust         = { 1, 1, 1, 0.5 },
        X_back          = -1.74,
        Y_back          = -0.11,
        Z_back          = 0.0,
        Reflection      = 0.0329,
        KillDistance    = 7.0,

        shape_table_data = {
            {
                name     = ld10_name,
                file     = 'ld10',
                life     = 1,
                fire     = {0, 1},
                username = ld10_name,
                index    = WSTYPE_PLACEHOLDER,
            },
        },

        warhead     = LD_10_warhead, --HE_penetrating_warhead(170,203),
        warhead_air = LD_10_warhead, --HE_penetrating_warhead(170,203),

        class_name      = "wAmmunitionSelfHoming",
        scheme          = "anti_rad_missile",

        LaunchDistData =
        {
            9,        6,
                       100,      150,      200,      250,      300,      350,
            1000,    22000,    23000,    26000,    26000,    27000,    30000,
            2000,    27000,    29000,    32000,    35000,    37000,    40000,
            4000,    32000,    35000,    37000,    40000,    42000,    45000,
            6000,    37000,    40000,    43000,    45000,    47000,    50000,
            7000,    43000,    45000,    47000,    50000,    55000,    60000,
            8000,    45000,    47000,    50000,    55000,    60000,    65000,
            9000,    50000,    52500,    55000,    58000,    65000,    70000,
           10000,    60000,    62500,    65000,    68000,    70000,    75000,
           12000,    65000,    66000,    67000,    70000,    75000,    80000,
        },

        controller = {
            boost_start = 0.5,
            march_start = 1.5,
        },

        boost = {
            impulse                              = 260,
            fuel_mass                            = 60,
            work_time                            = 6.0,
            nozzle_position                      = {{-2.1, 0, 0}},
            nozzle_orientationXYZ                = {{0.0, 0.0, 0.0}},
            tail_width                           = 0.4,
            smoke_color                          = {0.9, 0.9, 0.9},
            smoke_transparency                   = 0.1,
            custom_smoke_dissipation_factor      = 0.3,
        },

        march = {
            impulse                              = 245,
            fuel_mass                            = 10,
            work_time                            = 2.5,
            nozzle_position                      = {{-1.74, -0.11, 0}},
            nozzle_orientationXYZ                = {{0.0, 0.0, 0.0}},
            tail_width                           = 0.3,
            smoke_color                          = {0.6, 0.6, 0.6},
            smoke_transparency                   = 0.8,
            custom_smoke_dissipation_factor      = 0.2,
        },

        fm = {
            mass                = ld10_mass,
            caliber             = 0.203,
            wind_sigma          = 0.0,
            wind_time           = 0.0,
            tail_first          = 1,
            fins_part_val       = 0,
            rotated_fins_inp    = 0,
            delta_max           = math.rad(20),
            L                   = 0.25,
            S                   = 0.051,
            Ix                  = 3.5,
            Iy                  = 1 / 12 * ld10_mass * 3.8 * 3.8,
            Iz                  = 1 / 12 * ld10_mass * 3.8 * 3.8,

            Mxd                 = 0.3 * 57.3,
            Mxw                 = -44.5,

            table_scale    = 0.2,
            table_degree_values = 1,
            --    Mach      | 0.0        0.2        0.4        0.6        0.8        1.0        1.2        1.4        1.6        1.8        2.0        2.2        2.4        2.6        2.8        3.0        3.2        3.4        3.6        3.8        4.0     |
            Cx0     = {    0.25,    0.25,    0.25,    0.25,    0.45,    0.55,    0.50,    0.40,    0.25,    0.25,    0.25,    0.23,    0.20,    0.17,    0.17,    0.17,    0.17,    0.17,    0.17,    0.17,    0.17 },
            CxB     = {    0.05,    0.05,    0.05,    0.05,    0.10,    0.15,    0.12,    0.10,    0.08,    0.08,    0.08,    0.08,    0.08,    0.07,    0.07,    0.06,    0.05,    0.04,    0.04,    0.04,    0.04 },
            K1      = { 0.0056,    0.0056,    0.0056,    0.0056,    0.0056,    0.0056,    0.0056,    0.0056,    0.0052,    0.0048,    0.0045,    0.0041,    0.0037,    0.0036,    0.0034,    0.0032,    0.0031,    0.0030,    0.0029,    0.0027,    0.0026 },
            K2      = { 0.0055,    0.0055,    0.0055,    0.0055,    0.0055,    0.0055,    0.0055,    0.0055,    0.0051,    0.0047,    0.0043,    0.0037,    0.0031,    0.0032,    0.0033,    0.0035,    0.0036,    0.0037,    0.0038,    0.0039,    0.0040 },
            Cya     = { 1.14,    1.14,    1.14,    1.14,    1.14,    1.42,    1.46,    1.39,    1.32,    1.15,    1.06,    1.00,    0.94,    0.89,    0.83,    0.78,    0.73,    0.69,    0.65,    0.61,    0.57 },
            Cza     = { 1.14,    1.14,    1.14,    1.14,    1.14,    1.42,    1.46,    1.39,    1.32,    1.15,    1.06,    1.00,    0.94,    0.89,    0.83,    0.78,    0.73,    0.69,    0.65,    0.61,    0.57 },
            Mya     = { -0.5,    -0.5},
            Mza     = { -0.5,    -0.5},
            Myw     = { -2.0,    -2.0},
            Mzw     = { -2.0,    -2.0},
            A1trim  = { 10.0,    10.0},
            A2trim  = { 10.0,    10.0},

            model_roll = math.rad(45),
            fins_stall = 1,
        },

        proximity_fuze = {
            radius       = 8,
            arm_delay    = 1.6,
        },

        seeker = {
            delay               = 2.4,
            op_time             = 240,
            FOV                 = math.rad(60),
            max_w_LOS           = math.rad(20),
            sens_near_dist      = 100,
            sens_far_dist       = 70000,

            keep_aim_time       = 5,
            pos_memory_time     = 150,
            err_correct_time    = 2.0,
            calc_aim_dist       = 500000,
            blind_rad_val       = 0.1,
            aim_y_offset        = 2.5,

            ang_err_val         = math.rad(0.008),
            abs_err_val         = 2,
        },

        autopilot = {
            delay                = 1.5,
            op_time              = 240,
            Kconv                = 6.0,
            Knv                  = 0.0025,
            Kd                   = 0.5,
            Ki                   = 2.0,
            Kout                 = 1.0,
            Kx                   = 0.04,
            Krx                  = 2.0,
            fins_limit           = math.rad(20),
            fins_limit_x         = math.rad(5),
            Areq_limit           = 25.0,
            bang_bang            = 0,
            max_side_N           = 10,
            max_signal_Fi        = math.rad(12),
            rotate_fins_output   = 0,
            alg                  = 0,
            PN_dist_data         = {15000,    0,
                                     5000,    1},
            draw_fins_conv       = {math.rad(90),1,1},
            null_roll            = math.rad(45),

            loft_active_by_default   = 0,
            loft_add_pitch           = math.rad(10),
            loft_trig_ang            = math.rad(26),
            loft_min_dist            = 15000,
            K_heading_hor            = 0.3,
            K_heading_ver            = 0.3,
            K_loft                   = 0.3,
        },
    }

else

    LD_10_ARM = {
        category        = CAT_MISSILES,
        name            = ld10_name,
        model           = 'ld10',
        user_name       = _(ld10_name),
        wsTypeOfWeapon  = {4,4,8,WSTYPE_PLACEHOLDER},
        mass            = ld10_mass,

        Escort          = 0,
        Head_Type       = 3,
        sigma           = {10, 10, 10},
        M               = ld10_mass,
        H_max           = 25000.0,
        H_min           = -1.0,
        Diam            = 203.0,
        Cx_pil          = 2,
        D_max           = 80000.0,
        D_min           = 700.0,
        Head_Form       = 1,
        Life_Time       = 180.0,
        Nr_max          = 25,
        v_min           = 140.0,
        v_mid           = 900.0,
        Mach_max        = 4.0,
        t_b             = 0.0,
        t_acc           = 3.0,
        t_marsh         = 5.0,
        Range_max       = 80000.0,
        H_min_t         = 1.0,
        Fi_start        = 0.5236,
        Fi_rak          = 3.14152,
        Fi_excort       = 1.05,
        Fi_search       = 1.05,
        OmViz_max       = 0.52,
        exhaust         = { 1, 1, 1, 0.5 },
        X_back          = -1.74,
        Y_back          = -0.11,
        Z_back          = 0.0,
        Reflection      = 0.0329,
        KillDistance    = 7.0,

        shape_table_data = {
            {
                name     = ld10_name,
                file     = 'ld10',
                life     = 1,
                fire     = {0, 1},
                username = ld10_name,
                index    = WSTYPE_PLACEHOLDER,
            },
        },

        warhead     = LD_10_warhead, -- HE_penetrating_warhead(170,203),
        warhead_air = LD_10_warhead, -- HE_penetrating_warhead(170,203),

        class_name      = "wAmmunitionSelfHoming",
        scheme          = "anti_radiation_missile2",

        LaunchDistData =
        {
            9,        6,
                       100,      150,      200,      250,      300,      350,
            1000,    12000,    13000,    16000,    16000,    17000,    30000,
            2000,    17000,    19000,    25000,    30000,    35000,    40000,
            4000,    20000,    22000,    25000,    30000,    35000,    45000,
            6000,    30000,    32000,    35000,    37000,    40000,    50000,
            7000,    40000,    42000,    45000,    47000,    55000,    60000,
            8000,    45000,    47000,    50000,    55000,    60000,    65000,
            9000,    50000,    52500,    55000,    58000,    65000,    70000,
           10000,    60000,    62500,    65000,    68000,    70000,    75000,
           12000,    65000,    66000,    67000,    70000,    75000,    80000,
        },

        controller = {
            march_start = 0.021,
        },

        march = {
            impulse                             = 205,
            fuel_mass                           = 70,
            work_time                           = 10,
            boost_time                          = 0,
            boost_factor                        = 0,
            nozzle_position                     = {{-1.74, -0.11, 0}},
            nozzle_orientationXYZ               = {{0.0, 0.0, 0.0}},
            tail_width                          = 0.3,
            smoke_color                         = {0.6, 0.6, 0.6},
            smoke_transparency                  = 0.8,
            custom_smoke_dissipation_factor     = 0.2,
        },


        fm = {
            mass        = ld10_mass,
            caliber     = 0.203,
            cx_coeff    = {1, 0.4, 1.1, 0.5, 1.4},
            L           = 3.8,
            I           = 1 / 12 * ld10_mass * 3.8 * 3.8,
            Ma          = 0.3,
            Mw          = 1.116,
            wind_sigma  = 0.0,
            wind_time   = 0.0,
            Sw          = 0.85,
            dCydA       = {0.07, 0.036},
            A           = 0.36,
            maxAoa      = 0.28,
            finsTau     = 0.1,

            Ma_x        = 0.001,
            Kw_x        = 0.001,
            --I_x         = 50,
        },

        radio_seeker = {
            FOV                 = math.rad(5),
            op_time             = 150,
            keep_aim_time       = 8,
            pos_memory_time     = 60,
            sens_near_dist      = 200.0,
            sens_far_dist       = 60000.0,
            err_correct_time    = 1.0,
            err_val             = 0.001,
            calc_aim_dist       = 500000,
            blind_rad_val       = 0.2,
            blind_ctrl_dist     = 1000,
            aim_y_offset        = 2.0,
            min_sens_rad_val    = 0.00025,
        },

        simple_gyrostab_seeker = {
            omega_max = math.rad(8)
        },

        fuze_proximity = {
            ignore_inp_armed    = 1,
            arm_delay           = 10,
            radius              = 10,
        },

        autopilot = {
            K                = 100.0,
            Kg               = 6.0,
            Ki               = 0.0,
            finsLimit        = 0.22,
            useJumpByDefault = 1,
            J_Power_K        = 1.2,
            J_Diff_K         = 0.4,
            J_Int_K          = 0.0,
            J_Angle_K        = math.rad(12),
            J_FinAngle_K     = math.rad(18),
            J_Angle_W        = 3.5,
            delay            = 1.0,
        },

        start_helper = {
            delay               = 0.2,
            power               = 0.02,
            time                = 2,
            use_local_coord     = 0,
            max_vel             = 200,
            max_height          = 400,
            vh_logic_or         = 1,
        },
    }
end

declare_weapon(LD_10_ARM)
--LD_10_ARM.shape_table_data.index = LD_10_ARM.wsTypeOfWeapon[4]

declare_loadout({
    category    = CAT_MISSILES,
    CLSID       = 'DIS_LD-10',
    Picture     = 'agm88.png',
    attribute   = LD_10_ARM.wsTypeOfWeapon,
    displayName = _(ld10_name),
    Cx_pil      = 0.000859765625,
    Count       = 1,
    Weight      = ld10_mass + pylon_mass,
    Elements    = {
        [1] =
        {
            Position  = {0, 0, 0},
            ShapeName = 'ld10',
        },
    }, -- end of Elements
})


declare_loadout({
    category       = CAT_MISSILES,
    CLSID          = 'DIS_LD-10_DUAL_L',
    Picture        = 'agm88.png',
    wsTypeOfWeapon = LD_10_ARM.wsTypeOfWeapon,
    attribute      = {4,4,32,WSTYPE_PLACEHOLDER},
    displayName    = _(ld10_name .. ' x 2'),
    Cx_pil         = 0.000859765625 * 1.31,
    Count          = 2,
    Weight         = 2 * ld10_mass + pylon_dual_mass,
    Elements       = {
        { ShapeName = 'lau-115C+2_lau7', IsAdapter = true, },
        { ShapeName = 'ld10',            connector_name = 'Point02', },
        { ShapeName = 'ld10',            connector_name = 'Point03', },
    }, -- end of Elements
    JettisonSubmunitionOnly = true,
})

declare_loadout({
    category       = CAT_MISSILES,
    CLSID          = 'DIS_LD-10_DUAL_R',
    Picture        = 'agm88.png',
    wsTypeOfWeapon = LD_10_ARM.wsTypeOfWeapon,
    attribute      = {4,4,32,WSTYPE_PLACEHOLDER},
    displayName    = _(ld10_name .. ' x 2'),
    Cx_pil         = 0.000859765625 * 1.31,
    Count          = 2,
    Weight         = 2 * ld10_mass + pylon_dual_mass,
    Elements       = {
        { ShapeName = 'lau-115C+2_lau7', IsAdapter = true, },
        { ShapeName = 'ld10',            connector_name = 'Point03', },
        { ShapeName = 'ld10',            connector_name = 'Point02', },
    }, -- end of Elements
    JettisonSubmunitionOnly = true,
})

