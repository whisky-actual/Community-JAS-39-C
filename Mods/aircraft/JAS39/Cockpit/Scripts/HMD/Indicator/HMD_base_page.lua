dofile(LockOn_Options.common_script_path .. "elements_defs.lua")
dofile(LockOn_Options.common_script_path .. "devices_defs.lua")
dofile(LockOn_Options.script_path .. "HMD/Indicator/HMD_Def.lua")



local hologramFilm          = addHMDCircle(nil, nil, nil, nil, hcr.rw, lvl.noclip, nil, nil, 310, 0, 360, 36, MakeMaterial(nil, {25, 25, 25, 0.25})) --Would like it to be more visible.
hologramFilm.element_params = nil
hologramFilm.controllers    = nil

addHMDCircle(nil, nil, nil, nil, hcr.incIf, lvl.noclip, nil, nil, 310, 0, 360, 36, matl.mask, true)



addHMDSimple(base, nil, nil, nil, nil, nil, {"mainpower", "HMDState"}, {{ctrl.compareNum,0, 1}, {ctrl.compareNum,1, 1}})



dofile(LockOn_Options.script_path .. "HMD/Indicator/HMD_Indication_Page.lua")