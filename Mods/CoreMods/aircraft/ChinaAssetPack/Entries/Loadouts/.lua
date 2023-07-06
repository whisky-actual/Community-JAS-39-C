
local ls6_500_name  = 'LS-6-500'
local ls6_500_mass  = 525.0
local ls6_500_model = "ls-6"
local pylon_mass    = 45.0

local LS6_500_warhead = 
{
    mass                 = 200, 
    caliber              = 377,
    expl_mass            = 200,
    piercing_mass        = 0.0,
    other_factors        = { 1.0, 1.0, 1.0 },
    concrete_factors     = { 3.0, 1.0, 1.0 },
    concrete_obj_factor  = 2.0,
    obj_factors          = { 3.0, 1.0 },
    cumulative_factor    = 3.0,
    cumulative_thickness = 0.0,
}

LS_6_500 =
{
    category        = CAT_MISSILES,
    name            = ls6_500_name,
    user_name       = _(ls6_500_name),
    scheme          = "AGM-154C",
    class_name      = "wAmmunitionCruise",
    model           = ls6_500_model,
    mass            = ls6_500_mass,
    
    wsTypeOfWeapon  = {wsType_Weapon,wsType_Missile,wsType_AS_Missile,WSTYPE_PLACEHOLDER},

    Escort          = 0,
    Head_Type       = 5,
    sigma           = {20, 20, 20},
    M               = ls6_500_mass,
    H_max           = 28000.0,
    H_min           = 100,
    Diam            = 330.0,
    Cx_pil          = 8,
    D_max           = 130000.0,
    D_min           = 5000.0,
    Head_Form       = 1,
    Life_Time       = 9999,
    Nr_max          = 10,
    v_min           = 10.0,
    v_mid           = 200.0,
    Mach_max        = 1.7,
    t_b             = 0.0,
    t_acc           = 0.0,
    t_marsh         = 0.0,
    Range_max       = 140000.0,
    H_min_t         = 0.0,
    Fi_start        = 3.14152,
    Fi_rak          = 3.14152,
    Fi_excort       = 3.14152,
    Fi_search       = 99.9,
    OmViz_max       = 99.9,
    X_back          = 0.0,
    Y_back          = 0.0,
    Z_back          = 0.0,
    Reflection      = 0.07,
    KillDistance    = 0.0,
    
    LaunchDistData =
    {
        17,        10,
        
                 100,    150,    200,    250,    300,    350,    400,    450,    500,    550,
        100,     0,        0,        0,        0,        10000,    19000,    25000,    30000,    33000,    37000,
        200,     0,        0,        0,        10000,    16000,    24000,    30000,    34000,    38000,    41000,
        500,     0,        0,        0,        12000,    24000,    32000,    38000,    42000,    45000,    48000,
        800,     0,        0,        0,        15000,    27000,    35000,    40000,    44000,    48000,    51000,
        1000,    0,        0,        0,        17000,    29000,    36000,    42000,    46000,    49000,    53000,
        2000,    0,        0,        14000,    24000,    37000,    43000,    50000,    54000,    57000,    60000,
        3000,    0,        0,        21000,    32000,    42000,    51000,    57000,    61000,    65000,    69000,
        4000,    11000,    11000,    27000,    40000,    51000,    58000,    64000,    69000,    73000,    76000,
        5000,    21000,    22000,    28000,    48000,    58000,    64000,    70000,    76000,    79000,    84000,
        6000,    25000,    25000,    28000,    50000,    60000,    67000,    76000,    81000,    86000,    91000,
        7000,    34000,    34000,    35000,    51000,    62000,    68000,    83000,    88000,    93000,    97000,
        8000,    36000,    37000,    38000,    52000,    63000,    69000,    88000,    94000,    99000,    104000,
        9000,    43000,    44000,    45000,    53000,    64000,    71000,    94000,    99000,    104000,   110000,
        10000,   61000,    68000,    76000,    84000,    91000,    95000,    98000,    104000,   108000,   114000,
        11000,   67000,    74000,    81000,    89000,    95000,    99000,    101000,   106000,   112000,   114000,
        13000,   76000,    83000,    91000,    98000,    105000,   109000,   110000,   112000,   116000,   121000,
        15000,   83000,    91000,    98000,    106000,   113000,   115000,   117000,   119000,   122000,   125000,
    },
        
    shape_table_data =
    {
        {
            name     = ls6_500_name,
            file     = ls6_500_model,
            life     = 1,
            fire     = { 0, 1},
            username = ls6_500_name,
            index    = WSTYPE_PLACEHOLDER,
        },
    },
    
    fm = {
        mass                = ls6_500_mass,  
        caliber             = 0.377,  
        cx_coeff            = {1, 0.8, 0.8, 0.15, 1.5},
        L                   = 3.09,
        I                   = 1 / 12 * ls6_500_mass * 3.09 * 3.09,
        Ma                  = 2,
        Mw                  = 7,
        wind_sigma          = 0.0,
        wind_time           = 0.0,
        Sw                  = 1.1,
        dCydA               = {0.07, 0.036},
        A                   = 0.1,
        maxAoa              = 0.4,
        finsTau             = 1.2,
        Ma_x                = 2,
        Ma_z                = 2,
        Mw_x                = 1.4,
        
        addDeplSw           = 0.6,
        no_wings_A_mlt      = 2,
        wingsDeplProcTime   = 5,
        wingsDeplDelay      = 9999,
        no_wings_cx_coeff   = {1, 0.4, 0.8, 0.10, 1.5},
    },
    
    simple_seeker = {
        sensitivity  = 0,
        delay        = 2.5,
        FOV          = 0.6,
        maxW         = 500,
        opTime       = 9999,
    },
    
    control_block = {
        seeker_activation_dist       = 7000,
        default_cruise_height        = -1,
        obj_sensor                   = 1,
        can_update_target_pos        = 0,
        turn_before_point_reach      = 1,
        turn_hor_N                   = 2.2,
        turn_max_calc_angle_deg      = 90,
        turn_point_trigger_dist      = 100,
    },
    
    autopilot = {
        delay                        = 2.5,
        K                            = 500,
        Ki                           = 0.00005,
        Kg                           = 8,
        nw_K                         = 30,
        nw_Ki                        = 0.0,
        nw_Kg                        = 25,
        finsLimit                    = 0.8,
        useJumpByDefault             = 0,
        J_Power_K                    = 6,
        J_Diff_K                     = 3,
        J_Int_K                      = 0.0,
        J_Angle_W                    = 0.1,
        hKp_err                      = 460,
        hKp_err_croll                = 0.012,
        hKd                          = -0.008,
        max_roll                     = 1.3,
        egm_Angle_K                  = 0.2,
        egm_FinAngle_K               = 0.3,
        egm_add_power_K              = 0.2,
        wings_depl_fins_limit_K      = 0.3,
        err_new_wlos_k               = 0.8,
        err_aoaz_k                   = 28,
        err_aoaz_sign_k              = 0.18,
    },
        
    warhead     = LS6_500_warhead,
    warhead_air = LS6_500_warhead,
}

declare_weapon(LS_6_500)

declare_loadout({
    category         = CAT_BOMBS,
    CLSID            = 'DIS_LS_6_500',
    attribute        = LS_6_500.wsTypeOfWeapon,
    Count            = 1,
    Cx_pil           = 0.0018,
    Picture          = "ls-6.png",
    displayName      = _(ls6_500_name),
    Weight           = LS_6_500.mass + pylon_mass,
    Elements         = {
        [1] = {
            ShapeName = ls6_500_model,
            DrawArgs  = {
                [1] = {2, 1.0},
            }
        }
    },
    ejectImpulse     = eject_speed * LS_6_500.mass,
    ejectDirection   = {0, -1, 0},
})

---------------------------------------------------

local ls6_250_name  = 'LS-6-250'
local ls6_250_mass  = 275.0
local ls6_250_model = "ls-6-250"
local pylon_mass = 45.0

local LS6_250_warhead = 
{
    mass                 = 100, 
    caliber              = 299,
    expl_mass            = 100,
    piercing_mass        = 0.0,
    other_factors        = { 1.0, 1.0, 1.0 },
    concrete_factors     = { 3.0, 1.0, 1.0 },
    concrete_obj_factor  = 2.0,
    obj_factors          = { 3.0, 1.0 },
    cumulative_factor    = 3.0,
    cumulative_thickness = 0.0,
}

LS_6_250 =
{
    category        = CAT_MISSILES,
    name            = ls6_250_name,
    user_name       = _(ls6_250_name),
    scheme          = "AGM-154C",
    class_name      = "wAmmunitionCruise",
    model           = ls6_250_model,
    mass            = ls6_250_mass,
    
    wsTypeOfWeapon  = {wsType_Weapon,wsType_Missile,wsType_AS_Missile,WSTYPE_PLACEHOLDER},

    Escort          = 0,
    Head_Type       = 5,
    sigma           = {20, 20, 20},
    M               = ls6_250_mass,
    H_max           = 28000.0,
    H_min           = 100,
    Diam            = 299.0,
    Cx_pil          = 8,
    D_max           = 130000.0,
    D_min           = 5000.0,
    Head_Form       = 1,
    Life_Time       = 9999,
    Nr_max          = 10,
    v_min           = 10.0,
    v_mid           = 200.0,
    Mach_max        = 1.7,
    t_b             = 0.0,
    t_acc           = 0.0,
    t_marsh         = 0.0,
    Range_max       = 140000.0,
    H_min_t         = 0.0,
    Fi_start        = 3.14152,
    Fi_rak          = 3.14152,
    Fi_excort       = 3.14152,
    Fi_search       = 99.9,
    OmViz_max       = 99.9,
    X_back          = 0.0,
    Y_back          = 0.0,
    Z_back          = 0.0,
    Reflection      = 0.03,
    KillDistance    = 0.0,
    
    LaunchDistData =
    {
        17,        10,
        
                 100,    150,    200,    250,    300,    350,    400,    450,    500,    550,
        100,     0,        0,        0,        0,        10000,    19000,    25000,    30000,    33000,    37000,
        200,     0,        0,        0,        10000,    16000,    24000,    30000,    34000,    38000,    41000,
        500,     0,        0,        0,        12000,    24000,    32000,    38000,    42000,    45000,    48000,
        800,     0,        0,        0,        15000,    27000,    35000,    40000,    44000,    48000,    51000,
        1000,    0,        0,        0,        17000,    29000,    36000,    42000,    46000,    49000,    53000,
        2000,    0,        0,        14000,    24000,    37000,    43000,    50000,    54000,    57000,    60000,
        3000,    0,        0,        21000,    32000,    42000,    51000,    57000,    61000,    65000,    69000,
        4000,    11000,    11000,    27000,    40000,    51000,    58000,    64000,    69000,    73000,    76000,
        5000,    21000,    22000,    28000,    48000,    58000,    64000,    70000,    76000,    79000,    84000,
        6000,    25000,    25000,    28000,    50000,    60000,    67000,    76000,    81000,    86000,    91000,
        7000,    34000,    34000,    35000,    51000,    62000,    68000,    83000,    88000,    93000,    97000,
        8000,    36000,    37000,    38000,    52000,    63000,    69000,    88000,    94000,    99000,    104000,
        9000,    43000,    44000,    45000,    53000,    64000,    71000,    94000,    99000,    104000,   110000,
        10000,   61000,    68000,    76000,    84000,    91000,    95000,    98000,    104000,   108000,   114000,
        11000,   67000,    74000,    81000,    89000,    95000,    99000,    101000,   106000,   112000,   114000,
        13000,   76000,    83000,    91000,    98000,    105000,   109000,   110000,   112000,   116000,   121000,
        15000,   83000,    91000,    98000,    106000,   113000,   115000,   117000,   119000,   122000,   125000,
    },
        
    shape_table_data =
    {
        {
            name     = ls6_250_name,
            file     = ls6_250_model,
            life     = 1,
            fire     = { 0, 1},
            username = ls6_250_name,
            index    = WSTYPE_PLACEHOLDER,
        },
    },
    
    fm = {
        mass                = ls6_250_mass,
        caliber             = 0.299,
        cx_coeff            = {1, 0.8, 0.8, 0.15, 1.5},
        L                   = 2.48,
        I                   = 1 / 12 * ls6_250_mass * 2.48 * 2.48,
        Ma                  = 2,
        Mw                  = 7,
        wind_sigma          = 0.0,
        wind_time           = 0.0,
        Sw                  = 1.1,
        dCydA               = {0.07, 0.036},
        A                   = 0.1,
        maxAoa              = 0.4,
        finsTau             = 1.2,
        Ma_x                = 2,
        Ma_z                = 2,
        Mw_x                = 1.4,
        
        addDeplSw           = 0.6,
        no_wings_A_mlt      = 2,
        wingsDeplProcTime   = 5,
        wingsDeplDelay      = 9999,
        no_wings_cx_coeff   = {1, 0.4, 0.8, 0.10, 1.5},
    },
    
    simple_seeker = {
        sensitivity  = 0,
        delay        = 2.5,
        FOV          = 0.6,
        maxW         = 500,
        opTime       = 9999,
    },
    
    control_block = {
        seeker_activation_dist       = 7000,
        default_cruise_height        = -1,
        obj_sensor                   = 1,
        can_update_target_pos        = 0,
        turn_before_point_reach      = 1,
        turn_hor_N                   = 2.2,
        turn_max_calc_angle_deg      = 90,
        turn_point_trigger_dist      = 100,
    },
    
    autopilot = {
        delay                        = 2.5,
        K                            = 500 / 2.0,
        Ki                           = 0.00005,
        Kg                           = 8 / 2.0,
        nw_K                         = 30 / 2.0,
        nw_Ki                        = 0.0,
        nw_Kg                        = 25 / 2.0,
        finsLimit                    = 0.8,
        useJumpByDefault             = 0,
        J_Power_K                    = 6 / 2.0,
        J_Diff_K                     = 3 / 2.0,
        J_Int_K                      = 0.0,
        J_Angle_W                    = 0.1,
        hKp_err                      = 460,
        hKp_err_croll                = 0.012,
        hKd                          = -0.008,
        max_roll                     = 1.3,
        egm_Angle_K                  = 0.2,
        egm_FinAngle_K               = 0.3,
        egm_add_power_K              = 0.2,
        wings_depl_fins_limit_K      = 0.3,
        err_new_wlos_k               = 0.8,
        err_aoaz_k                   = 28,
        err_aoaz_sign_k              = 0.18,
    },
        
    warhead     = LS6_250_warhead,
    warhead_air = LS6_250_warhead,
}

declare_weapon(LS_6_250)

local ldout_cnt = 1

declare_loadout({
    category         = CAT_BOMBS,
    CLSID            = 'DIS_LS_6_250',
    attribute        = LS_6_250.wsTypeOfWeapon,
    Count            = ldout_cnt,
    Cx_pil           = 0.0012,
    Picture          = "ls-6.png",
    displayName      = _(ls6_250_name),
    Weight           = LS_6_250.mass + pylon_mass,
    Elements         = {
        [1] = {
            ShapeName = ls6_250_model,
            DrawArgs  = {
                [1] = {2, 1.0},
            }
        }
    },
    ejectImpulse     = eject_speed * LS_6_250.mass,
    ejectDirection   = {0, -1, 0},
})

ldout_cnt = 2

declare_loadout({
    category         = CAT_BOMBS,
    CLSID            = "DIS_LS_6_250_DUAL_L",
    Count            = ldout_cnt,
    Cx_pil           = 0.0012 * ldout_cnt + 0.00122,
    Picture          = "ls-6.png",
    displayName      = _(ls6_250_name .. " Dual"),
    Weight           = LS_6_250.mass * ldout_cnt + pylon_mass,
    Elements = {
        {
            ShapeName = "JF-17_GDJ-II19L",
            IsAdapter = true
        },
        {
            ShapeName = ls6_250_model,
            connector_name = "Pylon_GDJ-II19L_R",
            DrawArgs  = {
                [1] = {1, 1.0},
            }
        },
        {
            ShapeName = ls6_250_model,
            connector_name = "Pylon_GDJ-II19L_L",
            DrawArgs  = {
                [1] = {1, 1.0},
            }
        },
    },
    wsTypeOfWeapon   = LS_6_250.wsTypeOfWeapon,
    attribute        = {4, 4, 32, WSTYPE_PLACEHOLDER},
    ejectImpulse     = eject_speed * LS_6_250.mass,
    ejectDirection   = {0, -1, 0},
})

declare_loadout({
    category         = CAT_BOMBS,
    CLSID            = "DIS_LS_6_250_DUAL_R",
    Count            = ldout_cnt,
    Cx_pil           = 0.0012 * ldout_cnt + 0.00122,
    Picture          = "ls-6.png",
    displayName      = _(ls6_250_name .. " Dual"),
    Weight           = LS_6_250.mass * ldout_cnt + pylon_mass,
    Elements = {
        {
            ShapeName = "JF-17_GDJ-II19R",
            IsAdapter = true
        },
        {
            ShapeName = ls6_250_model,
            connector_name = "Pylon_GDJ-II19R_L",
            DrawArgs  = {
                [1] = {1, 1.0},
            }
        },
        {
            ShapeName = ls6_250_model,
            connector_name = "Pylon_GDJ-II19R_R",
            DrawArgs  = {
                [1] = {1, 1.0},
            }
        },
    },
    wsTypeOfWeapon   = LS_6_250.wsTypeOfWeapon,
    attribute        = {4, 4, 32, WSTYPE_PLACEHOLDER},
    ejectImpulse     = eject_speed * LS_6_250.mass,
    ejectDirection   = {0, -1, 0},
})
