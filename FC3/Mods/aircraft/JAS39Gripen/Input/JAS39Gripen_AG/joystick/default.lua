local res = external_profile("Config/Input/Aircrafts/base_joystick_binding.lua")
join(res.keyCommands,{

-- Autopilot
{down = iCommandPlaneAutopilot, name = _('Autopilot'), category = _('Autopilot')},
{down = iCommandPlaneSAUHBarometric, name = _('Autopilot - Barometric Altitude Hold \'H\''), category = _('Autopilot')},
{down = iCommandPlaneAutopilotOverrideOn, up = iCommandPlaneAutopilotOverrideOff, name = _('Autopilot override'), category = _('Autopilot')},
{down = iCommandPlaneStabTangBank, name = _('Autopilot - Attitude Hold'), category = _('Autopilot')},
{down = iCommandPlaneStabHbarBank, name = _('Autopilot - Altitude And Roll Hold'), category = _('Autopilot')},
{down = iCommandPlaneStabHorizon,	name = _('Autopilot - Transition To Level Flight Control'), category = _('Autopilot')},
{down = iCommandPlaneStabHbar, name = _('Autopilot - Barometric Altitude Hold'), category = _('Autopilot')},
{down = iCommandPlaneStabHrad, name = _('Autopilot - Radar Altitude Hold'), category = _('Autopilot')},
{down = iCommandPlaneRouteAutopilot, name = _('Autopilot - \'Route following\''), category = _('Autopilot')},
{down = iCommandPlaneStabCancel, name = _('Autopilot Disengage'), category = _('Autopilot')},

-- Systems
{down = iCommandPlaneJettisonFuelTanks, name = _('Jettison Fuel Tanks'), category = _('Systems')},
{pressed = iCommandAltimeterPressureIncrease,	up = iCommandAltimeterPressureStop, name = _('Altimeter Pressure Increase Su-25T'), category = _('Systems')},
{pressed = iCommandAltimeterPressureDecrease, up = iCommandAltimeterPressureStop, name = _('Altimeter Pressure Decrease Su-25T'), category = _('Systems')},

-- Systems F15
{down = iCommandPlane_HOTAS_NoseWheelSteeringButton, up = iCommandPlane_HOTAS_NoseWheelSteeringButton, name = _('Nose Gear Maneuvering Range'), category = _('Systems')},
{down = iCommandPlane_HOTAS_NoseWheelSteeringButtonOff, up = iCommandPlane_HOTAS_NoseWheelSteeringButtonOff, name = _('Nose Wheel Steering'), category = _('Systems')},
-- Systems Su33
{down = iCommandPlaneAirRefuel, name = _('Refueling Boom'), category = _('Systems')},
{down = iCommandPlaneHook, name = _('Tail Hook'), category = _('Systems')},
{down = iCommandPlanePackWing, name = _('Folding Wings'), category = _('Systems')},

-- Modes
{down = iCommandPlaneModeFI0, name = _('(6) Longitudinal Missile Aiming Mode'), category = _('Modes')},
{down = iCommandPlaneModeGround, name = _('(7) Air-To-Ground Mode'), category = _('Modes')},
{down = iCommandPlaneModeGrid, name = _('(8) Gunsight Reticle Switch'), category = _('Modes')},

-- Sensors
{down = iCommandPlaneChangeLock, up = iCommandPlaneChangeLockUp, name = _('Target Lock'), category = _('Sensors')},
{down = iCommandSensorReset, name = _('Target Unlock'), category = _('Sensors')},
{down = iCommandPlaneRadarOnOff, name = _('ELINT Pod On/Off'), category = _('Sensors')},
{down = iCommandPlaneRadarCenter, name = _('Target Designator To Center'), category = _('Sensors')},
{down = iCommandPlaneEOSOnOff, name = _('Electro-Optical System On/Off'), category = _('Sensors')},
{down = iCommandPlaneLaserRangerOnOff, name = _('Laser Ranger On/Off'), category = _('Sensors')},
{down = iCommandPlaneNightTVOnOff, name = _('Night Vision (FLIR or LLTV) On/Off'), category = _('Sensors')},
{pressed = iCommandPlaneRadarUp, up = iCommandPlaneRadarStop, name = _('Target Designator Up'), category = _('Sensors')},
{pressed = iCommandPlaneRadarDown, up = iCommandPlaneRadarStop, name = _('Target Designator Down'), category = _('Sensors')},
{pressed = iCommandPlaneRadarLeft, up = iCommandPlaneRadarStop, name = _('Target Designator Left'), category = _('Sensors')},
{pressed = iCommandPlaneRadarRight, up = iCommandPlaneRadarStop, name = _('Target Designator Right'), category = _('Sensors')},

{down = iCommandPlaneZoomIn, name = _('Display Zoom In'), category = _('Sensors')},
{down = iCommandPlaneZoomOut, name = _('Display Zoom Out'), category = _('Sensors')},
{down = iCommandDecreaseRadarScanArea, name = _('Target Size / Gunpod Elevation Decrease Stepping'), category = _('Sensors')},
{down = iCommandIncreaseRadarScanArea, name = _('Target Size / Gunpod Elevation Increase Stepping'), category = _('Sensors')},
{pressed = iCommandPlaneIncreaseBase_Distance, up = iCommandPlaneStopBase_Distance, name = _('Target Size / Gunpod Elevation Increase'), category = _('Sensors')},
{pressed = iCommandPlaneDecreaseBase_Distance, up = iCommandPlaneStopBase_Distance, name = _('Target Size / Gunpod Elevation Decrease'), category = _('Sensors')},
{down = iCommandChangeRWRMode, name = _('RWR/SPO Mode Select'), category = _('Sensors')},
{down = iCommandPlaneThreatWarnSoundVolumeDown, name = _('RWR/SPO Sound Signals Volume Down'), category = _('Sensors')},
{down = iCommandPlaneThreatWarnSoundVolumeUp, name = _('RWR/SPO Sound Signals Volume Up'), category = _('Sensors')},

-- Weapons                                                                        
{down = iCommandPlaneSalvoOnOff, name = _('Salvo Mode'), category = _('Weapons')},
--{combos = {{key = 'Space', reformers = {'RAlt'}}}, down = iCommandPlanePickleOn,	up = iCommandPlanePickleOff, name = _('Weapon Release'), category = _('Weapons')},
{down = iCommandChangeGunRateOfFire, name = _('Cut Of Burst select'), category = _('Weapons')},
{down = iCommandChangeRippleQuantity, name = _('Ripple Quantity Select/SPPU select'), category = _('Weapons')},
{down = iCommandChangeRippleInterval, name = _('Ripple Interval Increase'), category = _('Weapons')},
{down = iCommandChangeRippleIntervalDown, name = _('Ripple Interval Decrease'), category = _('Weapons')},

-- Countermeasures
{down = iCommandActiveIRJamming, name = _('IR Jamming'), category = _('Countermeasures')},
})
-- joystick axes 
join(res.axisCommands,{
{action = iCommandPlaneSelecterHorizontalAbs, name = _('I-251 Slew Horizontal')},
{action = iCommandPlaneSelecterVerticalAbs	, name = _('I-251 Slew Vertical')},
{action = iCommandPlaneMFDZoomAbs 			, name = _('I-251 Zoom')},
{action = iCommandPlaneBase_DistanceAbs 	, name = _('Target Box Size / Funnel target wing span / Gunpod Elevation')},
})
return res
