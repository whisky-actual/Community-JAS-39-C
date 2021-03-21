dofile('Scripts/Database/Weapons/warheads.lua')

--Fuel tanks--
--1100 L
local gripenft1100_name = 'External drop tank 1100 litre'
local pylon_mass = 0.0

declare_loadout(
    {
        category    = CAT_FUEL_TANKS,
        name        = gripenft1100_name,
        displayName = _(gripenft1100_name),
        Picture     = "gripentank1100.png",        
        attribute   = {wsType_Air, wsType_Free_Fall, wsType_FuelTank, WSTYPE_PLACEHOLDER},
        CLSID       = "JAS_TANK1100",
        
        Weight_Empty = 95 + pylon_mass,
        Weight = 95 + 924 + pylon_mass,
    --  Capacity = 1030 - 45,
        Cx_pil = 0.0014, --0.002197266,
        shape_table_data =
        {
            {
                name = ft800_name,
                file = "gripentank1100",
                life = 1,
                fire = { 0, 1},
                username = gripenft1100_name,
                index = WSTYPE_PLACEHOLDER,
            },
        },
        Elements =
        {
            {
                Position = {0, 0, 0},
                ShapeName = "gripentank1100",
            },
        },
    }
)
--1700 L
local gripenft1700_name = 'External drop tank 1700 litre'
local pylon_mass = 0.0

declare_loadout(
    {
        category    = CAT_FUEL_TANKS,
        name        = gripenft1700_name,
        displayName = _(gripenft1700_name),
        Picture     = "gripentank1700.png",
        attribute   = {wsType_Air, wsType_Free_Fall, wsType_FuelTank, WSTYPE_PLACEHOLDER},
        CLSID       = "JAS_TANK1700",
        
        Weight_Empty = 145 + pylon_mass,
        Weight = 145 + 1388 + pylon_mass,
    --  Capacity = 1664 - 75,
        Cx_pil = 0.00148,--0.002197266, -- Ragnar: I've calculated it to be exactly this much // changed to F-5 tank Cx -- Teo// testing
        shape_table_data =
        {
            {
                name = gripenft1700_name,
                file = "gripentank1700",
                life = 1,
                fire = { 0, 1},
                username = gripenft1700_name,
                index = WSTYPE_PLACEHOLDER,
            },
        },
        Elements =
        {
            {
                Position = {0, 0, 0},
                ShapeName = "gripentank1700",
            },
        },
    }
)
-- ARAK M70B

local wsType_ARAK70HE = 11044
local wsType_ARAK70HEPOD = 11048
local wsType_ARAK70AP = 11049
local wsType_ARAK70APPOD = 11056

local ARAK70BHE = {
	category			= CAT_ROCKETS,
	name				= "ARAKM70BHE",
	user_name			= _("ARAKM70BHE"),
	wsTypeOfWeapon		= {wsType_Weapon,wsType_NURS,wsType_Rocket,wsType_ARAK70HE},
	scheme 				= "nurs-standard",
	model 				= "ARAK70HE",

        fm = 
        {
            mass        = 44.7,   -- start weight, kg
            caliber     = 0.135, -- Caliber, meters 
            cx_coeff    = {1,0.889005,0.67,0.3173064,2.08},  -- Cx
            L           = 2.105, --Length, meters
            I           = 39.00209, -- moment of inertia
            Ix          = 6, -- not used???
            Ma          = 0.50851, -- dependence moment coefficient of  by  AoA
            Mw          = 3.28844, --  dependence moment coefficient by angular speed
            shapeName   = "",
            
            wind_time   = 1.5, -- dispersion coefficient
            wind_sigma  = 4, -- dispersion coefficient
        },

        engine =
        {
            fuel_mass   = 12.5, -- Fuel mass, kg
            impulse     = 180, -- Specific impulse, sec
            boost_time  = 0, -- Time of booster action
            work_time   = 2.2, -- Time of mid-flight engine action
            boost_factor= 1, -- Booster to cruise trust ratio
            nozzle_position =  {{-0.758, 0, 0}}, -- meters
            tail_width  = 0.150, -- contrail thickness 
            boost_tail  = 1.5,
            work_tail   = 1.5,

            smoke_color = {0.1, 0.1, 0.1},
			smoke_transparency = 0.6,--0.8,
        },

	warhead	=
	{
		mass	= 21.6,-- HE 21.6, HEAT 19.7
		expl_mass = 21.6,--0.285, HE warhead 21.6, HEAT 5.0
		other_factors = { 2.0, 2.5, 2.5},--{ 1.0, 0.5, 0.5},
		concrete_factors = { 0.8, 0.8, 0.8},--{ 1.0, 0.5, 0.1},
		concrete_obj_factor = 0.8,
		obj_factors = { 1.5, 1.5},--{ 1.0, 1.0},
		cumulative_factor= 2.0,
		cumulative_thickness = 0.6,
		piercing_mass			= 20.0,
	},

	shape_table_data =
	{
		{
			file		 = "ARAK70HE",
			life		 = 1,
			fire		 = {0, 1},
			username = "ARAKM70",
			index = WSTYPE_PLACEHOLDER,
		},
	},

	properties =
	{
		dist_min = 500,
		dist_max = 7000,
	}
}

declare_weapon(ARAK70BHE)


declare_loadout(
{
	category 		= CAT_ROCKETS,
	CLSID 			= "{ARAKM70BHE}",
	attribute 		= {wsType_Weapon,wsType_NURS,wsType_Container,wsType_ARAK70HEPOD},
	--attribute 		= {wsType_Weapon,wsType_NURS,wsType_Container,WSTYPE_PLACEHOLDER},
	wsTypeOfWeapon	=	ARAK70BHE.wsTypeOfWeapon,	
	Picture 		= "ARAK70HE.png",
	displayName		= _("ARAK M70B HE"),
	Weight 			= (19.7 + 25)*6 + 104, -- (Head + fuse + body) * 6 + pod weight
	Count			=	6,
	Cx_pil			=	0.00059912109375,
	kind_of_shipping = 1,

	Elements = {
	
		{
			ShapeName	=	"ARAKM70B", -- pod name
			IsAdapter = true,
		},

		{
			DrawArgs = {[1] = {1,1},[2] = {2,1},},
			Position	=	{-0.1,	-0.192,	-0.077}, --1
			ShapeName	=	"ARAK70HE",
			Rotation = {0,0,0},
		},

		{
			DrawArgs = {[1] = {1,1},[2] = {2,1},},
			Position	=	{-0.1,	-0.45,	-0.073}, --2
			ShapeName	=	"ARAK70HE",
			Rotation = {0,0,0},
		},

		{
			DrawArgs = {[1] = {1,1},[2] = {2,1},},
			Position	=	{-0.1,	-0.326, 0.143}, --3
			ShapeName	=	"ARAK70HE",
			Rotation = {0,0,0},
		},

		{
			DrawArgs = {[1] = {1,1},[2] = {2,1},},
			Position	=	{-0.1,	-0.326,	-0.143}, --4
			ShapeName	=	"ARAK70HE",
			Rotation = {0,0,0},
		},

		{
			DrawArgs = {[1] = {1,1},[2] = {2,1},},
			Position	=	{-0.1,	-0.192,	0.077}, --5
			ShapeName	=	"ARAK70HE",
			Rotation = {0,0,0},
		},

		{
			DrawArgs = {[1] = {1,1},[2] = {2,1},},
			Position	=	{-0.1,	-0.45,	0.073}, --6
			ShapeName	=	"ARAK70HE",
			Rotation = {0,0,0},
		},
	},

}
)

local ARAK70BAP = {
	category			= CAT_ROCKETS,
	name				= "ARAKM70BAP",
	user_name			= _("ARAKM70BAP"),
	wsTypeOfWeapon		= {wsType_Weapon,wsType_NURS,wsType_Rocket,wsType_ARAK70AP},
	scheme 				= "nurs-standard",
	model 				= "ARAK70AP",

        fm = 
        {
            mass        = 44.7,   -- start weight, kg
            caliber     = 0.135, -- Caliber, meters 
            cx_coeff    = {1,0.889005,0.67,0.3173064,2.08},  -- Cx
            L           = 2.105, --Length, meters
            I           = 39.00209, -- moment of inertia
            Ix          = 6, -- not used???
            Ma          = 0.50851, -- dependence moment coefficient of  by  AoA
            Mw          = 3.28844, --  dependence moment coefficient by angular speed
            shapeName   = "",
            
            wind_time   = 1.5, -- dispersion coefficient
            wind_sigma  = 4, -- dispersion coefficient
        },

        engine =
        {
            fuel_mass   = 12.5, -- Fuel mass, kg
            impulse     = 180, -- Specific impulse, sec
            boost_time  = 0, -- Time of booster action
            work_time   = 2.2, -- Time of mid-flight engine action
            boost_factor= 1, -- Booster to cruise trust ratio
            nozzle_position =  {{-0.758, 0, 0}}, -- meters
            tail_width  = 0.150, -- contrail thickness 
            boost_tail  = 1.5,
            work_tail   = 1.5,

            smoke_color = {0.1, 0.1, 0.1},
			smoke_transparency = 0.6,--0.8,
        },

	warhead	=
	{
		mass	= 19.7,-- HE 21.6, HEAT 19.7
		expl_mass = 19.7,--0.285, HE warhead 21.6, HEAT 5.0
		other_factors = { 2.0, 2.5, 2.5},--{ 1.0, 0.5, 0.5},
		concrete_factors = { 1.5, 0.8, 0.8},--{ 1.0, 0.5, 0.1},
		concrete_obj_factor = 0.8,
		obj_factors = { 1.5, 1.5},--{ 1.0, 1.0},
		cumulative_factor= 2.0,
		cumulative_thickness = 0.6,
		piercing_mass			= 40.0,
	},

	shape_table_data =
	{
		{
			file		 = "ARAK70AP",
			life		 = 1,
			fire		 = {0, 1},
			username = "ARAKM70AP",
			index = WSTYPE_PLACEHOLDER,
		},
	},

	properties =
	{
		dist_min = 500,
		dist_max = 7000,
	}
}

declare_weapon(ARAK70BAP)


declare_loadout(
{
	category 		= CAT_ROCKETS,
	CLSID 			= "{ARAKM70BAP}",
	attribute 		= {wsType_Weapon,wsType_NURS,wsType_Container,wsType_ARAK70APPOD},
	--attribute 		= {wsType_Weapon,wsType_NURS,wsType_Container,WSTYPE_PLACEHOLDER},
	wsTypeOfWeapon	=	ARAK70BAP.wsTypeOfWeapon,	
	Picture 		= "ARAK70AP.png",
	displayName		= _("ARAK M70B AP"),
	Weight 			= (19.7 + 25)*6 + 104, -- (Head + fuse + body) * 6 + pod weight
	Count			=	6,
	Cx_pil			=	0.00059912109375,
	kind_of_shipping = 1,

	Elements = {
	
		{
			ShapeName	=	"ARAKM70B", -- pod name
			IsAdapter = true,
		},

		{
			DrawArgs = {[1] = {1,1},[2] = {2,1},},
			Position	=	{-0.1,	-0.192,	-0.077}, --1
			ShapeName	=	"ARAK70AP",
			Rotation = {0,0,0},
		},

		{
			DrawArgs = {[1] = {1,1},[2] = {2,1},},
			Position	=	{-0.1,	-0.45,	-0.073}, --2
			ShapeName	=	"ARAK70AP",
			Rotation = {0,0,0},
		},

		{
			DrawArgs = {[1] = {1,1},[2] = {2,1},},
			Position	=	{-0.1,	-0.326, 0.143}, --3
			ShapeName	=	"ARAK70AP",
			Rotation = {0,0,0},
		},

		{
			DrawArgs = {[1] = {1,1},[2] = {2,1},},
			Position	=	{-0.1,	-0.326,	-0.143}, --4
			ShapeName	=	"ARAK70AP",
			Rotation = {0,0,0},
		},

		{
			DrawArgs = {[1] = {1,1},[2] = {2,1},},
			Position	=	{-0.1,	-0.192,	0.077}, --5
			ShapeName	=	"ARAK70AP",
			Rotation = {0,0,0},
		},

		{
			DrawArgs = {[1] = {1,1},[2] = {2,1},},
			Position	=	{-0.1,	-0.45,	0.073}, --6
			ShapeName	=	"ARAK70AP",
			Rotation = {0,0,0},
		},
	},

}
)

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
    CLSID            = 'JAS-AGM65K',
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
    CLSID            = 'JAS-AGM65G',
    attribute        = AGM65_G.wsTypeOfWeapon,
    Count            = 1,
    Cx_pil           = 0.0006265625,
    Picture          = "agm65.png",
    displayName      = _(agm65g_name),
    Weight           = 301 + pylon_mass,
    Elements         = {{ShapeName = "agm-65g"}},
})
