dofile(LockOn_Options.script_path .. "command_defs.lua")
dofile(LockOn_Options.script_path .. "devices.lua")
dofile(LockOn_Options.script_path .. "utils.lua")



local updateTimeStep = .01 -- 100 Hz
make_default_activity(updateTimeStep)


local nav = GetSelf()


local baseData = get_base_data()

local map = get_terrain_related_data("name")
-- On what map am I on?
-- "Persian Gulf"
-- "Caucasus"

local Terrain = require("terrain")
-- Everything below requires Terrain.
-- x, z, alt coords are in meters!


local terrainAlt = get_param_handle("terrainAlt")
local GPSAlt = get_param_handle("GPSAlt")

local LCP_CoordLAT = get_param_handle("LCP_LAT")
local LCP_CoordLON = get_param_handle("LCP_LON")

local LAT_DEGREES        = get_param_handle("LAT_DEGREES")
local LAT_DECIMALMINUTES = get_param_handle("LAT_DECIMALMINUTES")
local LON_DEGREES        = get_param_handle("LON_DEGREES")
local LON_DECIMALMINUTES = get_param_handle("LON_DECIMALMINUTES")

local PULLUPQUE = get_param_handle("PULLUPQUE")
local PULLMORE  = get_param_handle("PULLMORE")


local degrees = 0
local minutes = 0
local seconds = 0

local DDM_DEG_LAT = 0
local DDM_MIN_LAT = 0

local DDM_DEG_LON = 0
local DDM_MIN_LON = 0

local LoadFactorBlink  = 0
local LoadfactorTooLow = 0

local maxWaypoints = 39

local wpType = {
	W = 1,
	T = 2,
	L = 3
}

local wpCount = {
	W = 0,
	T = 0,
	L = -1
}

local prevWPCount = {
	W = 0,
	T = 0,
	L = -1
}

local selectedWP = get_param_handle("selectedWP")

local loop_once = 0
local iterate = 0
waypoints = {}

for i = 1, maxWaypoints do
	waypoints[i] = {
		lat = get_param_handle("WP_" .. i .. "_latitude"), -- Meters.
		lon = get_param_handle("WP_" .. i .. "_longitude"), -- Meters.
		altitude = get_param_handle("WP_" .. i .. "_altitude"), -- Meters.
		alt_type = get_param_handle("WP_" .. i .. "_alt_type"), -- Baro or radar (for CC).
		distance = get_param_handle("WP_" .. i .. "_distance"), -- Nm.
		speed = get_param_handle("WP_" .. i .. "_speed"), -- M/s.
		type = get_param_handle("WP_" .. i .. "_type"),   -- (W)ay, (T)arget or (L)anding point.
		prevType = 0,                                     -- (W)ay, (T)arget or (L)anding point.
		name = get_param_handle("WP_" .. i .. "_name"),   -- 1 = W, 2 = T, 3 = L.
		CDX = get_param_handle("WP_" .. i .. "_CDX"),     -- MFD coords.
		CDY = get_param_handle("WP_" .. i .. "_CDY"),     -- MFD coords.
		-- RD_X = get_param_handle("WP_" .. i .. "_RD_X"),         -- MFD coords.
		-- RD_Y = get_param_handle("WP_" .. i .. "_RD_Y"),         -- MFD coords.
		heading = get_param_handle("WP_" .. i .. "_heading") -- Degrees.
	}
end


local M2FT = 3.2808399
local TWOPI = math.pi * 2



function post_initialize()
	selectedWP:set(1)
	get_param_handle("numOfWP"):set(#get_mission_route())
end

function update()

	-- Y = LON, X = LAT

	local X_COORD_MET, Z_COORD_MET, Y_COORD_MET = baseData.getSelfCoordinates() -- AC coordinates in meters

	-- convert_to_dms(X_COORD_MET, Y_COORD_MET)


	GPSAlt:set(Z_COORD_MET * M2FT)

	local LAT_COORD_DEC, LON_COORD_DEC = Terrain.convertMetersToLatLon(X_COORD_MET, Y_COORD_MET)
	-- turns the Meters Coords system to LatLong (be aware , it returns 2 vars)
	-- print_message_to_user(LAT_COORD_DEC.."  "..LON_COORD_DEC)


	degrees, minutes, seconds = dd2dms(LAT_COORD_DEC)

	LCP_CoordLAT:set("A/C POS:  " .. AddCharIf(degrees) .. "@" .. AddCharIf(minutes) .. "^" .. AddCharIf(seconds) .. "]N")


	degrees, minutes, seconds = dd2dms(LON_COORD_DEC)

	LCP_CoordLON:set("_______: " .. AddCharIf(degrees, true) .. "@" .. AddCharIf(minutes) .. "^" .. AddCharIf(seconds) .. "]E")



	-- Degrees, decimal minutes	
	DDM_DEG_LAT = math.floor(LAT_COORD_DEC)
	DDM_MIN_LAT = (LAT_COORD_DEC - DDM_DEG_LAT) * 60

	DDM_DEG_LON = math.floor(LON_COORD_DEC)
	DDM_MIN_LON = (LON_COORD_DEC - DDM_DEG_LON) * 60

	-- print_message_to_user(DDM_MIN_LON)
	LAT_DEGREES:set(DDM_DEG_LAT)
	LAT_DECIMALMINUTES:set(DDM_MIN_LAT - 0.0005)
	LON_DEGREES:set(DDM_DEG_LON)
	LON_DECIMALMINUTES:set(DDM_MIN_LON - 0.0005)

	local TerrainAltitude = Terrain.GetHeight(X_COORD_MET, Y_COORD_MET) -- terrain altitude at given X,Y coordinates, in meters

	if math.abs(math.deg(get_param_handle("pitchRad"):get())) >= 30 or math.abs(math.deg(get_param_handle("rollRad"):get())) >= 30 then
		terrainAlt:set(TerrainAltitude * M2FT)
	else
		terrainAlt:set(baseData.getBarometricAltitude() * M2FT - baseData.getRadarAltitude() * M2FT)
	end
	-- terrainAlt:set(TerrainAltitude* M2FT)	--Terrain Altitude in feet

	local v_x, v_z, v_y = baseData.getSelfVelocity() -- Velocity in m/s

	local SafteySeconds = 5

	SafteySeconds = SafteySeconds + math.sqrt(baseData.getPitch()^2) + baseData.getMachNumber()

	v_x = v_x * SafteySeconds -- +m/s North

	v_y = v_y * SafteySeconds -- +m/*s East	

	v_z = v_z * SafteySeconds -- +m/s Up	


	local CollisionAltitude = Terrain.GetHeight(X_COORD_MET + v_x, Y_COORD_MET + v_y) -- terrain altitude at AC coordinates in 5 seconds

	local PlaneAltitude = Z_COORD_MET + v_z - 7 -- Altitude in meters + vertical velocity - saftey margin


	if (PlaneAltitude - CollisionAltitude <= PULLUPQUE:get()) and (v_z < 0) then
		LoadfactorTooLow = 1
	else
		LoadfactorTooLow = 0
		LoadFactorBlink = 0
	end

	if LoadfactorTooLow == 1 then
		if LoadFactorBlink < 1 then
			LoadFactorBlink = LoadFactorBlink + 0.0225
		else
			LoadFactorBlink = 0
		end
	end

	PULLMORE:set(LoadFactorBlink)

	-- terrain height of AC coords in 5 seconds  - AC Altitude in 5 seconds
	PULLUPQUE:set(PlaneAltitude - CollisionAltitude)



	--[[local airdromes = get_terrain_related_data('Airdromes')

	function calculateSlantRange(x_plane, y_plane, z_plane, x_airport, y_airport, z_airport)
		-- Beräkna horisontellt avstånd
		local horizontal_distance = math.sqrt((x_plane - x_airport)^2 + (y_plane - y_airport)^2)
		
		-- Beräkna vertikalt avstånd
		local vertical_distance = z_plane - z_airport
		
		-- Beräkna slant range
		local slant_range = math.sqrt(horizontal_distance^2 + vertical_distance^2)
		
		return slant_range
	end
	
	-- Exempelanvändning
	local x_plane, y_plane, z_plane = 1000, 2000, 10000  -- Flygplanets koordinater i meter
	local x_airport, y_airport, z_airport = 2000, 3000, 200  -- Flygplatsens koordinater i meter
	
	local slant_range = calculateSlantRange(X_COORD_MET, Y_COORD_MET, Z_COORD_MET, airdromes[12].reference_point.x, airdromes[12].reference_point.y, Terrain.GetHeight(airdromes[12].reference_point.x, airdromes[12].reference_point.y))
	print_message_to_user("Slant Range: " .. slant_range .. " meters")
	

	function calculateElevationAngle(altitude_aircraft, altitude_airport, slant_range)
		local elevation_difference = altitude_aircraft - altitude_airport
		local elevation_angle = math.deg(math.atan(elevation_difference / slant_range))
		return elevation_angle
	end
	
	-- Exempelanvändning
	local altitude_aircraft = 10000  -- Flygplanets höjd i meter
	local altitude_airport = 200  -- Flygplatsens höjd i meter
	--local slant_range = 5000  -- Horisontellt avstånd i meter
	
	local elevation_angle = calculateElevationAngle(baseData.getBarometricAltitude(), Terrain.GetHeight(airdromes[12].reference_point.x, airdromes[12].reference_point.y), slant_range)
	print_message_to_user("Elevation Angle: " .. elevation_angle .. " degrees")

	get_param_handle("12apel"):set(-elevation_angle - math.deg(baseData.getPitch()))--]]



	loadWaypoints(get_mission_route())

	local selfVelL, selfVelV, selfVelH = baseData.getSelfAirspeed()
	local distIn30s = math.sqrt(selfVelH^2 + selfVelL^2) * 30
	get_param_handle("CDVelvec"):set(distIn30s / get_param_handle("CD_Scale"):get() * 1.725)
end


function loadWaypoints(missionRoute)

	local xc, zc, yc = baseData.getSelfCoordinates()
	local own_hdg = TWOPI - baseData.getHeading()

	for i = 1, #missionRoute or 39 do
		waypoints[i].lat:set(missionRoute[i].x)
		waypoints[i].lon:set(missionRoute[i].y)
		waypoints[i].altitude:set(missionRoute[i].alt)
		waypoints[i].alt_type:set(missionRoute[i].alt_type)
		waypoints[i].distance:set(math.abs(math.sqrt((missionRoute[i].y - yc)^2 + (missionRoute[i].x - xc)^2)))


		waypoints[i].speed:set(missionRoute[i].speed)

		local mr_type = missionRoute[i].type

		if loop_once == 0 then
			if mr_type == "Turning Point" or mr_type == "Fly Over Point" then
				wpCount.W = wpCount.W + 1
				waypoints[i].name:set("W" .. wpCount.W)
				waypoints[i].type:set(1)
				waypoints[i].prevType = 1
			elseif mr_type == "Land" or mr_type == "LandingReFuAr" or mr_type == "TakeOff" or mr_type == "TakeOffGround" or mr_type == "TakeOffGroundHot" then
				wpCount.L = wpCount.L + 1
				waypoints[i].name:set("L" .. wpCount.L)
				waypoints[i].type:set(3)
				waypoints[i].prevType = 3
			else
				wpCount.T = wpCount.T + 1
				waypoints[i].name:set("T" .. wpCount.T)
				waypoints[i].type:set(2)
				waypoints[i].prevType = 2
				-- print_message_to_user("Waypoint type: " .. mr_type, 30)
			end
			prevWPCount.T = wpCount.T
			prevWPCount.W = wpCount.W
			prevWPCount.L = wpCount.L
		elseif waypoints[i].prevType ~= waypoints[i].type:get() then
			iterate = 1

			wpCount.W = 0
			wpCount.T = 0
			wpCount.L = -1

			waypoints[i].prevType = waypoints[i].type:get()
		end

		if (prevWPCount.T ~= wpCount.T or prevWPCount.W ~= wpCount.W or prevWPCount.L ~= wpCount.L) and i == iterate then
			if waypoints[i].type:get() == 1 then
				wpCount.W = wpCount.W + 1
				waypoints[i].name:set("W" .. wpCount.W)
			elseif waypoints[i].type:get() == 3 then
				wpCount.L = wpCount.L + 1
				waypoints[i].name:set("L" .. wpCount.L)
			elseif waypoints[i].type:get() == 2 then
				wpCount.T = wpCount.T + 1
				waypoints[i].name:set("T" .. wpCount.T)
			end

			iterate = iterate + 1

			if i == #get_mission_route() then
				prevWPCount.T = wpCount.T
				prevWPCount.W = wpCount.W
				prevWPCount.L = wpCount.L
			end
		end

		local dx = math.cos(own_hdg) * (missionRoute[i].y - yc) - math.sin(own_hdg) * (missionRoute[i].x - xc)
		local dy = math.cos(own_hdg) * (missionRoute[i].x - xc) + math.sin(own_hdg) * (missionRoute[i].y - yc)

		waypoints[i].CDX:set(dx / get_param_handle("CD_Scale"):get() * 1.725)
		waypoints[i].CDY:set(dy / get_param_handle("CD_Scale"):get() * 1.725)



		if i == selectedWP:get() then
			get_param_handle("nextWPRange"):set(waypoints[i].distance:get() * .000539956803)
			local az = -math.atan2(dx, dy)
			local el = math.atan((waypoints[i].altitude:get() - baseData.getBarometricAltitude()) / waypoints[i].distance:get()) - baseData.getPitch()

			local fAz, fEl = rotatePoint(az, el, -baseData.getRoll())

			local HUDAz, HUDEl, clamped = clampToRect(fAz, fEl, math.rad(14 - 5.72), math.rad(10 - 2.86), 0, -math.rad(5))
			get_param_handle("nextWPHUDAz"):set(HUDAz)
			get_param_handle("nextWPHUDEl"):set(HUDEl)
			get_param_handle("nextWPHUDAzUnclamped"):set(fAz)
			get_param_handle("nextWPADIAzUnclamped"):set(math.sin(math.max(-1.6, math.min(1.6, -fAz))))
			get_param_handle("nextWPHUDElUnclamped"):set(fEl)
			get_param_handle("nextWPADIElUnclamped"):set(math.sin(math.max(-1.6, math.min(1.6, fEl))))
			get_param_handle("nextWPHUDClamped"):set(clamped and 1 or 0)
			get_param_handle("nextWPHUDClampText"):set(math.sqrt(math.deg(fAz)^2 + math.deg(fEl)^2))

			if get_param_handle("nextWPRange"):get() < .1 and #missionRoute >= i + 1 then
				selectedWP:set(selectedWP:get() + 1)
			end

			get_param_handle("nextWPName"):set(waypoints[i].name:get())
			get_param_handle("nextWPHeading"):set(az)

			local selfHDG
			if get_param_handle("headingMode"):get() == 1 then
				selfHDG = 360 - math.deg(baseData.getHeading())
			else
				selfHDG = math.deg(baseData.getMagneticHeading())
			end

			get_param_handle("nextWPType"):set(waypoints[i].type:get())

			-- TODO: WP info on CD and mach fix on CD, correct types for every wp, (pressing T on UCP changes current W to T), W scrolls through W, T scrolls through T, L scrolls though L, change landing mode keybind.
			get_param_handle("nextWPHeadingClampedHUD"):set(clampToRect(selfHDG - math.deg(az), 0, 14, 1, selfHDG, 0))
			get_param_handle("nextWPHeadingHUD"):set(selfHDG - math.deg(az))
		end
	end

	for i = -60, 115, 5 do
		get_param_handle("distScale_" .. i):set((i / .000539956803) / get_param_handle("CD_Scale"):get() * 1.725)
	end

	loop_once = 1
end


function dd2dms(decimalDegrees)
	local d = math.floor(decimalDegrees)
	local m = math.floor((decimalDegrees - d) * 60)
	local s = math.floor(((((decimalDegrees - d) * 60) - m) * 60) + .5)
	return d, m, s
end

function AddCharIf(DSM, LONbool)
	if not LONbool then
		if DSM < 10 then
			DSM = "0" .. DSM
		end
	else
		if DSM >= 10 and DSM < 100 then
			DSM = "0" .. DSM
		elseif DSM < 10 then
			DSM = "00" .. DSM
		end
	end

	return DSM
end



need_to_be_closed = 0



--[[
Terrain.GetHeight(x, z)
gives you the hight of the terrain at x,z  in meters
for a LOS check is suggest adding 1m to the hight, or round up
otherwise you might get strange results


Terrain.isVisible(x1, alt1, z1, x2, alt2, z2)
check Terrain Line of sight (ignores buildings/trees)

Terrain.GetSurfaceType(x,z)
gives you the type of terrain.
	LAND             1
	SHALLOW_WATER    2
	WATER            3
	ROAD             4
	RUNWAY           5
during my last test there was not landtype for Woods


local tmp_lat,tmp_long = Terrain.convertMetersToLatLon(x,z)
turns the Meters Coords system to LatLong (be aware , it returns 2 vars)

local x, z = Terrain.convertLatLonToMeters(lat,long)
gets you the METERS coord system from Lat Long



local mr = get_mission_route()



function set_d1_xy(x, y)
	local geopos = lo_to_geo_coords(x, y)
	asn41_d1_lat_offset = 0
	asn41_d1_lon_offset = 0
	asn41_d1_lat = geopos.lat
	asn41_d1_lon = geopos.lon
end

function set_d2_xy(x, y)
	local geopos = lo_to_geo_coords(x, y)
	asn41_d2_lat_offset = 0
	asn41_d2_lon_offset = 0
	asn41_d2_lat = geopos.lat
	asn41_d2_lon = geopos.lon
end
--]]