dofile(LockOn_Options.script_path.."args_def.lua")

--------------------------------------------------------------------------------
-- Variables
--------------------------------------------------------------------------------
shape_name = "JF-17-CPT"

is_EDM           = true
new_model_format = true


ambient =
{
    lighttype = "ambient"
}
--[[
ambient_light               = {255,255,255}
ambient_color_day_texture   = {255, 0, 0}
ambient_color_night_texture = {40, 60 ,150}
ambient_color_from_devices  = {50, 50, 40}
ambient_color_from_panels   = {35, 25, 25}
]]

dusk_border                 = 0.4

draw_pilot                  = true
external_model_canopy_arg   = 38

use_external_views          = false
cockpit_local_point         = {4.151,0.742,0.000}

day_texture_set_value       = 0.0
night_texture_set_value     = 0.1

livery = "default"

--------------------------------------------------------------------------------
-- Mirror
--------------------------------------------------------------------------------
mirrors_data = 
{
    center_point      = {0.3,0.0,0.0},  --{ 0.423, 0.115, 0.00 }, difference from cockpit_local_point {3.715, 0.29, 0.0},
    width             = math.rad(70), --0.265, --integrated (keep in mind that mirrors can be none planar )
    aspect            = 1.0,
    rotation          = math.rad(20);
    animation_speed   = 2.0;
    --near_clip         = 0.1;
    --middle_clip       = 10;
    --far_clip          = 60000;    
    arg_value_when_on = 1.0;
}


--------------------------------------------------------------------------------
-- Controllers
--------------------------------------------------------------------------------
controllers = LoRegisterPanelControls()

backup_mag_hdg            = CreateGauge()
backup_mag_hdg.arg_number = cpt_args.MAG_HDG_BACKUP
backup_mag_hdg.input      = {0,2*math.pi}
backup_mag_hdg.output     = {0,1}
backup_mag_hdg.controller = controllers.base_gauge_MagneticHeading

--[[
StickPitch              = CreateGauge()
StickPitch.arg_number   = cpt_args.STICK_MOVE_PITCH
StickPitch.input        = {-1, 1}
StickPitch.output       = {1, -1}
StickPitch.controller   = controllers.base_gauge_StickPitchPosition

StickRoll               = CreateGauge()
StickRoll.arg_number    = cpt_args.STICK_MOVE_BANK
StickRoll.input         = {-1, 1}
StickRoll.output        = {-1, 1}
StickRoll.controller    = controllers.base_gauge_StickRollPosition
]]

function create_mirror(arg_) 
    local _mirrors_draw         = CreateGauge()
    _mirrors_draw.arg_number    = arg_
    _mirrors_draw.input         = {0,1}
    _mirrors_draw.output        = {1,0}
    _mirrors_draw.controller    = controllers.mirrors_draw
    return _mirrors_draw
end
create_mirror(cpt_args.MIRROR_RIGHT)
create_mirror(cpt_args.MIRROR_CENTER)
create_mirror(cpt_args.MIRROR_LEFT)


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

Z_test =
{
    near = 0.05,
    far  = 4.0,
}

dofile(LockOn_Options.common_script_path.."tools.lua")
livery = find_custom_livery("JF-17","default")

need_to_be_closed = true -- close lua state after initialization

