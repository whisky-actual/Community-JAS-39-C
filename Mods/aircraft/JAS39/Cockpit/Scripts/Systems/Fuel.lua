dofile(LockOn_Options.script_path.."command_defs.lua")
local update_time_step = 0.2 -- 5 times / sec
make_default_activity(update_time_step)
local Fuel = GetSelf()
local sensor_data = get_base_data()

local LD_UPPER = get_param_handle("LD_UPPER")

local UNIT_MODE = get_param_handle("UNIT_MODE")
local fuel_pct = get_param_handle("FUEL")
local extra_fuel_pct = get_param_handle("XF_FUEL")
local FUEL_TO_FILL = get_param_handle("FUEL_TO_FILL")
local FUEL_CONTENTS = get_param_handle("FUEL_CONTENTS")
local FUEL_FLOW = get_param_handle("FUEL_FLOW")

local MAX_MEASURED_AMOUNT_PCT = 0
local MAX_MEASURED_AMOUNT_L = 0
local MAX_MEASURED_AMOUNT_LBS = 0
local MAX_MEASURED_AMOUNT_KG = 0

local CURRENT_FUEL_AMOUNT_PCT = 0 
local CURRENT_FUEL_AMOUNT_L = 0 
local CURRENT_FUEL_AMOUNT_LBS = 0 
local CURRENT_FUEL_AMOUNT_KG = 0 

local LAST_FUEL_AMOUNT = 0 

local max_amount_pct = 22.50					-- max 2550 kg/ 22.50 = 113.3% 
local FlowCounter = 0

local INNER_PYLON_L_LOADOUT = get_param_handle("INNER_PYLON_L_LOADOUT")
local CENTERLINE_PYLON_LOADOUT = get_param_handle("CENTERLINE_PYLON_LOADOUT")
local INNER_PYLON_R_LOADOUT = get_param_handle("INNER_PYLON_R_LOADOUT")

function post_initialize()	
	MaxFuelPerLoadout()
end

Fuel:listen_event("WeaponRearmComplete")

function CockpitEvent(event, val)												
    if event == "WeaponRearmComplete" then
		MaxFuelPerLoadout()
	end
end

function MaxFuelPerLoadout()
	MAX_MEASURED_AMOUNT_PCT = 113
	MAX_MEASURED_AMOUNT_L = 3000
	MAX_MEASURED_AMOUNT_LBS = 6614
	MAX_MEASURED_AMOUNT_KG = 2550
	
	
	
	
	
	if INNER_PYLON_L_LOADOUT:get() == 0.9 then	-- if 1100 L tank is loaded
		MAX_MEASURED_AMOUNT_PCT = MAX_MEASURED_AMOUNT_PCT + 38
		MAX_MEASURED_AMOUNT_L = MAX_MEASURED_AMOUNT_L + 1100
		MAX_MEASURED_AMOUNT_LBS = MAX_MEASURED_AMOUNT_LBS + 2207
		MAX_MEASURED_AMOUNT_KG = MAX_MEASURED_AMOUNT_KG + 851
		
	elseif INNER_PYLON_L_LOADOUT:get() == 0.91 then		-- if 1700 L tank is loaded
		MAX_MEASURED_AMOUNT_PCT = MAX_MEASURED_AMOUNT_PCT + 59
		MAX_MEASURED_AMOUNT_L = MAX_MEASURED_AMOUNT_L + 1700
		MAX_MEASURED_AMOUNT_LBS = MAX_MEASURED_AMOUNT_LBS + 3411
		MAX_MEASURED_AMOUNT_KG = MAX_MEASURED_AMOUNT_KG + 1315
	end
	
	if INNER_PYLON_R_LOADOUT:get() == 0.90 then	-- if 1100 L tank is loaded
		MAX_MEASURED_AMOUNT_PCT = MAX_MEASURED_AMOUNT_PCT + 38
		MAX_MEASURED_AMOUNT_L = MAX_MEASURED_AMOUNT_L + 1100
		MAX_MEASURED_AMOUNT_LBS = MAX_MEASURED_AMOUNT_LBS + 2207
		MAX_MEASURED_AMOUNT_KG = MAX_MEASURED_AMOUNT_KG + 851
		
		
	elseif INNER_PYLON_R_LOADOUT:get() == 0.91 then		-- if 1700 L tank is loaded
		MAX_MEASURED_AMOUNT_PCT = MAX_MEASURED_AMOUNT_PCT + 59
		MAX_MEASURED_AMOUNT_L = MAX_MEASURED_AMOUNT_L + 1700
		MAX_MEASURED_AMOUNT_LBS = MAX_MEASURED_AMOUNT_LBS + 3411
		MAX_MEASURED_AMOUNT_KG = MAX_MEASURED_AMOUNT_KG + 1315	
	end
	
	if CENTERLINE_PYLON_LOADOUT:get() == 0.90 then	-- if 1100 L tank is loaded
		MAX_MEASURED_AMOUNT_PCT = MAX_MEASURED_AMOUNT_PCT + 38
		MAX_MEASURED_AMOUNT_L = MAX_MEASURED_AMOUNT_L + 1100
		MAX_MEASURED_AMOUNT_LBS = MAX_MEASURED_AMOUNT_LBS + 2207
		MAX_MEASURED_AMOUNT_KG = MAX_MEASURED_AMOUNT_KG + 851
	end


end

function FlowOrNot()
	if LAST_FUEL_AMOUNT < CURRENT_FUEL_AMOUNT_LBS then
		FUEL_FLOW:set(1)
	else 
		FUEL_FLOW:set(0)
	end
	FlowCounter = 0
end





function update()
-- fuel====================================================================================================================================

	if UNIT_MODE:get() == 1 then
		if CURRENT_FUEL_AMOUNT_PCT > MAX_MEASURED_AMOUNT_PCT then
			MAX_MEASURED_AMOUNT_PCT = CURRENT_FUEL_AMOUNT_PCT
		end
		FUEL_TO_FILL:set(MAX_MEASURED_AMOUNT_PCT - CURRENT_FUEL_AMOUNT_PCT)
		FUEL_CONTENTS:set(CURRENT_FUEL_AMOUNT_PCT)
		
	elseif UNIT_MODE:get() == 2 then
		if CURRENT_FUEL_AMOUNT_L > MAX_MEASURED_AMOUNT_L then
			MAX_MEASURED_AMOUNT_L = CURRENT_FUEL_AMOUNT_L
		end
		FUEL_TO_FILL:set(MAX_MEASURED_AMOUNT_L - CURRENT_FUEL_AMOUNT_L)
		FUEL_CONTENTS:set(CURRENT_FUEL_AMOUNT_L)
		
	elseif UNIT_MODE:get() == 3 then
		if CURRENT_FUEL_AMOUNT_LBS > MAX_MEASURED_AMOUNT_LBS then
			MAX_MEASURED_AMOUNT_LBS = CURRENT_FUEL_AMOUNT_LBS
		end
		FUEL_TO_FILL:set(MAX_MEASURED_AMOUNT_LBS - CURRENT_FUEL_AMOUNT_LBS)
		FUEL_CONTENTS:set(CURRENT_FUEL_AMOUNT_LBS)
	elseif UNIT_MODE:get() == 4 then
		if CURRENT_FUEL_AMOUNT_KG > MAX_MEASURED_AMOUNT_KG then
			MAX_MEASURED_AMOUNT_KG = CURRENT_FUEL_AMOUNT_KG
		end
		FUEL_TO_FILL:set(MAX_MEASURED_AMOUNT_KG - CURRENT_FUEL_AMOUNT_KG)
		FUEL_CONTENTS:set(CURRENT_FUEL_AMOUNT_KG)
	end

	--1 = % , 2 = Litres, 3 = Lbs, 4 = Kg
	CURRENT_FUEL_AMOUNT_PCT = (sensor_data.getTotalFuelWeight() / max_amount_pct)
	CURRENT_FUEL_AMOUNT_L = (sensor_data.getTotalFuelWeight() * 1.176470)
	CURRENT_FUEL_AMOUNT_LBS = (sensor_data.getTotalFuelWeight() * 1.176470) * 2.2046
	CURRENT_FUEL_AMOUNT_KG = sensor_data.getTotalFuelWeight()
	
	
	

--UNIT_MODE:set(1)			-- 1 = % , 2 = Litres, 3 = Lbs, 4 = Kg
	fuel_pct:set(CURRENT_FUEL_AMOUNT_PCT)
	if fuel_pct:get() >= 113 then
		extra_fuel_pct:set(fuel_pct:get() -113)
	else 
		extra_fuel_pct:set(0)
	end

	if (LD_UPPER:get() == 3) then --if aar page is selected
	
		FlowCounter = FlowCounter + 1
		
		if FlowCounter == 5 then
			LAST_FUEL_AMOUNT = CURRENT_FUEL_AMOUNT_LBS
		end
	
		
		
		if FlowCounter == 10 then
			FlowOrNot()
	
		end
	
	end

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