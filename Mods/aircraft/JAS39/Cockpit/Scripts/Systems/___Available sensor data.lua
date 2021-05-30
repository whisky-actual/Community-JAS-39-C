--[[
Sensor_Data()

Use local sensor_data = get_base_data() to get all the basic data provided by the sim. Check the sensor data variables link provided to see what is available.



local sensor_data = get_base_data()


getAngleOfAttack

getAngleOfSlide

getBarometricAltitude

getCanopyPos

getCanopyState

getEngineLeftFuelConsumption

getEngineLeftRPM

getEngineLeftTemperatureBeforeTurbine

getEngineRightFuelConsumption

getEngineRightRPM

getEngineRightTemperatureBeforeTurbine

getFlapsPos

getFlapsRetracted

getHeading

getHelicopterCollective

getHelicopterCorrection

getHorizontalAcceleration

getIndicatedAirSpeed            --m/s

getLandingGearHandlePos

getLateralAcceleration

getLeftMainLandingGearDown

getLeftMainLandingGearUp

getMachNumber

getMagneticHeading               --Radians

getNoseLandingGearDown

getNoseLandingGearUp

getPitch

getRadarAltitude

getRateOfPitch					--Radians per second

getRateOfRoll

getRateOfYaw

getRightMainLandingGearDown

getRightMainLandingGearUp

getRoll

getRudderPosition

getSelfAirspeed

getSelfCoordinates

getSelfVelocity

getSpeedBrakePos

getStickPitchPosition           -- -100 to 100

getStickRollPosition

getThrottleLeftPosition

getThrottleRightPosition

getTotalFuelWeight

getTrueAirSpeed

getVerticalAcceleration              --(g’s) G Force normal

getVerticalVelocity                --m/s

getWOW_LeftMainLandingGear

getWOW_NoseLandingGear

getWOW_RightMainLandingGear



Controllers.base_gauge
Same as sensor data


 --base_gauge_RadarAltitude

 --base_gauge_BarometricAltitude

 --base_gauge_AngleOfAttack

 --base_gauge_AngleOfSlide

 --base_gauge_VerticalVelocity

 --base_gauge_TrueAirSpeed

 --base_gauge_IndicatedAirSpeed

 --base_gauge_MachNumber

 --base_gauge_VerticalAcceleration --Ny

 --base_gauge_HorizontalAcceleration --Nx

 --base_gauge_LateralAcceleration --Nz

 --base_gauge_RateOfRoll

 --base_gauge_RateOfYaw

 --base_gauge_RateOfPitch

 --base_gauge_Roll

 --base_gauge_MagneticHeading

 --base_gauge_Pitch

 --base_gauge_Heading

 --base_gauge_EngineLeftFuelConsumption

 --base_gauge_EngineRightFuelConsumption

 --base_gauge_EngineLeftTemperatureBeforeTurbine

 --base_gauge_EngineRightTemperatureBeforeTurbine

 --base_gauge_EngineLeftRPM

 --base_gauge_EngineRightRPM

 --base_gauge_WOW_RightMainLandingGear

 --base_gauge_WOW_LeftMainLandingGear

 --base_gauge_WOW_NoseLandingGear

 --base_gauge_RightMainLandingGearDown

 --base_gauge_LeftMainLandingGearDown

 --base_gauge_NoseLandingGearDown

 --base_gauge_RightMainLandingGearUp

 --base_gauge_LeftMainLandingGearUp

 --base_gauge_NoseLandingGearUp

 --base_gauge_LandingGearHandlePos

 --base_gauge_StickRollPosition

 --base_gauge_StickPitchPosition

 --base_gauge_RudderPosition

 --base_gauge_ThrottleLeftPosition

 --base_gauge_ThrottleRightPosition

 --base_gauge_HelicopterCollective

 --base_gauge_HelicopterCorrection

 --base_gauge_CanopyPos

 --base_gauge_CanopyState

 --base_gauge_FlapsRetracted

 --base_gauge_SpeedBrakePos

 --base_gauge_FlapsPos

 --base_gauge_TotalFuelWeight

