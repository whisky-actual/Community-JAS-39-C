local rb15f_warhead = {
    mass                 = 200, 
    caliber              = 500,
    expl_mass            = 100,
    piercing_mass        = 50,
    other_factors        = { 1.0, 1.0, 1.0 },
    concrete_factors     = { 5.0, 1.0, 1.0 },
    concrete_obj_factor  = 2.0,
    obj_factors          = { 5.0, 1.0 },
    cumulative_factor    = 2.0,
    cumulative_thickness = 0.0,
}

local mass = 650

local rb15 = {

	category		= CAT_MISSILES,
	name			= "rb15",
	user_name		= _("RBS-15 Mk. IV Gungnir Radiation Seeking Anti-ship Missile "),
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
			username = _("Rb15"),
			index	 = WSTYPE_PLACEHOLDER,
		},
	},

		Escort = 0,
		Head_Type = 3,
		sigma = {5, 5, 5},
		M = mass,
		H_max = 2500.0,
		H_min = 10,
		Diam = 360.0,
		Cx_pil = 2.5,    
		D_max = 300000.0,
		D_min = 2000.0,
		Head_Form = 1,
		Life_Time = 2400.0,
		Nr_max = 20,
		v_min = 270.0,
		v_mid = 372.0,
		Mach_max = 1.3,  --1.1
		t_b = 5.0,
		t_acc = 0.0,
		t_marsh = 1800.0,
		Range_max = 300000.0,
		H_min_t = 0.0,
		Fi_start = 0.25,
		Fi_rak = 3.14152,
		Fi_excort = 3.14152,
		Fi_search = 99.9,
		OmViz_max = 99.9,
		
		
		X_back = -2.0,
		Y_back = -0.2,
		Z_back = 0.0,
		Reflection = 0.006,
		KillDistance = 25.0, 
		add_attributes = {"Cruise missiles"},
		
		warhead		= rb15f_warhead,
		warhead_air = rb15f_warhead,


-- Missile Flight Model Data
	fm = {
		mass		= mass, 
		caliber		= 0.36,
		cx_coeff	= {1, 0.3, 0.65, 0.010, 1.6},
		L			= 5.145,
		I			= 1 / 12 * mass * 4.2 * 4.2, --  moment of inertia
		Ma			= 0.6,
		Mw			= 1.116,
		wind_sigma	= 0.0,
		wind_time	= 1000.0,
		Sw			= 0.85,
		dCydA		= {0.07, 0.036},
		A			= 0.08,
		maxAoa		= 0.30,
		finsTau		= 0.05,	-- !	?????? ????? / wingspan
		Ma_x		= 3,
		Ma_z		= 3,
		Kw_x		= 0.05,
		addDeplSw		= 1.0,
		wingsDeplDelay	= 1.0,
	},

-- Missile Engine Data
	controller = {
		boost_start = 0.01,  --0.001
		march_start = 0.5,
	},

	booster = {
		impulse								= 800,		-- added some initial boost to avoid collision with aircraft
		fuel_mass							= 1,
		work_time							= 1,
		boost_time							= 0,
		boost_factor						= 0,
		nozzle_position						= {{-0.5, 0.0, 0.0}},
		nozzle_orientationXYZ				= {{0.0, 0.0, 0.0}},  
		tail_width							= 0.0,
		smoke_color							= {0.0, 0.0, 0.0},
		smoke_transparency					= 0.0,          
		custom_smoke_dissipation_factor		= 0.0,
	},

	march = {
		impulse								= 840,    
		fuel_mass							= 120,   
		work_time							= 9999,
		boost_time							= 0,
		boost_factor						= 0,
		nozzle_position						= {{-0.5, 0.0, 0.0}},
		nozzle_orientationXYZ				= {{0.0, 0.0, 0.0}},
		tail_width							= 0.1,
		smoke_color							= {0.0, 0.0, 0.0},
		smoke_transparency					= 0.1,    --0.3,
		custom_smoke_dissipation_factor		= 0.2,    
	},

-- Missile Radar Homing Data   
	radio_seeker = {
		FOV					= math.rad(60.0),   --0
		op_time				= 9999.0,
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
		FOV			= math.rad(60.0),    --0
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
		finsLimit		 = 0.68, 
		useJumpByDefault = 1, 
		J_Power_K		 = 2.2,  
		J_Diff_K		 = 0.8,  
		J_Int_K			 = 0.0,
		J_Angle_K		 =  math.rad(05),   
		J_FinAngle_K	 =  math.rad(15),  
		J_Angle_W		 = 0.5,  
		glide_height              = 50.0,
		skim_glide_height         = 5.0,
				
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
        action_wait_timer               = 5,    -- wait for dist functions n sen, then set default values
        default_sensor_tg_dist          = 30000, -- turn on seeker and start horiz. correction if target is locked
        default_final_maneuver_tg_dist  = 5000,
        default_straight_nav_tg_dist    = 750,
        default_destruct_tg_dist        = 280000, -- if seeker still can not find a target explode warhead after reaching pred. target point + n. km
        trigger_by_path                 = 1,
        pre_maneuver_glide_height       = 5,    -- triggers st nav instead of fin. maneuver if h>2*pre_maneuver_glide_height at fin. maneuver distance --19
        use_horiz_dist                  = 1,
    },
	
	
		
}

declare_weapon(rb15, { mass = 650 })

declare_loadout(
	{
		category		= CAT_MISSILES,
		Picture			= "Rb15.png",
		displayName		= rb15.user_name,
		Weight			= rb15.mass,
		CLSID			= "JAS_RB15F",
		attribute		= rb15.wsTypeOfWeapon,
		Count			= 1,
		Cx_pil			= 0.001,  --/note: This is too low but its the one HB uses and it works fine
		ejectImpulse	= 50,
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