local CBU97_CLUSTER_SCHEME_DATA  = {
	panel1 =
	{
		op_time					= 50,
		wind_sigma				= 5,
		impulse_sigma			= 1,
		moment_sigma			= 10,
		mass					= 15,
		caliber					= 0.1,
		L						= 2.3552,
		I						= 6,
		Ma						= 0.5,
		Mw						= 1,
		cx_coeff				= {1, 0.4,0.4,0.3,1.4},
		model_name				= "cbu97_panel1",
		init_pos				= {{0,0,0}},
		init_impulse			= {{0, 14.14, 0}},
	},
	
	panel2 =
	{
		op_time					= 50,
		wind_sigma				= 5,
		impulse_sigma			= 1,
		moment_sigma			= 10,
		mass					= 15,
		caliber					= 0.1,
		L						= 2.3552,
		I						= 6,
		Ma						= 0.5,
		Mw						= 1,
		cx_coeff				= {1, 0.4,0.4,0.3,1.4},
		model_name				= "cbu97_panel2",
		init_pos				= {{0,0,0}},
		init_impulse			= {{0, -10, -10}},
	},
	
	panel3 =
	{
		op_time					= 50,
		wind_sigma				= 5,
		impulse_sigma			= 1,
		moment_sigma			= 10,
		mass					= 15,
		caliber					= 0.1,
		L						= 2.3552,
		I						= 6,
		Ma						= 0.5,
		Mw						= 1,
		cx_coeff				= {1, 0.4,0.4,0.3,1.4},
		model_name				= "cbu97_panel3",
		init_pos				= {{0,0,0}},
		init_impulse			= {{0, 14.14, 0}},
	},
	
	dispenser = 
	{
		op_time					= 9000,
		wind_sigma				= 20,
		impulse_sigma			= 1,
		moment_sigma			= 1,
		mass					= 360,
		caliber					= 0.45,
		L						= 2.5,
		I						= 100,
		Ma						= 0.228,
		Mw						= 2.33,
		cx_coeff				= {1, 1, 1, 1, 2},
		model_name				= "cbu97_shaft",
		set_start_args			= {0,12,13},
		spawn_args_change		= {{1,12,0},{1,1,0.6}},
		spawn_time				= {0.02, 0.22, 0.42},
		spawn_weight_loss		= {0, 150, 150},
		spawm_args_change		= {{1,1,1},{1,12,0},{2,2,1}},
		op_spawns				= 3,
	},
	
	empty_dispenser = 
	{
		op_time					= 50,
		wind_sigma				= 5,
		impulse_sigma			= 1,
		moment_sigma			= 1,
		mass					= 45,
		caliber					= 0.45,
		L						= 2.5,
		I						= 2,
		Ma						= 0.03,
		Mw						= 0.3,
		cx_coeff				= {1, 1, 1, 1, 2},
		model_name				= "cbu97_shaft",
		set_start_args			= {0, 1, 2},
		spawn_options			= {{2, 2, 1}},
	},
	
	BLU_108 =
	{
		op_time					= 9000,
		count					= 10,
		effect_count			= 10,
		wind_sigma				= 5,
		impulse_sigma			= 1,
		moment_sigma			= 2,
		mass					= 29.5,
		caliber					= 0.133,
		L						= 0.7,
		I						= 2.4,
		Ma						= 0.90985,
		Mw						= 1.67549,
		cx_coeff				= {1, 0.39, 0.38, 0.236, 1.31},
		model_name				= "cbu97_blu108",
		set_start_args			= {13},
		connectors_model_name	= "cbu97_shaft",
		explosion_impulse_coeff	= 42,
		explosion_center		= {{0.36,0,0},{-0.44,0,0}},
		release_rnd_coeff		= 5,
		chute_open_time			= 0.3,
		chute_diam				= 2,
		chute_Cx				= 1.2,
		chute_rnd_coeff			= 0.3,
		spawn_options			= {{0,1,5},{0,2,5}},
			
		submunition_engine_impulse			= 60,
		submunition_engine_fuel_mass		= 0.1,
		submunition_engine_work_time		= 0.22,
		submunition_engine_rotation_moment	= 9,
		submunition_engine_start_height		= 32,
		skeets_release_delay				= 1.05,
		skeets_in_seq_release_delay			= 0.02,
		main_chute_open_speed				= 4,
		extr_chute_max_diam					= 0.3,
		opening_speed_k						= 2,
		jump_error_sum						= 440,
	},
	
	BLU_108_panel =
	{
		op_time 				= 50,
		wind_sigma				= 5,
		impulse_sigma			= 1,
		moment_sigma			= 1,
		mass					= 5,
		caliber					= 0.1,
		L						= 1,
		I						= 1,
		Ma						= 0.5,
		Mw						= 1,
		cx_coeff				= {1, 0.4, 0.4, 0.4, 1.4},
		model_name				= "cbu97_blu108_panel",
		init_pos				= {{0,0,0}},
		init_impulse			= {{0,125,0}},
		spawn_options			= {{0,1,1}},
	},
	
	skeet = 
	{
		op_time					= 9000,
		count					= 4,
		effect_count			= 4,
		wind_sigma				= 1,
		impulse_sigma			= 1,
		moment_sigma			= 1,
		mass					= 5,
		caliber					= 0.1,
		L						= 1,
		I						= 1,
		Ma						= 1,
		Mw						= 1,
		cx_coeff				= {1, 0.4, 0.4, 0.4, 1.4},
		model_name				= "cbu97_skeet",
		init_pos				= {{0.02,-0.15,0},{0.02,0.15,0},{0.25,-0.15,0},{0.25,0.15,0}},
		omega_impulse_coeff		= 3.6,
		release_rnd_coeff		= 12,
		set_start_args			= 10,
		spawm_options			= {{2,2,1},{3,3,1},{4,4,1},{5,5,1}},
			
		shell_model_name		= "shell",
		seeker_local_point		= {{0.05, -0.07, 0}},
		seeker_rotation_point	= {0, 0, 0},
		seeker_max_angle		= 0.392699,
		seeker_max_range		= 160,
		seeker_activation_time	= 0.3,
		shot_error				= 0.05,
		aim_lock_efficiency		= 0.66,
		shell_speed				= 500,
	},
	warhead = warheads["CBU97"],
}


local BK_90 =
{
	category		= CAT_BOMBS,
	
	--wsTypeOfWeapon = {wsType_Weapon, wsType_Bomb, wsType_Bomb_Cluster},
	wsTypeOfWeapon = {4,	5,	38,	35},
	type			= 4,
	mass			= 605.0,
	hMin			= 1000.0,
	hMax			= 10000.0,
	Cx				= 0.00133,
	VyHold			= -80.0,
	Ag				= -1.0,
	
	name			= "BK_90",
	model			= "BK_90",
	user_name		= _("BK-90"),
	scheme			= "bomb-cassette_new",
	class_name		= "wAmmunitionCbu",
	
	warhead = warheads["CBU_97"],
	
    fm =
    {
        mass            = 605.000000,
        caliber         = 0.41,
        cx_coeff        = {1.000000, 0.390000, 0.600000, 0.168000, 1.310000},
        L               = 2.3552,
        wind_time       = 1000.000000,
        wind_sigma      = 30.0,
    },  
    
    launcher =
    {
        cluster = cluster_desc("Bomb_Other", wsType_Bomb_Cluster, 
		{
			scheme = CBU97_CLUSTER_SCHEME_DATA,			
			name    		= _("BLU-108"),
			type_name		= _("cluster"),
			cluster_scheme	= "CBU_97",
		})
    },  
 
	targeting_data = 	{
    char_time = 20.40,
	bomblet_char_time = 99.14,
	},

}, 
declare_weapon(BK_90)



declare_loadout (
{
	CLSID	=	"JAS_BK90",
	Picture	=	"BK_90.png",
	displayName	=	_("BK-90"),
	Weight = BK_90.mass,
	
	attribute = BK_90.wsTypeOfWeapon,
	Count = 1,
	Cx_pil = BK_90.Cx,
	
	
	
	Elements	=	
	{
		[1]	=	
		{
			DrawArgs	=	
			{
				[1]	=	{1,	1},
				[2]	=	{2,	1},
			}, -- end of DrawArgs
			Position	=	{0,	0,	0},
			ShapeName	=	"BK_90",
		}, 
	}, -- end of Elements
})
