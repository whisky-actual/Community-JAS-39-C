
local ft800_name = '1100L Gripen Tank'
local pylon_mass = 0.0

declare_loadout(
    {
        category    = CAT_FUEL_TANKS,
        name        = ft800_name,
        displayName = _(ft800_name),
        Picture     = "tank800.png",        
        attribute   = {wsType_Air, wsType_Free_Fall, wsType_FuelTank, WSTYPE_PLACEHOLDER},
        CLSID       = "DIS_TANK800",
        
        Weight_Empty = 45 + pylon_mass,
        Weight = 1030 + pylon_mass,
        Capacity = 1030 - 45,
        Cx_pil = 0.0014, --0.002197266,
        shape_table_data =
        {
            {
                name = ft800_name,
                file = "tank800",
                life = 1,
                fire = { 0, 1},
                username = ft800_name,
                index = WSTYPE_PLACEHOLDER,
            },
        },
        Elements =
        {
            {
                Position = {0, 0, 0},
                ShapeName = "tank800",
            },
        },
    }
)