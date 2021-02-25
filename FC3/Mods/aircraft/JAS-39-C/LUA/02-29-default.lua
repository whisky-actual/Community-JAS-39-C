local res = external_profile("Config/Input/Aircrafts/base_joystick_binding.lua")
join(res.keyCommands,{

-- Systems
--{down = iCommandPlane_HOTAS_NoseWheelSteeringButton, up = iCommandPlane_HOTAS_NoseWheelSteeringButton, value_down = 1.0, value_up = 0.0, name = _('Nose Wheel Steering'), category = _('Systems')},
{pressed = iCommandAltimeterPressureIncrease,	up = iCommandAltimeterPressureStop, name = _('Altimeter Pressure Increase'), category = _('Systems')},
{pressed = iCommandAltimeterPressureDecrease, up = iCommandAltimeterPressureStop, name = _('Altimeter Pressure Decrease'), category = _('Systems')},
--{down = iCommandPlaneAirRefuel, name = _('Refueling Boom'), category = _('Systems')},
{down = iCommandPlaneJettisonFuelTanks, name = _('Jettison Fuel Tanks'), category = _('Systems')},
{down = iCommandPlaneWheelParkingBrake, up = iCommandPlaneWheelParkingBrake, name = _('Wheel Brake Start'), category = _('Systems')},

-- Systems F15
{down = iCommandPlane_HOTAS_NoseWheelSteeringButton, up = iCommandPlane_HOTAS_NoseWheelSteeringButton, name = _('Nose Gear Maneuvering Range'), category = _('Systems')},
{down = iCommandPlane_HOTAS_NoseWheelSteeringButtonOff, up = iCommandPlane_HOTAS_NoseWheelSteeringButtonOff, name = _('Nose Wheel Steering'), category = _('Systems')},
-- Systems Su33
{down = iCommandPlaneAirRefuel, name = _('Refueling Boom'), category = _('Systems')},
{down = iCommandPlaneHook, name = _('Tail Hook'), category = _('Systems')},
{down = iCommandPlanePackWing, name = _('Folding Wings'), category = _('Systems')},

-- Modes
{down = iCommandPlaneModeBVR, name = _('(2) Beyond Visual Range Mode'), category = _('Modes')},
{down = iCommandPlaneModeVS, name = _('(3) Close Air Combat Vertical Scan Mode'), category = _('Modes')},
{down = iCommandPlaneModeBore, name = _('(4) Close Air Combat Bore Mode'), category = _('Modes')},
{down = iCommandPlaneModeHelmet, name = _('(5) Close Air Combat HMD Helmet Mode'), category = _('Modes')},
{down = iCommandPlaneModeFI0, name = _('(6) Longitudinal Missile Aiming Mode'), category = _('Modes')},
{down = iCommandPlaneModeGround, name = _('(7) Air-To-Ground Mode'), category = _('Modes')},
{down = iCommandPlaneModeGrid, name = _('(8) Gunsight Reticle Switch'), category = _('Modes')},
{down = iCommandPlaneTrimCancel, name = _('Trim Reset'), category = _('Flight Control')},

-- Sensors
{combos = {{key = 'JOY_BTN3'}}, down = iCommandPlaneChangeLock, up = iCommandPlaneChangeLockUp, name = _('Target Lock'), category = _('Sensors')},
{down = iCommandSensorReset, name = _('Return To Search'), category = _('Sensors')},
{down = iCommandPlaneRadarOnOff, name = _('Radar On/Off'), category = _('Sensors')},
{down = iCommandPlaneRadarChangeMode, name = _('Radar RWS/TWS Mode Select'), category = _('Sensors')},
{down = iCommandPlaneRadarCenter, name = _('Target Designator To Center'), category = _('Sensors')},
{down = iCommandPlaneChangeRadarPRF, name = _('Radar Pulse Repeat Frequency Select'), category = _('Sensors')},
{down = iCommandPlaneEOSOnOff, name = _('Electro-Optical System On/Off'), category = _('Sensors')},
{pressed = iCommandPlaneRadarUp, up = iCommandPlaneRadarStop, name = _('Target Designator Up'), category = _('Sensors')},
{pressed = iCommandPlaneRadarDown, up = iCommandPlaneRadarStop, name = _('Target Designator Down'), category = _('Sensors')},
{pressed = iCommandPlaneRadarLeft, up = iCommandPlaneRadarStop, name = _('Target Designator Left'), category = _('Sensors')},
{pressed = iCommandPlaneRadarRight, up = iCommandPlaneRadarStop, name = _('Target Designator Right'), category = _('Sensors')},
{pressed = iCommandSelecterUp, up = iCommandSelecterStop, name = _('Scan Zone Up'), category = _('Sensors')},
{pressed = iCommandSelecterDown, up = iCommandSelecterStop, name = _('Scan Zone Down'), category = _('Sensors')},
{pressed = iCommandSelecterLeft, up = iCommandSelecterStop, name = _('Scan Zone Left'), category = _('Sensors')},
{pressed = iCommandSelecterRight, up = iCommandSelecterStop, name = _('Scan Zone Right'), category = _('Sensors')},
{down = iCommandPlaneZoomIn, name = _('Display Zoom In'), category = _('Sensors')},
{down = iCommandPlaneZoomOut, name = _('Display Zoom Out'), category = _('Sensors')},
--{down = iCommandPlaneLaunchPermissionOverride, name = _('Launch Permission Override'), category = _('Sensors')},
{down = iCommandDecreaseRadarScanArea, name = _('Radar Scan Zone Decrease'), category = _('Sensors')},
{down = iCommandIncreaseRadarScanArea, name = _('Radar Scan Zone Increase'), category = _('Sensors')},
{pressed = iCommandPlaneIncreaseBase_Distance, up = iCommandPlaneStopBase_Distance, name = _('Target Specified Size Increase'), category = _('Sensors')},
{pressed = iCommandPlaneDecreaseBase_Distance, up = iCommandPlaneStopBase_Distance, name = _('Target Specified Size Decrease'), category = _('Sensors')},
{down = iCommandChangeRWRMode, name = _('RWR/SPO Mode Select'), category = _('Sensors')},
{down = iCommandPlaneThreatWarnSoundVolumeDown, name = _('RWR/SPO Sound Signals Volume Down'), category = _('Sensors')},
{down = iCommandPlaneThreatWarnSoundVolumeUp, name = _('RWR/SPO Sound Signals Volume Up'), category = _('Sensors')},

-- Autopilot
{down = iCommandPlaneAutopilot, name = _('Autopilot'), category = _('Autopilot')},
{down = iCommandPlaneSAUHBarometric, name = _('Autopilot - Barometric Altitude Hold \'H\''), category = _('Autopilot')},
{down = iCommandPlaneStabHorizon, name = _('Autopilot - Transition To Level Flight Control'), category = _('Autopilot')},
{down = iCommandPlane_SPU9_SPU_9_on_off, up = iCommandPlane_SPU9_SPU_9_on_off, value_down = 1.0, value_up = 0.0, name = _('Autopilot Reset (Stick Button)'), category = _('Autopilot')},
{down = iCommandPlaneAutopilotOverrideOn, up = iCommandPlaneAutopilotOverrideOff, name = _('Autopilot override'), category = _('Autopilot')},
{down = iCommandPlaneStabHbarBank, name = _('Autopilot - Damper'), category = _('Autopilot')},
{down = iCommandPlaneSAUHRadio, name = _('Autopilot - Ground Collision Avoidance'), category = _('Autopilot')},
{down = iCommandPlaneStabHbar, name = _('Autopilot - Barometric Altitude Hold'), category = _('Autopilot')},
{down = iCommandPlaneStabTangBank, name = _('Autopilot - Attitude Hold'), category = _('Autopilot')},
{down = iCommandPlaneRouteAutopilot, name = _('Autopilot - \'Path Control\''), category = _('Autopilot')},
{down = iCommandPlaneStabHrad, name = _('Autopilot - Reapproach'), category = _('Autopilot')},
{down = iCommandPlaneAUTIncrease, up = iCommandPlaneAUTIncrease, value_down = 1.0, value_up = 0.0, name = _('Min Altitude Increase'), category = _('Autopilot')},
{down = iCommandPlaneAUTIncrease, up = iCommandPlaneAUTIncrease, value_down = -1.0, value_up = 0.0, name = _('Min Altitude Decrease'), category = _('Autopilot')},

-- Flight Control
--{down = iCommandPlaneTrimCancel, name = _('Trim Reset'), category = _('Flight Control')},
--{combos = {{key = 'JOY_BTN3'}}, down = iCommandPlaneTrimOn, up = iCommandPlaneTrimOff, name = _('Stick to Trimmer Control Mode'), category = _('Flight Control')},
{down = iCommandPlane_HOTAS_LeftThrottleButton, up = iCommandPlane_HOTAS_LeftThrottleButton_Off, name = _('Stick Deflection Limiter Override'), category = _('Flight Control')},

-- Weapons                                                                        
{down = iCommandPlaneSalvoOnOff, name = _('Salvo Mode'), category = _('Weapons')},
{down = iCommandChangeGunRateOfFire, name = _('Cut Of Burst select'), category = _('Weapons')},
{down = iCommandPlaneHUDFilterOnOff, name = _('HUD Filter On Off'), category = _('Weapons')},
})
-- joystick axes 
join(res.axisCommands,{
{action = iCommandWheelBrake,				  name = _('Wheel Brake')},

{action = iCommandPlaneSelecterHorizontalAbs, name = _('TDC Slew Horizontal')},
{action = iCommandPlaneSelecterVerticalAbs	, name = _('TDC Slew Vertical')},
{action = iCommandPlaneRadarHorizontalAbs	, name = _('Radar Range')},
{action = iCommandPlaneRadarVerticalAbs		, name = _('Radar Vertical')},

{action = iCommandPlaneMFDZoomAbs 			, name = _('MFD Range')},
{action = iCommandPlaneBase_DistanceAbs 	, name = _('Target Base')},
})
return res
