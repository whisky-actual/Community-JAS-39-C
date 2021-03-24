local arakm70l_warhead =
{
    mass                 = 19.7, 
    caliber              = 135,
    expl_mass            = 19.7,
    piercing_mass        = 40.0,
    other_factors        = { 2.0, 2.5, 2.5 },
    concrete_factors     = { 1.5, 0.8, 0.8 },
    concrete_obj_factor  = 0.8,
    obj_factors          = { 1.5, 1.5 },
    cumulative_factor    = 2.0,
    cumulative_thickness = 0.6, 
}
local pylon_mass = 1.0

local arakm70l_name  = 'ARAK M70L AP'
local arakm70l_mass  = 44.7
local arakm70l_model = 'ARAK70AP'

ARAKM70_L = 
{
    category        = CAT_MISSILES,
    name            = arakm70l_name,
    user_name       = _(arakm70l_name),
    model           = arakm70l_model,
    mass            = arakm70l_mass,
    
    wsTypeOfWeapon  = {wsType_Weapon,wsType_Missile,wsType_AS_Missile,WSTYPE_PLACEHOLDER},

    Escort          = 1,
    Head_Type       = 4,
    M               = arakm70l_mass,
    sigma           = {1, 1, 1},
    H_max           = 8000.0,
    H_min           = 1.0,
    Diam            = 70.0,
    Cx_pil          = 0.00244140625,
    D_max           = 8000.0,
    D_min           = 500.0,
    Head_Form       = 1,
    Life_Time       = 90.0,
    Nr_max          = 25,
    v_min           = 140.0,
    v_mid           = 500.0,
    Mach_max        = 3.0,
    t_b             = 0.0,
    t_acc           = 0.0,
    t_marsh         = 1.1,
    Range_max       = 8000.0,
    H_min_t         = 15.0,
    Fi_start        = 0.4,
    Fi_rak          = 3.14152,
    Fi_excort       = 1.05,
    Fi_search       = 0.7,
    OmViz_max       = 0.35,
    exhaust         = {0.78, 0.78, 0.78, 0.3};
    X_back          = -2.0,
    Y_back          = -0.0,
    Z_back          = 0.0, -- -0.1,
    Reflection      = 0.05,
    KillDistance    = 0.0,
    
    LaunchDistData  = 
    {        
        5,        3,
        
                   100,      200,      300,    
        1000,     9000,     9500,    10000,
        2000,     9500,    10000,    10500,
        3000,    10000,    10500,    11000,
        4000,    10500,    11000,    11500,
        5000,    11000,    11500,    12000,
    },
    
    shape_table_data =
    {
        {
            name     = arakm70l_name,
            file     = arakm70l_model,
            life     = 1,
            fire     = {0, 1},
            username = arakm70l_name,
            index    = WSTYPE_PLACEHOLDER,
        },
    },
    
    warhead     = arakm70l_warhead,
    warhead_air = arakm70l_warhead,
    
    scheme     = 'APKWS',
    class_name = 'wAmmunitionLaserHoming',

    march = {
		fuel_mass               = 12.5,
        impulse                 = 180,
        boost_time              = 0,
        work_time               = 2.2,
        boost_factor            = 1,
        nozzle_position         = {{-0.758, 0, 0}},
        nozzle_orientationXYZ   = {{0, 0, 0}},
        tail_width              = 0.150,
        boost_tail              = 1.5,
        work_tail               = 1.5,
        smoke_color             = {0.1, 0.1, 0.1},
        smoke_transparency      = 0.6,
        custom_smoke_dissipation_factor = 0.2,   
    },

    fm = {
		mass        = arakm70l_mass,  
        caliber     = 0.135, 
        cx_coeff    = {1,0.9,0.6,0.32,2.1},
        L           = 2,
        I           = 1 / 12 * arakm70l_mass * 2 * 2,
        Ma          = 0.84,
        Mw          = 3.5,
        shapeName   = arakm70l_model,
        wind_sigma  = 5.0,
        wind_time   = 1.1,
        dCydA       = {0.11, 0.11},
        A           = 0.36,
        Sw          = 0.04,
        maxAoa      = math.rad(8),        
        finsTau     = 0.1,
        Mx0         = 0.2,
        Ma_x        = 1.8,
        Mw_x        = 1.12,
        I_x         = 1.01,
    },
    
    seeker = {
        delay               = 1.1,
        FOV                 = math.rad(40),
        max_seeker_range    = 13000,
    },

    autopilot = {
        delay               = 0.9,
        op_time             = 45,
        dV_dt               = 20,
        Knav                = 12,
        Tf                  = 0.2,
        Kd                  = 150,
        Kdx                 = 0.2,
        Kix                 = 0.8,
        gload_limit         = 10,
        fins_limit          = math.rad(20),
        fins_limit_x        = math.rad(10),
    },
}

declare_weapon(ARAKM70_L)


declare_loadout({
    category        = CAT_ROCKETS,
    CLSID           = 'DIS_BRM1_90',
    wsTypeOfWeapon  = ARAKM70_L.wsTypeOfWeapon,
    attribute       = {4, 4, 32, WSTYPE_PLACEHOLDER},
    Count           = 6,
    Cx_pil          = 0.00059912109375,
    Picture         = "ARAK70AP.png",
    displayName     = _("ARAK M70B AP L"),
    Weight          = (19.7 + 25)*6 + 104, -- 97.5 + 16 * ARAKM70_L.mass + pylon_mass,
    -- Elements        = RocketPod("ARAKM70B", arakm70l_model, 6),
    
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
	
	Required        = {"DIS_WMD7"},
    JettisonSubmunitionOnly = false,
})

