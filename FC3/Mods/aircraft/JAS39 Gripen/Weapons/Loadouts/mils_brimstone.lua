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
	category        = CAT_MISSILES,
    name            = brimstone_name,
    user_name       = _(brimstone_name),
    model           = brimstone_model,
    mass            = brimstone_mass,
	scheme			= "command_guided_spin_missile",
	class_name		= "wAmmunitionVikhr",
	wsTypeOfWeapon  = {wsType_Weapon, wsType_Missile, wsType_AS_Missile, WSTYPE_PLACEHOLDER},
	
	Escort = 1,
	Head_Type = 4,
	sigma = {3, 3, 3},
	M = 43.0,
	H_max = 5000.0,
	H_min = 5.0,
	Diam = 120.0,
	Cx_pil = 0.0001,
	D_max = 20000.0,
	D_min = 500.0,
	Head_Form = 0,
	Life_Time = 30.0,
	Nr_max = 12,
	v_min = 140.0,
	v_mid = 600.0,
	Mach_max = 3.0,
	t_b = 0.0,
	t_acc = 5.0,
	t_marsh = 5.0,
	Range_max = 20000.0,
	H_min_t = 0.0,
	Fi_start = 0.5,
	Fi_rak = 3.14152,
	Fi_excort = 0.8,
	Fi_search = 99.9,
	OmViz_max = 99.9,
	--warhead = brimstone_warhead,
	exhaust = {0.78, 0.78, 0.78, 0.3},
	X_back = 0.382,
	Y_back = 0.0,
	Z_back = 0.0,
	Reflection = 0.0121,
	KillDistance = 0.0,

		shape_table_data =
	{
		{
			name     = brimstone_name,
			file     = brimstone_model,
			life     = 1,
			fire     = {0, 1},
			username = brimstone_name,
			index    = WSTYPE_PLACEHOLDER,
		},
	},


	controller = {
		boost_start = 0.001,
		march_start = 0.500,
	},
	
	booster = {
		impulse								= 220,
		fuel_mass							= 5.1,
		work_time							= 0.5,
		nozzle_position						= {{-0.9, 0, 0.0}},
		nozzle_orientationXYZ				= {{0.0, 0.0, 0.0}},
		tail_width							= 0.2,
		smoke_color							= {1.0, 1.0, 1.0},
		smoke_transparency					= 0.8,
		custom_smoke_dissipation_factor		= 0.0,				
	},
	
	march = {
		impulse								= 300,
		fuel_mass							= 12,
		work_time							= 9,
		nozzle_position						= {{-0.9, 0, 0.0}},
		nozzle_orientationXYZ				= {{0, 0, 0}},
		tail_width							= 0.15,
		smoke_color							= {1.0, 1.0, 1.0},
		smoke_transparency					= 0.5,
		custom_smoke_dissipation_factor		= 0.2,				
	},
	
	spiral_nav = {
		def_cone_max_dist		= 20500,
		t_cone_near_rad			= 1,
		def_cone_near_rad		= 1,
		def_cone_near_rad_st	= 1,
		def_cone_time_stab_rad	= 1,
		gb_angle				= 0.0,
		gb_min_dist				= 0.0,
		gb_use_time				= 0.0,
		gb_max_retW				= 0.0,
		gb_ret_Kp				= 0.0,
	},
	

	fm  = {
		mass        = brimstone_mass,
		caliber     = 0.13,
		L           = 2.75,
		I           = 1 / 12 * 49 * 2.75 * 2.75,
		Ma          = 2,
		Mw          = 5,		
		cx_coeff    = {1,0.65,0.85,0.85,1.4},
		Sw			= 0.125,
		dCydA		= {0.024, 0.018},
		A			= 0.6,
		maxAoa		= 0.2,
		finsTau		= 0.1,
		freq		= 2.0,
	},

	autopilot = {
		Kp					= 0.078,
		Ki					= 0.058,
		Kd					= 0.038,
		max_ctrl_angle		= 1.35,
		delay				= 0.2,
		op_time				= 24.0,
		fins_discreet		= 0.04,
		no_ctrl_center_ang	= 0.00004,
	},

	
	
	eng_err = {
		y_error = 0.0,
		z_error = 0.0,
		min_time_interval = 0.1,
		max_time_interval = 1.0,
	},
	
	warhead = brimstone_warhead,
	warhead_air = brimstone_warhead,
}


declare_weapon(BRIM_STONE)

declare_loadout({
    category        = CAT_MISSILES,
    CLSID           = "JAS_BRIMSTONE",
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
