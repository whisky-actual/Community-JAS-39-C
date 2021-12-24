shape_name   	   = "Jas-39-CPT"
is_EDM			   = true
new_model_format   = true
ambient_light    = {255,255,255}
ambient_color_day_texture    = {72, 100, 160}
ambient_color_night_texture  = {40, 60 ,150}
ambient_color_from_devices   = {50, 50, 40}
ambient_color_from_panels	 = {35, 25, 25}

dusk_border					 = 0.4
draw_pilot					 = false

external_model_canopy_arg	 = 38


day_texture_set_value   = 0.0
night_texture_set_value = 0.1


local controllers = LoRegisterPanelControls()

PilotDraw                           = CreateGauge()
PilotDraw.arg_number    	        = 1200
PilotDraw.input				        = {0.0, 1.0}
PilotDraw.output			        = {0.1, 1.0}
PilotDraw.controller		        = controllers.pilot_draw

Throttle							= CreateGauge()
Throttle.arg_number					= 1071
Throttle.input						= {0, 1}
Throttle.output						= {0, 1}
Throttle.controller					= controllers.base_gauge_ThrottleLeftPosition

CanopyLight	                 		= CreateGauge("parameter")
CanopyLight.arg_number      		= 251
CanopyLight.input           		= {0,1}
CanopyLight.output          		= {0,1}
CanopyLight.parameter_name			= "CANOPY_LIGHT"

LDP_Background                      = CreateGauge("parameter")
LDP_Background.arg_number           = 1063
LDP_Background.input                = {0, 1}
LDP_Background.output               = {0, 1}
LDP_Background.parameter_name       = "LDP_BACKGROUND"

RWR_Background                      = CreateGauge("parameter")
RWR_Background.arg_number           = 1239
RWR_Background.input                = {0, 1}
RWR_Background.output               = {0, 1}
RWR_Background.parameter_name       = "RWR_BACKGROUND"



JoystickPitch                 		= CreateGauge("parameter")
JoystickPitch.arg_number            = 1001
JoystickPitch.input                 = {-1, 1}
JoystickPitch.output                = {-1, 1}
JoystickPitch.parameter_name        = "JOYSTICK_PITCH_ANIM"

JoystickRoll                 	    = CreateGauge("parameter")
JoystickRoll.arg_number             = 1002
JoystickRoll.input                  = {-1, 1}
JoystickRoll.output                 = {-1, 1}
JoystickRoll.parameter_name         = "JOYSTICK_ROLL_ANIM"

GearNoseLight	            		= CreateGauge("parameter")
GearNoseLight.arg_number     		= 1066
GearNoseLight.input          		= {0,1}
GearNoseLight.output         		= {0,1}
GearNoseLight.parameter_name		= "GEAR_NOSE_LIGHT"
	
GearLeftLight	            		= CreateGauge("parameter")
GearLeftLight.arg_number     		= 1067
GearLeftLight.input          		= {0,1}
GearLeftLight.output         		= {0,1}
GearLeftLight.parameter_name		= "GEAR_LEFT_LIGHT"
	
GearRightLight	            		= CreateGauge("parameter")
GearRightLight.arg_number     		= 1068
GearRightLight.input          		= {0,1}
GearRightLight.output         		= {0,1}
GearRightLight.parameter_name		= "GEAR_RIGHT_LIGHT"

APUStartLight	            		= CreateGauge("parameter")
APUStartLight.arg_number     		= 1076
APUStartLight.input          		= {0,1}
APUStartLight.output         		= {0,1}
APUStartLight.parameter_name		= "APU_START_LIGHT"

APURunningLight	            		= CreateGauge("parameter")
APURunningLight.arg_number     		= 1077
APURunningLight.input          		= {0,1}
APURunningLight.output         		= {0,1}
APURunningLight.parameter_name		= "APU_RUNNING_LIGHT"

RUDDER_PEDAL                 		= CreateGauge("parameter")
RUDDER_PEDAL.arg_number            	= 1235
RUDDER_PEDAL.input                 	= {-1, 1}
RUDDER_PEDAL.output                	= {-1, 1}
RUDDER_PEDAL.parameter_name        	= "RUDDER_PEDAL_ANIM"

CautionLight	            		= CreateGauge("parameter")
CautionLight.arg_number     		= 1236
CautionLight.input          		= {0,1}
CautionLight.output         		= {0,1}
CautionLight.parameter_name			= "CAUTION_LIGHT"


--------------------------------------------------------------------------------
-- Mirror
--------------------------------------------------------------------------------
 
  
mirrors_data = {
    center_point          = {-4.5,2.2,0}, -- XYZ
    width                 = 2, --integrated (keep in mind that mirrors can be none planar )
    aspect                = 2,
    rotation              = math.rad(0);
    animation_speed       = 2.0;
    near_clip             = 0.1;
    middle_clip           = 40;
    far_clip              = 60000;
	
}	
mirrors_draw                        = CreateGauge()
mirrors_draw.arg_number                = 3
mirrors_draw.input                   = {0,1}
mirrors_draw.output                   = {1,0}
mirrors_draw.controller             = controllers.mirrors_draw
 

need_to_be_closed = true -- close lua state after initialization


--[[ available functions 

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

--]]