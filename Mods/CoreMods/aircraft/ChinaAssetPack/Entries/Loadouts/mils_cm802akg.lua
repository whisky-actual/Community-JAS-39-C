
local cm802akg_use_scheme  = 0
local cm802akg_scheme_type = 1

local cm802akg_name  = 'CM-802AKG'
local cm802akg_disp  = 'KEPD 350 Long Range Cruise-missle'
local cm802akg_model = 'cm802akg'
local cm802akg_mass  = 715
local pylon_mass     = 50.0

local C802AKG_warhead =
{
    mass                 = 165, 
    caliber              = 360,
    expl_mass            = 100,
    piercing_mass        = 0.0,
    other_factors        = { 1.0, 1.0, 1.0 },
    concrete_factors     = { 3.0, 1.0, 5.0 },
    concrete_obj_factor  = 2.0,
    obj_factors          = { 2.0, 1.0 },
    cumulative_factor    = 2.0,
    cumulative_thickness = 0.0,
}


CM_802AKG_AS = {
    category        = CAT_MISSILES,
    name            = cm802akg_name,
    model           = cm802akg_model,
    user_name       = _(cm802akg_disp),
    mass            = cm802akg_mass,
    wsTypeOfWeapon  = {wsType_Weapon,wsType_Missile,wsType_AS_Missile,WSTYPE_PLACEHOLDER},
    add_attributes  = {"Cruise missiles"},

    Escort          = 1,
    Head_Type       = 8, -- TV
    sigma           = {8, 8, 8},
    M               = cm802akg_mass,

    H_max           = 10000.0,
    H_min           = -1,
    Diam            = 343.0,
    Cx_pil          = 1,
    D_max           = 220000.0,
    D_min           = 2000.0,
    Head_Form       = 0,
    Life_Time       = 9999999999.0,
    Nr_max          = 15,
    v_min           = 270.0,
    v_mid           = 372.0,
    Mach_max        = 1.3,
    t_b             = 5.0,
    t_acc           = 0.0,
    t_marsh         = 1000.0,
    Range_max       = 220000.0,
    H_min_t         = 0.0,
    Fi_start        = 0.25,
    Fi_rak          = 3.14152,
    Fi_excort       = 3.14152,--0.35,
    Fi_search       = 99.9,
    OmViz_max       = 99.9,
    Stage_          = 1,
    Engine_Type     = 5,
    X_back          = -2.566,
    Y_back          = -0.19,
    Z_back          = 0.0,
    Reflection      = 0.09,
    KillDistance    = 0.0,

    warhead     = C802AKG_warhead,
    warhead_air = C802AKG_warhead,

    shape_table_data = {
        {
            name     = cm802akg_name,
            file     = cm802akg_model,
            life     = 1,
            fire     = {0, 1},
            username = cm802akg_name,
            index    = WSTYPE_PLACEHOLDER,
        },
    },

    LaunchDistData =
    {
    -- launch altitude: 500m - 7500m for C-802A
    -- http://www.sinaimg.cn/dy/slidenews/8_img/2011_45/22159_89924_239722.jpg
        12,        7,

                    100,         125,       150,         175,        200,       250,          300,
         500,    150000,      155000,    160000,      165000,     170000,    175000,       180000,
         600,    152000,      157000,    162000,      167000,     172000,    177000,       182000,
         700,    154000,      159000,    164000,      169000,     174000,    179000,       184000,
         800,    156000,      161000,    166000,      171000,     176000,    181000,       186000,
         900,    158000,      163000,    168000,      173000,     178000,    183000,       188000,
        1000,    160000,      165000,    170000,      175000,     180000,    185000,       190000,
        1200,    163000,      168000,    173000,      178000,     183000,    188000,       193000,
        2200,    170000,      175000,    180000,      185000,     189000,    194000,       199000,
        3200,    176000,      181000,    186000,      191000,     194000,    199000,       204000,
        4200,    181000,      186000,    191000,      196000,     199000,    203000,       208000,
        5200,    185000,      190000,    195000,      199000,     203000,    207000,       212000,
        7500,    190000,      195000,    200000,      204000,     208000,    212000,       217000,
    },

    MinLaunchDistData =
    {
        20,        7,

                    100,      150,      200,      250,      300,      350,      400,   
          500,        0,    14540,     7320,    11250,     8260,     8680,     8970,    
          600,        0,    11400,     7290,     7780,     8230,     8650,     9040,    
          700,        0,     7410,     7410,     7890,     8350,     8770,     9160,    
          800,        0,     7800,     7525,     8025,     8475,     8900,     9300,    
          900,        0,     8325,     7650,     8125,     8575,     9025,     9425,    
         1000,        0,     9325,     7725,     8225,     8675,     9100,     9500,    
         2000,        0,     9200,     8100,     8250,     8825,     9225,     9725,    
         3000,     6050,     6900,     7650,     8200,     8550,     8950,     9350,    
         4000,     6350,     7000,     7500,     7950,     8300,     8650,     9000,    
         5000,     6600,     7300,     7100,     8000,     8500,     8800,     9200,    
         6000,    12750,     7500,     7250,     8250,     8750,     9000,     9500,    
         7000,    13250,     7750,     7250,     8500,     8750,     9250,     9750,    
         8000,    14250,     8250,     8500,     8750,     9250,     9500,    10000,    
         9000,    15000,    14000,     8750,     9250,     9500,    10000,    10500,    
        10000,    16000,    14750,     9250,     9500,    10000,    10250,    10750,    
        11000,    17000,    16000,    14500,    10500,    11000,    11000,    11500,    
        12000,    18500,    17500,    16000,    11000,    11500,    12000,    12500,    
        13000,    19500,    19000,    18000,    16500,    12500,    19500,    22500,    
        14000,    21000,    20500,    20000,    19000,    18000,    27000,    30000,    
        15000,    22500,    22500,    22000,    22000,    31000,    35500,    39000,    
    },
}

cm802akg_scheme_data_e = {

    scheme     = "AGM-84E",
    class_name = "wAmmunitionAntiShip",

    controller = {
        boost_start = 0.0,
        march_start = 5.0,
    },

    control_block = {
        default_cruise_height = 1000.0,
    },

    boost = { -- air launch - no booster
        impulse                             = 0,
        fuel_mass                           = 0,
        work_time                           = 0,
        boost_time                          = 0,
        boost_factor                        = 0,
        nozzle_position                     = {{0, 0, 0}},
        nozzle_orientationXYZ               = {{0, 0, 0}},
        tail_width                          = 0.0,
        smoke_color                         = {0.0, 0.0, 0.0},
        smoke_transparency                  = 0.0,
        custom_smoke_dissipation_factor     = 0.0,
    },

    march = {
        impulse           = 660,
        fuel_mass         = 180,
        work_time         = 9999,
        min_fuel_rate     = 0.005,
        min_thrust        = -100,
        max_thrust        = 5000,
        thrust_Tau        = 0.0017,
        
        nozzle_position                  = {{-2.566, -0.19, 0.0}},
        nozzle_orientationXYZ            = {{0.0, 0.0, 0.0}},
        tail_width                       = 0.5,
        smoke_color                      = {0.0, 0.0, 0.0},
        smoke_transparency               = 0.2,
        custom_smoke_dissipation_factor  = 0.2,

        start_burn_effect           = 1,
        start_effect_delay          = {0.0,     0.3,    0.8},
        start_effect_time           = {0.7,     1.0,    0.1},
        start_effect_size           = {0.09,    0.104,  0.11},
        start_effect_smoke          = {0.01,    0.4,    0.01},
        start_effect_x_pow          = {1.0,     1.0,    1.0},
        start_effect_x_dist         = {1.1,     0.9,    0.0},
        start_effect_x_shift        = {0.15,    0.15,   0.2},
    },

    engine_control = {
        default_speed   = 220,
        K               = 350,
        Kd              = 1.0,
        Ki              = 0.001,
        speed_delta     = 5,
    },

    fm = {
        mass        = cm802akg_mass,
        caliber     = 0.36,
        cx_coeff    = {1, 0.3, 0.65, 0.018, 1.6},
        L           = 5.145,
        I           = 1 / 12 * cm802akg_mass * 5.145 * 5.145,
        Ma          = 0.6,    --y
        Mw          = 1.116,
        wind_sigma  = 0.0,
        wind_time   = 1000.0,
        Sw          = 0.75,
        dCydA       = {0.07, 0.036},
        A           = 0.08,
        maxAoa      = 0.3,
        finsTau     = 0.05,
        Ma_x        = 3,
        Ma_z        = 3,
        Mw_x        = 2.6,
    },

    seeker = {
        delay               = 0.0,
        op_time             = 800,
        activate_on_update  = 1,

        FOV                 = math.rad(60),

        max_target_speed            = 33,
        max_target_speed_rnd_coeff  = 10,

        max_lock_dist       = 30000,
    },

    ins = {
        aim_sigma       = 350,
        check_AI        = 1,
        error_coeff     = 0.04,
    },

    autopilot =
    {
        glide_height                = 1000.0,
        dont_climb_on_cruise_height = 0,
        vel_proj_div                = 6.0,
        default_glide_height        = 1000.0,
        pre_maneuver_glide_height   = 1000.0,
        skim_glide_height           = 8,
        use_start_bar_height        = 1,
        altim_vel_k                 = 4,

        delay               = 1.0,
        op_time             = 9999,
        Kw                  = 1.6,
        Ks                  = 2.0,
        K                   = 1.7,
        Kd                  = 0.0,
        Ki                  = 16.0,
        Kx                  = 0.04,
        Kdx                 = 0.001,
        w_limit             = math.rad(5),
        fins_limit          = math.rad(35),
        fins_limit_x        = math.rad(20),
        rotated_WLOS_input  = 0,
        conv_input          = 0,
        PN_dist_data        = { 2000,   0,
                                500,    0},

        max_climb_angle     = math.rad(10),
        max_dive_angle      = math.rad(-25),
        max_climb_ang_hdiff = 200,
        max_dive_ang_hdiff  = -500,

        Ksd                     = 0.0,
        Ksi                     = 0.0,
        integr_val_limit        = 0.5,
        hor_err_limit           = 0.5,
        max_climb_vel           = 200,
        min_climb_vel           = 120,
        min_climb_vel_factor    = 0,
        max_climb_h             = 3000,
        min_climb_h             = 10000,
        min_climb_h_factor      = 0.5,
        
        inertial_km_error       = 4.0,
        glide_height_eq_error   = 0.02,
        
        --min_climb_vel         = 165,
        --cruise_climb_vel      = 205,
        
        vert_ctrl_data      = { 100,    math.rad(-24),
                                115,    math.rad(-16),
                                130,    math.rad(-8),
                                145,    math.rad(0),
                                185,    math.rad(10),   },
    },

    final_autopilot = {
        delay               = 1.0,
        op_time             = 9999,
        Kw                  = 1.0,
        Ks                  = 5.0,
        K                   = 5.4,
        Kd                  = 0.0,
        Ki                  = 0.0,
        Kx                  = 0.0,
        Kix                 = 0.0,
        w_limit             = math.rad(15),
        fins_limit          = math.rad(50),
        rotated_WLOS_input  = 0,
        conv_input          = 0,
        PN_dist_data        = { 2000,   1,
                                500,    1},

        add_err_val             = 0,
        add_err_vert            = 0,
        add_out_val             = 0.1,
        add_out_vert            = 1,
        loft_angle              = math.rad(7),
        loft_trig_angle         = math.rad(12),
        K_loft_err              = 1,
        loft_angle_vert         = 1,
        loft_active_by_default  = 0,
    },

    triggers_control = {
        action_wait_timer               = 5,    -- wait for dist functions n sen, then set default values
        default_sensor_tg_dist          = 10000, -- turn on seeker and start horiz. correction if target is locked
        default_final_maneuver_tg_dist  = 7000,
        default_straight_nav_tg_dist    = 7000,
        default_destruct_tg_dist        = 3000, -- if seeker still can not find a target explode warhead after reaching pred. target point + n. km
        trigger_by_path                 = 1,
        final_maneuver_trig_v_lim       = 3,
        use_horiz_dist                  = 1,
        pre_maneuver_glide_height       = 1000, -- triggers st nav instead of fin. maneuver if h>2*pre_maneuver_glide_height at fin. maneuver distance
        min_cruise_height               = 1000,
        min_cruise_height_trigger_sum   = 11000,
        min_cruise_height_trigger_mlt   = 220/33,
    },
}

cm802akg_scheme_data_h = {

    scheme     = "sat_cruise_missile",
    class_name = "wAmmunitionAntiShip",

    controller = {
        boost_start = 0.0,
        march_start = 5.0,
    },
    
    control_block = {
        seeker_activation_dist      = 20000,
        default_cruise_height       = 200,
        obj_sensor                  = 0,
        can_update_target_pos       = 1,
        turn_before_point_reach     = 1,
        turn_hor_N                  = 0.8,
        turn_max_calc_angle_deg     = 90,
        turn_point_trigger_dist     = 100,
        use_horiz_dist              = 1,
    },

    boost = { -- air launch - no booster
        impulse                              = 0,
        fuel_mass                            = 0,
        work_time                            = 0,
        boost_time                           = 0,
        boost_factor                         = 0,
        nozzle_position                      = {{0, 0, 0}},
        nozzle_orientationXYZ                = {{0, 0, 0}},
        tail_width                           = 0,
        smoke_color                          = {0.0, 0.0, 0.0},
        smoke_transparency                   = 0.0,
        custom_smoke_dissipation_factor      = 0.0,
    },

    booster_animation = {
        start_val = 0,
    },
    
    play_booster_animation = {
        val = 0,
    },
    
    march = {
        impulse           = 660,
        fuel_mass         = 180,
        work_time         = 9999,
        min_fuel_rate     = 0.005,
        min_thrust        = -100,
        max_thrust        = 5000,
        thrust_Tau        = 0.0017,

        nozzle_position                  = {{-2.566, -0.19, 0.0}},
        nozzle_orientationXYZ            = {{0.0, 0.0, 0.0}},
        tail_width                       = 0.5,
        smoke_color                      = {0.0, 0.0, 0.0},
        smoke_transparency               = 0.2,
        custom_smoke_dissipation_factor  = 0.2,

        start_burn_effect           = 0,
        start_effect_delay          = {0.0,   0.3,    0.8},
        start_effect_time           = {0.7,   1.0,    0.1},
        start_effect_size           = {0.09,  0.104,  0.11},
        start_effect_smoke          = {0.01,  0.4,    0.01},
        start_effect_x_pow          = {1.0,   1.0,    1.0},
        start_effect_x_dist         = {1.1,   0.9,    0.0},
        start_effect_x_shift        = {0.15,  0.15,   0.2},
    },

    fm = {
        mass        = cm802akg_mass,  
        caliber     = 0.36,  
        cx_coeff    = {1, 0.3, 0.65, 0.018, 1.6},
        L           = 5.145,
        I           = 1 / 12 * cm802akg_mass * 5.145 * 5.145,
        Ma          = 0.6,    --y
        Mw          = 1.116,
        wind_sigma  = 0.0,
        wind_time   = 1000.0,
        Sw          = 0.75,
        dCydA       = {0.07, 0.036},
        A           = 0.08,
        maxAoa      = 0.3,
        finsTau     = 0.05,
        Ma_x        = 3,
        Ma_z        = 3,
        Kw_x        = 0.01,
        
        addDeplSw           = 0.6,
        no_wings_A_mlt      = 7,
        wingsDeplProcTime   = 5,
        wingsDeplDelay      = 1,
    },
    
    seeker = {
        coalition               = 2,
        coalition_rnd_coeff     = 5.0,
        can_update_target_pos   = 1,
    },

    final_autopilot = {
        delay               = 0,
        K                   = 60,
        Ki                  = 0,
        Kg                  = 4,
        finsLimit           = 0.8,
        useJumpByDefault    = 0,
        J_Power_K           = 1.5,
        J_Diff_K            = 0.4,
        J_Int_K             = 0,
        J_Angle_K           = 0.18,
        J_FinAngle_K        = 0.32,
        J_Angle_W           = 0.8,
        J_Trigger_Vert      = 1,
        hKp_err             = 120,
        hKp_err_croll       = 0.04,
        hKd                 = 0.005,
        max_roll            = 0.8,
    },

    cruise_autopilot = {
        delay               = 1,
        Kp_hor_err          = 240,
        Kp_hor_err_croll    = 0.06,
        Kd_hor              = 0,
        Kp_ver              = 9,
        Kii_ver             = 0.2,
        Kd_ver              = 0,
        Kp_eng              = 265,
        Ki_eng              = 0.003,
        Kd_eng              = 0,
        Kp_ver_st1          = 0.009,
        Kd_ver_st1          = 0.015,
        Kp_ver_st2          = 0.00018,
        Kd_ver_st2          = 0.00005,
        
        auto_terrain_following          = 1,
        auto_terrain_following_height   = 50,
        
        alg_points_num          = 7,
        alg_calc_time           = 1.5,
        alg_vel_k               = 6,
        alg_div_k               = 2,
        alg_max_sin_climb       = 0.8,
        alg_section_temp_points = 3,
        alg_tmp_point_vel_k     = 1.5,
        no_alg_vel_k            = 10,
        
        max_roll            = 0.8,
        max_start_y_vel     = 35,
        stab_vel            = 237.5,
        finsLimit           = 0.8,
        estimated_N_max     = 6,
        eng_min_thrust      = -100,
        eng_max_thrust      = 3000,
    },
}


if cm802akg_use_scheme == 1 then
    CM_802AKG_AS.Escort     = 0
    CM_802AKG_AS.Head_Type  = 5 -- TV
    if cm802akg_scheme_type == 0 then
        copyTable(CM_802AKG_AS, cm802akg_scheme_data_e)
    else
        copyTable(CM_802AKG_AS, cm802akg_scheme_data_h)
    end
end

declare_weapon(CM_802AKG_AS)

declare_loadout({
    category     = CAT_MISSILES,
    CLSID        = 'DIS_CM-802AKG',
    Picture      = 'c802akg.png',
    attribute    = CM_802AKG_AS.wsTypeOfWeapon,
    displayName  = _(cm802akg_disp),
    Cx_pil       = 0.0023,
    Count        = 1,
    Weight       = cm802akg_mass + pylon_mass,
    Elements     = {
        [1] =
        {
            Position  = {0, 0, 0},
            ShapeName = cm802akg_model,
            DrawArgs  = {
                [1] = {1, 1.0},
            }
        },
    }, -- end of Elements
    --Required     = {"DIS_AKG_DLPOD"},
    ejectImpulse   = eject_speed * cm802akg_mass,
    ejectDirection = {0, -1, 0},
})


------- CM-802AKG for AI only -------

local cm802akg_ai_name  = 'CM-802AKG_AI'
local cm802akg_ai_disp  = 'CM802AKG (DIS) for AI'

CM802AKG_AI = {}
copyTable(CM802AKG_AI, CM_802AKG_AS)
CM802AKG_AI.name           = cm802akg_ai_name
CM802AKG_AI.user_name      = _(cm802akg_ai_disp)
CM802AKG_AI.Escort         = 0
CM802AKG_AI.Head_Type      = 5 -- TV
CM802AKG_AI.wsTypeOfWeapon = {wsType_Weapon,wsType_Missile,wsType_AS_Missile,WSTYPE_PLACEHOLDER}
CM802AKG_AI.shape_table_data[1].name     = cm802akg_ai_name
CM802AKG_AI.shape_table_data[1].username = cm802akg_ai_name
CM802AKG_AI.shape_table_data[1].index    = WSTYPE_PLACEHOLDER

if cm802akg_scheme_type == 0 then
    copyTable(CM802AKG_AI, cm802akg_scheme_data_e)
else
    copyTable(CM802AKG_AI, cm802akg_scheme_data_h)
end

declare_weapon(CM802AKG_AI)

declare_loadout({
    category     = CAT_MISSILES,
    CLSID        = 'DIS_CM-802AKG_AI',
    Picture      = 'c802akg.png',
    attribute    = CM802AKG_AI.wsTypeOfWeapon,
    displayName  = _(cm802akg_ai_disp),
    Cx_pil       = 0.0023,
    Count        = 1,
    Weight       = cm802akg_mass + pylon_mass,
    Elements     = {
        [1] =
        {
            Position  = {0, 0, 0},
            ShapeName = cm802akg_model,
            DrawArgs  = {
                [1] = {1, 1.0},
            }
        },
    }, -- end of Elements
    ejectImpulse   = eject_speed * cm802akg_mass,
    ejectDirection = {0, -1, 0},
})
