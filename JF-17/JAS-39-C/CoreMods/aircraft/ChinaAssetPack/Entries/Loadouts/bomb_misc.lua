dofile('Scripts/Database/Weapons/warheads.lua')

function copyTable(target, src)
    for i, v in pairs(src) do
        if type(v) == 'table' then
            if not target[i] then
                target[i] = { }
            end
            copyTable(target[i], v)
        else
            target[i] = v
        end
    end
end


--[[ Bombs ]]
-- FAB-250
FAB_250_DUAL_L = {
    category    = CAT_BOMBS,
    CLSID       = "{FAB_250_DUAL_L}",
    Picture     = "fab250_dual.png",
    displayName = _("2 x FAB-250"),
    Cx_pil      = 0.0004,
    Count       = 2,
    Weight      = 32 + 250*2,
    JettisonSubmunitionOnly = true,
    
    Elements =
    {
        {
            ShapeName = "J-11A_twinpylon_l",
            IsAdapter = true
        },
        {
            DrawArgs =    
            {
                [1] = {1, 1},
                [2] = {2, 1},
            },
            -- ShapeName = "FAB-250-N1",
            -- Position  = {0,-0.654936/2,0.654936/2},
            payload_CLSID = "{3C612111-C7AD-476E-8A8E-2485812F4E5C}",
            connector_name = "Pylon_out"
        },
        {
            DrawArgs =    
            {
                [1] = {1, 1},
                [2] = {2, 1},
            },
            -- ShapeName = "FAB-250-N1",
            -- Position  = {0,-0.654936/2,-0.654936/2},
            payload_CLSID = "{3C612111-C7AD-476E-8A8E-2485812F4E5C}",
            connector_name = "Pylon_in"
        },
    },
    wsTypeOfWeapon = {4, 5, 9, 6},
    attribute      = {4, 5, 32, WSTYPE_PLACEHOLDER},
}
declare_loadout(FAB_250_DUAL_L)


FAB_250_DUAL_R = {}
copyTable(FAB_250_DUAL_R, FAB_250_DUAL_L)
FAB_250_DUAL_R.CLSID = "{FAB_250_DUAL_R}"
FAB_250_DUAL_R.Elements[1].ShapeName = "J-11A_twinpylon_r"
-- FAB_250_DUAL_R.Elements[2].Position = {0,-0.654936/2,-0.654936/2}
-- FAB_250_DUAL_R.Elements[3].Position = {0,-0.654936/2, 0.654936/2}
FAB_250_DUAL_R.Elements[2].connector_name = "Pylon_out"
FAB_250_DUAL_R.Elements[3].connector_name = "Pylon_in"
FAB_250_DUAL_R.attribute = FAB_250_DUAL_L.attribute
declare_loadout(FAB_250_DUAL_R)


-- FAB-500
FAB_500_DUAL_L = {
    category    = CAT_BOMBS,
    CLSID       = "{FAB_500_DUAL_L}",
    Picture     = "fab500_dual.png",
    displayName = _("2 x FAB-500"),
    Cx_pil      = 0.0004,
    Count       = 2,
    Weight      = 32 + 506*2,
    JettisonSubmunitionOnly = true,
    
    Elements =
    {
        {
            -- Position  = {0, 0, 0},
            ShapeName = "J-11A_twinpylon_l",
            IsAdapter = true
        },
        {
            DrawArgs =    
            {
                [1] = {1, 1},
                [2] = {2, 1},
            },
            -- ShapeName = "FAB-500-N3",
            -- Position  = {0,-0.654936/2,0.654936/2},
            payload_CLSID = "{37DCC01E-9E02-432F-B61D-10C166CA2798}",
            connector_name = "Pylon_out"
        },
        {
            DrawArgs =    
            {
                [1] = {1, 1},
                [2] = {2, 1},
            },
            -- ShapeName = "FAB-500-N3",
            -- Position  = {0,-0.654936/2,-0.654936/2},
            payload_CLSID = "{37DCC01E-9E02-432F-B61D-10C166CA2798}",
            connector_name = "Pylon_in"
        },
    },
    wsTypeOfWeapon = {4, 5, 9, 7},
    attribute      = {4, 5, 32, WSTYPE_PLACEHOLDER},
}
declare_loadout(FAB_500_DUAL_L)


FAB_500_DUAL_R = {}
copyTable(FAB_500_DUAL_R, FAB_500_DUAL_L)
FAB_500_DUAL_R.CLSID = "{FAB_500_DUAL_R}"
FAB_500_DUAL_R.Elements[1].ShapeName = "J-11A_twinpylon_r"
-- FAB_500_DUAL_R.Elements[2].Position = {0,-0.654936/2,-0.654936/2}
-- FAB_500_DUAL_R.Elements[3].Position = {0,-0.654936/2, 0.654936/2}
FAB_500_DUAL_R.Elements[2].connector_name = "Pylon_out"
FAB_500_DUAL_R.Elements[3].connector_name = "Pylon_in"
FAB_500_DUAL_R.attribute = FAB_500_DUAL_L.attribute
declare_loadout(FAB_500_DUAL_R)


-- RBK-250
RBK_250_PTAB25M_DUAL_L = {
    category    = CAT_BOMBS,
    CLSID       = "{RBK_250_PTAB25M_DUAL_L}",
    Picture     = "rbk250_dual.png",
    displayName = _("2 x RBK-250 PTAB-2.5M"),
    Cx_pil      = 0.0004,
    Count       = 2,
    Weight      = 32 + 273*2,
    JettisonSubmunitionOnly = true,
    
    Elements =
    {
        {
            -- Position  = {0, 0, 0},
            ShapeName = "J-11A_twinpylon_l",
            IsAdapter = true
        },
        {
            DrawArgs =    
            {
                [1] = {1, 1},
                [2] = {2, 1},
                [3] = {3, 1},
            }, -- end of DrawArgs
            -- ShapeName = "RBK_250_PTAB_25M_cassette",
            -- Position  = {0.325000*3/4,-0.325000,0.654936/2},
            payload_CLSID = "{4203753F-8198-4E85-9924-6F8FF679F9FF}",
            connector_name = "Pylon_out"
        },
        {
            DrawArgs =    
            {
                [1] = {1, 1},
                [2] = {2, 1},
                [3] = {3, -1},
            }, -- end of DrawArgs
            -- ShapeName = "RBK_250_PTAB_25M_cassette",
            -- Position  = {0.325000*3/4,-0.325000,-0.654936/2},
            payload_CLSID = "{4203753F-8198-4E85-9924-6F8FF679F9FF}",
            connector_name = "Pylon_in"
        },
    },
    wsTypeOfWeapon = {4, 5, 38, 18},
    attribute      = {4, 5, 32, WSTYPE_PLACEHOLDER},
}
declare_loadout(RBK_250_PTAB25M_DUAL_L)


RBK_250_PTAB25M_DUAL_R = {}
copyTable(RBK_250_PTAB25M_DUAL_R, RBK_250_PTAB25M_DUAL_L)
RBK_250_PTAB25M_DUAL_R.CLSID = "{RBK_250_PTAB25M_DUAL_R}"
RBK_250_PTAB25M_DUAL_R.Elements[1].ShapeName = "J-11A_twinpylon_r"
-- RBK_250_PTAB25M_DUAL_R.Elements[2].DrawArgs[3] = {3, -1}
-- RBK_250_PTAB25M_DUAL_R.Elements[2].Position = {0.325000*3/4,-0.325000,-0.654936/2}
-- RBK_250_PTAB25M_DUAL_R.Elements[3].DrawArgs[3] = {3, 1}
-- RBK_250_PTAB25M_DUAL_R.Elements[3].Position = {0.325000*3/4,-0.325000, 0.654936/2}
RBK_250_PTAB25M_DUAL_R.Elements[2].connector_name = "Pylon_out"
RBK_250_PTAB25M_DUAL_R.Elements[3].connector_name = "Pylon_in"
RBK_250_PTAB25M_DUAL_R.attribute = RBK_250_PTAB25M_DUAL_L.attribute
declare_loadout(RBK_250_PTAB25M_DUAL_R)


-- RBK-500
RBK_500_PTAB105_DUAL_L = {
    category    = CAT_BOMBS,
    CLSID       = "{RBK_500_PTAB105_DUAL_L}",
    Picture     = "rbk500_dual.png",
    displayName = _("2 x RBK-500-255 PTAB-10-5"),
    Cx_pil      = 0.0004,
    Count       = 2,
    Weight      = 32 + 427*2,
    JettisonSubmunitionOnly = true,
    
    Elements =
    {
        {
            -- Position  = {0, 0, 0},
            ShapeName = "J-11A_twinpylon_l",
            IsAdapter = true
        },
        {
            DrawArgs =    
            {
                [1] = {1, 1},
                [2] = {2, 1},
                [3] = {3, 1},
            }, -- end of DrawArgs
            -- ShapeName = "RBK_500_255_PTAB_10_5_cassette",
            -- Position  = {0.325000*3/4,-0.4,0.654936/2},
            payload_CLSID = "{D5435F26-F120-4FA3-9867-34ACE562EF1B}",
            connector_name = "Pylon_out"
        },
        {
            DrawArgs =    
            {
                [1] = {1, 1},
                [2] = {2, 1},
                [3] = {3, -1},
            }, -- end of DrawArgs
            -- ShapeName = "RBK_500_255_PTAB_10_5_cassette",
            -- Position  = {0.325000*3/4,-0.4,-0.654936/2},
            payload_CLSID = "{D5435F26-F120-4FA3-9867-34ACE562EF1B}",
            connector_name = "Pylon_in"
        },
    },
    wsTypeOfWeapon = {4, 5, 38, 20},
    attribute      = {4, 5, 32, WSTYPE_PLACEHOLDER},
}
declare_loadout(RBK_500_PTAB105_DUAL_L)


RBK_500_PTAB105_DUAL_R = {}
copyTable(RBK_500_PTAB105_DUAL_R, RBK_500_PTAB105_DUAL_L)
RBK_500_PTAB105_DUAL_R.CLSID = "{RBK_500_PTAB105_DUAL_R}"
RBK_500_PTAB105_DUAL_R.Elements[1].ShapeName = "J-11A_twinpylon_r"
-- RBK_500_PTAB105_DUAL_R.Elements[2].DrawArgs[3] = {3, -1}
-- RBK_500_PTAB105_DUAL_R.Elements[2].Position = {0.325000*3/4,-0.4,-0.654936/2}
-- RBK_500_PTAB105_DUAL_R.Elements[3].DrawArgs[3] = {3, 1}
-- RBK_500_PTAB105_DUAL_R.Elements[3].Position = {0.325000*3/4,-0.4, 0.654936/2}
RBK_500_PTAB105_DUAL_R.Elements[2].connector_name = "Pylon_out"
RBK_500_PTAB105_DUAL_R.Elements[3].connector_name = "Pylon_in"
RBK_500_PTAB105_DUAL_R.attribute = RBK_500_PTAB105_DUAL_L.attribute
declare_loadout(RBK_500_PTAB105_DUAL_R)


-- customized MK-20
JF17_MK_20 = {
    category    = CAT_BOMBS,
    CLSID       = "DIS_MK_20",
    Picture     = "Mk20.png",
    displayName = _("Mk-20"),
    Count       = 1,
    Weight      = 222,
    Cx_pil      = 0.000413,
    
    Elements =
    {
        [1] =
        {
            DrawArgs =
            {
                [1] = {1, 1},
                [2] = {2, 1},
            }, -- end of DrawArgs
            Position  = {0, 0, 0},
            ShapeName = "ROCKEYE",
        }, 
    }, -- end of Elements
    attribute = {4, 5, 38, 45},
}
declare_loadout(JF17_MK_20)


-- customized GBU-10/12/16
JF17_GBU_10 = {
    category    = CAT_BOMBS,
    CLSID       = "DIS_GBU_10",
    Picture     = "GBU10.png",
    displayName = _("GBU-10"),
    Count       = 1,
    Weight      = 1162,
    Cx_pil      = 0.000793,
    
    Elements =
    {
        {
            DrawArgs =    
            {
                [1] = {1, 1},
                [2] = {2, 1},
            }, -- end of DrawArgs
            Position  = {0, 0, 0},
            ShapeName = "GBU-10",
        }, 
    },
    attribute = {4, 5, 36, 36},
    Required  = {"DIS_WMD7"},
}
declare_loadout(JF17_GBU_10)

JF17_GBU_16 = {
    category    = CAT_BOMBS,
    CLSID       = "DIS_GBU_16",
    Picture     = "GBU16.png",
    displayName = _("GBU-16"),
    Count       = 1,
    Weight      = 564,
    Cx_pil      = 0.000413,
    
    Elements =
    {
        {
            DrawArgs =    
            {
                [1] = {1, 1},
                [2] = {2, 1},
            }, -- end of DrawArgs
            Position  = {0, 0, 0},
            ShapeName = "GBU-16",
        }, 
    },
    attribute = {4, 5, 36, 39},
    Required  = {"DIS_WMD7"},
}
declare_loadout(JF17_GBU_16)

JF17_GBU_12 = {
    category    = CAT_BOMBS,
    CLSID       = "DIS_GBU_12",
    Picture     = "GBU12.png",
    displayName = _("GBU-12"),
    Count       = 1,
    Weight      = 275,
    Cx_pil      = 0.000413,
    
    Elements =
    {
        {
            DrawArgs =    
            {
                [1] = {1, 1},
                [2] = {2, 1},
            }, -- end of DrawArgs
            Position  = {0, 0, 0},
            ShapeName = "GBU-12",
        }, 
    },
    attribute = {4, 5, 36, 38},
    Required  = {"DIS_WMD7"},
}
declare_loadout(JF17_GBU_12)


---- customized dual rack

-- gdj-ii19 dual mk82 left/right
JF17_MK_82_DUAL_L = {
    category    = CAT_BOMBS,
    CLSID       = "DIS_MK_82_DUAL_L",
    Picture     = "mk82.png",
    displayName = _("GDJ-II19 - 2 x Mk-82"),
    Count       = 2,
    Weight      = 79 + 2 * 241,
    Cx_pil      = 0.00025 * 2 + 0.0,
    
    JettisonSubmunitionOnly = true,
    Elements =
    {
        {ShapeName = "xxxx_l", IsAdapter      = true},
        {ShapeName = "MK-82", connector_name = "Point02"},
        {ShapeName = "MK-82", connector_name = "Point01"}
    },
    
    wsTypeOfWeapon = {4, 5, 9, 31},
    attribute      = {4, 5, 32, WSTYPE_PLACEHOLDER},
}
declare_loadout(JF17_MK_82_DUAL_L)

JF17_MK_82_DUAL_R = {}
copyTable(JF17_MK_82_DUAL_R, JF17_MK_82_DUAL_L)
JF17_MK_82_DUAL_R.CLSID = "DIS_MK_82_DUAL_R"
JF17_MK_82_DUAL_R.Elements[1].ShapeName = "xxxx_r"
JF17_MK_82_DUAL_R.Elements[2].connector_name = "Point01"
JF17_MK_82_DUAL_R.Elements[3].connector_name = "Point02"
JF17_MK_82_DUAL_R.attribute = JF17_MK_82_DUAL_L.attribute
declare_loadout(JF17_MK_82_DUAL_R)


-- gdj-ii19 dual mk82snakeeye left/right
JF17_MK_82S_DUAL_L = {
    category    = CAT_BOMBS,
    CLSID       = "DIS_MK_82S_DUAL_L",
    Picture     = "mk82AIR.png",
    displayName = _("GDJ-II19 - 2 x Mk-82 SnakeEye"),
    Count       = 2,
    Weight      = 79 + 2 * 232,
    Cx_pil      = 0.00035 * 2 + 0.0,
    
    JettisonSubmunitionOnly = true,
    Elements =
    {
        {ShapeName = "xxxx_l", IsAdapter      = true},
        {ShapeName = "MK-82_Snakeye", connector_name = "Point02"},
        {ShapeName = "MK-82_Snakeye", connector_name = "Point01"}
    },
    
    wsTypeOfWeapon = {4, 5, 9, 79},
    attribute      = {4, 5, 32, WSTYPE_PLACEHOLDER},
}
declare_loadout(JF17_MK_82S_DUAL_L)

JF17_MK_82S_DUAL_R = {}
copyTable(JF17_MK_82S_DUAL_R, JF17_MK_82S_DUAL_L)
JF17_MK_82S_DUAL_R.CLSID = "DIS_MK_82S_DUAL_R"
JF17_MK_82S_DUAL_R.Elements[1].ShapeName = "xxxx_r"
JF17_MK_82S_DUAL_R.Elements[2].connector_name = "Point01"
JF17_MK_82S_DUAL_R.Elements[3].connector_name = "Point02"
JF17_MK_82S_DUAL_R.attribute = JF17_MK_82S_DUAL_L.attribute
declare_loadout(JF17_MK_82S_DUAL_R)


-- gdj-ii19 dual mk20 left/right
JF17_MK_20_DUAL_L = {
    category    = CAT_BOMBS,
    CLSID       = "DIS_MK_20_DUAL_L",
    Picture     = "Mk20.png",
    displayName = _("GDJ-II19 - 2 x Mk-20"),
    Count       = 2,
    Weight      = 79 + 2 * 222,
    Cx_pil      = 0.000413 * 2 + 0.0,
    
    JettisonSubmunitionOnly = true,
    Elements =
    {
        {ShapeName = "xxxx_l", IsAdapter      = true},
        {ShapeName = "ROCKEYE", connector_name = "Point02"},
        {ShapeName = "ROCKEYE", connector_name = "Point01"}
    },
    
    wsTypeOfWeapon = {4, 5, 38, 45},
    attribute      = {4, 5, 32, WSTYPE_PLACEHOLDER},
}
declare_loadout(JF17_MK_20_DUAL_L)

JF17_MK_20_DUAL_R = {}
copyTable(JF17_MK_20_DUAL_R, JF17_MK_20_DUAL_L)
JF17_MK_20_DUAL_R.CLSID = "DIS_MK_20_DUAL_R"
JF17_MK_20_DUAL_R.Elements[1].ShapeName = "xxxx_r"
JF17_MK_20_DUAL_R.Elements[2].connector_name = "Point01"
JF17_MK_20_DUAL_R.Elements[3].connector_name = "Point02"
JF17_MK_20_DUAL_R.attribute = JF17_MK_20_DUAL_L.attribute
declare_loadout(JF17_MK_20_DUAL_R)

-- bru-33 dual gbu12
JF17_GBU_12_DUAL = {
    category    = CAT_BOMBS,
    CLSID       = "DIS_GBU_12_DUAL",
    Picture     = "GBU12.png",
    displayName = _("BRU-33 - 2 x GBU-12"),
    Count       = 2,
    Weight      = 79 + 2 * 275,
    Cx_pil      = 0.000413 * 2 + 0.0,
    
    JettisonSubmunitionOnly = true,
    Elements =
    {
        {ShapeName = "BRU_33A", IsAdapter      = true},
        {ShapeName = "GBU-12",  connector_name = "Point02"},
        {ShapeName = "GBU-12",  connector_name = "Point01"}
    },
    
    wsTypeOfWeapon = {4, 5, 36, 38},
    attribute      = {4, 5, 32, WSTYPE_PLACEHOLDER},
    Required       = {"DIS_WMD7"},
}
declare_loadout(JF17_GBU_12_DUAL)


-- gdj-ii19 dual gbu12 left/right
JF17_GBU_12_DUAL_L = {
    category    = CAT_BOMBS,
    CLSID       = "DIS_GBU_12_DUAL_L",
    Picture     = "GBU12.png",
    displayName = _("GDJ-II19 - 2 x GBU-12"),
    Count       = 2,
    Weight      = 79 + 2 * 275,
    Cx_pil      = 0.000413 * 2 + 0.0,
    
    JettisonSubmunitionOnly = true,
    Elements =
    {
        {ShapeName = "xxxx_l", IsAdapter      = true},
        {ShapeName = "GBU-12", connector_name = "Point02"},
        {ShapeName = "GBU-12", connector_name = "Point01"}
    },
    
    wsTypeOfWeapon = {4, 5, 36, 38},
    attribute      = {4, 5, 32, WSTYPE_PLACEHOLDER},
    Required       = {"DIS_WMD7"},
}
declare_loadout(JF17_GBU_12_DUAL_L)

JF17_GBU_12_DUAL_R = {}
copyTable(JF17_GBU_12_DUAL_R, JF17_GBU_12_DUAL_L)
JF17_GBU_12_DUAL_R.CLSID = "DIS_GBU_12_DUAL_R"
JF17_GBU_12_DUAL_R.Elements[1].ShapeName = "xxxx_r"
JF17_GBU_12_DUAL_R.Elements[2].connector_name = "Point01"
JF17_GBU_12_DUAL_R.Elements[3].connector_name = "Point02"
JF17_GBU_12_DUAL_R.attribute = JF17_GBU_12_DUAL_L.attribute
declare_loadout(JF17_GBU_12_DUAL_R)

