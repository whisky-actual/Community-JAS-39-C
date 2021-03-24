
local gbu31_name = 'GBU-31'
local gbu31_mass = 934.0
local pylon_mass = 1.0

GBU_31 =
{
    category        = CAT_MISSILES,
    name            = gbu31_name,
    user_name       = _(gbu31_name),
    scheme          = "AGM-154C",
    class_name      = "wAmmunitionCruise",
    model           = "gbu-31",
    mass            = gbu31_mass,
    
    wsTypeOfWeapon  = {wsType_Weapon,wsType_Missile,wsType_AS_Missile,WSTYPE_PLACEHOLDER},

    Escort          = 0,
    Head_Type       = 5,
    sigma           = {7, 7, 7},
    M               = gbu31_mass,
    H_max           = 15000.0,
    H_min           = 400.0,
    Diam            = 457.0,
    Cx_pil          = 6,
    D_max           = 30000.0,
    D_min           = 1000.0,
    Head_Form       = 1,
    Life_Time       = 9999,
    Nr_max          = 10,
    v_min           = 10.0,
    v_mid           = 200.0,
    Mach_max        = 1.7,
    t_b             = 0.0,
    t_acc           = 0.0,
    t_marsh         = 0.0,
    Range_max       = 70000.0,
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
			19,		8,

					100,	150,	200,	250,	300,	350,	400,	450,		
			100,	0,		0,		3000,	5550,	7575,	8375,	8975,	9025,	
			200,	0,		0,		3625,	6350,	8400,	9750,	10425,	11100,	
			400,	0,		0,		4325,	7200,	9175,	10525,	11450,	12250,	
			700,	0,		0,		5500,	8325,	10325,	11600,	12500,	13275,	
			1000,	0,		0,		6600,	9400,	11400,	12600,	13550,	14300,	
			2000,	2450,	7000,	10450,	13150,	14950,	16150,	17000,	17750,	
			3000,	4800,	10900,	14300,	16900,	18600,	19700,	20400,	21200,	
			4000,	6100,	14400,	18100,	20800,	22300,	23300,	24100,	24800,	
			5000,	7100,	17200,	21900,	24600,	26200,	27100,	27800,	28500,	
			6000,	8100,	17200,	25500,	28600,	30000,	30900,	31600,	32400,	
			7000,	8750,	17250,	28750,	32500,	33750,	34750,	35500,	36000,	
			8000,	9500,	17500,	32250,	36250,	37750,	38500,	39250,	40250,	
			9000,	10250,	17750,	35250,	39500,	41750,	42500,	43250,	44250,	
			10000,	10750,	18000,	38000,	42500,	45500,	46500,	47250,	48250,	
			11000,	11000,	18000,	39500,	45000,	48500,	50500,	51000,	52500,	
			12000,	11500,	18000,	34500,	47000,	51500,	54000,	55000,	56500,	
			13000,	11000,	18000,	31000,	49000,	53000,	57000,	59000,	60000,	
			14000,	12000,	18000,	29000,	51000,	55000,	59000,	63000,	64000,	
			15000,	12000,	18000,	28000,	48000,	57000,	61000,	66000,	68000,	
		},
       
    shape_table_data =
    {
        {
            name     = gbu31_name,
            file     = "gbu-31",
            life     = 1,
            fire     = { 0, 1},
            username = gbu31_name,
            index    = WSTYPE_PLACEHOLDER,
        },
    },
    
    fm =    {
        mass                = gbu31_mass,  
        caliber             = 0.457,								--0.377,  
        cx_coeff            = {1, 0.45, 0.8, 0.15, 1.55},			--{1, 0.3, 0.65, 0.010, 1.6},
        L                   = 3.09,
        I                   = 1 / 12 * gbu31_mass * 3.09 * 3.09,
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
        
    warhead     = simple_warhead(850, 457),
    warhead_air = simple_warhead(850, 457),
}

declare_weapon(GBU_31)

declare_loadout({
    category         = CAT_MISSILES,
    CLSID            = 'JAS_GB6_TSP',
    attribute        = GBU_31.wsTypeOfWeapon,
    Count            = 1,
    Cx_pil           = 0.00264,
    Picture          = "gbu31.png",
    displayName      = _(gbu31_name),
    Weight           = GBU_31.mass + pylon_mass,
    Elements         = {
        [1] = {
            ShapeName = "gbu-31",
            DrawArgs  = {
                [1] = {2, 1.0},
            }
        }
    },
    ejectImpulse     = 140,
})
