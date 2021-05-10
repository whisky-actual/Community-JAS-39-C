
local gripenft1700_name = 'External drop tank 1700 litre'
local pylon_mass = 0.0

declare_loadout(
    {
        category    = CAT_FUEL_TANKS,
        name        = gripenft1700_name,
        displayName = _(gripenft1700_name),
        Picture     = "gripentank1700.png",
        attribute   = {wsType_Air, wsType_Free_Fall, wsType_FuelTank, WSTYPE_PLACEHOLDER},
        CLSID       = "JAS_TANK1700",
        
        Weight_Empty = 145 + pylon_mass,
        Weight = 145 + 1388 + pylon_mass,
    --  Capacity = 1664 - 75,
        Cx_pil = 0.00148,--0.002197266, -- Ragnar: I've calculated it to be exactly this much // changed to F-5 tank Cx -- Teo// testing
        shape_table_data =
        {
            {
                name = gripenft1700_name,
                file = "gripentank1700",
                life = 1,
                fire = { 0, 1},
                username = "1700L Tank",
                index = WSTYPE_PLACEHOLDER,
            },
        },
        Elements =
        {
            {
                Position = {0, 0, 0},
                ShapeName = "gripentank1700",
            },
        },
    }
)