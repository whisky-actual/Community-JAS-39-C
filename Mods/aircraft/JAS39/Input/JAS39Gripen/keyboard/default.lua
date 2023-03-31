local cockpit = folder.."../../../Cockpit/Scripts/"
dofile(cockpit.."devices.lua")
dofile(cockpit.."command_defs.lua")

local res = external_profile("Config/Input/Aircrafts/common_keyboard_binding.lua")

-- Brakes
local BrakesON      = 10038
local BrakesOFF     = 10039
local L_BRAKE       = 10056
local R_BRAKE       = 10057
local B_BRAKE       = 10058
local Brakes        = 10023 
local P_BRAKE	    = 10059
local LANDING_MODE  = 10060
local AUTOTHROTTLE  = 10064
local ATAOA_1214	= 10065

ignore_features(res.keyCommands,{"dragchute"})
---------------------------------------------
-- POTENTIAL --------------------------------
---------------------------------------------
--[[
-- Autopilot
{down = iCommandPlaneAutopilot, name = _('Autopilot'), category = _('Autopilot')},
{down = iCommandPlaneAUTOnOff, name = _('Autothrust'), category = _('Autopilot')},
{down = iCommandPlaneAUTIncrease, up = iCommandPlaneAUTIncrease, value_down = 1.0, value_up = 0.0, name = _('Autothrust - Increase Velocity'), category = _('Autopilot')},
{down = iCommandPlaneAUTIncrease, up = iCommandPlaneAUTIncrease, value_down = -1.0, value_up = 0.0, name = _('Autothrust - Decrease Velocity'), category = _('Autopilot')},
{down = iCommandPlaneSAUHBarometric, name = _('Autopilot - Barometric Altitude Hold \'H\''), category = _('Autopilot')},--59
{down = iCommandPlaneAutopilotOverrideOn, up = iCommandPlaneAutopilotOverrideOff, name = _('Autopilot override (Su-25T)'), category = _('Autopilot')},
{down = iCommandPlaneStabTangBank, name = _('Autopilot - Attitude Hold'), category = _('Autopilot')},--386
{down = iCommandPlaneStabHbarBank, name = _('Autopilot - Altitude And Roll Hold'), category = _('Autopilot')},--387
{down = iCommandPlaneStabHorizon,	name = _('Autopilot - Transition To Level Flight Control'), category = _('Autopilot')},--388
{down = iCommandPlaneStabHbar, name = _('Autopilot - Barometric Altitude Hold'), category = _('Autopilot')},--389
{down = iCommandPlaneStabHrad, name = _('Autopilot - Radar Altitude Hold'), category = _('Autopilot')},--390
{down = iCommandPlaneRouteAutopilot, name = _('Autopilot - \'Route following\''), category = _('Autopilot')},
{down = iCommandPlaneSAUHRadio, name = _('Autopilot - Ground Collision Avoidance'), category = _('Autopilot')},
{down = iCommandPlane_SPU9_SPU_9_on_off, up = iCommandPlane_SPU9_SPU_9_on_off, value_down = 1.0, value_up = 0.0, name = _('Autopilot Reset (Stick Button)'), category = _('Autopilot')},
{down = iCommandPlaneAutopilotOverrideOn, up = iCommandPlaneAutopilotOverrideOff, name = _('Autopilot override'), category = _('Autopilot')},
]]--
join(res.keyCommands,{
---------------------------------------------
-- GRIPEN BINDINGS --------------------------
---------------------------------------------
--{down = Keys.NoHotas, 																			name = _('I dont have a Hotas'),    	   category = _('Other')},
---------------------------------------------
-- Systems ----------------------------------
---------------------------------------------
-- NightVision
{combos = {{key = 'H', reformers = {'RShift'}}}        , down = iCommandViewNightVisionGogglesOn   , name = _('Night Vision Goggle - Toggle'), category = _('Systems')},
{combos = {{key = 'H', reformers = {'RShift','RCtrl'}}}, down = iCommandPlane_Helmet_Brightess_Up  , name = _('Goggle Gain - Inc'),            category = _('Systems')},
{combos = {{key = 'H', reformers = {'RShift','RAlt'}}} , down = iCommandPlane_Helmet_Brightess_Down, name = _('Goggle Gain - Dec'),            category = _('Systems')},
---------------------------------------------
-- General ----------------------------------
---------------------------------------------
-- Mirrors
{combos = {{key = 'N', reformers = {'RAlt'}}},		down = iCommandViewLeftMirrorOn ,	up = iCommandViewLeftMirrorOff ,	name = _('Mirror Left On'),		category = _('General') , features = {"Mirrors"}},
{combos = {{key = 'M', reformers = {'RAlt'}}},		down = iCommandViewRightMirrorOn,	up = iCommandViewRightMirrorOff,	name = _('Mirror Right On'),	category = _('General') , features = {"Mirrors"}},
{combos = {{key = 'M' }},							down = iCommandToggleMirrors,											name = _('Toggle Mirrors'),		category = _('General') , features = {"Mirrors"}},
-- Pilot
{combos = {{key = 'P', reformers = {'RShift'}}},	down = iCommandCockpitShowPilotOnOff,			name = _('Show Pilot Body'),						category = _('General')},
-- Auto Lock On 
{combos = {{key = 'F5', reformers = {'RAlt'}}},		down = iCommandAutoLockOnNearestAircraft,		name = _('Auto lock on nearest aircraft'),			category = _('General')},
{combos = {{key = 'F6', reformers = {'RAlt'}}},		down = iCommandAutoLockOnCenterAircraft,		name = _('Auto lock on center aircraft'),			category = _('General')},
{combos = {{key = 'F7', reformers = {'RAlt'}}},		down = iCommandAutoLockOnNextAircraft,			name = _('Auto lock on next aircraft'),				category = _('General')},
{combos = {{key = 'F8', reformers = {'RAlt'}}},		down = iCommandAutoLockOnPreviousAircraft,		name = _('Auto lock on previous aircraft'),			category = _('General')},
{combos = {{key = 'F9', reformers = {'RAlt'}}},		down = iCommandAutoLockOnNearestSurfaceTarget,	name = _('Auto lock on nearest surface target'),	category = _('General')},
{combos = {{key = 'F10', reformers = {'RAlt'}}},	down = iCommandAutoLockOnCenterSurfaceTarget,	name = _('Auto lock on center surface target'),		category = _('General')},
{combos = {{key = 'F11', reformers = {'RAlt'}}},	down = iCommandAutoLockOnNextSurfaceTarget,		name = _('Auto lock on next surface target'),		category = _('General')},
{combos = {{key = 'F12', reformers = {'RAlt'}}},	down = iCommandAutoLockOnPreviousSurfaceTarget, name = _('Auto lock on previous surface target'),	category = _('General')},
-- Other 
{combos = {{key = 'E', reformers = {'LCtrl'}}}, 	down = Keys.SeatEject,	               			name = _('Eject'), 			  						category = _('General')}, 
{combos = {{key = 'C', reformers = {'RCtrl'}}}, 	down = Keys.CanopyLever,	               		name = _('Canopy'),                    			  	category = _('General')},
{combos = {{key = 'T'}},							down = iCommandPlaneWingtipSmokeOnOff,			name = _('Smoke'),									category = _('General')},
-- Systems Su33
--{combos = {{key = 'G', reformers = {'LAlt'}}}, down = iCommandPlaneHook, name = _('Tail Hook'), category = _('FC3')},
--{combos = {{key = 'U'}},						 down = iCommandPlaneShipTakeOff,			name = _('Ship Take Off Position'),		category = _('General') , features = {"shiptakeoff"}},
---------------------------------------------
-- Flight Controls --------------------------
---------------------------------------------
{combos = {{key = 'W'}}, 						up = BrakesOFF,	down = BrakesON, 		name = _('Wheel Brakes - Both'),    category = {_('Systems')}},				
---------------------------------------------
-- Stick ------------------------------------
---------------------------------------------
-- Flight Controls Gripen
{combos = {{key = 'Up'}},				pressed = Keys.GripenPlaneUpStart,				up = Keys.GripenPlaneUpStop,			name = _('Aircraft Pitch Down'),	category = {_('Stick'), _('HOTAS'), _('Flight Control')}},
{combos = {{key = 'Down'}},				pressed = Keys.GripenPlaneDownStart,			up = Keys.GripenPlaneDownStop,			name = _('Aircraft Pitch Up'),		category = {_('Stick'), _('HOTAS'), _('Flight Control')}},
{combos = {{key = 'Left'}},				pressed = Keys.GripenPlaneLeftStart,			up = Keys.GripenPlaneLeftStop,			name = _('Aircraft Bank Left'),		category = {_('Stick'), _('HOTAS'), _('Flight Control')}},
{combos = {{key = 'Right'}},			pressed = Keys.GripenPlaneRightStart,			up = Keys.GripenPlaneRightStop,			name = _('Aircraft Bank Right'),	category = {_('Stick'), _('HOTAS'), _('Flight Control')}},
{combos = {{key = 'Z'}},				pressed = Keys.GripenPlaneLeftRudderStart,		up = Keys.GripenPlaneLeftRudderStop,	name = _('Aircraft Rudder Left'),	category = {_('Flight Control')}},
{combos = {{key = 'X'}},				pressed = Keys.GripenPlaneRightRudderStart,		up = Keys.GripenPlaneRightRudderStop,	name = _('Aircraft Rudder Right'),	category = {_('Flight Control')}},
-- Trim Controls
{combos = {{key = '.', reformers = {'RCtrl'}}},	pressed = iCommandPlaneTrimUp,			up = iCommandPlaneTrimStop, name = _('Trim: Nose Up'),			category = {_('Stick'), _('HOTAS'), _('Flight Control')}},
{combos = {{key = ';', reformers = {'RCtrl'}}},	pressed = iCommandPlaneTrimDown,		up = iCommandPlaneTrimStop, name = _('Trim: Nose Down'),		category = {_('Stick'), _('HOTAS'), _('Flight Control')}},
{combos = {{key = ',', reformers = {'RCtrl'}}},	pressed = iCommandPlaneTrimLeft,		up = iCommandPlaneTrimStop, name = _('Trim: Left Wing Down'),	category = {_('Stick'), _('HOTAS'), _('Flight Control')}},
{combos = {{key = '/', reformers = {'RCtrl'}}},	pressed = iCommandPlaneTrimRight,		up = iCommandPlaneTrimStop, name = _('Trim: Right Wing Down'),	category = {_('Stick'), _('HOTAS'), _('Flight Control')}},
{combos = {{key = 'Z', reformers = {'RCtrl'}}},	pressed = iCommandPlaneTrimLeftRudder,	up = iCommandPlaneTrimStop, name = _('Trim: Rudder Left'),		category = {_('Stick'), _('HOTAS'), _('Flight Control')}},
{combos = {{key = 'X', reformers = {'RCtrl'}}},	pressed = iCommandPlaneTrimRightRudder,	up = iCommandPlaneTrimStop, name = _('Trim: Rudder Right'),		category = {_('Stick'), _('HOTAS'), _('Flight Control')}},
-- Weapons
{combos = {{key = 'Space'}}, 						down = Keys.Trigger,	     		up = Keys.Trigger,      	name = _('Trigger'),      			category = {_('Stick'), _('HOTAS')}, 			value_down =  1.0,		value_up = 0.0},
{combos = {{key = 'C', reformers = {'RAlt'}}}, 		down = Keys.TriggerSafe,	 									name = _('Trigger Safe - Toggle'), 	category = {_('Stick'), _('HOTAS')}},
{																						up = Keys.TriggerSafeHold,	name = _('Trigger Safe - Hold'), 	category = {_('Stick'), _('HOTAS')}, 			value_down =  1.0,		value_up = 0.0},
{combos = {{key = 'C'}}, 							down = Keys.CannonMode,	 										name = _('Cannon Mode'), 			category = {_('Stick'), _('HOTAS')}},
-- FC3 Weapons                                                                       
{combos = {{key = 'V', reformers = {'LCtrl'}}}, 	down = iCommandPlaneSalvoOnOff, 								name = _('Salvo Mode'), 						category = {_('Stick'), _('HOTAS')}},
{combos = {{key = 'Space', reformers = {'LCtrl'}}}, down = iCommandChangeRippleQuantity, 							name = _('Ripple Quantity Select/SPPU select'), category = {_('Stick'), _('HOTAS')}},
{combos = {{key = 'V'}}, 							down = iCommandChangeRippleInterval, 							name = _('Ripple Interval Increase'), 			category = {_('Stick'), _('HOTAS')}},
{combos = {{key = 'V', reformers = {'LShift'}}}, 	down = iCommandChangeRippleIntervalDown, 						name = _('Ripple Interval Decrease'), 			category = {_('Stick'), _('HOTAS')}},
{combos = {{key = 'D'}},							down = iCommandPlaneChangeWeapon, 								name = _('Weapon Change'),						category = {_('Stick'), _('HOTAS')}},
-- Modes
{combos = {{key = '1'}},							down = iCommandPlaneModeNAV,		name = _('(1) Navigation Modes'),								category = {_('Stick'), _('HOTAS')}},
{combos = {{key = '2'}},							down = iCommandPlaneModeBVR, 		name = _('(2) Beyond Visual Range Mode'), 						category = {_('Stick'), _('HOTAS')}},
{combos = {{key = '3'}},							down = iCommandPlaneModeVS, 		name = _('(3) Close Air Combat Vertical Scan Mode'), 			category = {_('Stick'), _('HOTAS')}},
{combos = {{key = '4'}},							down = iCommandPlaneModeBore, 		name = _('(4) Close Air Combat Bore Mode'), 					category = {_('Stick'), _('HOTAS')}},
{combos = {{key = '5'}},							down = iCommandPlaneModeHelmet, 	name = _('(5) Close Air Combat HMD Helmet Mode'), 				category = {_('Stick'), _('HOTAS')}},
{combos = {{key = '6'}},							down = iCommandPlaneModeFI0, 		name = _('(6) Longitudinal Missile Aiming Mode/FLOOD mode'),	category = {_('Stick'), _('HOTAS')}},
{combos = {{key = '7'}},							down = iCommandPlaneModeGround, 	name = _('(7) Air-To-Ground Mode'), 							category = {_('Stick'), _('HOTAS')}},
{combos = {{key = '8'}},							down = iCommandPlaneModeGrid, 		name = _('(8) Gunsight Reticle Switch'), 						category = {_('Stick'), _('HOTAS')}},
---------------------------------------------
-- Throttle Grip ----------------------------
---------------------------------------------
-- TDC
{combos = {{key = ';'}}, pressed = iCommandPlaneRadarUp, up = iCommandPlaneRadarStop, 	name = _('Target Designator Up'),    category = {_('Throttle Grip'), _('HOTAS'), _('Sensors')}},
{combos = {{key = '.'}}, pressed = iCommandPlaneRadarDown, up = iCommandPlaneRadarStop, name = _('Target Designator Down'),  category = {_('Throttle Grip'), _('HOTAS'), _('Sensors')}},
{combos = {{key = ','}}, pressed = iCommandPlaneRadarLeft, up = iCommandPlaneRadarStop, name = _('Target Designator Left'),  category = {_('Throttle Grip'), _('HOTAS'), _('Sensors')}},
{combos = {{key = '/'}}, pressed = iCommandPlaneRadarRight, up = iCommandPlaneRadarStop,name = _('Target Designator Right'), category = {_('Throttle Grip'), _('HOTAS'), _('Sensors')}},
-- Sensors (F15 Specific)
{												 down = iCommandRefusalTWS,			 						name = _('Unlock TWS Target'), 					 			category = {_('Throttle Grip'), _('HOTAS'), _('Sensors')}},
{combos = {{key = 'I', reformers = {'RShift'}}}, down = iCommandPlaneChangeRadarPRF, 						name = _('Radar Pulse Repeat Frequency Select'), 			category = {_('Throttle Grip'), _('HOTAS'), _('Sensors')}},
-- Sensors (Su25T Specific)				
{combos = {{key = 'O', reformers = {'RShift'}}}, down = iCommandPlaneLaserRangerOnOff, 						name = _('Laser Ranger On/Off'), 				 			category = {_('Throttle Grip'), _('HOTAS'), _('Sensors')}},
{combos = {{key = 'O', reformers = {'RCtrl'}}},  down = iCommandPlaneNightTVOnOff, 							name = _('Night Vision (FLIR or LLTV) On/Off'),  			category = {_('Throttle Grip'), _('HOTAS'), _('Sensors')}},
-- Sensors (Shared)				
{combos = {{key = 'O'}}, 						 down = iCommandPlaneEOSOnOff, 			    				name = _('Electro-Optical System On/Off'), 					category = {_('Throttle Grip'), _('HOTAS'), _('Sensors')}},
{combos = {{key = 'Enter'}}, down = iCommandPlaneChangeLock, up = iCommandPlaneChangeLockUp,				name = _('Target Lock'), 									category = {_('Throttle Grip'), _('HOTAS'), _('Sensors')}},
{combos = {{key = 'Back'}}, 					 down = iCommandSensorReset, 								name = _('Radar NDTWS / Target Unlock'), 					category = {_('Throttle Grip'), _('HOTAS'), _('Sensors')}},
{combos = {{key = 'I'}}, 						 down = iCommandPlaneRadarOnOff, 							name = _('Radar On/Off / ELINT Pod On/Off'), 				category = {_('Throttle Grip'), _('HOTAS'), _('Sensors')}},
{combos = {{key = 'I', reformers = {'RAlt'}}}, 	 down = iCommandPlaneRadarChangeMode, 						name = _('Radar RWS/TWS Mode Select'), 						category = {_('Throttle Grip'), _('HOTAS'), _('Sensors')}},
{combos = {{key = 'I', reformers = {'RCtrl'}}},  down = iCommandPlaneRadarCenter, 							name = _('Target Designator To Center'), 					category = {_('Throttle Grip'), _('HOTAS'), _('Sensors')}},
-- Radar / TGP
{combos = {{key = ';', reformers = {'RShift'}}}, pressed = iCommandSelecterUp, up = iCommandSelecterStop, 	name = _('Scan Zone Up'),																 category = {_('Throttle Grip'), _('HOTAS'), _('Sensors')}},
{combos = {{key = '.', reformers = {'RShift'}}}, pressed = iCommandSelecterDown, up = iCommandSelecterStop, name = _('Scan Zone Down'),																 category = {_('Throttle Grip'), _('HOTAS'), _('Sensors')}},
{combos = {{key = ',', reformers = {'RShift'}}}, pressed = iCommandSelecterLeft, up = iCommandSelecterStop, name = _('Scan Zone Left'),																 category = {_('Throttle Grip'), _('HOTAS'), _('Sensors')}},
{combos = {{key = '/', reformers = {'RShift'}}}, pressed = iCommandSelecterRight, up = iCommandSelecterStop,name = _('Scan Zone Right'),															 category = {_('Throttle Grip'), _('HOTAS'), _('Sensors')}},
{combos = {{key = '='}}, down = iCommandPlaneZoomIn,                                                        name = _('Display Zoom In'),															 category = {_('Throttle Grip'), _('HOTAS'), _('Sensors')}},
{combos = {{key = '-'}}, down = iCommandPlaneZoomOut,                                                       name = _('Display Zoom Out'),                 											 category = {_('Throttle Grip'), _('HOTAS'), _('Sensors')}},
{combos = {{key = '-', reformers = {'RCtrl'}}}, down = iCommandDecreaseRadarScanArea,                       name = _('Radar Scan Zone / Target Size Decreas'),										 category = {_('Throttle Grip'), _('HOTAS'), _('Sensors')}},
{combos = {{key = '=', reformers = {'RCtrl'}}}, down = iCommandIncreaseRadarScanArea,                       name = _('Radar Scan Zone / Target Size Increase'), 									 category = {_('Throttle Grip'), _('HOTAS'), _('Sensors')}},
{combos = {{key = '=', reformers = {'RAlt'}}}, pressed = iCommandPlaneIncreaseBase_Distance, up = iCommandPlaneStopBase_Distance, name = _('Target Specified Size Increase'), 						 category = {_('Throttle Grip'), _('HOTAS'), _('Sensors')}},
{combos = {{key = '-', reformers = {'RAlt'}}}, pressed = iCommandPlaneDecreaseBase_Distance, up = iCommandPlaneStopBase_Distance, name = _('Target Specified Size Decrease'), 						 category = {_('Throttle Grip'), _('HOTAS'), _('Sensors')}},
-- Navigation
{combos = {{key = '`', reformers = {'LCtrl'}}},		down = iCommandPlaneChangeTarget,			name = _('Next Waypoint, Airfield Or Target'),		category = {_('Throttle Quadrant'), _('HOTAS'), _('Sensors')}},
{combos = {{key = '`', reformers = {'LShift'}}},	down = iCommandPlaneUFC_STEER_DOWN,			name = _('Previous Waypoint, Airfield Or Target'),	category = {_('Throttle Quadrant'), _('HOTAS'), _('Sensors')}},
-- Countermeasures
{combos = {{key = 'Delete'}}, 						down = Keys.CountermeasureRelease,	 		name = _('Countermeasure Dispense'), 			category = {_('Throttle Grip'), _('HOTAS')}},
{												    down = iCommandActiveJamming,				name = _('ECM'), 								category = {_('Throttle Grip'), _('HOTAS')}},--136
-- Throttle Gripen
{combos = {{key = 'Num+'}},	pressed = Keys.GripenThrottleIncrease, up = Keys.GripenThrottleStop, name = _('Throttle Up'),						category = {_('Throttle Grip'), _('HOTAS')}},
{combos = {{key = 'Num-'}},	pressed = Keys.GripenThrottleDecrease, up = Keys.GripenThrottleStop, name = _('Throttle Down'),						category = {_('Throttle Grip'), _('HOTAS')}},
{down = AUTOTHROTTLE,																			 name = _('Autothrottle - Toggle'), 			category = {_('Throttle Grip'), _('HOTAS'), _('Autopilot')}},			
{down = ATAOA_1214,																				 name = _('Autothrottle - Toggle AoA 12/14'),	category = {_('Throttle Grip'), _('HOTAS'), _('Autopilot')}},			
-- Throttle FC3
{combos = {{key = 'Home', reformers = {'RAlt'}}}, 	down = Keys.ThrottleStop,	               	name = _('Throttle Stop'),						category = {_('Throttle Grip'), _('HOTAS')},			 	value_down =  1.0,		value_up = 0.0},
{combos = {{key = 'PageUp'}},						down = iCommandPlaneAUTIncreaseRegime,		name = _('Throttle Step Up'),					category = {_('Throttle Grip'), _('HOTAS'), _('Flight Control')}},
{combos = {{key = 'PageDown'}},						down = iCommandPlaneAUTDecreaseRegime,		name = _('Throttle Step Down'),					category = {_('Throttle Grip'), _('HOTAS'), _('Flight Control')}},
-- Airbrakes
{combos = {{key = 'B'}},							down = iCommandPlaneAirBrake,				name = _('Airbrake'),							category = _('Throttle Grip'), _('HOTAS') , features = {"airbrake"}},
{combos = {{key = 'B', reformers = {'LShift'}}},	down = iCommandPlaneAirBrakeOn,				name = _('Airbrake On'),						category = _('Throttle Grip'), _('HOTAS') , features = {"airbrake"}},
{combos = {{key = 'B', reformers = {'LCtrl'}}},		down = iCommandPlaneAirBrakeOff,			name = _('Airbrake Off'),						category = _('Throttle Grip'), _('HOTAS') , features = {"airbrake"}},
---------------------------------------------
-- Left Lower Pannel ------------------------
---------------------------------------------
-- Ligths
{down = Keys.TaxiLights,	               													  name = _('Taxi Lights'), 			  			 category = _('Left Lower Pannel')},
{down = Keys.LandingTaxiLightsOff,	               											  name = _('Landing and Taxi Lights Off'), 		 category = _('Left Lower Pannel')},
{down = Keys.LandingLights,	               													  name = _('Landing Lights'), 			  		 category = _('Left Lower Pannel')},
{down = Keys.CovertLights,	               													  name = _('Covert Lights'), 			  		 category = _('Left Lower Pannel')},	
-- AAR                                                                                                                                       
{down = Keys.AARProbeCover,	               													  name = _('AAR Probe Cover'), 			  		 category = _('Left Lower Pannel')},
{down = Keys.AARProbe,	               														  name = _('AAR Probe')	, 			  			 category = _('Left Lower Pannel')}, 	
-- RWR
{combos = {{key = 'R', reformers = {'RShift'}}}, down = iCommandChangeRWRMode, 				  name = _('RWR/SPO Mode Select'), 				 category = _('Left Lower Pannel')},
{combos = {{key = ',', reformers = {'RAlt'}}}, down = iCommandPlaneThreatWarnSoundVolumeDown, name = _('RWR/SPO Sound Signals Volume Down'), category = _('Left Lower Pannel')},
{combos = {{key = '.', reformers = {'RAlt'}}}, down = iCommandPlaneThreatWarnSoundVolumeUp,   name = _('RWR/SPO Sound Signals Volume Up'), 	 category = _('Left Lower Pannel')},
---------------------------------------------
-- Left Control Pannel ----------------------
---------------------------------------------
{combos = {{key = 'G', reformers = {'LCtrl'}}}, 	down = Keys.GearUp,	    				 name = _('Landing Gear Up'),                    category = _('Left Control Pannel')},
{combos = {{key = 'G', reformers = {'LShift'}}}, 	down = Keys.GearDown,                    name = _('Landing Gear Down'),                  category = _('Left Control Pannel')},
{down = Keys.Start,	                				up = Keys.Start,		                 name = _('Engine Start'), 						 category = _('Left Control Pannel'), value_down =  1.0, value_up = 0.0},
---------------------------------------------
-- Instrument Panel -------------------------
---------------------------------------------
-- Autopilot
{combos = {{key = 'A'}, {key = '1', reformers = {'LAlt'}}}, down = iCommandPlaneAutopilot,   name = _('Autopilot - Attitude Hold'), 		category = {_('Autopilot'), _('Instrument Panel')}},
{combos = {{key = 'H'}, {key = '2', reformers = {'LAlt'}}}, down = iCommandPlaneStabHbar, 	 name = _('Autopilot - Altitude Hold'), 		category = {_('Autopilot'), _('Instrument Panel')}},
{combos = {{key = '9', 				reformers = {'LAlt'}}}, down = iCommandPlaneStabCancel,  name = _('Autopilot Disengage'), 				category = {_('Autopilot'), _('Instrument Panel')}},
-- Other
{combos = {{key = 'N', reformers = {'RShift'}}},	down = iCommandPlaneResetMasterWarning,	 name = _('Audible Warning Reset'),				category = _('Instrument Panel')},
-- Left Display (LD)
{down = Keys.LDSK_1, 		     name = _('LD Softkey 1'),		category = {_('Instrument Panel'), _('Left Display (LD)')}},
{down = Keys.LDSK_2, 		     name = _('LD Softkey 2'),		category = {_('Instrument Panel'), _('Left Display (LD)')}},
{down = Keys.LDSK_3, 		     name = _('LD Softkey 3'),		category = {_('Instrument Panel'), _('Left Display (LD)')}},
{down = Keys.LDSK_4, 		     name = _('LD Softkey 4'),		category = {_('Instrument Panel'), _('Left Display (LD)')}},
{down = Keys.LDSK_5, 		     name = _('LD Softkey 5'),		category = {_('Instrument Panel'), _('Left Display (LD)')}},
{down = Keys.LDSK_6, 		     name = _('LD Softkey 6'),		category = {_('Instrument Panel'), _('Left Display (LD)')}},
{down = Keys.LDSK_7, 		     name = _('LD Softkey 7'),		category = {_('Instrument Panel'), _('Left Display (LD)')}},  
{down = Keys.LDSK_8, 		     name = _('LD Softkey 8'),		category = {_('Instrument Panel'), _('Left Display (LD)')}},
{down = Keys.LDSK_9, 		     name = _('LD Softkey 9'),		category = {_('Instrument Panel'), _('Left Display (LD)')}},
{down = Keys.LDSK_10,		     name = _('LD Softkey 10'),		category = {_('Instrument Panel'), _('Left Display (LD)')}},
{down = Keys.LDSK_11,		     name = _('LD Softkey 11'),		category = {_('Instrument Panel'), _('Left Display (LD)')}},
{down = Keys.LDSK_12,		     name = _('LD Softkey 12'),		category = {_('Instrument Panel'), _('Left Display (LD)')}},
{down = Keys.LDSK_13,		     name = _('LD Softkey 13'),		category = {_('Instrument Panel'), _('Left Display (LD)')}}, 
{down = Keys.LDSK_14,		     name = _('LD Softkey 14'),		category = {_('Instrument Panel'), _('Left Display (LD)')}},
{down = Keys.LDSK_15,		     name = _('LD Softkey 15'),		category = {_('Instrument Panel'), _('Left Display (LD)')}},
{down = Keys.LDSK_16,		     name = _('LD Softkey 16'),		category = {_('Instrument Panel'), _('Left Display (LD)')}},
{down = Keys.LDSK_17,		     name = _('LD Softkey 17'),		category = {_('Instrument Panel'), _('Left Display (LD)')}},
{down = Keys.LDSK_18,		     name = _('LD Softkey 18'),		category = {_('Instrument Panel'), _('Left Display (LD)')}},
{down = Keys.LDSK_19,		     name = _('LD Softkey 19'),		category = {_('Instrument Panel'), _('Left Display (LD)')}},
{down = Keys.LDSK_20,		     name = _('LD Softkey 20'),		category = {_('Instrument Panel'), _('Left Display (LD)')}},
{down = Keys.LD_Brightness_Up,   name = _('LD Brightness +'),	category = {_('Instrument Panel'), _('Left Display (LD)')}},
{down = Keys.LD_Brightness_Down, name = _('LD Brightness -'),	category = {_('Instrument Panel'), _('Left Display (LD)')}},
{down = Keys.LD_Contrast_Up,     name = _('LD Contrast +'),		category = {_('Instrument Panel'), _('Left Display (LD)')}},
{down = Keys.LD_Contrast_Down,   name = _('LD Contrast -'),		category = {_('Instrument Panel'), _('Left Display (LD)')}},
-- Center Display (CD)
{down = Keys.CDSK_1, 			 name = _('CD Softkey 1'),		category = {_('Instrument Panel'), _('Center Display (CD)')}},	
{down = Keys.CDSK_2, 			 name = _('CD Softkey 2'),		category = {_('Instrument Panel'), _('Center Display (CD)')}},
{down = Keys.CDSK_3, 			 name = _('CD Softkey 3'),		category = {_('Instrument Panel'), _('Center Display (CD)')}},
{down = Keys.CDSK_4, 			 name = _('CD Softkey 4'),		category = {_('Instrument Panel'), _('Center Display (CD)')}},
{down = Keys.CDSK_5, 			 name = _('CD Softkey 5'),		category = {_('Instrument Panel'), _('Center Display (CD)')}},
{down = Keys.CDSK_6, 			 name = _('CD Softkey 6'),		category = {_('Instrument Panel'), _('Center Display (CD)')}},
{down = Keys.CDSK_7, 			 name = _('CD Softkey 7'),		category = {_('Instrument Panel'), _('Center Display (CD)')}},                     
{down = Keys.CDSK_8, 			 name = _('CD Softkey 8'),		category = {_('Instrument Panel'), _('Center Display (CD)')}},
{down = Keys.CDSK_9, 			 name = _('CD Softkey 9'),		category = {_('Instrument Panel'), _('Center Display (CD)')}},
{down = Keys.CDSK_10,			 name = _('CD Softkey 10'),		category = {_('Instrument Panel'), _('Center Display (CD)')}},
{down = Keys.CDSK_11,			 name = _('CD Softkey 11'),		category = {_('Instrument Panel'), _('Center Display (CD)')}},
{down = Keys.CDSK_12,			 name = _('CD Softkey 12'),		category = {_('Instrument Panel'), _('Center Display (CD)')}},
{down = Keys.CDSK_13,			 name = _('CD Softkey 13'),		category = {_('Instrument Panel'), _('Center Display (CD)')}},                   
{down = Keys.CDSK_14,			 name = _('CD Softkey 14'),		category = {_('Instrument Panel'), _('Center Display (CD)')}},
{down = Keys.CDSK_15,			 name = _('CD Softkey 15'),		category = {_('Instrument Panel'), _('Center Display (CD)')}},
{down = Keys.CDSK_16,			 name = _('CD Softkey 16'),		category = {_('Instrument Panel'), _('Center Display (CD)')}},
{down = Keys.CDSK_17,			 name = _('CD Softkey 17'),		category = {_('Instrument Panel'), _('Center Display (CD)')}},
{down = Keys.CDSK_18,			 name = _('CD Softkey 18'),		category = {_('Instrument Panel'), _('Center Display (CD)')}},
{down = Keys.CDSK_19,			 name = _('CD Softkey 19'),		category = {_('Instrument Panel'), _('Center Display (CD)')}},
{down = Keys.CDSK_20,			 name = _('CD Softkey 20'),		category = {_('Instrument Panel'), _('Center Display (CD)')}},
{down = Keys.CD_Brightness_Up,	 name = _('CD Brightness +'), 	category = {_('Instrument Panel'), _('Center Display (CD)')}},
{down = Keys.CD_Brightness_Down, name = _('CD Brightness -'),	category = {_('Instrument Panel'), _('Center Display (CD)')}},
{down = Keys.CD_Contrast_Up, 	 name = _('CD Contrast +'), 	category = {_('Instrument Panel'), _('Center Display (CD)')}},
{down = Keys.CD_Contrast_Down,   name = _('CD Contrast -'), 	category = {_('Instrument Panel'), _('Center Display (CD)')}},
-- Right Display (RD)
{down = Keys.RD_Brightness_Up,   name = _('RD Brightness +'), 	category = {_('Instrument Panel'), _('Right  Display (RD)')}},
{down = Keys.RD_Brightness_Down, name = _('RD Brightness -'), 	category = {_('Instrument Panel'), _('Right  Display (RD)')}},
{down = Keys.RD_Contrast_Up,     name = _('RD Contrast +'),   	category = {_('Instrument Panel'), _('Right  Display (RD)')}},
{down = Keys.RD_Contrast_Down,   name = _('RD Contrast -'),   	category = {_('Instrument Panel'), _('Right  Display (RD)')}},
---------------------------------------------
-- Upfront Control Panel (UCP) --------------
---------------------------------------------
-- Modes
{combos = {{key = 'F'}}, 																down = LANDING_MODE, 				 name = _('Landing mode - Toggle'), 		 category = _('Upfront Control Panel')},
-- Communications
{combos = {{key = 'I', reformers = {'LWin'}}},											down = iCommandAWACSTankerBearing,	 name = _('Request AWACS Available Tanker'), category = _('Upfront Control Panel')},
{combos = {{key = '\\', reformers = {'RShift'}}, {key = 'M', reformers = {'RShift'}}},	down = iCommandToggleReceiveMode,	 name = _('Receive Mode'),					 category = _('Upfront Control Panel')},
-- HUD
{combos = {{key = 'K', reformers = {'RCtrl','RShift'}}}, pressed = iCommandHUDBrightnessUp,									 name = _('HUD Brightness up'),				 category = _('Upfront Control Panel') , features = {"HUDbrightness"}},
{combos = {{key = 'K', reformers = {'RShift','RAlt'}}}, pressed = iCommandHUDBrightnessDown,								 name = _('HUD Brightness down'),			 category = _('Upfront Control Panel') , features = {"HUDbrightness"}},
{combos = {{key = 'K', reformers = {'RCtrl','RAlt'}}},		down = iCommandBrightnessILS,									 name = _('HUD Color'),						 category = _('Upfront Control Panel') , features = {"HUDcolor"}},
---------------------------------------------
-- Lower Right Pannel -----------------------
---------------------------------------------
{combos = {{key = 'P', reformers = {'RCtrl'}}}, 	down = P_BRAKE, 														 name = _('Parking Brake'),       category = _('Right Aft Console')},		
---------------------------------------------
-- Upper Right Pannel -----------------------
---------------------------------------------
{down = Keys.Main,	                													  									 name = _('Main Power'), 		  category = _('Upper Right Pannel'), value_down =  1.0, value_up = 0.0},
{down = Keys.Fuel,	                													  									 name = _('Fuel'), 				  category = _('Upper Right Pannel'), value_down =  1.0, value_up = 0.0},
{down = Keys.APU,	                													  									 name = _('APU'), 				  category = _('Upper Right Pannel'), value_down =  1.0, value_up = 0.0},
{down = Keys.FuelCover,	            													  									 name = _('Fuel Cover'), 		  category = _('Upper Right Pannel'), value_down =  1.0, value_up = 0.0},
{down = Keys.MassSafe,	                       																				 name = _('MASS Safe'), 		  category = _('Upper Right Pannel')},			 	
{combos = {{key = 'M', reformers = {'LCtrl'}}}, 	down = Keys.MassStby,	              									 name = _('MASS Standby'), 		  category = _('Upper Right Pannel')},			 	
{combos = {{key = 'M', reformers = {'LShift'}}}, 	down = Keys.MassLive,	              									 name = _('MASS Live'), 		  category = _('Upper Right Pannel')},
{combos = {{key = 'R', reformers = {'LAlt'}}}, 		down = iCommandPlaneJettisonFuelTanks,									 name = _('Jettison Fuel Tanks'), category = _('Upper Right Pannel')},
{combos = {{key = 'W', reformers = {'LCtrl'}}},		down = iCommandPlaneJettisonWeapons,up = iCommandPlaneJettisonWeaponsUp, name = _('Weapons Jettison'), 	  category = _('Upper Right Pannel')},
})
return res