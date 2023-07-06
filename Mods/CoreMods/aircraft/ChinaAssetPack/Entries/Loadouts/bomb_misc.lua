
local function bombs_in_hatch_block(tbl,x0,y0,z0,dy,dz,collumns,layers,count,shape)
    local col = 1
    local layer = 1
    while count > 0 and layer < layers + 1 do
        tbl[#tbl + 1] = {
            Position  = {
                x0,
                y0 + (layer - 1) * dy,
                z0 + (col - 1) * dz,
            },
            ShapeName = shape
        }
                
        col = col + 1
        if col > collumns then
           layer = layer + 1
           col = 1
        end
        count = count - 1
    end
    return count
end

local function h6_bay_hatch(shapename,col,row,layer,gap_y)
    local cols = col
    local rows = row
    local layers = layer

    if cols > 2 then cols = 2 end
    if rows > 3 then rows = 3 end
    if layers > 4 then layers = 4 end

    local count = cols * rows * layers

    local dx    = 2.2
    local dy    = -gap_y
    local dz    = 1.0

    local x0    = 2.2
    local y0    = -0.32 -- -dy * layers - 0.64
    local z0    = -0.5

    y0 = gap_y * (layers - 1) + y0

    local elems = {}

    while count > 0 do
          count = bombs_in_hatch_block(elems,x0,y0,z0,dy,dz,cols,layers,count,shapename)
          x0    = x0 - dx
    end

    return elems
end

---------------------------------------------

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
    ejectImpulse   = 140,
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
    ejectImpulse   = 140,
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
    ejectImpulse   = 140,
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
    category     = CAT_BOMBS,
    CLSID        = "{RBK_500_PTAB105_DUAL_L}",
    Picture      = "rbk500_dual.png",
    displayName  = _("2 x RBK-500-255 PTAB-10-5"),
    Cx_pil       = 0.0004,
    Count        = 2,
    Weight       = 32 + 253*2,
    Weight_Empty = 32,
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
    ejectImpulse   = 140,
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
    attribute    = {4, 5, 38, 45},
    ejectImpulse = 140,
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
    attribute    = {4, 5, 36, 36},
    Required     = {"DIS_WMD7"},
    ejectImpulse = 140,
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
    attribute    = {4, 5, 36, 39},
    Required     = {"DIS_WMD7"},
    ejectImpulse = 140,
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
    attribute    = {4, 5, 36, 38},
    Required     = {"DIS_WMD7"},
    ejectImpulse = 140,
}
declare_loadout(JF17_GBU_12)


---- customized dual rack
-- gdj-ii19 dual mk82 left/right
JF17_MK_82_DUAL_L = {
    category    = CAT_BOMBS,
    CLSID       = "DIS_MK_82_DUAL_GDJ_II19_L",
    Picture     = "mk82.png",
    displayName = _("GDJ-II19 - 2 x Mk-82"),
    Count       = 2,
    Weight      = 79 + 2 * 241,
    Cx_pil      = 0.00025 * 2 + 0.00122,

    JettisonSubmunitionOnly = true,
    Elements =
    {
        {ShapeName = "JF-17_GDJ-II19L", IsAdapter      = true},
        {ShapeName = "MK-82", connector_name = "Pylon_GDJ-II19L_R"},
        {ShapeName = "MK-82", connector_name = "Pylon_GDJ-II19L_L"}
    },

    wsTypeOfWeapon = {4, 5, 9, 31},
    attribute      = {4, 5, 32, WSTYPE_PLACEHOLDER},
    ejectImpulse   = 140,
}
declare_loadout(JF17_MK_82_DUAL_L)

JF17_MK_82_DUAL_R = {}
copyTable(JF17_MK_82_DUAL_R, JF17_MK_82_DUAL_L)
JF17_MK_82_DUAL_R.CLSID = "DIS_MK_82_DUAL_GDJ_II19_R"
JF17_MK_82_DUAL_R.Elements[1].ShapeName = "JF-17_GDJ-II19R"
JF17_MK_82_DUAL_R.Elements[2].connector_name = "Pylon_GDJ-II19R_L"
JF17_MK_82_DUAL_R.Elements[3].connector_name = "Pylon_GDJ-II19R_R"
JF17_MK_82_DUAL_R.attribute = JF17_MK_82_DUAL_L.attribute
declare_loadout(JF17_MK_82_DUAL_R)


-- gdj-ii19 dual mk82snakeeye left/right
JF17_MK_82S_DUAL_L = {
    category    = CAT_BOMBS,
    CLSID       = "DIS_MK_82S_DUAL_GDJ_II19_L",
    Picture     = "mk82AIR.png",
    displayName = _("GDJ-II19 - 2 x Mk-82 SnakeEye"),
    Count       = 2,
    Weight      = 79 + 2 * 232,
    Cx_pil      = 0.00035 * 2 + 0.00122,

    JettisonSubmunitionOnly = true,
    Elements =
    {
        {ShapeName = "JF-17_GDJ-II19L", IsAdapter      = true},
        {ShapeName = "MK-82_Snakeye", connector_name = "Pylon_GDJ-II19L_R"},
        {ShapeName = "MK-82_Snakeye", connector_name = "Pylon_GDJ-II19L_L"}
    },

    wsTypeOfWeapon = {4, 5, 9, 79},
    attribute      = {4, 5, 32, WSTYPE_PLACEHOLDER},
    ejectImpulse   = 140,
}
declare_loadout(JF17_MK_82S_DUAL_L)

JF17_MK_82S_DUAL_R = {}
copyTable(JF17_MK_82S_DUAL_R, JF17_MK_82S_DUAL_L)
JF17_MK_82S_DUAL_R.CLSID = "DIS_MK_82S_DUAL_GDJ_II19_R"
JF17_MK_82S_DUAL_R.Elements[1].ShapeName = "JF-17_GDJ-II19R"
JF17_MK_82S_DUAL_R.Elements[2].connector_name = "Pylon_GDJ-II19R_L"
JF17_MK_82S_DUAL_R.Elements[3].connector_name = "Pylon_GDJ-II19R_R"
JF17_MK_82S_DUAL_R.attribute = JF17_MK_82S_DUAL_L.attribute
declare_loadout(JF17_MK_82S_DUAL_R)


-- gdj-ii19 dual mk20 left/right
JF17_MK_20_DUAL_L = {
    category    = CAT_BOMBS,
    CLSID       = "DIS_MK_20_DUAL_GDJ_II19_L",
    Picture     = "Mk20.png",
    displayName = _("GDJ-II19 - 2 x Mk-20"),
    Count       = 2,
    Weight      = 79 + 2 * 222,
    Cx_pil      = 0.000413 * 2 + 0.00122,

    JettisonSubmunitionOnly = true,
    Elements =
    {
        {ShapeName = "JF-17_GDJ-II19L", IsAdapter      = true},
        {ShapeName = "ROCKEYE", connector_name = "Pylon_GDJ-II19L_R"},
        {ShapeName = "ROCKEYE", connector_name = "Pylon_GDJ-II19L_L"}
    },

    wsTypeOfWeapon = {4, 5, 38, 45},
    attribute      = {4, 5, 32, WSTYPE_PLACEHOLDER},
    ejectImpulse   = 140,
}
declare_loadout(JF17_MK_20_DUAL_L)

JF17_MK_20_DUAL_R = {}
copyTable(JF17_MK_20_DUAL_R, JF17_MK_20_DUAL_L)
JF17_MK_20_DUAL_R.CLSID = "DIS_MK_20_DUAL_GDJ_II19_R"
JF17_MK_20_DUAL_R.Elements[1].ShapeName = "JF-17_GDJ-II19R"
JF17_MK_20_DUAL_R.Elements[2].connector_name = "Pylon_GDJ-II19R_L"
JF17_MK_20_DUAL_R.Elements[3].connector_name = "Pylon_GDJ-II19R_R"
JF17_MK_20_DUAL_R.attribute = JF17_MK_20_DUAL_L.attribute
declare_loadout(JF17_MK_20_DUAL_R)



-- gdj-ii19 dual gbu12 left/right
JF17_GBU_12_DUAL_L = {
    category    = CAT_BOMBS,
    CLSID       = "DIS_GBU_12_DUAL_GDJ_II19_L",
    Picture     = "GBU12.png",
    displayName = _("2 x GBU-12 500 Ib Laser-guided Bomb"),
    Count       = 2,
    Weight      = 79 + 2 * 275,
    Cx_pil      = 0.000413 * 2 + 0.00122,

    JettisonSubmunitionOnly = true,
    Elements =
    {
        {ShapeName = "BRU_33A", IsAdapter      = true},
        {ShapeName = "GBU-12", connector_name = "Point02"},
        {ShapeName = "GBU-12", connector_name = "Point01"}
    },

    wsTypeOfWeapon = {4, 5, 36, 38},
    attribute      = {4, 5, 32, WSTYPE_PLACEHOLDER},
    Required       = {"DIS_WMD7"},
    ejectImpulse   = 140,
}
declare_loadout(JF17_GBU_12_DUAL_L)




-- gdj-ii19 dual gbu12 left/right
JF17_GBU_12_DUAL_R = {
    category    = CAT_BOMBS,
   -- CLSID       = "DIS_GBU_12_DUAL_GDJ_II19_R",
    Picture     = "GBU16.png",
    displayName = _("2 x GBU-16 1000 Ib Laser-guided Bomb"),
    Count       = 2,
    Weight      = 79 + 2 * 275,
    Cx_pil      = 0.000413 * 2 + 0.00122,

    JettisonSubmunitionOnly = true,
    Elements =
    {
        {ShapeName = "BRU_33A", IsAdapter      = true},
        {ShapeName = "GBU-16", connector_name = "Point02"},
        {ShapeName = "GBU-16", connector_name = "Point01"}
    },

    wsTypeOfWeapon = {4, 5, 36, 38},
    attribute      = {4, 5, 32, WSTYPE_PLACEHOLDER},
    Required       = {"DIS_WMD7"},
    ejectImpulse   = 140,
}
declare_loadout(JF17_GBU_12_DUAL_R)

------------------------------------------------------------------

local bomb_250_2_name  = "250-2"
local bomb_250_2_model = "250-2"
local bomb_250_2_disp  = "250-2 - 250kg GP Bombs HD"
local bomb_250_2_mass  = 250.0

local BOMB_250_2 = {
    category  = CAT_BOMBS,
    name      = bomb_250_2_name,
    model     = bomb_250_2_model,
    user_name = _(bomb_250_2_disp),

    type           = 0,    
    mass           = bomb_250_2_mass,
    hMin           = 200.0,
    hMax           = 20000.0,
    Cx             = 0.000999,
    VyHold         = -100.0,
    Ag             = -1.23,
    Reflection     = 0.02,
    warhead        = warheads["FAB_250"],

    wsTypeOfWeapon = {wsType_Weapon, wsType_Bomb, wsType_Bomb_A, WSTYPE_PLACEHOLDER},
    
    shape_table_data =
    {
        {
            name     = bomb_250_2_name,
            file     = bomb_250_2_model,
            life     = 1,
            fire     = {0, 1},
            username = bomb_250_2_name,
            index    = WSTYPE_PLACEHOLDER,
        },
    },

    scheme         = "bomb-common",
    class_name     = "wAmmunition",

    fm =
    {
        mass            = bomb_250_2_mass,
        caliber         = 0.325000,
        cx_coeff        = {1.000000, 0.390000, 0.380000, 0.236000, 1.310000},
        L               = 1.480000,
        I               = 43.077867,
        Ma              = 0.141338,
        Mw              = 2.244756,
        wind_sigma      = 30.000000,
    },
 
    targeting_data = {
        char_time = 20.56, -- characteristic time for sights 
    },
}
declare_weapon(BOMB_250_2)

declare_loadout(
{
    category        = CAT_BOMBS,
    CLSID           = "DIS_BOMB_250_2",
    attribute       = BOMB_250_2.wsTypeOfWeapon,
    Count           = 1,
    Cx_pil          = BOMB_250_2.Cx,
    Picture         = "rus_FAB-250n-1.png",
    displayName     = BOMB_250_2.user_name,
    Weight          = BOMB_250_2.mass,
    Elements  = {
        {
            ShapeName = bomb_250_2_model,
        }, 
    },
    ejectImpulse    = 140,
}
)

H6_250_2_N12 = {
    category    = CAT_BOMBS,
    CLSID       = "DIS_H6_250_2_N12",
    Picture     = "rus_FAB-250n-1.png",
    displayName = _("12 x " .. bomb_250_2_disp),
    Count       = 12,
    Weight      = 3000,
    Cx_pil      = 0.0,

    Elements    = h6_bay_hatch(bomb_250_2_model, 2, 3, 2, 0.32),

    wsTypeOfWeapon = BOMB_250_2.wsTypeOfWeapon,
    attribute      = {4, 5, 32, WSTYPE_PLACEHOLDER},
    ejectImpulse   = 140,
}
declare_loadout(H6_250_2_N12)

H6_250_2_N24 = {
    category    = CAT_BOMBS,
    CLSID       = "DIS_H6_250_2_N24",
    Picture     = "rus_FAB-250n-1.png",
    displayName = _("24 x " .. bomb_250_2_disp),
    Count       = 24,
    Weight      = 6000,
    Cx_pil      = 0.0,

    Elements    = h6_bay_hatch(bomb_250_2_model, 2, 3, 4, 0.32),

    wsTypeOfWeapon = BOMB_250_2.wsTypeOfWeapon,
    attribute      = {4, 5, 32, WSTYPE_PLACEHOLDER},
    ejectImpulse   = 140,
}
declare_loadout(H6_250_2_N24)

MER6_250_2_N6 = {
    category    = CAT_BOMBS,
    CLSID       = "DIS_MER6_250_2_N6",
    Picture     = "rus_FAB-250n-1.png",
    displayName = _("MER6 - 6 x " .. bomb_250_2_disp),
    Count       = 6,
    Weight      = 1500 + 50,
    Cx_pil      = 6.5 * BOMB_250_2.Cx,

    Elements    = {
        {ShapeName = "mbd3-u6-68", IsAdapter = true},
        {ShapeName = bomb_250_2_model, connector_name = "fab_100-250_001"},
        {ShapeName = bomb_250_2_model, connector_name = "fab_100-250_002"},
        {ShapeName = bomb_250_2_model, connector_name = "fab_100-250_003"},
        {ShapeName = bomb_250_2_model, connector_name = "fab_100-250_004"},
        {ShapeName = bomb_250_2_model, connector_name = "fab_100-250_005"},
        {ShapeName = bomb_250_2_model, connector_name = "fab_100-250_006"},
    },

    wsTypeOfWeapon = BOMB_250_2.wsTypeOfWeapon,
    attribute      = {4, 5, 32, WSTYPE_PLACEHOLDER},
    ejectImpulse   = 140,
}
declare_loadout(MER6_250_2_N6)

--------------------------------------

local bomb_250_3_name  = "250-3"
local bomb_250_3_model = "250-3"
local bomb_250_3_disp  = "250-3 - 250kg GP Bombs LD"
local bomb_250_3_mass  = 250.0

local BOMB_250_3 = {
    category  = CAT_BOMBS,
    name      = bomb_250_3_name,
    model     = bomb_250_3_model,
    user_name = _(bomb_250_3_disp),

    type           = 0,    
    mass           = bomb_250_3_mass,
    hMin           = 100.0,
    hMax           = 10000.0,
    Cx             = 0.00025,
    VyHold         = -100.0,
    Ag             = -1.23,
    Reflection     = 0.02,
    warhead        = warheads["FAB_250"],

    wsTypeOfWeapon = {wsType_Weapon, wsType_Bomb, wsType_Bomb_A, WSTYPE_PLACEHOLDER},
    
    shape_table_data =
    {
        {
            name     = bomb_250_3_name,
            file     = bomb_250_3_model,
            life     = 1,
            fire     = {0, 1},
            username = bomb_250_3_name,
            index    = WSTYPE_PLACEHOLDER,
        },
    },

    scheme         = "bomb-common",
    class_name     = "wAmmunition",

    fm =
    {
        mass            = bomb_250_3_mass,
        caliber         = 0.273,
        cx_coeff        = {1.0, 0.29, 0.71, 0.14, 1.28},
        L               = 2.21,
        I               = 94.425933,
        Ma              = 2.746331,
        Mw              = 2.146083,
        wind_time       = 1000.0,
        wind_sigma      = 80.0
    },
 
    targeting_data = {
        char_time = 20.32, -- characteristic time for sights 
    },
}
declare_weapon(BOMB_250_3)

declare_loadout(
{
    category        = CAT_BOMBS,
    CLSID           = "DIS_BOMB_250_3",
    attribute       = BOMB_250_3.wsTypeOfWeapon,
    Count           = 1,
    Cx_pil          = BOMB_250_3.Cx,
    Picture         = "rus_FAB-250n-1.png",
    displayName     = BOMB_250_3.user_name,
    Weight          = BOMB_250_3.mass,
    Elements  = {
        {
            ShapeName = bomb_250_3_model,
        }, 
    },
    ejectImpulse    = 140,
}
)

MER6_250_3_N6 = {
    category    = CAT_BOMBS,
    CLSID       = "DIS_MER6_250_3_N6",
    Picture     = "rus_FAB-250n-1.png",
    displayName = _("MER6 - 6 x " .. bomb_250_3_disp),
    Count       = 6,
    Weight      = 1500 + 50,
    Cx_pil      = 6.5 * BOMB_250_3.Cx,

    Elements    = {
        {ShapeName = "gdj-iv1", IsAdapter = true},
        {ShapeName = bomb_250_3_model, connector_name = "Point005"},
        {ShapeName = bomb_250_3_model, connector_name = "Point003"},
        {ShapeName = bomb_250_3_model, connector_name = "Point006"},
        {ShapeName = bomb_250_3_model, connector_name = "Point002"},
        {ShapeName = bomb_250_3_model, connector_name = "Point004"},
        {ShapeName = bomb_250_3_model, connector_name = "Point001"},
    },

    wsTypeOfWeapon = BOMB_250_3.wsTypeOfWeapon,
    attribute      = {4, 5, 32, WSTYPE_PLACEHOLDER},
    ejectImpulse   = 140,
}
declare_loadout(MER6_250_3_N6)

