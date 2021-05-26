local AAQ_name = 'Litening III POD (LLTV)'
local pylon_mass = 50.0

declare_loadout(
{
    category    = CAT_PODS,
    displayName = _(AAQ_name),
    Picture     = "AAQ-28.png",
    attribute    =    {4,    15,    44,    19},
    CLSID       = "JAS_Litening",
    
    Weight = 245 + pylon_mass,
    Cx_pil = 0.00105,
    shape_table_data =
    {
        {
            name = AAQ_name,
            file = "AAQ",
            life = 1,
            fire = { 0, 1},
            username = AAQ_name,
            index = WSTYPE_PLACEHOLDER,
        },
    },
    Elements =
    {
        [1] = {
            Position = {0, 0, 0},
            ShapeName = "kingal",
        },
    },
}
)