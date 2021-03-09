
local c701tv_name = 'Rb75 AGM-65B'
local c701_mass = 210
local pylon_mass = 1.0

C701TV =
{
    -- TO FIX
    category        = CAT_MISSILES,
    name            = c701tv_name,
    user_name       = _(c701tv_name),
    model           = "c701t",
    mass            = c701_mass,
    
    wsTypeOfWeapon  = {wsType_Weapon,wsType_Missile,wsType_AS_Missile,WSTYPE_PLACEHOLDER},
    
    class_name      = "wAmmunitionSelfHoming",
    scheme          = "AGM-65",
    
	mass        	= 210.5, 
	Escort			= 0,
    Head_Type		= 5,
	sigma			= {5, 5, 5},
	M				= 210.5,
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
	exhaust			= {0.7, 0.7, 0.7, 0.1},
	X_back			= -0.9,
	Y_back			= -0.15,
	Z_back 			= 0.0,
	Reflection		= 0.063,
	KillDistance	= 0.0,
	
	fm = {
		mass        = 210.5,  
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
		max_w_LOS		= 0.05,
		max_w_LOS_surf	= 0.025,
	
		max_target_speed			= 128,
		max_target_speed_rnd_coeff	= 10,
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
		smoke_color			= {0.7, 0.7, 0.7},
		smoke_transparency	= 0.72,
	},
	
	warhead		= predefined_warhead("AGM_65A"),
	warhead_air = predefined_warhead("AGM_65A"),

	shape_table_data =
    {
        {
            name        = c701tv_name,
            file        = "c701t",
            life        = 1,
            fire        = { 0, 1},
            username    = c701tv_name,
            index       = WSTYPE_PLACEHOLDER,
        },
    },
}

declare_weapon(C701TV)

declare_loadout({
    category         = CAT_MISSILES,
    CLSID            = 'DIS_C-701T',
    attribute        = C701TV.wsTypeOfWeapon,
    Count            = 1,
    Cx_pil           = 0.0009765625,
    Picture          = "agm65.png",
    displayName      = _(c701tv_name),
    Weight           = c701_mass + pylon_mass,
    Elements         = {{ShapeName = "c701t"}},
})

--------------------------------------------------------------

local c701ir_name = 'Rb75T AGM-65E'

C701IR =
{
    -- TO FIX
    category        = CAT_MISSILES,
    name            = c701ir_name,
    user_name       = _(c701ir_name),
    model           = "c701",
    mass            = 295,
    
    wsTypeOfWeapon  = {wsType_Weapon,wsType_Missile,wsType_AS_Missile,WSTYPE_PLACEHOLDER},
    
    class_name      = "wAmmunitionSelfHoming",
    scheme          = "AGM-65",
    
    -- TO FIX
    Escort          = 0,
    Head_Type       = 5,
    sigma           = {5, 5, 5},
    M               = 295.0,
    H_max           = 10000.0,
    H_min           = -1,
    Diam            = 305.0,
    Cx_pil          = 4,
    D_max           = 7000.0,
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
    t_marsh         = 6.0,
    Range_max       = 24076.0,
    H_min_t         = 0.0,
    Fi_start        = 0.5,
    Fi_rak          = 3.14152,
    Fi_excort       = 1.05,
    Fi_search       = 99.9,
    OmViz_max       = 99.9,  
    exhaust         = {0.7, 0.7, 0.7, 0.1},
    X_back          = -0.9,
    Y_back          = -0.15,
    Z_back          = 0.0,
    Reflection      = 0.063,    
    KillDistance    = 0.0,

    shape_table_data =
    {
        {
            name        = c701ir_name,
            file        = "c701",
            life        = 1,
            fire        = { 0, 1},
            username    = c701ir_name,
            index       = WSTYPE_PLACEHOLDER,
        },
    },
    
    fm = {
		mass        = 295.0,  
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
		max_w_LOS		= 0.05,
		max_w_LOS_surf	= 0.025,
	
		max_target_speed			= 128,
		max_target_speed_rnd_coeff	= 10,
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
		smoke_color			= {0.7, 0.7, 0.7},
		smoke_transparency	= 0.72,
	},
	
	warhead		= predefined_warhead("AGM_65E"),
	warhead_air = predefined_warhead("AGM_65E"),
}

declare_weapon(C701IR)

declare_loadout({
    category         = CAT_MISSILES,
    CLSID            = 'DIS_C-701IR',
    attribute        = C701IR.wsTypeOfWeapon,
    Count            = 1,
    Cx_pil           = 0.0006265625,
    Picture          = "agm65.png",
    displayName      = _(c701ir_name),
    Weight           = 295 + pylon_mass,
    Elements         = {{ShapeName = "c701"}},
})
