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


local TERRAIN_ALT = get_param_handle("TERRAIN_ALT")
local GPS_ALTITUDE_FEET = get_param_handle("GPS_ALTITUDE_FEET")




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


		GPS_ALTITUDE_FEET:set(Z_COORD_MET* 3.2808399)
		
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
	
	TERRAIN_ALT:set(TerrainAltitude* 3.2808399)	--Terrain Altitude in feet
	
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

end

need_to_be_closed = 0

