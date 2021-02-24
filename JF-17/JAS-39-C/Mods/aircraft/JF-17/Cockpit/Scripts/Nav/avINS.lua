dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."damage_list.lua")

local gettext = require("i_18n")
_ = gettext.translate

-- debugGUI = true

dtime = 1.0 / 32
drift_per_hour = 0	--0.005 -- degree

overheat_time = 600.0
cooldown_time = 30.0

-- damage
INS_FAILURE_GYRO = 0
INS_FAILURE_ACC = 1

-- 以下为状态, 不受 Element 影响
INS_FAILURE_DATA_INVALID = 2
--INS_GPS_NAV_MODE_ACTIVE = 3
INS_FAILURE_ALGNMENT = 3
INS_FAILURE_ALT_INVALID = 4
INS_DATA_DEGRADED = 5
INS_WIND_INVALID = 6
INS_FAILURE_GPS_RECEIVER = 7
INS_PU_REJECTED  = 8

Damage = {
    {
        Failure = INS_FAILURE_GYRO, Failure_name = "INS_FAILURE_GYRO", Failure_editor_name = _("INS_FAILURE_GYRO"),
        Element = damage_cells["CABIN_RIGHT_SIDE"], Integrity_Treshold = 0.4, Slope_param = 1.0, work_time_to_fail_probability = 0.01, work_time_to_fail = 3600*300,
    },
    {
        Failure = INS_FAILURE_ACC, Failure_name = "INS_FAILURE_ACC", Failure_editor_name = _("INS_FAILURE_ACC"),
        Element = damage_cells["CABIN_RIGHT_SIDE"], Integrity_Treshold = 0.4, Slope_param = 1.0, work_time_to_fail_probability = 0.01, work_time_to_fail = 3600*300,
    },
    {
        Failure = INS_FAILURE_DATA_INVALID, Failure_name = "INS_FAILURE_DATA_INVALID", Failure_editor_name = _("INS_FAILURE_DATA_INVALID"),
        Element = 1000, Integrity_Treshold = 0.4, Slope_param = 1.0, work_time_to_fail_probability = 0.01, work_time_to_fail = 3600*300,
    },
    --[[{
        Failure = INS_GPS_NAV_MODE_ACTIVE, Failure_name = "INS_GPS_NAV_MODE_ACTIVE", Failure_editor_name = _("INS_GPS_NAV_MODE_ACTIVE"),
        Element = 1000, Integrity_Treshold = 0.4, Slope_param = 1.0, work_time_to_fail_probability = 0.01, work_time_to_fail = 3600*300,
    },]]
    {
        Failure = INS_FAILURE_ALGNMENT, Failure_name = "INS_FAILURE_ALGNMENT", Failure_editor_name = _("INS_FAILURE_ALGNMENT"),
        Element = 1000, Integrity_Treshold = 0.4, Slope_param = 1.0, work_time_to_fail_probability = 0.01, work_time_to_fail = 3600*300,
    },
    {
        Failure = INS_FAILURE_ALT_INVALID, Failure_name = "INS_FAILURE_ALT_INVALID", Failure_editor_name = _("INS_FAILURE_ALT_INVALID"),
        Element = 1000, Integrity_Treshold = 0.4, Slope_param = 1.0, work_time_to_fail_probability = 0.01, work_time_to_fail = 3600*300,
    },
    {
        Failure = INS_DATA_DEGRADED, Failure_name = "INS_DATA_DEGRADED", Failure_editor_name = _("INS_DATA_DEGRADED"),
        Element = 1000, Integrity_Treshold = 0.4, Slope_param = 1.0, work_time_to_fail_probability = 0.01, work_time_to_fail = 3600*300,
    },
    {
        Failure = INS_WIND_INVALID, Failure_name = "INS_WIND_INVALID", Failure_editor_name = _("INS_WIND_INVALID"),
        Element = 1000, Integrity_Treshold = 0.4, Slope_param = 1.0, work_time_to_fail_probability = 0.01, work_time_to_fail = 3600*300,
    },
    {
        Failure = INS_FAILURE_GPS_RECEIVER, Failure_name = "INS_FAILURE_GPS_RECEIVER", Failure_editor_name = _("INS_FAILURE_GPS_RECEIVER"),
        Element = 1000, Integrity_Treshold = 0.4, Slope_param = 1.0, work_time_to_fail_probability = 0.01, work_time_to_fail = 3600*300,
    },
    {
        Failure = INS_PU_REJECTED, Failure_name = "INS_PU_REJECTED", Failure_editor_name = _("INS_PU_REJECTED"),
        Element = 1000, Integrity_Treshold = 0.4, Slope_param = 1.0, work_time_to_fail_probability = 0.01, work_time_to_fail = 3600*300,
    },
}

need_to_be_closed = true
