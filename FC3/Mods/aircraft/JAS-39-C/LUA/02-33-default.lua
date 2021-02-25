local res = external_profile("Config/Input/Aircrafts/base_joystick_binding.lua")

join(res.keyCommands,{

{pressed = iCommandAltimeterPressureIncrease,	up = iCommandAltimeterPressureStop, name = _('Altimeter Pressure Increase'), category = _('Systems')},
{pressed = iCommandAltimeterPressureDecrease, up = iCommandAltimeterPressureStop, name = _('Altimeter Pressure Decrease'), category = _('Systems')},

-- Autopilot
{down = iCommandPlaneAutopilot, name = _('Autopilot'), category = _('Autopilot')},
{down = iCommandPlaneAUTOnOff, name = _('Autothrust'), category = _('Autopilot')},
{down = iCommandPlaneAUTIncrease, up = iCommandPlaneAUTIncrease, value_down = 1.0, value_up = 0.0, name = _('Autothrust - Increase Velocity'), category = _('Autopilot')},
{down = iCommandPlaneAUTIncrease, up = iCommandPlaneAUTIncrease, value_down = -1.0, value_up = 0.0, name = _('Autothrust - Decrease Velocity'), category = _('Autopilot')},
{down = iCommandPlaneSAUHBarometric, name = _('Autopilot - Barometric Altitude Hold \'H\''), category = _('Autopilot')},
--{down = iCommandPlaneAutopilotOverrideOn, up = iCommandPlaneAutopilotOverrideOff, name = _('Autopilot override (Su-25T)'), category = _('Autopilot')},
{down = iCommandPlaneStabTangBank, name = _('Autopilot - Attitude Hold'), category = _('Autopilot')},
{down = iCommandPlaneStabHbarBank, name = _('Autopilot - Altitude And Roll Hold'), category = _('Autopilot')},
{down = iCommandPlaneStabHorizon,	name = _('Autopilot - Transition To Level Flight Control'), category = _('Autopilot')},
{down = iCommandPlaneStabHbar, name = _('Autopilot - Barometric Altitude Hold'), category = _('Autopilot')},
{down = iCommandPlaneStabHrad, name = _('Autopilot - Radar Altitude Hold'), category = _('Autopilot')},
{down = iCommandPlaneRouteAutopilot, name = _('Autopilot - \'Route following\''), category = _('Autopilot')},
{down = iCommandPlaneSAUHRadio, name = _('Autopilot - Ground Collision Avoidance'), category = _('Autopilot')},
{down = iCommandPlane_SPU9_SPU_9_on_off, up = iCommandPlane_SPU9_SPU_9_on_off, value_down = 1.0, value_up = 0.0, name = _('Autopilot Reset (Stick Button)'), category = _('Autopilot')},
{down = iCommandPlaneAutopilotOverrideOn, up = iCommandPlaneAutopilotOverrideOff, name = _('Autopilot override'), category = _('Autopilot')},

-- Systems
{down = iCommandPlaneAirRefuel, name = _('Refueling Boom'), category = _('Systems')},
{down = iCommandPlaneHook, name = _('Tail Hook'), category = _('Systems')},
{down = iCommandPlanePackWing, name = _('Folding Wings'), category = _('Systems')},
--{down = iCommandPlane_HOTAS_NoseWheelSteeringButton, name = _('Nose Wheel Steering'), category = _('Systems')},
{down = iCommandPlaneWheelBrakeLeftOn, up = iCommandPlaneWheelBrakeLeftOff, name = _('Wheel Brake Left'), category = _('Systems')},
{down = iCommandPlaneWheelBrakeRightOn, up = iCommandPlaneWheelBrakeRightOff, name = _('Wheel Brake Right'), category = _('Systems')},
{down = iCommandPlaneWheelParkingBrake, up = iCommandPlaneWheelParkingBrake, name = _('Wheel Brake Start'), category = _('Systems')},
{down = iCommandPlane_ADF_Test, name = _('Aerial Refueling Lights'), category = _('Systems')},
{down = iCommandPlane_HOTAS_ChinaHatForward, name = _('Engine Inlet Grids Auto/Off'), category = _('Systems')},
{down = iCommandPlaneHUDFilterOnOff, name = _('HUD Color Filter On/Off'), category = _('Systems')},
{down = iCommandPlaneRightMFD_OSB1 , name = _('HDD, HUD Repeater Mode On/Off'), category = _('Systems')},

-- Systems F15
{down = iCommandPlane_HOTAS_NoseWheelSteeringButton, up = iCommandPlane_HOTAS_NoseWheelSteeringButton, name = _('Nose Gear Maneuvering Range'), category = _('Systems')},
{down = iCommandPlane_HOTAS_NoseWheelSteeringButtonOff, up = iCommandPlane_HOTAS_NoseWheelSteeringButtonOff, name = _('Nose Wheel Steering'), category = _('Systems')},

-- Modes
{down = iCommandPlaneModeBVR, name = _('(2) Beyond Visual Range Mode'), category = _('Modes')},
{down = iCommandPlaneModeVS, name = _('(3) Close Air Combat Vertical Scan Mode'), category = _('Modes')},
{down = iCommandPlaneModeBore, name = _('(4) Close Air Combat Bore Mode'), category = _('Modes')},
{down = iCommandPlaneModeHelmet, name = _('(5) Close Air Combat HMD Helmet Mode'), category = _('Modes')},
{down = iCommandPlaneModeFI0, name = _('(6) Longitudinal Missile Aiming Mode'), category = _('Modes')},
{down = iCommandPlaneModeGround, name = _('(7) Air-To-Ground Mode'), category = _('Modes')},
{down = iCommandPlaneModeGrid, name = _('(8) Gunsight Reticle Switch'), category = _('Modes')},

-- Flight Control
{down = iCommandPlaneTrimCancel, name = _('Trim Reset'), category = _('Flight Control')},
--{down = iCommandPlaneCobra, up = iCommandPlaneCobra, value_down = 1.0, value_up = 0.0, name = _('ASC Direct Control (Cobra)'), category = _('Flight Control')},
{down = iCommandPlaneCobra, name = _('ASC Direct Control (Cobra)'), category = _('Flight Control')},
{combos = {{key = 'JOY_BTN3'}}, down = iCommandPlaneTrimOn, up = iCommandPlaneTrimOff, name = _('Stick to Trimmer Control Mode'), category = _('Flight Control')},
{down = iCommandPlane_P_51_WarEmergencyPower, name = _('Special Afterburner Mode'), category = _('Flight Control')},
{down = iCommandPlane_HOTAS_LeftThrottleButton, up = iCommandPlane_HOTAS_LeftThrottleButton_Off, name = _('Stick Deflection Limiter Override'), category = _('Flight Control')},
{down = iCommandPlane_ADF_Mode_change, name = _('ASC Refueling Mode'), category = _('Flight Control')},


-- Sensors
{down = iCommandPlaneChangeLock, up = iCommandPlaneChangeLockUp, name = _('Target Lock'), category = _('Sensors')},
{down = iCommandSensorReset, name = _('Return To Search'), category = _('Sensors')},
{down = iCommandPlaneRadarOnOff, name = _('Radar'), category = _('Sensors')},
{down = iCommandPlaneRadarChangeMode, name = _('Radar RWS/TWS Mode Select'), category = _('Sensors')},
{down = iCommandPlaneRadarCenter, name = _('Target Designator To Center'), category = _('Sensors')},
{down = iCommandPlaneChangeRadarPRF, name = _('Radar Pulse Repeat Frequency Select'), category = _('Sensors')},
{down = iCommandPlaneEOSOnOff, name = _('Electro-Optical System'), category = _('Sensors')},
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

-- Weapons                                                                        
{down = iCommandPlaneSalvoOnOff, name = _('Salvo Mode'), category = _('Weapons')},
{down = iCommandChangeGunRateOfFire, name = _('Cut Of Burst'), category = _('Weapons')},


})
-- joystick axes 
join(res.axisCommands,{
{action = iCommandPlaneSelecterHorizontalAbs, name = _('TDC Slew Horizontal')},
{action = iCommandPlaneSelecterVerticalAbs	, name = _('TDC Slew Vertical')},
{action = iCommandPlaneRadarHorizontalAbs	, name = _('Radar Range')},
{action = iCommandPlaneRadarVerticalAbs		, name = _('Radar Vertical')},

{action = iCommandPlaneMFDZoomAbs 			, name = _('MFD Range')},
{action = iCommandPlaneBase_DistanceAbs 	, name = _('Target Base')},
{action = iCommandWheelBrake,		name = _('Wheel Brake')},
{action = iCommandLeftWheelBrake,	name = _('Wheel Brake Left')},
{action = iCommandRightWheelBrake,	name = _('Wheel Brake Right')},
})
return res
