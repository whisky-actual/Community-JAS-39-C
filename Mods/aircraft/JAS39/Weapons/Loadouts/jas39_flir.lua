local jas_flir_name = 'Litening III Targeting Pod FLIR'
local pylon_mass = 1.0

declare_loadout(
{
    category    = CAT_PODS,
    displayName = _(jas_flir_name),
    Picture     = "L005.png",
    attribute    =    {4,    15,    44,    19},
    CLSID       = "{JAS39_FLIR}",
    
    Weight = 1 + pylon_mass,
    Cx_pil = 0.00001,
    shape_table_data =
    {
        {
            name = jas_flir_name,
            file = "",
            life = 1,
            fire = { 0, 1},
            username = "FLIR",
            index = WSTYPE_PLACEHOLDER,
        },
    },
    Elements =
    {
        [1] = {
            Position = {0, 0, 0},
            ShapeName = "",
        },
    },
}
)