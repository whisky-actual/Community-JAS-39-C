
local cm802akg_name = 'KEPD-350 (CM-802AKG)'
local cm802akg_mass = 715
local pylon_mass    = 50.0

local C802AKG_warhead = 
{
    mass                 = 165, 
    caliber              = 360,
    expl_mass            = 100,
    piercing_mass        = 0.0,
    other_factors        = { 1.0, 1.0, 1.0 },
    concrete_factors     = { 5.0, 1.0, 10.0 },
    concrete_obj_factor  = 2.0,
    obj_factors          = { 5.0, 1.0 },
    cumulative_factor    = 2.0,
    cumulative_thickness = 0.0,
}


CM_802AKG_AS = {
    category        = CAT_MISSILES,
    name            = cm802akg_name,
    model           = 'cm802akg',
    user_name       = _(cm802akg_name),
    mass            = cm802akg_mass,
    wsTypeOfWeapon  = {wsType_Weapon,wsType_Missile,wsType_AS_Missile,WSTYPE_PLACEHOLDER},
    add_attributes  = {"Cruise missiles"},
	--class_name      = 'wAmmunitionCruise',

    Escort          = 1,
    Head_Type       = 8, -- TV
    sigma           = {8, 8, 8},
    M               = cm802akg_mass,

    H_max           = 10000.0,
    H_min           = -1,
    Diam            = 343.0,
    Cx_pil          = 1,
    D_max           = 220000.0,
    D_min           = 2000.0,
    Head_Form       = 0,
    Life_Time       = 660.0,
    Nr_max          = 15,
    v_min           = 270.0,
    v_mid           = 372.0,
    Mach_max        = 1.3,
    t_b             = 5.0,
    t_acc           = 0.0,
    t_marsh         = 1000.0,
    Range_max       = 220000.0,
    H_min_t         = 0.0,
    Fi_start        = 0.25,
    Fi_rak          = 3.14152,
    Fi_excort       = 3.14152,--0.35,
    Fi_search       = 99.9,
    OmViz_max       = 99.9,
    Stage_          = 1,
    Engine_Type     = 5,
    X_back          = -2.566,
    Y_back          = 0.0,
    Z_back          = 0.0,
    Reflection      = 0.121,
    KillDistance    = 0.0,

    warhead     = C802AKG_warhead,
    warhead_air = C802AKG_warhead,

    shape_table_data = {
        {
            name     = cm802akg_name,
            file     = 'cm802akg',
            life     = 1,
            fire     = {0, 1},
            username = cm802akg_name,
            index    = WSTYPE_PLACEHOLDER,
        },
    },

    LaunchDistData =
    {
    -- launch altitude: 500m - 7500m for C-802A
    -- http://www.sinaimg.cn/dy/slidenews/8_img/2011_45/22159_89924_239722.jpg
        12,        7,
                   100,      125,      150,      175,       200,       250,       300,
         500,    150000,      155000,    160000,      165000,     170000,    175000,       180000,
         600,    152000,      157000,    162000,      167000,     172000,    177000,       182000,
         700,    154000,      159000,    164000,      169000,     174000,    179000,       184000,
         800,    156000,      161000,    166000,      171000,     176000,    181000,       186000,
         900,    158000,      163000,    168000,      173000,     178000,    183000,       188000,
        1000,    160000,      165000,    170000,      175000,     180000,    185000,       190000,
        1200,    163000,      168000,    173000,      178000,     183000,    188000,       193000,
        2200,    170000,      175000,    180000,      185000,     189000,    194000,       199000,
        3200,    176000,      181000,    186000,      191000,     194000,    199000,       204000,
        4200,    181000,      186000,    191000,      196000,     199000,    203000,       208000,
        5200,    185000,      190000,    195000,      199000,     203000,    207000,       212000,
        7500,    190000,      195000,    200000,      204000,     208000,    212000,       217000,
    },
}


declare_weapon(CM_802AKG_AS)
--C_802AK_AS.shape_table_data.index = C_802AK_AS.wsTypeOfWeapon[4]

declare_loadout({
    category     = CAT_MISSILES,
    CLSID        = 'DIS_CM-802AKG',
    Picture      = 'c802akg.png',
    attribute    = CM_802AKG_AS.wsTypeOfWeapon,
    displayName  = _(cm802akg_name),
    Cx_pil       = 0.0023,
    Count        = 1,
    Weight       = cm802akg_mass + pylon_mass,
    Elements     = {
        [1] =
        {
            Position  = {0, 0, 0},
            ShapeName = 'cm802akg',
        },
    }, -- end of Elements
    Required     = {"DIS_AKG_DLPOD"},
    ejectImpulse = 140,
})
