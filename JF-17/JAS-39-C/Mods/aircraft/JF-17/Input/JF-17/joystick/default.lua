local inputpath = folder.."../../../Input/JF-17/"
local cscripts = folder.."../../../Cockpit/Scripts/"
dofile(cscripts.."command_defs.lua")
dofile(cscripts.."devices.lua")

local res = external_profile("Config/Input/Aircrafts/common_joystick_binding.lua")

local arcade_binding = external_profile(inputpath.."thunder_arcade_binding_joystick.lua")
join(res.keyCommands, arcade_binding.keyCommands)

local click_binding = external_profile(inputpath.."thunder_click_binding.lua")
join(res.keyCommands, click_binding.keyCommands)

join(res.keyCommands,{

-- 拉烟
{down = iCommandPlaneWingtipSmokeOnOff, name = _('Smoke'), category = _('Systems')},

-- Modes
-- T1: MMS
{down = key_cmds.HOTAS_Throttle_T1_Center,          name = _(cmd_names.HOTAS_Throttle_T1_Center),          category = _('HOTAS')},
{down = key_cmds.HOTAS_Throttle_T1_Forward,         name = _(cmd_names.HOTAS_Throttle_T1_Forward),         category = _('HOTAS')},
{down = key_cmds.HOTAS_Throttle_T1_Backward,        name = _(cmd_names.HOTAS_Throttle_T1_Backward),        category = _('HOTAS')},
{down = key_cmds.HOTAS_Throttle_T1_MMS_Cycle_Next,  name = _(cmd_names.HOTAS_Throttle_T1_MMS_Cycle_Next),  category = _('HOTAS')},
{down = key_cmds.HOTAS_Throttle_T1_MMS_Cycle_Prev,  name = _(cmd_names.HOTAS_Throttle_T1_MMS_Cycle_Prev),  category = _('HOTAS')},

-- T2: radio
{down = key_cmds.HOTAS_Throttle_T2_Forward,      name = _(cmd_names.HOTAS_Throttle_T2_Forward),   category = _('HOTAS')},
{down = key_cmds.HOTAS_Throttle_T2_Backward,     name = _(cmd_names.HOTAS_Throttle_T2_Backward),  category = _('HOTAS')},
{down = key_cmds.HOTAS_Throttle_T2_Press,        name = _(cmd_names.HOTAS_Throttle_T2_Press),     category = _('HOTAS')},

-- T3: air brake
{   down = key_cmds.AirBrake,    name = _(cmd_names.HOTAS_Throttle_T3_Down),      cockpit_device_id = devices.FCS, category = _('HOTAS')},
{pressed = key_cmds.AirBrakeOn,  name = _(cmd_names.HOTAS_Throttle_T3_Forward),   cockpit_device_id = devices.FCS, category = _('HOTAS')},
{pressed = key_cmds.AirBrakeOff, name = _(cmd_names.HOTAS_Throttle_T3_Backward),  cockpit_device_id = devices.FCS, category = _('HOTAS')},

-- T4: PTT
{down = key_cmds.HOTAS_Throttle_T4_Forward,      name = _(cmd_names.HOTAS_Throttle_T4_Forward),   cockpit_device_id = devices.INTERCOM,  category = {_('Radio'), _('HOTAS')}},
{down = key_cmds.HOTAS_Throttle_T4_Backward,     name = _(cmd_names.HOTAS_Throttle_T4_Backward),  cockpit_device_id = devices.INTERCOM,  category = {_('Radio'), _('HOTAS')}},
{down = key_cmds.HOTAS_Throttle_T4_Press, up = key_cmds.HOTAS_Throttle_T4_Press, value_down = 1.0, value_up = 0.0,  name = _(cmd_names.HOTAS_Throttle_T4_Press),  category = {_('IFF'), _('HOTAS')}},

-- T5: TDC
{   down = key_cmds.HOTAS_Throttle_T5_Press,    name = _(cmd_names.HOTAS_Throttle_T5_Press),    category = _('HOTAS')},
--{pressed = key_cmds.HOTAS_Throttle_T5_Up,       name = _(cmd_names.HOTAS_Throttle_T5_Up),       category = _('HOTAS')},
--{pressed = key_cmds.HOTAS_Throttle_T5_Down,     name = _(cmd_names.HOTAS_Throttle_T5_Down),     category = _('HOTAS')},
--{pressed = key_cmds.HOTAS_Throttle_T5_Left,     name = _(cmd_names.HOTAS_Throttle_T5_Left),     category = _('HOTAS')},
--{pressed = key_cmds.HOTAS_Throttle_T5_Right,    name = _(cmd_names.HOTAS_Throttle_T5_Right),    category = _('HOTAS')},

{pressed = key_cmds.HOTAS_Throttle_T5_Up,    up = key_cmds.HOTAS_Throttle_T5_UD_Stop,   name = _(cmd_names.HOTAS_Throttle_T5_Up),       category = _('HOTAS')},
{pressed = key_cmds.HOTAS_Throttle_T5_Down,  up = key_cmds.HOTAS_Throttle_T5_UD_Stop,   name = _(cmd_names.HOTAS_Throttle_T5_Down),     category = _('HOTAS')},
{pressed = key_cmds.HOTAS_Throttle_T5_Left,  up = key_cmds.HOTAS_Throttle_T5_LR_Stop,   name = _(cmd_names.HOTAS_Throttle_T5_Left),     category = _('HOTAS')},
{pressed = key_cmds.HOTAS_Throttle_T5_Right, up = key_cmds.HOTAS_Throttle_T5_LR_Stop,   name = _(cmd_names.HOTAS_Throttle_T5_Right),    category = _('HOTAS')},
        
-- S1: SS (sensor select)
{down = key_cmds.HOTAS_Stick_S1_Forward,     name = _(cmd_names.HOTAS_Stick_S1_Forward),     category = _('HOTAS')},
{down = key_cmds.HOTAS_Stick_S1_Backward,    name = _(cmd_names.HOTAS_Stick_S1_Backward),    category = _('HOTAS')},
{down = key_cmds.HOTAS_Stick_S1_Left,        name = _(cmd_names.HOTAS_Stick_S1_Left),        category = _('HOTAS')},
{down = key_cmds.HOTAS_Stick_S1_Right,       name = _(cmd_names.HOTAS_Stick_S1_Right),       category = _('HOTAS')},
{down = key_cmds.HOTAS_Stick_S1_Press,       name = _(cmd_names.HOTAS_Stick_S1_Press),       category = _('HOTAS')},

-- S2: SC senser control
{down = key_cmds.HOTAS_Stick_S2_Forward,     name = _(cmd_names.HOTAS_Stick_S2_Forward),   category = _('HOTAS')},
{down = key_cmds.HOTAS_Stick_S2_Backward,    name = _(cmd_names.HOTAS_Stick_S2_Backward),  category = _('HOTAS')},
{down = key_cmds.HOTAS_Stick_S2_Left,        name = _(cmd_names.HOTAS_Stick_S2_Left),      category = _('HOTAS')},
{down = key_cmds.HOTAS_Stick_S2_Right,       name = _(cmd_names.HOTAS_Stick_S2_Right),     category = _('HOTAS')},
{down = key_cmds.HOTAS_Stick_S2_Press,       name = _(cmd_names.HOTAS_Stick_S2_Press),     category = _('HOTAS')},

-- S3: Weapon launch
{combos = {{key = 'JOY_BTN2'}},    down = key_cmds.HOTAS_Stick_S3, value_down = 1.0, up = key_cmds.HOTAS_Stick_S3, value_up = 0.0, name = _(cmd_names.HOTAS_Stick_S3),  category = _('HOTAS')},

-- S4: Main Gun Fire
{combos = {{key = 'JOY_BTN1'}},    down = key_cmds.HOTAS_Stick_S4, value_down = 1.0, up = key_cmds.HOTAS_Stick_S4, value_up = 0.0, name = _(cmd_names.HOTAS_Stick_S4),  category = _('HOTAS')},

-- S5: Jettison payload
--{    down = key_cmds.HOTAS_Stick_S5,                name = _('Jettison Payload'),    category = _('HOTAS')},
{                                  down = key_cmds.HOTAS_Stick_S5, value_down = 1.0, up = key_cmds.HOTAS_Stick_S5, value_up = 0.0, name = _(cmd_names.HOTAS_Stick_S5),  category = _('HOTAS')},

-- S6: Trim
{    pressed = key_cmds.HOTAS_Stick_S6_Up,          name = _(cmd_names.HOTAS_Stick_S6_Up),     category = _('HOTAS')},
{    pressed = key_cmds.HOTAS_Stick_S6_Down,        name = _(cmd_names.HOTAS_Stick_S6_Down),   category = _('HOTAS')},
{    pressed = key_cmds.HOTAS_Stick_S6_Left,        name = _(cmd_names.HOTAS_Stick_S6_Left),   category = _('HOTAS')},
{    pressed = key_cmds.HOTAS_Stick_S6_Right,       name = _(cmd_names.HOTAS_Stick_S6_Right),  category = _('HOTAS')},

-- S7: Auto pilot OFF
{    down = key_cmds.HOTAS_Stick_S7,                name = _(cmd_names.HOTAS_Stick_S7),   category = _('HOTAS')},

-- S8: Change weapon
{    down = key_cmds.HOTAS_Stick_S8,                name = _(cmd_names.HOTAS_Stick_S8),   category = _('HOTAS')},

-- Seat Adjustment
{pressed = key_cmds.SeatAdjustment_Up,       cockpit_device_id = devices.MISC,  name = _(cmd_names.SeatAdjustment_Up),    category = {_('Seat')}},
{pressed = key_cmds.SeatAdjustment_Down,     cockpit_device_id = devices.MISC,  name = _(cmd_names.SeatAdjustment_Down),  category = {_('Seat')}},

})


local axis_binding = external_profile(inputpath.."thunder_axis_binding.lua")
join(res.axisCommands, axis_binding.axisCommands)

join(res.axisCommands,{
    {combos = defaultDeviceAssignmentFor("roll")  ,  action = axis_cmd.HOTAS_StickRoll_Abs      , name = _('Roll')},
    {combos = defaultDeviceAssignmentFor("pitch") ,  action = axis_cmd.HOTAS_StickPitch_Abs     , name = _('Pitch')},
    {combos = defaultDeviceAssignmentFor("rudder"),  action = axis_cmd.HOTAS_PedalYaw_Abs       , name = _('Rudder')},
    {combos = defaultDeviceAssignmentFor("thrust"),  action = axis_cmd.HOTAS_Throttle_Abs       , name = _('Thrust')},
    
    {combos = {{key = 'JOY_RX'}},                    action = axis_cmd.HOTAS_Throttle_T6_Abs    , name = _(cmd_names.HOTAS_Throttle_T6)},
    --{combos = {{key = 'JOY_RY'}},                    action = axis_cmd.Sensor_AZ_Axis_Abs       , name = _('Sensor Horizontal Axis')},

    {action = axis_cmd.TDC_X_Abs,        name = _('TDC Slew Horizontal')  },
    {action = axis_cmd.TDC_Y_Abs,        name = _('TDC Slew Vertical')    },

    {action = axis_cmd.WheelBrake_Abs,        name = _('Wheel Brake')},
    {action = axis_cmd.WheelBrakeLeft_Abs,    name = _('Wheel Brake Left')},
    {action = axis_cmd.WheelBrakeRight_Abs,   name = _('Wheel Brake Right')},
    
    {action = iCommandViewHorizontalAbs,      name = _('Absolute Camera Horizontal View')},
    {action = iCommandViewVerticalAbs,        name = _('Absolute Camera Vertical View')},
    {action = iCommandViewZoomAbs,            name = _('Zoom View')},
    {action = iCommandViewRollAbs,            name = _('Absolute Roll Shift Camera View')},
    {action = iCommandViewHorTransAbs,        name = _('Absolute Horizontal Shift Camera View')},
    {action = iCommandViewVertTransAbs,       name = _('Absolute Vertical Shift Camera View')},
    {action = iCommandViewLongitudeTransAbs,  name = _('Absolute Longitude Shift Camera View')},
})


return res
