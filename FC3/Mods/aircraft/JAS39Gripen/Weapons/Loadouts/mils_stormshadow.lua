local stormshadow_name = 'Storm Shadow'
local stormshadow_mass = 1300.0
local pylon_mass = 1.0

local stormshadow_warhead = 
{
	mass					= 450,
	caliber					= 480,
	expl_mass      			= 240,
	piercing_mass        	= 240.0,		
	other_factors   		= { 1.0, 1.0, 1.0 },
	concrete_factors		= { 5.0, 1.0, 10.0 },
	concrete_obj_factor		= 5.0,
	obj_factors				= { 1.0, 1.0 },
	cumulative_factor		= 0.0,
	cumulative_thickness	= 0.0
}

STORM_SHADOW =
{
	category		= CAT_MISSILES,
	name			= stormshadow_name,
	user_name		= _(stormshadow_name),
	scheme			= "cruise_missile",
	class_name		= "wAmmunitionCruise",
	model			= 'stormshadow',
	mass			= 1300,
	wsTypeOfWeapon 	= {wsType_Weapon,wsType_Missile,wsType_AS_Missile,WSTYPE_PLACEHOLDER},
    add_attributes = {"Cruise missiles"},
	
	Escort			= 0,
	Head_Type		= 5,
	sigma			= {10, 10, 10},
	M		        = 1100.0,
	H_max			= 15000.0, 
	H_min			= -1,
	Diam			= 480.0,
	Cx_pil			= 8,
	D_max			= 548192.0, 
	D_min			= 10000.0,
	Head_Form		= 0,
	Life_Time		= 100000,
	Nr_max			= 6,
	v_min			= 170.0,
	v_mid			= 237.5,
	Mach_max		= 0.90,
	t_b				= 0.0,
	t_acc			= 5.0,
	t_marsh			= 10000.0,
	Range_max		= 548192.0,
	H_min_t			= 500.0,
	Fi_start		= 0.35,
	Fi_rak			= 3.14152,
	Fi_excort		= 0.7,
	Fi_search		= 99.9,
	OmViz_max		= 99.9,
	X_back = -3.392,
	Y_back = 0.064,
	Z_back = 0.0,
	Reflection = 0.1691,
	KillDistance = 0.0,
	
	warhead     = stormshadow_warhead,
    warhead_air = stormshadow_warhead,
		
	shape_table_data =
	{
		{
			name	 = stormshadow_name,
			file	 = 'stormshadow',
			life	 = 1,
			fire	 = { 0, 1},
			username = stormshadow_name,
			index	 = WSTYPE_PLACEHOLDER,
		},
	},
	
	fm = {
		mass        = 1300,  
		caliber     = 0.480,  
		cx_coeff    = {1, 0.3, 0.65, 0.018, 1.6},
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
		Ma_x		= 3,
		Ma_z		= 3,
		Kw_x		= 0.05,
	},
	
	simple_seeker = {
		sensitivity     = 0,
		delay		= 0.0,
		FOV			= 0.6,
		maxW		= 500,
		opTime		= 9999,
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
		auto_terrain_following_height	= 60,
		
		alg_points_num			= 7,
		alg_calc_time			= 1.5,
		alg_vel_k				= 6,
		alg_div_k				= 2,
		alg_max_sin_climb		= 0.7,
		alg_section_temp_points	= 3,
		alg_tmp_point_vel_k		= 1.5,
		no_alg_vel_k			= 10,
		
		max_roll			= 0.7,
		max_start_y_vel		= 35,
		stab_vel			= 237.5,
		finsLimit			= 0.8,
		estimated_N_max		= 6,
		eng_min_thrust		= -100,
		eng_max_thrust		= 3000,		
	},
	
	final_autopilot =		{
		delay = 0.1,
		K					= 60,
		Ki					= 0,
		Kg					= 4,
		finsLimit			= 0.8,
		useJumpByDefault	= 1,
		J_Power_K			= 2.4,
		J_Diff_K			= 0.8,
		J_Int_K				= 0,
		J_Angle_K			= 0.17,
		J_FinAngle_K		= 0.195,
		J_Angle_W			= 2.4,
		hKp_err				= 100,
		hKp_err_croll		= 0.04,
		hKd					= 0.005,
		max_roll			= 0.7,
	},
	
	control_block ={
		seeker_activation_dist		= 7000,
		default_cruise_height		= 100,
		obj_sensor					= 0,
		can_update_target_pos		= 0,
		turn_before_point_reach		= 1,
		turn_hor_N					= 0.8,
		turn_max_calc_angle_deg		= 90,
		turn_point_trigger_dist		= 100,
	},
	
	controller = {
		boost_start	= 0.001,
		march_start = 0.8,
	},
	

	boost = {	--	air launch - no booster
		impulse								= 0,
		fuel_mass							= 0,
		work_time							= 0,
		boost_time							= 0,
		boost_factor						= 0,
		nozzle_position						= {{0, 0, 0}},
		nozzle_orientationXYZ				= {{0, 0, 0}},
		tail_width							= 0,
		smoke_color							= {0.0, 0.0, 0.0},
		smoke_transparency					= 0.0,
		custom_smoke_dissipation_factor		= 0.0,				
	},
	
	
	march = {
		impulse			= 690,
		fuel_mass		= 283.5,
		work_time		= 9999,
		min_fuel_rate	= 0.005,
		min_thrust		= -100,
		max_thrust		= 3000,
		thrust_Tau		= 0.0017,
	},
	
	booster_animation = {
		start_val = 0,
	},
	
	play_booster_animation = {
		val = 0,
	},
	
	
}


declare_weapon(STORM_SHADOW)

declare_loadout({
    category         = CAT_MISSILES,
    CLSID            = 'JAS_GB6',
    attribute        = STORM_SHADOW.wsTypeOfWeapon,
    Count            = 1,
    Cx_pil           = 0.000365,
    Picture          = "stormshadow.png",
    displayName      = _(stormshadow_name),
    Weight           = STORM_SHADOW.mass + pylon_mass,
    Elements         = {
        [1] = {
            ShapeName = "stormshadow",
            DrawArgs  = {
                [1] = {2, 1.0},
            }
        }
    },
    ejectImpulse     = 140,
})
