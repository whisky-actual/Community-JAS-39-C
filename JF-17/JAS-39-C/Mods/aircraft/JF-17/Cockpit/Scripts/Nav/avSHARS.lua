dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."damage_list.lua")

local gettext = require("i_18n")
_ = gettext.translate

-- debugGUI = true

dtime = 1.0 / 32
drift_per_hour = 0		--0.015 -- degree

-- damage
SHARS_FAILURE_SENSOR = 0

Damage = {
    {
        Failure = SHARS_FAILURE_SENSOR, Failure_name = "SHARS_FAILURE_SENSOR", Failure_editor_name = _("SHARS_FAILURE_SENSOR"),
        Element = damage_cells["NOSE_RIGHT_SIDE"], Integrity_Treshold = 0.4, Slope_param = 1.0, work_time_to_fail_probability = 0.01, work_time_to_fail = 3600*300,
    },
}

need_to_be_closed = true
