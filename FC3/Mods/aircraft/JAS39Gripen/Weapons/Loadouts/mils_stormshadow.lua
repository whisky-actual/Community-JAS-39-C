local stormshadow = {

	category		= CAT_MISSILES,
	name			= "stormshadow",
	user_name		= _("Storm Shadow"),
	wsTypeOfWeapon	= {wsType_Weapon, wsType_Missile, wsType_AS_Missile, WSTYPE_PLACEHOLDER},
	scheme			= "anti_radiation_missile",
	class_name		= "wAmmunitionSelfHoming",
	model			= "stormshadow",
	NatoName		= "(stormshadow)",

	shape_table_data =
	{
		{
			name	 = "stormshadow",
			file	 = "stormshadow",
			life	 = 1,
			fire	 = { 0, 1},
			username = _("stormshadow"),
			index	 = WSTYPE_PLACEHOLDER,
		},
	},

		Escort = 0,
		Head_Type = 3,
		sigma = {2, 2, 2},
		M = 1100.0,
		H_max = 15000.0, 
		H_min = -1,
		Diam = 480.0,
		Cx_pil = 8,
		D_max = 548192.0, 
		D_min = 10000.0,
		Head_Form = 1,
		Life_Time = 100000,
		Nr_max = 6,
		v_min = 170.0,
		v_mid = 237.5,
		Mach_max = 0.90,  
		t_b = 0.0,
		t_acc = 5.0,
		t_marsh = 10000.0,
		Range_max = 548192.0,
		H_min_t = 500.0,
		Fi_start = 0.35,
		Fi_rak = 3.14152,
		Fi_excort = 0.7,
		Fi_search = 99.9,
		OmViz_max = 99.9,
		warhead     = HE_penetrating_warhead(500.0,480),
		warhead_air = HE_penetrating_warhead(500.0,480),
		-- No exhaust (turbo)
		X_back = -3.392,
		Y_back = 0.064,
		Z_back = 0.0,
		Reflection = 0.05,
		KillDistance = 25.0, 
		add_attributes = {"Cruise missiles"},


-- Missile Flight Model Data
	fm = {
		mass		= 1300,  
		caliber		= 0.480, 
		cx_coeff	= {1, 0.3, 0.65, 0.018, 1.6},
		L			= 4.37,
		I			= 1 / 12 * 1300 * 4.2 * 4.2, 
		Ma			= 3,
		Mw			= 10,
		wind_sigma	= 0.0,
		wind_time	= 1000.0,
		Sw			= 1.2,
		dCydA		= {0.07, 0.036},
		A			= 0.08,
		maxAoa		= 0.2,
		finsTau		= 0.08,	-- !	?????? ????? / wingspan
		Ma_x		= 3,
		Ma_z		= 3,
		Kw_x		= 0.05,
		addDeplSw		= 1.0,
		wingsDeplDelay	= 1.0,
	},

-- Missile Engine Data
	controller = {
		boost_start = 0.001,  
		march_start = 0.8,
	},

	booster = {					--	air launch - no booster
		impulse								= 690, 
		fuel_mass							= 10,  
		work_time							= 2,   
		boost_time							= 0,
		boost_factor						= 0,
		nozzle_position						= {{0, 0, 0}},
		nozzle_orientationXYZ				= {{0.0, 0.0, 0.0}},  
		tail_width							= 0.00,  
		smoke_color							= {0.0, 0.0, 0.0},  
		smoke_transparency					= 0.0,          
		custom_smoke_dissipation_factor		= 0.0,
	},

	march = {
		impulse								= 690,   
		fuel_mass							= 283.5,
		work_time							= 9999,  
		boost_time							= 0,
		boost_factor						= 0,
		nozzle_position						= {{-0.15, -0.285, 0}},  --= {{-1.0, -0.2, 0}},
		nozzle_orientationXYZ				= {{0.0, 0.0, 0.0}},
		tail_width							= 0.01,
		smoke_color							= {0.5, 0.5, 0.5},    --{0.1, 0.1, 0.1},
		smoke_transparency					= 0.3,    --0.3,
		custom_smoke_dissipation_factor		= 0.1,    
	},

-- Missile Radar Homing Data   
	radio_seeker = {
		FOV					= math.rad(8),   
		op_time				= 9999,
		keep_aim_time		= 10,
		pos_memory_time		= 400,
		sens_near_dist		= 300.0,
		sens_far_dist		= 300000.0,
		err_correct_time	= 2.5,
		err_val				= 0.0025,
		calc_aim_dist		= 500000,
		blind_rad_val		= 0.1,
		blind_ctrl_dist		= 2100,
		aim_y_offset		= 3.0,
	},

	simple_seeker =	{
		sensitivity = 0,
		delay		= 0.0,
		FOV			= math.rad(8),    --0
		maxW		= 500,
		opTime		= 9999,
	},

	simple_gyrostab_seeker = {
		omega_max	= math.rad(10)
	},

	fuze_proximity = {
		ignore_inp_armed	= 1,
		arm_delay			= 10,
		radius				= 0,
	},

-- Missile Flight Control Data 
	autopilot = {
		delay			 = 1.0,
		K				 = 500.0,  
		Kg				 = 15.0,  
		Ki				 = 0.0,  
		finsLimit		 = 0.9, 
		useJumpByDefault = 1, 
		J_Power_K		 = 2.2,  
		J_Diff_K		 = 0.8,  
		J_Int_K			 = 0.0,
		J_Angle_K		 =  math.rad(05),   
		J_FinAngle_K	 =  math.rad(15),  
		J_Angle_W		 = 0.5,    
		auto_terrain_following			= 1,
		auto_terrain_following_height	= 60,
	},

	start_helper = {
		delay				= 1.0,
		power				= 0.1,
		time				= 1,
		use_local_coord		= 0,
		max_vel				= 200,
		max_height			= 200,
		vh_logic_or			= 0,
	},

triggers_control = {
		action_wait_timer				= 5,	-- wait for dist functions n sen, then set default values
		default_sensor_tg_dist			= 11000, -- turn on seeker and start horiz. correction if target is locked
		default_final_maneuver_tg_dist	= 7000,
		default_straight_nav_tg_dist	= 7000,
		default_destruct_tg_dist		= 3000,	-- if seeker still can not find a target explode warhead after reaching pred. target point + n. km
		trigger_by_path					= 1,
		final_maneuver_trig_v_lim		= 3,
		use_horiz_dist					= 1,
		pre_maneuver_glide_height		= 1524,	-- triggers st nav instead of fin. maneuver if h>2*pre_maneuver_glide_height at fin. maneuver distance
		min_cruise_height				= 1524,
		min_cruise_height_trigger_sum	= 11000,	
		min_cruise_height_trigger_mlt	= 237/33,		
	},
	
	
		
}

declare_weapon(stormshadow)

declare_loadout(
	{
		category		= CAT_MISSILES,
		Picture			= "stormshadow.png",
		displayName		= stormshadow.user_name,
		Weight			= stormshadow.mass,
		CLSID			= "JAS_Stormshadow",
		attribute		= stormshadow.wsTypeOfWeapon,
		Count			= 1,
		Cx_pil			= 0.000365,
		ejectImpulse	= 140,
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
				ShapeName	=	"stormshadow",
					},
		}, -- end of Elements
	}
)