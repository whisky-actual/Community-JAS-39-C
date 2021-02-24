name_METEOR = 'METEOR'
METEOR = {
    category        = CAT_AIR_TO_AIR,
    name            = name_METEOR,
    model           = 'METEOR',
    user_name       = _(name_METEOR),
    wsTypeOfWeapon  = {4,4,7,WSTYPE_PLACEHOLDER},
    mass            = 199.0,
    
    Escort          = 0,
    Head_Type       = 2,
    sigma           = {5, 5, 5},
    M               = 190.0,
    H_max           = 25000.0,
    H_min           = -1.0,
    Diam            = 178.0,   --203.0,
    Cx_pil          = 2,
    D_max           = 140000.0, --65000
    D_min           = 1000.0,
    Head_Form       = 1,
    Life_Time       = 200.0,   --180.0,
    Nr_max          = 30,
    v_min           = 140.0,
    v_mid           = 900.0,
    Mach_max        = 4.0,
    t_b             = 0.0,
    t_acc           = 6.0,
    t_marsh         = 80.0, --4 
    Range_max       = 160000.0,  --65000
    H_min_t         = 20.0,   -- 3.0,
    Fi_start        = 0.5,
    Fi_rak          = 3.14152,
    Fi_excort       = 1.05,
    Fi_search       = 1.05,
    OmViz_max       = 0.52,
    warhead         = enhanced_a2a_warhead(18.0);
    exhaust         = { 1, 1, 1, 0.5 };
    X_back          = -1.90,
    Y_back          = -0.11,
    Z_back          = 0.0,
    Reflection      = 0.0329,
    KillDistance    = 15.0, -- 11

    shape_table_data = {
        {
            name     = name_METEOR,
            file     = 'METEOR',
            life     = 1,
            fire     = {0, 1},
            username = name_METEOR,
            index    = WSTYPE_PLACEHOLDER,
        },
    },

    loft   = 1,
    hoj    = 1,
    ccm_k0 = 0.12,  
    rad_correction = 1,
    
    PN_coeffs = { 3,                
                  5000.0 , 1.0,       
                  15000.0, 0.4,       
                  30000.0, 0.2,
                },
    supersonic_A_coef_skew = 0.25, 
    nozzle_exit_area       = 0.3500, 

    ModelData = {   
        58 , 
        0.9,  

       
        0.012 ,
        0.042 , 
        0.012 ,
        0.003 , 
        1.20  , 
        1.20  , 

       
        0.3 ,
        0.45 ,
        1.2 , 

        0.29 , 
        0.00, 

  --    t_statr   t_b      t_accel  t_march   t_inertial   t_break  t_end
         0.05,    0.0,       4.0,     76.0,     10.0,          0.0,      1.0e9,          
         0.0,    0.0,       6.0,     3.5,      0.0,          0.0,        0.0,          
         0.0,    0.0,     2000.0,   800.0,      0.0,          0.0,        0.0,           

        1.0e9, 
        160.0,
        0, 
        2.0, 
        30000, 
        31000, 
        0.08,  
        50.0, 
        0.0, 
        1.19, 
        1.0, 
        2.0,
        30000.0, 
        4.0, 
        3.2,
        2.75,
        70.0, 
       
        65000.0,
        28000.0, 
        23000.0,
        0.2,
        0.6,
        1.4,
        -3.0,
        0.5,
    },
}

declare_weapon(METEOR)
METEOR.shape_table_data.index = METEOR.wsTypeOfWeapon[4]

declare_loadout({
    category     = CAT_AIR_TO_AIR,
    CLSID        = "{RAFALE_MBDA_METEOR}",
    Picture      = 'METEOR.png',
    attribute    = METEOR.wsTypeOfWeapon,
    displayName  = _(name_METEOR),
    Cx_pil       = 0.001959765625,
    Count        = 1,
    Weight       = 199.0,
    Elements     = {
        [1] =
        {
            DrawArgs =
            {
                [1] = {1, 1},
                [2] = {2, 1},
            }, -- end of DrawArgs
            Position  = {0, 0, 0},
            ShapeName = 'METEOR',
        },
    }, -- end of Elements
})

declare_loadout({ -- Ajout Pylônes lau-115 + 2xlau-127 + 2xMETEOR 
    category    = CAT_AIR_TO_AIR,
    CLSID       = "{LAU-115_2xLAU-127_MBDA_METEOR}",
    attribute   = {wsType_Weapon, wsType_Missile, wsType_Container, WSTYPE_PLACEHOLDER},
    wsTypeOfWeapon  = METEOR.wsTypeOfWeapon,
    Count       = 2,    --count of weapon
    Cx_pil      = 0.001, -- drag index of whole rack
    Picture     =   'METEOR.png',
    displayName = _("METEOR x2"),
    Weight      = 75 + 2 * 185,-- weight adapter + weapon
    Elements    =
    {
            [1] =
            {
                Position    =   {0, 0,  0},
                ShapeName   =   "LAU-115C+2_LAU127", IsAdapter = true,
                    },
            [2] =
            {   
                Rotation    =   {80, 0, 0.5},
                Position    =   {0.1, -0.05, -0.205},
                ShapeName   =   "METEOR",
                    },
            [3] =
            {
                Rotation    =   {-80, 0, -0.5},
                Position    =   {0.1, -0.05,  0.205},
                ShapeName   =   "METEOR",
                    },
    }
})