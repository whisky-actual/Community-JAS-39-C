
local jas39_rbs15_warhead = {
    mass                 = 200, 
    caliber              = 500,
    expl_mass            = 200, 
    piercing_mass        = 200, 
    other_factors        = { 1.0, 1.0, 1.0 },
    concrete_factors     = { 2.0, 1.0, 1.0 },
    concrete_obj_factor  = 2.0,
    obj_factors          = { 2.0, 1.0 },
    cumulative_factor    = 2.0,
    cumulative_thickness = 0.0,
}

local JAS_39_RBS_15 = {

	category		= CAT_MISSILES,
	name			= "JAS39_RBS15_MK4",
	displayName		= _("RBS-15 Mk4 AShM"),	
	user_name 		= _("RBS15"),
	mass			= 650,
	wsTypeOfWeapon  = {wsType_Weapon,wsType_Missile,wsType_AS_Missile,WSTYPE_PLACEHOLDER},
	model			= "jas39_rbs-15",
	NatoName		= "(rbs15)",	
	Escort			= 0,
	Head_Type		= 4,
	sigma			= {4, 4, 4},
	M				= 600.0,
	H_max			= 15000.0,
	H_min			= -1,
	Diam			= 360.0,
	Cx_pil			= 1,
	D_max			= 300000.0,
	D_min			= 5000.0,
	Head_Form		= 0,
	Life_Time		= 1800,
	Nr_max			= 6,
	v_min			= 170.0,
	v_mid			= 237.5,
	Mach_max		= 0.95,
	t_b				= 0.0,
	t_acc			= 5.0,
	t_marsh			= 10000.0,
	Range_max		= 300000.0,
	H_min_t			= 0.0,
	Fi_start		= 0.35,
	Fi_rak			= 3.14152,
	Fi_excort		= 0.7,
	Fi_search		= 99.9,
	OmViz_max		= 99.9,
	X_back			= 0,
	Y_back			= 0,
	Z_back			= 0,
	Reflection		= 0.15,
	KillDistance	= 0.0,
	add_attributes = {"Cruise missiles"},
	
	warhead			= jas39_rbs15_warhead,
	warhead_air 	= jas39_rbs15_warhead,
		
	manualWeaponFlag = 2,

	shape_table_data =
	{
		{
			name	 = "JAS39_RBS15_MK4",
			file	 = "jas39_rbs-15",
			life	 = 1,
			fire	 = { 0, 1},
			username = _("RBS15"),
			index	 = WSTYPE_PLACEHOLDER,
		},
	},
	
	scheme			= "Harpoon",
	class_name		= "wAmmunitionAntiShip",
	
	fm = {
		mass        = 600.0,  
		caliber     = 0.360,  
		cx_coeff    = {1,0.39,0.38,0.3,1.31},
		L           = 5.25,
		I           = 1 / 12 * 600.0 * 5.25 * 5.25,
		Ma          = 0.68,
		Mw          = 1.116,
		wind_sigma	= 0.0,
		wind_time	= 1000.0,
		Sw			= 0.95,
		dCydA		= {0.07, 0.036},
		A			= 0.5,
		maxAoa		= 0.3,
		finsTau		= 0.05,
		Ma_x		= 3,
		Ma_z		= 3,
		Kw_x		= 0.01,
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
		sens_far_dist				= 300000.0,
		primary_target_filter		= 1,
		add_y						= 1.5,		
		sens_ref_rcs				= 1000.0,
		sens_ref_dist				= 300000.0,
	},
	
	autopilot =
	{
		dont_climb_on_cruise_height	= 1,
		vel_proj_div 				= 6.0,
		default_glide_height		= 6.0,
		min_glide_height			= 6.0,
		pre_maneuver_glide_height	= 6.0,
		skim_glide_height			= 5,
		use_start_bar_height		= 1,	
		altim_vel_k					= 4,	
		
		delay				= 1.0,
		op_time				= 9999,
		Kw					= 1.4,
		Ks					= 2.0,
		K					= 1.8,
		Kd 					= 0.0,
		Ki 					= 16.0,
		Kx					= 0.04,
		Kdx					= 0.001,
		w_limit				= math.rad(5),
		fins_limit			= math.rad(35),
		fins_limit_x		= math.rad(20),
		rotated_WLOS_input	= 0,
		conv_input			= 0,
		PN_dist_data 		= {	2000,	0,
								500,	0},
								
		max_climb_angle		= math.rad(10),
		max_dive_angle		= math.rad(-25),
		max_climb_ang_hdiff	= 200,
		max_dive_ang_hdiff	= -500,
		
		Ksd						= 0.0,
		Ksi						= 0.0,
		integr_val_limit		= 0.5,
		hor_err_limit			= 0.5,
		max_climb_vel			= 200,
		min_climb_vel			= 120,
		min_climb_vel_factor	= 0,
		max_climb_h				= 3000,
		min_climb_h				= 10000,
		min_climb_h_factor		= 0.5,
		
		inertial_km_error		= 4.0,		-- m for 1000m dist
		glide_height_eq_error	= 1.0,		-- percent
	},	
	
	final_autopilot = {
		delay				= 1.0,
		op_time				= 9999,
		Kw					= 1.0,
		Ks					= 5.0,
		K					= 6.0,
		Kd 					= 0.0,
		Ki 					= 0.0,
		Kx					= 0.0,
		Kix					= 0.0,
		w_limit				= math.rad(15),
		fins_limit			= math.rad(50),
		rotated_WLOS_input	= 0,
		conv_input			= 0,
		PN_dist_data 		= {	2000,	1,
								500,	1},
								
		add_err_val				= 0,
		add_err_vert			= 0,
		add_out_val				= 0.075,
		add_out_vert			= 1,
		loft_angle				= math.rad(7),
		loft_trig_angle			= math.rad(12),
		K_loft_err				= 1,
		loft_angle_vert			= 0,
		loft_active_by_default	= 0,
	},
	
	triggers_control = {
		sensor_tg_dist			= 20000, -- turn on seeker and start horiz. correction if target is locked
		final_maneuver_tg_dist	= 2500,
		straight_nav_tg_dist	= 2500,
		self_destruct_tg_dist	= 1000,	-- if seeker still can not find a target explode warhead after reaching pred. target point + n. km
		target_upd_jump_dist	= 20000,
		update_pos_from_input	= 0,
		can_increase_tg_dist	= 1,
		
		send_final_maneuver_by_default	= 1,
		final_maneuver_trig_v_lim		= 3,
		use_horiz_dist					= 1,
		pre_maneuver_glide_height		= 6,	-- triggers st nav instead 
	},
	
	controller = {
		boost_start	= 0,
		march_start = 0,
	},
	
	boost = {				--	air launch - no booster
		impulse								= 0,
		fuel_mass							= 0,
		work_time							= 0,
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
		impulse			= 650,
		fuel_mass		= 180,
		work_time		= 9999,
		min_fuel_rate	= 0.005,
		min_thrust		= -100,
		max_thrust		= 4000,
		thrust_Tau		= 0.0017,
		
		nozzle_position						= {{0, 0, 0}},
		nozzle_orientationXYZ				= {{0, 0, 0}},
		tail_width							= 0.0,
		smoke_color							= {0.0, 0.0, 0.0},
		smoke_transparency					= 0.0,
		custom_smoke_dissipation_factor		= 0.0,	
		
		start_burn_effect			= 1,
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
		Kd				= 1.0,
		Ki				= 0.001,
		speed_delta		= 5,
	},
	
}

declare_weapon(JAS_39_RBS_15)

declare_loadout(
	{
		category		= CAT_MISSILES,
		Picture			= "jas39_RBS-15.png",
		wsTypeOfWeapon  = JAS_39_RBS_15.wsTypeOfWeapon,			
		displayName		= _("RBS-15 Mk4 AShM"),
		CLSID			= "{JAS39_RBS15}",
		attribute		= JAS_39_RBS_15.wsTypeOfWeapon,
		Count			= 1,
		Weight			= JAS_39_RBS_15.mass,
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