local res = external_profile("Config/Input/Aircrafts/base_joystick_binding.lua")

join(res.keyCommands,{


-- Autopilot
{down = iCommandPlaneAutopilot, name    		= _('LAAP Engage/Disengage')     , category = _('LASTE Control Panel')},
{down = iCommandPlaneStabPathHold, name 		= _('LAAP Path Hold')			  , category = _('LASTE Control Panel')},
{down = iCommandPlaneStabHbarHeading, name 		= _('LAAP Altitude/Heading Hold'), category = _('LASTE Control Panel')},
{down = iCommandPlaneStabHbarBank, name 		= _('LAAP Altitude/Bank Hold')   , category = _('LASTE Control Panel')},
{down = iCommandPlane_EAC_ARM, name = _('EAC Arm'), category = _('LASTE Control Panel')},
{down = iCommandPlane_EAC_OFF, name = _('EAC Off'), category = _('LASTE Control Panel')},

-- Systems
{down = iCommandPlaneAirRefuel, name = _('Refueling Bay'), category = _('Systems')},
--{down = iCommandPlaneJettisonFuelTanks, name = _('Jettison Fuel Tanks'), category = _('Systems')},
-- Modes
--{down = iCommandPlaneModeBVR, name = _('(2) Beyond Visual Range Mode'), category = _('Modes')},
--{down = iCommandPlaneModeVS, name = _('(3) Close Air Combat Vertical Scan Mode'), category = _('Modes')},
--{down = iCommandPlaneModeBore, name = _('(4) Close Air Combat Bore Mode'), category = _('Modes')},
--{down = iCommandPlaneModeHelmet, name = _('(5) Close Air Combat HMD Helmet Mode'), category = _('Modes')},
{down = iCommandPlaneModeFI0, name = _('(6) Longitudinal Missile Aiming Mode'), category = _('Modes')},
{down = iCommandPlaneModeGround, name = _('(7) Air-To-Ground Mode'), category = _('Modes')},
--{down = iCommandPlaneModeGrid, name = _('(8) Gunsight Reticle Switch'), category = _('Modes')},
{down = iCommandPlaneTrimCancel, name = _('Trim Reset'), category = _('Flight Control')},

-- Systems F15
{down = iCommandPlane_HOTAS_NoseWheelSteeringButton, up = iCommandPlane_HOTAS_NoseWheelSteeringButton, name = _('Nose Gear Maneuvering Range'), category = _('Systems')},
{down = iCommandPlane_HOTAS_NoseWheelSteeringButtonOff, up = iCommandPlane_HOTAS_NoseWheelSteeringButtonOff, name = _('Nose Wheel Steering'), category = _('Systems')},
-- Systems Su33
{down = iCommandPlaneHook, name = _('Tail Hook'), category = _('Systems')},
{down = iCommandPlanePackWing, name = _('Folding Wings'), category = _('Systems')},

-- Sensors
{combos = {{key = 'JOY_BTN3'}}, down = iCommandPlaneChangeLock, up = iCommandPlaneChangeLockUp, name = _('Target Lock').._('(Air Refuel Reset/Disconnect)'), category = _('Sensors')},
{down = iCommandSensorReset, name = _('Target Unlock'), category = _('Sensors')},
--{down = iCommandPlaneRadarOnOff, name = _('Radar On/Off'), category = _('Sensors')},
--{down = iCommandPlaneRadarChangeMode, name = _('Radar RWS/TWS Mode Select'), category = _('Sensors')},
{down = iCommandPlaneRadarCenter, name = _('Target Designator To Center'), category = _('Sensors')},
--{down = iCommandPlaneChangeRadarPRF, name = _('Radar Pulse Repeat Frequency Select'), category = _('Sensors')},
{down = iCommandPlaneEOSOnOff, name = _('CCRP steering mode'), category = _('Sensors')},
--{down = iCommandPlaneLaserRangerOnOff, name = _('Laser Ranger On/Off'), category = _('Sensors')},
--{down = iCommandPlaneNightTVOnOff, name = _('Night Vision (FLIR or LLTV) On/Off'), category = _('Sensors')},
{pressed = iCommandPlaneRadarUp, up = iCommandPlaneRadarStop, name = _('Target Designator Up'), category = _('Sensors')},
{pressed = iCommandPlaneRadarDown, up = iCommandPlaneRadarStop, name = _('Target Designator Down'), category = _('Sensors')},
{pressed = iCommandPlaneRadarLeft, up = iCommandPlaneRadarStop, name = _('Target Designator Left'), category = _('Sensors')},
{pressed = iCommandPlaneRadarRight, up = iCommandPlaneRadarStop, name = _('Target Designator Right'), category = _('Sensors')},
--{pressed = iCommandSelecterUp, up = iCommandSelecterStop, name = _('Scan Zone Up'), category = _('Sensors')},
--{pressed = iCommandSelecterDown, up = iCommandSelecterStop, name = _('Scan Zone Down'), category = _('Sensors')},
--{pressed = iCommandSelecterLeft, up = iCommandSelecterStop, name = _('Scan Zone Left'), category = _('Sensors')},
--{pressed = iCommandSelecterRight, up = iCommandSelecterStop, name = _('Scan Zone Right'), category = _('Sensors')},
{down = iCommandPlaneZoomIn, name = _('Display Zoom In'), category = _('Sensors')},
{down = iCommandPlaneZoomOut, name = _('Display Zoom Out'), category = _('Sensors')},
--{down = iCommandPlaneLaunchPermissionOverride, name = _('Launch Permission Override'), category = _('Sensors')},
--{down = iCommandDecreaseRadarScanArea, name = _('Radar Scan Zone Decrease'), category = _('Sensors')},
--{down = iCommandIncreaseRadarScanArea, name = _('Radar Scan Zone Increase'), category = _('Sensors')},
--{pressed = iCommandPlaneIncreaseBase_Distance, up = iCommandPlaneStopBase_Distance, name = _('Target Specified Size Increase'), category = _('Sensors')},
--{pressed = iCommandPlaneDecreaseBase_Distance, up = iCommandPlaneStopBase_Distance, name = _('Target Specified Size Decrease'), category = _('Sensors')},
{down = iCommandChangeRWRMode, name = _('RWR/SPO Mode Select'), category = _('Sensors')},
{down = iCommandPlaneThreatWarnSoundVolumeDown, name = _('RWR/SPO Sound Signals Volume Down'), category = _('Sensors')},
{down = iCommandPlaneThreatWarnSoundVolumeUp, name = _('RWR/SPO Sound Signals Volume Up'), category = _('Sensors')},

-- Weapons                                                                        
{down = iCommandPlaneSalvoOnOff, name = _('Salvo Mode'), category = _('Weapons')},
{combos = {{key = 'JOY_BTN2'}}, down = iCommandPlanePickleOn,	up = iCommandPlanePickleOff, name = _('Weapon Release'), category = _('Weapons')},
--{down = iCommandChangeGunRateOfFire, name = _('Cannon Rate Of Fire / Cut Of Burst select'), category = _('Weapons')},
{down = iCommandChangeRippleQuantity, name = _('Ripple Quantity Select'), category = _('Weapons')},
{down = iCommandChangeRippleInterval, name = _('Ripple Interval Increase'), category = _('Weapons')},
{down = iCommandChangeRippleIntervalDown, name = _('Ripple Interval Decrease'), category = _('Weapons')},
{down = iCommandChangeReleaseMode, name = _('PRS/SGL Release Submodes Cycle'), category = _('Weapons')},
})
-- joystick axes 
join(res.axisCommands,{
{action = iCommandPlaneSelecterHorizontalAbs, name = _('TDC Slew Horizontal')},
{action = iCommandPlaneSelecterVerticalAbs	, name = _('TDC Slew Vertical')},
{action = iCommandWheelBrake,		name = _('Wheel Brake')},
{action = iCommandLeftWheelBrake,	name = _('Wheel Brake Left')},
{action = iCommandRightWheelBrake,	name = _('Wheel Brake Right')},

--{action = iCommandPlaneRadarHorizontalAbs	, name = _('Radar Horizontal')},
--{action = iCommandPlaneRadarVerticalAbs		, name = _('Radar Vertical')},

--{action = iCommandPlaneMFDZoomAbs 			, name = _('MFD Range')},
--{action = iCommandPlaneBase_DistanceAbs 	, name = _('Base/Distance')},
})
return res
