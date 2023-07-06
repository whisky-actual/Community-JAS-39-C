local C701_warhead =
{
    mass                 = 29, 
    caliber              = 180,
    expl_mass            = 15,
    piercing_mass        = 0.0,
    other_factors        = { 1.0, 1.0, 1.0 },
    concrete_factors     = { 2.0, 1.0, 1.0 },
    concrete_obj_factor  = 2.0,
    obj_factors          = { 2.0, 1.0 },
    cumulative_factor    = 2.0,
    cumulative_thickness = 0.0,
}

local c701tv_name  = 'C-701T'
local c701tv_model = 'c701t'
local c701_mass    = 100
local pylon_mass   = 70.0

C701TV =
{
    -- TO FIX
    category        = CAT_MISSILES,
    name            = c701tv_name, -- AGM-65F
    user_name       = _(c701tv_name),
    model           = c701tv_model,
    mass            = c701_mass,
    
    wsTypeOfWeapon  = {wsType_Weapon,wsType_Missile,wsType_AS_Missile,WSTYPE_PLACEHOLDER},
    
    class_name      = "wAmmunitionSelfHoming",
    scheme          = "tv_homing_gyrost_missile",
    
    -- TO FIX
    Escort          = 0,
    Head_Type       = 5,
    sigma           = {5, 5, 5},
    M               = c701_mass,
    H_max           = 10000.0,
    H_min           = -1,
    Diam            = 180.0,
    Cx_pil          = 1.7,
    D_max           = 30000.0,
    D_min           = 500.0,
    Head_Form       = 0,
    Head_Form       = 0,
    Life_Time       = 110,
    Nr_max          = 16,
    v_min           = 50.0,
    v_mid           = 150.0,
    Mach_max        = 0.95,
    t_b             = 0.0,
    t_acc           = 0.0,
    t_marsh         = 6.0,
    Range_max       = 30000.0,
    H_min_t         = 0.0,
    Fi_start        = 0.5,
    Fi_rak          = 3.14152,
    Fi_excort       = 1.05,
    Fi_search       = 99.9,
    OmViz_max       = 99.9,
    Engine_Type_    = 1,
    Engine_Type     = 1,
    exhaust         = tail_solid,
    X_back          = -1.13,
    Y_back          = 0.0,
    Z_back          = 0.0,
    Reflection      = 0.05,
    KillDistance    = 0.0,

    shape_table_data =
    {
        {
            name        = c701tv_name,
            file        = c701tv_model,
            life        = 0.4,
            fire        = { 0, 1},
            username    = c701tv_name,
            index       = WSTYPE_PLACEHOLDER,
        },
    },
    
    LaunchDistData =
    {
        4,        5,
    --    H    --M 0.3        0.5        0.7        0.9        1.2        for a = 330m/s
                100,      165,      230,      300,      400,
        50,     8400,     11000,    12000,    13000,    13000,
        2000,   14000,    15500,    17000,    18000,    18000,
        5000,   22000,    23000,    23500,    24500,    26800,
        10000,  25600,    26800,    28000,    28700,    29800,
    },
    
    MinLaunchDistData = 
    {
        4,        5,
    --    H    --M 0.3        0.5        0.7        0.9        1.2        for a = 330m/s
                100,      165,      230,      300,      400,
        50,     1000,     1200,     1400,     1600,     3000,
        2000,   2000,     2300,     2500,     2700,     3000,
        5000,   3000,     3000,     3000,     3000,     4000,
        10000,  6000,     6000,     6000,     6000,     6000,
    },
    -- TO FIX
    controller = {
        boost_start = 0.01,
        march_start = 0.1,
    },
    boost = {
        impulse                              = 125,
        fuel_mass                            = 12,
        work_time                            = 3,
        nozzle_position                      = {{-1.13, 0, 0}},
        nozzle_orientationXYZ                = {{0, 0, 0}},
        tail_width                           = 0.2,
        smoke_color                          = {0.6, 0.6, 0.6},
        smoke_transparency                   = 0.8,
        custom_smoke_dissipation_factor      = 0.2,       
    },
    march = {
        impulse                              = 150,
        fuel_mass                            = 6,
        work_time                            = 6,
        nozzle_position                      = {{-1.13, 0, 0}},
        nozzle_orientationXYZ                = {{0, 0, 0}},
        tail_width                           = 0.2,
        smoke_color                          = {0.6, 0.6, 0.6},
        smoke_transparency                   = 0.8,
        custom_smoke_dissipation_factor      = 0.2,                
    },
    fm = {
        mass        = c701_mass,  
        caliber     = 0.18,  
        cx_coeff    = {1,0.3,0.38,0.236,1.31},
        L           = 2.507,
        I           = 1 / 12 * c701_mass * 2.507 * 2.507,
        Ma          = 0.68,
        Mw          = 1.116,
        wind_sigma  = 0.0,
        wind_time   = 0.0,
        Sw          = 0.55,
        dCydA       = {0.07, 0.036},
        A           = 0.36,
        maxAoa      = 0.3,
        finsTau     = 0.1,
        Ma_x        = 0.005,
        Mw_x        = 0.1,
        I_x         = 45,
    },
    
    seeker = {
        delay            = 0.0,
        op_time          = 40,
        FOV              = math.rad(60),
        max_w_LOS        = 0.5,
        max_w_LOS_surf   = 0.016,
        send_off_data    = 0,
        aim_sigma        = 0.5,
    },
    
    simple_gyrostab_seeker = {
        omega_max = math.rad(8)
    },
    
    -- TO FIX
    autopilot = {
        K                 = 36.0,
        Kg                = 6.0,
        Ki                = 0.0005,
        finsLimit         = 0.2,
        useJumpByDefault  = 0,
        J_Power_K         = 3.6,
        J_Diff_K          = 1.0,
        J_Int_K           = 0.0,
        J_Angle_K         = math.rad(14),
        J_FinAngle_K      = math.rad(18),
        J_Angle_W         = 4.5,
        delay             = 0.8,
    },
    -- TO FIX
    warhead     = C701_warhead,
    warhead_air = C701_warhead,
}

declare_weapon(C701TV)

declare_loadout({
    category         = CAT_MISSILES,
    CLSID            = 'DIS_C-701T',
    attribute        = C701TV.wsTypeOfWeapon,
    Count            = 1,
    Cx_pil           = 0.0006265625,
    Picture          = "c701t.png",
    displayName      = _(c701tv_name),
    Weight           = c701_mass + pylon_mass,
    Elements         = {{ShapeName = c701tv_model}},
    ejectImpulse     = 140,
})

--------------------------------------------------------------

local c701ir_name  = 'C-701IR'
local c701ir_model = "c701t"

C701IR = {}
copyTable(C701IR, C701TV)
C701IR.name           = c701ir_name
C701IR.model          = c701ir_model
C701IR.user_name      = _(c701ir_name)
C701IR.wsTypeOfWeapon = {wsType_Weapon,wsType_Missile,wsType_AS_Missile,WSTYPE_PLACEHOLDER}
C701IR.shape_table_data[1].name     = c701ir_name
C701IR.shape_table_data[1].file     = c701ir_model
C701IR.shape_table_data[1].username = c701ir_name
C701IR.shape_table_data[1].index    = WSTYPE_PLACEHOLDER
declare_weapon(C701IR)





declare_loadout({
    category       = CAT_MISSILES,
    CLSID          = "DIS_C-701IR",
    Picture        = 'pl12.png',
    wsTypeOfWeapon = LD_10_ARM.wsTypeOfWeapon,
    attribute      = {4,4,32,WSTYPE_PLACEHOLDER},
    displayName    = _(c701ir_name .. ' x 3'),
    Cx_pil         = 0.00150390623,
    Count          = 3,
    Weight         = 3 * c701_mass + pylon_mass,
   Elements = {
	
		{
			ShapeName	=	"jas39_spear_triple_rack",
			IsAdapter = true,
		},
		
		{
			DrawArgs = {[1] = {1,1},[2] = {2,1},},
			Position	=	{-0.15,	-0.42,	0.25}, --1
			ShapeName	=	"c701ir_model",
		},
		
		{
			DrawArgs = {[1] = {1,1},[2] = {2,1},},
			Position	=	{-0.15,	-0.42,	-0.25}, --2
			ShapeName	=	"c701ir_model",
		},
		
		{
			DrawArgs = {[1] = {1,1},[2] = {2,1},},
			Position	=	{-0.15,	-0.50, 0.0}, --3
			ShapeName	=	"c701ir_model",
		},		
		
	},
    
    JettisonSubmunitionOnly = false,
})

