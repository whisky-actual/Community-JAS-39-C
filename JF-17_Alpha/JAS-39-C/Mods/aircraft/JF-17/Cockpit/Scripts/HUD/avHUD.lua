dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."damage_list.lua")

local gettext = require("i_18n")
_ = gettext.translate

-- debugGUI = true

tdc_deadzone = get_plugin_option_value("JF-17", "TDC_DEADZONE", "local")
hud_slew_rate = get_plugin_option_value("JF-17", "HUD_RDR_TDC", "local")

dtime = 1.0 / 60

need_to_be_closed = true
