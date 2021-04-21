dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."Systems/electric_system.lua")

local dev = GetSelf()

local update_time_step = 0.02
make_default_activity(update_time_step)

local BATTERY = get_param_handle("BATTERY")
local ufc_rpm_r = get_param_handle("UFC_RPM_R")
local ufc_rpm_l = get_param_handle("UFC_RPM_L")
local ufc_text_r  = get_param_handle("UFC_TEXT_R")
local ufc_text_l  = get_param_handle("UFC_TEXT_L")
local ufc_fuel  = get_param_handle("UFC_FUEL")

local sensor_data = get_base_data()
local ias_conversion_to_knots = 1.9504132
local ias_conversion_to_kmh = 3.6
local DEGREE_TO_RAD  = 0.0174532925199433
local RAD_TO_DEGREE  = 57.29577951308233
local METER_TO_FEET = 3.28084
local KG_TO_LBS = 2.20462

function post_initialize() --Causes error
    ufc_FD_x:set(0)
    ufc_FD_y:set(0)
    ufc_level_enable:set(1)
    ufc_enable:set(1)
end

function SetCommand(command,value)

end

function update()
    ufc_rpm_r:set(sensor_data.getEngineRightRPM())
    ufc_rpm_l:set(sensor_data.getEngineLeftRPM())
    ufc_text_r:set(sensor_data.getEngineRightRPM())
    ufc_text_l:set(sensor_data.getEngineLeftRPM())
    ufc_fuel:set(sensor_data.getTotalFuelWeight() * 2.20462)
end