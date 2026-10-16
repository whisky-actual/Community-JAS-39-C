dofile(LockOn_Options.script_path .. "HUD/Indicator/HUD_def.lua")
dofile(LockOn_Options.common_script_path .. "elements_defs.lua")
dofile(LockOn_Options.common_script_path .. "devices_defs.lua")



local rot = 36 / 2

-- HUDGlassVerts = 		{
		-- {-160 + 10, -255 + 5}, {0, -255}, {-201.7 + 10, -184}, {-236.2, -59.5}, {-233, 107.8}, {-217.5, 139.3}, {-180.8 + 10, 199.2 - 15}, {-140, 213 - 20}, {-110, 220.3 - 20}, {-78.5, 225.4 - 20},
		-- {-18.7,     229.8 - 20}, {18.7, 229.8 - 20}, {79.3, 225.7 - 20}, {111, 220.6 - 20}, {143.3, 212.8 - 20}, {183.6 - 10, 199.3 - 15}, {219, 139.4}, {235, 107.8}, {238.4, -59.5}, {204 - 10, -184},
		-- {163 - 10, -255 + 5}
	-- }
-- HUDGlassInd = {0, 1, 2, 2, 1, 3, 3, 1, 4, 4, 1, 5, 5, 1, 6, 6, 1, 7, 7, 1, 8, 8, 1, 9, 9, 1, 10, 10, 1, 11, 11, 1, 12, 12, 1, 13, 13, 1, 14, 14, 1, 15, 15, 1, 16, 16, 1, 17, 17, 1, 18, 18, 1, 19, 19, 1, 20}
local HUDGlassVerts = {{300, 300}, {-300, 300}, {-300, -300}, {300, -300}}
local HUDGlassInd = {0, 1, 2, 0, 2, 3}


local glassMask = addHUDMeshPoly(
	nil, {0, -150}, nil, nil, hcr.rw, HUDLvls.noclip, nil, nil, HUDGlassVerts, HUDGlassInd, materials.cyan,
	true
)
glassMask.collimated = false


addHUDMeshPoly( --d2Mr(-25.1125)
	"HUD_Total_FOV", {-.5125, -1.17343 * fov2MilRad - d2Mr(5)}, {0, 0, rot}, nil, hcr.incIf, HUDLvls.noclip, nil, nil,
	{
		{0,        -d2Mr(10)}, {-d2Mr(12.5), -d2Mr(10)}, {-d2Mr(14), -d2Mr(8)}, {-d2Mr(14), d2Mr(6.5)}, {-d2Mr(11), d2Mr(10)}, {d2Mr(11), d2Mr(10)}, {d2Mr(14), d2Mr(6.5)}, {d2Mr(14), -d2Mr(8)}, {d2Mr(12.5), -d2Mr(10)},
		{-d2Mr(12.5), -d2Mr(10)}
	}, {0, 1, 2, 0, 2, 3, 0, 3, 4, 0, 4, 5, 0, 5, 6, 0, 6, 7, 0, 7, 8}, MakeMaterial(nil, {16, 3, 24, .255}), false
)


addHUDSimple("HUD_Base", {0, d2Mr(5)}, nil, "HUD_Total_FOV", nil, nil, {"DisplaysBooted"}, {{ctrl.compareNum, 0, 1}})



dofile(LockOn_Options.script_path .. "HUD/Indicator/HUD_indication_page.lua")