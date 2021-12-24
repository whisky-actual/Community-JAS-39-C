
local jas39_kepd350_arm_mass = 1400

local jas39_kepd350_arm = {

	category		= CAT_MISSILES,
	name			= "jas39_kepd350_arm",
	user_name		= _("KEPD 350 Long Range Anti-Radiation Cruise-missile"),
	wsTypeOfWeapon	= {wsType_Weapon, wsType_Missile, wsType_AS_Missile, WSTYPE_PLACEHOLDER},
	scheme			= "cruise_missile",
	class_name		= "wAmmunitionCruise",
	model			= "jas39_kepd350",
	NatoName		= "(kepd350)",

	shape_table_data =
	{
		{
			name	 = "jas39_kepd350_arm",
			file	 = "jas39_kepd350",
			life	 = 1,
			fire	 = { 0, 1},
			username = _("KEPD350"),
			index	 = WSTYPE_PLACEHOLDER,
		},
	},

	Escort			= 0,
	Head_Type		= 3,
	sigma			= {1, 1, 1},
	M		        = jas39_kepd350_arm_mass,
	H_max			= 15000.0, 
	H_min			= -1,
	Diam			= 480.0,
	Cx_pil			= 8,
	D_max			= 400000.0, 
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
	Range_max		= 400000.0,
	H_min_t			= 500.0,
	Fi_start		= 0.35,
	Fi_rak			= 3.14152,
	Fi_excort		= 0.7,
	Fi_search		= 99.9,
	OmViz_max		= 99.9,
	X_back = -3.392,
	Y_back = 0.064,
	Z_back = 0.0,
	Reflection = 0.125,
	KillDistance = 0.0,

	warhead     = penetrating_warhead(2500.0,480),
	warhead_air = penetrating_warhead(2500.0,480),

	manualWeaponFlag = 1,

	LaunchDistData =
    {
          6,        7,
                   100,      125,      150,      175,       200,       250,       300,
        1500,    363000,      368000,    373000,      378000,     383000,    388000,       393000,
        2000,    370000,      375000,    380000,      385000,     389000,    394000,       400000,
        2500,    376000,      381000,    386000,      391000,     394000,    399000,       400000,
        3000,    381000,      386000,    391000,      396000,     399000,    400000,       400000,
        5000,    385000,      390000,    395000,      399000,     400000,    400000,       400000,
        7500,    390000,      395000,    400000,      400000,     400000,    400000,       400000,
    },

	fm = {
		mass        = jas39_kepd350_arm_mass,  
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
		auto_terrain_following_height	= 30,
		
		alg_points_num			= 7,
		alg_calc_time			= 1.5,
		alg_vel_k				= 6,
		alg_div_k				= 2,
		alg_max_sin_climb		= 0.7,
		alg_section_temp_points	= 3,
		alg_tmp_point_vel_k		= 1.5,
		no_alg_vel_k			= 10,
		
		max_roll			= 0.7,
		max_start_y_vel		= 70, --35
		stab_vel			= 330,
		finsLimit			= 0.8,
		estimated_N_max		= 6,
		eng_min_thrust		= -100,
		eng_max_thrust		= 3000,
	},

	final_autopilot =        -- final stage guidance with terminal maneuver
    {
        delay               = 0,
        K                   = 60,       -- autopilot P
        Ki                  = 0,        -- I
        Kg                  = 15,       -- D
        finsLimit           = 0.68,
        useJumpByDefault    = 1,        --
        J_Power_K           = 2.8,      -- terminal maneuver params: P
        J_Diff_K            = 0.8,      -- D
        J_Int_K             = 0,        -- I
        J_Angle_K           = 0.8,     -- jump maneuver angle
        J_FinAngle_K        = 0.65,     -- jump inactivation trigger angle to target
        J_Angle_W           = 4.0,      -- max maneuver angle speed
        bang_bang           = 0,        -- use only -1, 1 values to control fins
        J_Trigger_Vert      = 1,        -- use global y axis
    },
	
	control_block ={
		seeker_activation_dist		= 7000,
		default_cruise_height		= 50,
		obj_sensor					= 0,
		can_update_target_pos		= 1,
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
		work_time		= 1100,
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

declare_weapon(jas39_kepd350_arm)

declare_loadout(
	{
		category		= CAT_MISSILES,
		Picture			= "jas39_kepd350.png",
		displayName		= jas39_kepd350_arm.user_name,
		Weight			= jas39_kepd350_arm_mass,
		CLSID			= "{JAS39_KEPD350_ARM}",
		attribute		= jas39_kepd350_arm.wsTypeOfWeapon,
		Count			= 1,
		Cx_pil			= 0.000365,
		ejectImpulse	= 140,
    Elements         = {
        [1] = {
            ShapeName = "jas39_kepd350",
            DrawArgs  = {
                [1] = {2, 1.0},
            }
        }
    },
	}
)