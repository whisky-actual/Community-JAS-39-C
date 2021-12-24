local jas39_rbs15ai_name = 'RBS-15 Mk4 Gungnir Anti-ship Missile (AI)'

local jas39_rbsai15_warhead = {
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

local jas39_rbsai15_mass = 650

local jas39_rbsai15 = {

	category		= CAT_MISSILES,
	name			= jas39_rbs15ai_name,
	user_name		= _(jas39_rbs15ai_name),
	wsTypeOfWeapon	= {wsType_Weapon, wsType_Missile, wsType_AS_Missile, WSTYPE_PLACEHOLDER},
	scheme			= "anti_ship_missile_prog_path",
	class_name		= "wAmmunitionCruise",
	model			= "jas39_rbs-15",
	NatoName		= "(Gungnir)",

	shape_table_data =
	{
		{
			name	 = jas39_rbs15ai_name,
			file	 = "jas39_rbs-15",
			life	 = 1,
			fire	 = { 0, 1},
			username = _("RBS15AI"),
			index	 = WSTYPE_PLACEHOLDER,
		},
	},

		Escort = 0,
		Head_Type = 5,
		sigma = {5, 5, 5},
		M = jas39_rbsai15_mass,
		H_max = 15000.0,
		H_min = 4500,
		Diam = 500.0,
		Cx_pil = 5, 
		D_max = 250000.0,
		D_min = 7000.0,
		Head_Form = 1, 
		Life_Time = 9999,
		Nr_max = 20,
		v_min = 170.0,
		v_mid = 400.0,
		Mach_max = 1.5, 
		t_b = 0.0,	
		t_acc = 6.0,	
		t_marsh = 150.0,
		Range_max = 300000.0,
		H_min_t = 0.0,
		Fi_start = 0.25,
		Fi_rak = 3.14152,
		Fi_excort = 3.14152,
		Fi_search = 99.9,
		OmViz_max = 99.9,
		X_back = -1.341,
		Y_back = -0.178,
		Z_back = 0.0,
		Reflection = 0.3,	
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

		warhead		= jas39_rbsai15_warhead,
		warhead_air = jas39_rbsai15_warhead,


	fm = {
		mass        = jas39_rbsai15_mass,  
		caliber     = 0.500,  
		cx_coeff    = {1,0.4,1.1,0.5,1.4},
		L           = 4.35,
		I           = 1 / 12 * jas39_rbsai15_mass * 4.35 * 4.35,
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
	},
	
	simple_seeker = {
		delay		= 1.0,
		FOV			= math.rad(60),
		stTime		= 0.5,
		opTime		= 9999,
	},
	
	autopilot =
	{
		delay						= 1.0,
		Kpv							= 0.026,
		Kdv							= 8.0,
		Kiv							= 0.000004,
		Kph							= 28.0,
		Kdh							= 3.0,
		Kih							= 0.0,
		cmd_K						= 12.0,
		cmd_Kd						= 10.0,
		glide_height				= 4.0,
		use_current_height			= 1,
		max_vert_speed 				= 70.0,
		altim_vel_k					= 1.0,
		finsLimit					= 0.68,
		inertial_km_error			= 0.2,
		max_heading_err_val 		= 0.09,		
		skim_glide_height			= 4.0,
		pre_maneuver_glide_height	= 4.0,
	},
	
	final_autopilot =		
	{
		delay				= 0, 
		K					= 60,
		Ki					= 0,
		Kg					= 16,
		finsLimit			= 0.9,		
		useJumpByDefault	= 1,
		J_Power_K			= 2.0,
		J_Diff_K			= 0.8,
		J_Int_K				= 0,
		J_Angle_K			= 0.24,
		J_FinAngle_K		= 0.32,
		J_Angle_W			= 2.4,
		bang_bang			= 0,
		J_Trigger_Vert		= 1,
	},
	
	h_glide_on = {			-- turn on seeker and start horiz. correction if target is locked on
		delay				= 1,
		trigger_dist		= 8000,
	},
	
	mode_switcher = {		-- use final maneuver if target is locked on
		delay = 1,
		trigger_dist		= 4000,
	},
	
	self_destruct = 		-- if seeker still can not find a target explode warhead
	{
		delay = 1,
		trigger_dist		= 1000,
		inactivation_dist	= 900,
	},

	controller = {
		boost_start = 1,
		march_start = 4,
	},
	
	boost = {				
		impulse								= 195, 
		fuel_mass							= 115,
		work_time							= 6, 
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
	},
	
	engine_control = {
		default_speed	= 400,
		K				= 265,
		Kd				= 0.01,
		Ki				= 0.001,
	},
	
	
		
}

declare_weapon(jas39_rbsai15)

declare_loadout(
	{
		category		= CAT_MISSILES,
		Picture			= "jas39_RBS-15.png",
		displayName		= jas39_rbsai15.user_name,
		Weight			= jas39_rbsai15_mass,
		CLSID			= "{JAS39_RBS15AI}",
		attribute		= jas39_rbsai15.wsTypeOfWeapon,
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