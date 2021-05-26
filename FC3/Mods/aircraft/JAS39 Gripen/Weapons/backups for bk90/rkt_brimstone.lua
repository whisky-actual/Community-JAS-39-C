local brimstone_warhead =
{
    mass                 = 6.3, 
    caliber              = 120,
    expl_mass            = 6.3,
    piercing_mass        = 6.3*1.2,
    other_factors        = { 1.0, 1.0, 1.0 },
    concrete_factors     = { 1.0, 1.0, 1.0 },
    concrete_obj_factor  = 0.0,
    obj_factors          = { 1.0, 1.0 },
    cumulative_factor    = 4.0,
    cumulative_thickness = 1.75, 
}
local pylon_mass = 1.0

local brimstone_name  = 'Brimstone Laser Guided Missile'
local brimstone_mass  = 48.5
local brimstone_model = 'brimstone'


BRIM_STONE =
{
	category		= CAT_MISSILES,
	name            = brimstone_name,
    user_name       = _(brimstone_name),
	scheme			= "command_guided_spin_missile",
	class_name		= "wAmmunitionVikhr",
	model           = brimstone_model,
    mass            = brimstone_mass,
	
	wsTypeOfWeapon 	= {wsType_Weapon,wsType_Missile,wsType_AS_Missile,WSTYPE_PLACEHOLDER},
	Escort 			= 1,
	Head_Type 		= 7,
	sigma 			= {3, 3, 3},
	M 				= brimstone_mass,
	H_max 			= 18000.0,
	H_min 			= -1,
	Diam 			= 150.0,
	Cx_pil			= 2.5,
	D_max 			= 4300.0,
	D_min 			= 300.0,
	Head_Form 		= 0,
	Life_Time 		= 22.0,
	Nr_max 			= 10,
	v_min 			= 0.0,
	v_mid 			= 235.0,
	Mach_max 		= 1.2,
	t_b 			= 0.0,
	t_acc			= 0.9,
	t_marsh			= 17.5,
	Range_max		= 4300.0,
	H_min_t		    = 1.0,
	Fi_start 		= 0.03,
	Fi_rak 		    = 3.14152,
	Fi_excort 		= 0.79,
	Fi_search 		= 0.09,
	OmViz_max 		= 0.2,
	X_back 			= -1.455,
	Y_back 			= 0.0,
	Z_back			= 0.0,
	Reflection		= 0.0182,
	KillDistance 	= 0,
		
	shape_table_data =
	{
		{
			name	 = "brimstone_name",
			file	 = "brimstone_model",
			life	 = 1,
			fire	 = { 0, 1},
			username = "Brimstone",
			index	 = WSTYPE_PLACEHOLDER,
		},
	},
	
	
	controller = {
		boost_start = 0.001,
		march_start = 0.900,
	},
	
	booster = {
		impulse								= 155,
		fuel_mass							= 3.9,
		work_time							= 0.8,
		nozzle_position						= {{-0.5, 0.0, 0.0}},
		nozzle_orientationXYZ				= {{0.0, 0.0, 0.0}},
		tail_width							= 0.035,
		smoke_color							= {0.8, 0.8, 0.8},
		smoke_transparency					= 0.8,
		custom_smoke_dissipation_factor		= 0.0,				
	},
	
	march = {
		impulse								= 170,
		fuel_mass							= 5.24,
		work_time							= 17.5,
		nozzle_position						= {{-0.42, 0.0, 0.074},{-0.42, 0.0, -0.074},{-0.42, 0.074, 0.0},{-0.42,-0.074, 0.0 }},
		nozzle_orientationXYZ				= {{0.0, -0.18, 0.0},{0.0, 0.18, 0.0},{0.0, 0.0, 0.18},{0.0, 0.0, -0.18}},
		tail_width							= 0.025,
		smoke_color							= {0.85, 0.85, 0.85},
		smoke_transparency					= 0.07,
		custom_smoke_dissipation_factor		= 0.06,				
	},
	
	spiral_nav = {
											-- laser guidance simulation--	(use high values for wire/radio guidance)
		t_cone_near_rad			= 1000,		-- simple simulation radius (for bots)
		def_cone_max_dist		= 4300,		-- laser reach
		def_cone_near_rad		= 1000,		-- stab. radius
		def_cone_near_rad_st	= 0,		-- start radius
		def_cone_time_stab_rad	= 0,		-- stab. time
		
											-- start/dust avoidance program--
		gb_angle				= 0.006,	-- start angle above LOS (rad)
		gb_min_dist				= 1,		-- min distance to use this program
		gb_use_time				= 0.3,		-- time trigger: return aim to LOS
		gb_max_retW				= 0.9,		-- ret W max
		gb_ret_Kp				= 1.3,		-- ret power coeff.
	},
	
	fm  = {
		mass        = 24.5,  
		caliber     = 0.150,
		L           = 1.3,
		I           = 1 / 12 * 24.5 * 1.3 * 1.3,
		Ma          = 2.0,
		Mw          = 5.0,		
		cx_coeff    = {1,0.5,0.4,0.3,1.12},
		dCydA		= {0.024, 0.017},
		rail_open	= 0,
		A			= 0.6,
		Sw			= 0.45,
		maxAoa		= 0.2,
		finsTau		= 0.1,
		freq		= 4,
	},
	
	autopilot = {
		Kp					= 0.07,		--P
		Ki					= 0.004,	--I
		Kd					= 0.03,		--D
		max_ctrl_angle		= 1.0,		--turn off autopilot after reaching max angle
		delay				= 0.2,		--autopilot delay
		op_time				= 22.0,		--autopilot operation time
		no_ctrl_center_ang	= 0.00008,	--blind point at center (rad)
		fins_discreet		= 0.016,	
	},	
	
	eng_err = {
		y_error = 0.05,
		z_error = 0.05,
		min_time_interval = 0.1,
		max_time_interval = 0.9,
	},
	
	warhead     = brimstone_warhead,
    warhead_air = brimstone_warhead,
}

declare_weapon(BRIM_STONE)

declare_loadout({
    category        = CAT_MISSILES,
    CLSID           = 'JAS_BRM1_90',
    wsTypeOfWeapon  = BRIM_STONE.wsTypeOfWeapon,
    attribute       = {4, 4, 32, WSTYPE_PLACEHOLDER},
    Count           = 3,
    Cx_pil          = 0.0001,
    Picture         = "brimstone.png",
    displayName     = _(brimstone_name),
    Weight          = 48.5*3+50,
	Elements = {
	
		{
			ShapeName	=	"brimstone_triple_rack",
			IsAdapter = true,
		},
		
		{
			DrawArgs = {[1] = {1,1},[2] = {2,1},},
			Position	=	{0.15,	-0.18,	0.3}, --1
			ShapeName	=	"brimstone",
			Rotation = {0,0,0},
		},
		
		{
			DrawArgs = {[1] = {1,1},[2] = {2,1},},
			Position	=	{0.15,	-0.18,	-0.3}, --2
			ShapeName	=	"brimstone",
			Rotation = {0,0,0},
		},
		
		{
			DrawArgs = {[1] = {1,1},[2] = {2,1},},
			Position	=	{0.15,	-0.26, 0.0}, --3
			ShapeName	=	"brimstone",
			Rotation = {0,0,0},
		},		
		
	},
    
    JettisonSubmunitionOnly = false,
})
