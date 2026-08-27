local MAR_warhead = 
{
    mass                 = 90, 
    caliber              = 231,
    expl_mass            = 90,
    piercing_mass        = 0.0,					
    other_factors        = { 1.0, 1.0, 1.0 },	
    concrete_factors     = { 1.0, 1.0, 1.0 },
    concrete_obj_factor  = 1.0,
    obj_factors          = { 2.0, 1.0 },
    cumulative_factor    = 2.0,
    cumulative_thickness = 0.0, 
}
local mass = 200.0

local mar1 = {

	category		= CAT_MISSILES,
	name			= "mar1",
	user_name		= _("MAR-1 High Speed Anti-Radiation Missile"),
	wsTypeOfWeapon 	= {wsType_Weapon, wsType_Missile, wsType_AS_Missile, WSTYPE_PLACEHOLDER},
	scheme			= "anti_rad_missile",              
	class_name		= "wAmmunitionAntiRad",                          
	model			= "jas39_mar1",
	mass 			= mass,
      
        Escort = 0,
        Head_Type = 3,
		sigma = {10, 10, 10},
        M = mass,
        H_max = 25000.0,
        H_min = -1,
        Diam = 231.0,
        Cx_pil = 2,
        D_max = 90000.0,
        D_min = 2000.0,
        Head_Form = 0,
        Life_Time = 400.0,
        Nr_max = 25,
        v_min = 140.0,
        v_mid = 900.0,
        Mach_max = 3.0,
        t_b = 0.0,
        t_acc = 5.0,
        t_marsh = 15.0,
        Range_max = 90000.0,
        H_min_t = 0.0,
        Fi_start = 0.5236,
        Fi_rak = 3.14152,
        Fi_excort = 1.05,
        Fi_search = 1.05,
        OmViz_max = 0.52,
        X_back = -1.3,
        Y_back = -0.50,
        Z_back = 0.0,
        Reflection = 0.09,
        KillDistance = 7.0,
	 
	shape_table_data =
	{
		{
			name	 = "mar1",
			file	 = "jas39_mar1",
			life	 = 1,
			fire	 = { 0, 1},
			username = _("MAR1"),
			index	 = WSTYPE_PLACEHOLDER,			
		},
	},

	LaunchDistData =
	{
		19,		8,

				100,	150,	200,	250,	300,	350,	400,	450,		
		100,	9650,	11460,	12150,	12320,	11970,	12020,	12050,	14660,	
		200,	14820,	15710,	16630,	17450,	18170,	18330,	19070,	19230,	
		400,	18710,	19580,	20350,	21100,	21670,	21680,	22380,	22390,	
		700,	20590,	21490,	22360,	23060,	23070,	23740,	24360,	24370,	
		1000,	22800,	23625,	24400,	24875,	24875,	25575,	26200,	26225,	
		2000,	28975,	29850,	30700,	31200,	31225,	31775,	32600,	32375,	
		3000,	32500,	33475,	34325,	34700,	34725,	35325,	35875,	35875,	
		4000,	36100,	36925,	37775,	38325,	38150,	38800,	39425,	39425,	
		5000,	39650,	40500,	41300,	41950,	42100,	42200,	42900,	42900,	
		6000,	43250,	44100,	45000,	45800,	45800,	45850,	46700,	46750,	
		7000,	46800,	47700,	48600,	49400,	49600,	49600,	50200,	51000,	
		8000,	50500,	51000,	52000,	53000,	53500,	53500,	53750,	54500,	
		9000,	54000,	55000,	55750,	56750,	57750,	58000,	58000,	58250,	
		10000,	57750,	58750,	59750,	60500,	61500,	62500,	62500,	62500,	
		11000,	61750,	62750,	63500,	64500,	65500,	66250,	66750,	66750,	
		12000,	65750,	66750,	67750,	68500,	69500,	70250,	71250,	72000,	
		13000,	69500,	70500,	71500,	72500,	73000,	74000,	75000,	76000,	
		14000,	73500,	74500,	75500,	76500,	77500,	78500,	79500,	80500,	
		15000,	78000,	79000,	79500,	80500,	81500,	82500,	83500,	90000,
	},

	
	fm = {
        mass                = mass,
        caliber             = 0.203,
        wind_sigma          = 0.0,
        wind_time           = 0.0,
        tail_first          = 1,
        fins_part_val       = 0,
        rotated_fins_inp    = 0,
        delta_max           = math.rad(20),
        draw_fins_conv      = {math.rad(90),1,1},
        L                   = 0.203,
        S                   = 0.0324,
        Ix                  = 1.5,
        Iy                  = 190,
        Iz                  = 190,

        Mxd                 = 0.1 * 57.3,
        Mxw                 = -15.8,

        table_scale         = 0.2,
        table_degree_values = 1,
        --    Mach      | 0.0        0.2        0.4        0.6        0.8        1.0        1.2        1.4        1.6        1.8        2.0        2.2        2.4        2.6        2.8        3.0        3.2        3.4        3.6        3.8        4.0     |
        Cx0 = {    0.4727,    0.4727,    0.4727,    0.4727,    0.4838,    0.7609,     0.8869,     0.86198,    0.81793,     0.76899,     0.72481,     0.68476,    0.64836,    0.61529,    0.58515,    0.55744,    0.53195,    0.50829,    0.48624,    0.46561,    0.4461,     0.42772,    0.41035,    0.3941,     0.37898,    0.366    },
        CxB = {    0.021,     0.021,     0.021,     0.021,     0.021,     0.138,      0.153,      0.146,      0.1382,      0.1272,      0.1167,      0.1073,     0.0987,     0.0909,     0.0837,     0.077,      0.0708,     0.065,      0.0595,     0.0544,     0.0495,     0.0449,     0.0406,     0.0364,     0.0324,     0.0286    },
        K1  = {    0.00264,   0.00264,   0.00264,   0.00264,   0.00264,   0.00264,    0.0022,     0.001873,   0.0016435,   0.0014752,   0.0013448,   0.0012436,  0.0011534,  0.0010742,  0.0010149,  0.0009484,  0.0009016,  0.0008476,  0.000795,   0.0007529,  0.0007122,  0.0006727,  0.0006343,  0.0006058,  0.0005781,  0.00056    },
        K2  = {    -0.00257,  -0.00257,  -0.00257,  -0.00257,  -0.00257,  -0.00265,   -0.002274,  -0.002034,  -0.0018241,  -0.0016225,  -0.0014468,  -0.001275,  -0.0011248, -0.0009777, -0.0008514, -0.0007274, -0.0006236, -0.0005217, -0.0004393, -0.0003584, -0.0002968, -0.0002363, -0.0001949, -0.0001546, -0.0001335, -0.000114    },
        Cya = {    0.3207,    0.3207,    0.3207,    0.3207,    0.3381,    0.4226,     0.4651,     0.5049,     0.5175,      0.5033,      0.4919,      0.4815,     0.4729,     0.4653,     0.4586,     0.4528,     0.4479,     0.444,      0.441,      0.4371,     0.4341,     0.4321,     0.43,       0.4271,     0.426,      0.424    },
        Cza = {    0.3207,    0.3207,    0.3207,    0.3207,    0.3381,    0.4226,     0.4651,     0.5049,     0.5175,      0.5033,      0.4919,      0.4815,     0.4729,     0.4653,     0.4586,     0.4528,     0.4479,     0.444,      0.441,      0.4371,     0.4341,     0.4321,     0.43,       0.4271,     0.426,      0.424    },
        Mya = {    -0.7724,   -0.7724,   -0.7724,   -0.7724,   -0.8442,   -1.0226,    -0.9581,    -0.85133,   -0.7413,     -0.59726,    -0.49729,    -0.42745,   -0.37784,   -0.3414,    -0.31341,   -0.29077,   -0.27141,   -0.25428,   -0.23854,   -0.22399,   -0.21035,   -0.19771,   -0.18616,   -0.1758,    -0.16696,   -0.16075    },
        Mza = {    -0.7724,   -0.7724,   -0.7724,   -0.7724,   -0.8442,   -1.0226,    -0.9581,    -0.85133,   -0.7413,     -0.59726,    -0.49729,    -0.42745,   -0.37784,   -0.3414,    -0.31341,   -0.29077,   -0.27141,   -0.25428,   -0.23854,   -0.22399,   -0.21035,   -0.19771,   -0.18616,   -0.1758,    -0.16696,   -0.16075    },
        Myw = {    -2.0,    -2.0},
        Mzw = {    -2.0,    -2.0},
        A1trim = { 4.0, 6.0, 10.0, 15.0},
        A2trim = { 4.0, 6.0, 10.0, 15.0},

        model_roll = math.rad(45),
        fins_stall = 1,
	},
	
    controller = {
        boost_start = 0.5,
        march_start = 6.5,
    },

    boost = {
        impulse                             = 242,
        fuel_mass                           = 57.6,
        work_time                           = 6.0,
        nozzle_position                     = {{-1.6, 0.0, 0}},
        nozzle_orientationXYZ               = {{0.0, 0.0, 0.0}},
        nozzle_exit_area                    = 0.01219,
        tail_width                          = 0.4,
        smoke_color                         = {1.0, 1.0, 1.0},
        smoke_transparency                  = 0.5,
        custom_smoke_dissipation_factor     = 0.2,
    },

    march = {
        impulse                             = 236,
        fuel_mass                           = 11.6,
        work_time                           = 8.0,
        nozzle_position                     = {{-1.6, 0.0, 0}},
        nozzle_orientationXYZ               = {{0.0, 0.0, 0.0}},
        nozzle_exit_area                    = 0.01219,
        tail_width                          = 0.2,
        smoke_color                         = {1.0, 1.0, 1.0},
        smoke_transparency                  = 0.5,
        custom_smoke_dissipation_factor     = 0.2,
    },	
	
    proximity_fuze = {
        radius       = 8,
        arm_delay    = 1.6,
    },


    seeker = {
        delay               = 2.4,
        op_time             = 240,
        FOV                 = math.rad(120),
        max_w_LOS           = math.rad(20),
        sens_near_dist      = 100,
        sens_far_dist       = 50000,

        keep_aim_time       = 5,
        pos_memory_time     = 150,
        err_correct_time    = 2.0,
        calc_aim_dist       = 200000,
        blind_rad_val       = 0.1,
        aim_y_offset        = 0.5,
        aim_sigma           = 2,

        ang_err_val         = math.rad(0.006),
        abs_err_val         = 1,
        
        lock_manual_target_types_only = 0,
        filter_ignore_strings = {"EWR", "ewr"},
		
		guide_to_last_pos	= true,
    },

    autopilot = {
        delay                = 1.0,
        x_channel_delay      = 1.0,
        op_time              = 240,
        Kconv                = 3.0,
        Knv                  = 0.0025,
        Kd                   = 0.4,
        Ki                   = 0.01,
        Kout                 = 1.0,
        Kx                   = 0.04,
        Krx                  = 2.0,
        fins_limit           = math.rad(20),
        fins_limit_x         = math.rad(5),
        Areq_limit           = 14.0,
        bang_bang            = 0,
        max_signal_Fi        = math.rad(12),
        rotate_fins_output   = 0,
        alg                  = 0,
        PN_dist_data         = {15000,    1,
                                 5000,    1},
        null_roll            = math.rad(45),
        
        min_a_conv_approach_vel = 100,

        K_heading_hor                = 0.5,
        K_heading_ver                = 0.3,
        K_loft                       = 15,
        loft_active_by_default       = 0,
        loft_min_trig_ang            = math.rad(5),
        loft_trig_ang                = math.rad(15),
        loft_trig_max_alt            = 3000,
        loft_trig_change_min_dist    = 20000,
        loft_trig_change_max_dist    = 40000,
        
        loft_min_dist                = 5000,
        loft_min_add_pitch           = math.rad(10),
        loft_add_pitch               = math.rad(15),
        
        min_horiz_time               = 3.0,
        max_pitch_cmd                = math.rad(40),
    },
    
    conv =
    {
        seeker_add_pitch = math.rad(-20),
    },
		
	warhead		= MAR_warhead,
	warhead_air = MAR_warhead,
	
}

declare_weapon(mar1)

declare_loadout({
	category 		= CAT_MISSILES,
	CLSID	 		= "{JAS39_MAR-1}",
	attribute		= mar1.wsTypeOfWeapon,
	Count 			= 1,
	Cx_pil			= mar1.Cx,
	Picture			= "jas39_mar-1.png",
	displayName		= mar1.user_name,
	Weight			= mar1.mass,
	Elements  		= {{ShapeName = mar1.model}},
		
})