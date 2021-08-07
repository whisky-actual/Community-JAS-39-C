local count = 0
local function counter()
	count = count + 1
	return count
end
-------DEVICE ID----------
devices = {}
--devices["ELECTRIC_SYSTEM"]		= counter()
--devices["UTILITIES"]				= counter()
--devices["ENGINE"]					= counter()
devices["Wheel_BRAKES"]			= counter()  -- 1
devices["SLAT_SYSTEM"]				= counter()  -- 2
devices["CANARD_SYSTEM"]			= counter()  -- 3
----devices["FLAP_SYSTEM"]			= counter()
devices["LIFT_DUMPING_SYSTEM"]	    = counter()  -- 4
--devices["AIRBRAKES"]        		= counter()
--devices["SUPERSONIC_SYSTEM"] 		= counter()
--devices["FBW_SYSTEM"]				= counter()
--devices["FBW_SYSTEM_API"]			= counter()
--devices["GEAR_SYSTEM"]         	= counter()
--devices["ADI"]					= counter()
--devices["UFC"]					= counter()
--devices["CANOPY"]					= counter()
--devices["RADAR"]					= counter()
--devices["RWR"]					= counter()
--devices["MISC_ELEC"]				= counter()
devices["NVG"]              		= counter()  -- 5 
devices["WHEEL_CHOCKS_LADDER"]		= counter()  -- 6
devices["GEAR_BAYS"]				= counter()  -- 7
devices["ENGINE_NOZZLE"]			= counter()  -- 8
devices["MFD"]						= counter()	-- test

