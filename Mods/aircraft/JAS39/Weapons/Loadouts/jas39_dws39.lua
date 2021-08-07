
local DWS_39_Clusterbomb =
{
    category        = CAT_BOMBS,
	wsTypeOfWeapon	= {wsType_Weapon, wsType_Bomb, wsType_Bomb_Cluster, WSTYPE_PLACEHOLDER},	
 	type    		= 4,
    mass            = 605,
	hMin    		= 90.0,
	hMax    		= 5000.0,
	Cx      		= 0.000265,
	VyHold  		= -100.0,
	Ag      		= -1.23,
 
	name            = "jas_dws39",
    model           = "BK_90", 
	user_name       = _("DWS 39 Unguided Cluster Bomb"),
    scheme          = "bomb-cassette_new",
    class_name      = "wAmmunitionCbu",
  
    warhead = simple_warhead(0),
  
    shape_table_data =
    {
        {
            name     = jas_dws39,
            file     = "bk_90",
            life     = 1,
            fire     = {0, 1},
            username = _("DWS39"),
            index    = WSTYPE_PLACEHOLDER,
        },
    },
    
    fm = {
        mass            = 605,
        caliber         = 0.335,
        cx_coeff        = {1.0, 0.39, 0.60, 0.168, 1.31},
        L               = 2.34,
        I               = 101.298600,
        Ma              = 0.197848,
        Mw              = 1.987409,
        wind_time       = 1,
        wind_sigma      = 1,
		model_roll 		= 0, 
	},
    
    control = 
    {
		default_open_height = 457,
    },
    
	targeting_data =
	{
		char_time = 20.40,
		bomblet_char_time = 99.14,
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
                    impulse_sigma           = 1,
                    moment_sigma            = 1,
					mass            		= 605,
					caliber         		= 0.335,
					cx_coeff        		= {1.0, 0.39, 0.60, 0.168, 1.31},
					L               		= 2.34,
					I               		= 101.298600,
					Ma              		= 0.197848,
					Mw              		= 1.987409,
					wind_time       		= 1,
					wind_sigma      		= 1,
					model_roll 				= 0, 
					model_name              = "bk_90",
                    set_start_args          = {0,12,13},
                    spawn_args_change       = {{1,12,0},{1,1,0.6}},
                    spawn_time              = {0.02, 0.17, 0.32}, 
                    spawn_weight_loss       = {0, 150, 150},
                    spawn_args_change       = {{1,1,1},{1,12,0},{2,2,1}},
                    op_spawns               = 3,
                },

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
                    model_name              = "bk_90",
                    set_start_args          = {0, 1, 2},
                    spawn_options           = {{2, 2, 1}},
                },

                BLU_108 =
                {
                    op_time                 = 9000,
                    count                   = 12,
                    effect_count            = 12,
                    wind_sigma              = 1,
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
                    chute_open_time         = 0.5,
                    chute_diam              = 2,
                    chute_Cx                = 1.2,
                    chute_rnd_coeff         = 0.5,
                    spawn_options           = {{0,1,6},{0,2,6}},
        
                    submunition_engine_impulse          = 60,
                    submunition_engine_fuel_mass        = 0.1,
                    submunition_engine_work_time        = 0.22,
                    submunition_engine_rotation_moment  = 9,
                    submunition_engine_start_height     = 48,   
                    skeets_release_delay                = 1.00, 
                    skeets_in_seq_release_delay         = 0.02, 
                    main_chute_open_speed               = 4,
                    extr_chute_max_diam                 = 0.3,
                    opening_speed_k                     = 2,
                    jump_error_sum                      = 440,
                },

                BLU_108_panel =
                {
                    op_time                 = 50,
                    wind_sigma              = 1,
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

                skeet = 
                {
                    op_time                 = 9000,
                    count                   = 4,
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
                    seeker_max_angle        = 0.785,
                    seeker_max_range        = 160,  
                    seeker_activation_time  = 0.1,
                    shot_error              = 0.05, 
                    aim_lock_efficiency     = 0.9,
                    shell_speed             = 750,  
                },

                warhead = predefined_warhead("CBU97"),
            },
            
            name            = _("DWS39-MJ2"),
            type_name       = _("cluster"),
            cluster_scheme  = "AGM-154B_cluster",
        }
        )
    },
}

declare_weapon(DWS_39_Clusterbomb)

declare_loadout({
    category        = CAT_BOMBS,
    CLSID           = "{JAS39_DWS39}",
    attribute       = DWS_39_Clusterbomb.wsTypeOfWeapon,
    Count           = 1,
    Cx_pil          = DWS_39_Clusterbomb.Cx,
    Picture         = "bk90.png",
    displayName     = DWS_39_Clusterbomb.user_name,
    Weight          = DWS_39_Clusterbomb.mass,
    Elements        = {{ShapeName = "bk_90"}},
})

  