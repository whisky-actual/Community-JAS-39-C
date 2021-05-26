local wsType_BK90 = 11031
local wsType_BK90MJ1 = 11053
local wsType_BK90MJ2 = 11054
local wsType_BK90Test = 11032


local BK90_cluster_DATA = -- cluster data
{
	scheme = 
	{
		cluster =
		{
		wind_sigma					= 25,
		impulse_sigma				= 4,
		moment_sigma				= 0.1,
		count						= 24,
		effect_count				= 24,
		mass						= 18,
		caliber						= 0.132,
		cx_coeff					= {1, 0.39, 0.38, 0.236, 1.31},
		L							= 0.5,
		I							= 0.061333,
		Ma							= 0.06,
		Mw							= 0.8,
		model_name					= "MUS_JAS_2",
		connectors_model_name		= "BK_90",
		explosion_impulse_coeff		= 550,
		explosion_dont_use_x_axis	= 1,
		release_rnd_coeff			= 0.9,
		chute_open_time				= 0.7,
		chute_cut_time				= 500.0,
		chute_diam					= 1.8,
		chute_Cx					= 1,
		chute_rnd_coeff				= 0.65,
		explosion_center			=	{{0,0, -10000},{0,0,10000},},
		spawn_options				=	{
											{0,1,1}, {0,2,1}, {0,3,1}, {0,4,1},
											{0,5,1}, {0,6,1}, {0,7,1}, {0,8,1},
											{0,9,1}, {0,10,1}, {0,11,1}, {0,12,1},
											{0,13,1}, {0,14,1}, {0,15,1}, {0,16,1},
											{0,17,1}, {0,18,1}, {0,19,1}, {0,20,1},
											{0,21,1}, {0,22,1}, {0,23,1}, {0,24,1},
										},
		},
		
		warhead			=  cumulative_warhead(50.1, 120),
	},

	name    = _("BK-90 MJ2"),
	type_name = _("cluster"),
}


local BK_90 =
{
	category		= CAT_BOMBS,
	wsTypeOfWeapon	= {wsType_Weapon, wsType_Bomb, wsType_Bomb_Cluster, WSTYPE_PLACEHOLDER},
	type			= 5,
	mass			= 605.0,
	hMin			= 90.0,
	hMax			= 5000.0,
	Cx				= 0.000413,
	VyHold			= -100.0,
	Ag				= -1.23,

	name			= "BK_90",
	model			= "BK_90",
	user_name		= _("BK-90 Unguided Cluster Munition"),
	scheme			= "bomb-cassette-2",
	class_name		= "wAmmunition",
	
	
	
	fm =
    {
        mass            = 605.000000,
        caliber         = 0.335000,
        cx_coeff        = {1.000000, 0.390000, 0.600000, 0.168000, 1.310000},
        L               = 2.340000,
        I               = 101.298600,
        Ma              = 0.197848,
        Mw              = 1.987409,
        wind_time       = 1000.000000,
        wind_sigma      = 100.000000,
		model_roll 		= 0,
    },  
	
	shape_table_data =
	{
		{
			name     = "BK_90",
			file     = "BK_90",
			life     = 1,
			fire     = {0, 1},
			username = _("BK-90"),
			index    = WSTYPE_PLACEHOLDER,
		},
	},
	
	launcher = 
    {
        cluster = cluster_desc("Bomb_Other", wsType_Bomb_Cluster,combine_cluster(BK90_cluster_DATA,
        {
            cluster = {
					
					warhead			=  cumulative_warhead(50.1, 120),
					wind_sigma					= 25,
					impulse_sigma				= 4,
					moment_sigma				= 0.1,
					count						= 48,
					effect_count				= 24,
					mass						= 18,
					caliber						= 0.132,
					cx_coeff					= {1, 0.39, 0.38, 0.236, 1.31},
					L							= 0.5,
					I							= 0.061333,
					Ma							= 0.06,
					Mw							= 0.8,
					model_name					= "MUS_JAS_2",
					connectors_model_name		= "BK_90",
					explosion_impulse_coeff		= 550,
					explosion_dont_use_x_axis	= 1,
					release_rnd_coeff			= 0.9,
					chute_open_time				= 0.7,
					chute_cut_time				= 500.0,
					chute_diam					= 1.8,
					chute_Cx					= 1,
					chute_rnd_coeff				= 0.65,
					explosion_center			=	{{0,0, -10000},{0,0,10000},},
					spawn_options				=	{
														{0,1,1}, {0,2,1}, {0,3,1}, {0,4,1},
														{0,5,1}, {0,6,1}, {0,7,1}, {0,8,1},
														{0,9,1}, {0,10,1}, {0,11,1}, {0,12,1},
														{0,13,1}, {0,14,1}, {0,15,1}, {0,16,1},
														{0,17,1}, {0,18,1}, {0,19,1}, {0,20,1},
														{0,21,1}, {0,22,1}, {0,23,1}, {0,24,1},
													},
            }
        }, 
		"cluster"
		)
		)
    },
    
    control = 
    {
        default_delay		= 1.2,
		default_open_height = 457,
    },
	
	targeting_data = 
	{
		char_time				= 20.43,
		bomblet_char_time		= 23.8,
	}
}	

declare_weapon(BK_90)

declare_loadout({
	category 		= CAT_BOMBS,
	CLSID	 		= "JAS_BK90",
	attribute		= BK_90.wsTypeOfWeapon,
	Count 			= 1,
	Cx_pil			= BK_90.Cx,
	Picture			= "bk90.png",
	displayName		= BK_90.user_name,
	Weight			= BK_90.mass,
	Elements  		= {{ShapeName = "BK_90"}},
})
