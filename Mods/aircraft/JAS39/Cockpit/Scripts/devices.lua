local count = 0
local function counter()
	count = count + 1
	return count
end
-------DEVICE ID----------
devices = {}
devices["ELECTRIC_SYSTEM"]	= counter()
devices["OP_PHASES"]		= counter()
devices["WHEEL_BRAKES"]		= counter()
devices["ACCESSORIES"]		= counter()
devices["GEAR"]         	= counter()
devices["ENGINE"]			= counter()
devices["NVG"]              = counter()
devices["AIRBRAKES"]      	= counter()
devices["LEF"]				= counter()
devices["FLYBYWIRE"]		= counter()
devices["ELEVONS"]			= counter()
devices["RUDDER"]			= counter()
devices["CANARDS"]			= counter()
devices["AUTOTHROTTLE"]		= counter()
devices["WEAPONS"]			= counter()
devices["MFD"]				= counter()
devices["HUD"]				= counter()
devices["CANOPY"]			= counter()
devices["LIGHTS"]			= counter()
devices["DISPLAYS"]			= counter()
devices["COUNTERMEASURES"]	= counter()
devices["STORES"]			= counter()
devices["FUEL"]				= counter()-- Needs to be after STORES in order for it to work
devices["NAVIGATION"]		= counter()
devices["HMD"]				= counter()
devices["RWR"]        		= counter()
devices["FC3"]        		= counter()
devices["UCP"]        		= counter()
devices["LCP"]        		= counter()