dofile(LockOn_Options.common_script_path .. "devices_defs.lua")
dofile(LockOn_Options.common_script_path .. "elements_defs.lua")
-- dofile(LockOn_Options.script_path .. "MFD/Indicator/MFD_def.lua")
dofile(LockOn_Options.script_path .. "MFD/Indicator/RD/RD_Def.lua")



base = "RD_Base"



addRDBox(nil, nil, nil, nil, hcr.rw, lvls.noclip, {"mainpower"}, {{ctrl.compareNum, 0, 1}}, width / halfWidth, height / halfWidth, materials["green"], true)  -- Mask for clipping.
addRDBox(nil, nil, nil, nil, hcr.incIf, lvls.noclip, {"mainpower"}, {{ctrl.compareNum, 0, 1}}, width / halfWidth, height / halfWidth, materials["MFDBGGray"]) -- Mask for clipping and background.



addRDSimple(base, nil, nil, nil, nil, nil, {"mainpower"}, {{ctrl.compareNum, 0, 1}})



dofile(LockOn_Options.script_path .. "MFD/Indicator/RD/RD_Main_Pages.lua")



addRDBox(nil, nil, nil, base, hcr.rw, nil, {"RDBrightness"}, {{ctrl.opacity, 0}}, width / halfWidth, height / halfWidth, materials["black"])