
local jas_meteor_name = 'Meteor BVRAAM Active Rdr AAM'
local jas_meteor_mass = 190.0
local pylon_mass = 1.0

local jas_meteor_warhead = enhanced_a2a_warhead(24, 203)

JAS_MBDA_METEOR = {
    category        = CAT_AIR_TO_AIR,
    name            = jas_meteor_name,
	scheme			= "aa_missile_amraam2",
	class_name		= "wAmmunitionSelfHoming",	
    model           = 'jas39_meteor',
    user_name       = _(jas_meteor_name),
	wsTypeOfWeapon 	= {wsType_Weapon,wsType_Missile,wsType_AA_Missile,WSTYPE_PLACEHOLDER},
    mass            = jas_meteor_mass,

    Escort 			= 0,
    Head_Type 		= 2,
	sigma 			= {5, 5, 5},
    M 				= jas_meteor_mass,
    H_max 			= 30000.0,
    H_min 			= 1.0,
    Diam 			= 178.0,
    Cx_pil 			= 2.5,
    D_max 			= 60000.0,
    D_min 			= 700.0,
    Head_Form 		= 1,
    Life_Time 		= 300.0,
    Nr_max 			= 35,
    v_min 			= 140.0,
    v_mid 			= 700.0,
    Mach_max 		= 4.0,
    t_b 			= 0.4,
    t_acc 			= 3.0,
    t_marsh 		= 6.0,
    Range_max 		= 180000.0,
    H_min_t 		= 1.0,
    Fi_start 		= 0.88,
    Fi_rak 			= 3.14152,
    Fi_excort 		= 1.05,
    Fi_search 		= 1.05,
    OmViz_max 		= 0.52,
    exhaust 		= {0.8, 0.8, 0.8, 0.05 };
    X_back 			= -1.98,
    Y_back 			= 0.0,
    Z_back 			= 0.0,
    Reflection 		= 0.07,
    KillDistance 	= 15.0,
	ccm_k0 			= 0.08,  -- Counter Countermeasures Probability Factor. Value = 0 - missile has absolutely resistance to countermeasures. Default = 1 (medium probability)
	loft 			= 1,
	hoj 			= 1,
	loft_factor 	= 2.5,
	PN_gain 		= 4,	
	SeekerGen 		= 4,  -- Seeker generation		
	
    active_radar_lock_dist      = 15000.0,
    active_dist_trig_by_default = 1,		
	
	supersonic_A_coef_skew = 0.1, -- наклон прямой коэффициента отвала поляры на сверхзвуке
	nozzle_exit_area =	0.011, -- площадь выходного сечения сопла
	
    warhead         = jas_meteor_warhead,
    warhead_air     = jas_meteor_warhead,

    shape_table_data = {
        {
            name     = jas_meteor_name,
            file     = 'jas39_meteor',
            life     = 1,
            fire     = {0, 1},
            username = "METEOR",
            index    = WSTYPE_PLACEHOLDER,
        },
    },

	ModelData = {   58 ,  -- model params count
					0.6 ,   -- characteristic square
				
					-- parameters of the dependence of Cx
					0.032 , -- Cx0 plateau at subsonic speeds (M << 1) cx_k0
					0.065 , -- peak height at wave crisis cx_k1
					0.02 ,  -- steepness of the front approaching the wave crisis cx_k2
					-0.071 , -- Cx0 plateau at supersonic speeds (M >> 1) cx_k3
					0.30  , -- steepness of decline after the wave crisis cx_k4
					0.84  , -- polar drag coefficient
				
					-- parameters of the dependence of Cy
					1.6 , -- Cy0 plateau at subsonic speeds (M << 1)
					0.8 , -- Cy0 plateau at supersonic speeds (M >> 1)
					1.2 , -- steepness of decline (front) after the wave crisis
				
					0.6, -- 7 Alfa_max  maximum balancing angle, radians
					0.0, -- angular velocity created by the gas rudder's moment
				
					-- t_statr   t_b      t_accel      t_march   t_inertial    t_break   t_end
						-1.0,   -1.0,       2.1,         36.5,      0.0,          0.0,      1.0e9,         -- time interval
						0.0,    0.0,       17.28,       0.85,      0.0,          0.0,        0.0,         -- fuel flow rate in seconds kg/sec
						0.0,    0.0,       42732.0,     4094.0,      0.0,        0.0,        0.0,         -- thrust
				
					1.0e9, -- self-destructive timer, sec
					300.0, -- power system working time, sec
					0, -- absolute altitude of self-destruction, m
					2.5, -- control activation delay time (evasion maneuver, safety), sec
					15000.0, -- target distance at launch, beyond which the missile performs a 'loft' maneuver, m
					15000.0, -- target distance at which the 'loft' maneuver ends and the missile switches to pure proportional navigation (should be greater or equal to the previous parameter), m
					0.261799,  -- sine of the ascent trajectory angle during the loft maneuver
					30.0, -- longitudinal acceleration of fuze arming
					0.0, -- speed module communicated by the catapult device, ejection charge, etc.
					36.0, -- характристика системы САУ-РАКЕТА,  коэф фильтра второго порядка K0
					7.8, -- характристика системы САУ-РАКЕТА,  коэф фильтра второго порядка K1
					1.0, -- характристика системы САУ-РАКЕТА,  полоса пропускания контура управления
					-- SAM. Data for calculating launch distances (indicator on the sight) 
					21.0, -- derivative of range by carrier speed at an altitude of 1 km, PPS
					-25.0, -- derivative of range by target speed at an altitude of 1 km, ZPS
					-3.0, -- derivative of range by height of target speed, ZPS
					60000.0, -- range at 180-degree angle (head-on), H=5000m, V=900km/h, m
					23000.0, -- range at 180-degree angle (pursuit), H=5000m, V=900km/h, m
					140000.0, -- range at 180-degree angle (head-on), H=10000m, V=900km/h, m
					40000.0, -- range at 0-degree angle (pursuit), H=10000m, V=900km/h, m
					38000.0, -- range at 180-degree angle, H=1000m, V=900km/h, m
					15000.0, -- range at 180-degree angle (pursuit), H=1000m, V=900km/h, m
					3500.0, -- offset backward relative to the zero rear point of the reach zone
					0.4, -- guaranteed range percentage from PPS range at an altitude of 1 km
					-0.015, -- derivative of guaranteed range percentage in PPS by height
					0.5, -- change in the slope coefficients of the curve for the upper and lower hemispheres from the carrier's altitude
				},
	
	controller = {
		boost_start = 0.3,
		march_start = 3.8,
	},

	boost = {
		impulse								= 225,
		fuel_mass							= 30,
		work_time							= 3.0,
		nozzle_position						= {{-1.4, 0, 0}},
		nozzle_orientationXYZ				= {{0.0, 0.0, 0.0}},
		nozzle_exit_area 					= 0.03,
		tail_width							= 0.5,
		smoke_color							= {1.0, 1.0, 1.0},
		smoke_transparency					= 1.0,
		custom_smoke_dissipation_factor		= 0.2,
        smoke_opacity_type                  = 1,		
	},

	march = {
		impulse								= 140,
		fuel_mass							= 20.0,
		work_time							= 48.0,
		nozzle_position						= {{-1.5, 0, 0}},
		nozzle_orientationXYZ				= {{0.0, 0.0, 0.0}},
		nozzle_exit_area 					= 0.03,
		tail_width							= 0.15,
		smoke_color							= {0.8, 0.8, 0.8},
		smoke_transparency					= 0.03,
		custom_smoke_dissipation_factor		= 0.2,
        effect_type                         = 1,		
	},

    fm = {
        mass                = 190.0,
        caliber             = 0.200,
        wind_sigma          = 0.0,
        wind_time           = 0.0,
        tail_first          = 0,
        fins_part_val       = 0,
        rotated_fins_inp    = 0,
        delta_max           = math.rad(20),
        draw_fins_conv      = {math.rad(90),1,1},
        L                   = 0.200,
        S                   = 0.0314, 
        Ix                  = 1.95,    
        Iy                  = 140.1, 
        Iz                  = 140.1, 

        Mxd                 = 0.1 * 57.3,
        Mxw                 = -15.8,

        table_scale         = 0.2,
        table_degree_values = 1,
         --	Mach	  | 0.0		0.2	0.4	0.6	0.8	1.0	1.2	1.4	1.6	1.8	2.0	2.2	2.4	2.6	2.8	3.0	3.2	3.4	3.6	3.8	4.0	4.2	4.4	4.6	4.8	5.0 |
                Cx0     = { 0.606,	0.606,	0.606,	0.606,	0.946,	1.251,	1.172,	1.071,	0.943,	0.829,	0.742,	0.679,	0.635,	0.599,	0.568,	0.541,	0.516,	0.493,	0.471,	0.450,	0.431,	0.413,	0.397,	0.382,	0.368,	0.355  },
                CxB 	= { 0.021,	0.021,	0.021,	0.021,	0.021,	0.138,	0.153,	0.146,	0.1382,	0.1272,	0.1133,	0.0998,	0.0873,	0.079,	0.0728,	0.067,	0.0616,	0.0565,	0.0517,	0.0473,	0.043,	0.039,	0.0353,	0.0316,	0.0282,	0.0249 },
                K1	= { 0.0044,	0.0044,	0.0044,	0.0044,	0.0086,	0.0108,	0.008,  0.00447, 0.00302, 0.0027,  0.00246, 0.00228, 0.00212, 0.00198, 0.00188, 0.00178, 0.00168, 0.00158, 0.00148, 0.0014, 0.00132, 0.00124, 0.00116, 0.001104,0.00105, 0.001  },
		K2	= {-0.0047,    -0.0047,-0.0047,-0.0047,-0.0024,-0.0016,-0.0025,-0.00456,-0.00497,-0.00495,-0.00492,-0.00479,-0.00466,-0.00455,-0.00451,-0.00445,-0.00437,-0.00427,-0.00414,-0.00406,-0.00396,-0.00384,-0.00371,-0.00364,-0.00357,-0.0035 },
                Cya	= { 0.593,	0.593,	0.593,	0.593,	0.613,	0.618,	0.609,	0.597,	0.584,	0.564,	0.548,	0.533,	0.521,	0.51,	0.501,	0.493,	0.487,	0.481,	0.476,	0.471,	0.467,	0.463,	0.459,	0.455,	0.451,	0.447 },
		Cza	= { 0.593,	0.593,	0.593,	0.593,	0.613,	0.618,	0.609,	0.597,	0.584,	0.564,	0.548,	0.533,	0.521,	0.51,	0.501,	0.493,	0.487,	0.481,	0.476,	0.471,	0.467,	0.463,	0.459,	0.455,	0.451,	0.447 },
                Mya	= {-0.862,     -0.862, -0.862, -0.862, -0.943, -1.023, -0.958, -0.825, -0.719, -0.572, -0.471, -0.402, -0.354, -0.319, -0.293, -0.273, -0.255, -0.240, -0.225, -0.212, -0.199, -0.187, -0.175, -0.165, -0.156, -0.149 },
		Mza	= {-0.862,     -0.862, -0.862, -0.862, -0.943, -1.023, -0.958, -0.825, -0.719, -0.572, -0.471, -0.402, -0.354, -0.319, -0.293, -0.273, -0.255, -0.240, -0.225, -0.212, -0.199, -0.187, -0.175, -0.165, -0.156, -0.149 },
                Myw	= {-18.58,     -18.58, -18.58, -18.58, -19.04, -19.96,-16.109,-13.162, -7.511, -5.822, -5.027, -4.758, -4.503, -4.263, -4.037, -3.824, -3.623, -3.436, -3.257, -3.091, -2.934, -2.786, -2.647, -2.516, -2.394, -2.277 },
		Mzw	= {-18.58,     -18.58, -18.58, -18.58, -19.04, -19.96,-16.109,-13.162, -7.511, -5.822, -5.027, -4.758, -4.503, -4.263, -4.037, -3.824, -3.623, -3.436, -3.257, -3.091, -2.934, -2.786, -2.647, -2.516, -2.394, -2.277 },
                A1trim	= { 30,		30,	30,	30,	30,	31.2,	32.74,	33.39,	33.7,	33.89,	34.04,	34.18,	34.31,	34.44,	34.57,	34.7,	34.83,	34.96,	35.09,	35.22,	35.35,	35.48,	35.61,	35.74,	35.87,	36 },
		A2trim	= { 30,		30,	30,	30,	30,	31.2,	32.74,	33.39,	33.7,	33.89,	34.04,	34.18,	34.31,	34.44,	34.57,	34.7,	34.83,	34.96,	35.09,	35.22,	35.35,	35.48,	35.61,	35.74,	35.87,	36 },

        model_roll = math.rad(45),
        fins_stall = 1,
    },

	sensor = {
		delay						= 1.5,
		op_time						= 300,
		FOV							= math.rad(120),
		max_w_LOS					= math.rad(30),
		sens_near_dist				= 100,
		sens_far_dist				= 33000,
		ccm_k0						= 0.05,
		aim_sigma					= 3.0,
		height_error_k				= 10,
		height_error_max_vel		= 10,
		height_error_max_h			= 100,
		hoj							= 1,
        active_radar_lock_dist      = 15000.0,
        active_dist_trig_by_default = 1,		
	},
	
	gimbal = {
		delay				= 0,
		op_time				= 300,
		pitch_max			= math.rad(60),
		yaw_max				= math.rad(60),
		max_tracking_rate	= math.rad(30),
		tracking_gain		= 50,
	},

	autopilot = {
		delay				= 0.2,
		cmd_delay			= 0.8,
		op_time				= 300,
		Tf					= 0.1,
		Knav				= 4.0,
		Kd					= 180.0,
		Ka					= 16.0,
		T1					= 309.0,
		Tc					= 0.06,
		Kx					= 0.1,
		Krx					= 2.0,
		gload_limit			= 35.0,
		fins_limit			= math.rad(28),
		fins_limit_x		= math.rad(5),
		null_roll			= math.rad(45),
		accel_coeffs		= { 0, 11.5,-1.2,-0.25, 24.0,
								0.0248 * 0.75 * 0.0091 },

		loft_active			= 1,
		loft_factor			= 2.5,
		loft_sin			= math.sin(15/57.3),
		loft_off_range		= 15000,
		dV0					= 393,
	},

	actuator = {
		Tf					= 0.005,
		D					= 250.0,
		T1					= 0.002,
		T2					= 0.006,
		max_omega			= math.rad(400),
		max_delta			= math.rad(20),
		fin_stall			= 1,
		sim_count			= 4,
	},

	proximity_fuze = {
		radius		= 15.0,
		arm_delay	= 1.6,
	},
	
}

declare_weapon(JAS_MBDA_METEOR)

declare_loadout({
    category    = CAT_AIR_TO_AIR,
    CLSID       = "{JAS39_Meteor}",
    Picture     = 'jas39_meteor.png',
    wsTypeOfWeapon   = JAS_MBDA_METEOR.wsTypeOfWeapon,
    displayName = _(jas_meteor_name),
	attribute	=	{4,	4,	32,	WSTYPE_PLACEHOLDER},
    Count       = 1,
    Weight      = jas_meteor_mass + pylon_mass,
    Elements    =
	{
		{
		
			ShapeName	=	"jas39_meteor",
			Position	=	{0,	0,	0}
		},
	},	
})
