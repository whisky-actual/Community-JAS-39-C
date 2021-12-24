dofile(LockOn_Options.script_path.."command_defs.lua")
local update_time_step = 0.01 
make_default_activity(update_time_step)
local filename = GetSelf()  
local sensor_data = get_base_data()


-- ===== Local variables =====
local RAD_TO_DEGREE  = 57.29577951308233
local AIRBRAKE_STATE = 0 
local AIRBRAKE_TARGET = 0
local Diff1 = 0
local Diff2 = 0
local AIRBRAKETimeSec = 1.08
local AIRBRAKEIncrement = update_time_step / AIRBRAKETimeSec
local AOA = 0
local AIRBRAKE_OUT = false

function Sensor_data()							-- Go to line 130 for list of available base data
	AOA = sensor_data.getAngleOfAttack() * RAD_TO_DEGREE		-- Angle of attack converted from radians to degrees



end




function update()
Sensor_data()

-- beginning of phases
-- ======================== Stationary =============================	
	--if get_param_handle("CURRENT_PHASE_STATIONARY"):get() > 0.0 then
		
		
-- ========================= Parked ================================
	--elseif get_param_handle("CURRENT_PHASE_PARKED"):get() > 0.0 then 

--========================= Taxi ================================
	if get_param_handle("CURRENT_PHASE_TAXI"):get()> 0.0 then
		if (AIRBRAKE_OUT == true) then 
			dispatch_action(nil,148)  						--Airbrake in
			AIRBRAKE_OUT = false
		end
-- ============= Take off ground roll ===========================
	--elseif get_param_handle("CURRENT_PHASE_TGR"):get() > 0.0 then									
	
		
-- ========================= Rotation ===========================	
	--elseif get_param_handle("CURRENT_PHASE_ROT"):get() > 0.0 then
		
		
-- ================== Lift off ================================
	--elseif get_param_handle("CURRENT_PHASE_LO"):get() > 0.0 then
		
		
-- ======================= Combat ==============================
	elseif get_param_handle("CURRENT_PHASE_CO"):get() > 0.0 then			
		if (AOA >= 26) and (AIRBRAKE_OUT == false) then
			dispatch_action(nil,147)
			AIRBRAKE_OUT = true
		elseif (AOA < 26) and (AIRBRAKE_OUT == true) then
			dispatch_action(nil,148)
			AIRBRAKE_OUT = false
		end
--================ Powered Approach And Landing =================
	--elseif get_param_handle("CURRENT_PHASE_PAL"):get() > 0.0 then
	
--===================== Touch Down =============================		
	elseif get_param_handle("CURRENT_PHASE_TD"):get() > 0.0 then
		if (AIRBRAKE_OUT == false) then	
			dispatch_action(nil,147)  					 --Airbrake out
			AIRBRAKE_OUT = true							 -- declares airbrake is out
		end
	end
--======================= Landing Roll =========================
	--elseif get_param_handle("CURRENT_PHASE_LR"):get() > 0.0 then
	
	--end	
-- end of phases

--set_aircraft_draw_argument_value(182,AIRBRAKE_STATE) --(arg,value)
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