
-- Type 200 反跑道炸弹
local type200_name = 'TYPE-200A'
local type200_mass = 200.0
local pylon_mass = 0.0

local type200_warhead =
{
    mass                 = 115.0,
    expl_mass            = 115.0,
    piercing_mass        = 100.0,
    other_factors        = { 0.5, 0.5, 1.0 },
    concrete_factors     = { 5.0, 1.0, 5.0 },
    concrete_obj_factor  = 10.0,
    obj_factors          = { 1.0, 1.0, 1.0 },
    cumulative_factor    = 0.0,
    cumulative_thickness = 0.0
}

Type200 = {
    category       = CAT_BOMBS,
    name           = type200_name,
    user_name      = _(type200_name),
    wsTypeOfWeapon = {4, 5, 37, WSTYPE_PLACEHOLDER},
    
    model          = "type-200a",
    scheme         = "bomb-concrete",
    --class_name     = 'wAmmunition',
    
    shape_table_data = {
        {
            name     = type200_name,
            file     = 'type-200a',
            life     = 1,
            fire     = { 0, 1},
            username = type200_name,
            index    = WSTYPE_PLACEHOLDER,
        },
    },

    -- bomb data
    type        = 1,
    mass        = type200_mass,
    hMin        = 50.0,
    hMax        = 3000.0,
    Cx          = 0.00133,
    VyHold      = -50.0,
    Ag          = -20.0,
    warhead     = type200_warhead,
    sounderName = 'Weapons/BetAB_500ShP',

    -- scheme data
    fm = {
        mass            = type200_mass,
        caliber         = 0.223,
        cx_coeff        = {1.000000, 0.390000, 0.600000, 0.168000, 1.310000},
        L               = 2.500000,
        I               = 220.833333,
        Ma              = 0.290638,
        Mw              = 2.769849,
        wind_time       = 1000.0,
        wind_sigma      = 0.0,
        
        cx_factor       = 300,
    },
    
    engine =
    {
        fuel_mass             = 51.8,
        impulse               = 170,
        boost_time            = 0,
        work_time             = 1.6,
        boost_factor          = 1,
        nozzle_position       = {{-0.85, -0.146, 0}},
        nozzle_orientationXYZ = {{0, 0, 0}},
        tail_width            = 0.55,
        boost_tail            = 1,
        work_tail             = 1,

        smoke_color = {0.6, 0.6, 0.6},
        smoke_transparency = 0.3,
    },
    
    control = 
    {
        delay_par = 1.5,
        delay_eng = 10,
    },

    targeting_data = { -- TODO
        v0 = 200,
        data = {
            {    1.000000, 20.200000,  0.000000},
            {   10.000000, 20.277292,  0.000140},
            {   20.000000, 20.974612, -0.001161},
            {   30.000000, 22.769170, -0.004716},
            {   40.000000, 24.530820, -0.008370},
            {   50.000000, 26.006583, -0.011409},
            {   60.000000, 27.225948, -0.013867},
            {   70.000000, 28.244350, -0.015948},
            {   80.000000, 29.104125, -0.017757},
            {   90.000000, 29.847648, -0.019331},
            {  100.000000, 30.497785, -0.020713},
            {  200.000000, 34.417633, -0.029035},
            {  300.000000, 36.463728, -0.032998},
            {  400.000000, 37.804113, -0.035178},
            {  500.000000, 38.757713, -0.036380},
            {  600.000000, 39.461708, -0.036995},
            {  700.000000, 39.992857, -0.037257},
            {  800.000000, 40.400741, -0.037312},
            {  900.000000, 40.719782, -0.037253},
            { 1000.000000, 40.974474, -0.037137},
            { 1100.000000, 41.182447, -0.036998},
            { 1200.000000, 41.356427, -0.036855},
            { 1300.000000, 41.505608, -0.036721},
            { 1400.000000, 41.636693, -0.036598},
            { 1500.000000, 41.754532, -0.036490},
            { 1600.000000, 41.862668, -0.036396},
            { 1700.000000, 41.963673, -0.036315},
            { 1800.000000, 42.059437, -0.036246},
            { 1900.000000, 42.151341, -0.036187},
            { 2000.000000, 42.240399, -0.036136},
            { 3000.000000, 43.072382, -0.035844},
            { 4000.000000, 43.883330, -0.035602},
            { 5000.000000, 44.690588, -0.035290},
            { 6000.000000, 45.492075, -0.034901},
            { 7000.000000, 46.284544, -0.034433},
            { 8000.000000, 47.064678, -0.033892},
            { 9000.000000, 47.829238, -0.033280},
            {10000.000000, 48.574960, -0.032601},   
        },
    },
    
}
declare_weapon(Type200)

--
declare_loadout({
    category         = CAT_BOMBS,
    CLSID            = 'DIS_TYPE200',
    attribute        = Type200.wsTypeOfWeapon,
    Count            = 1,
    Cx_pil           = 0.0018,
    Picture          = "type200a.png", -- TODO
    displayName      = _(type200_name),
    Weight           = type200_mass + pylon_mass,
    Elements         = {
        {
            ShapeName = 'type-200a',
            DrawArgs  = {
                [1] = {1, 1.0},
            }
        }
    }, -- TODO
    ejectImpulse     = 140,
})


declare_loadout({
    category         = CAT_BOMBS,
    CLSID            = 'DIS_TYPE200_DUAL_L',
    attribute        = Type200.wsTypeOfWeapon,
    Count            = 2,
    Cx_pil           = 0.0036,
    Picture          = "type200a.png", -- TODO
    displayName      = _(type200_name .. " Dual"),
    Weight           = type200_mass * 2.0 + pylon_mass,
    Elements         = {{ShapeName = 'type-200a'}}, -- TODO
    ejectImpulse     = 140,
    
    Elements = {
        {
            ShapeName = "BRU_33A",
            IsAdapter = true
        },
        {
            ShapeName = "type-200a",
            connector_name = "Point01",
            DrawArgs  = {
                [1] = {1, 1.0},
            }
        },
        {
            ShapeName = "type-200a",
            connector_name = "Point02",
            DrawArgs  = {
                [1] = {1, 1.0},
            }
        },
    },
    wsTypeOfWeapon = Type200.wsTypeOfWeapon,
    attribute      = {4, 5, 32, WSTYPE_PLACEHOLDER},
})

declare_loadout({
    category         = CAT_BOMBS,
    CLSID            = 'DIS_TYPE200_DUAL_R',
    attribute        = Type200.wsTypeOfWeapon,
    Count            = 2,
    Cx_pil           = 0.0036,
    Picture          = "type200a.png", -- TODO
    displayName      = _(type200_name .. " Dual"),
    Weight           = type200_mass * 2.0 + pylon_mass,
    Elements         = {{ShapeName = 'type-200a'}}, -- TODO
    ejectImpulse     = 140,
    
    Elements =
    {
        {
            ShapeName = "BRU_33A",
            IsAdapter = true
        },
        {
            ShapeName = "type-200a",
            connector_name = "Point02",
            DrawArgs  = {
                [1] = {1, 1.0},
            }
        },
        {
            ShapeName = "type-200a",
            connector_name = "Point01",
            DrawArgs  = {
                [1] = {1, 1.0},
            }
        },
    },
    wsTypeOfWeapon = Type200.wsTypeOfWeapon,
    attribute      = {4, 5, 32, WSTYPE_PLACEHOLDER},
})
