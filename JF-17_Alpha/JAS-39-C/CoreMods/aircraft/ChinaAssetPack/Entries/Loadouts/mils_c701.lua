
local c701tv_name = 'RB-75 (C-701T)'
local c701_mass = 100
local pylon_mass = 40.0

C701TV =
{
    -- TO FIX
    category        = CAT_MISSILES,
    name            = c701tv_name, -- AGM-65F
    user_name       = _(c701tv_name),
    model           = "c701t",
    mass            = c701_mass,
    
    wsTypeOfWeapon  = {wsType_Weapon,wsType_Missile,wsType_AS_Missile,WSTYPE_PLACEHOLDER},
    
    class_name      = "wAmmunitionSelfHoming",
    scheme          = "self_homing_gyrost_missile",
    
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
    Life_Time       = 180,
    Nr_max          = 16,
    v_min           = 50.0,
    v_mid           = 150.0,
    Mach_max        = 0.95,
    t_b             = 0.0,
    t_acc           = 0.0,
    t_marsh         = 6.0,
    Range_max       = 40000.0,
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
    Reflection      = 0.063,
    Reflection      = 0.063,
    KillDistance    = 0.0,

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
        march_start = 0.8,
    },
    march = {
        impulse                              = 125,
        fuel_mass                            = 12,
        work_time                            = 6,
        boost_time                           = 0,
        boost_factor                         = 0,
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
        maxAoa      = 0.23,
        finsTau     = 0.1,
        lockRoll    = 1,
    },
    -- TO FIX
    simple_seeker = {
        sensitivity = 0,
        delay       = 0.0,
        FOV         = math.rad(60),
        DGF         = {0.00, 0.11, 0.22, 0.33, 0.44, 0.55, 0.66, 0.77, 0.88, 1.00},
        RWF         = {1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 0.80, 0.70, 0.60, 0.10},
        maxW        = 0.18,
        stTime      = 0.5,
        opTime      = 9999,
    },
    
    simple_gyrostab_seeker = {
        omega_max    = math.rad(8)
    },
    
    -- TO FIX
    autopilot = {
        K                 = 36.0,
        Kg                = 6.0,
        Ki                = 0.0005,
        finsLimit         = 0.2,
        useJumpByDefault  = 1,
        J_Power_K         = 3.6,
        J_Diff_K          = 1.0,
        J_Int_K           = 0.0,
        J_Angle_K         = math.rad(14),
        J_FinAngle_K      = math.rad(18),
        J_Angle_W         = 4.5,
        delay             = 0.8,
    },
    -- TO FIX
    warhead = predefined_warhead("AGM_65G"),
    warhead_air = predefined_warhead("AGM_65G"),
}

declare_weapon(C701TV)

declare_loadout({
    category         = CAT_MISSILES,
    CLSID            = 'DIS_C-701T',
    attribute        = C701TV.wsTypeOfWeapon,
    Count            = 1,
    Cx_pil           = 0.0006265625,
    Picture          = "agm65.png",
    displayName      = _(c701tv_name),
    Weight           = c701_mass + pylon_mass,
    Elements         = {{ShapeName = "c701t"}},
    ejectImpulse     = 140,
})

--------------------------------------------------------------

local c701ir_name = 'RB-75 (C-701IR)'

C701IR =
{
    -- TO FIX
    category        = CAT_MISSILES,
    name            = c701ir_name,
    user_name       = _(c701ir_name),
    model           = "c701t",
    mass            = c701_mass,
    
    wsTypeOfWeapon  = {wsType_Weapon,wsType_Missile,wsType_AS_Missile,WSTYPE_PLACEHOLDER},
    
    class_name      = "wAmmunitionSelfHoming",
    scheme          = "self_homing_gyrost_missile",
    
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
    Reflection      = 0.063,
    Reflection      = 0.063,
    KillDistance    = 0.0,

    shape_table_data =
    {
        {
            name        = c701ir_name,
            file        = "c701t",
            life        = 1,
            fire        = { 0, 1},
            username    = c701ir_name,
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
        march_start = 0.8,
    },
    march = {
        impulse                              = 125,
        fuel_mass                            = 12,
        work_time                            = 6,
        boost_time                           = 0,
        boost_factor                         = 0,
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
        maxAoa      = 0.23,
        finsTau     = 0.1,
        lockRoll    = 1,
    },
    -- TO FIX
    simple_seeker = {
        sensitivity  = 0,
        delay        = 0.0,
        FOV          = math.rad(60),
        DGF          = {0.00, 0.11, 0.22, 0.33, 0.44, 0.55, 0.66, 0.77, 0.88, 1.00},
        RWF          = {1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 0.80, 0.70, 0.60, 0.10},
        maxW         = 0.18,
        stTime       = 0.5,
        opTime       = 9999,
    },
    
    simple_gyrostab_seeker = {
        omega_max    = math.rad(8)
    },
    
    -- TO FIX
    autopilot = {
        K                 = 36.0,
        Kg                = 6.0,
        Ki                = 0.0005,
        finsLimit         = 0.2,
        useJumpByDefault  = 1,
        J_Power_K         = 3.6,
        J_Diff_K          = 1.0,
        J_Int_K           = 0.0,
        J_Angle_K         = math.rad(14),
        J_FinAngle_K      = math.rad(18),
        J_Angle_W         = 4.5,
        delay             = 0.8,
    },
    -- TO FIX
    warhead = predefined_warhead("AGM_65G"),
    warhead_air = predefined_warhead("AGM_65G"),
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
    Weight           = c701_mass + pylon_mass,
    Elements         = {{ShapeName = "c701t"}},
    ejectImpulse     = 140,
})
