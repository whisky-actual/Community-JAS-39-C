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

local mar1_wvr = {

	category		= CAT_MISSILES,
	name			= "mar1_wvr",
	user_name		= _("MAR-1 High Speed Anti-Radiation Missile"),
	wsTypeOfWeapon 	= {wsType_Weapon, wsType_Missile, wsType_AS_Missile, WSTYPE_PLACEHOLDER},
	scheme			= "anti_rad_missile",              
	class_name		= "wAmmunitionSelfHoming",                          
	model			= "jas39_mar1",
	mass 			= 200,    

    Escort = 0,
	Head_Type = 3,
	sigma = {10, 10, 10},
	M = 200.0,
	H_max = 25000.0,
	H_min = -1,
	Diam = 254.0,
	Cx_pil = 2,
	D_max = 100000.0,
	D_min = 700.0,
	Head_Form = 0,
	Life_Time = 300.0,
	Nr_max = 25,
	v_min = 140.0,
	v_mid = 900.0,
	Mach_max = 3.0,
	t_b = 0.0,
	t_acc = 5.0,
	t_marsh = 15.0,
	Range_max = 100000.0,
	H_min_t = 0.0,
	Fi_start = 0.52,
	Fi_rak = 3.14152,
	Fi_excort = 1.05,
	Fi_search = 99.9,
	OmViz_max = 99.9,
	exhaust = {0.9, 0.9, 0.9, 0.2};
	X_back = -1.3,
	Y_back = -0.50,
	Z_back = 0.0,
	Reflection = 0.0329,
	KillDistance = 7.0,

	LaunchDistData =
	{
		7,		7,

				100,	150,	200,	250,	300,	350,	400,		
		500,	0,		75790,	83280,	87490,	90390,	93090,	93850,	
		600,	0,		73690,	81610,	85620,	88750,	91500,	93860,	
		700,	0,		74170,	82540,	86570,	89730,	92470,	94870,	
		800,	0,		75175,	83750,	87775,	90975,	93725,	96150,	
		900,	0,		75925,	84675,	88775,	91975,	94725,	97175,	
		1000,	0,		76500,	85425,	89550,	92750,	95525,	97975,	
		2000,	0,		79850,	87125,	91600,	95050,	98075,	100775,	
	},
	 
	shape_table_data =
	{
		{
			name	 = "mar1_wvr",
			file	 = "jas39_mar1",
			life	 = 1,
			fire	 = { 0, 1},
			username = _("MAR1"),
			index	 = WSTYPE_PLACEHOLDER,			
		},
	},

	controller = {
        boost_start = 0.5,
        march_start = 1.0,
	},
	
	boost = {
        impulse                             = 240, --242
        fuel_mass                           = 50,  --57.6
        work_time                           = 5.0, --6.0
		nozzle_position						= {{-1.65, 0.0, -0.0}},
		nozzle_orientationXYZ				= {{0.0, 0.0, 0.0}},
		tail_width							= 0.4,
		smoke_color							= {1.0, 1.0, 1.0},
		smoke_transparency					= 1.3,
		custom_smoke_dissipation_factor		= 0.2,
	},
	
	march = {
        impulse                             = 140, --236
        fuel_mass                           = 80, --11.6 
        work_time                           = 15,  --4.0
		nozzle_position                     = {{-1.65, 0.0, -0.0}},
		nozzle_orientationXYZ				= {{0.0, 0.0, 0.0}},
		tail_width                          = 0.2,
		smoke_color							= {0.6, 0.6, 0.6},  
		smoke_transparency                  = 0.8,
		custom_smoke_dissipation_factor		= 0.2,	
	},
	
	fm = {
        mass                = 199,
        caliber             = 0.203,
        wind_sigma          = 0.0,
        wind_time           = 0.0,
        tail_first          = 1,
        fins_part_val       = 0,
        rotated_fins_inp    = 0,
        delta_max           = math.rad(20),
        L                   = 0.203,
        S                   = 0.0324,
        Ix                  = 1.5,
        Iy                  = 190,
        Iz                  = 190,

        Mxd                 = 0.3 * 57.3,
        Mxw                 = -44.5,

        table_scale    = 0.2,
        table_degree_values = 1,
        --    Mach      | 0.0        0.2        0.4        0.6        0.8        1.0        1.2        1.4        1.6        1.8        2.0        2.2        2.4        2.6        2.8        3.0        3.2        3.4        3.6        3.8        4.0     |
        Cx0 = {    0.4727,    0.4727,    0.4727,    0.4727,    0.4838,    0.7609,     0.8869,     0.86198,    0.81793,     0.76899,     0.72481,     0.68476,    0.64836,    0.61529,    0.58515,    0.55744,    0.53195,    0.50829,    0.48624,    0.46561,    0.4461,     0.42772,    0.41035,    0.3941,     0.37898,    0.366    },
        CxB = {    0.021,     0.021,     0.021,     0.021,     0.021,     0.138,      0.153,      0.146,      0.1382,      0.1272,      0.1167,      0.1073,     0.0987,     0.0909,     0.0837,     0.077,      0.0708,     0.065,      0.0595,     0.0544,     0.0495,     0.0449,     0.0406,     0.0364,     0.0324,     0.0286    },
        K1  = {    0.00264,   0.00264,   0.00264,   0.00264,   0.00264,   0.00264,    0.0022,     0.001873,   0.0016435,   0.0014752,   0.0013448,   0.0012436,  0.0011534,  0.0010742,  0.0010149,  0.0009484,  0.0009016,  0.0008476,  0.000795,   0.0007529,  0.0007122,  0.0006727,  0.0006343,  0.0006058,  0.0005781,  0.00056    },
        K2  = {    -0.00257,  -0.00257,  -0.00257,  -0.00257,  -0.00257,  -0.00265,   -0.002274,  -0.002034,  -0.0018241,  -0.0016225,  -0.0014468,  -0.001275,  -0.0011248, -0.0009777, -0.0008514, -0.0007274, -0.0006236, -0.0005217, -0.0004393, -0.0003584, -0.0002968, -0.0002363, -0.0001949, -0.0001546, -0.0001335, -0.000114    },
        Cya = {    0.3207,    0.3207,    0.3207,    0.3207,    0.3381,    0.4226,     0.4651,     0.5049,     0.5175,      0.5033,      0.4919,      0.4815,     0.4729,     0.4653,     0.4586,     0.4528,     0.4479,     0.444,      0.441,      0.4371,     0.4341,     0.4321,     0.43,       0.4271,     0.426,      0.424    },
        Cza = {    0.3207,    0.3207,    0.3207,    0.3207,    0.3381,    0.4226,     0.4651,     0.5049,     0.5175,      0.5033,      0.4919,      0.4815,     0.4729,     0.4653,     0.4586,     0.4528,     0.4479,     0.444,      0.441,      0.4371,     0.4341,     0.4321,     0.43,       0.4271,     0.426,      0.424    },
        Mya       = { -0.5,    -0.5},
        Mza       = { -0.5,    -0.5},
        Myw       = { -2.0,    -2.0},
        Mzw       = { -2.0,    -2.0},
        A1trim    = { 10.0,    10.0},
        A2trim    = { 10.0,    10.0},

        model_roll = math.rad(45),
        fins_stall = 1,
	},
	
	proximity_fuze = {
        radius       = 8,
        arm_delay    = 1.6,
	},
	
	seeker = {
        delay               = 2.4,
        op_time             = 300,
        FOV                 = math.rad(60),
        max_w_LOS           = math.rad(20),
        sens_near_dist      = 100,
        sens_far_dist       = 100000,

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
        delay                = 1.0,
        x_channel_delay      = 1.0,
        op_time              = 240,
        Kconv                = 6.0,
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
        PN_dist_data         = {15000,    0,
                                 5000,    1},
        null_roll            = math.rad(45),
        
        min_a_conv_approach_vel = 100,

        K_heading_hor                = 0.5,
        K_heading_ver                = 0.3,
        K_loft                       = 3.3,
        loft_active_by_default       = 1,
        loft_min_trig_ang            = math.rad(5),
        loft_trig_ang                = math.rad(20),
        loft_trig_max_alt            = 3000,
        loft_trig_change_min_dist    = 20000,
        loft_trig_change_max_dist    = 35000,
        
        loft_min_dist                = 5000,
        loft_min_add_pitch           = math.rad(10),
        loft_add_pitch               = math.rad(20),
        
        min_horiz_time               = 3.0,
        max_pitch_cmd                = math.rad(32),
	},
		
	warhead		= MAR_warhead,
	warhead_air = MAR_warhead,
	
}

declare_weapon(mar1_wvr)

declare_loadout({
	category 		= CAT_MISSILES,
	CLSID	 		= "{JAS39_MAR-1_WVR}",
	attribute		= mar1_wvr.wsTypeOfWeapon,
	Count 			= 1,
	Cx_pil			= mar1_wvr.Cx,
	Picture			= "jas39_mar-1.png",
	displayName		= mar1_wvr.user_name,
	Weight			= mar1_wvr.mass,
	Elements  		= {{ShapeName = mar1_wvr.model}},
		
})