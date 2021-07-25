
local jas_litening_name = 'Litening III Targeting Pod'
local pylon_mass = 0.0

declare_loadout(
    {
        category    = CAT_PODS,
        name        = jas_litening_name,
        displayName = _(jas_litening_name),
        Picture     = "AAQ-28.png",        
        attribute = {wsType_Weapon, wsType_GContainer, wsType_Support, WSTYPE_PLACEHOLDER},
        CLSID       = "JAS39_Litening",
        
        Weight = 208 + pylon_mass,
        Cx_pil = 0.0014,
        shape_table_data =
        {
            {
                name = jas_litening_name,
                file = "aaq-28 litening",
                life = 1,
                fire = { 0, 1},
                username = "LITENINGPOD",
                index = WSTYPE_PLACEHOLDER,
            },
        },
        Elements =
        {
            {
                Position = {0, 0, 0},
                ShapeName = "aaq-28 litening",
            },
        },
    }
)