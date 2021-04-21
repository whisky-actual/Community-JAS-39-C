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

local brimstone_name  = 'Brimstone'
local brimstone_mass  = 48.5
local brimstone_model = 'brimstone'

BRIM_STONE = 
{
    category        = CAT_MISSILES,
    name            = brimstone_name,
    user_name       = _(brimstone_name),
    model           = brimstone_model,
    mass            = brimstone_mass,
    
    wsTypeOfWeapon  = {wsType_Weapon,wsType_Missile,wsType_AS_Missile,WSTYPE_PLACEHOLDER},

    Escort          = 1,
    Head_Type       = 4,
    M               = brimstone_mass,
    sigma           = {1, 1, 1},
    H_max           = 10000.0,
    H_min           = 1.0,
    Diam            = 120.0,
    Cx_pil          = 0.0001,
    D_max           = 22000.0,
    D_min           = 500.0,
    Head_Form       = 1,
    Life_Time       = 60.0,
    Nr_max          = 25,
    v_min           = 140.0,
    v_mid           = 600.0,
    Mach_max        = 3.0,
    t_b             = 0.0,
    t_acc           = 0.0,
    t_marsh         = 1.1,
    Range_max       = 22000.0,
    H_min_t         = 15.0,
    Fi_start        = 0.5,
    Fi_rak          = 3.14152,
    Fi_excort       = 1.05,
    Fi_search       = 0.9,
    OmViz_max       = 0.9,
    exhaust         = {0.78, 0.78, 0.78, 0.3};
    X_back          = -2.0,
    Y_back          = -0.0,
    Z_back          = 0.0,
    Reflection      = 0.05,
    KillDistance    = 5.0,
    
    LaunchDistData  =       
	{
      4,        5,
    --    H --M 0.3        0.5      0.7       0.9        1.2        for a = 330m/s
                100,      165,      230,      300,      400,
        50,     8400,     11000,    12000,    14000,    15000,
        2000,   16000,    18000,    22000,    23000,    24000,
        5000,   22000,    23000,    23500,    24500,    26800,
        10000,  25600,    26800,    28000,    28700,    29800,
    },
	
    
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
    
    warhead     = brimstone_warhead,
    warhead_air = brimstone_warhead,
    
    scheme     = 'APKWS',
    class_name = 'wAmmunitionLaserHoming',

    march = {
        fuel_mass               = 15,
        impulse                 = 300,
        boost_time              = 0,
        work_time               = 45.0,
        boost_factor            = 1,
        nozzle_position         = {{-0.9, 0, 0.0}},
        nozzle_orientationXYZ   = {{0, 0, 0}},
        tail_width              = 0.15,
        boost_tail              = 1,
        work_tail               = 1,
        smoke_color             = {0.9, 0.9, 0.9},
        smoke_transparency      = 0.5,
        custom_smoke_dissipation_factor = 0.2,    
    },

    fm = {
        mass        = brimstone_mass,  
        caliber     = 0.09, 
        cx_coeff    = {1,0.9,0.6,0.32,2.1},
        L           = 2,
        I           = 1 / 12 * brimstone_mass * 2 * 2,
        Ma          = 0.84,
        Mw          = 3.5,
        shapeName   = brimstone_model,
        wind_sigma  = 5.0,
        wind_time   = 1.1,
        dCydA       = {0.11, 0.11},
        A           = 0.36,
        Sw          = 0.2,
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
        max_seeker_range    = 25000, --22000
    },

    autopilot = {
        delay               = 0.9,
        op_time             = 120,
        dV_dt               = 20,
        Knav                = 12,
        Tf                  = 0.2,
        Kd                  = 150,
        Kdx                 = 0.2,
        Kix                 = 0.8,
        gload_limit         = 15,
        fins_limit          = math.rad(20),
        fins_limit_x        = math.rad(10),
    },
}

declare_weapon(BRIM_STONE)

declare_loadout({
    category        = CAT_ROCKETS,
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

