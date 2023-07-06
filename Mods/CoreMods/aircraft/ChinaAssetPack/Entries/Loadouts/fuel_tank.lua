local pylon_mass = 0.0

----------------------------------------------
local ft800_name  = '800L Tank'
local ft800_model = 'tank800'

declare_loadout(
    {
        category    = CAT_FUEL_TANKS,
        name        = ft800_name,
        displayName = _(ft800_name),
        Picture     = "tank800.png",        
        attribute   = {wsType_Air, wsType_Free_Fall, wsType_FuelTank, WSTYPE_PLACEHOLDER},
        CLSID       = "DIS_TANK800",
        
        Weight_Empty = 45 + pylon_mass,
        Weight = 730 + pylon_mass,
        Capacity = 730 - 45,
        Cx_pil = 0.0014, --0.002197266,
        shape_table_data =
        {
            {
                name = ft800_name,
                file = ft800_model,
                life = 1,
                fire = { 0, 1},
                username = ft800_name,
                index = WSTYPE_PLACEHOLDER,
            },
        },
        Elements =
        {
            {
                Position  = {0, 0, 0},
                ShapeName = ft800_model,
            },
        },
    }
)

local ft800_empty_name = '1100L Tank Cosmetic'
declare_loadout(
    {
        category    = CAT_FUEL_TANKS,
        name        = ft800_empty_name,
        displayName = _(ft800_empty_name),
        Picture     = "tank800.png",        
        attribute   = {wsType_Air, wsType_Free_Fall, wsType_FuelTank, WSTYPE_PLACEHOLDER},
        CLSID       = "DIS_TANK800_EMPTY",
        
        Weight_Empty = 0 + pylon_mass,
        Weight = 0 + pylon_mass,
        Capacity = 0 - 45,
        Cx_pil = 0.0014, --0.002197266,
        shape_table_data =
        {
            {
                name = ft800_empty_name,
                file = ft800_model,
                life = 1,
                fire = { 0, 1},
                username = ft800_empty_name,
                index = WSTYPE_PLACEHOLDER,
            },
        },
        Elements =
        {
            {
                Position  = {0, 0, 0},
                ShapeName = ft800_model,
            },
        },
    }
)


----------------------------------------------
local ft1100_name  = '1100L Tank'
local ft1100_model = 'tank1100'

declare_loadout(
    {
        category    = CAT_FUEL_TANKS,
        name        = ft1100_name,
        displayName = _(ft1100_name),
        Picture     = "tank1100.png",
        attribute   = {wsType_Air, wsType_Free_Fall, wsType_FuelTank, WSTYPE_PLACEHOLDER},
        CLSID       = "DIS_TANK1100",
        
        Weight_Empty = 75 + pylon_mass,
        Weight = 1064 + pylon_mass,
        Capacity = 1064 - 75,
        Cx_pil = 0.00148,--0.002197266, -- Ragnar: I've calculated it to be exactly this much // changed to F-5 tank Cx -- Teo// testing
        shape_table_data =
        {
            {
                name = ft1100_name,
                file = ft1100_model,
                life = 1,
                fire = { 0, 1},
                username = ft1100_name,
                index = WSTYPE_PLACEHOLDER,
            },
        },
        Elements =
        {
            {
                Position  = {0, 0, 0},
                ShapeName = ft1100_model,
            },
        },
    }
)

local ft1100_empty_name = '1100L Tank Empty'
declare_loadout(
    {
        category    = CAT_FUEL_TANKS,
        name        = ft1100_empty_name,
        displayName = _(ft1100_empty_name),
        Picture     = "tank1100.png",
        attribute   = {wsType_Air, wsType_Free_Fall,wsType_FuelTank, WSTYPE_PLACEHOLDER},
        CLSID       = "DIS_TANK1100_EMPTY",
        
        Weight_Empty = 75 + pylon_mass,
        Weight = 75 + pylon_mass,
        Capacity = 1064 - 75,
        Cx_pil = 0.00148,--0.002197266, -- Ragnar: I've calculated it to be exactly this much // changed to F-5 tank Cx -- Teo// testing
        shape_table_data =
        {
            {
                name = ft1100_empty_name,
                file = ft1100_model,
                life = 1,
                fire = { 0, 1},
                username = ft1100_empty_name,
                index = WSTYPE_PLACEHOLDER,
            },
        },
        Elements =
        {
            {
                Position  = {0, 0, 0},
                ShapeName = ft1100_model,
            },
        },
         Sensors  = 
    {
        OPTIC = {"WMD7 FLIR"},
    },
    laserRanger = true,
    laserDesignator = true,
    }
)

------------------------------------------------
