
local gb6_name   = "GB-6"
local gb6_mass   = 620
local gb6_model  = "gb6"
local pylon_mass = 52.0

local JS_6_warhead = 
{
    mass                    = 2.5,
    caliber                 = 63,
    expl_mass               = 1.5,
    piercing_mass           = 0.0,
    other_factors           = { 1.0, 1.0, 1.0 },
    concrete_factors        = { 1.0, 1.0, 1.0 },
    concrete_obj_factor     = 0.0,
    obj_factors             = { 1.0, 1.0 },
    cumulative_factor       = 3.0,
    cumulative_thickness    = 0.65
}
    
local GB6HE_warhead = 
{
    mass                 = 500, 
    caliber              = 377,
    expl_mass            = 500,
    piercing_mass        = 0.0,
    other_factors        = { 1.0, 1.0, 1.0 },
    concrete_factors     = { 3.0, 1.0, 1.0 },
    concrete_obj_factor  = 2.0,
    obj_factors          = { 3.0, 1.0 },
    cumulative_factor    = 3.0,
    cumulative_thickness = 0.0,
}

GB6 =
{
    category        = CAT_MISSILES,
    name            = gb6_name,
    user_name       = _(gb6_name),
    scheme          = "AGM-154AB",
    class_name      = "wAmmunitionCruise",
    model           = gb6_model,
    mass            = gb6_mass,
        
    wsTypeOfWeapon  = {wsType_Weapon,wsType_Missile,wsType_AS_Missile,WSTYPE_PLACEHOLDER},

    Escort          = 0,
    Head_Type       = 5,
    sigma           = {20, 20, 20},
    M               = gb6_mass,
    H_max           = 28000.0,
    H_min           = 100,
    Diam            = 330.0,
    Cx_pil          = 10,
    D_max           = 126000.0,
    D_min           = 10000.0,
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
    Reflection      = 0.1,
    KillDistance    = 0.0,
    
    LaunchDistData =
    {
        19,        10,

                100,    150,    200,    250,    300,    350,    400,    450,    500,    550,        
          100,    0,        0,        0,        10100,    20100,    28025,    33575,    37975,    41250,    44125,    
          200,    0,        0,        0,        10800,    20650,    28225,    34650,    38700,    41975,    44850,    
          400,    0,        0,        0,        11250,    21825,    29900,    35975,    39875,    43375,    46200,    
          700,    0,        0,        0,        12200,    23875,    31475,    37900,    41800,    45050,    48475,    
         1000,    0,        0,        7850,     13150,    22500,    33450,    38450,    42150,    45250,    48250,    
         2000,    0,        0,        11200,    19000,    28650,    40000,    45650,    49550,    52850,    55950,    
         3000,    0,        12000,    15000,    23000,    32000,    46600,    52300,    56400,    63000,    66800,    
         4000,    14400,    16800,    18300,    26200,    34400,    47200,    58800,    62700,    66800,    70900,    
         5000,    20000,    22500,    23600,    29500,    37800,    48700,    64600,    69000,    73600,    77300,    
         6000,    25700,    25900,    26100,    33700,    42500,    49500,    70000,    75600,    79600,    84000,    
         7000,    30250,    30250,    30500,    39250,    45000,    53750,    60500,    83000,    85000,    90000,    
         8000,    34250,    34250,    34500,    41500,    50750,    57000,    63750,    85000,    89500,    96000,    
         9000,    39250,    39250,    40250,    46250,    54250,    60500,    67500,    73500,    96750,    105000,    
        10000,    53750,    54250,    67250,    78750,    86750,    92500,    96000,    98500,    99000,    106250,    
        11000,    60000,    64500,    74500,    84000,    91000,    96500,    100000,   101000,   104000,   109500,    
        12000,    63500,    70500,    80000,    89000,    96000,    101500,   104500,   106500,   109500,   113500,    
        13000,    67500,    76000,    84500,    93500,    101000,   106000,   110000,   112000,   113500,   118500,    
        14000,    70500,    81500,    88500,    98000,    105000,   110500,   112500,   115500,   118500,   121500,    
        15000,    73000,    85500,    92500,    101000,   109000,   113500,   117000,   119500,   122000,   126000,    
    },

    MinLaunchDistData =
    {
        19,        10,

                100,    150,    200,    250,    300,    350,    400,    450,    500,    550,        
          100,    0,        0,       0,      9775,     7175,    11725,    17700,    21600,    24750,    27500,    
          200,    0,        0,       0,      8150,     7175,    11325,    17325,    21275,    24375,    27250,    
          400,    0,        0,       0,      7350,     6400,    10475,    16550,    20550,    23725,    26600,    
          700,    0,        0,       0,      7775,     4675,    8925,     15150,    19225,    22475,    25425,    
         1000,    0,        0,      7750,    6850,     3950,    5800,     3100,     3500,     4100,     6400,    
         2000,    0,        0,      6900,    5000,     4750,    5000,     5750,     5400,     5950,     6350,    
         3000,    0,       7000,    5800,    6200,     6500,    5600,     5600,     5800,     30000,    33800,    
         4000,    9200,    5500,    6600,    7000,     7100,    8100,     6000,     6000,     6100,     10100,    
         5000,    3600,    5800,    6100,    6200,     7100,    6800,     8300,     5400,     8300,     10200,    
         6000,    3300,    5100,    5800,    6400,     8300,    9400,     9900,     7700,     9500,     11700,    
         7000,    4750,    5000,    6750,    7750,     9000,    10500,    15250,    9750,     11500,    13500,    
         8000,    5250,    5750,    7500,    8000,     10250,   11000,    16500,    11500,    13500,    15500,    
         9000,    6000,    6250,    8250,    8500,     8750,    11500,    11750,    14500,    15250,    57250,    
        10000,    1250,    4000,    9000,    9250,     9500,    10250,    11750,    18500,    20250,    23000,    
        11000,    5000,    7000,    7500,    8000,     8500,    9500,     13000,    14500,    17000,    24500,    
        12000,    1000,    7500,    8500,    9000,     9000,    10500,    15500,    14500,    17000,    26000,    
        13000,    5500,    8000,    9000,    10000,    11500,   10500,    20000,    22000,    25500,    27500,    
        14000,    5500,    8000,    9500,    10500,    10500,   11000,    17000,    18500,    25500,    30500,    
        15000,    1000,    8500,    10500,   11500,    11000,   12000,    19000,    26000,    29000,    31500,    
    },
    
    shape_table_data =
    {
        {
            name     = gb6_name,
            file     = gb6_model,
            life     = 1,
            fire     = {0, 1},
            username = gb6_name,
            index    = WSTYPE_PLACEHOLDER,
        },
    },
    
    warhead = simple_warhead(0),

    fm = {
        mass                = gb6_mass,  
        caliber             = 0.3,  
        cx_coeff            = {1, 0.8, 0.8, 0.15, 1.5},
        L                   = 4.5,
        I                   = 1 / 12 * gb6_mass * 4.5 * 4.5,
        Ma                  = 2,
        Mw                  = 7,
        wind_sigma          = 0.0,
        wind_time           = 0.0,
        Sw                  = 1.2,
        dCydA               = {0.07, 0.036},
        A                   = 0.15,
        maxAoa              = 0.4,
        finsTau             = 0.2,
        Ma_x                = 2,
        Ma_z                = 2,
        Mw_x                = 1.4,
        
        addDeplSw           = 0.6,
        no_wings_A_mlt      = 2,
        wingsDeplProcTime   = 5,
        wingsDeplDelay      = 9999,
        no_wings_cx_coeff   = {1, 0.5, 0.8, 0.10, 1.6},
    },
    
    simple_seeker = {
        sensitivity = 0,
        delay       = 2.5,
        FOV         = 0.6,
        maxW        = 500,
        opTime      = 9999,
    },
    
    control_block = {
        seeker_activation_dist       = 7000,
        default_cruise_height        = -1,
        obj_sensor                   = 0,
        can_update_target_pos        = 0,
        turn_before_point_reach      = 1,
        turn_hor_N                   = 2.2,
        turn_max_calc_angle_deg      = 90,
        turn_point_trigger_dist      = 100,
    },
    
    control_block2 = {
        delay                            = 0.5,
        add_y                            = 90,
        wind_k                           = 1.0,
        use_snake_maneuver               = 0,
        max_no_vert_offset_open_h        = 90,
        vert_offset_before_end_game_k    = 0.8,
        can_update_target_pos            = 0,
    },

    open_trigger = {
        delay                           = 0.1,
        trigger_add_time                = 1,
        bomblet_char_time               = 23.9,
        chute_bomblet_char_time         = 70.1,
        chute_open_time                 = 2.6,
        chute_cut_time                  = 400,
        char_time_vel_correction_coeff  = -0.0132,
        char_time_h_correction_coeff    = 0.0,
        default_add_y                   = 90,
        out_w_add_y                     = 0,
        wind_correction_coeff           = 1,
        time_coeff_data                 = { 25,       0.9,
                                            18,       0.86,
                                            15,       0.8,
                                            11.7,     0.58,
                                            6.8,      0.3,
                                            3,        0.2, },
    },
    
    autopilot = {
        delay                       = 2.5,
        K                           = 500,
        Ki                          = 0.00005,
        Kg                          = 10,
        nw_K                        = 22,
        nw_Ki                       = 0.0,
        nw_Kg                       = 2,
        finsLimit                   = 0.8,
        useJumpByDefault            = 0,
        J_Power_K                   = 7,
        J_Diff_K                    = 4,
        J_Int_K                     = 0.0,
        J_Angle_W                   = 0.1,
        hKp_err                     = 460,
        hKp_err_croll               = 0.012,
        hKd                         = -0.008,
        max_roll                    = 1.3,
        egm_Angle_K                 = 0.2,
        egm_FinAngle_K              = 0.3,
        egm_add_power_K             = 0.2,
        wings_depl_fins_limit_K     = 0.3,
        err_new_wlos_k              = 0.84,
        err_aoaz_k                  = 28,
        err_aoaz_sign_k             = 0.18,
    },

    launcher =
    {
        cluster = cluster_desc("Bomb_Other", wsType_Bomb_Cluster,
        {
            scheme = 
            {
                dispenser = 
                {
                    mass                    = gb6_mass,
                    caliber                 = 0.55,
                    L                       = 3.5,
                    I                       = 270.0,
                    Ma                      = 1,
                    Mw                      = 3,
                    cx_coeff                = {1, 0.3, 0.65, 0.018, 1.6},
                    model_name              = gb6_model,
                    set_start_args          = {},
                    spawn_time              = {0},
                    spawn_weight_loss       = {300},
                    spawn_args_change       = {},
                    op_spawns               = 2,
                    use_effects             = 0,
                    hide_effect_0           = 0,
                },
                
                bomblets =
                {
                    wind_sigma                  = 25,
                    impulse_sigma               = 2,
                    moment_sigma                = 0.1,
                    count                       = 150,
                    effect_count                = 60,
                    mass                        = 3,
                    caliber                     = 0.063,
                    cx_coeff                    = {1.0, 0.39, 0.38, 0.236, 1.31},
                    L                           = 1.68000,
                    I                           = 0.061333,
                    Ma                          = 0.2,
                    Mw                          = 0.8,
                    model_name                  = "PTAB-2_5KO",
                    connectors_model_name       = "RBK_250_PTAB_25M_tail",
                    explosion_impulse_coeff     = 15,
                    explosion_dont_use_x_axis   = 0,
                    release_rnd_coeff           = 0.8,
                    chute_open_time             = 2.6,
                    chute_cut_time              = 500.0,
                    chute_diam                  = 0.2,
                    chute_Cx                    = 0.7,
                    chute_rnd_coeff             = 0.5,
                    explosion_center            = {{0,0.3,0}},
                    spawn_options               = {{0,0,150}},
                },
                warhead = JS_6_warhead,
            },
            
            name            = _("JS-06"),
            type_name       = _("cluster"),
            cluster_scheme  = "disp_bomblets",
        }
        )
    },
    
}

declare_weapon(GB6)

declare_loadout({
    category        = CAT_BOMBS,
    CLSID           = 'DIS_GB6',
    attribute       = GB6.wsTypeOfWeapon,
    Count           = 1,
    Cx_pil          = 0.0024,
    Picture         = "gb6.png",
    displayName     = _(gb6_name),
    Weight          = GB6.mass + pylon_mass,
    Elements        = {{ShapeName = gb6_model}},
    ejectImpulse    = eject_speed * GB6.mass,
    ejectDirection  = {0, -1, 0},
})




--------------------------------
GB6_TSP =
{
    category        = CAT_MISSILES,
    name            = gb6_name .. '-SFW',
    user_name       = _(gb6_name ..'-SFW'),
    scheme          = "AGM-154AB",
    class_name      = "wAmmunitionCruise",
    model           = gb6_model,
    mass            = gb6_mass,
    
    wsTypeOfWeapon  = {wsType_Weapon,wsType_Missile,wsType_AS_Missile,WSTYPE_PLACEHOLDER},

    Escort          = 0,
    Head_Type       = 5,
    sigma           = {20, 20, 20},
    M               = gb6_mass,
    H_max           = 28000.0,
    H_min           = 100,
    Diam            = 330.0,
    Cx_pil          = 10,
    D_max           = 126000.0,
    D_min           = 10000.0,
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
    Reflection      = 0.1,
    KillDistance    = 0.0,
    
    LaunchDistData =
    {
        19,        10,

                100,    150,    200,    250,    300,    350,    400,    450,    500,    550,        
        100,    0,        0,        0,        10100,    20100,    28025,    33575,    37975,    41250,    44125,    
        200,    0,        0,        0,        10800,    20650,    28225,    34650,    38700,    41975,    44850,    
        400,    0,        0,        0,        11250,    21825,    29900,    35975,    39875,    43375,    46200,    
        700,    0,        0,        0,        12200,    23875,    31475,    37900,    41800,    45050,    48475,    
        1000,    0,        0,        7850,    13150,    22500,    33450,    38450,    42150,    45250,    48250,    
        2000,    0,        0,        11200,    19000,    28650,    40000,    45650,    49550,    52850,    55950,    
        3000,    0,        12000,    15000,    23000,    32000,    46600,    52300,    56400,    63000,    66800,    
        4000,    14400,    16800,    18300,    26200,    34400,    47200,    58800,    62700,    66800,    70900,    
        5000,    20000,    22500,    23600,    29500,    37800,    48700,    64600,    69000,    73600,    77300,    
        6000,    25700,    25900,    26100,    33700,    42500,    49500,    70000,    75600,    79600,    84000,    
        7000,    30250,    30250,    30500,    39250,    45000,    53750,    60500,    83000,    85000,    90000,    
        8000,    34250,    34250,    34500,    41500,    50750,    57000,    63750,    85000,    89500,    96000,    
        9000,    39250,    39250,    40250,    46250,    54250,    60500,    67500,    73500,    96750,    105000,    
        10000,    53750,    54250,    67250,    78750,    86750,    92500,    96000,    98500,    99000,    106250,    
        11000,    60000,    64500,    74500,    84000,    91000,    96500,    100000,    101000,    104000,    109500,    
        12000,    63500,    70500,    80000,    89000,    96000,    101500,    104500,    106500,    109500,    113500,    
        13000,    67500,    76000,    84500,    93500,    101000,    106000,    110000,    112000,    113500,    118500,    
        14000,    70500,    81500,    88500,    98000,    105000,    110500,    112500,    115500,    118500,    121500,    
        15000,    73000,    85500,    92500,    101000,    109000,    113500,    117000,    119500,    122000,    126000,    
    },

    MinLaunchDistData =
    {
        19,        10,

                100,    150,    200,    250,    300,    350,    400,    450,    500,    550,        
        100,    0,        0,        0,        9775,    7175,    11725,    17700,    21600,    24750,    27500,    
        200,    0,        0,        0,        8150,    7175,    11325,    17325,    21275,    24375,    27250,    
        400,    0,        0,        0,        7350,    6400,    10475,    16550,    20550,    23725,    26600,    
        700,    0,        0,        0,        7775,    4675,    8925,    15150,    19225,    22475,    25425,    
        1000,    0,        0,        7750,    6850,    3950,    5800,    3100,    3500,    4100,    6400,    
        2000,    0,        0,        6900,    5000,    4750,    5000,    5750,    5400,    5950,    6350,    
        3000,    0,        7000,    5800,    6200,    6500,    5600,    5600,    5800,    30000,    33800,    
        4000,    9200,    5500,    6600,    7000,    7100,    8100,    6000,    6000,    6100,    10100,    
        5000,    3600,    5800,    6100,    6200,    7100,    6800,    8300,    5400,    8300,    10200,    
        6000,    3300,    5100,    5800,    6400,    8300,    9400,    9900,    7700,    9500,    11700,    
        7000,    4750,    5000,    6750,    7750,    9000,    10500,    15250,    9750,    11500,    13500,    
        8000,    5250,    5750,    7500,    8000,    10250,    11000,    16500,    11500,    13500,    15500,    
        9000,    6000,    6250,    8250,    8500,    8750,    11500,    11750,    14500,    15250,    57250,    
        10000,    1250,    4000,    9000,    9250,    9500,    10250,    11750,    18500,    20250,    23000,    
        11000,    5000,    7000,    7500,    8000,    8500,    9500,    13000,    14500,    17000,    24500,    
        12000,    1000,    7500,    8500,    9000,    9000,    10500,    15500,    14500,    17000,    26000,    
        13000,    5500,    8000,    9000,    10000,    11500,    10500,    20000,    22000,    25500,    27500,    
        14000,    5500,    8000,    9500,    10500,    10500,    11000,    17000,    18500,    25500,    30500,    
        15000,    1000,    8500,    10500,    11500,    11000,    12000,    19000,    26000,    29000,    31500,    
    },
        
    shape_table_data =
    {
        {
            name     = gb6_name .. '-SFW',
            file     = gb6_model,
            life     = 1,
            fire     = {0, 1},
            username = gb6_name .. '-SFW',
            index    = WSTYPE_PLACEHOLDER,
        },
    },
    
    warhead = simple_warhead(0),

    fm = {
        mass                = gb6_mass,
        caliber             = 0.3,  
        cx_coeff            = {1, 0.8, 0.8, 0.15, 1.5},
        L                   = 4.5,
        I                   = 1 / 12 * gb6_mass * 4.5 * 4.5,
        Ma                  = 2,
        Mw                  = 7,
        wind_sigma          = 0.0,
        wind_time           = 0.0,
        Sw                  = 1.2,
        dCydA               = {0.07, 0.036},
        A                   = 0.15,
        maxAoa              = 0.4,
        finsTau             = 0.2,
        Ma_x                = 2,
        Ma_z                = 2,
        Mw_x                = 1.4,
        
        addDeplSw           = 0.6,
        no_wings_A_mlt      = 2,
        wingsDeplProcTime   = 5,
        wingsDeplDelay      = 9999,
        no_wings_cx_coeff   = {1, 0.5, 0.8, 0.10, 1.6},
    },
    
    simple_seeker = {
        sensitivity = 0,
        delay       = 2.5,
        FOV         = 0.6,
        maxW        = 500,
        opTime      = 9999,
    },
    
    control_block = {
        seeker_activation_dist       = 7000, -- 到达航路点前xx米 激活传感器(?)
        default_cruise_height        = -1,
        obj_sensor                   = 0, -- 载具传感器不抓目标
        can_update_target_pos        = 0,
        turn_before_point_reach      = 1, -- 到达航路点前转弯
        turn_hor_N                   = 2.2,
        turn_max_calc_angle_deg      = 90,
        turn_point_trigger_dist      = 100,
    },
    
    control_block2 = {
        delay                            = 0.5,
        add_y                            = 180, -- 爬高180米, 准备攻击
        wind_k                           = 1.0,
        use_snake_maneuver               = 0, -- 末段蛇形机动
        max_no_vert_offset_open_h        = 90,
        vert_offset_before_end_game_k    = 0.8,
        can_update_target_pos            = 0,
    },

    -- 释放子弹药的动作
    open_trigger = {
        delay                           = 0.1,
        trigger_add_time                = 0.5,
        bomblet_char_time               = 49,
        chute_bomblet_char_time         = 150,
        chute_open_time                 = 0.5,
        chute_cut_time                  = 500,
        char_time_vel_correction_coeff  = 0,
        char_time_h_correction_coeff    = 0,
        default_add_y                   = 180,
        out_w_add_y                     = 0,
        wind_correction_coeff           = 1,
        time_coeff_data                 = { 41,      1.92,    --900
                                            32.4,    1.78,    --700
                                            23.8,    1.55,    --500
                                            21.6,    1.3,     --450
                                            20.0,    1.08,    --400
                                            17.3,    1.0,     --350
                                            15,      1.2,     --300
                                            13,      1.2,     --250
                                            9.8,     0.96,    --180
                                            5.8,     0.85, }, --90
    },
    
    autopilot = {
        delay                       = 2.5,
        K                           = 500,
        Ki                          = 0.00005,
        Kg                          = 10,
        nw_K                        = 22,
        nw_Ki                       = 0.0,
        nw_Kg                       = 2,
        finsLimit                   = 0.8,
        useJumpByDefault            = 0,
        J_Power_K                   = 7,
        J_Diff_K                    = 4,
        J_Int_K                     = 0.0,
        J_Angle_W                   = 0.1,
        hKp_err                     = 460,
        hKp_err_croll               = 0.012,
        hKd                         = -0.008,
        max_roll                    = 1.3,
        egm_Angle_K                 = 0.2,
        egm_FinAngle_K              = 0.3,
        egm_add_power_K             = 0.2,
        wings_depl_fins_limit_K     = 0.3,
        err_new_wlos_k              = 0.84,
        err_aoaz_k                  = 28,
        err_aoaz_sign_k             = 0.18,
    },
    
    launcher =
    {
        cluster = cluster_desc("Bomb_Other", wsType_Bomb_Cluster,
        {
            scheme = 
            {
                dispenser = 
                {
                    op_time                 = 9000,
                    wind_sigma              = 20,
                    impulse_sigma           = 1,
                    moment_sigma            = 1,
                    mass                    = 450,
                    caliber                 = 0.45,
                    L                       = 2.5,
                    I                       = 100,
                    Ma                      = 0.228,
                    Mw                      = 2.33,
                    cx_coeff                = {1, 1, 1, 1, 2},
                    model_name              = gb6_model,
                    set_start_args          = {0,12,13},
                    spawn_args_change       = {{1,12,0},{1,1,0.6}},
                    spawn_time              = {0.02, 0.17, 0.32}, -- BLU_108(带4个子弹药)的释放延迟, 要拉成一条线，可以适当放大，但不能太大，最好不要超过2.0
                    spawn_weight_loss       = {0, 150, 150},
                    spawn_args_change       = {{1,1,1},{1,12,0},{2,2,1}},
                    op_spawns               = 3,
                },

                --释放完BLU_108后的外壳(自由落体)
                empty_dispenser = 
                {
                    op_time                 = 50,
                    wind_sigma              = 5,
                    impulse_sigma           = 1,
                    moment_sigma            = 1,
                    mass                    = 45,
                    caliber                 = 0.45,
                    L                       = 2.5,
                    I                       = 2,
                    Ma                      = 0.03,
                    Mw                      = 0.3,
                    cx_coeff                = {1, 1, 1, 1, 2},
                    model_name              = gb6_model,
                    set_start_args          = {0, 1, 2},
                    spawn_options           = {{2, 2, 1}},
                },

                -- BLU_108(未释放战斗部)
                BLU_108 =
                {
                    op_time                 = 9000,
                    count                   = 12, -- BLU_108数量
                    effect_count            = 12,
                    wind_sigma              = 5,
                    impulse_sigma           = 1,
                    moment_sigma            = 2,
                    mass                    = 29.5,
                    caliber                 = 0.133,
                    L                       = 0.7,
                    I                       = 0.4,
                    Ma                      = 0.90985,
                    Mw                      = 1.67549,
                    cx_coeff                = {1, 0.39, 0.38, 0.236, 1.31},
                    model_name              = "cbu97_blu108",
                    set_start_args          = {13},
                    connectors_model_name   = "cbu97_shaft",
                    explosion_impulse_coeff = 42,
                    explosion_center        = {{0.36,0,0},{-0.44,0,0}},
                    release_rnd_coeff       = 7,
                    chute_open_time         = 0.5, -- 可以试试让BLU_108晚点开伞
                    chute_diam              = 2,
                    chute_Cx                = 1.2,
                    chute_rnd_coeff         = 0.5,
                    spawn_options           = {{0,1,6},{0,2,6}},
        
                    submunition_engine_impulse          = 60,
                    submunition_engine_fuel_mass        = 0.1,
                    submunition_engine_work_time        = 0.22,
                    submunition_engine_rotation_moment  = 9,
                    submunition_engine_start_height     = 48,   -- BLU-108开始自转的高度, 越高释放, 覆盖范围越大 
                    skeets_release_delay                = 1.00, -- BLU_108自转后开始释放战斗部的延迟
                    skeets_in_seq_release_delay         = 0.02, -- 每个战斗部释放间隔 (?) 
                    main_chute_open_speed               = 4,
                    extr_chute_max_diam                 = 0.3,
                    opening_speed_k                     = 2,
                    jump_error_sum                      = 440,
                },

                -- 释放完战斗部的BLU_108壳子
                BLU_108_panel =
                {
                    op_time                 = 50,
                    wind_sigma              = 5,
                    impulse_sigma           = 1,
                    moment_sigma            = 1,
                    mass                    = 5,
                    caliber                 = 0.1,
                    L                       = 1,
                    I                       = 1,
                    Ma                      = 0.5,
                    Mw                      = 1,
                    cx_coeff                = {1, 0.4, 0.4, 0.4, 1.4},
                    model_name              = "cbu97_blu108_panel",
                    init_pos                = {{0,0,0}},
                    init_impulse            = {{0,125,0}},
                    spawn_options           = {{0,1,1}},
                },

                -- 战斗部
                skeet = 
                {
                    op_time                 = 9000,
                    count                   = 4, -- 战斗部数量
                    effect_count            = 4,
                    wind_sigma              = 1,
                    impulse_sigma           = 1,
                    moment_sigma            = 0.1,
                    mass                    = 5,
                    caliber                 = 0.1,
                    L                       = 1,
                    I                       = 1,
                    Ma                      = 1,
                    Mw                      = 1,
                    cx_coeff                = {1, 0.4, 0.4, 0.4, 1.4},
                    model_name              = "cbu97_skeet",
                    init_pos                = {{0.02,-0.15,0},{0.02,0.15,0},{0.25,-0.15,0},{0.25,0.15,0}},
                    omega_impulse_coeff     = 3.6,
                    release_rnd_coeff       = 12,
                    set_start_args          = 10,
                    spawn_options           = {{2,2,1},{3,3,1},{4,4,1},{5,5,1}},
        
                    shell_model_name        = "shell",
                    seeker_local_point      = {{0.05, -0.07, 0}},
                    seeker_rotation_point   = {0, 0, 0},
                    seeker_max_angle        = 0.785, -- 战斗部搜索角度范围: 45度
                    seeker_max_range        = 160,  -- 战斗部最大搜索距离: 160米
                    seeker_activation_time  = 0.1,
                    shot_error              = 0.05, -- 战斗部误差
                    aim_lock_efficiency     = 0.85, -- 战斗部抓住目标几率
                    shell_speed             = 750,  -- m/s
                },
                warhead = predefined_warhead("CBU97"),
            },
            
            name            = _("MM-06"),
            type_name       = _("cluster"),
            cluster_scheme  = "AGM-154B_cluster",
        }
        )
    },
}

declare_weapon(GB6_TSP)

declare_loadout({
    category        = CAT_BOMBS,
    CLSID           = 'DIS_GB6_TSP',
    attribute       = GB6_TSP.wsTypeOfWeapon,
    Count           = 1,
    Cx_pil          = 0.0024,
    Picture         = "gb6.png",
    displayName     = _(gb6_name .. '-SFW'),
    Weight          = GB6_TSP.mass + pylon_mass,
    Elements        = {{ShapeName = gb6_model}},
    ejectImpulse    = eject_speed * GB6_TSP.mass,
    ejectDirection  = {0, -1, 0},
})


-- GB6_HE
GB6_HE =
{
    category        = CAT_MISSILES,
    name            = gb6_name .. '-HE',
    user_name       = _(gb6_name ..'-HE'),
    scheme          = "AGM-154C",
    class_name      = "wAmmunitionCruise",
    model           = gb6_model,
    mass            = gb6_mass,
    
    wsTypeOfWeapon  = {wsType_Weapon,wsType_Missile,wsType_AS_Missile,WSTYPE_PLACEHOLDER},

    Escort          = 0,
    Head_Type       = 5,
    sigma           = {20, 20, 20},
    M               = gb6_mass,
    H_max           = 28000.0,
    H_min           = 100,
    Diam            = 330.0,
    Cx_pil          = 10,
    D_max           = 126000.0,
    D_min           = 10000.0,
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
    Reflection      = 0.1,
    KillDistance    = 0.0,
    
    LaunchDistData =
    {
        19,        10,

                100,    150,    200,    250,    300,    350,    400,    450,    500,    550,        
        100,    0,        0,        0,        10100,    20100,    28025,    33575,    37975,    41250,    44125,    
        200,    0,        0,        0,        10800,    20650,    28225,    34650,    38700,    41975,    44850,    
        400,    0,        0,        0,        11250,    21825,    29900,    35975,    39875,    43375,    46200,    
        700,    0,        0,        0,        12200,    23875,    31475,    37900,    41800,    45050,    48475,    
        1000,    0,        0,        7850,    13150,    22500,    33450,    38450,    42150,    45250,    48250,    
        2000,    0,        0,        11200,    19000,    28650,    40000,    45650,    49550,    52850,    55950,    
        3000,    0,        12000,    15000,    23000,    32000,    46600,    52300,    56400,    63000,    66800,    
        4000,    14400,    16800,    18300,    26200,    34400,    47200,    58800,    62700,    66800,    70900,    
        5000,    20000,    22500,    23600,    29500,    37800,    48700,    64600,    69000,    73600,    77300,    
        6000,    25700,    25900,    26100,    33700,    42500,    49500,    70000,    75600,    79600,    84000,    
        7000,    30250,    30250,    30500,    39250,    45000,    53750,    60500,    83000,    85000,    90000,    
        8000,    34250,    34250,    34500,    41500,    50750,    57000,    63750,    85000,    89500,    96000,    
        9000,    39250,    39250,    40250,    46250,    54250,    60500,    67500,    73500,    96750,    105000,    
        10000,    53750,    54250,    67250,    78750,    86750,    92500,    96000,    98500,    99000,    106250,    
        11000,    60000,    64500,    74500,    84000,    91000,    96500,    100000,    101000,    104000,    109500,    
        12000,    63500,    70500,    80000,    89000,    96000,    101500,    104500,    106500,    109500,    113500,    
        13000,    67500,    76000,    84500,    93500,    101000,    106000,    110000,    112000,    113500,    118500,    
        14000,    70500,    81500,    88500,    98000,    105000,    110500,    112500,    115500,    118500,    121500,    
        15000,    73000,    85500,    92500,    101000,    109000,    113500,    117000,    119500,    122000,    126000,    
    },

    MinLaunchDistData =
    {
        19,        10,

                100,    150,    200,    250,    300,    350,    400,    450,    500,    550,        
        100,    0,        0,        0,        9775,    7175,    11725,    17700,    21600,    24750,    27500,    
        200,    0,        0,        0,        8150,    7175,    11325,    17325,    21275,    24375,    27250,    
        400,    0,        0,        0,        7350,    6400,    10475,    16550,    20550,    23725,    26600,    
        700,    0,        0,        0,        7775,    4675,    8925,    15150,    19225,    22475,    25425,    
        1000,    0,        0,        7750,    6850,    3950,    5800,    3100,    3500,    4100,    6400,    
        2000,    0,        0,        6900,    5000,    4750,    5000,    5750,    5400,    5950,    6350,    
        3000,    0,        7000,    5800,    6200,    6500,    5600,    5600,    5800,    30000,    33800,    
        4000,    9200,    5500,    6600,    7000,    7100,    8100,    6000,    6000,    6100,    10100,    
        5000,    3600,    5800,    6100,    6200,    7100,    6800,    8300,    5400,    8300,    10200,    
        6000,    3300,    5100,    5800,    6400,    8300,    9400,    9900,    7700,    9500,    11700,    
        7000,    4750,    5000,    6750,    7750,    9000,    10500,    15250,    9750,    11500,    13500,    
        8000,    5250,    5750,    7500,    8000,    10250,    11000,    16500,    11500,    13500,    15500,    
        9000,    6000,    6250,    8250,    8500,    8750,    11500,    11750,    14500,    15250,    57250,    
        10000,    1250,    4000,    9000,    9250,    9500,    10250,    11750,    18500,    20250,    23000,    
        11000,    5000,    7000,    7500,    8000,    8500,    9500,    13000,    14500,    17000,    24500,    
        12000,    1000,    7500,    8500,    9000,    9000,    10500,    15500,    14500,    17000,    26000,    
        13000,    5500,    8000,    9000,    10000,    11500,    10500,    20000,    22000,    25500,    27500,    
        14000,    5500,    8000,    9500,    10500,    10500,    11000,    17000,    18500,    25500,    30500,    
        15000,    1000,    8500,    10500,    11500,    11000,    12000,    19000,    26000,    29000,    31500,    
    },
        
    shape_table_data =
    {
        {
            name     = gb6_name .. '-HE',
            file     = gb6_model,
            life     = 1,
            fire     = {0, 1},
            username = gb6_name .. '-HE',
            index    = WSTYPE_PLACEHOLDER,
        },
    },
    
    fm = {
        mass                = gb6_mass,
        caliber             = 0.3,  
        cx_coeff            = {1, 0.8, 0.8, 0.15, 1.5},
        L                   = 4.5,
        I                   = 1 / 12 * gb6_mass * 4.5 * 4.5,
        Ma                  = 2,
        Mw                  = 7,
        wind_sigma          = 0.0,
        wind_time           = 0.0,
        Sw                  = 1.2,
        dCydA               = {0.07, 0.036},
        A                   = 0.15,
        maxAoa              = 0.4,
        finsTau             = 0.2,
        Ma_x                = 2,
        Ma_z                = 2,
        Mw_x                = 1.4,
        
        addDeplSw           = 0.6,
        no_wings_A_mlt      = 2,
        wingsDeplProcTime   = 5,
        wingsDeplDelay      = 9999,
        no_wings_cx_coeff   = {1, 0.5, 0.8, 0.10, 1.6},
    },
    
    simple_seeker = {
        sensitivity = 0,
        delay       = 2.5,
        FOV         = 0.6,
        maxW        = 500,
        opTime      = 9999,
    },
    
    control_block = {
        seeker_activation_dist       = 7000,
        default_cruise_height        = -1,
        obj_sensor                   = 0,
        can_update_target_pos        = 0,
        turn_before_point_reach      = 1,
        turn_hor_N                   = 2.2,
        turn_max_calc_angle_deg      = 90,
        turn_point_trigger_dist      = 100,
    },
    
    autopilot = {
        delay                       = 2.5,
        K                           = 500,
        Ki                          = 0.00005,
        Kg                          = 10,
        nw_K                        = 22,
        nw_Ki                       = 0.0,
        nw_Kg                       = 2,
        finsLimit                   = 0.8,
        useJumpByDefault            = 0,
        J_Power_K                   = 7,
        J_Diff_K                    = 4,
        J_Int_K                     = 0.0,
        J_Angle_W                   = 0.1,
        hKp_err                     = 460,
        hKp_err_croll               = 0.012,
        hKd                         = -0.008,
        max_roll                    = 1.3,
        egm_Angle_K                 = 0.2,
        egm_FinAngle_K              = 0.3,
        egm_add_power_K             = 0.2,
        wings_depl_fins_limit_K     = 0.3,
        err_new_wlos_k              = 0.84,
        err_aoaz_k                  = 28,
        err_aoaz_sign_k             = 0.18,
    },
        
    warhead     = GB6HE_warhead,
    warhead_air = GB6HE_warhead,
}

declare_weapon(GB6_HE)

declare_loadout({
    category         = CAT_BOMBS,
    CLSID            = 'DIS_GB6_HE',
    attribute        = GB6_HE.wsTypeOfWeapon,
    Count            = 1,
    Cx_pil           = 0.0024,
    Picture          = "gb6.png",
    displayName      = _(gb6_name .. '-HE'),
    Weight           = GB6_HE.mass + pylon_mass,
    Elements         = {{ShapeName = gb6_model}},
    ejectImpulse     = eject_speed * GB6_HE.mass,
    ejectDirection   = {0, -1, 0},
})

