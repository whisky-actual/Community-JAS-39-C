local jas_spearew_warhead =
{
    mass                 = 0.0, 
    caliber              = 180,
    expl_mass            = 0.0,
    piercing_mass        = 0.0*0.0,
    other_factors        = { 1.0, 1.0, 1.0 },
    concrete_factors     = { 1.0, 1.0, 1.0 },
    concrete_obj_factor  = 0.0,
    obj_factors          = { 1.0, 1.0 },
    cumulative_factor    = 0.0,
    cumulative_thickness = 0.0, 
}

local jas_spearew_name  = 'SPEAR-EW Decoy'
local jas_spearew_mass  = 90
local jas_spearew_model = 'jas39_spear-ew'

JAS_SPEAREW_MISSILE =
{
	category        = CAT_MISSILES,
    name            = jas_spearew_name,
    user_name       = _(jas_spearew_name),
    model           = jas_spearew_model,
    mass            = jas_spearew_mass,
	scheme			= "sat_cruise_missile",             
	class_name		= "wAmmunitionCruise",     
	wsTypeOfWeapon  = {wsType_Weapon, wsType_Missile, wsType_AS_Missile, WSTYPE_PLACEHOLDER},
	
	mass = jas_spearew_mass,
	Escort = 0,
    Head_Type = 3,
	sigma = {2, 2, 2},
    M = jas_spearew_mass,
    H_max = 15000.0,
    H_min = -1,
    Diam = 180.0,
    Cx_pil = 2,
    D_max = 225000.0,
    D_min = 500.0,
    Head_Form = 0,
    Life_Time = 750,
    Nr_max = 25,
    v_min = 50.0,
    v_mid = 320.0,
    Mach_max = 2.0,
    t_b = 0.0,
    t_acc = 1.0,
    t_marsh = 9999.0,
    Range_max = 225000.0,
    H_min_t = 0.0,
    Fi_start = 0.5,
    Fi_rak = 3.14152,
    Fi_excort = 1.05,
    Fi_search = 99.9,
    OmViz_max = 99.9,
	exhaust	= {1.0, 1.0, 1.0, 0.1},
	X_back	= -0.9,
	Y_back	= -0.15,
	Z_back 	= 0.0,
	Reflection	= 0.5,
	KillDistance= 0.0,
	add_attributes = {"Cruise missiles"},	
	
	manualWeaponFlag = 1,
	
	LaunchDistData = 
	{
		14,		8,
		
					50,		75,		100,	125,	150,	200,	250,	300,	
				
		100,		0,		0,		0,		132000,	136000,	141000,	145000,	148000,	
		200,		0,		0,		0,		133000,	137000,	142000,	145000,	148000,	
		300,		0,		0,		129000,	135000,	138000,	142000,	146000,	149000,	
		500,		0,		0,		133000,	136000,	139000,	143000,	146000,	149000,	
		600,		0,		128000,	134000,	137000,	139000,	143000,	147000,	149000,	
		800,		0,		131000,	135000,	138000,	140000,	144000,	147000,	149000,	
		900,		126000,	132000,	135000,	138000,	140000,	144000,	148000,	149000,	
		1000,		128000,	133000,	136000,	137000,	140000,	144000,	148000,	151000,	
		1100,		133000,	136000,	138000,	141000,	143000,	147000,	151000,	154000,	
		1200,		137000,	140000,	143000,	146000,	149000,	153000,	156000,	160000,	
		1300,		142000,	144000,	147000,	150000,	153000,	158000,	161000,	165000,	
		1400,		145000,	148000,	151000,	154000,	157000,	162000,	167000,	171000,	
		1500,		148000,	151000,	155000,	158000,	161000,	168000,	174000,	178000,	
		1600,		152000,	156000,	160000,	164000,	168000,	177000,	185000,	225000,	
	},

		shape_table_data =
	{
		{
			name     = jas_spearew_name,
			file     = jas_spearew_model,
			life     = 1,
			fire     = {0, 1},
			username = "SPEAREW",
			index    = WSTYPE_PLACEHOLDER,
		},
	},

	controller = {
		boost_start	= 2.00,
		march_start = 5.00,
	},
	
	fm = {
		mass        = 675,  
		caliber     = 0.343,  
		cx_coeff    = {1, 0.3, 0.65, 0.023, 1.6},
		L           = 4.37,
		I           = 1500,
		Ma          = 3,	
		Mw          = 10,
		wind_sigma	= 0.0,
		wind_time	= 0.0,
		Sw			= 1.2,
		dCydA		= {0.07, 0.036},
		A			= 0.08,
		maxAoa		= 0.2,
		finsTau		= 0.08,
		Ma_x		= 1.2,
		Ma_z		= 3,
		Mw_x		= 2.7,
	},
	
	seeker = {
		coalition				= 2,
		coalition_rnd_coeff		= 5.0,
		can_update_target_pos	= 1,
	},
	
	control_block ={
		seeker_activation_dist		= 40000, 
		default_cruise_height		= 10000, 
		obj_sensor					= 0,
		can_update_target_pos		= 1,
		turn_before_point_reach		= 1,
		turn_hor_N					= 0.8,
		turn_max_calc_angle_deg		= 90,
		turn_point_trigger_dist		= 100,
		use_horiz_dist				= 1,
	},
	
	final_autopilot =		{
		delay 				= 0,
		K					= 60,
		Ki					= 0,
		Kg					= 4,
		finsLimit			= 0.8,
		useJumpByDefault	= 1,
		J_Power_K			= 1.5,
		J_Diff_K			= 0.4,
		J_Int_K				= 0,
		J_Angle_K			= 0.18,
		J_FinAngle_K		= 0.32,
		J_Angle_W			= 0.8,
		J_Trigger_Vert		= 1,
		hKp_err				= 120,
		hKp_err_croll		= 0.04,
		hKd					= 0.005,
		max_roll			= 0.8,
	},
	
	cruise_autopilot = {
		delay				= 1,
		Kp_hor_err			= 240,
		Kp_hor_err_croll	= 0.06,
		Kd_hor				= 0,
		Kp_ver				= 9,
		Kii_ver				= 0.2,
		Kd_ver				= 0,
		Kp_eng				= 265,
		Ki_eng				= 0.003,
		Kd_eng				= 0,
		Kp_ver_st1			= 0.009,
		Kd_ver_st1			= 0.015,
		Kp_ver_st2			= 0.00018,
		Kd_ver_st2			= 0.00005,
		
		auto_terrain_following			= 1,
		auto_terrain_following_height	= 50,
		
		alg_points_num			= 7,
		alg_calc_time			= 1.5,
		alg_vel_k				= 6,
		alg_div_k				= 2,
		alg_max_sin_climb		= 0.8,
		alg_section_temp_points	= 3,
		alg_tmp_point_vel_k		= 1.5,
		no_alg_vel_k			= 10,
		
		max_roll			= 0.8,
		max_start_y_vel		= 35,
		stab_vel			= 237.5,
		finsLimit			= 0.8,
		estimated_N_max		= 6,
		eng_min_thrust		= -100,
		eng_max_thrust		= 1500,		
	},
	
	boost = {	--	air launch - no booster
		impulse								= 100,
		fuel_mass							= 23,
		work_time							= 3,
		boost_time							= 0,
		boost_factor						= 0,
		nozzle_position						= {{0, 0, 0}},
		nozzle_orientationXYZ				= {{0, 0, 0}},
		tail_width							= 0,
		smoke_color							= {0.0, 0.0, 0.0},
		smoke_transparency					= 0.0,
		custom_smoke_dissipation_factor		= 0.0,						
	},
	
	booster_animation = {
		start_val = 0,
	},
	
	play_booster_animation = {
		val = 0,
	},
	
	march = {
		impulse			= 600,
		fuel_mass		= 77.5,
		work_time		= 800,
		min_fuel_rate	= 0.005,
		min_thrust		= -100,
		max_thrust		= 1500,
		thrust_Tau		= 0.0017,
		
		nozzle_position						= {{-0.8, 0.0, 0}},
		nozzle_orientationXYZ				= {{0.0, 0.0, 0.0}},
		tail_width							= 0.2,
		smoke_color							= {0.9, 0.9, 0.9},
		smoke_transparency					= 0.2,
		custom_smoke_dissipation_factor		= 0.2,		
		
		start_burn_effect			= 0,
		start_effect_delay			= {0.0,		0.3, 	0.8},
		start_effect_time			= {0.7,		1.0, 	0.1},
		start_effect_size			= {0.09,	0.104,	0.11},
		start_effect_smoke			= {0.01,	0.4, 	0.01},
		start_effect_x_pow			= {1.0,		1.0,	1.0},
		start_effect_x_dist			= {1.1,		0.9,	0.0},
		start_effect_x_shift		= {0.15,	0.15,	0.2},
		
	},
	
	warhead = jas_spearew_warhead,
	warhead_air = jas_spearew_warhead,
	
}

declare_weapon(JAS_SPEAREW_MISSILE)

declare_loadout({
    category        = CAT_MISSILES,
    CLSID           = "{JAS39_SPEAREW}",
    wsTypeOfWeapon  = JAS_SPEAREW_MISSILE.wsTypeOfWeapon,
    attribute       = {4, 4, 32, WSTYPE_PLACEHOLDER},
    Count           = 3,
    Cx_pil          = 0.0001,
    Picture         = "jas39_spear-ew.png",
    displayName     = _('3 x ' .. jas_spearew_name),
    Weight          = jas_spearew_mass * 3 + 90,
	ejectImpulse    = 140,	
	Elements = {
	
		{
			ShapeName	=	"jas39_spear_triple_rack",
			IsAdapter = true,
		},
		
		{
			DrawArgs = {[1] = {1,1},[2] = {2,1},},
			Position	=	{-0.15,	-0.42,	0.25}, --1
			ShapeName	=	"jas39_spear-ew",
		},
		
		{
			DrawArgs = {[1] = {1,1},[2] = {2,1},},
			Position	=	{-0.15,	-0.42,	-0.25}, --2
			ShapeName	=	"jas39_spear-ew",
		},
		
		{
			DrawArgs = {[1] = {1,1},[2] = {2,1},},
			Position	=	{-0.15,	-0.50, 0.0}, --3
			ShapeName	=	"jas39_spear-ew",
		},		
		
	},
    
    JettisonSubmunitionOnly = false,
})
