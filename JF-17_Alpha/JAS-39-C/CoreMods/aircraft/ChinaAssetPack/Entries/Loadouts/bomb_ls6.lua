
local ls6_name = 'GBU-39/B (LS-6-500)'
local ls6_mass = 525.0
local pylon_mass = 45.0

local LS6_warhead = 
{
    mass                 = 500, 
    caliber              = 377,
    expl_mass            = 500,
    piercing_mass        = 0.0,
    other_factors        = { 2.0, 1.0, 1.0 },
    concrete_factors     = { 3.0, 1.0, 1.0 },
    concrete_obj_factor  = 2.0,
    obj_factors          = { 3.0, 1.0 },
    cumulative_factor    = 3.0,
    cumulative_thickness = 0.0,
}

LS_6_500 =
{
    category        = CAT_MISSILES,
    name            = ls6_name,
    user_name       = _(ls6_name),
    scheme          = "AGM-154C",
    class_name      = "wAmmunitionCruise",
    model           = "ls-6",
    mass            = ls6_mass,
    
    wsTypeOfWeapon  = {wsType_Weapon,wsType_Missile,wsType_AS_Missile,WSTYPE_PLACEHOLDER},

    Escort          = 0,
    Head_Type       = 5,
    sigma           = {20, 20, 20},
    M               = ls6_mass,
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
    Reflection      = 0.618,
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
            name     = ls6_name,
            file     = "ls-6",
            life     = 1,
            fire     = { 0, 1},
            username = ls6_name,
            index    = WSTYPE_PLACEHOLDER,
        },
    },
    
    fm =    {
        mass                = ls6_mass,  
        caliber             = 0.377,  
        cx_coeff            = {1, 0.3, 0.65, 0.010, 1.6},
        L                   = 3.09,
        I                   = 1 / 12 * ls6_mass * 3.09 * 3.09,
        Ma                  = 2,
        Mw                  = 7,
        wind_sigma          = 0.0,
        wind_time           = 0.0,
        Sw                  = 1.1,
        dCydA               = {0.07, 0.036},
        A                   = 0.07,
        maxAoa              = 0.4,
        finsTau             = 1.2,
        Ma_x                = 2,
        Ma_z                = 2,
        Kw_x                = 0.03,
        add_Sw              = 0.6,
        add_w_c0            = 0.008,
        start_no_w_A_mult   = 7,
    },
    
    simple_seeker = {
        sensitivity  = 0,
        delay        = 0.0,
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
    
    --[[
    control_block2 ={
        delay                            = 0.5,
        add_y                            = 90,
        wind_k                           = 1.0,
        use_snake_maneuver               = 0,
        max_no_vert_offset_open_h        = 0,
        vert_offset_before_end_game_k    = 0.8,    
    },

    open_trigger = {
        delay                           = 0.1,
        trigger_add_time                = 0,
        bomblet_char_time               = 23.9,--23.3
        chute_bomblet_char_time         = 70.1,
        chute_open_time                 = 2.6,
        chute_cut_time                  = 500,
        char_time_vel_correction_coeff  = -0.0132,
        char_time_h_correction_coeff    = 0.0,
        default_add_y                   = 90,
    },
    ]]
    
    autopilot = {
        delay                        = 2,
        K                            = 500,
        Ki                           = 0.0,
        Kg                           = 30,
        nw_K                         = 180,
        nw_Ki                        = 0.001,
        nw_Kg                        = 52,
        finsLimit                    = 0.8,
        useJumpByDefault             = 0,
        J_Power_K                    = 7,
        J_Diff_K                     = 1.2,
        J_Int_K                      = 0.0,
        J_Angle_K                    = 0.14,
        J_FinAngle_K                 = 0.25,
        J_Angle_W                    = 0.12,
        hKp_err                      = 460,
        hKp_err_croll                = 0.012,
        hKd                          = -0.008,
        max_roll                     = 1.3,
        egm_Angle_K                  = 0.18,
        egm_FinAngle_K               = 0.26,
        egm_add_power_K              = 0.2,
        wings_depl_fins_limit_K      = 0.28,
        err_new_wlos_k               = 0.84,
        err_aoaz_k                   = 28,
        err_aoaz_sign_k              = 0.18,
    },
        
    warhead     = LS6_warhead,
    warhead_air = LS6_warhead,
}

declare_weapon(LS_6_500)

declare_loadout({
    category         = CAT_MISSILES,
    CLSID            = 'DIS_LS_6_500',
    attribute        = LS_6_500.wsTypeOfWeapon,
    Count            = 1,
    Cx_pil           = 0.001,
    Picture          = "ls-6.png",
    displayName      = _(ls6_name),
    Weight           = LS_6_500.mass + pylon_mass,
    Elements         = {{ShapeName = "ls-6"}},
    ejectImpulse     = 140,
})
