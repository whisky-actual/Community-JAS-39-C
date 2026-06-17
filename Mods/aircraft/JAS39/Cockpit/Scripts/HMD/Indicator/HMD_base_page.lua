dofile(LockOn_Options.common_script_path .. "elements_defs.lua")
dofile(LockOn_Options.common_script_path .. "devices_defs.lua")
dofile(LockOn_Options.script_path .. "HMD/Indicator/HMD_Def.lua")



local rot = 13

local hologramFilm          = addHMDCircle(nil, {0, 0, rot}, nil, nil, hcr.rw, lvl.noclip, nil, nil, 310, 0, 360, 36, MakeMaterial(nil, {25, 25, 25, 0.25})) --Would like it to be more visible.
hologramFilm.element_params = nil
hologramFilm.controllers    = nil

addHMDCircle(nil, nil, {0, 0, rot}, nil, hcr.incIf, lvl.noclip, nil, nil, 310, 0, 360, 36, materials.HUDMask, true)


addHMDSimple(base, nil, {0, 0, rot}, nil, nil, nil, {"mainpower", "HMDState"}, {{ctrl.compareNum, 0, 1}, {ctrl.compareNum, 1, 1}})



dofile(LockOn_Options.script_path .. "HMD/Indicator/HMD_Indication_Page.lua")
dofile(LockOn_Options.script_path .. "HMD/Indicator/HMD_Tac_Page.lua")