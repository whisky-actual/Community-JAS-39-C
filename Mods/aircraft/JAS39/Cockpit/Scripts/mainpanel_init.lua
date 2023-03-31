shape_name   	   = "Jas-39-CPT"
is_EDM			   = true
new_model_format   = true
ambient_light                = {255,255,255}
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

use_external_views          = false

-------------------------------------------------------
--FC3 Commands
-------------------------------------------------------
MIRROR                              = CreateGauge("parameter")
MIRROR.arg_number                   = 3004
MIRROR.input                        = {0, 1}
MIRROR.output                       = {-1, 1}
MIRROR.parameter_name               = "MIRROR"

LKneeboardDraw                      = CreateGauge("parameter")
LKneeboardDraw.arg_number           = 3008
LKneeboardDraw.input                = {0, 1}
LKneeboardDraw.output               = {-1, 1}
LKneeboardDraw.parameter_name       = "LKneeboardDraw"

RKneeboardDraw                      = CreateGauge("parameter")
RKneeboardDraw.arg_number           = 3007
RKneeboardDraw.input                = {0, 1}
RKneeboardDraw.output               = {-1, 1}
RKneeboardDraw.parameter_name       = "RKneeboardDraw"

JoystickDraw                       	= CreateGauge("parameter")
JoystickDraw.arg_number            	= 3006
JoystickDraw.input                 	= {-1, 1}
JoystickDraw.output                	= {-1, 1}
JoystickDraw.parameter_name        	= "JoystickDraw"
-------------------------------------------------------
--Left Console Panel
-------------------------------------------------------

-------------------------------------------------------
--Left Auxiliary Console
-------------------------------------------------------
GearNoseLight	            		= CreateGauge("parameter")
GearNoseLight.arg_number     		= 2033
GearNoseLight.input          		= {0,1}
GearNoseLight.output         		= {-1,1}
GearNoseLight.parameter_name		= "GEAR_NOSE_LIGHT"	
	
GearLeftLight	            		= CreateGauge("parameter")
GearLeftLight.arg_number     		= 2034
GearLeftLight.input          		= {0,1}
GearLeftLight.output         		= {-1,1}
GearLeftLight.parameter_name		= "GEAR_LEFT_LIGHT"
	
GearRightLight	            		= CreateGauge("parameter")
GearRightLight.arg_number     		= 2035
GearRightLight.input          		= {0,1}
GearRightLight.output         		= {-1,1}
GearRightLight.parameter_name		= "GEAR_RIGHT_LIGHT"

APUEMGYRunningLight	            	= CreateGauge("parameter")
APUEMGYRunningLight.arg_number     	= 1079
APUEMGYRunningLight.input          	= {-1,1}
APUEMGYRunningLight.output         	= {-1,1}
APUEMGYRunningLight.parameter_name	= "APUEMGY_RUNNING_LIGHT"

-------------------------------------------------------
--Instrument Panel
-------------------------------------------------------
SpeedBrakeInd	            	= CreateGauge("parameter")  
SpeedBrakeInd.arg_number     	= 2036                      
SpeedBrakeInd.input          	= {0,1}                     
SpeedBrakeInd.output         	= {-1,1}                     
SpeedBrakeInd.parameter_name	= "SpeedBrakeInd"

HMD_LIGHT	            		= CreateGauge("parameter")
HMD_LIGHT.arg_number     		= 2090
HMD_LIGHT.input          		= {0,1}
HMD_LIGHT.output         		= {-1,1}
HMD_LIGHT.parameter_name		= "HMD_LIGHT"

ATT_LIGHT	            		= CreateGauge("parameter")
ATT_LIGHT.arg_number     		= 2078
ATT_LIGHT.input          		= {0,1}
ATT_LIGHT.output         		= {-1,1}
ATT_LIGHT.parameter_name		= "ATT_LIGHT"

ALT_LIGHT	            		= CreateGauge("parameter")
ALT_LIGHT.arg_number     		= 2077
ALT_LIGHT.input          		= {0,1}
ALT_LIGHT.output         		= {-1,1}
ALT_LIGHT.parameter_name		= "ALT_LIGHT"

MAN_LIGHT	            		= CreateGauge("parameter")
MAN_LIGHT.arg_number     		= 2079
MAN_LIGHT.input          		= {0,1}
MAN_LIGHT.output         		= {-1,1}
MAN_LIGHT.parameter_name		= "MAN_LIGHT"

CautionLight	            	= CreateGauge("parameter")
CautionLight.arg_number     	= 3005
CautionLight.input          	= {-1,1}
CautionLight.output         	= {-1,1}
CautionLight.parameter_name		= "CAUTION_LIGHT"
-------------------------------------------------------
--LD
-------------------------------------------------------
LDP_Background                      = CreateGauge("parameter")
LDP_Background.arg_number           = 3000
LDP_Background.input                = {0, 1}
LDP_Background.output               = {0, 1}
LDP_Background.parameter_name       = "LDP_BACKGROUND"
-------------------------------------------------------
--CD
-------------------------------------------------------
RWR_Background                      = CreateGauge("parameter")
RWR_Background.arg_number           = 3001
RWR_Background.input                = {0, 1}
RWR_Background.output               = {-1, 1}
RWR_Background.parameter_name       = "RWR_BACKGROUND"
-------------------------------------------------------
--RD
-------------------------------------------------------
RDR_Background                      = CreateGauge("parameter")
RDR_Background.arg_number           = 3002
RDR_Background.input                = {0, 1}
RDR_Background.output               = {0, 1}
RDR_Background.parameter_name       = "RDR_BACKGROUND"
-------------------------------------------------------
--Right Auxiliary Console
-------------------------------------------------------

-------------------------------------------------------
-- Right Console Panel
-------------------------------------------------------
MapLight	            			= CreateGauge("parameter")  
MapLight.arg_number     			= 179                       
MapLight.input          			= {0,1}                     
MapLight.output         			= {0,1}                     
MapLight.parameter_name				= "FLOOD_LIGHT"           

FloodLight	            			= CreateGauge("parameter")  
FloodLight.arg_number     			= 180                       
FloodLight.input          			= {0,1}                     
FloodLight.output         			= {0,1}                     
FloodLight.parameter_name			= "FLOOD_LIGHT"  

BackLighting	            		= CreateGauge("parameter")  
BackLighting.arg_number     		= 2030                      
BackLighting.input          		= {-1,1}                     
BackLighting.output         		= {-1,1}                     
BackLighting.parameter_name			= "BACK_LIGHTS"

IndicatorLighting	            	= CreateGauge("parameter")  
IndicatorLighting.arg_number     	= 2031                      
IndicatorLighting.input          	= {-1,1}                     
IndicatorLighting.output         	= {-1,1}                     
IndicatorLighting.parameter_name	= "INDICATOR_LIGHTS"

APUStartLight	            		= CreateGauge("parameter")
APUStartLight.arg_number     		= 1076
APUStartLight.input          		= {0,1}
APUStartLight.output         		= {0,1}
APUStartLight.parameter_name		= "APU_START_LIGHT"

APURunningLight	            		= CreateGauge("parameter")
APURunningLight.arg_number     		= 1077
APURunningLight.input          		= {-1,1}
APURunningLight.output         		= {-1,1}
APURunningLight.parameter_name		= "APU_RUNNING_LIGHT"
-------------------------------------------------------
--HOTAS
-------------------------------------------------------
Throttle							= CreateGauge()
Throttle.arg_number					= 1071
Throttle.input						= {0, 1}
Throttle.output						= {0, 1}
Throttle.controller					= controllers.base_gauge_ThrottleLeftPosition

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

RUDDER_PEDAL                 		= CreateGauge("parameter")
RUDDER_PEDAL.arg_number            	= 1235
RUDDER_PEDAL.input                 	= {-1, 1}
RUDDER_PEDAL.output                	= {-1, 1}
RUDDER_PEDAL.parameter_name        	= "RUDDER_PEDAL_ANIM"
-------------------------------------------------------
--Ejection Seat
-------------------------------------------------------


-------------------------------------------------------
--Others
-------------------------------------------------------
PilotDraw                           = CreateGauge()
PilotDraw.arg_number    	        = 3100
PilotDraw.input				        = { 0, 1}
PilotDraw.output			        = {-1, 1}
PilotDraw.controller		        = controllers.pilot_draw

CanopyLight	                 		= CreateGauge("parameter")
CanopyLight.arg_number      		= 251
CanopyLight.input           		= {0,1}
CanopyLight.output          		= {0,1}
CanopyLight.parameter_name			= "CANOPY_LIGHT"
-------------------------------------------------------
--Cockpit Center JAS39
-------------------------------------------------------
--cockpit_local_point         = {4.275,0.70,0.000}
-------------------------------------------------------
-- Mirror (for FC3 version only)
------------------------------------------------------- 
mirrors_data = {
    center_point          = {0,0,0}, -- XYZ
    width                 = 1, --integrated (keep in mind that mirrors can be none planar )
    aspect                = 1,
    rotation              = math.rad(0);
    animation_speed       = 10;
    near_clip             = 0.1;
    middle_clip           = 40;
    far_clip              = 60000;
}	

local Stupidgreenlamps = {2003,2009,2017,2025,2037,2038,2039,2040,2041,2042,2043,2044,2045,2046,2047,2048,2049,2080,2081,2082,2083,2084,2085,2086,2087,2088,2089,3020}

for i = 1, 30 do
    GreenLamp                 		= CreateGauge("parameter")
    GreenLamp.arg_number            	= Stupidgreenlamps[i]
    GreenLamp.input                 	= {-1, 0}
    GreenLamp.output                	= {-1, 0}
    GreenLamp.parameter_name        	= "littlegreendots" -- Not sure why MAINPOWER does not update the lights at spawn but this does...
end

need_to_be_closed = true