local count = 0
local function counter()
	count = count + 1
	return count
end
-------DEVICE ID----------
devices = {}
devices["ELECTRIC_SYSTEM"]			= counter()
devices["UTILITIES"]				= counter()
devices["ENGINE"]					= counter()
devices["PARKING_BRAKE"]			= counter()
-- devices["GEAR_SYSTEM"]         		= counter()
devices["ADI"]						= counter()
devices["UFC"]						= counter()
devices["CANOPY"]					= counter()
devices["RADAR"]					= counter()
devices["RWR"]						= counter()
devices["MISC_ELEC"]				= counter()

