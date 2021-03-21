
local agm65k_name = 'AGM-65K'
local agm65_mass = 297
local pylon_mass = 1.0

AGM65_K =
{
    -- TO FIX
    category        = CAT_MISSILES,
    name            = agm65k_name,
    user_name       = _(agm65k_name),
    model           = "agm-65k",
    mass            = agm65_mass,
    
    wsTypeOfWeapon  = {wsType_Weapon,wsType_Missile,wsType_AS_Missile,WSTYPE_PLACEHOLDER},
    
    class_name      = "wAmmunitionSelfHoming",
    scheme          = "AGM-65",
    
	mass        	= 360, 
	Escort			= 0,
    Head_Type		= 5,
	sigma			= {5, 5, 5},
	M				= 297,
	H_max			= 10000.0,
	H_min			= -1,
	Diam			= 305.0,
	Cx_pil			= 4,
	D_max			= 12964.0,
	D_min			= 500.0,
	Head_Form		= 0,
	Life_Time		= 110,
	Nr_max			= 16,
	v_min			= 50.0,
	v_mid			= 290.0,
	Mach_max		= 1.5,
	t_b				= 0.0,
	t_acc			= 4.0,
	t_marsh			= 0.0,
	Range_max		= 24076.0,
	H_min_t			= 0.0,
	Fi_start		= 0.5,
	Fi_rak			= 3.14152,
	Fi_excort		= 1.05,
	Fi_search		= 99.9,
	OmViz_max		= 99.9,
	exhaust			= {0.75, 0.75, 0.75, 0.1},
	X_back			= -0.9,
	Y_back			= -0.15,
	Z_back 			= 0.0,
	Reflection		= 0.063,
	KillDistance	= 0.0,
	
	fm = {
		mass        = 297,  
		caliber     = 0.305,  
		cx_coeff    = {1,0.39,0.38,0.236,1.31},
		L           = 2.49,
		I           = 1 / 12 * 209 * 2.49 * 2.49,
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
	
	seeker = {
		delay			= 0.0,
		op_time			= 105,
		FOV				= math.rad(60),
		max_w_LOS		= 0.06,
		max_w_LOS_surf	= 0.03,
	
		max_target_speed			= 33,
		max_target_speed_rnd_coeff	= 10,
	},
	
	PN_autopilot = {
		K			= 0.014,
		Ki			= 0,
		Kg			= 2.5,
		Kx			= 0.02,
		fins_limit	= 0.3,
		K_GBias		= 0.238,
	},
	
	march = {
		smoke_color			= {0.9, 0.9, 0.9},
		smoke_transparency	= 0.5,
	},
	
	warhead		= HE_penetrating_warhead(135,305),
	warhead_air = HE_penetrating_warhead(135,305),

	shape_table_data =
    {
        {
            name        = agm65k_name,
            file        = "agm-65k",
            life        = 1,
            fire        = { 0, 1},
            username    = agm65k_name,
            index       = WSTYPE_PLACEHOLDER,
        },
    },
}

declare_weapon(AGM65_K)

declare_loadout({
    category         = CAT_MISSILES,
    CLSID            = 'DIS_C-701T',
    attribute        = AGM65_K.wsTypeOfWeapon,
    Count            = 1,
    Cx_pil           = 0.0009765625,
    Picture          = "agm65.png",
    displayName      = _(agm65k_name),
    Weight           = agm65_mass + pylon_mass,
    Elements         = {{ShapeName = "agm-65k"}},
})

--------------------------------------------------------------

local agm65g_name = 'AGM-65G'

AGM65_G =
{
    -- TO FIX
    category        = CAT_MISSILES,
    name            = agm65g_name,
    user_name       = _(agm65g_name),
    model           = "agm-65g",
    mass            = 301,
    
    wsTypeOfWeapon  = {wsType_Weapon,wsType_Missile,wsType_AS_Missile,WSTYPE_PLACEHOLDER},
    
    class_name      = "wAmmunitionSelfHoming",
    scheme          = "AGM-65",
    
    -- TO FIX
    Escort          = 0,
    Head_Type       = 5,
    sigma           = {5, 5, 5},
    M               = 301.0,
    H_max           = 10000.0,
    H_min           = -1,
    Diam            = 305.0,
    Cx_pil          = 4,
    D_max           = 12964.0,
    D_min           = 500.0,
    Head_Form       = 0,
    Head_Form       = 0,
    Life_Time       = 110,
    Nr_max          = 16,
    v_min           = 50.0,
    v_mid           = 290.0,
    Mach_max        = 1.5,
    t_b             = 0.0,
    t_acc           = 4.0,
    t_marsh         = 0.0,
    Range_max       = 24076.0,
    H_min_t         = 0.0,
    Fi_start        = 0.5,
    Fi_rak          = 3.14152,
    Fi_excort       = 1.05,
    Fi_search       = 99.9,
    OmViz_max       = 99.9,  
    exhaust         = {0.75, 0.75, 0.75, 0.1},
    X_back          = -0.9,
    Y_back          = -0.15,
    Z_back          = 0.0,
    Reflection      = 0.063,    
    KillDistance    = 0.0,

    shape_table_data =
    {
        {
            name        = agm65g_name,
            file        = "agm-65g",
            life        = 1,
            fire        = { 0, 1},
            username    = agm65g_name,
            index       = WSTYPE_PLACEHOLDER,
        },
    },
    
    fm = {
		mass        = 301.0,  
		caliber     = 0.305,  
		cx_coeff    = {1,0.39,0.38,0.236,1.31},
		L           = 2.49,
		I           = 1 / 12 * 209 * 2.49 * 2.49,
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
	
	seeker = {
		delay			= 0.0,
		op_time			= 105,
		FOV				= math.rad(60),
		max_w_LOS		= 0.06,
		max_w_LOS_surf	= 0.03,
	
		max_target_speed			= 33,
		max_target_speed_rnd_coeff	= 10,
	},
	
	PN_autopilot = {
		K			= 0.02,
		Ki			= 0,
		Kg			= 2.5,
		Kx			= 0.02,
		fins_limit	= 0.3,
		K_GBias		= 0.28,
	},
	
	march = {
		smoke_color			= {0.7, 0.7, 0.7},
		smoke_transparency	= 0.72,
	},
	
	warhead		= HE_penetrating_warhead(135,305),
	warhead_air = HE_penetrating_warhead(135,305),
}

declare_weapon(AGM65_G)

declare_loadout({
    category         = CAT_MISSILES,
    CLSID            = 'DIS_C-701IR',
    attribute        = AGM65_G.wsTypeOfWeapon,
    Count            = 1,
    Cx_pil           = 0.0006265625,
    Picture          = "agm65.png",
    displayName      = _(agm65g_name),
    Weight           = 301 + pylon_mass,
    Elements         = {{ShapeName = "agm-65g"}},
})
