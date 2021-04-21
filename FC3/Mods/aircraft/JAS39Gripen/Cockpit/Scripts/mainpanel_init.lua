shape_name   	   = "Cockpit_Eurofighter"
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

use_external_views = false

day_texture_set_value   = 0.0
night_texture_set_value = 0.1

--初始化座舱动画
local controllers = LoRegisterPanelControls()

StickPitch							= CreateGauge()
StickPitch.arg_number				= 74
StickPitch.input					= {-100, 100}
StickPitch.output					= {-1, 1}
StickPitch.controller				= controllers.base_gauge_StickPitchPosition

StickBank							= CreateGauge()
StickBank.arg_number				= 71
StickBank.input						= {-100, 100}
StickBank.output					= {-1, 1}
StickBank.controller				= controllers.base_gauge_StickRollPosition

RudderPedals						= CreateGauge()
RudderPedals.arg_number				= 500
RudderPedals.input					= {-100,100}
RudderPedals.output					= {-1,1}
RudderPedals.controller				= controllers.base_gauge_RudderPosition

Throttle							= CreateGauge()
Throttle.arg_number					= 105
Throttle.input						= {0, 100}
Throttle.output						= {0, 1}
Throttle.controller					= controllers.base_gauge_ThrottleLeftPosition

Battery_click					    = CreateGauge("parameter")
Battery_click.arg_number		    = 700
Battery_click.input				    = {0, 1}
Battery_click.output			    = {0, 1}
Battery_click.parameter_name	    = "BATTERY" 

canopy_click					    = CreateGauge("parameter")
canopy_click.arg_number		           = 701
canopy_click.input				    = {0, 1}
canopy_click.output			        = {0, 1}
canopy_click.parameter_name	        = "CANOPY" 

fuel_cover_click					    = CreateGauge("parameter")
fuel_cover_click.arg_number		        = 750
fuel_cover_click.input				    = {0, 1}
fuel_cover_click.output			        = {0, 1}
fuel_cover_click.parameter_name	        = "FUELCOVER" 

fuel_probe_click					    = CreateGauge("parameter")
fuel_probe_click.arg_number		        = 751
fuel_probe_click.input				    = {0, 1}
fuel_probe_click.output			        = {0, 1}
fuel_probe_click.parameter_name	        = "FUELPROBE" 

hook_click					            = CreateGauge("parameter")
hook_click.arg_number		            = 707
hook_click.input				            = {0, 1}
hook_click.output			            = {0, 1}
hook_click.parameter_name	            = "HOOK"

-- reng_cover_click					    = CreateGauge("parameter")
-- reng_cover_click.arg_number		        = 704
-- reng_cover_click.input				    = {0, 1}
-- reng_cover_click.output			        = {0, 1}
-- reng_cover_click.parameter_name	        = "ENGINE_R_COVER" 

-- reng_crank_click					    = CreateGauge("parameter")
-- reng_crank_click.arg_number		        = 705
-- reng_crank_click.input				    = {0, 1}
-- reng_crank_click.output			        = {0, 1}
-- reng_crank_click.parameter_name	        = "ENGINE_R_CRANK" 

-- leng_crank_click					    = CreateGauge("parameter")
-- leng_crank_click.arg_number		        = 698
-- leng_crank_click.input				    = {0, 1}
-- leng_crank_click.output			        = {0, 1}
-- leng_crank_click.parameter_name	        = "ENGINE_L_CRANK" 


-- GenLeftSwitch					    = CreateGauge("parameter")
-- GenLeftSwitch.arg_number		    = 702
-- GenLeftSwitch.input				    = {0, 1}
-- GenLeftSwitch.output			    = {0, 1}
-- GenLeftSwitch.parameter_name	    = "GenLeftSwitch"

-- GenRightSwitch					    = CreateGauge("parameter")
-- GenRightSwitch.arg_number		    = 703
-- GenRightSwitch.input				= {0, 1}
-- GenRightSwitch.output			    = {0, 1}
-- GenRightSwitch.parameter_name	    = "GenRightSwitch"

-- EngineSwitch					    = CreateGauge("parameter")
-- EngineSwitch.arg_number		        = 123
-- EngineSwitch.input				    = {0, 1}
-- EngineSwitch.output			        = {-1, 1}
-- EngineSwitch.parameter_name	        = "EngineSwitch"

mirrors_data = {
    center_point          = {0.0,0.0,0}, 
    width                 = 0.8, --integrated (keep in mind that mirrors can be none planar )
    aspect                = 5.0,
    rotation              = math.rad(-4);
    animation_speed       = 4.0;
    near_clip             = 0.1;
    middle_clip           = 40;
    far_clip              = 60000;
    flaps                 = 
    {
        "PNT_MIRROR_CTR",
        "PNT_L_MIRROR",
        "PNT_R_MIRROR",
    }
}
mirrors_draw                        = CreateGauge()
mirrors_draw.arg_number                = 1000
mirrors_draw.input                   = {0,1}
mirrors_draw.output                   = {1,0}
mirrors_draw.controller             = controllers.mirrors_draw
--need_to_be_closed = true
-- need_to_be_closed = false