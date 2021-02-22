dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."damage_list.lua")

local gettext = require("i_18n")
_ = gettext.translate

-- debugGUI = true

dtime = 0.2

--GPS modeling
psedoRangeErrorProcessTx = 25.0
SNRProcess = 20.0

--SNS receiver parameters
SAT_SYS_NONE = 0
SAT_SYS_GLONASS = 1
SAT_SYS_GPS = 2
SAT_SYS_BOTH = 3
-- SAT_SYS_BDS = 4

system_mode_available = {}
system_mode_available[SAT_SYS_GPS] = true
system_mode_available[SAT_SYS_BOTH] = true
system_mode_available[SAT_SYS_GLONASS] = true
-- system_mode_available[SAT_SYS_BDS] = true

channel_quantity = 64
use_L2 = true
use_carrier = true
position_latency = 0.07
position_update_dt = 0.1 --PSR measuring rate
status_update_dt = 0.1 --satellites re-acquisition and DOPS calculation rate

antenna_pos = {2.87555, 0.93907, 0.0}
min_elevation = -10.0
terrainLOS = true

Starting_Time = {}
Starting_Time["hot_start_time"] = 90
Starting_Time["warm_start_time"] = 120
Starting_Time["cold_start_time"] = 180

Satellite_re_aquisition_time = {}
Satellite_re_aquisition_time[10] = 3
Satellite_re_aquisition_time[60] = 5

--coords extrapolation
coords_extrapolation_enable = true
coords_extrapolation_dt = 0.1 --coords extrapolation rate

Kalman_filter_enable = true


-- failures
SNS_FAILURE_ANTENNA = 0
SNS_FAILURE_CABLE = 1
SNS_FAILURE_COMPUTER = 2

Damage = {
    {
        Failure = SNS_FAILURE_ANTENNA,  Failure_name = "SNS_FAILURE_ANTENNA",  Failure_editor_name = _("SNS_FAILURE_ANTENNA"),  Element = damage_cells["FUSELAGE_TOP"], work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300
    },
    {
        Failure = SNS_FAILURE_CABLE,    Failure_name = "SNS_FAILURE_CABLE",    Failure_editor_name = _("SNS_FAILURE_CABLE"),    Element = 1000, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300
    },
    {
        Failure = SNS_FAILURE_COMPUTER, Failure_name = "SNS_FAILURE_COMPUTER", Failure_editor_name = _("SNS_FAILURE_COMPUTER"), Element = 1000, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300
    },
}

--
need_to_be_closed = true
