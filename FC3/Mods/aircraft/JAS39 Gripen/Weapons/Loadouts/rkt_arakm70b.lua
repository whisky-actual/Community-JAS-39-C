dofile('Scripts/Database/Weapons/warheads.lua')

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
