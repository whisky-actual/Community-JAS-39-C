dofile(LockOn_Options.script_path.."command_defs.lua")
local update_time_step = 0.01 -- 100 times / sec
make_default_activity(update_time_step)
local dev = GetSelf()
local sensor_data = get_base_data()

local map = get_terrain_related_data("name")
--on what map am i on?
--"Persian Gulf"
--"Caucasus"

local Terrain           = require('terrain')
--everything below requires Terrain
--X , Z , Alt Coords are in Meters!


local terrainAlt = get_param_handle("terrainAlt")
local GPSAlt = get_param_handle("GPSAlt")



local absPitch = get_param_handle("absPitch")
local absRoll  = get_param_handle("absRoll")


local M_TO_FT = 3.2808399



function post_initialize()

--local map = get_terrain_related_data("name")
--on what map am i on?
--"Persian Gulf"
--"Caucasus"


--local Terrain           = require('terrain')
--everything below requires Terrain
--X , Z , Alt Coords are in Meters!


--Terrain.GetHeight(x, z)
--gives you the hight of the terrain at x,z  in meters
-- for a LOS check is suggest adding 1m to the hight, or round up
-- otherwise you might get strange results


--Terrain.isVisible(x1, alt1, z1, x2, alt2, z2)
-- check Terrain Line of sight (ignores buildings/trees)

--Terrain.GetSurfaceType(x,z)
-- gives you the type of terrain.
--  LAND             1
--  SHALLOW_WATER    2
--  WATER            3 
--  ROAD             4
--  RUNWAY           5
-- during my last test there was not landtype for Woods


--local tmp_lat,tmp_long = Terrain.convertMetersToLatLon(x,z)
-- turns the Meters Coords system to LatLong (be aware , it returns 2 vars)

--local x, z = Terrain.convertLatLonToMeters(lat,long)
--gets you the METERS coord system from Lat Long




	--local mr = get_mission_route()



end

local degrees =  0
local minutes =  0
local seconds =  0

local LCP_CoordLAT = get_param_handle("LCP_LAT")
local LCP_CoordLON = get_param_handle("LCP_LON")

local DDM_DEG_LAT = 0
local DDM_MIN_LAT = 0
				    
local DDM_DEG_LON = 0
local DDM_MIN_LON = 0

local LAT_DEGREES 		 = get_param_handle("LAT_DEGREES")	
local LAT_DECIMALMINUTES = get_param_handle("LAT_DECIMALMINUTES")
local LON_DEGREES 		 = get_param_handle("LON_DEGREES")	
local LON_DECIMALMINUTES = get_param_handle("LON_DECIMALMINUTES")

local PULLUPQUE 		 = get_param_handle("PULLUPQUE")
local PULLMORE 		 	 = get_param_handle("PULLMORE")
local TEST_PARAM 		 = get_param_handle("TEST_PARAM")

local LoadFactorBlink 	 = 0
local LoadfactorTooLow 	 = 0


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


function convert_dd_to_dms(decimal_degrees)
    local d = math.floor(decimal_degrees)
    local m = math.floor((decimal_degrees - d) * 60)
    local s = math.floor(((((decimal_degrees - d) * 60) - m) * 60) + 0.5 )
    return d, m, s
end

function AddCharIf(DSM, LONbool)

	if not LONbool then
		if DSM < 10 then
			DSM = "0"..DSM
		end
	else
		if DSM >= 10 and DSM < 100 then
			DSM = "0"..DSM
		elseif DSM < 10 then
			DSM = "00"..DSM
		end
	end

	return DSM
end


function update()

	-- Y = LON, X = LAT
	
	local X_COORD_MET, Z_COORD_MET, Y_COORD_MET = sensor_data.getSelfCoordinates()		-- AC coordinates in meters
		
	--convert_to_dms(X_COORD_MET, Y_COORD_MET)


		GPSAlt:set(Z_COORD_MET* 3.2808399)
		
	local LAT_COORD_DEC,LON_COORD_DEC = Terrain.convertMetersToLatLon(X_COORD_MET,Y_COORD_MET)
	-- turns the Meters Coords system to LatLong (be aware , it returns 2 vars)
	--print_message_to_user(LAT_COORD_DEC.."  "..LON_COORD_DEC)


	degrees, minutes, seconds = convert_dd_to_dms(LAT_COORD_DEC)

	LCP_CoordLAT:set("A/C POS:  "..AddCharIf(degrees).."@"..AddCharIf(minutes).."^"..AddCharIf(seconds).."]N")
	

	degrees, minutes, seconds = convert_dd_to_dms(LON_COORD_DEC)

	LCP_CoordLON:set("_______: "..AddCharIf(degrees, true).."@"..AddCharIf(minutes).."^"..AddCharIf(seconds).."]E")


	
--Degrees, decimal minutes	
	DDM_DEG_LAT = math.floor(LAT_COORD_DEC) 
	DDM_MIN_LAT = (LAT_COORD_DEC - DDM_DEG_LAT) * 60
	
	DDM_DEG_LON = math.floor(LON_COORD_DEC)
	DDM_MIN_LON = (LON_COORD_DEC - DDM_DEG_LON) * 60
	
	--print_message_to_user(DDM_MIN_LON)
	LAT_DEGREES:set(DDM_DEG_LAT)		
	LAT_DECIMALMINUTES:set(DDM_MIN_LAT-0.0005)
	LON_DEGREES:set(DDM_DEG_LON) 		
	LON_DECIMALMINUTES:set(DDM_MIN_LON-0.0005)
	
	local TerrainAltitude = Terrain.GetHeight(X_COORD_MET,Y_COORD_MET)	-- terrain altitude at given X,Y coordinates, in meters
	
	if math.abs(math.deg(get_param_handle("pitchRad"):get())) >= 30 or math.abs(math.deg(get_param_handle("rollRad"):get())) >= 30 then
		terrainAlt:set(TerrainAltitude * M_TO_FT)
	else
		terrainAlt:set(sensor_data.getBarometricAltitude() * M_TO_FT - sensor_data.getRadarAltitude() * M_TO_FT)
	end
	--terrainAlt:set(TerrainAltitude* 3.2808399)	--Terrain Altitude in feet
	
	local v_x, v_z, v_y = sensor_data.getSelfVelocity() --Velocity in m/s
	
	local SafteySeconds = 5 
	
	SafteySeconds = SafteySeconds + math.sqrt(sensor_data.getPitch()^2) + sensor_data.getMachNumber()

	v_x = v_x * SafteySeconds	-- +m/s North
	
	v_y = v_y * SafteySeconds	-- +m/*s East	
	
	v_z = v_z * SafteySeconds	-- +m/s Up	

	
	local CollisionAltitude = Terrain.GetHeight(X_COORD_MET + v_x ,Y_COORD_MET + v_y)	-- terrain altitude at AC coordinates in 5 seconds

	local PlaneAltitude = Z_COORD_MET + v_z - 7 -- Altitude in meters + vertical velocity - saftey margin 


	if (PlaneAltitude - CollisionAltitude <= PULLUPQUE:get()) and ( v_z < 0) then
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
	
	local elevation_angle = calculateElevationAngle(sensor_data.getBarometricAltitude(), Terrain.GetHeight(airdromes[12].reference_point.x, airdromes[12].reference_point.y), slant_range)
	print_message_to_user("Elevation Angle: " .. elevation_angle .. " degrees")

	get_param_handle("12apel"):set(-elevation_angle - math.deg(sensor_data.getPitch()))--]]
	
	

end

need_to_be_closed = 0

