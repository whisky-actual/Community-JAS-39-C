local res = external_profile("Config/Input/Aircrafts/base_keyboard_binding.lua")
join(res.keyCommands,{

{combos = {{key = '=', reformers = {'RShift'}}}, pressed = iCommandAltimeterPressureIncrease,	up = iCommandAltimeterPressureStop, name = _('Altimeter Pressure Increase'), category = _('Systems')},
{combos = {{key = '-', reformers = {'RShift'}}}, pressed = iCommandAltimeterPressureDecrease, up = iCommandAltimeterPressureStop, name = _('Altimeter Pressure Decrease'), category = _('Systems')},

-- Autopilot
{combos = {{key = 'A'}}, down = iCommandPlaneAutopilot, name = _('Autopilot'), category = _('Autopilot')},
{combos = {{key = 'H'}}, down = iCommandPlaneSAUHBarometric, name = _('Autopilot - Barometric Altitude Hold \'H\''), category = _('Autopilot')},
{combos = {{key = '1', reformers = {'LAlt'}}}, down = iCommandPlaneStabTangBank, name = _('Autopilot - Attitude Hold'), category = _('Autopilot')},
{combos = {{key = '2', reformers = {'LAlt'}}}, down = iCommandPlaneStabHbarBank, name = _('Autopilot - Altitude And Roll Hold'), category = _('Autopilot')},
{combos = {{key = '3', reformers = {'LAlt'}}}, down = iCommandPlaneStabHorizon,	name = _('Autopilot - Transition To Level Flight Control'), category = _('Autopilot')},
{combos = {{key = '4', reformers = {'LAlt'}}}, down = iCommandPlaneStabHbar, name = _('Autopilot - Barometric Altitude Hold'), category = _('Autopilot')},
{combos = {{key = '5', reformers = {'LAlt'}}}, down = iCommandPlaneStabHrad, name = _('Autopilot - Radar Altitude Hold'), category = _('Autopilot')},
{combos = {{key = '6', reformers = {'LAlt'}}}, down = iCommandPlaneRouteAutopilot, name = _('Autopilot - \'Route following\''), category = _('Autopilot')},
{combos = {{key = '9', reformers = {'LAlt'}}}, down = iCommandPlaneStabCancel, name = _('Autopilot Reset'), category = _('Autopilot')},
{combos = {{key = 'A', reformers = {'LShift'}}}, down = iCommandPlaneAutopilotOverrideOn, up = iCommandPlaneAutopilotOverrideOff, name = _('Autopilot override'), category = _('Autopilot')},

-- Modes
{combos = {{key = '2'}}, down = iCommandPlaneModeBVR, name = _('(2) Beyond Visual Range Mode'), category = _('Modes')},
{combos = {{key = '3'}}, down = iCommandPlaneModeVS, name = _('(3) Close Air Combat Vertical Scan Mode'), category = _('Modes')},
{combos = {{key = '4'}}, down = iCommandPlaneModeBore, name = _('(4) Close Air Combat Bore Mode'), category = _('Modes')},
{combos = {{key = '5'}}, down = iCommandPlaneModeHelmet, name = _('(5) Close Air Combat HMD Helmet Mode'), category = _('Modes')},
{combos = {{key = '6'}}, down = iCommandPlaneModeFI0, name = _('(6) Longitudinal Missile Aiming Mode'), category = _('Modes')},
{combos = {{key = '7'}}, down = iCommandPlaneModeGround, name = _('(7) Air-To-Ground Mode'), category = _('Modes')},
{combos = {{key = '8'}}, down = iCommandPlaneModeGrid, name = _('(8) Gunsight Reticle Switch'), category = _('Modes')},

-- Flight Control
{combos = {{key = 'T', reformers = {'LCtrl'}}}, down = iCommandPlaneTrimCancel, name = _('Trim Reset'), category = _('Flight Control')},
--{combos = {{key = 'S'}}, down = iCommandPlaneCobra, up = iCommandPlaneCobra, value_down = 1.0, value_up = 0.0, name = _('ASC Direct Control (Cobra)'), category = _('Flight Control')},
--{combos = {{key = 'S'}}, down = iCommandPlaneCobra, name = _('ASC Direct Control (Cobra)'), category = _('Flight Control')},
{down = iCommandPlaneTrimOn, up = iCommandPlaneTrimOff, name = _('Stick to trimmer control mode'), category = _('Flight Control')},

{combos = {{key = 'Y'}}, down = iCommandPlane_HOTAS_LeftThrottleButton, up = iCommandPlane_HOTAS_LeftThrottleButton_Off, name = _('Stick Deflection Limiter Override'), category = _('Flight Control')},

-- Systems
--{combos = {{key = 'Q', reformers = {'LAlt'}}}, down = iCommandPlane_HOTAS_NoseWheelSteeringButton, name = _('Nose Wheel Steering'), category = _('Systems')},
{combos = {{key = 'A', reformers = {'LCtrl'}}}, down = iCommandPlaneWheelBrakeLeftOn, up = iCommandPlaneWheelBrakeLeftOff, name = _('Wheel Brake Left On/Off'), category = _('Systems')},
{combos = {{key = 'A', reformers = {'LAlt'}}}, down = iCommandPlaneWheelBrakeRightOn, up = iCommandPlaneWheelBrakeRightOff, name = _('Wheel Brake Right On/Off'), category = _('Systems')},
{combos = {{key = 'W', reformers = {'LShift'}}}, down = iCommandPlaneWheelParkingBrake, up = iCommandPlaneWheelParkingBrake, name = _('Wheel Brake Start'), category = _('Systems')},
{combos = {{key = 'I', reformers = {'LAlt'}}}, down = iCommandPlane_HOTAS_ChinaHatForward, name = _('Engine Inlet Grids Auto/Off'), category = _('Systems')},
{combos = {{key = 'H', reformers = {'RShift'}}}, down = iCommandPlaneHUDFilterOnOff, name = _('HUD Color Filter On/Off'), category = _('Systems')},
{down = iCommandPlaneRightMFD_OSB1 , name = _('HDD, HUD Repeater Mode On/Off'), category = _('Systems')},

-- Systems F15
{combos = {{key = 'S'}}, down = iCommandPlane_HOTAS_NoseWheelSteeringButton, up = iCommandPlane_HOTAS_NoseWheelSteeringButton, name = _('Nose Gear Maneuvering Range'), category = _('Systems')},
{combos = {{key = 'Q', reformers = {'LAlt'}}}, down = iCommandPlane_HOTAS_NoseWheelSteeringButtonOff, up = iCommandPlane_HOTAS_NoseWheelSteeringButtonOff, name = _('Nose Wheel Steering'), category = _('Systems')},
-- Systems Su33
{combos = {{key = 'R', reformers = {'LCtrl'}}}, down = iCommandPlaneAirRefuel, name = _('Refueling Boom'), category = _('Systems')},
{combos = {{key = 'G', reformers = {'LAlt'}}}, down = iCommandPlaneHook, name = _('Tail Hook'), category = _('Systems')},
{combos = {{key = 'P', reformers = {'RCtrl'}}}, down = iCommandPlanePackWing, name = _('Folding Wings'), category = _('Systems')},

-- Sensors
{combos = {{key = 'Enter'}}, down = iCommandPlaneChangeLock, up = iCommandPlaneChangeLockUp, name = _('Target Lock'), category = _('Sensors')},
{combos = {{key = 'Back'}}, down = iCommandSensorReset, name = _('Return To Search'), category = _('Sensors')},
{combos = {{key = 'I'}}, down = iCommandPlaneRadarOnOff, name = _('Radar On/Off'), category = _('Sensors')},
{combos = {{key = 'I', reformers = {'RAlt'}}}, down = iCommandPlaneRadarChangeMode, name = _('Radar RWS/TWS Mode Select'), category = _('Sensors')},
{combos = {{key = 'I', reformers = {'RCtrl'}}}, down = iCommandPlaneRadarCenter, name = _('Target Designator To Center'), category = _('Sensors')},
{combos = {{key = 'I', reformers = {'RShift'}}}, down = iCommandPlaneChangeRadarPRF, name = _('Radar Pulse Repeat Frequency Select'), category = _('Sensors')},
{combos = {{key = 'O'}}, down = iCommandPlaneEOSOnOff, name = _('Electro-Optical System On/Off'), category = _('Sensors')},
{combos = {{key = ';'}}, pressed = iCommandPlaneRadarUp, up = iCommandPlaneRadarStop, name = _('Target Designator Up'), category = _('Sensors')},
{combos = {{key = '.'}}, pressed = iCommandPlaneRadarDown, up = iCommandPlaneRadarStop, name = _('Target Designator Down'), category = _('Sensors')},
{combos = {{key = ','}}, pressed = iCommandPlaneRadarLeft, up = iCommandPlaneRadarStop, name = _('Target Designator Left'), category = _('Sensors')},
{combos = {{key = '/'}}, pressed = iCommandPlaneRadarRight, up = iCommandPlaneRadarStop, name = _('Target Designator Right'), category = _('Sensors')},
{combos = {{key = ';', reformers = {'RShift'}}}, pressed = iCommandSelecterUp, up = iCommandSelecterStop, name = _('Scan Zone Up'), category = _('Sensors')},
{combos = {{key = '.', reformers = {'RShift'}}}, pressed = iCommandSelecterDown, up = iCommandSelecterStop, name = _('Scan Zone Down'), category = _('Sensors')},
{combos = {{key = ',', reformers = {'RShift'}}}, pressed = iCommandSelecterLeft, up = iCommandSelecterStop, name = _('Scan Zone Left'), category = _('Sensors')},
{combos = {{key = '/', reformers = {'RShift'}}}, pressed = iCommandSelecterRight, up = iCommandSelecterStop, name = _('Scan Zone Right'), category = _('Sensors')},
{combos = {{key = '='}}, down = iCommandPlaneZoomIn, name = _('Display Zoom In'), category = _('Sensors')},
{combos = {{key = '-'}}, down = iCommandPlaneZoomOut, name = _('Display Zoom Out'), category = _('Sensors')},
{combos = {{key = '-', reformers = {'RCtrl'}}}, down = iCommandDecreaseRadarScanArea, name = _('Radar Scan Zone Decrease'), category = _('Sensors')},
{combos = {{key = '=', reformers = {'RCtrl'}}}, down = iCommandIncreaseRadarScanArea, name = _('Radar Scan Zone Increase'), category = _('Sensors')},
{combos = {{key = '=', reformers = {'RAlt'}}}, pressed = iCommandPlaneIncreaseBase_Distance, up = iCommandPlaneStopBase_Distance, name = _('Target Specified Size Increase'), category = _('Sensors')},
{combos = {{key = '-', reformers = {'RAlt'}}}, pressed = iCommandPlaneDecreaseBase_Distance, up = iCommandPlaneStopBase_Distance, name = _('Target Specified Size Decrease'), category = _('Sensors')},
{combos = {{key = 'R', reformers = {'RShift'}}}, down = iCommandChangeRWRMode, name = _('RWR/SPO Mode Select'), category = _('Sensors')},
{combos = {{key = ',', reformers = {'RAlt'}}}, down = iCommandPlaneThreatWarnSoundVolumeDown, name = _('RWR/SPO Sound Signals Volume Down'), category = _('Sensors')},
{combos = {{key = '.', reformers = {'RAlt'}}}, down = iCommandPlaneThreatWarnSoundVolumeUp, name = _('RWR/SPO Sound Signals Volume Up'), category = _('Sensors')},

-- Weapons                                                                        
{combos = {{key = 'V', reformers = {'LCtrl'}}}, down = iCommandPlaneSalvoOnOff, name = _('Salvo Mode'), category = _('Weapons')},
{combos = {{key = 'C', reformers = {'LShift'}}}, down = iCommandChangeGunRateOfFire, name = _('Cut Of Burst select'), category = _('Weapons')},


})
return res
