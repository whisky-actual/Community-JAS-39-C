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

ignore_features(res.keyCommands,{
"dragchute"
})

join(res.keyCommands,{

-- Gripen Weapons
{down = Keys.TriggerAA,	     		up = Keys.TriggerAA,      	name = _('Trigger'),      								category = _('Gripen Weapons'), 			value_down =  1.0,		value_up = 0.0},
{down = Keys.TriggerSafe,	 									name = _('Trigger Safe - Toggle'), 						category = _('Gripen Weapons')},
{down = Keys.TriggerSafeHold, 		up = Keys.TriggerSafeHold,	name = _('Trigger Safe - Hold'), 						category = _('Gripen Weapons'), 			value_down =  1.0,		value_up = 0.0},
{down = Keys.CannonMode,	 									name = _('Cannon Mode'), 								category = _('Gripen Weapons')},
{down = Keys.CountermeasureRelease,	 							name = _('Countermeasure Dispense'), 					category = _('Gripen Weapons')},
			
-- Gripen Systems						
{down = P_BRAKE, 												name = _('Parking Brake - Toggle'), 	                category = _('Gripen Systems')},			
{down = BrakesON, 					up = BrakesOFF,   			name = _('Wheel Brakes - Both'), 	               		category = _('Gripen Systems')},			
{down = AUTOTHROTTLE,											name = _('Autothrottle - Toggle'), 						category = _('Gripen Systems')},			
{down = ATAOA_1214,												name = _('Autothrottle - Toggle AoA 12/14'),			category = _('Gripen Systems')},			
{down = Keys.Start,	                up = Keys.Start,			name = _('Engine Start'), 								category = _('Gripen Systems'), 		 	value_down =  1.0,		value_up = 0.0},
{down = Keys.Main,	                       						name = _('Main Power'), 			  					category = _('Gripen Systems'),			 	value_down =  1.0,		value_up = 0.0},
{down = Keys.Fuel,	                       						name = _('Fuel'), 					  					category = _('Gripen Systems'),			 	value_down =  1.0,		value_up = 0.0},
{down = Keys.APU,	                       						name = _('APU'), 					  					category = _('Gripen Systems'),			 	value_down =  1.0,		value_up = 0.0},
{down = Keys.FuelCover,	                   						name = _('Fuel Cover'), 			  					category = _('Gripen Systems'),			 	value_down =  1.0,		value_up = 0.0},
{down = Keys.ThrottleStop,	               						name = _('Throttle Stop'), 			  					category = _('Gripen Systems'),			 	value_down =  1.0,		value_up = 0.0},
{down = Keys.MassSafe,	                       					name = _('MASS Safe'), 					  				category = _('Gripen Systems')},			 	
{down = Keys.MassStby,	                   						name = _('MASS Standby'), 			  					category = _('Gripen Systems')},			 	
{down = Keys.MassLive,	               							name = _('MASS Live'), 			  						category = _('Gripen Systems')},
{down = Keys.TaxiLights,	               						name = _('Taxi Lights'), 			  					category = _('Gripen Systems')},
{down = Keys.LandingTaxiLightsOff,	               				name = _('Landing and Taxi Lights Off'), 				category = _('Gripen Systems')},
{down = Keys.LandingLights,	               						name = _('Landing Lights'), 			  				category = _('Gripen Systems')},
{down = Keys.CovertLights,	               						name = _('Covert Lights'), 			  					category = _('Gripen Systems')},	
{down = Keys.AARProbeCover,	               						name = _('AAR Probe Cover'), 			  				category = _('Gripen Systems')},
{down = Keys.AARProbe,	               							name = _('AAR Probe')	, 			  					category = _('Gripen Systems')}, 	
{down = Keys.SeatEject,	               							name = _('Eject')	, 			  						category = _('Gripen Systems')}, 

-- Gripen Flight Control					
{down = Keys.GearUp,	                   						name = _('Landing Gear Up'),                      		category = _('Gripen Flight Control')},
{down = Keys.GearDown,	                   						name = _('Landing Gear Down'),                    		category = _('Gripen Flight Control')},
{down = Keys.CanopyLever,	               						name = _('Canopy'),                    			  		category = _('Gripen Flight Control')},

-- Gripen Modes					
{down = LANDING_MODE, 											name = _('Landing mode - Toggle'), 						category = _('Gripen Modes')},
{down = Keys.NoHotas, 											name = _('I dont have a Hotas'), 						category = _('Gripen Modes')},
-- MFDS ==================================================================================================================================================
--LEFT DISPLAY ==========
-- Left row
{down = Keys.LDSK_1,  name = _('LD Softkey 1'), category = _('MFD')},	-- LEFT DISPLAY SOFT KEY 1
{down = Keys.LDSK_2,  name = _('LD Softkey 2'), category = _('MFD')},
{down = Keys.LDSK_3,  name = _('LD Softkey 3'), category = _('MFD')},
{down = Keys.LDSK_4,  name = _('LD Softkey 4'), category = _('MFD')},
{down = Keys.LDSK_5,  name = _('LD Softkey 5'), category = _('MFD')},
{down = Keys.LDSK_6,  name = _('LD Softkey 6'), category = _('MFD')},
{down = Keys.LDSK_7,  name = _('LD Softkey 7'), category = _('MFD')},
-- BottoKeys.m row              LD         
{down = Keys.LDSK_8,  name = _('LD Softkey 8'), category = _('MFD')},
{down = Keys.LDSK_9,  name = _('LD Softkey 9'), category = _('MFD')},
{down = Keys.LDSK_10, name = _('LD Softkey 10'), category = _('MFD')},
{down = Keys.LDSK_11, name = _('LD Softkey 11'), category = _('MFD')},
{down = Keys.LDSK_12, name = _('LD Softkey 12'), category = _('MFD')},
{down = Keys.LDSK_13, name = _('LD Softkey 13'), category = _('MFD')},
-- RightKeys. row               LD         
{down = Keys.LDSK_14, name = _('LD Softkey 14'), category = _('MFD')},
{down = Keys.LDSK_15, name = _('LD Softkey 15'), category = _('MFD')},
{down = Keys.LDSK_16, name = _('LD Softkey 16'), category = _('MFD')},
{down = Keys.LDSK_17, name = _('LD Softkey 17'), category = _('MFD')},
{down = Keys.LDSK_18, name = _('LD Softkey 18'), category = _('MFD')},
{down = Keys.LDSK_19, name = _('LD Softkey 19'), category = _('MFD')},
{down = Keys.LDSK_20, name = _('LD Softkey 20'), category = _('MFD')},
--Brightness
{down = Keys.LD_Brightness_Up, name = _('LD Brightness +'), category = _('MFD')},
{down = Keys.LD_Brightness_Down, name = _('LD Brightness -'), category = _('MFD')},
--Contrast 
{down = Keys.LD_Contrast_Up, name = _('LD Contrast +'), category = _('MFD')},
{down = Keys.LD_Contrast_Down, name = _('LD Contrast -'), category = _('MFD')},

--CENTER DISPLAY ==========
-- Left row
{down = Keys.CDSK_1,  name = _('CD Softkey 1'), category = _('MFD')},	
{down = Keys.CDSK_2,  name = _('CD Softkey 2'), category = _('MFD')},
{down = Keys.CDSK_3,  name = _('CD Softkey 3'), category = _('MFD')},
{down = Keys.CDSK_4,  name = _('CD Softkey 4'), category = _('MFD')},
{down = Keys.CDSK_5,  name = _('CD Softkey 5'), category = _('MFD')},
{down = Keys.CDSK_6,  name = _('CD Softkey 6'), category = _('MFD')},
{down = Keys.CDSK_7,  name = _('CD Softkey 7'), category = _('MFD')},
-- Bottom row                       
{down = Keys.CDSK_8,  name = _('CD Softkey 8'), category = _('MFD')},
{down = Keys.CDSK_9,  name = _('CD Softkey 9'), category = _('MFD')},
{down = Keys.CDSK_10, name = _('CD Softkey 10'), category = _('MFD')},
{down = Keys.CDSK_11, name = _('CD Softkey 11'), category = _('MFD')},
{down = Keys.CDSK_12, name = _('CD Softkey 12'), category = _('MFD')},
{down = Keys.CDSK_13, name = _('CD Softkey 13'), category = _('MFD')},
-- Right row                      
{down = Keys.CDSK_14, name = _('CD Softkey 14'), category = _('MFD')},
{down = Keys.CDSK_15, name = _('CD Softkey 15'), category = _('MFD')},
{down = Keys.CDSK_16, name = _('CD Softkey 16'), category = _('MFD')},
{down = Keys.CDSK_17, name = _('CD Softkey 17'), category = _('MFD')},
{down = Keys.CDSK_18, name = _('CD Softkey 18'), category = _('MFD')},
{down = Keys.CDSK_19, name = _('CD Softkey 19'), category = _('MFD')},
{down = Keys.CDSK_20, name = _('CD Softkey 20'), category = _('MFD')},
--Brightness
{down = Keys.CD_Brightness_Up, name = _('CD Brightness +'), category = _('MFD')},
{down = Keys.CD_Brightness_Down, name = _('CD Brightness -'), category = _('MFD')},
--Contrast 
{down = Keys.CD_Contrast_Up, name = _('CD Contrast +'), category = _('MFD')},
{down = Keys.CD_Contrast_Down, name = _('CD Contrast -'), category = _('MFD')},
------- FC3 BINDINGS ---------

-- General (Gameplay)
-- {combos = {{key = 'U'}},							down = iCommandPlaneShipTakeOff,			name = _('Ship Take Off Position'),		category = _('General') , features = {"shiptakeoff"}},
{combos = {{key = 'P', reformers = {'RShift'}}},	down = iCommandCockpitShowPilotOnOff,		name = _('Show Pilot Body'),			category = _('General')},

-- Flight Control
{combos = {{key = 'Up'}},		down = iCommandPlaneUpStart,			up = iCommandPlaneUpStop,			name = _('Aircraft Pitch Down'),	category = _('Flight Control')},
{combos = {{key = 'Down'}},		down = iCommandPlaneDownStart,			up = iCommandPlaneDownStop,			name = _('Aircraft Pitch Up'),		category = _('Flight Control')},
{combos = {{key = 'Left'}},		down = iCommandPlaneLeftStart,			up = iCommandPlaneLeftStop,			name = _('Aircraft Bank Left'),		category = _('Flight Control')},
{combos = {{key = 'Right'}},	down = iCommandPlaneRightStart,			up = iCommandPlaneRightStop,		name = _('Aircraft Bank Right'),	category = _('Flight Control')},
{combos = {{key = 'Z'}},		down = iCommandPlaneLeftRudderStart,	up = iCommandPlaneLeftRudderStop,	name = _('Aircraft Rudder Left'),	category = _('Flight Control')},
{combos = {{key = 'X'}},		down = iCommandPlaneRightRudderStart,	up = iCommandPlaneRightRudderStop,	name = _('Aircraft Rudder Right'),	category = _('Flight Control')},

{combos = {{key = '.', reformers = {'RCtrl'}}},	pressed = iCommandPlaneTrimUp,			up = iCommandPlaneTrimStop, name = _('Trim: Nose Up'),			category = _('Flight Control')},
{combos = {{key = ';', reformers = {'RCtrl'}}},	pressed = iCommandPlaneTrimDown,		up = iCommandPlaneTrimStop, name = _('Trim: Nose Down'),		category = _('Flight Control')},
{combos = {{key = ',', reformers = {'RCtrl'}}},	pressed = iCommandPlaneTrimLeft,		up = iCommandPlaneTrimStop, name = _('Trim: Left Wing Down'),	category = _('Flight Control')},
{combos = {{key = '/', reformers = {'RCtrl'}}},	pressed = iCommandPlaneTrimRight,		up = iCommandPlaneTrimStop, name = _('Trim: Right Wing Down'),	category = _('Flight Control')},
{combos = {{key = 'Z', reformers = {'RCtrl'}}},	pressed = iCommandPlaneTrimLeftRudder,	up = iCommandPlaneTrimStop, name = _('Trim: Rudder Left'),		category = _('Flight Control')},
{combos = {{key = 'X', reformers = {'RCtrl'}}},	pressed = iCommandPlaneTrimRightRudder,	up = iCommandPlaneTrimStop, name = _('Trim: Rudder Right'),		category = _('Flight Control')},

{combos = {{key = 'Num+'}}, 						pressed = iCommandThrottleIncrease,		up = iCommandThrottleStop,  name = _('Throttle Up'),		category = _('Flight Control')},
{combos = {{key = 'Num-'}}, 						pressed = iCommandThrottleDecrease,		up = iCommandThrottleStop,  name = _('Throttle Down'),		category = _('Flight Control')},
-- {combos = {{key = 'Num+', reformers = {'RAlt'}}}, 	pressed = iCommandThrottle1Increase,	up = iCommandThrottle1Stop, name = _('Throttle Left Up'),	category = _('Flight Control')},
-- {combos = {{key = 'Num-', reformers = {'RAlt'}}}, 	pressed = iCommandThrottle1Decrease,	up = iCommandThrottle1Stop, name = _('Throttle Left Down'), category = _('Flight Control')},
-- {combos = {{key = 'Num+', reformers = {'RShift'}}}, pressed = iCommandThrottle2Increase,	up = iCommandThrottle2Stop, name = _('Throttle Right Up'),	category = _('Flight Control')},
-- {combos = {{key = 'Num-', reformers = {'RShift'}}}, pressed = iCommandThrottle2Decrease,	up = iCommandThrottle2Stop, name = _('Throttle Right Down'), category = _('Flight Control')},

{combos = {{key = 'PageUp'}},							down = iCommandPlaneAUTIncreaseRegime,		name = _('Throttle Step Up'),			category = _('Flight Control')},
{combos = {{key = 'PageDown'}},							down = iCommandPlaneAUTDecreaseRegime,		name = _('Throttle Step Down'),			category = _('Flight Control')},
-- {combos = {{key = 'PageUp', reformers = {'RAlt'}}},		down = iCommandPlaneAUTIncreaseRegimeLeft,	name = _('Throttle Step Up Left'),		category = _('Flight Control')},
-- {combos = {{key = 'PageDown', reformers = {'RAlt'}}},	down = iCommandPlaneAUTDecreaseRegimeLeft,	name = _('Throttle Step Down Left'),	category = _('Flight Control')},
-- {combos = {{key = 'PageUp', reformers = {'RShift'}}},	down = iCommandPlaneAUTIncreaseRegimeRight, name = _('Throttle Step Up Right'),		category = _('Flight Control')},
-- {combos = {{key = 'PageDown', reformers = {'RShift'}}}, down = iCommandPlaneAUTDecreaseRegimeRight, name = _('Throttle Step Down Right'),	category = _('Flight Control')},

-- Systems
-- {combos = {{key = 'L', reformers = {'RShift'}}},	down = iCommandPowerOnOff,					name = _('Electric Power Switch'),					category = _('Systems')},
{combos = {{key = 'B'}},							down = iCommandPlaneAirBrake,				name = _('Airbrake'),								category = _('Systems') , features = {"airbrake"}},
{combos = {{key = 'B', reformers = {'LShift'}}},	down = iCommandPlaneAirBrakeOn,				name = _('Airbrake On'),							category = _('Systems') , features = {"airbrake"}},
{combos = {{key = 'B', reformers = {'LCtrl'}}},		down = iCommandPlaneAirBrakeOff,			name = _('Airbrake Off'),							category = _('Systems') , features = {"airbrake"}},
{combos = {{key = 'T'}},							down = iCommandPlaneWingtipSmokeOnOff,		name = _('Smoke'),									category = _('Systems')},
-- {combos = {{key = 'L'}},							down = iCommandPlaneCockpitIllumination,	name = _('Illumination Cockpit'),					category = _('Systems')},
-- {combos = {{key = 'L', reformers = {'RCtrl'}}},		down = iCommandPlaneLightsOnOff,			name = _('Navigation lights'),						category = _('Systems')},
-- {combos = {{key = 'L', reformers = {'RAlt'}}},		down = iCommandPlaneHeadLightOnOff,			name = _('Gear Light Near/Far/Off'),				category = _('Systems')},
--{combos = {{key = 'F'}},							down = iCommandPlaneFlaps,					name = _('Flaps Up/Down'),							category = _('Systems')},
--{combos = {{key = 'F', reformers = {'LShift'}}},	down = iCommandPlaneFlapsOn,				name = _('Flaps Landing Position'),					category = _('Systems')},
--{combos = {{key = 'F', reformers = {'LCtrl'}}},	down = iCommandPlaneFlapsOff,				name = _('Flaps Up'),								category = _('Systems')},
-- {combos = {{key = 'G'}},							down = iCommandPlaneGear,					name = _('Landing Gear Up/Down'),					category = _('Systems')},
-- {combos = {{key = 'G', reformers = {'LCtrl'}}},		down = iCommandPlaneGearUp,					name = _('Landing Gear Up'),						category = _('Systems')},
-- {combos = {{key = 'G', reformers = {'LShift'}}},	down = iCommandPlaneGearDown,				name = _('Landing Gear Down'),						category = _('Systems')},
-- {combos = {{key = 'W'}},							down = iCommandPlaneWheelBrakeOn, up = iCommandPlaneWheelBrakeOff, name = _('Wheel Brake On'),	category = _('Systems')},
-- {combos = {{key = 'C', reformers = {'LCtrl'}}},		down = iCommandPlaneFonar,					name = _('Canopy Open/Close'),						category = _('Systems')},
--{combos = {{key = 'P'}},							down = iCommandPlaneParachute,				name = _('Dragging Chute'),							category = _('Systems') , features = {"dragchute"}},
{combos = {{key = 'N', reformers = {'RShift'}}},	down = iCommandPlaneResetMasterWarning,		name = _('Audible Warning Reset'),					category = _('Systems')},
{combos = {{key = 'W', reformers = {'LCtrl'}}},		down = iCommandPlaneJettisonWeapons,up = iCommandPlaneJettisonWeaponsUp, name = _('Weapons Jettison'), category = _('Systems')},
-- {combos = {{key = 'E', reformers = {'LCtrl'}}},		down = iCommandPlaneEject,					name = _('Eject (3 times)'),						category = _('Systems')},
-- {combos = {{key = 'C', reformers = {'RShift'}}},	down = iCommandFlightClockReset,			name = _('Flight Clock Start/Stop/Reset'),			category = _('Systems') , features = {"flightclock"}},
-- {													down = iCommandClockElapsedTimeReset,		name = _('Elapsed Time Clock Start/Stop/Reset'),	category = _('Systems') , features = {"flightclock"}},
-- {combos = {{key = 'Home', reformers = {'RShift'}}}, down = iCommandEnginesStart,				name = _('Engines Start'),							category = _('Systems')},
-- {combos = {{key = 'End', reformers = {'RShift'}}},	down = iCommandEnginesStop,					name = _('Engines Stop'),							category = _('Systems')},
-- {combos = {{key = 'Home', reformers = {'RAlt'}}},	down = iCommandLeftEngineStart,				name = _('Engine Left Start'),						category = _('Systems') , features = {"TwinEngineAircraft"}},
-- {combos = {{key = 'End', reformers = {'RAlt'}}},	down = iCommandLeftEngineStop,				name = _('Engine Left Stop'),						category = _('Systems') , features = {"TwinEngineAircraft"}},
-- {combos = {{key = 'Home', reformers = {'RCtrl'}}},	down = iCommandRightEngineStart,			name = _('Engine Right Start'),						category = _('Systems') , features = {"TwinEngineAircraft"}},
-- {combos = {{key = 'End', reformers = {'RCtrl'}}},	down = iCommandRightEngineStop,				name = _('Engine Right Stop'),						category = _('Systems') , features = {"TwinEngineAircraft"}},
{combos = {{key = 'K', reformers = {'RCtrl'}}},		down = iCommandBrightnessILS,				name = _('HUD Color'),								category = _('Systems') , features = {"HUDcolor"}},
{combos = {{key = 'K', reformers = {'RCtrl','RShift'}}}, pressed = iCommandHUDBrightnessUp,		name = _('HUD Brightness up'),						category = _('Systems') , features = {"HUDbrightness"}},
{combos = {{key = 'K', reformers = {'RShift','RAlt'}}}, pressed = iCommandHUDBrightnessDown,	name = _('HUD Brightness down'),					category = _('Systems') , features = {"HUDbrightness"}},
-- {combos = {{key = 'R'}},							down = iCommandPlaneFuelOn, up = iCommandPlaneFuelOff, name = _('Fuel Dump'),					category = _('Systems') , features = {"fueldump"}},

-- {combos = {{key = '=', reformers = {'RShift'}}}, pressed = iCommandAltimeterPressureIncrease,	up = iCommandAltimeterPressureStop, name = _('Altimeter Pressure Increase'), category = _('Systems')},
-- {combos = {{key = '-', reformers = {'RShift'}}}, pressed = iCommandAltimeterPressureDecrease, up = iCommandAltimeterPressureStop, name = _('Altimeter Pressure Decrease'), category = _('Systems')},

-- Modes
{combos = {{key = '`', reformers = {'LCtrl'}}},		down = iCommandPlaneChangeTarget,			name = _('Next Waypoint, Airfield Or Target'),		category = _('Modes')},
{combos = {{key = '`', reformers = {'LShift'}}},	down = iCommandPlaneUFC_STEER_DOWN,			name = _('Previous Waypoint, Airfield Or Target'),	category = _('Modes')},
{combos = {{key = '1'}},							down = iCommandPlaneModeNAV,				name = _('(1) Navigation Modes'),					category = _('Modes')},

-- Weapons
-- {combos = {{key = 'Space'}},					down = iCommandPlaneFire,	up = iCommandPlaneFireOff,	name = _('Weapon Fire'),		category = _('Weapons')},
{combos = {{key = 'D'}},						down = iCommandPlaneChangeWeapon,						name = _('Weapon Change'),		category = _('Weapons')},
-- {combos = {{key = 'C'}},						down = iCommandPlaneModeCannon,							name = _('Cannon'),				category = _('Weapons')},
-- {combos = {{key = 'W', reformers = {'LAlt'}}},	down = iCommandPlaneLaunchPermissionOverride,			name = _('Launch Permission Override'), category = _('Weapons') , features = {"LaunchPermissionOverride"}},

-- Countermeasures
-- {combos = {{key = 'Q', reformers = {'LShift'}}},	down = iCommandPlaneDropSnar,			name = _('Countermeasures Continuously Dispense'),					category = _('Countermeasures') , features = {"Countermeasures"}},
-- {combos = {{key = 'Q'}},							down = iCommandPlaneDropSnarOnce, up = iCommandPlaneDropSnarOnceOff, name = _('Countermeasures Release'),	category = _('Countermeasures') , features = {"Countermeasures"}},
-- {combos = {{key = 'Delete'}},						down = iCommandPlaneDropFlareOnce,		name = _('Countermeasures Flares Dispense'),						category = _('Countermeasures') , features = {"Countermeasures"}},
-- {combos = {{key = 'Insert'}},						down = iCommandPlaneDropChaffOnce,		name = _('Countermeasures Chaff Dispense'),							category = _('Countermeasures') , features = {"Countermeasures"}},
-- {combos = {{key = 'E'}},							down = iCommandActiveJamming,			name = _('ECM'),													category = _('Countermeasures') , features = {"ECM"}},

-- Communications
{combos = {{key = 'I', reformers = {'LWin'}}},											down = iCommandAWACSTankerBearing,	name = _('Request AWACS Available Tanker'),	category = _('Communications')},
{combos = {{key = '\\', reformers = {'RShift'}}, {key = 'M', reformers = {'RShift'}}},	down = iCommandToggleReceiveMode,	name = _('Receive Mode'),					category = _('Communications')},

-- Cockpit Camera Motion (Передвижение камеры в кабине)
{combos = {{key = 'N', reformers = {'RAlt'}}},	down = iCommandViewLeftMirrorOn ,	up = iCommandViewLeftMirrorOff ,	name = _('Mirror Left On'),		category = _('View Cockpit') , features = {"Mirrors"}},
{combos = {{key = 'M', reformers = {'RAlt'}}},	down = iCommandViewRightMirrorOn,	up = iCommandViewRightMirrorOff,	name = _('Mirror Right On'),	category = _('View Cockpit') , features = {"Mirrors"}},
{combos = {{key = 'M' }},						down = iCommandToggleMirrors,											name = _('Toggle Mirrors'),		category = _('View Cockpit') , features = {"Mirrors"}},

-- Auto Lock On 
{combos = {{key = 'F5', reformers = {'RAlt'}}},		down = iCommandAutoLockOnNearestAircraft,		name = _('Auto lock on nearest aircraft'),			category = _('Simplifications')},
{combos = {{key = 'F6', reformers = {'RAlt'}}},		down = iCommandAutoLockOnCenterAircraft,		name = _('Auto lock on center aircraft'),			category = _('Simplifications')},
{combos = {{key = 'F7', reformers = {'RAlt'}}},		down = iCommandAutoLockOnNextAircraft,			name = _('Auto lock on next aircraft'),				category = _('Simplifications')},
{combos = {{key = 'F8', reformers = {'RAlt'}}},		down = iCommandAutoLockOnPreviousAircraft,		name = _('Auto lock on previous aircraft'),			category = _('Simplifications')},
{combos = {{key = 'F9', reformers = {'RAlt'}}},		down = iCommandAutoLockOnNearestSurfaceTarget,	name = _('Auto lock on nearest surface target'),	category = _('Simplifications')},
{combos = {{key = 'F10', reformers = {'RAlt'}}},	down = iCommandAutoLockOnCenterSurfaceTarget,	name = _('Auto lock on center surface target'),		category = _('Simplifications')},
{combos = {{key = 'F11', reformers = {'RAlt'}}},	down = iCommandAutoLockOnNextSurfaceTarget,		name = _('Auto lock on next surface target'),		category = _('Simplifications')},
{combos = {{key = 'F12', reformers = {'RAlt'}}},	down = iCommandAutoLockOnPreviousSurfaceTarget, name = _('Auto lock on previous surface target'),	category = _('Simplifications')},

-- Autopilot
{combos = {{key = 'A'}, {key = '1', reformers = {'LAlt'}}}, down = iCommandPlaneAutopilot, name = _('Autopilot - Attitude Hold'), category = _('Autopilot')},
{combos = {{key = 'H'}, {key = '2', reformers = {'LAlt'}}}, down = iCommandPlaneStabHbar, name = _('Autopilot - Altitude Hold'), category = _('Autopilot')},
{combos = {{key = '9', reformers = {'LAlt'}}}, down = iCommandPlaneStabCancel, name = _('Autopilot Disengage'), category = _('Autopilot')},
-- {combos = {{key = '4', reformers = {'LCtrl'}}}, down = iCommandHelicopter_PPR_button_T_up, name = _('CAS Pitch'), category = _('Autopilot')},
-- {combos = {{key = '5', reformers = {'LCtrl'}}}, down = iCommandHelicopter_PPR_button_K_up, name = _('CAS Roll'), category = _('Autopilot')},
-- {combos = {{key = '6', reformers = {'LCtrl'}}}, down = iCommandHelicopter_PPR_button_H_up, name = _('CAS Yaw'), category = _('Autopilot')},

--Flight Control
-- {combos = {{key = 'T', reformers = {'LAlt'}}}, down = iCommandPlaneTrimOn, up = iCommandPlaneTrimOff, name = _('T/O Trim'), category = _('Flight Control')},

-- Systems
-- {combos = {{key = 'R', reformers = {'LCtrl'}}}, down = iCommandPlaneAirRefuel, name = _('Refueling Boom'), category = _('Systems')},
{combos = {{key = 'R', reformers = {'LAlt'}}}, down = iCommandPlaneJettisonFuelTanks, name = _('Jettison Fuel Tanks'), category = _('Systems')},
-- {combos = {{key = 'S'}}, down = iCommandPlane_HOTAS_NoseWheelSteeringButton, up = iCommandPlane_HOTAS_NoseWheelSteeringButton, name = _('Nose Gear Maneuvering Range'), category = _('Systems')},
-- {combos = {{key = 'Q', reformers = {'LAlt'}}}, down = iCommandPlane_HOTAS_NoseWheelSteeringButtonOff, up = iCommandPlane_HOTAS_NoseWheelSteeringButtonOff, name = _('Nose Wheel Steering'), category = _('Systems')},
-- {combos = {{key = 'A', reformers = {'LCtrl'}}}, down = iCommandPlaneWheelBrakeLeftOn, up = iCommandPlaneWheelBrakeLeftOff, name = _('Wheel Brake Left On/Off'), category = _('Systems')},
-- {combos = {{key = 'A', reformers = {'LAlt'}}}, down = iCommandPlaneWheelBrakeRightOn, up = iCommandPlaneWheelBrakeRightOff, name = _('Wheel Brake Right On/Off'), category = _('Systems')},
-- {combos = {{key = 'T', reformers = {'LShift'}}}, down = iCommandClockElapsedTimeReset, name = _('Elapsed Time Clock Start/Stop/Reset'), category = _('Systems')},
-- {combos = {{key = 'D', reformers = {'LShift'}}}, down = iCommandPlaneFSQuantityIndicatorSelectorMAIN, name = _('Fuel Quantity Selector'), category = _('Systems')},
-- {combos = {{key = 'D', reformers = {'LCtrl','LAlt'}}}, down = iCommandPlaneFSQuantityIndicatorTest, up = iCommandPlaneFSQuantityIndicatorTest, value_down = 1, value_up = 0, name = _('Fuel Quantity Test'), category = _('Systems')},
-- {combos = {{key = 'D', reformers = {'LAlt'}}}, down = iCommandPlaneFSQuantityIndicatorSelectorINT,	up = iCommandPlaneFSQuantityIndicatorSelectorINT, value_down = 1,  value_up = 0, 	name = _('Bingo Fuel Index, CW'),  category = _('Systems')},
-- {combos = {{key = 'D', reformers = {'LCtrl'}}}, down = iCommandPlaneFSQuantityIndicatorSelectorINT,	up = iCommandPlaneFSQuantityIndicatorSelectorINT, value_down = -1, value_up = 0, 	name = _('Bingo Fuel Index, CCW'), category = _('Systems')},
-- {combos = {{key = 'L', reformers = {'RCtrl','RAlt'}}}, down = iCommandPlaneAntiCollisionLights, name = _('Anti-collision lights'), category = _('Systems')},

--NightVision
{combos = {{key = 'H', reformers = {'RShift'}}}        , down = iCommandViewNightVisionGogglesOn   , name = _('Night Vision Goggle - Toggle'), category = _('Sensors')},
{combos = {{key = 'H', reformers = {'RShift','RCtrl'}}}, down = iCommandPlane_Helmet_Brightess_Up  , name = _('Goggle Gain - Inc'),            category = _('Sensors')},
{combos = {{key = 'H', reformers = {'RShift','RAlt'}}} , down = iCommandPlane_Helmet_Brightess_Down, name = _('Goggle Gain - Dec'),            category = _('Sensors')},

-- Systems Su33
--{combos = {{key = 'G', reformers = {'LAlt'}}}, down = iCommandPlaneHook, name = _('Tail Hook'), category = _('Systems')},
--{combos = {{key = 'P', reformers = {'RCtrl'}}}, down = iCommandPlanePackWing, name = _('Folding Wings'), category = _('Systems')},

-- Modes
{combos = {{key = '2'}}, down = iCommandPlaneModeBVR, name = _('(2) Beyond Visual Range Mode'), category = _('Modes')},
{combos = {{key = '3'}}, down = iCommandPlaneModeVS, name = _('(3) Close Air Combat Vertical Scan Mode'), category = _('Modes')},
{combos = {{key = '4'}}, down = iCommandPlaneModeBore, name = _('(4) Close Air Combat Bore Mode'), category = _('Modes')},
--{combos = {{key = '5'}}, down = iCommandPlaneModeHelmet, name = _('(5) Close Air Combat HMD Helmet Mode'), category = _('Modes')},
{combos = {{key = '6'}}, down = iCommandPlaneModeFI0, name = _('(6) Longitudinal Missile Aiming Mode/FLOOD mode'), category = _('Modes')},
{combos = {{key = '7'}}, down = iCommandPlaneModeGround, name = _('(7) Air-To-Ground Mode'), category = _('Modes')},
--{combos = {{key = '8'}}, down = iCommandPlaneModeGrid, name = _('(8) Gunsight Reticle Switch'), category = _('Modes')},

-- Sensors
{combos = {{key = 'Enter'}}, down = iCommandPlaneChangeLock, up = iCommandPlaneChangeLockUp, name = _('Target Lock'), category = _('Sensors')},
{combos = {{key = 'Back'}}, down = iCommandSensorReset, name = _('Radar - Return To Search/NDTWS'), category = _('Sensors')},
{down = iCommandRefusalTWS, name = _('Unlock TWS Target'), category = _('Sensors')},
{combos = {{key = 'I'}}, down = iCommandPlaneRadarOnOff, name = _('Radar On/Off'), category = _('Sensors')},
{combos = {{key = 'I', reformers = {'RAlt'}}}, down = iCommandPlaneRadarChangeMode, name = _('Radar RWS/TWS Mode Select'), category = _('Sensors')},
{combos = {{key = 'I', reformers = {'RCtrl'}}}, down = iCommandPlaneRadarCenter, name = _('Target Designator To Center'), category = _('Sensors')},
{combos = {{key = 'I', reformers = {'RShift'}}}, down = iCommandPlaneChangeRadarPRF, name = _('Radar Pulse Repeat Frequency Select'), category = _('Sensors')},
--{combos = {{key = 'O'}}, down = iCommandPlaneEOSOnOff, name = _('Electro-Optical System On/Off'), category = _('Sensors')},
--{combos = {{key = 'O', reformers = {'RShift'}}}, down = iCommandPlaneLaserRangerOnOff, name = _('Laser Ranger On/Off'), category = _('Sensors')},
--{combos = {{key = 'O', reformers = {'RCtrl'}}}, down = iCommandPlaneNightTVOnOff, name = _('Night Vision (FLIR or LLTV) On/Off'), category = _('Sensors')},
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
--{combos = {{key = '=', reformers = {'RAlt'}}}, pressed = iCommandPlaneIncreaseBase_Distance, up = iCommandPlaneStopBase_Distance, name = _('Target Specified Size Increase'), category = _('Sensors')},
--{combos = {{key = '-', reformers = {'RAlt'}}}, pressed = iCommandPlaneDecreaseBase_Distance, up = iCommandPlaneStopBase_Distance, name = _('Target Specified Size Decrease'), category = _('Sensors')},
{combos = {{key = 'R', reformers = {'RShift'}}}, down = iCommandChangeRWRMode, name = _('RWR/SPO Mode Select'), category = _('Sensors')},
{combos = {{key = ',', reformers = {'RAlt'}}}, down = iCommandPlaneThreatWarnSoundVolumeDown, name = _('RWR/SPO Sound Signals Volume Down'), category = _('Sensors')},
{combos = {{key = '.', reformers = {'RAlt'}}}, down = iCommandPlaneThreatWarnSoundVolumeUp, name = _('RWR/SPO Sound Signals Volume Up'), category = _('Sensors')},

-- Weapons                                                                        
{combos = {{key = 'V', reformers = {'LCtrl'}}}, down = iCommandPlaneSalvoOnOff, name = _('Salvo Mode'), category = _('Weapons')},
-- {combos = {{key = 'Space', reformers = {'RAlt'}}}, down = iCommandPlanePickleOn,	up = iCommandPlanePickleOff, name = _('Weapon Release'), category = _('Weapons')},
--{combos = {{key = 'C', reformers = {'LShift'}}}, down = iCommandChangeGunRateOfFire, name = _('Cannon Rate Of Fire / Cut Of Burst select'), category = _('Weapons')},
})
return res
