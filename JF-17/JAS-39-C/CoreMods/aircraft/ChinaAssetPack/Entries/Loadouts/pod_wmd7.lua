
local wmd7_name = 'LDP Litening III'
local pylon_mass = 1.0

declare_loadout(
{
    category    = CAT_PODS,
    displayName = _(wmd7_name),
    Picture     = "aaq-28.png",
    attribute   = {wsType_Weapon,wsType_GContainer,wsType_Control_Cont,WSTYPE_PLACEHOLDER},
    CLSID       = "DIS_WMD7",
    
    Weight = 208 + pylon_mass,
    Cx_pil = 0.00105,--0.002197266, -- Ragnar: I've calculated it to be exactly this much // changed to F-5 tank Cx -- Teo// testing
    shape_table_data =
    {
        {
            name = wmd7_name,
            file = "wmd7",
            life = 1,
            fire = { 0, 1},
            username = wmd7_name,
            index = WSTYPE_PLACEHOLDER,
        },
    },
    Elements =
    {
        [1] = {
            Position = {0, 0, 0},
            ShapeName = "wmd7",
        },
    },
}
)
