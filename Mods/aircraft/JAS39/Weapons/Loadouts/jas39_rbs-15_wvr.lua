
local jas39_rbs15_warhead = {
    mass                 = 300, 
    caliber              = 500,
    expl_mass            = 300, 
    piercing_mass        = 300, 
    other_factors        = { 1.0, 1.0, 1.0 },
    concrete_factors     = { 5.0, 1.0, 1.0 },
    concrete_obj_factor  = 2.0,
    obj_factors          = { 5.0, 1.0 },
    cumulative_factor    = 2.0,
    cumulative_thickness = 0.0,
}

local mass = 650

local jas39_rbs15_wvr = {

	category		= CAT_MISSILES,
	name			= "jas39_rbs15_wvr",
	user_name		= _("RBS-15 Mk4 Gungnir Anti-ship Missile"),
	wsTypeOfWeapon	=	{4,	4,	8,	WSTYPE_PLACEHOLDER},	
	scheme			= "Harpoon",
	class_name		= "wAmmunitionAntiShip",
	model			= "jas39_rbs-15",
	NatoName		= "(Gungnir)",

	shape_table_data =
	{
		{
			name	 = "jas39_rbs15_wvr",
			file	 = "jas39_rbs-15",
			life	 = 1,
			fire	 = { 0, 1},
			username = _("RBS15"),
			index	 = WSTYPE_PLACEHOLDER,
		},
	},

	Escort = 0,
	Head_Type = 3,
	sigma = {5, 5, 5},
	M = 650,
	H_max = 15000.0,
	H_min = 1500,
	Diam = 500.0,
	Cx_pil = 5,
	D_max = 250000.0,
	D_min = 7000.0,
	Head_Form = 0,
	Life_Time = 250.0,
	Nr_max = 20,
	v_min = 170.0,
	v_mid = 400.0,
	Mach_max = 1.5,
	t_b = 0.0,
	t_acc = 4.0,
	t_marsh = 150.0,
	Range_max = 300000.0,
	H_min_t = 0.0,
	Fi_start = 0.25,
	Fi_rak = 3.14152,
	Fi_excort = 0.35,
	Fi_search = 99.9,
	OmViz_max = 99.9,
	exhaust1 = tail_solid,
	X_back = -1.341,
	Y_back = -0.178,
	Z_back = 0.0,
	Reflection = 0.15,
	KillDistance = 0.0,
	add_attributes = {"Cruise missiles"},
	
	manualWeaponFlag = 1,

	LaunchDistData =
    {
          6,        7,
                   100,      125,      150,      175,       200,       250,       300,
        1500,    263000,      268000,    273000,      278000,     283000,    288000,       293000,
        2000,    270000,      275000,    280000,      285000,     289000,    294000,       300000,
        2500,    276000,      281000,    286000,      291000,     294000,    299000,       300000,
        3000,    281000,      286000,    291000,      296000,     299000,    300000,       300000,
        5000,    285000,      290000,    295000,      299000,     300000,    300000,       300000,
        7500,    290000,      295000,    300000,      300000,     300000,    300000,       300000,
    },
	
	fm = {
		mass        = 650,  
		caliber     = 0.500,  
		cx_coeff    = {1,0.39,0.38,0.236,1.31},		
		L           = 4.35,
		I           = 1 / 12 * 650 * 4.35 * 4.35,
		Ma          = 0.3,
		Mw          = 1.116,
		wind_sigma	= 0.0,
		wind_time	= 0.0,
		Sw			= 1.65,
		dCydA		= {0.07, 0.036},
		A			= 0.36,
		maxAoa		= 0.28,
		finsTau		= 0.1,		
		Ma_x		= 0.001,
		Kw_x		= 0.001,
		I_x			= 50,
		lockRoll 	= 1,	
		
	},
	
	seeker = {
	
		delay						= 0.0,
		op_time						= 9999.0,
		FOV							= math.rad(60),
		max_w_LOS					= 0.06,
		max_target_speed			= 33.0,
		max_target_speed_rnd_coeff	= 10.0,
		ship_track_by_default		= 1,
		flag_dist					= 5000.0,
		sens_near_dist				= 10.0,
		sens_far_dist				= 350000.0,
		primary_target_filter		= 1,
		add_y						= 3, --1.5	
		sens_ref_rcs				= 350000.0,
		sens_ref_dist				= 350000.0,		
	},
	
	autopilot =
	{
	
		K 							= 30,
		Kd 							= 0.15,
		Kdx 						= 0.001,
		Ki 							= 8,
		Ks 							= 8,
		Ksd 						= 0.1,
		Ksi 						= 0,
		Kw 							= 1,
		Kx 							= 0.04,
		PN_dist_data 				= { 2000, 0, 500, 0 },
		altim_vel_k 				= 5,
		conv_input 					= 0,
		default_glide_height 		= 5,
		delay 						= 1,
		dont_climb_on_cruise_height = 0,
		fins_limit 					= math.rad(60),
		fins_limit_x 				= math.rad(45),
		fins_q_div 					= 1,
		glide_height 				= 5,
		hor_err_limit 				= 0.5,
		integr_val_limit 			= 0.5,
		max_climb_ang_hdiff 		= 200,
		max_climb_angle				= math.rad(10),
		max_dive_ang_hdiff 			= -200,
		max_dive_angle 				= math.rad(-20),
		op_time 					= 9999,
		pre_maneuver_glide_height 	= 5,
		rotated_WLOS_input 			= 0,
		skim_glide_height 			= 5,
		use_start_bar_height 		= 1,
		vel_proj_div 				= 22,
		w_limit 					= math.rad(15),	
	},
	
	final_autopilot =		
		{

		K 							= 30,
		K_loft_err 					= 0,
		Kd 							= 0.15,
		Ki 							= 0,
		Kix 						= 0,
		Ks 							= 10,
		Kw 							= 3.5,
		Kx 							= 0,
		PN_dist_data 				= { 10000, 0, 4000, 1 },
		add_err_val 				= 0.014,
		add_err_vert 				= 1,
		add_out_val 				= 0,
		add_out_vert 				= 0,
		conv_input 					= 0,
		delay 						= 1,
		fins_limit 					= math.rad(60),
		fins_q_div 					= 1,
		loft_angle 					= 0,
		loft_angle_vert 			= 0,
		loft_trig_angle 			= 0,
		op_time 					= 9999,
		rotated_WLOS_input 			= 0,
		w_limit 					= math.rad(15),
	},
	
	triggers_control = {

		sensor_tg_dist						= 8000, 
		final_maneuver_tg_dist				= 4000, 
		straight_nav_tg_dist				= 1000,
		self_destruct_tg_dist				= 1000,	
		target_upd_jump_dist				= 1000,
		update_pos_from_input				= 1, --0
		can_increase_tg_dist				= 1,
			
		send_final_maneuver_by_default		= 0,
		final_maneuver_trig_v_lim			= 3,
		use_horiz_dist						= 1,
		pre_maneuver_glide_height			= 8,
	},
	
	controller = {
		boost_start = 0,
		march_start = 4,
	},
	
	boost = {				
		impulse								= 400,
		fuel_mass							= 40, 
		work_time							= 4,
		boost_time							= 0,
		boost_factor						= 0,
		nozzle_position						= {{0, 0, 0}},
		nozzle_orientationXYZ				= {{0, 0, 0}},
		tail_width							= 0.0,
		smoke_color							= {0.0, 0.0, 0.0},
		smoke_transparency					= 0.0,
		custom_smoke_dissipation_factor		= 0.0,		
	},
	
	march = {
		impulse			= 28000,
		fuel_mass		= 350,
		work_time		= 9999,
		min_fuel_rate	= 0.005,
		min_thrust		= -100,
		max_thrust		= 6700,
		thrust_Tau		= 0.0017,
		
		nozzle_position						= {{0, 0, 0}},
		nozzle_orientationXYZ				= {{0, 0, 0}},
		tail_width							= 0.0,
		smoke_color							= {0.0, 0.0, 0.0},
		smoke_transparency					= 0.0,
		custom_smoke_dissipation_factor		= 0.0,	
		
		start_burn_effect			= 0,
		start_effect_delay			= {0.0,		0.3, 	0.8},
		start_effect_time			= {0.7,		1.0, 	0.1},
		start_effect_size			= {0.09,	0.104,	0.11},
		start_effect_smoke			= {0.01,	0.4, 	0.01},
		start_effect_x_pow			= {1.0,		1.0,	1.0},
		start_effect_x_dist			= {1.1,		0.9,	0.0},
		start_effect_x_shift		= {0.15,	0.15,	0.2},
	},
	
	engine_control = {
		default_speed	= 400,
		K				= 265,
		Kd				= 0.01,
		Ki				= 0.001,
		speed_delta		= 10,		
	},
	
		mass 		= 650,
		warhead		= jas39_rbs15_warhead,
		warhead_air = jas39_rbs15_warhead,
}

declare_weapon(jas39_rbs15_wvr)

declare_loadout(
	{
		category		= CAT_MISSILES,
		Picture			= "jas39_RBS-15.png",
		displayName		= jas39_rbs15_wvr.user_name,
		Weight			= 650,
		CLSID			= "{JAS39_RBS15_WVR}",
		attribute		= jas39_rbs15_wvr.wsTypeOfWeapon,
		Count			= 1,
		Cx_pil			= 0.001, 	
		Elements		=
	{
		[1]	=	
		{
				DrawArgs	=
				{
					[1]	=	{1,	1},
					[2]	=	{2,	1},
				}, -- end of DrawArgs
				Position	=	{0,	0,	0},
				ShapeName	=	"jas39_rbs-15",
					},
		}, -- end of Elements   
	}
)