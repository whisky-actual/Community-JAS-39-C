local rb15 = {

	category		= CAT_MISSILES,
	name			= "rb15",
	user_name		= _("Rb-15F MK4"),
	wsTypeOfWeapon	= {wsType_Weapon, wsType_Missile, wsType_AS_Missile, WSTYPE_PLACEHOLDER},
	scheme			= "anti_radiation_missile",
	class_name		= "wAmmunitionSelfHoming",
	model			= "rb15f4",
	NatoName		= "(rb15)",

	shape_table_data =
	{
		{
			name	 = "rb15f4",
			file	 = "rb15f4",
			life	 = 1,
			fire	 = { 0, 1},
			username = _("rb15"),
			index	 = WSTYPE_PLACEHOLDER,
		},
	},

		Escort = 0,
		Head_Type = 3,
		sigma = {5, 5, 5},
		M = 770.0,
		H_max = 300.0,
		H_min = 35,
		Diam = 400.0,
		Cx_pil = 2.0,    --8.0
		D_max = 285000.0,
		D_min = 10000.0,
		Head_Form = 1,
		Life_Time = 1800.0,
		Nr_max = 18,
		v_min = 180.0,
		v_mid = 275.0,
		Mach_max = 1.9,  --1.1
		t_b = 0.0,
		t_acc = 1.0,
		t_marsh = 1200.0,
		Range_max = 285000.0,
		H_min_t = 0.0,
		Fi_start = 1,5709,
		Fi_rak = 3.14152,
		Fi_excort = 1,0472,
		Fi_search = 99.9,
		OmViz_max = 99.9,
		warhead = antiship_penetrating_warhead(5320, 5370),  
		-- No exhaust (turbo)
		X_back = -2.0,
		Y_back = -0.2,
		Z_back = 0.0,
		Reflection = 0.02,
		KillDistance = 25.0, 
		add_attributes = {"Cruise missiles"},


-- Missile Flight Model Data
	fm = {
		mass		= 770.0,
		caliber		= 0.400,
		cx_coeff	= {1, 0.3, 0.65, 0.010, 1.6},
		L			= 4.2,
		I			= 1 / 12 * 770.0 * 4.2 * 4.2, -- 1131.9 moment of inertia
		Ma			= 0.3,
		Mw			= 1.116,
		wind_sigma	= 0.0,
		wind_time	= 1000.0,
		Sw			= 1.2,
		dCydA		= {0.07, 0.036},
		A			= 0.06,
		maxAoa		= 0.26,
		finsTau		= 1.25,	-- !	?????? ????? / wingspan
		Ma_x		= 2,
		Ma_z		= 2,
		Kw_x		= 0.05,
		addDeplSw		= 1.0,
		wingsDeplDelay	= 1.0,
	},

-- Missile Engine Data
	controller = {
		boost_start = 0.01,  --0.001
		march_start = 1.001,
	},

	booster = {
		impulse								= 550, 
		fuel_mass							= 30.0,  
		work_time							= 1.0,   
		boost_time							= 0,
		boost_factor						= 0,
		nozzle_position						= {{-2.2, -0.28, 0}},  
		nozzle_orientationXYZ				= {{0.0, 0.0, 0.0}},  
		tail_width							= 0.03,  
		smoke_color							= {1.0, 1.0, 1.0},  
		smoke_transparency					= 0.5,          
		custom_smoke_dissipation_factor		= 0.0,
	},

	march = {
		impulse								= 890,    
		fuel_mass							= 720.0,  
		work_time							= 3200,  
		boost_time							= 0,
		boost_factor						= 0,
		nozzle_position						= {{-2.15, -0.28, 0}},  --= {{-1.0, -0.2, 0}},
		nozzle_orientationXYZ				= {{0.0, 0.0, 0.0}},
		tail_width							= 0.01,
		smoke_color							= {0.5, 0.5, 0.5},    --{0.1, 0.1, 0.1},
		smoke_transparency					= 0.3,    --0.3,
		custom_smoke_dissipation_factor		= 0.1,    
	},

-- Missile Radar Homing Data   
	radio_seeker = {
		FOV					= math.rad(8),   --0
		op_time				= 1500,
		keep_aim_time		= 5,
		pos_memory_time		= 200,
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
	
	warhead		= antiship_penetrating_warhead(4310, 4370), -- 3310 3370
	warhead_air = antiship_penetrating_warhead(4310, 4370), --3310 3370
		
}

declare_weapon(rb15, { mass = 770 })

declare_loadout(
	{
		category		= CAT_MISSILES,
		Picture			= "Rb15.png",
		displayName		= rb15.user_name,
		Weight			= rb15.mass,
		CLSID			= "JAS_RB15F",
		attribute		= rb15.wsTypeOfWeapon,
		Count			= 1,
		Cx_pil			= 0.001,
		ejectImpulse	= 5000,
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
				ShapeName	=	"rb15f4",
					},
		}, -- end of Elements
	}
)