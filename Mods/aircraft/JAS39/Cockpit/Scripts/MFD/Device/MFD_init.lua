dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")

dev = GetSelf()

update_time_step = 0.02 --update will be called 50 times per second
make_default_activity(update_time_step)

sensor_data = get_base_data()

local pct = get_param_handle("FUEL")
local max_amount = 25.50

local adi_level_enable = get_param_handle("ADI_LINE_GROUP")
local ADI_ROLL = get_param_handle("ADI_ROLL")
local ADI_PITCH = get_param_handle("ADI_PITCH")

local ALT_BARO_T 	  	  	  = get_param_handle("ALT_BARO_T")
local ALT_BARO_H 	  	  	  = get_param_handle("ALT_BARO_H")
local ALT_RDR_T 	  	  	  = get_param_handle("ALT_RDR_T")
local ALT_RDR_H 	  	  	  = get_param_handle("ALT_RDR_H")

local CUR_IAS  = get_param_handle("CUR_IAS")
local CUR_TAS  = get_param_handle("CUR_TAS")
local CUR_MACH = get_param_handle("CUR_MACH") 

local NoseLandingGear 	   = get_param_handle("NoseLandingGear") 
local RightMainLandingGear = get_param_handle("RightMainLandingGear") 
local LeftMainLandingGear  = get_param_handle("LeftMainLandingGear")

local TRUEHEADING 	  = get_param_handle("TRUEHEADING") 
local MAGNATICHEADING = get_param_handle("MAGNATICHEADING") 
local MAGNATICHEADINGCOMPASS = get_param_handle("MAGNATICHEADINGCOMPASS") 

local hdg_param 	= get_param_handle("HDG_PARAM")
local MFD_HDG_PARAM = get_param_handle("MFD_HDG_PARAM")

local RPM_PARAM = get_param_handle("RPM_PARAM")
local RPM_PARAM_H = get_param_handle("RPM_PARAM_H")
local RPM_PARAM_U = get_param_handle("RPM_PARAM_U")
local RPM_PARAM_T = get_param_handle("RPM_PARAM_T")

local TGT_PARAM = get_param_handle("TGT_PARAM")
local TGT_PARAM_H = get_param_handle("TGT_PARAM_H")
local TGT_PARAM_U = get_param_handle("TGT_PARAM_U")
local TGT_PARAM_T = get_param_handle("TGT_PARAM_T")

function post_initialize()
 
	
end

local btnPressed = 0
function SetCommand(command,value)
  
   
end

function update()
    
	pct:set(math.floor(sensor_data.getTotalFuelWeight() / max_amount))
	-- *************************** 
	RPM_PARAM:set(sensor_data.getEngineLeftRPM() - 30)
	RPM_PARAM_H:set(math.floor(sensor_data.getEngineLeftRPM() / 100))
	RPM_PARAM_T:set((sensor_data.getEngineLeftRPM() / 10))
	RPM_PARAM_U:set((sensor_data.getEngineLeftRPM() % 10))	
	-- *************************** 
	TGT_PARAM:set(sensor_data.getEngineLeftTemperatureBeforeTurbine())
	TGT_PARAM_H:set((sensor_data.getEngineLeftTemperatureBeforeTurbine() / 100))
	TGT_PARAM_T:set((sensor_data.getEngineLeftTemperatureBeforeTurbine() % 100) / 10)
	TGT_PARAM_U:set( (sensor_data.getEngineLeftTemperatureBeforeTurbine() % 10))
	-- *************************** 
	ADI_ROLL:set(sensor_data.getRoll())
    ADI_PITCH:set(-sensor_data.getPitch())
	-- *************************** 
	NoseLandingGear:set(get_aircraft_draw_argument_value(0))
	LeftMainLandingGear:set(get_aircraft_draw_argument_value(3))
	RightMainLandingGear:set(get_aircraft_draw_argument_value(5))
	-- ***************************   
	ALT_BARO_T:set(math.floor(sensor_data.getBarometricAltitude() * 3.2808399 / 1000))		-- feet
	ALT_BARO_H:set(math.floor(sensor_data.getBarometricAltitude()* 3.2808399 % 1000))		-- feet
	ALT_RDR_T:set(math.floor(sensor_data.getRadarAltitude() * 3.2808399/ 1000))				-- feet
	ALT_RDR_H:set(math.floor(sensor_data.getRadarAltitude()* 3.2808399 % 1000))				-- feet
 	-- ******************************
	CUR_MACH:set(sensor_data.getMachNumber())
	if CUR_MACH:get() <= 0.1 then 
		CUR_MACH:set(0)
	end
	local ias = sensor_data.getIndicatedAirSpeed() * 1.94384449			 -- m/s to kts
	local iasx, iasy, iasz = sensor_data.getSelfAirspeed()
    if ias == 0 then 
		ias = math.sqrt(iasx * iasx + iasy * iasy + iasz * iasz )   
	elseif (ias > 100) and (ias < 200) then
		ias = ias + (ias -100)
	elseif (ias >= 200) then
		ias = ias + 100
	end
	
	local tSpeed = sensor_data.getTrueAirSpeed() * 1.94384449 			-- m/s to kts
	
	
	CUR_IAS:set(ias)
	CUR_TAS:set(tSpeed)
	-- ***********************
	real_HDG = sensor_data.getHeading()
	local magnetic_HDG = -((math.deg(sensor_data.getHeading()))-360)
	-- HDG
    local hdg = math.deg(-sensor_data.getHeading())
    if hdg < 0 then hdg = 360 + hdg end
    hdg = hdg % 360
	MAGNATICHEADING:set( sensor_data.getMagneticHeading()*(180/math.pi) + 6 )
	-- MAGNATICHEADING:set( magnetic_HDG )
	MAGNATICHEADINGCOMPASS:set( hdg )	
end

print_message_to_user(ias)
function CockpitEvent(command,val)
  
end
 
need_to_be_closed = false -- close lua state after initialization


