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

end

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
local LoadFactorBlink 	 = 0
local LoadfactorTooLow 	 = 0

function update()
	-- Y = LON, X = LAT
	local X_COORD_MET, Z_COORD_MET, Y_COORD_MET = sensor_data.getSelfCoordinates()		-- AC coordinates in meters
		
		GPS_ALTITUDE_FEET:set(Z_COORD_MET* 3.2808399)
		
	local LAT_COORD_DEC,LON_COORD_DEC = Terrain.convertMetersToLatLon(X_COORD_MET,Y_COORD_MET)
	-- turns the Meters Coords system to LatLong (be aware , it returns 2 vars)
	
	
	--print_message_to_user(LON_COORD_DEC)
	
	
	
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

	
	--print_message_to_user( SafteySeconds)
	
	
	
	
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

	--get_param_handle("PULLUPQUE"):set(-2000)

--print_message_to_user(PULLUPQUE:get())

end

need_to_be_closed = 0

--[[
--**This file is an attempt to document every available function in lua in DCS, but is incomplete at the moment**

local dev = GetSelf() --With this utility function the following can be used: performClickableAction, listen_command, listen_event, and for some special devices like avSimpleElectricSystem and avSimpleWeaponSystem there are a few more available

dev:listen_command()
function SetCommand(command,value) -- function called by DCS when a command is triggered
end

dev:listen_event("GroundPowerOn")
dev:listen_event("GroundPowerOff")
dev:listen_event("GroundAirOff")
dev:listen_event("GroundAirOn")
dev:listen_event("WeaponRearmFirstStep")
dev:listen_event("WeaponRearmComplete")
dev:listen_event("WeaponRearmSingleStepComplete")
dev:listen_event("UnlimitedWeaponStationRestore")
dev:listen_event("WheelChocksOn")
dev:listen_event("WheelChocksOff")
function CockpitEvent(event,val) -- function called by DCS when event happens
end

dev:performClickableAction(command, value, true/false)--This is used to ‘click’ a switch without using your mouse. This is used a lot for when a key is pressed and you want that key to move a switch.

post_initialize() --This function is run once at the beginning of mission start

update() --This function is run multiple times a second, depending on the update rate set. At the beginning of your device script you must define the update rate using make_default_activity()

print_message_to_user(output)--prints on screen in game, very useful for debug

local sensor_data = get_base_data() -- sensor data, full list below
getAngleOfAttack()
getAngleOfSlide()
getBarometricAltitude()
getCanopyPos()
getCanopyState()
getEngineLeftFuelConsumption()
getEngineLeftRPM()
getEngineLeftTemperatureBeforeTurbine()
getEngineRightFuelConsumption()
getEngineRightRPM()
getEngineRightTemperatureBeforeTurbine()
getFlapsPos()
getFlapsRetracted()
getHeading()
getHorizontalAcceleration()
getIndicatedAirSpeed()
getLandingGearHandlePos()
getLateralAcceleration()
getLeftMainLandingGearDown()
getLeftMainLandingGearUp()
getMachNumber()
getMagneticHeading()
getNoseLandingGearDown()
getNoseLandingGearUp()
getPitch()
getRadarAltitude()
getRateOfPitch()
getRateOfRoll()
getRateOfYaw()
getRightMainLandingGearDown()
getRightMainLandingGearUp()
getRoll()
getRudderPosition()
getSpeedBrakePos()
getSelfAirspeed()
getSelfCoordinates()
getSelfVelocity()
getStickPitchPosition()
getStickRollPosition()
getThrottleLeftPosition()
getThrottleRightPosition()
getTotalFuelWeight()
getTrueAirSpeed()
getVerticalAcceleration()
getVerticalVelocity()
getWOW_LeftMainLandingGear()
getWOW_NoseLandingGear()
getWOW_RightMainLandingGear()

set_aircraft_draw_argument_value(arg #, value)
get_aircraft_draw_argument_value(arg)
get_cockpit_draw_argument_value(arg)

dispatch_action(device ID, command, value)--Triggers command with value. Similar to device:performClickableAction() but doesn’t move the switch

get_param_handle(name)--This is used to set a param handle, best described as a global variable. It is useful for setting animations in mainpanel.lua, getting information into indicators, and getting information between an EFM and lua if you have an EFM. You use :set(value) and :get() to set and read it. Usage would look like:
throttle_position = get_param_handle("THROTTLE_POSITION")
throttle_position:set(0.5)
throttle_position:get()


--]]