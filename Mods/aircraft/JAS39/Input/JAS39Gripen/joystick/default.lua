local cockpit = folder.."../../../Cockpit/Scripts/"
dofile(cockpit.."devices.lua")
dofile(cockpit.."command_defs.lua")

local res = external_profile("Config/Input/Aircrafts/common_joystick_binding.lua")
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
--
local PITCHBW_AXIS  = 10061
local ROLLBW_AXIS   = 10062
local YAWBW_AXIS    = 10063
local THROTTLE_AXIS = 10066

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
--{down = Keys.NoHotas, 																name = _('I dont have a Hotas'),    	   					category = _('Other')},
---------------------------------------------
-- Systems ----------------------------------
---------------------------------------------
-- NightVision
{down = iCommandViewNightVisionGogglesOn   ,											name = _('Night Vision Goggle - Toggle'),					category = _('Systems')},
{down = iCommandPlane_Helmet_Brightess_Up  ,											name = _('Goggle Gain - Inc'),           					category = _('Systems')},
{down = iCommandPlane_Helmet_Brightess_Down,											name = _('Goggle Gain - Dec'),           					category = _('Systems')},
---------------------------------------------		
-- General ----------------------------------		
---------------------------------------------		
-- Mirrors		
{down = iCommandViewLeftMirrorOn ,				up = iCommandViewLeftMirrorOff ,		name = _('Mirror Left On'),									category = _('General') , features = {"Mirrors"}},
{down = iCommandViewRightMirrorOn,				up = iCommandViewRightMirrorOff,		name = _('Mirror Right On'),								category = _('General') , features = {"Mirrors"}},
{down = iCommandToggleMirrors,															name = _('Toggle Mirrors'),									category = _('General') , features = {"Mirrors"}},
-- Pilot		
{down = iCommandCockpitShowPilotOnOff,													name = _('Show Pilot Body'),								category = _('General')},
-- Auto Lock On 		
{down = iCommandAutoLockOnNearestAircraft,												name = _('Auto lock on nearest aircraft'),					category = _('General')},
{down = iCommandAutoLockOnCenterAircraft,												name = _('Auto lock on center aircraft'),					category = _('General')},
{down = iCommandAutoLockOnNextAircraft,													name = _('Auto lock on next aircraft'),						category = _('General')},
{down = iCommandAutoLockOnPreviousAircraft,												name = _('Auto lock on previous aircraft'),					category = _('General')},
{down = iCommandAutoLockOnNearestSurfaceTarget,											name = _('Auto lock on nearest surface target'),			category = _('General')},
{down = iCommandAutoLockOnCenterSurfaceTarget,											name = _('Auto lock on center surface target'),				category = _('General')},
{down = iCommandAutoLockOnNextSurfaceTarget,											name = _('Auto lock on next surface target'),				category = _('General')},
{down = iCommandAutoLockOnPreviousSurfaceTarget, 										name = _('Auto lock on previous surface target'),			category = _('General')},
-- Other 										
{down = Keys.SeatEject,	               													name = _('Eject'), 			  								category = _('General')}, 
{down = Keys.CanopyLever,	               												name = _('Canopy'),                    			  			category = _('General')},
{down = iCommandPlaneWingtipSmokeOnOff,													name = _('Smoke'),											category = _('General')},
-- Systems Su33
--{down = iCommandPlaneHook, 															name = _('Tail Hook'), 										category = _('General')},
--{down = iCommandPlaneShipTakeOff,														name = _('Ship Take Off Position'),							category = _('General') , features = {"shiptakeoff"}},
---------------------------------------------
-- Flight Controls --------------------------
---------------------------------------------
{combos = {{key = 'W'}}, 						up = BrakesOFF,	down = BrakesON, 		name = _('Wheel Brakes - Both'),    						category = {_('Systems')}},				
---------------------------------------------
-- Stick ------------------------------------
---------------------------------------------
-- Flight Controls Gripen						
{pressed = Keys.GripenPlaneUpStart,				up = Keys.GripenPlaneUpStop,			name = _('Aircraft Pitch Down'),							category = {_('Stick'), _('HOTAS'), _('Flight Control')}},
{pressed = Keys.GripenPlaneDownStart,			up = Keys.GripenPlaneDownStop,			name = _('Aircraft Pitch Up'),								category = {_('Stick'), _('HOTAS'), _('Flight Control')}},
{pressed = Keys.GripenPlaneLeftStart,			up = Keys.GripenPlaneLeftStop,			name = _('Aircraft Bank Left'),								category = {_('Stick'), _('HOTAS'), _('Flight Control')}},
{pressed = Keys.GripenPlaneRightStart,			up = Keys.GripenPlaneRightStop,			name = _('Aircraft Bank Right'),							category = {_('Stick'), _('HOTAS'), _('Flight Control')}},
{pressed = Keys.GripenPlaneLeftRudderStart,		up = Keys.GripenPlaneLeftRudderStop,	name = _('Aircraft Rudder Left'),							category = {_('Flight Control')}},
{pressed = Keys.GripenPlaneRightRudderStart,	up = Keys.GripenPlaneRightRudderStop,	name = _('Aircraft Rudder Right'),							category = {_('Flight Control')}},
-- Trim Controls						
{pressed = iCommandPlaneTrimUp,					up = iCommandPlaneTrimStop,				name = _('Trim: Nose Up'),									category = {_('Stick'), _('HOTAS'), _('Flight Control')}},
{pressed = iCommandPlaneTrimDown,				up = iCommandPlaneTrimStop,				name = _('Trim: Nose Down'),								category = {_('Stick'), _('HOTAS'), _('Flight Control')}},
{pressed = iCommandPlaneTrimLeft,				up = iCommandPlaneTrimStop,				name = _('Trim: Left Wing Down'),							category = {_('Stick'), _('HOTAS'), _('Flight Control')}},
{pressed = iCommandPlaneTrimRight,				up = iCommandPlaneTrimStop,				name = _('Trim: Right Wing Down'),							category = {_('Stick'), _('HOTAS'), _('Flight Control')}},
{pressed = iCommandPlaneTrimLeftRudder,		 	up = iCommandPlaneTrimStop,				name = _('Trim: Rudder Left'),								category = {_('Stick'), _('HOTAS'), _('Flight Control')}},
{pressed = iCommandPlaneTrimRightRudder,	    up = iCommandPlaneTrimStop, 			name = _('Trim: Rudder Right'),								category = {_('Stick'), _('HOTAS'), _('Flight Control')}},
-- Weapons						
{down = Keys.Trigger,	     					up = Keys.Trigger,      				name = _('Trigger'),      									category = {_('Stick'), _('HOTAS')}, 			value_down =  1.0,		value_up = 0.0},
{down = Keys.TriggerSafe,	 															name = _('Trigger Safe - Toggle'), 							category = {_('Stick'), _('HOTAS')}},
{up = Keys.TriggerSafeHold,																name = _('Trigger Safe - Hold'), 							category = {_('Stick'), _('HOTAS')}, 			value_down =  1.0,		value_up = 0.0},
{down = Keys.CannonMode,	 															name = _('Cannon Mode'), 									category = {_('Stick'), _('HOTAS')}},
-- FC3 Weapons                                                                       
{down = iCommandPlaneSalvoOnOff, 														name = _('Salvo Mode'), 									category = {_('Stick'), _('HOTAS')}},
{down = iCommandChangeRippleQuantity, 													name = _('Ripple Quantity Select/SPPU select'), 			category = {_('Stick'), _('HOTAS')}},
{down = iCommandChangeRippleInterval, 													name = _('Ripple Interval Increase'), 						category = {_('Stick'), _('HOTAS')}},
{down = iCommandChangeRippleIntervalDown, 												name = _('Ripple Interval Decrease'), 						category = {_('Stick'), _('HOTAS')}},
{down = iCommandPlaneChangeWeapon, 														name = _('Weapon Change'),									category = {_('Stick'), _('HOTAS')}},
-- Modes
{down = iCommandPlaneModeNAV,															name = _('(1) Navigation Modes'),							category = {_('Stick'), _('HOTAS')}},
{down = iCommandPlaneModeBVR, 															name = _('(2) Beyond Visual Range Mode'), 					category = {_('Stick'), _('HOTAS')}},
{down = iCommandPlaneModeVS, 															name = _('(3) Close Air Combat Vertical Scan Mode'), 		category = {_('Stick'), _('HOTAS')}},
{down = iCommandPlaneModeBore, 															name = _('(4) Close Air Combat Bore Mode'), 				category = {_('Stick'), _('HOTAS')}},
{down = iCommandPlaneModeHelmet, 														name = _('(5) Close Air Combat HMD Helmet Mode'), 			category = {_('Stick'), _('HOTAS')}},
{down = iCommandPlaneModeFI0, 															name = _('(6) Longitudinal Missile Aiming Mode/FLOOD mode'),category = {_('Stick'), _('HOTAS')}},
{down = iCommandPlaneModeGround, 														name = _('(7) Air-To-Ground Mode'), 						category = {_('Stick'), _('HOTAS')}},
{down = iCommandPlaneModeGrid, 															name = _('(8) Gunsight Reticle Switch'), 					category = {_('Stick'), _('HOTAS')}},
---------------------------------------------
-- Throttle Grip ----------------------------
---------------------------------------------
-- TDC
{pressed = iCommandPlaneRadarUp, 				up = iCommandPlaneRadarStop, 			name = _('Target Designator Up'),   						category = {_('Throttle Grip'), _('HOTAS'), _('Sensors')}},
{pressed = iCommandPlaneRadarDown, 				up = iCommandPlaneRadarStop, 			name = _('Target Designator Down'), 						category = {_('Throttle Grip'), _('HOTAS'), _('Sensors')}},
{pressed = iCommandPlaneRadarLeft, 				up = iCommandPlaneRadarStop, 			name = _('Target Designator Left'), 						category = {_('Throttle Grip'), _('HOTAS'), _('Sensors')}},
{pressed = iCommandPlaneRadarRight, 			up = iCommandPlaneRadarStop,			name = _('Target Designator Right'),						category = {_('Throttle Grip'), _('HOTAS'), _('Sensors')}},
-- Sensors (F15 Specific)
{down = iCommandRefusalTWS,			 													name = _('Unlock TWS Target'), 					 			category = {_('Throttle Grip'), _('HOTAS'), _('Sensors')}},
{down = iCommandPlaneChangeRadarPRF, 													name = _('Radar Pulse Repeat Frequency Select'), 			category = {_('Throttle Grip'), _('HOTAS'), _('Sensors')}},
-- Sensors (Su25T Specific)										
{down = iCommandPlaneLaserRangerOnOff, 													name = _('Laser Ranger On/Off'), 				 			category = {_('Throttle Grip'), _('HOTAS'), _('Sensors')}},
{down = iCommandPlaneNightTVOnOff, 														name = _('Night Vision (FLIR or LLTV) On/Off'),  			category = {_('Throttle Grip'), _('HOTAS'), _('Sensors')}},
-- Sensors (Shared)										
{down = iCommandPlaneEOSOnOff, 			    											name = _('Electro-Optical System On/Off'), 					category = {_('Throttle Grip'), _('HOTAS'), _('Sensors')}},
{down = iCommandPlaneChangeLock, 				up = iCommandPlaneChangeLockUp,			name = _('Target Lock'), 									category = {_('Throttle Grip'), _('HOTAS'), _('Sensors')}},
{down = iCommandSensorReset, 															name = _('Radar NDTWS / Target Unlock'), 					category = {_('Throttle Grip'), _('HOTAS'), _('Sensors')}},
{down = iCommandPlaneRadarOnOff, 														name = _('Radar On/Off / ELINT Pod On/Off'), 				category = {_('Throttle Grip'), _('HOTAS'), _('Sensors')}},
{down = iCommandPlaneRadarChangeMode, 													name = _('Radar RWS/TWS Mode Select'), 						category = {_('Throttle Grip'), _('HOTAS'), _('Sensors')}},
{down = iCommandPlaneRadarCenter, 														name = _('Target Designator To Center'), 					category = {_('Throttle Grip'), _('HOTAS'), _('Sensors')}},
-- Radar / TGP						
{pressed = iCommandSelecterUp, 					up = iCommandSelecterStop, 				name = _('Scan Zone Up'),									category = {_('Throttle Grip'), _('HOTAS'), _('Sensors')}},
{pressed = iCommandSelecterDown, 				up = iCommandSelecterStop, 				name = _('Scan Zone Down'),									category = {_('Throttle Grip'), _('HOTAS'), _('Sensors')}},
{pressed = iCommandSelecterLeft, 				up = iCommandSelecterStop,				name = _('Scan Zone Left'),									category = {_('Throttle Grip'), _('HOTAS'), _('Sensors')}},
{pressed = iCommandSelecterRight, 				up = iCommandSelecterStop,				name = _('Scan Zone Right'),								category = {_('Throttle Grip'), _('HOTAS'), _('Sensors')}},
{down = iCommandPlaneZoomIn,                                                        	name = _('Display Zoom In'),								category = {_('Throttle Grip'), _('HOTAS'), _('Sensors')}},
{down = iCommandPlaneZoomOut,                                                       	name = _('Display Zoom Out'),                 				category = {_('Throttle Grip'), _('HOTAS'), _('Sensors')}},
{down = iCommandDecreaseRadarScanArea,                       							name = _('Radar Scan Zone / Target Size Decreas'), 			category = {_('Throttle Grip'), _('HOTAS'), _('Sensors')}},
{down = iCommandIncreaseRadarScanArea,                       							name = _('Radar Scan Zone / Target Size Increase'), 		category = {_('Throttle Grip'), _('HOTAS'), _('Sensors')}},
{pressed = iCommandPlaneIncreaseBase_Distance, 	up = iCommandPlaneStopBase_Distance, 	name = _('Target Specified Size Increase'), 				category = {_('Throttle Grip'), _('HOTAS'), _('Sensors')}},
{pressed = iCommandPlaneDecreaseBase_Distance, 	up = iCommandPlaneStopBase_Distance, 	name = _('Target Specified Size Decrease'), 				category = {_('Throttle Grip'), _('HOTAS'), _('Sensors')}},
-- Navigation						
{down = iCommandPlaneChangeTarget,														name = _('Next Waypoint, Airfield Or Target'),				category = {_('Throttle Quadrant'), _('HOTAS'), _('Sensors')}},
{down = iCommandPlaneUFC_STEER_DOWN,													name = _('Previous Waypoint, Airfield Or Target'), 			category = {_('Throttle Quadrant'), _('HOTAS'), _('Sensors')}},
-- Countermeasures						
{down = Keys.CountermeasureRelease,	 													name = _('Countermeasure Dispense'), 						category = {_('Throttle Grip'), _('HOTAS')}},
{down = iCommandActiveJamming,															name = _('ECM'), 											category = {_('Throttle Grip'), _('HOTAS')}},--136
-- Throttle Gripen									
{pressed = Keys.GripenThrottleIncrease,			up = Keys.GripenThrottleStop,  			name = _('Throttle Up'),									category = {_('Throttle Grip'), _('HOTAS')}},
{pressed = Keys.GripenThrottleDecrease,			up = Keys.GripenThrottleStop,  			name = _('Throttle Down'),									category = {_('Throttle Grip'), _('HOTAS')}},
{down = AUTOTHROTTLE,																	name = _('Autothrottle - Toggle'), 							category = {_('Throttle Grip'), _('HOTAS'), _('Autopilot')}},			
{down = ATAOA_1214,																		name = _('Autothrottle - Toggle AoA 12/14'),				category = {_('Throttle Grip'), _('HOTAS'), _('Autopilot')}},			
-- Throttle FC3									
{down = Keys.ThrottleStop,	               												name = _('Throttle Stop'),									category = {_('Throttle Grip'), _('HOTAS')},			 	value_down =  1.0,		value_up = 0.0},
{down = iCommandPlaneAUTIncreaseRegime,													name = _('Throttle Step Up'),								category = {_('Throttle Grip'), _('HOTAS'), _('Flight Control')}},
{down = iCommandPlaneAUTDecreaseRegime,													name = _('Throttle Step Down'),								category = {_('Throttle Grip'), _('HOTAS'), _('Flight Control')}},
-- Airbrakes									
{down = iCommandPlaneAirBrake,															name = _('Airbrake'),										category = _('Throttle Grip'), _('HOTAS') , features = {"airbrake"}},
{down = iCommandPlaneAirBrakeOn,														name = _('Airbrake On'),									category = _('Throttle Grip'), _('HOTAS') , features = {"airbrake"}},
{down = iCommandPlaneAirBrakeOff,														name = _('Airbrake Off'),									category = _('Throttle Grip'), _('HOTAS') , features = {"airbrake"}},
---------------------------------------------						
-- Left Lower Pannel ------------------------						
---------------------------------------------						
-- Ligths						
{down = Keys.TaxiLights,	               												name = _('Taxi Lights'), 			  						category = _('Left Lower Pannel')},
{down = Keys.LandingTaxiLightsOff,	               										name = _('Landing and Taxi Lights Off'), 					category = _('Left Lower Pannel')},
{down = Keys.LandingLights,	               												name = _('Landing Lights'), 			  					category = _('Left Lower Pannel')},
{down = Keys.CovertLights,	               												name = _('Covert Lights'), 			  						category = _('Left Lower Pannel')},	
-- AAR                                                                                                                                  			   
{down = Keys.AARProbeCover,	               												name = _('AAR Probe Cover'), 			  					category = _('Left Lower Pannel')},
{down = Keys.AARProbe,	               													name = _('AAR Probe')	, 			  						category = _('Left Lower Pannel')}, 	
-- RWR									
{down = iCommandChangeRWRMode, 				  											name = _('RWR/SPO Mode Select'), 							category = _('Left Lower Pannel')},
{down = iCommandPlaneThreatWarnSoundVolumeDown, 										name = _('RWR/SPO Sound Signals Volume Down'), 				category = _('Left Lower Pannel')},
{down = iCommandPlaneThreatWarnSoundVolumeUp,     									    name = _('RWR/SPO Sound Signals Volume Up'), 				category = _('Left Lower Pannel')},
---------------------------------------------						
-- Left Control Pannel ----------------------						
---------------------------------------------						
{down = Keys.GearUp,	    				 											name = _('Landing Gear Up'),                    			category = _('Left Control Pannel')},
{down = Keys.GearDown,                    												name = _('Landing Gear Down'),                  			category = _('Left Control Pannel')},
{down = Keys.Start,	                			up = Keys.Start,		            	name = _('Engine Start'), 									category = _('Left Control Pannel'), value_down =  1.0, value_up = 0.0},
---------------------------------------------						
-- Instrument Panel -------------------------						
---------------------------------------------						
-- Autopilot						
{down = iCommandPlaneAutopilot,  														name = _('Autopilot - Attitude Hold'), 						category = {_('Autopilot'), _('Instrument Panel')}},
{down = iCommandPlaneStabHbar, 	 														name = _('Autopilot - Altitude Hold'), 						category = {_('Autopilot'), _('Instrument Panel')}},
{down = iCommandPlaneStabCancel, 														name = _('Autopilot Disengage'), 							category = {_('Autopilot'), _('Instrument Panel')}},
-- Other						
{down = iCommandPlaneResetMasterWarning,												name = _('Audible Warning Reset'),							category = _('Instrument Panel')},
-- Left Display (LD)
{down = Keys.LDSK_1, 		     														name = _('LD Softkey 1'),									category = {_('Instrument Panel'), _('Left Display (LD)')}},
{down = Keys.LDSK_2, 		     														name = _('LD Softkey 2'),									category = {_('Instrument Panel'), _('Left Display (LD)')}},
{down = Keys.LDSK_3, 		     														name = _('LD Softkey 3'),									category = {_('Instrument Panel'), _('Left Display (LD)')}},
{down = Keys.LDSK_4, 		     														name = _('LD Softkey 4'),									category = {_('Instrument Panel'), _('Left Display (LD)')}},
{down = Keys.LDSK_5, 		     														name = _('LD Softkey 5'),									category = {_('Instrument Panel'), _('Left Display (LD)')}},
{down = Keys.LDSK_6, 		     														name = _('LD Softkey 6'),									category = {_('Instrument Panel'), _('Left Display (LD)')}},
{down = Keys.LDSK_7, 		     														name = _('LD Softkey 7'),									category = {_('Instrument Panel'), _('Left Display (LD)')}},  
{down = Keys.LDSK_8, 		     														name = _('LD Softkey 8'),									category = {_('Instrument Panel'), _('Left Display (LD)')}},
{down = Keys.LDSK_9, 		     														name = _('LD Softkey 9'),									category = {_('Instrument Panel'), _('Left Display (LD)')}},
{down = Keys.LDSK_10,		     														name = _('LD Softkey 10'),									category = {_('Instrument Panel'), _('Left Display (LD)')}},
{down = Keys.LDSK_11,		     														name = _('LD Softkey 11'),									category = {_('Instrument Panel'), _('Left Display (LD)')}},
{down = Keys.LDSK_12,		     														name = _('LD Softkey 12'),									category = {_('Instrument Panel'), _('Left Display (LD)')}},
{down = Keys.LDSK_13,		     														name = _('LD Softkey 13'),									category = {_('Instrument Panel'), _('Left Display (LD)')}}, 
{down = Keys.LDSK_14,		     														name = _('LD Softkey 14'),									category = {_('Instrument Panel'), _('Left Display (LD)')}},
{down = Keys.LDSK_15,		     														name = _('LD Softkey 15'),									category = {_('Instrument Panel'), _('Left Display (LD)')}},
{down = Keys.LDSK_16,		     														name = _('LD Softkey 16'),									category = {_('Instrument Panel'), _('Left Display (LD)')}},
{down = Keys.LDSK_17,		     														name = _('LD Softkey 17'),									category = {_('Instrument Panel'), _('Left Display (LD)')}},
{down = Keys.LDSK_18,		     														name = _('LD Softkey 18'),									category = {_('Instrument Panel'), _('Left Display (LD)')}},
{down = Keys.LDSK_19,		     														name = _('LD Softkey 19'),									category = {_('Instrument Panel'), _('Left Display (LD)')}},
{down = Keys.LDSK_20,		     														name = _('LD Softkey 20'),									category = {_('Instrument Panel'), _('Left Display (LD)')}},
{down = Keys.LD_Brightness_Up,   														name = _('LD Brightness +'),								category = {_('Instrument Panel'), _('Left Display (LD)')}},
{down = Keys.LD_Brightness_Down, 														name = _('LD Brightness -'),								category = {_('Instrument Panel'), _('Left Display (LD)')}},
{down = Keys.LD_Contrast_Up,     														name = _('LD Contrast +'),									category = {_('Instrument Panel'), _('Left Display (LD)')}},
{down = Keys.LD_Contrast_Down,   														name = _('LD Contrast -'),									category = {_('Instrument Panel'), _('Left Display (LD)')}},
-- Center Display (CD)														
{down = Keys.CDSK_1, 			 														name = _('CD Softkey 1'),									category = {_('Instrument Panel'), _('Center Display (CD)')}},	
{down = Keys.CDSK_2, 			 														name = _('CD Softkey 2'),									category = {_('Instrument Panel'), _('Center Display (CD)')}},
{down = Keys.CDSK_3, 			 														name = _('CD Softkey 3'),									category = {_('Instrument Panel'), _('Center Display (CD)')}},
{down = Keys.CDSK_4, 			 														name = _('CD Softkey 4'),									category = {_('Instrument Panel'), _('Center Display (CD)')}},
{down = Keys.CDSK_5, 			 														name = _('CD Softkey 5'),									category = {_('Instrument Panel'), _('Center Display (CD)')}},
{down = Keys.CDSK_6, 			 														name = _('CD Softkey 6'),									category = {_('Instrument Panel'), _('Center Display (CD)')}},
{down = Keys.CDSK_7, 			 														name = _('CD Softkey 7'),									category = {_('Instrument Panel'), _('Center Display (CD)')}},                     
{down = Keys.CDSK_8, 			 														name = _('CD Softkey 8'),									category = {_('Instrument Panel'), _('Center Display (CD)')}},
{down = Keys.CDSK_9, 			 														name = _('CD Softkey 9'),									category = {_('Instrument Panel'), _('Center Display (CD)')}},
{down = Keys.CDSK_10,			 														name = _('CD Softkey 10'),									category = {_('Instrument Panel'), _('Center Display (CD)')}},
{down = Keys.CDSK_11,			 														name = _('CD Softkey 11'),									category = {_('Instrument Panel'), _('Center Display (CD)')}},
{down = Keys.CDSK_12,			 														name = _('CD Softkey 12'),									category = {_('Instrument Panel'), _('Center Display (CD)')}},
{down = Keys.CDSK_13,			 														name = _('CD Softkey 13'),									category = {_('Instrument Panel'), _('Center Display (CD)')}},                   
{down = Keys.CDSK_14,			 														name = _('CD Softkey 14'),									category = {_('Instrument Panel'), _('Center Display (CD)')}},
{down = Keys.CDSK_15,			 														name = _('CD Softkey 15'),									category = {_('Instrument Panel'), _('Center Display (CD)')}},
{down = Keys.CDSK_16,			 														name = _('CD Softkey 16'),									category = {_('Instrument Panel'), _('Center Display (CD)')}},
{down = Keys.CDSK_17,			 														name = _('CD Softkey 17'),									category = {_('Instrument Panel'), _('Center Display (CD)')}},
{down = Keys.CDSK_18,			 														name = _('CD Softkey 18'),									category = {_('Instrument Panel'), _('Center Display (CD)')}},
{down = Keys.CDSK_19,			 														name = _('CD Softkey 19'),									category = {_('Instrument Panel'), _('Center Display (CD)')}},
{down = Keys.CDSK_20,			 														name = _('CD Softkey 20'),									category = {_('Instrument Panel'), _('Center Display (CD)')}},
{down = Keys.CD_Brightness_Up,	 														name = _('CD Brightness +'), 								category = {_('Instrument Panel'), _('Center Display (CD)')}},
{down = Keys.CD_Brightness_Down, 														name = _('CD Brightness -'),								category = {_('Instrument Panel'), _('Center Display (CD)')}},
{down = Keys.CD_Contrast_Up, 	 														name = _('CD Contrast +'), 									category = {_('Instrument Panel'), _('Center Display (CD)')}},
{down = Keys.CD_Contrast_Down,   														name = _('CD Contrast -'), 									category = {_('Instrument Panel'), _('Center Display (CD)')}},
-- Right Display (RD)																					
{down = Keys.RD_Brightness_Up,   														name = _('RD Brightness +'), 								category = {_('Instrument Panel'), _('Right  Display (RD)')}},
{down = Keys.RD_Brightness_Down, 														name = _('RD Brightness -'), 								category = {_('Instrument Panel'), _('Right  Display (RD)')}},
{down = Keys.RD_Contrast_Up,     														name = _('RD Contrast +'),   								category = {_('Instrument Panel'), _('Right  Display (RD)')}},
{down = Keys.RD_Contrast_Down,   														name = _('RD Contrast -'),   								category = {_('Instrument Panel'), _('Right  Display (RD)')}},
---------------------------------------------
-- Upfront Control Panel (UCP) --------------
---------------------------------------------
-- Modes
{down = LANDING_MODE, 				 													name = _('Landing mode - Toggle'), 							category = _('Upfront Control Panel')},
-- Communications													
{down = iCommandAWACSTankerBearing,									    				name = _('Request AWACS Available Tanker'),					category = _('Upfront Control Panel')},
{down = iCommandToggleReceiveMode,									    				name = _('Receive Mode'),									category = _('Upfront Control Panel')},
-- HUD                                                                  													
{pressed = iCommandHUDBrightnessUp,									    				name = _('HUD Brightness up'),								category = _('Upfront Control Panel') , features = {"HUDbrightness"}},
{pressed = iCommandHUDBrightnessDown,								    				name = _('HUD Brightness down'),							category = _('Upfront Control Panel') , features = {"HUDbrightness"}},
{down = iCommandBrightnessILS,									        				name = _('HUD Color'),										category = _('Upfront Control Panel') , features = {"HUDcolor"}},
---------------------------------------------									
-- Lower Right Pannel -----------------------									
---------------------------------------------									
{down = P_BRAKE, 														 				name = _('Parking Brake'),      							category = _('Right Aft Console')},		
---------------------------------------------									
-- Upper Right Pannel -----------------------									
---------------------------------------------									
{down = Keys.Main,	                									 				name = _('Main Power'), 		  							category = _('Upper Right Pannel'), value_down =  1.0, value_up = 0.0},
{down = Keys.Fuel,	                									 				name = _('Fuel'), 			  								category = _('Upper Right Pannel'), value_down =  1.0, value_up = 0.0},
{down = Keys.APU,	                									 				name = _('APU'), 				  							category = _('Upper Right Pannel'), value_down =  1.0, value_up = 0.0},
{down = Keys.FuelCover,	            									 				name = _('Fuel Cover'), 		  							category = _('Upper Right Pannel'), value_down =  1.0, value_up = 0.0},
{down = Keys.MassSafe,	                       							 				name = _('MASS Safe'), 		  								category = _('Upper Right Pannel')},			 	
{down = Keys.MassStby,	              									 				name = _('MASS Standby'), 	  								category = _('Upper Right Pannel')},			 	
{down = Keys.MassLive,	              									 				name = _('MASS Live'), 		  								category = _('Upper Right Pannel')},
{down = iCommandPlaneJettisonFuelTanks,									 				name = _('Jettison Fuel Tanks'),							category = _('Upper Right Pannel')},
{down = iCommandPlaneJettisonWeapons,up = iCommandPlaneJettisonWeaponsUp,				name = _('Weapons Jettison'),   							category = _('Upper Right Pannel')},
})
---------------------------------------------
-- FC3 Axes ---------------------------------
---------------------------------------------
join(res.axisCommands,{
{action = iCommandPlaneSelecterHorizontalAbs,											name = _('TDC Slew Horizontal')}, 	
{action = iCommandPlaneSelecterVerticalAbs	,											name = _('TDC Slew Vertical')}, 		
{action = iCommandPlaneRadarHorizontalAbs	,											name = _('Radar Horizontal')}, 		
{action = iCommandPlaneRadarVerticalAbs		,											name = _('Radar Vertical')}, 		
{action = iCommandPlaneMFDZoomAbs 			,											name = _('MFD Range')},  			
{action = iCommandPlaneBase_DistanceAbs 	,											name = _('Base/Distance')}, 			
---------------------------------------------
-- Gripen Axes ------------------------------
---------------------------------------------
{action = PITCHBW_AXIS,		                 											name = _('Gripen Pitch Axis')}, 		
{action = ROLLBW_AXIS,		                 											name = _('Gripen Roll Axis')}, 		
{action = YAWBW_AXIS,		                 											name = _('Gripen Rudder Axis')}, 	
{action = B_BRAKE,		                     											name = _('Gripen Wheel Brake Both')}, 
{action = L_BRAKE,		                     											name = _('Gripen Wheel Brake Left')}, 
{action = R_BRAKE,		                     											name = _('Gripen Wheel Brake Right')},
{action = THROTTLE_AXIS,		             											name = _('Gripen Throttle Axis')}, 	
})
return res