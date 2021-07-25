declare_loadout(
    {
        category = CAT_PODS,
        CLSID = "{JAS39_ELINT}",
--        attribute = {wsType_Weapon, wsType_GContainer, wsType_Control_Cont, WSTYPE_PLACEHOLDER},
        attribute	=	{4,	15,	44,	65},
		Picture = "L005.png",
        displayName = _("Integrated ELINT"),
        Weight = 1,
        Cx_pil = 0.000244140625,
        shape_table_data =
        {
            {
                file = "",
                life = 1,
                fire = { 0, 1},
                username = "ELINT",
                index = WSTYPE_PLACEHOLDER,
            },
        },
        Elements =
        {
            {
                Position = {0, 0, 0},
                ShapeName = "",
            },
        },
    }
)
