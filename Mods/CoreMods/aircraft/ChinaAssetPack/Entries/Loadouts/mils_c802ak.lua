
local c802ak_name  = 'C-802AK'
local c802ak_disp  = 'RBS-15 Mk4 AshM'
local c802ak_model = 'c802ak'
local c802ak_mass  = 715
local pylon_mass   = 50.0

local C802AK_warhead =
{
    mass                 = 165,
    caliber              = 360,
    expl_mass            = 165,
    piercing_mass        = 0.0,
    other_factors        = { 1.0, 1.0, 1.0 },
    concrete_factors     = { 3.0, 1.0, 1.0 },
    concrete_obj_factor  = 2.0,
    obj_factors          = { 3.0, 1.0 },
    cumulative_factor    = 2.0,
    cumulative_thickness = 0.0,
}

C_802AK_AS = {
    category       = CAT_MISSILES,
    name           = c802ak_name,
    user_name      = _(c802ak_disp),
    model          = c802ak_model,
    mass           = c802ak_mass,
    wsTypeOfWeapon = {wsType_Weapon,wsType_Missile,wsType_AS_Missile,WSTYPE_PLACEHOLDER},

    Escort         = 0,
    Head_Type      = 5, -- 5,
    sigma          = {8, 8, 8},
    M              = c802ak_mass,
    H_max          = 15000.0,
    H_min          = -1,
    Diam           = 360.0,
    Cx_pil         = 8,
    D_max          = 220000.0,
    D_min          = 2000.0,
    Head_Form      = 1,
    Life_Time      = 1850.0,
    Nr_max         = 15,
    v_min          = 170.0,
    v_mid          = 372.0,
    Mach_max       = 1.3,
    t_b            = 5.0,
    t_acc          = 0.0,
    t_marsh        = 1800.0,
    Range_max      = 220000.0,
    H_min_t        = 0.0,
    Fi_start       = 0.25,
    Fi_rak         = 3.14152,
    Fi_excort      = 3.14152, -- 0.35,
    Fi_search      = 99.9,
    OmViz_max      = 99.9,
    Stage_         = 1,
    Engine_Type    = 5,
    X_back         = -2.566,
    Y_back         = -0.19,
    Z_back         = 0.0,
    Reflection     = 0.09,
    KillDistance   = 0.0,

    manualWeaponFlag = 2,
    
    LaunchDistData =
    {
        -- launch altitude: 500m - 7500m
        -- http://www.sinaimg.cn/dy/slidenews/8_img/2011_45/22159_89924_239722.jpg
          12,        7,
                   100,      125,      150,      175,       200,       250,       300,
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

    warhead     = C802AK_warhead,
    warhead_air = C802AK_warhead,

    --add_attributes = {"Anti-Ship missiles"},
    add_attributes = {"Cruise missiles"},

    shape_table_data = {
        {
            name     = c802ak_name,
            file     = c802ak_model,
            life     = 0.6,
            fire     = {0, 1},
            username = c802ak_name,
            index    = WSTYPE_PLACEHOLDER,
        },
    },

    --
    --scheme          = "anti_ship_missile_prog_path_stpos_ctrl",
    scheme            = "Harpoon",
    class_name        = "wAmmunitionAntiShip",

    fm = {
        mass        = c802ak_mass,
        caliber     = 0.36,
        cx_coeff    = {1, 0.3, 0.65, 0.018, 1.6},
        L           = 5.145,
        I           = 1 / 12 * c802ak_mass * 5.145 * 5.145,
        Ma          = 0.6,
        Mw          = 1.116,
        wind_sigma  = 0.0,
        wind_time   = 1000.0,
        Sw          = 0.7,
        dCydA       = {0.07, 0.036},
        A           = 0.5,
        maxAoa      = 0.3,
        finsTau     = 0.05,
        Ma_x        = 3,
        Ma_z        = 3,
        Kw_x        = 0.05,
    },

    seeker = {
        delay                       = 0.0,
        op_time                     = 9999.0,
        FOV                         = math.rad(60.0),
        max_w_LOS                   = 0.06,
        max_target_speed            = 33.0,
        max_target_speed_rnd_coeff  = 10.0,
        ship_track_by_default       = 1,
        flag_dist                   = 5000.0,
        sens_near_dist              = 10.0,
        sens_far_dist               = 16000.0,
        primary_target_filter       = 1,
        add_y                       = 3.0,
        sens_ref_rcs                = 10000.0,
        sens_ref_dist               = 32000.0,
        ship_l_error_k              = 0.33,
        
        min_detectable_rcs          = 50.0,
        max_small_target_rcs        = 29999.999,
        min_large_target_rcs        = 60000.0,
    },

    autopilot =    --inertial autopilot + horiz correction when seeker is on
    {
        glide_height                = 20.0,
        dont_climb_on_cruise_height = 1,
        vel_proj_div                = 6.0,
        default_glide_height        = 1524,
        pre_maneuver_glide_height   = 12,
        skim_glide_height           = 8,
        use_start_bar_height        = 1,    
        altim_vel_k                 = 4,
        min_glide_height            = 15,
        
        delay                  = 1.0,
        op_time                = 9999,
        Kw                     = 3.5,
        Ks                     = 0.9,
        K                      = 1.6,
        Kd                     = 0.0,
        Ki                     = 20.0,--10
        Kx                     = 0.04,
        Kdx                    = 0.001,
        w_limit                = math.rad(5),
        fins_limit             = math.rad(50),
        fins_limit_x           = math.rad(25),
        rotated_WLOS_input     = 0,
        conv_input             = 0,
        PN_dist_data           = {2000,    0,
                                   500,    0},
                                
        max_climb_angle        = math.rad(10),
        max_dive_angle         = math.rad(-25),
        max_climb_ang_hdiff    = 200,
        max_dive_ang_hdiff     = -500,
        
        Ksd                    = 0.0,
        Ksi                    = 0.0,
        integr_val_limit       = 0.5,
        hor_err_limit          = 0.5,
        max_climb_vel          = 200,
        min_climb_vel          = 120,
        min_climb_vel_factor   = 0,
        max_climb_h            = 3000,
        min_climb_h            = 10000,
        min_climb_h_factor     = 0.5,
        
        inertial_km_error      = 0.15,
        glide_height_eq_error  = 0.02, -- percent
        glide_height_abs_error = 1.5,
    },

    final_autopilot =        -- final stage guidance with terminal maneuver
    {
        delay                  = 1.0,
        op_time                = 9999,
        Kw                     = 1.0,
        Ks                     = 5.0,
        K                      = 5.4,
        Kd                     = 0.0,
        Ki                     = 0.0,
        Kx                     = 0.0,
        Kix                    = 0.0,
        w_limit                = math.rad(15),
        fins_limit             = math.rad(50),
        rotated_WLOS_input     = 0,
        conv_input             = 0,
        PN_dist_data           = {2000,    1,
                                   500,    1},
                                
        add_err_val            = 0,
        add_err_vert           = 0,
        add_out_val            = 0.1,
        add_out_vert           = 1,
        loft_angle             = math.rad(8),
        loft_trig_angle        = math.rad(14),
        K_loft_err             = 1,
        loft_angle_vert        = 1,
        loft_active_by_default = 0,
    },

    triggers_control = {
        sensor_tg_dist           = 8000, -- turn on seeker and start horiz. correction if target is locked
        final_maneuver_tg_dist   = 4000,
        straight_nav_tg_dist     = 2000,
        self_destruct_tg_dist    = 4000,    -- if seeker still can not find a target explode warhead after reaching pred. target point + n. km
        target_upd_jump_dist     = 20000,
        update_pos_from_input    = 0,
        can_increase_tg_dist     = 1,
        
        send_final_maneuver_by_default  = 0,
        final_maneuver_trig_v_lim       = 3,
        use_horiz_dist                  = 1,
        pre_maneuver_glide_height       = 20,
        
        check_self_destruct_dist_with_no_target = 1,
    },

    controller = {
        boost_start = 0,
        march_start = 5.0,
    },

    boost = {    --    air launch - no booster
        impulse                          = 0,
        fuel_mass                        = 0,
        work_time                        = 0,
        boost_time                       = 0,
        boost_factor                     = 0,
        nozzle_position                  = {{0, 0, 0}},
        nozzle_orientationXYZ            = {{0, 0, 0}},
        tail_width                       = 0.0,
        smoke_color                      = {0.0, 0.0, 0.0},
        smoke_transparency               = 0.0,
        custom_smoke_dissipation_factor  = 0.0,
    },

    march = {
        impulse          = 700,
        fuel_mass        = 200,
        work_time        = 9999,
        min_fuel_rate    = 0.005,
        min_thrust       = 0,
        max_thrust       = 6000,
        thrust_Tau       = 0.0017,

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

    engine_control = {
        default_speed    = 300,
        K                = 265,
        Kd               = 0.01,
        Ki               = 0.001,
        speed_delta      = 5,
        --burst_signal     = 9999, -- used in 'anti_ship_missile_tb' scheme
    },

}

declare_weapon(C_802AK_AS)

declare_loadout({
    category     = CAT_MISSILES,
    CLSID        = 'DIS_C-802AK',
    Picture      = 'c802.png',
    attribute    = C_802AK_AS.wsTypeOfWeapon,
    -- attribute    = "weapons.missiles.C_802AK",
    displayName  = _(c802ak_disp),
    Cx_pil       = 0.0023,
    Count        = 1,
    Weight       = c802ak_mass + pylon_mass,
    Elements     = {
        [1] =
        {
            Position  = {0, 0, 0},
            ShapeName = c802ak_model,
            DrawArgs  = {
                [1] = {1, 1.0},
            }
        },
    }, -- end of Elements
    --attribute = {4, 4, 8, WSTYPE_PLACEHOLDER, "Anti-Ship missiles"},
    ejectImpulse   = eject_speed * c802ak_mass,
    ejectDirection = {0, -1, 0},
})





-- YJ-83K
local yj83k_name  = 'YJ-83K'
local yj83k_model = 'yj83k'
local yj83k_mass  = 715

YJ83K_AS = {}
copyTable(YJ83K_AS, C_802AK_AS)
YJ83K_AS.name           = yj83k_name
YJ83K_AS.model          = yj83k_model
YJ83K_AS.mass           = yj83k_mass
YJ83K_AS.user_name      = _(yj83k_name)
YJ83K_AS.wsTypeOfWeapon = {wsType_Weapon,wsType_Missile,wsType_AS_Missile,WSTYPE_PLACEHOLDER}
YJ83K_AS.shape_table_data[1].name     = yj83k_name
YJ83K_AS.shape_table_data[1].file     = yj83k_model
YJ83K_AS.shape_table_data[1].username = yj83k_name
YJ83K_AS.shape_table_data[1].index    = WSTYPE_PLACEHOLDER
declare_weapon(YJ83K_AS)



declare_loadout({
    category     = CAT_MISSILES,
    CLSID        = 'DIS_YJ83K',
    Picture      = 'yj83.png',
    attribute    = YJ83K_AS.wsTypeOfWeapon,
    displayName  = _(yj83k_name),
    Cx_pil       = 0.0023,
    Count        = 1,
    Weight       = yj83k_mass,
    Elements     = {
        {
            ShapeName = yj83k_model,
            DrawArgs  = {
                [1] = {1, 1.0},
            }
        },
    }, -- end of Elements
    ejectImpulse   = eject_speed * yj83k_mass,
    ejectDirection = {0, -1, 0},
})

declare_loadout({
    category       = CAT_MISSILES,
    CLSID          = 'DIS_GDJ_YJ83K',
    Picture        = 'yj83.png',
    wsTypeOfWeapon = YJ83K_AS.wsTypeOfWeapon,
    attribute      = {4, 4, 32, WSTYPE_PLACEHOLDER},
    displayName    = _(yj83k_name),
    Cx_pil         = 0.0023,
    Count          = 1,
    Weight         = yj83k_mass + pylon_mass,
    Elements       = {
        {
            ShapeName = "adapter_gdj_yj83k",
            IsAdapter = true,
        },
        {
            ShapeName = yj83k_model,
            connector_name = "adapter_cnt",
            DrawArgs  = {
                [1] = {1, 1.0},
            }
        },
    }, -- end of Elements
    JettisonSubmunitionOnly = true,
    ejectImpulse   = eject_speed * yj83k_mass,
    ejectDirection = {0, -1, 0},
})
