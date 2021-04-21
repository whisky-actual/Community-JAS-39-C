dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."Systems/electric_system.lua")


local dev = GetSelf()

local update_time_step = 0.02
make_default_activity(update_time_step)

local adi_roll = get_param_handle("ADI_ROLL")
local adi_pitch = get_param_handle("ADI_PITCH")
local adi_yaw = get_param_handle("ADI_YAW")
local adi_speed_dis = get_param_handle("ADI_SPEED_DIS")
local adi_alt_dis = get_param_handle("ADI_ALT_DIS")
local adi_hdg_dis = get_param_handle("ADI_HDG_DIS")
local adi_hdg_mov = get_param_handle("ADI_HDG_MOV")
local adi_aoa_dis = get_param_handle("ADI_AOA_DIS")
local adi_hsi_rot = get_param_handle("ADI_HSI_ROT")
local adi_level_enable = get_param_handle("ADI_LINES")
local ADI_DIS_ENABLE = get_param_handle("ADI_DIS_ENABLE")
local BATTERY = get_param_handle("BATTERY")

local sensor_data = get_base_data()
local ias_conversion_to_knots = 1.9504132
local ias_conversion_to_kmh = 3.6
local DEGREE_TO_RAD  = 0.0174532925199433
local RAD_TO_DEGREE  = 57.29577951308233
local METER_TO_FEET = 3.28084

function post_initialize()--Causes error
    adi_FD_x:set(0)
    adi_FD_y:set(0)
    adi_level_enable:set(1)
    adi_enable:set(1)
end

function SetCommand(command,value)

end

function update()
    ADI_DIS_ENABLE:set(PowerOnOff)
    adi_yaw:set(sensor_data.getRateOfYaw())
    adi_roll:set(sensor_data.getRoll())
    adi_pitch:set(sensor_data.getPitch())
    adi_speed_dis:set(sensor_data.getIndicatedAirSpeed() *ias_conversion_to_knots)
    adi_alt_dis:set(sensor_data.getBarometricAltitude() * METER_TO_FEET)
    adi_hdg_dis:set(sensor_data.getMagneticHeading() *RAD_TO_DEGREE)
    adi_aoa_dis:set(sensor_data.getAngleOfAttack() *RAD_TO_DEGREE)
    adi_hsi_rot:set(sensor_data.getHeading())
    local current_aoa = sensor_data.getAngleOfAttack()
    adi_FD_y:set(current_aoa)
end