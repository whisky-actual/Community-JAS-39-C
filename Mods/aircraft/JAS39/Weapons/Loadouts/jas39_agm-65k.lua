
local jas_agm_65k_name = "jas_agm_65k"
local jas_agm_65k_mass = 297
local pylon_mass = 52.0

JAS_AGM_65_K =
{
    category        = CAT_MISSILES,
    name            = jas_agm_65k_name,
    user_name       = _("AGM-65K TV Guided Missile"),
    class_name      = "wAmmunitionSelfHoming",
    model           = "agm-65k",
    mass            = jas_agm_65k_mass,
    
    wsTypeOfWeapon  = {wsType_Weapon,wsType_Missile,wsType_AS_Missile,WSTYPE_PLACEHOLDER},
        
	M 				= jas_agm_65k_mass, 
	Escort 			= 0,
	Head_Type 		= 4,
	sigma 			= {5, 5, 5},
	H_max 			= 10000.0,
	H_min 			= -1,
	Diam 			= 305.0,
	Cx_pil 			= 4,
	D_max 			= 12964.0,
	D_min 			= 500.0,
	Head_Form 		= 0,
	Life_Time 		= 110,
	Nr_max 			= 16,
	v_min 			= 50.0,
	v_mid 			= 290.0,
	Mach_max 		= 1.5,
	t_b 			= 0.0,
	t_acc 			= 4.0,
	t_marsh 		= 0.0,
	Range_max 		= 24076.0,
	H_min_t 		= 0.0,
	Fi_start 		= 0.5,
	Fi_rak 			= 3.14152,
	Fi_excort 		= 1.05,
	Fi_search 		= 99.9,
	OmViz_max 		= 99.9,
	exhaust 		= {0.75, 0.75, 0.75, 0.1},
	X_back 			= -1.6,
	Y_back 			= 0.0,
	Z_back 			= 0.0,
	Reflection 		= 0.063,
	KillDistance 	= 0.0,
 
    shape_table_data =
    {
        {
            name     = jas_agm_65k_name,
            file     = "agm-65k",
            life     = 1,
            fire     = {0, 1},
            username = _("AGM65K"),
            index    = WSTYPE_PLACEHOLDER,
        },
    },

 LaunchDistData =
    {
        3,        5,
    --    H    --M 0.3    0.5       0.7       0.9       1.2        for a = 330m/s
                100,      165,      230,      300,      400,
        50,     8400,     11000,    12000,    13000,    15000,
        2000,   14000,    16000,    18000,    22000,    24000,
        5000,   22000,    23000,    23500,    24000,    25000,
    },    

	march = {
		smoke_color			= {0.8, 0.8, 0.8},
		smoke_transparency	= 0.7,
	},
		
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
		Mw_x		= 3.3,
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
	
	warhead	= predefined_warhead("AGM_65K"),
	warhead_air = predefined_warhead("AGM_65K"),
}

declare_weapon(JAS_AGM_65_K)

declare_loadout({

    category     	= CAT_MISSILES,
    CLSID        	= "{JAS39_AGM_65K}",
    Picture     	= 'agm65.png',
    attribute       = {4,4,32,WSTYPE_PLACEHOLDER},
	wsTypeOfWeapon	= JAS_AGM_65_K.wsTypeOfWeapon,
    displayName 	= JAS_AGM_65_K.user_name,
    Cx_pil      	= 0.0001,
    Count       	= 1,
    Weight      	= jas_agm_65k_mass + pylon_mass,
    Elements    	= {
		[1]	=
		{
			Position	=	{0, 0, 0},
			ShapeName	=	"lau-117",
			IsAdapter 	= true,
		},
		[2]	=
		{
			Position	=	{0.0,	-0.10,	0}, 
			ShapeName	=	"agm-65k",
		},
    }, -- end of Elements
})

