local jas_brimstone_warhead =
{
    mass                 = 6.3, 
    caliber              = 180,
    expl_mass            = 6.3,
    piercing_mass        = 6.3*1.2,
    other_factors        = { 1.0, 1.0, 1.0 },
    concrete_factors     = { 1.0, 1.0, 1.0 },
    concrete_obj_factor  = 0.0,
    obj_factors          = { 1.0, 1.0 },
    cumulative_factor    = 4.0,
    cumulative_thickness = 1.75, 
}

local jas_brimstone_name  = 'Brimstone Laser Guided Missile'
local jas_brimstone_mass  = 48.5
local jas_brimstone_model = 'jas39_brimstone'

JAS_BRIM_STONE =
{
	category        = CAT_MISSILES,
    name            = jas_brimstone_name,
    user_name       = _(jas_brimstone_name),
    model           = jas_brimstone_model,
    mass            = jas_brimstone_mass,
	scheme			= "AGM-65E",             
	class_name		= "wAmmunitionSelfHoming",     
	wsTypeOfWeapon  = {wsType_Weapon, wsType_Missile, wsType_AS_Missile, WSTYPE_PLACEHOLDER},
	
		mass = jas_brimstone_mass,
		Escort = 1,
        Head_Type = 4,
		sigma = {2, 2, 2},
        M = jas_brimstone_mass,
        H_max = 10000.0,
        H_min = -1,
        Diam = 180.0,
        Cx_pil = 2,
        D_max = 10000.0,
        D_min = 500.0,
        Head_Form = 0,
        Life_Time = 110,
        Nr_max = 16,
        v_min = 50.0,
        v_mid = 290.0,
        Mach_max = 2.0,
        t_b = 0.0,
        t_acc = 4.0,
        t_marsh = 0.0,
        Range_max = 20000.0,
        H_min_t = 0.0,
        Fi_start = 0.5,
        Fi_rak = 3.14152,
        Fi_excort = 1.05,
        Fi_search = 99.9,
        OmViz_max = 99.9,
		exhaust	= {1.0, 1.0, 1.0, 0.1},
		X_back	= -0.9,
		Y_back	= -0.15,
		Z_back 	= 0.0,
		Reflection	= 0.012,
		KillDistance= 0.0,

		shape_table_data =
	{
		{
			name     = jas_brimstone_name,
			file     = jas_brimstone_model,
			life     = 1,
			fire     = {0, 1},
			username = "BRIMSTONE",
			index    = WSTYPE_PLACEHOLDER,
		},
	},


	fm = {
		mass        = 120,
		caliber     = 0.180,
		cx_coeff    = {1,0.39,0.38,0.236,1.31},
		L           = 2.49,
		I           = 1 / 12 * 120 * 2.49 * 2.49,
		Ma          = 0.68,
		Mw          = 1.116,
		wind_sigma	= 0.0,
		wind_time	= 0.0,
		Sw			= 0.55,
		dCydA		= {0.07, 0.036},
		A			= 0.36,
		maxAoa		= 0.23,
		finsTau		= 0.1,
		Ma_x		= 3,
		Kw_x		= 0.03,
		I_x			= 40,
	},
	
	laser_spot_seeker = {
		FOV					= 0.558,
		max_seeker_range	= 20000,
	},

	PN_autopilot = {
		K			= 0.014,
		Ki			= 0,
		Kg			= 2.5,
		Kx			= 0.02,
		fins_limit	= 0.3,
		K_GBias		= 0.26,
	},
	
	march = {
		smoke_color			= {1.0, 1.0, 1.0},
		smoke_transparency	= 0.8,			
	},
	
	warhead = jas_brimstone_warhead,
	warhead_air = jas_brimstone_warhead,
	
}

declare_weapon(JAS_BRIM_STONE)

declare_loadout({
    category        = CAT_MISSILES,
    CLSID           = "{JAS39_BRIMSTONE}",
    wsTypeOfWeapon  = JAS_BRIM_STONE.wsTypeOfWeapon,
    attribute       = {4, 4, 32, WSTYPE_PLACEHOLDER},
    Count           = 3,
    Cx_pil          = 0.0001,
    Picture         = "jas39_brimstone.png",
    displayName     = _('3 x ' .. jas_brimstone_name),
    Weight          = jas_brimstone_mass * 3 + 50,
	Elements = {
	
		{
			ShapeName	=	"jas39_brimstone_triple_rack",
			IsAdapter = true,
		},
		
		{
			DrawArgs = {[1] = {1,1},[2] = {2,1},},
			Position	=	{0.15,	-0.18,	0.3}, --1
			ShapeName	=	"jas39_brimstone",
			Rotation = {0,0,0},
		},
		
		{
			DrawArgs = {[1] = {1,1},[2] = {2,1},},
			Position	=	{0.15,	-0.18,	-0.3}, --2
			ShapeName	=	"jas39_brimstone",
			Rotation = {0,0,0},
		},
		
		{
			DrawArgs = {[1] = {1,1},[2] = {2,1},},
			Position	=	{0.15,	-0.26, 0.0}, --3
			ShapeName	=	"jas39_brimstone",
			Rotation = {0,0,0},
		},		
		
	},
    
    JettisonSubmunitionOnly = false,
})
