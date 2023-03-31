
local jas39_rbs15ai_name = 'RBS-15 Mk4 AShM'

local jas39_rbs15ai_warhead = {
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

local jas39_rbs15_ai = {
	category		= CAT_MISSILES,
	name			= jas39_rbs15ai_name,
	displayName		= _("RBS-15 Mk4 AShM for AI"),		
	user_name 		= _("RBS15"),
	mass			= 650,
	model			= 'jas39_rbs-15',
	wsTypeOfWeapon  = {wsType_Weapon,wsType_Missile,wsType_AS_Missile,WSTYPE_PLACEHOLDER},
	Escort 			= 0,
	Head_Type 		= 5,  
	sigma 			= {4, 4, 4},
	M 				= 650.0,   
	H_max 			= 15000.0,  
	H_min 			= -1,  
	Diam 			= 343.0,
	Cx_pil 			= 1,   
	D_max 			= 300000.0, 
	D_min 			= 2000.0,
	Head_Form 		= 1, 
	Life_Time 		= 1800.0,   
	Nr_max 			= 12,  
	v_min 			= 170.0,
	v_mid 			= 450.0,  
	Mach_max 		= 1.3,  
	t_b 			= 0.0,
	t_acc 			= 4.0, 
	t_marsh         = 1800.0,  
	Range_max 		= 300000.0, 
	H_min_t 		= 0.0,
	Fi_start 		= 3.14152,
    Fi_rak 			= 3.14152,
    Fi_excort 		= 3.14152,
    Fi_search 		= 99.9,
    OmViz_max 		= 99.9,	
	Stage			= 2,
	Engine_Type		= 6,
	exhaust1 		= { 1, 1, 1, 1 },
	X_back 			= -2.7,  
	Y_back 			= 0.0, 
	Z_back 			= 0.0,  
	X_back_acc 		= -2.7,
    Y_back_acc 		= 0.0,
    Z_back_acc 		= 0.0,
	Reflection 		= 0.15, 
	KillDistance 	= 0.0, 
	add_attributes = {"Cruise missiles"},	

	warhead	= jas39_rbs15ai_warhead,
	warhead_air = jas39_rbs15ai_warhead,

	manualWeaponFlag = 2,
	
	shape_table_data = 
	{
		{

			name	 = jas39_rbs15ai_name,
			file  	 = "jas39_rbs-15";   		
			life  	 = 1;
			fire  	 = { 0, 1};
			username = _("RBS15"),
			index = WSTYPE_PLACEHOLDER;
		},
	},
	
    class_name      = "wAmmunitionSelfHoming",
    scheme          = "anti_ship_missile_tb",

    fm = {
        mass            = 715,
        caliber         = 0.36,
        cx_coeff        = {1, 0.3, 0.65, 0.018, 1.6},
        L               = 5.145,
        I               = 1 / 12 * 715.0 * 5.145 * 5.145,
        Ma              = 0.6,
        Mw              = 1.116,
        wind_sigma      = 0.0,
        wind_time       = 1000.0,
        Sw              = 0.75,
        dCydA           = {0.07, 0.036},
        A               = 0.08,
        maxAoa          = 0.3,
        finsTau         = 0.05,
        Ma_x            = 3,
        Ma_z            = 3,
        Kw_x            = 0.05,
    },

    simple_seeker = {
        delay        = 1.0,
        FOV          = math.rad(120),
        stTime       = 0.5,
        opTime       = 9999,
    },
	
	simple_gyrostab_seeker = {
		omega_max	= math.rad(120)
	},	

    autopilot =    --inertial autopilot + horiz correction when seeker is on
    {
        delay                      = 1,        -- time delay
        Kpv                        = 0.02,     -- vertical control PID
        Kdv                        = 2,
        Kiv                        = 0.00006,
        Kph                        = 500.0,    -- horiz control PID
        Kdh                        = 5.0,
        Kih                        = 0.0,
        glide_height               = 6.0,      -- cruise glide height
        use_current_height         = 1,        -- keep launch height
        max_vert_speed             = 70.0,      -- max vertical speed kept from launch height to glide height
        altim_vel_k                = 1.0,      -- proximity sensor correction by velocity coeff
        finsLimit                  = 0.9,      -- max signal value from autopilot to fins
        inertial_km_error          = 8.0,      -- inertial guidance error coeff to 1 km flight distance
    },

    final_autopilot =        -- final stage guidance with terminal maneuver
    {
        delay                    = 0,
        K                        = 60,       -- autopilot P
        Ki                       = 0,        -- I
        Kg                       = 6,        -- D
        finsLimit                = 0.9, 
        useJumpByDefault         = 0,        
        J_Power_K                = 2.0,      -- terminal maneuver params: P
        J_Diff_K                 = 0.8,      -- D
        J_Int_K                  = 0,        -- I
        J_Angle_K                = 0.7,      -- jump maneuver angle
        J_FinAngle_K             = 0.52,     -- jump inactivation trigger angle to target
        J_Angle_W                = 3.0,      -- max maneuver angle speed
        bang_bang                = 0,        -- use only -1, 1 values to control fins
        J_Trigger_Vert           = 1,        -- use global y axis
		
    },

    h_glide_on = {            -- turn on seeker and start horiz. correction if target is locked on
        delay                   = 1,
        trigger_dist            = 20000,
    },

    mode_switcher = {        -- use final maneuver if target is locked on
        delay           = 1,
        trigger_dist    = 4000,
    },

    self_destruct =         -- if seeker still can not find a target explode warhead
    {
        delay = 1,
        trigger_dist            = 1000,
        inactivation_dist       = 900,
    },

    controller = {
        boost_start = 0.3,
        march_start = 2.0,
    },

    boost = {
        impulse                             = 0,
        fuel_mass                           = 0,
        work_time                           = 0,
        boost_time                          = 0,
        boost_factor                        = 0,
		nozzle_position						= {{-3.85, 0.0, 0.475},{-3.85, 0.0, -0.475}},
		nozzle_orientationXYZ				= {{0.0, -0.5, 0.0},{0.0, 0.5, 0.0}},
        tail_width                          = 0.1,
        smoke_color                         = {1, 1, 1},
		smoke_transparency					= 0.5,
		custom_smoke_dissipation_factor		= 0.5,
    },

    booster_animation = {
        start_val = 1, -- start arg.1 value ( default value without animation)
    },

    play_booster_animation = {
        val = 0, -- 1/0
    },

    encyclopediaAnimation = {
        args = {
            [1] = 1.00,
        },
    },

    march = {
        impulse          = 660,
        fuel_mass        = 100,
        work_time        = 9999,
        min_fuel_rate    = 0.005,
        min_thrust       = 0,
        max_thrust       = 5000,
        thrust_Tau       = 0.0017,
    },

    engine_control = {
        default_speed   = 330,
        K               = 300,
        Kd              = 0.01,
        Ki              = 0.001,
        burst_signal    = 9999, -- used in 'anti_ship_missile_tb' scheme
    },	
	
}
declare_weapon(jas39_rbs15_ai)

declare_loadout(
	{
		category		= CAT_MISSILES,
		Picture			= "jas39_RBS-15.png",
		wsTypeOfWeapon  = jas39_rbs15_ai.wsTypeOfWeapon,				
		displayName		= _("RBS-15 Mk4 AShM for AI"),
		Weight			= jas39_rbs15_ai.mass,
		CLSID			= "{JAS39_RBS15AI}",
		attribute		= jas39_rbs15_ai.wsTypeOfWeapon,
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