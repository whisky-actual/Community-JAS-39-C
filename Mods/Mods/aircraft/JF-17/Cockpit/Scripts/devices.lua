---- COUNTER FOR DEVICE ID-----
local count = 0
local function counter()
    count = count + 1
    return count
end
-------DEVICE ID-------
devices = {}
devices["ELECTRIC_SYSTEM"] = counter() -- 1
devices["HYDRAULICS"]      = counter()
devices["PNEUMATIC"]       = counter()

devices["LIGHTS"]         = counter() -- 4
devices["WARNING_SYSTEM"] = counter()

devices["EMMC"] = counter() -- 6
devices["AAP"]  = counter()
devices["ADC"]  = counter()
devices["DTC"]  = counter()

devices["RDR"]  = counter() -- 10
devices["WCS"]  = counter()
devices["SPJ"]  = counter()
devices["OESP"] = counter()
devices["RWR"]  = counter()
devices["IFF"]  = counter()
devices["SMS"]  = counter()

devices["SHARS"]   = counter() -- 17
devices["INS"]     = counter()
devices["NAVCOMP"] = counter()
devices["DMAP"]    = counter()

devices["RALT"]  = counter() -- 21
devices["MLS"]   = counter()
devices["TACAN"] = counter()

devices["INTERCOM"] = counter() -- 24
devices["COMM1"]    = counter()
devices["COMM2"]    = counter()
devices["DATALINK"] = counter()

devices["CNI"]    = counter() -- 28
devices["ACP"]    = counter()

devices["ECS"]    = counter() -- 30
devices["OXYGEN"] = counter()

devices["GEAR"]   = counter() -- 32
devices["FUEL"]   = counter()
devices["ENGINE"] = counter()
devices["FCS"]    = counter()

devices["DLINKPOD"] = counter() -- 36

devices["ZCP"]  = counter() -- 37
devices["MISC"] = counter()
devices["SNS"]  = counter() -- 39

devices["CTRL_IND"] = counter() -- 40
devices["MACRO"]    = counter()

devices["NVG"]    = counter() --42

-- test (start)
devices["TEST_DEV"] = counter()
devices["PITO"]     = counter()
-- test (end)

devices["HUD"]  = counter()
devices["UFCP"] = counter()
devices["MFCD"] = counter()
devices["HMD"]  = counter()

devices["CLOCK"] = counter()

-- test
devices["EFFECT"] = counter()
devices["CANARDS"]			= counter()
devices["CANOPY"]			= counter()