dofile(LockOn_Options.script_path.."clickable_defs.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."devices.lua")
--dofile(LockOn_Options.script_path.."sounds.lua")
--------------------------------------------------
--QAQC Functions
--------------------------------------------------
--function update()
--print_message_to_user(get_cockpit_draw_argument_value(2077))
--show_element_boxes = true
--show_element_parent_boxes = true
--show_indicator_borders = true
--enable_commands_log = true
--use_click_and_pan_mode = true
--show_tree_boxes = true
--show_other_pointers = true

cursor_mode = 
{ 
    CUMODE_CLICKABLE = 0,
    CUMODE_CLICKABLE_AND_CAMERA  = 1,
    CUMODE_CAMERA = 2,
};
clickable_mode_initial_status = cursor_mode.CUMODE_CLICKABLE
use_pointer_name = true
anim_speed_default = 16

local gettext = require("i_18n")
_ = gettext.translate

elements = {}
-------------------------------------------------------
--FC3 Commands
-------------------------------------------------------
elements["PNT_1253"] = Mfd_button(_("Autopilot - Transition To Level Flight Control"),  devices.FC3,	device_commands.AP_RSET,	1253,1,{0,1},JAS39MFD1)
elements["PNT_1254"] = Mfd_button(_("Autopilot - Altitude Hold"),devices.FC3,	device_commands.AP_ALT,		1254,1,{0,1},JAS39MFD1)
elements["PNT_1255"] = Mfd_button(_("Autopilot - Attitude Hold"),devices.FC3,	device_commands.AP_ATT,		1255,1,{0,1},JAS39MFD1)
elements["PNT_1256"] = Mfd_button(_("Autopilot - Disengage"),	devices.FC3,	device_commands.AP_OFF,		1256,1,{0,1},JAS39MFD1)
--elements["PNT_730"] = Mfd_button(_("Next Waypoint"),		    devices.FC3,	device_commands.NAV_NEXT,	730,1,{0,1},JAS39MFD1)
--elements["PNT_730"] = Mfd_button(_("Previous Waypoint"),	    devices.FC3,	device_commands.NAV_PREV,	730,1,{0,1},JAS39MFD1)
elements["PNT_1097"] = Mfd_button(_("Radar Power"),			    devices.FC3,	device_commands.RDR_PWR,	1097,1,{0,1},JAS39MFD1)
elements["PNT_1098"] = Mfd_button(_("Radar Mode"),			    devices.FC3,	device_commands.RDR_MODE,	1098,1,{0,1},JAS39MFD1)
elements["PNT_1099"] = Mfd_button(_("Radar Pulse Repeat Frequency"),devices.FC3,device_commands.RDR_PRF,	1099,1,{0,1},JAS39MFD1)
elements["PNT_1100"] = Mfd_button(_("Radar Zoom Out"),		    devices.FC3,	device_commands.RDR_OUT,	1100,1,{0,1},JAS39MFD1)
elements["PNT_1101"] = Mfd_button(_("Radar Zoom In"),		    devices.FC3,	device_commands.RDR_IN,		1101,1,{0,1},JAS39MFD1)
elements["PNT_1102"] = Mfd_button(_("Scan Zone Left/Radar Scan Zone Decrease"), devices.FC3,	device_commands.RDR_LEFT,	1102,1,{0,1},JAS39MFD1)
elements["PNT_1103"] = Mfd_button(_("Scan Zone Right/Radar Scan Zone Increase"),devices.FC3,	device_commands.RDR_RIGHT,	1103,1,{0,1},JAS39MFD1)
elements["PNT_1086"] = Mfd_button(_("Electro-Optical System On/Off"),			devices.FC3,	device_commands.EO,			1086,1,{0,1},JAS39MFD1)
elements["PNT_1087"] = Mfd_button(_("Scan Zone Up"),			devices.FC3,	device_commands.RDR_UP,		1087,1,{0,1},JAS39MFD1)
elements["PNT_1088"] = Mfd_button(_("Scan Zone Down"),		    devices.FC3,	device_commands.RDR_DOWN,	1088,1,{0,1},JAS39MFD1)
elements["PNT_1257"] = Mfd_button(_("HMD ON/OFF"),				devices.HMD,	device_commands.HMDTOGGLE,	1257,1,{0,1},JAS39MFD1)
elements["PNT_2001"] = Mfd_button(_("Kneeboard"),				devices.FC3,	device_commands.MAP,	2001,1,{0,1},JAS39MFD1)
elements["PNT_3009"] = Mfd_button(_("Hide Left Kneeboard"),	    devices.FC3,	device_commands.LKneeboardDraw,		3009,1,{0,1},JAS39MFD1)
elements["PNT_3010"] = Mfd_button(_("Hide Rigth Kneeboard"),    devices.FC3,	device_commands.RKneeboardDraw,		3010,1,{0,1},JAS39MFD1)
elements["PNT_3006"] = Mfd_button(_("Hide Joystick"),			devices.FC3,	device_commands.JoystickDraw,		3006,1,{0,1},JAS39MFD1)
--elements["PNT_2002"] = Mfd_button(_("F10 Map"),				devices.FC3,	device_commands.KNEEBOARD,	2002,1,{0,1},JAS39MFD1)
elements["PNT_3004"] = Mfd_button(_("Mirrors On/Off"),		    devices.FC3,	device_commands.MIRROR,		3004,1,{0,1},JAS39MFD1)
elements["PNT_3004_1"] = Mfd_button(_("Mirrors On/Off"),		devices.FC3,	device_commands.MIRROR,		3004,1,{0,1},JAS39MFD1)
elements["PNT_1091"] = Mfd_button(_("T1"),						devices.FC3,	device_commands.T1,			1091,1,{0,1},JAS39MFD1) -- lower row RD softkeys (use to test)
elements["PNT_1092"] = Mfd_button(_("T2"),						devices.FC3,	device_commands.T2,			1092,1,{0,1},JAS39MFD1) -- lower row RD softkeys (use to test)
elements["PNT_1093"] = Mfd_button(_("T3"),						devices.FC3,	device_commands.T3,			1093,1,{0,1},JAS39MFD1) -- lower row RD softkeys (use to test)
elements["PNT_1094"] = Mfd_button(_("T4"),						devices.FC3,	device_commands.T4,			1094,1,{0,1},JAS39MFD1) -- lower row RD softkeys (use to test)
elements["PNT_1095"] = Mfd_button(_("T5"),						devices.FC3,	device_commands.T5,			1095,1,{0,1},JAS39MFD1) -- lower row RD softkeys (use to test)
elements["PNT_1096"] = Mfd_button(_("T6"),						devices.FC3,	device_commands.T6,			1096,1,{0,1},JAS39MFD1) -- lower row RD softkeys (use to test)
-------------------------------------------------------
--Left Console Panel
------------------------------------------------------- 
elements["PNT_564"] = default_2_position_tumb(_("AAR Probe Cover (Open/Close)"),	devices.CANOPY,	device_commands.AARProbeCover, 	564,JAS39KNOB1)
elements["PNT_963"] = default_2_position_tumb(_("AAR Probe (In/Out)"),	devices.CANOPY,	device_commands.AARProbe, 	963,JAS39CLICK2)
elements["PNT_947"] = default_2_position_tumb(_("Covert Lights (Covert/Normal)"),	devices.LIGHTS,	device_commands.CovertLights,  947,JAS39CLICK2)
elements["PNT_948"]	= multiposition_switch_limited(_("Formation lights (Off/1/2/3/4)"),	devices.LIGHTS, device_commands.FormationLights, 948, 5, 0.5, false, -1, JAS39KNOB2, 3.0)
elements["PNT_950"] = default_3_position_tumb(_("Navigation Lights (Off/Dim/Bright)"),	devices.LIGHTS, device_commands.NavigationLights, 950,nil,true,JAS39CLICK2)
elements["PNT_951"] = default_2_position_tumb(_("Navigation Lights Flash (Flash/Steady)"),	devices.LIGHTS,	device_commands.FormFlashLights,  951,JAS39CLICK2)
elements["PNT_952"] = default_2_position_tumb(_("Anti collision Lights (On/Off)"),	devices.LIGHTS,	device_commands.AntiCollisionLights,  952,JAS39CLICK2)
elements["PNT_980"] = springloaded_3_pos_tumb(_("Seat (Down/Up"),	devices.CANOPY,	device_commands.SeatUpDown,  980,false,JAS39CLICK2,10)
elements["PNT_1065"] = default_3_position_tumb(_("Landing and Taxi Lights (Land/Off/Taxi"),	devices.LIGHTS, device_commands.LandingTaxiLights, 1065,nil,true,JAS39CLICK2)
elements["PNT_1011"] = default_2_position_tumb(_("Fuel Switch Cover (Open/Close)"),	devices.ENGINE,	device_commands.FuelCover, 	1011,JAS39KNOB1)
elements["PNT_1010"] = default_2_position_tumb(_("Fuel Switch (On/Off)"),	devices.ENGINE,	device_commands.Fuel, 	1010,JAS39CLICK2)
-------------------------------------------------------
--Left Auxiliary Console
-------------------------------------------------------
elements["PNT_1003"] = default_2_position_tumb(_("Landing Gear (Up/Down)"),	devices.GEAR,	device_commands.LandingGearLever,	1003,JAS39HEAVYSWITCH,1.5)
elements["PNT_1060"] = springloaded_3_pos_tumb(_("Start (On/Off)"),	devices.ENGINE,	device_commands.Start, 	1060, false, JAS39KNOB1,5)
elements["PNT_1080"] = default_2_position_tumb(_("Emergency Jettison Cover (Open/Close)"),	devices.WEAPONS,	device_commands.EmergencyJettisonCover, 	1080,JAS39KNOB1)
elements["PNT_1081"] = default_button(_("Emergency Jettison"),	devices.WEAPONS,	device_commands.EmergencyJettison,	1081,1,{0,1},JAS39CLICK1)
-------------------------------------------------------
--UCP (Upfront Control Panel)
-------------------------------------------------------
--elements["PNT_1238"] = default_axis_limited(_("HUD Brightness"),		devices.DISPLAYS,	device_commands.HUD_Brightness, 1238)
elements["PNT_1238"] = default_axis_limited(_("HUD Brightness"),        devices.DISPLAYS,   device_commands.HUD_Brightness, 1238, 0, 0.1, false, false, {0, 1})
elements["PNT_1262"] = Mfd_button(_("MENU"),							devices.UCP,	 	device_commands.UCP_MENU,	    1262,1,{0,1},JAS39MFD1)
--elements["PNT_1263"] = Mfd_button(_("1"),								devices.UCP,		device_commands.UCP_1,			1263,1,{0,1},JAS39MFD1)
elements["PNT_1263"] = Mfd_button(_("COM1 (Comms menu)"),				devices.FC3,		device_commands.COM1,			1263,1,{0,1},JAS39MFD1)
elements["PNT_1264"] = Mfd_button(_("T (2)"),							devices.UCP,		device_commands.UCP_2,			1264,1,{0,1},JAS39MFD1)
elements["PNT_1265"] = Mfd_button(_("LP (3)"),							devices.UCP,		device_commands.UCP_3,			1265,1,{0,1},JAS39MFD1)
elements["PNT_1266"] = Mfd_button(_("DAT (+/-)"),						devices.UCP,		device_commands.UCP_DAT,		1266,1,{0,1},JAS39MFD1)
elements["PNT_1267"] = Mfd_button(_("SHIFT"),							devices.UCP,		device_commands.UCP_SHIFT,		1267,1,{0,1},JAS39MFD1)
--elements["PNT_1268"] = Mfd_button(_("4"),								devices.UCP,		device_commands.UCP_4,			1268,1,{0,1},JAS39MFD1)
elements["PNT_1268"] = Mfd_button(_("COM2 (Rearm and refuel)"),			devices.FC3,		device_commands.COM2,			1268,1,{0,1},JAS39MFD1)
elements["PNT_1269"] = Mfd_button(_("W (5)"),							devices.UCP,		device_commands.UCP_5,			1269,1,{0,1},JAS39MFD1)
elements["PNT_1270"] = Mfd_button(_("OF (6)"),							devices.UCP,		device_commands.UCP_6,			1270,1,{0,1},JAS39MFD1)
elements["PNT_1271"] = Mfd_button(_("IFF (0)"),							devices.UCP,		device_commands.UCP_0,			1271,1,{0,1},JAS39MFD1)
elements["PNT_1272"] = Mfd_button(_("ENTER"),							devices.UCP,		device_commands.UCP_AMFM_ENT,	1272,1,{0,1},JAS39MFD1)
elements["PNT_1273"] = Mfd_button(_("CP (7)"),							devices.UCP,		device_commands.UCP_7,			1273,1,{0,1},JAS39MFD1)
--elements["PNT_1274"] = Mfd_button(_("8"),								devices.UCP,		device_commands.UCP_8,			1274,1,{0,1},JAS39MFD1)
elements["PNT_1274"] = Mfd_button(_("L (8)"),							devices.UCP,		device_commands.UCP_L,			1274,1,{0,1},JAS39MFD1)
elements["PNT_1275"] = Mfd_button(_("D (9)"),							devices.UCP,		device_commands.UCP_9,			1275,1,{0,1},JAS39MFD1)
elements["PNT_1276"] = Mfd_button(_("CLR"),								devices.UCP,		device_commands.UCP_CLR,		1276,1,{0,1},JAS39MFD1)
elements["PNT_1249"] = default_axis_limited(_("UCP Brightness"),		devices.UCP,		device_commands.UCP_Brightness, 1243, 0, 0.1, false, false, {0, 1})


-- elements["PNT_1263"] = Mfd_button(_("COM1 EDIT"),						devices.UCP,		device_commands.UCP_COM1_EDIT,	1263,1,{0,1},JAS39MFD1)
--elements["PNT_1327"] = Mfd_button(_("COM2 EDIT"),						devices.UCP,		device_commands.UCP_COM2_EDIT,	1327,1,{0,1},JAS39MFD1)
--elements["PNT_1331"] = Mfd_button(_("AUX EDIT"),						devices.UCP,		device_commands.UCP_AUX_EDIT,	1331,1,{0,1},JAS39MFD1)
--elements["PNT_934"]	 = default_axis_limited(_("PTT1"),					devices.UCP,	 	device_commands.UCP_PTT1,	    934)
--elements["PNT_938"]	 = default_axis_limited(_("PTT2"),					devices.UCP,	 	device_commands.UCP_PTT2,	    938)
--elements["PNT_939"]  = default_axis_limited(_("Volume"),				devices.UCP,	 	device_commands.UCP_VOL,	    939)
--elements["PNT_935"]  = default_2_position_tumb(_("TELE (on/off)"),		devices.UCP,		device_commands.UCP_TELE_OFF,   935,JAS39CLICK2)
-------------------------------------------------------
--Instrument Panel
-------------------------------------------------------
elements["PNT_1280"] = default_axis_limited(_("MFD Brightness Master"),	devices.DISPLAYS, device_commands.MASTER_BRIGHTNESS, 1280)--Work
elements["PNT_842"]  = Mfd_button(_("Master Caution"),  devices.CANOPY, device_commands.MasterCaution,  842,1,{0,1},JAS39CLICK1)






-- LCP ====
elements["LCP_Button_X"]   = Mfd_button(_("X"),		devices.LCP,	device_commands.LCP_X,		1335,1,{0,1},JAS39MFD1)
elements["LCP_Button_SYS"] = Mfd_button(_("SYS"),	devices.LCP,	device_commands.LCP_SYS,	1336,1,{0,1},JAS39MFD1)
elements["LCP_Button_TAC"] = Mfd_button(_("TAC"),	devices.LCP,	device_commands.LCP_TAC,	1337,1,{0,1},JAS39MFD1)
elements["LCP_Button_IFF"] = Mfd_button(_("IFF"),	devices.LCP,	device_commands.LCP_IFF,	1338,1,{0,1},JAS39MFD1)
elements["LCP_Button_COM"] = Mfd_button(_("COM"),	devices.LCP,	device_commands.LCP_COM,	1339,1,{0,1},JAS39MFD1)


elements["LCP_MFD_1"]  = Mfd_button(_("LCP Softkey 01"),	devices.LCP,	device_commands.LCP_SK01,	1340,1,{0,1},JAS39MFD1)
elements["LCP_MFD_2"]  = Mfd_button(_("LCP Softkey 02"),	devices.LCP,	device_commands.LCP_SK02,	1341,1,{0,1},JAS39MFD1)
elements["LCP_MFD_3"]  = Mfd_button(_("LCP Softkey 03"),	devices.LCP,	device_commands.LCP_SK03,	1342,1,{0,1},JAS39MFD1)
elements["LCP_MFD_4"]  = Mfd_button(_("LCP Softkey 04"),	devices.LCP,	device_commands.LCP_SK04,	1343,1,{0,1},JAS39MFD1)
elements["LCP_MFD_5"]  = Mfd_button(_("LCP Softkey 05"),	devices.LCP,	device_commands.LCP_SK05,	1344,1,{0,1},JAS39MFD1)
elements["LCP_MFD_6"]  = Mfd_button(_("LCP Softkey 06"),	devices.LCP,	device_commands.LCP_SK06,	1345,1,{0,1},JAS39MFD1)
elements["LCP_MFD_7"]  = Mfd_button(_("LCP Softkey 07"),	devices.LCP,	device_commands.LCP_SK07,	1346,1,{0,1},JAS39MFD1)
elements["LCP_MFD_8"]  = Mfd_button(_("LCP Softkey 08"),	devices.LCP,	device_commands.LCP_SK08,	1347,1,{0,1},JAS39MFD1)
elements["LCP_MFD_9"]  = Mfd_button(_("LCP Softkey 09"),	devices.LCP,	device_commands.LCP_SK09,	1348,1,{0,1},JAS39MFD1)
elements["LCP_MFD_10"] = Mfd_button(_("LCP Softkey 10"),	devices.LCP,	device_commands.LCP_SK10,	1349,1,{0,1},JAS39MFD1)
elements["LCP_MFD_11"] = Mfd_button(_("LCP Softkey 11"),	devices.LCP,	device_commands.LCP_SK11,	1350,1,{0,1},JAS39MFD1)
elements["LCP_MFD_12"] = Mfd_button(_("LCP Softkey 12"),	devices.LCP,	device_commands.LCP_SK12,	1351,1,{0,1},JAS39MFD1)
elements["LCP_MFD_13"] = Mfd_button(_("LCP Softkey 13"),	devices.LCP,	device_commands.LCP_SK13,	1371,1,{0,1},JAS39MFD1)	--missing animation


elements["LCP_Brightness_Knob"]	= default_axis_limited(_("LCP Brightness"),	devices.LCP, device_commands.LCP_Brightness, 1352, 0, 0.1, false, false, {0, 1})
elements["LCP_Contrast_Knob"]	= default_axis_limited(_("LCP Contrast"),	devices.LCP, device_commands.LCP_Contrast,   1353, 0, 0.1, false, false, {0, 1})




elements["LCP_Button_1"] = Mfd_button(_("1"),	devices.LCP,	device_commands.LCP_1,	1354,1,{0,1},JAS39MFD1)
elements["LCP_Button_2"] = Mfd_button(_("2"),	devices.LCP,	device_commands.LCP_2,	1355,1,{0,1},JAS39MFD1)
elements["LCP_Button_3"] = Mfd_button(_("3"),	devices.LCP,	device_commands.LCP_3,	1356,1,{0,1},JAS39MFD1)
elements["LCP_Button_4"] = Mfd_button(_("4"),	devices.LCP,	device_commands.LCP_4,	1357,1,{0,1},JAS39MFD1)
elements["LCP_Button_5"] = Mfd_button(_("5"),	devices.LCP,	device_commands.LCP_5,	1358,1,{0,1},JAS39MFD1)
elements["LCP_Button_CLR"] = Mfd_button(_("Clear"),	devices.LCP,	device_commands.LCP_CLR,	1359,1,{0,1},JAS39MFD1)
elements["LCP_Button_6"] = Mfd_button(_("6"),	devices.LCP,	device_commands.LCP_6,	1360,1,{0,1},JAS39MFD1)
elements["LCP_Button_7"] = Mfd_button(_("7"),	devices.LCP,	device_commands.LCP_7,	1361,1,{0,1},JAS39MFD1)
elements["LCP_Button_8"] = Mfd_button(_("8"),	devices.LCP,	device_commands.LCP_8,	1362,1,{0,1},JAS39MFD1)
elements["LCP_Button_9"] = Mfd_button(_("9"),	devices.LCP,	device_commands.LCP_9,	1363,1,{0,1},JAS39MFD1)
elements["LCP_Button_0"] = Mfd_button(_("0"),	devices.LCP,	device_commands.LCP_0,	1364,1,{0,1},JAS39MFD1)
elements["LCP_Button_ENT"] = Mfd_button(_("Enter"),	devices.LCP,	device_commands.LCP_ENT,	1365,1,{0,1},JAS39MFD1) -- missing animation





-------------------------------------------------------
--LD
-------------------------------------------------------
elements["PNT_1031"] = Mfd_button(_("Softkey 1 LD") ,devices.DISPLAYS, device_commands.LDSK_1,  1031,0.5,{0,1},JAS39MFD1)
elements["PNT_1032"] = Mfd_button(_("Softkey 2 LD") ,devices.DISPLAYS, device_commands.LDSK_2,  1032,1,{0,1},JAS39MFD1)
elements["PNT_1033"] = Mfd_button(_("Softkey 3 LD") ,devices.DISPLAYS, device_commands.LDSK_3,  1033,1,{0,1},JAS39MFD1)
elements["PNT_1034"] = Mfd_button(_("Softkey 4 LD") ,devices.DISPLAYS, device_commands.LDSK_4,  1034,1,{0,1},JAS39MFD1)
elements["PNT_1035"] = Mfd_button(_("Softkey 5 LD") ,devices.DISPLAYS, device_commands.LDSK_5,  1035,1,{0,1},JAS39MFD1)
elements["PNT_1036"] = Mfd_button(_("Softkey 6 LD") ,devices.DISPLAYS, device_commands.LDSK_6,  1036,1,{0,1},JAS39MFD1)
elements["PNT_1037"] = Mfd_button(_("Softkey 7 LD") ,devices.DISPLAYS, device_commands.LDSK_7,  1037,1,{0,1},JAS39MFD1)
elements["PNT_1041"] = Mfd_button(_("Softkey 8 LD") ,devices.DISPLAYS, device_commands.LDSK_8,  1041,1,{0,1},JAS39MFD1)
elements["PNT_1042"] = Mfd_button(_("Softkey 9 LD") ,devices.DISPLAYS, device_commands.LDSK_9,  1042,1,{0,1},JAS39MFD1)
elements["PNT_1043"] = Mfd_button(_("Softkey 10 LD"),devices.DISPLAYS, device_commands.LDSK_10, 1043,1,{0,1},JAS39MFD1)
elements["PNT_1044"] = Mfd_button(_("Softkey 11 LD"),devices.DISPLAYS, device_commands.LDSK_11, 1044,1,{0,1},JAS39MFD1)
elements["PNT_1045"] = Mfd_button(_("Softkey 12 LD"),devices.DISPLAYS, device_commands.LDSK_12, 1045,1,{0,1},JAS39MFD1)
elements["PNT_1046"] = Mfd_button(_("Softkey 13 LD"),devices.DISPLAYS, device_commands.LDSK_13, 1046,1,{0,1},JAS39MFD1)																								
elements["PNT_1057"] = Mfd_button(_("Softkey 14 LD"),devices.DISPLAYS, device_commands.LDSK_14, 1057,1,{0,1},JAS39MFD1)
elements["PNT_1056"] = Mfd_button(_("Softkey 15 LD"),devices.DISPLAYS, device_commands.LDSK_15, 1056,1,{0,1},JAS39MFD1)
elements["PNT_1055"] = Mfd_button(_("Softkey 16 LD"),devices.DISPLAYS, device_commands.LDSK_16, 1055,1,{0,1},JAS39MFD1)
elements["PNT_1054"] = Mfd_button(_("Softkey 17 LD"),devices.DISPLAYS, device_commands.LDSK_17, 1054,1,{0,1},JAS39MFD1)
elements["PNT_1053"] = Mfd_button(_("Softkey 18 LD"),devices.DISPLAYS, device_commands.LDSK_18, 1053,1,{0,1},JAS39MFD1)
elements["PNT_1052"] = Mfd_button(_("Softkey 19 LD"),devices.DISPLAYS, device_commands.LDSK_19, 1052,1,{0,1},JAS39MFD1)
elements["PNT_1051"] = Mfd_button(_("Softkey 20 LD"),devices.DISPLAYS, device_commands.LDSK_20, 1051,1,{0,1},JAS39MFD1)
-- Brighness+Contrast  Mfd_button

elements["PNT_1038"] = Mfd_button(_("Brightness + LD"),devices.DISPLAYS, device_commands.LD_Brightness_Up,   1038,-1,{-1,1},JAS39MFD1)
elements["PNT_1039"] = Mfd_button(_("Brightness - LD"),devices.DISPLAYS, device_commands.LD_Brightness_Down, 1038,1,{-1,1},JAS39MFD1)
elements["PNT_1058"] = Mfd_button(_("Contrast + LD")  ,devices.DISPLAYS, device_commands.LD_Contrast_Up,     1058,1,{0,1},JAS39MFD1)
elements["PNT_1059"] = Mfd_button(_("Contrast - LD")  ,devices.DISPLAYS, device_commands.LD_Contrast_Down,   1059,1,{0,1},JAS39MFD1)
-------------------------------------------------------
--CD
-------------------------------------------------------
elements["PNT_1200"] = Mfd_button(_("Softkey 1 CD") ,devices.DISPLAYS, device_commands.CDSK_1,  1200,1,{0,1},JAS39MFD1)
elements["PNT_1201"] = Mfd_button(_("Softkey 2 CD") ,devices.DISPLAYS, device_commands.CDSK_2,  1201,1,{0,1},JAS39MFD1)
elements["PNT_1202"] = Mfd_button(_("Softkey 3 CD") ,devices.DISPLAYS, device_commands.CDSK_3,  1202,1,{0,1},JAS39MFD1)
elements["PNT_1203"] = Mfd_button(_("Softkey 4 CD") ,devices.DISPLAYS, device_commands.CDSK_4,  1203,1,{0,1},JAS39MFD1)
elements["PNT_1204"] = Mfd_button(_("Softkey 5 CD") ,devices.DISPLAYS, device_commands.CDSK_5,  1204,1,{0,1},JAS39MFD1)
elements["PNT_1205"] = Mfd_button(_("Softkey 6 CD") ,devices.DISPLAYS, device_commands.CDSK_6,  1205,1,{0,1},JAS39MFD1)
elements["PNT_1206"] = Mfd_button(_("Softkey 7 CD") ,devices.DISPLAYS, device_commands.CDSK_7,  1206,1,{0,1},JAS39MFD1)
elements["PNT_1209"] = Mfd_button(_("Softkey 8 CD") ,devices.DISPLAYS, device_commands.CDSK_8,  1209,1,{0,1},JAS39MFD1)
elements["PNT_1210"] = Mfd_button(_("Softkey 9 CD") ,devices.DISPLAYS, device_commands.CDSK_9,  1210,1,{0,1},JAS39MFD1)
elements["PNT_1211"] = Mfd_button(_("Softkey 10 CD"),devices.DISPLAYS, device_commands.CDSK_10, 1211,1,{0,1},JAS39MFD1)
elements["PNT_1212"] = Mfd_button(_("Softkey 11 CD"),devices.DISPLAYS, device_commands.CDSK_11, 1212,1,{0,1},JAS39MFD1)
elements["PNT_1213"] = Mfd_button(_("Softkey 12 CD"),devices.DISPLAYS, device_commands.CDSK_12, 1213,1,{0,1},JAS39MFD1)
elements["PNT_1214"] = Mfd_button(_("Softkey 13 CD"),devices.DISPLAYS, device_commands.CDSK_13, 1214,1,{0,1},JAS39MFD1)																								
elements["PNT_1221"] = Mfd_button(_("Softkey 14 CD"),devices.DISPLAYS, device_commands.CDSK_14, 1221,1,{0,1},JAS39MFD1)
elements["PNT_1220"] = Mfd_button(_("Softkey 15 CD"),devices.DISPLAYS, device_commands.CDSK_15, 1220,1,{0,1},JAS39MFD1)
elements["PNT_1219"] = Mfd_button(_("Softkey 16 CD"),devices.DISPLAYS, device_commands.CDSK_16, 1219,1,{0,1},JAS39MFD1)
elements["PNT_1218"] = Mfd_button(_("Softkey 17 CD"),devices.DISPLAYS, device_commands.CDSK_17, 1218,1,{0,1},JAS39MFD1)
elements["PNT_1217"] = Mfd_button(_("Softkey 18 CD"),devices.DISPLAYS, device_commands.CDSK_18, 1217,1,{0,1},JAS39MFD1)
elements["PNT_1216"] = Mfd_button(_("Softkey 19 CD"),devices.DISPLAYS, device_commands.CDSK_19, 1216,1,{0,1},JAS39MFD1)
-- Brighness+Contrast  Mfd_button
elements["PNT_1207"] = Mfd_button(_("Brightness + CD"),devices.DISPLAYS, device_commands.CD_Brightness_Up,   1207,-1,{-1,1},JAS39MFD1)
elements["PNT_1208"] = Mfd_button(_("Brightness - CD"),devices.DISPLAYS, device_commands.CD_Brightness_Down, 1207,1,{-1,1},JAS39MFD1)
elements["PNT_1222"] = Mfd_button(_("Contrast + CD")  ,devices.DISPLAYS, device_commands.CD_Contrast_Up,     1222,1,{0,1},JAS39MFD1)
elements["PNT_1223"] = Mfd_button(_("Contrast - CD")  ,devices.DISPLAYS, device_commands.CD_Contrast_Down,   1223,1,{0,1},JAS39MFD1)
-------------------------------------------------------
--RD (Check FC3 Commands)
-------------------------------------------------------
elements["PNT_1082"] = Mfd_button(_("Softkey 1 RD") ,devices.DISPLAYS, device_commands.RDSK_1,  1082,1,{0,1},JAS39MFD1)
--[[

elements["PNT_1083"] = Mfd_button(_("Softkey 2 RD") ,devices.DISPLAYS, device_commands.RDSK_2,  1083,1,{0,1},JAS39MFD1)
elements["PNT_1084"] = Mfd_button(_("Softkey 3 RD") ,devices.DISPLAYS, device_commands.RDSK_3,  1084,1,{0,1},JAS39MFD1)
elements["PNT_1085"] = Mfd_button(_("Softkey 4 RD") ,devices.DISPLAYS, device_commands.RDSK_4,  1085,1,{0,1},JAS39MFD1)
elements["PNT_1086"] = Mfd_button(_("Softkey 5 RD") ,devices.DISPLAYS, device_commands.RDSK_5,  1086,1,{0,1},JAS39MFD1)
elements["PNT_1087"] = Mfd_button(_("Softkey 6 RD") ,devices.DISPLAYS, device_commands.RDSK_6,  1087,1,{0,1},JAS39MFD1)
elements["PNT_1088"] = Mfd_button(_("Softkey 7 RD") ,devices.DISPLAYS, device_commands.RDSK_7,  1088,1,{0,1},JAS39MFD1)
elements["PNT_1091"] = Mfd_button(_("Softkey 8 RD") ,devices.DISPLAYS, device_commands.RDSK_8,  1091,1,{0,1},JAS39MFD1)
elements["PNT_1092"] = Mfd_button(_("Softkey 9 RD") ,devices.DISPLAYS, device_commands.RDSK_9,  1092,1,{0,1},JAS39MFD1)
elements["PNT_1093"] = Mfd_button(_("Softkey 10 RD"),devices.DISPLAYS, device_commands.RDSK_10, 1093,1,{0,1},JAS39MFD1)
elements["PNT_1094"] = Mfd_button(_("Softkey 11 RD"),devices.DISPLAYS, device_commands.RDSK_11, 1094,1,{0,1},JAS39MFD1)
elements["PNT_1095"] = Mfd_button(_("Softkey 12 RD"),devices.DISPLAYS, device_commands.RDSK_12, 1095,1,{0,1},JAS39MFD1)
elements["PNT_1096"] = Mfd_button(_("Softkey 13 RD"),devices.DISPLAYS, device_commands.RDSK_13, 1096,1,{0,1},JAS39MFD1)																								
elements["PNT_1097"] = Mfd_button(_("Softkey 14 RD"),devices.DISPLAYS, device_commands.RDSK_14, 1097,1,{0,1},JAS39MFD1)
elements["PNT_1098"] = Mfd_button(_("Softkey 15 RD"),devices.DISPLAYS, device_commands.RDSK_15, 1098,1,{0,1},JAS39MFD1)
elements["PNT_1099"] = Mfd_button(_("Softkey 16 RD"),devices.DISPLAYS, device_commands.RDSK_16, 1099,1,{0,1},JAS39MFD1)
elements["PNT_1100"] = Mfd_button(_("Softkey 17 RD"),devices.DISPLAYS, device_commands.RDSK_17, 1100,1,{0,1},JAS39MFD1)
elements["PNT_1101"] = Mfd_button(_("Softkey 18 RD"),devices.DISPLAYS, device_commands.RDSK_18, 1101,1,{0,1},JAS39MFD1)
elements["PNT_1102"] = Mfd_button(_("Softkey 19 RD"),devices.DISPLAYS, device_commands.RDSK_19, 1102,1,{0,1},JAS39MFD1)
elements["PNT_1103"] = Mfd_button(_("Softkey 20 RD"),devices.DISPLAYS, device_commands.RDSK_20, 1103,1,{0,1},JAS39MFD1)
]]--
-- Brighness+Contrast  Mfd_button
elements["PNT_1089"] = Mfd_button(_("Brightness + RD"),devices.DISPLAYS, device_commands.RD_Brightness_Up,   1089,-1,{0,1},JAS39MFD1)
elements["PNT_1090"] = Mfd_button(_("Brightness - RD"),devices.DISPLAYS, device_commands.RD_Brightness_Down, 1089,1,{0,1},JAS39MFD1)
elements["PNT_1104"] = Mfd_button(_("Contrast + RD")  ,devices.DISPLAYS, device_commands.RD_Contrast_Up,     1104,1,{0,1},JAS39MFD1)
elements["PNT_1105"] = Mfd_button(_("Contrast - RD")  ,devices.DISPLAYS, device_commands.RD_Contrast_Down,   1105,1,{0,1},JAS39MFD1)
-- Brighness+Contrast  Mfd_button
elements["PNT_1089"] = Mfd_button(_("Brightness + RD"),devices.DISPLAYS, device_commands.RD_Brightness_Up,   1089,-1,{-1,1},JAS39MFD1)
elements["PNT_1090"] = Mfd_button(_("Brightness - RD"),devices.DISPLAYS, device_commands.RD_Brightness_Down, 1089,1,{-1,1},JAS39MFD1)
elements["PNT_1104"] = Mfd_button(_("Contrast + RD")  ,devices.DISPLAYS, device_commands.RD_Contrast_Up,     1104,1,{0,1},JAS39MFD1)
elements["PNT_1105"] = Mfd_button(_("Contrast - RD")  ,devices.DISPLAYS, device_commands.RD_Contrast_Down,   1105,1,{0,1},JAS39MFD1)
-------------------------------------------------------
--Right Auxiliary Console
-------------------------------------------------------
elements["PNT_1281"] = fika_compartment("Compartment (Open/Close)", devices.ACCESSORIES, device_commands.Compartment, 1281,JAS39HEAVYSWITCH, 1)
-------------------------------------------------------
--Right Console Panel
-------------------------------------------------------
elements["PNT_946"]	= default_axis_limited(_("Flood Lights"),	devices.LIGHTS, device_commands.FloodLight, 946)
elements["PNT_945"]	= default_axis_limited(_("Backlights"),	devices.LIGHTS, device_commands.BackLight, 945)
elements["PNT_944"]	= default_axis_limited(_("Indicator Lights"),	devices.LIGHTS, device_commands.IndicatorLight, 944)
elements["PNT_1013"] = default_3_position_tumb(_("Mass (Safe/Stby/Live)"),	devices.WEAPONS,	device_commands.Mass, 	1013,nil,true,JAS39KNOB2)
elements["PNT_904"] = default_2_position_tumb(_("Main Power (On/Off)"),	devices.ENGINE,	device_commands.Main, 	904,JAS39CLICK2)
elements["PNT_1061"] = default_2_position_tumb(_("APU (On/Off)"),	devices.ENGINE,	device_commands.APU, 	1061,JAS39CLICK2)
elements["PNT_1005"] = default_2_position_tumb("Canopy (Open/Close)", devices.CANOPY, device_commands.CanopyLever, 1005,JAS39HEAVYSWITCH, 1.5)
elements["PNT_1018"] = default_2_position_tumb(_("Tank Jettison Cover (Open/Close)"),	devices.WEAPONS,	device_commands.TankJettisonCover, 	1018,JAS39KNOB1)
elements["PNT_1016"] = default_button(_("Tank Jettison"),	devices.WEAPONS,	device_commands.TankJettison,	1016,1,{0,1},JAS39CLICK1)
elements["PNT_1017"] = default_2_position_tumb(_("Weapons Jettison Cover (Open/Close)"),	devices.WEAPONS,	device_commands.WeaponJettisonCover, 	1017,JAS39KNOB1)
elements["PNT_1015"] = default_button(_("Weapons Jettison"),  devices.WEAPONS, device_commands.WeaponJettison,   	1014,1,{0,1}, JAS39CLICK1)
elements["PNT_976"] = default_2_position_tumb(_("Parking Brake (Enable/Disable)"),	devices.WHEEL_BRAKES,	device_commands.ParkingBrake,	976,JAS39KNOB2,3.0)
elements["PNT_1012"] = default_2_position_tumb(_("Canopy Jettison (Enable/Disable)"),	devices.CANOPY,	device_commands.CanopyJettison,	1012,JAS39KNOB2,3.0)
elements["PNT_953"] = default_2_position_tumb(_("DTU (Insert/Eject)"),	devices.ENGINE,	device_commands.DTU, 	953,JAS39MFD1,1.0)
-------------------------------------------------------
--HOTAS
-------------------------------------------------------
elements["PNT_571"] = default_2_position_tumb(_("ThrottleStop (On/Off)"),	devices.ENGINE,	device_commands.ThrottleStop, 	571,JAS39KNOB2,3.0)
elements["PNT_1075"] = default_2_position_tumb(_("Trigger Safe (Safe/Armed)"),	devices.WEAPONS,	device_commands.TriggerSafe, 	1075,JAS39MFD1)
-------------------------------------------------------
--Ejection Seat
-------------------------------------------------------
elements["PNT_973"] = default_axis_limited(_("Ejection handle"),  devices.CANOPY, device_commands.SeatEject,  973)
elements["PNT_972"] = default_2_position_tumb(_("Ejection Seat (Safe/Arm)"),	devices.CANOPY,	device_commands.SeatArm,	972,JAS39HEAVYSWITCH,1.5)
-------------------------------------------------------
--FOR REFERENCE 
-------------------------------------------------------
-- elements["PNT_1015"] =
-- {
	-- class 							= {class_type.BTN},
	-- hint 							= ("Weapons Jettison"),
	-- device 							= devices.WEAPONS,
	-- action 							= {device_commands.WeaponJettison, 1},
	-- stop_action 					= {device_commands.WeaponJettison, 0},
	-- arg 							= {1014},
	-- arg_value 						= {1.0},
	-- arg_lim 						= {0, 1},
	-- use_release_message 			= {false},
    -- sound 							= {JAS39CLICK1},
-- }	

-- elements["PNT-017"]	= default_2_position_tumb(_("Power, BATT OFF/ON"),	devices.EFM_HELPER, EFM_commands.batterySwitch,	17, CH47CLICK1)

-- EFM system
-- elements["PNT-017"]	= default_2_position_tumb(_("Power, BATT OFF/ON"),	devices.EFM_HELPER, EFM_commands.batterySwitch,	17, CH47CLICK1)
-- elements["PNT-016"]	= default_2_position_tumb(_("Generators Switch, ON/OFF"), devices.EFM_HELPER, EFM_commands.generatorSwitch,	16,  CH47CLICK1, 0.5)
-- elements["PNT-015"]	= default_2_position_tumb(_("APU Power Switch, ON/OFF"), devices.EFM_HELPER, EFM_commands.inverterSwitch,	15, CH47APU_Start_In)
-- elements["PNT-004"]	= default_axis_limited(_("Pilot Throttle"),	devices.EFM_HELPER, EFM_commands.throttle, 4)
-- elements["PNT-004a"]	= default_axis_limited(_("Co-Pilot Throttle"),	devices.EFM_HELPER, EFM_commands.throttle, 4)
-- elements["PNT-005"]	= default_2_position_tumb(_("Fuel X-feed"),	devices.EFM_HELPER, EFM_commands.throttleIdleCutoff, 5, CH47CLICK1, 3)
-- elements["PNT-058"]	= springloaded_3_pos_tumb(_("Engine Start"),	devices.EFM_HELPER, EFM_commands.starterButton,	58, false, CH47Starter, 3)--springloaded_3_pos_tumb
-- elements["PNT-2002"] = default_button(_("Reset Trim"), devices.EFM_HELPER, EFM_commands.trimReset, 603)
-- elements["PNT-003"]	= default_axis(_("Collective Pilot"),	devices.EFM_HELPER, EFM_commands.JoystickThrottle, 3, -1, 1, true, false, false)
-- elements["PNT-003a"]	= default_axis(_("Collective CoPilot"),	devices.EFM_HELPER, EFM_commands.JoystickThrottle, 3, -1, 1, true, false, false)

-- cockpit
-- elements["DoorHandle"] = default_2_position_tumb(_("Open Door"), devices.OPENDOOR, device_commands.Opendoorsw, 38, CH47HEAVYSWITCH, 0.5)
-- elements["DoorHandleL"] = default_2_position_tumb(_("Open Door"), devices.OPENDOOR, device_commands.Opendoorsw, 38, CH47HEAVYSWITCH, 0.5)
-- elements["PNT-DOOR"] = default_2_position_tumb(_("Open Inner Door"), devices.OPENDOOR, device_commands.Opendoorsw1, 39, CH47HEAVYSWITCH, 0.5)
-- elements["PNT-2006"]	= default_2_position_tumb(_("Wipers, OFF/ON"),	devices.WIPERS, 	device_commands.Wipersw, 2006)
-- elements["PNT-2003"] = default_2_position_tumb(_("Parking Brake"), devices.ENGINE, device_commands.parkbrake, 2003, CH47SLIDE2, 0.8)
-- elements["STEER-MANUAL"]	= default_axis_limited(_("Manual Steering"),	devices.STEERING, device_commands.steeringwheel, 202, 0, nil, nil, nil, {-1,1})
-- elements["STEER-LOCK"] = default_2_position_tumb(_("Steering Lock"),	devices.STEERING, device_commands.SteerlockSw,	203, CH47CLICK1 )


-- Engines
-- elements["PNT-012"]	= multiposition_switch3(_("Engine Condition Levers, ECL"),	devices.ENGINE, device_commands.ECL, 12, 3, 0.5, false, -1, 0.7, false) --CH47HEAVYSWITCH
-- elements["PNT-012"]	= multiposition_switch_limited(_("Engine Condition Levers, ECL"),	devices.ENGINE, device_commands.ECL, 12, 3, 0.5, true, 0, CH47HEAVYSWITCH, 0.7)
-- elements["PNT-3009"]	= default_2_position_tumb(_("Ignition Lock"),	devices.ENGINE, device_commands.ignitionlock, 3509, CH47SLIDE, 0.9)
-- elements["PNT-020"]	= default_2_position_tumb(_("APU Generator"),	devices.ENGINE, device_commands.APUGEN,	20, CH47CLICK1)
-- elements["PNT-058"]	= springloaded_2_pos_tumb(_("Engine Start"),	devices.ENGINE, device_commands.starterfake, 58, 3)
-- elements["PNT-058"]	= springloaded_3_pos_tumb(_("Engine Start"),	devices.ENGINE, device_commands.starterfake,	58, false, CH47Starter, 3)--springloaded_3_pos_tumb
-- elements["PNT-031"]	= default_2_position_tumb(_("Power Xfer Switches"),	devices.ENGINE, device_commands.PowerXfer,	31, CH47CLICK1, 1)
-- elements["EAPS-1"]	= default_2_position_tumb(_("EAPS engine 1"),	devices.ENGINE,	device_commands.EAPS1, 95, CH47SLIDE, 0.4)
-- elements["EAPS-2"]	= default_2_position_tumb(_("EAPS engine 2"),	devices.ENGINE,	device_commands.EAPS2, 96, CH47SLIDE, 0.8)
-- elements["PNT-Manual"]	= default_2_position_tumb(_("Startup Procedure"),	devices.ENGINE,	device_commands.StartupManual, 4501, CH47SLIDE, 0.8)



-- Fuel System
-- elements["PNT-018"]	= default_2_position_tumb(_("Emergency Fuel OFF Switch"),	devices.FUEL_SYSTEM,	device_commands.FuelShutoffSw,	18, 0.7)
-- elements["PNT-023"]	= default_2_position_tumb(_("Fuel Pump Switch, ON/OFF"),		devices.FUEL_SYSTEM,	device_commands.FuelPumpSw,		23, 0.95)



-- Counter measures panel
-- elements["PNT-043"]	= default_2_position_tumb(_("Countermeasures Cover"),	devices.COUNTERMEASURES, 	device_commands.CMsCover,	43, CH47CLICK1)
-- elements["PNT-044"]	= default_2_position_tumb(_("Countermeasures, Arm/Safe"),	devices.COUNTERMEASURES, 	device_commands.MasterArmCMs,	44, CH47CLICK1)
-- elements["PNT-045"]	= default_2_position_tumb(_("ECM on/off"),	devices.COUNTERMEASURES, 	device_commands.ECM,		45, CH47CLICK1) --iCommandActiveJamming
-- elements["PNT-047"]	= default_2_position_tumb(_("Chaff Selector"),	devices.COUNTERMEASURES,	device_commands.ChaffSelector,	47, CH47CLICK1, 0.9)
-- elements["PNT-048"]	= default_2_position_tumb(_("Flare Selector"),	devices.COUNTERMEASURES,	device_commands.FlareSelector,	48, CH47CLICK1, 0.9)
-- elements["FLAREFIRE"]	= default_button(_("Flare Fire"),	devices.COUNTERMEASURES,	device_commands.FLAREFIRE,	4008)
-- elements["CHAFFFIRE"]	= default_button(_("Chaff Fire"),	devices.COUNTERMEASURES,	device_commands.CHAFFFIRE,	4007)



-- Weapons panel
-- elements["PNT-550"]	= default_red_cover(_("MASTER ARM COVER"),	devices.WEAPON_SYSTEM, 	device_commands.MasterArmCover,	550, 0.9)
-- elements["PNT-551"]	= default_2_position_tumb(_("Weapons ARM on/off"),	devices.WEAPON_SYSTEM, 	device_commands.MasterArm,	551, CH47CLICK1, 0.9)
-- elements["PNT-552"]	= multiposition_switch("Weapon Select",	devices.WEAPON_SYSTEM,	device_commands.GunSelector, 552, 5, 0.5, true, -1, CH47CLICK1, 0.9)
-- elements["PNT-3010"]	= default_2_position_tumb(_("Weapons Sight Down"),	devices.WEAPON_SYSTEM, 	device_commands.GunSight,	3010, CH47SLIDE, 0.9)
-- elements["PNT-150"]	= default_2_position_tumb(_("Troop Warning RED(Ready) /GREEN (Go)"), devices.WEAPON_SYSTEM, 	device_commands.TroopWarn,	150, CH47CLICK1, 0.9)
-- elements["PNT-151"]	= default_2_position_tumb(_("Troop Standby"),	devices.WEAPON_SYSTEM, 	device_commands.TroopAlarm,	151, CH47CLICK1, 0.9)
-- elements["PNT-WEAPONS"]	= default_2_position_tumb(_("WEAPONS Procedure"),	devices.WEAPON_SYSTEM,	device_commands.WEAPONSProcedure, 4502, CH47SLIDE, 0.8)

-- RWR
-- elements["PNT-025"]	= default_2_position_tumb(_("RWR Power Switch, OFF/ON"),		devices.RWR, device_commands.RWRpower,		25, CH47CLICK1, 0.8)
-- elements["PNT-030"]	= default_axis_limited(_("RWR Display Brightness Knob"), 		devices.RWR, device_commands.RWRBrightness, 30, 1)


-- External Lights 
-- elements["PNT-013"] = default_2_position_tumb(_("Position Light Switch"),					devices.EXTLIGHTS, device_commands.PositionLightSw,	13, CH47CLICK1)
-- elements["PNT-027"] = default_3_position_tumb(_("Anti-Collision Light Switch"),	devices.EXTLIGHTS, device_commands.AntiCollision, 27)
-- elements["PNT-010"]	= multiposition_switch_limited(_("Panel Lights"),	devices.EXTLIGHTS, device_commands.PanelLightsw, 10, 3, 0.5, true, 0, CH47SLIDE, 0.9)
-- elements["PNT-026"]	= default_2_position_tumb(_("Landing Light Switch, ON/OFF"),			devices.EXTLIGHTS, device_commands.LandingLightSw,	2026, CH47CLICK1)
-- elements["PNT-014"]	= default_2_position_tumb(_("Interior Lights, ON/OFF"),			devices.EXTLIGHTS, device_commands.PlaneLightsOnOffSw,	2062, CH47CLICK1)
-- elements["PNT-061"] = default_2_position_tumb(_("Flip Radio Cover"),	devices.RADIO, device_commands.RadioFlipCover, 2061, CH47CLICK1, 0.9)
-- elements["PNT-190"] = default_2_position_tumb(_("Rotor Blade Lights on/off"), devices.EXTLIGHTS, device_commands.BladetipSw, 190, 0.8)
-- elements["PNT-088"]	= default_axis_limited(_("Landing Lights Brightness"),	devices.EXTLIGHTS, device_commands.FormationLights, 88)

-- Autopilot
-- elements["PNT-431"] = default_2_position_tumb(_("Autopilot Roll/Pitch"),	devices.AUTOPILOT, device_commands.AP_RP,  	431, CH47CLICK1)
-- elements["PNT-433"] = default_2_position_tumb(_("Autopilot Altitude"),		devices.AUTOPILOT, device_commands.AP_ALT,  433, CH47CLICK1)
-- elements["PNT-438"] = default_2_position_tumb(_("Autopilot"),				devices.AUTOPILOT, device_commands.AP_ON,  	438, CH47CLICK1)


-- Toys
-- elements["PNT-2008"]	= default_3_position_tumb(_("Winch Up/DOWN"),			devices.WINCH, device_commands.WinchSwDown, 2008, true, 0.9, true)
-- elements["PNT-2005"]	= default_2_position_tumb(_("Winch Power, OFF/ON"),		devices.WINCH, device_commands.WinchpowerSw, 2005, CH47CLICK1, 0.9)
-- elements["PNT-022"] = default_animated_lever(_("Refuel Probe, In/Out"), devices.REFUELPROBE, device_commands.RefuelProbesw, 22, 0.4)
-- elements["PNT-2020"] = multiposition_switch_limited(_("Ramp Selector Closed/Half-Open/Half-Down/Full-Down"), devices.RAMP, device_commands.Rampsw, 2020, 4, 0.25, true, 0, CH47CLICK1, 0.8)
-- elements["PNT-2021"] = default_red_cover(_("Ramp Selector Switch Cover"),		devices.RAMP, device_commands.RampcoverSw,	2021, 0.95)
-- elements["PNT-ACDC"]	= default_2_position_tumb(_("ACDC OFF/ON"),		devices.MPEE, device_commands.ACDCSw, 2062, CH47CLICK1, 0.9)
-- elements["PNT-061"] = default_2_position_tumb(_("ACDC Cover"),	devices.MPEE, device_commands.ACDCcover, 2061, CH47CLICK1, 0.9)

--Avionics
--elements["PNT-028"]	= default_axis(_("Altimeter Setting Knob"), devices.AVIONICS, device_commands.AltimeterSet, 28, 0.04, 1, false, true)
--elements["PNT-029"]	= default_axis_limited(_("ADI Adjustment Knob"), devices.AVIONICS, device_commands.ADIadjust, 29, nil, nil, nil, nil, {-1,1})
--elements["PNT-031"]	= default_axis(_("LO flag setting knob"), devices.AVIONICS, device_commands.LOset, 31)
--elements["PNT-032"]	= default_axis(_("HI flag setting knob"), devices.AVIONICS, device_commands.HIset, 32)

-- -- Mirrors
--elements["PNT_MIRROR_LEFT"]  = default_2_position_tumb("Toggle Mirrors", 0, 1625, nil)
--elements["PNT_MIRROR_RIGHT"] = default_2_position_tumb("Toggle Mirrors", 0, 1625, nil)

-- elements["PNT_2"] = default_2_position_tumb("Hide Stick Toggle", devices.GEAR, Keys.ToggleStick, nil)

-- elements["PNT_129"] = default_2_position_tumb("Canopy", devices.CANOPY, Keys.Canopy, 129)
-- elements["PNT_129"].animated        = {true, true}
-- elements["PNT_129"].animation_speed = {2, 2} 

-- elements["PNT_132"] = default_movable_axis("Flaps Control Handle", devices.FLAPS, device_commands.flaps, 132, 0.0,-0.17, true, false)

-- ELECTRICAL
-- elements["PNT_961"] = default_3_1_position_tumb("Battery (Reset/On/Off)",                       devices.ELECTRIC_SYSTEM, device_commands.ElecBatt,       961,nil,true,TOGGLECLICK_MID_FWD)
-- elements["PNT_962"] = default_2_position_tumb("Generator (On/Off-Reset)",                       devices.ELECTRIC_SYSTEM, device_commands.ElecGen,        962,TOGGLECLICK_MID_FWD)
-- elements["PNT_963"] = default_2_position_tumb("External Power (ON/Off)",                        devices.ELECTRIC_SYSTEM, device_commands.ElecExtPwr,     963,TOGGLECLICK_MID_FWD)
-- elements["PNT_964"] = default_2_position_tumb("Backup (Auto/Off)",                              devices.ELECTRIC_SYSTEM, device_commands.ElecBkp,        964,TOGGLECLICK_MID_FWD)
-- elements["PNT_965"] = default_3_position_tumb("Emergency Override (Emergency/Auto/Auto)",       devices.ELECTRIC_SYSTEM, device_commands.ElecEmer,       965,nil,true,TOGGLECLICK_MID_FWD)
-- elements["PNT_966"] = default_3_position_tumb("Aircraft Interconnect (On/Off/Off)",             devices.ELECTRIC_SYSTEM, device_commands.ElecAcftIntc,   966,nil,true,TOGGLECLICK_MID_FWD)


-- BASIC FLIGHT INSTRUMENT
-- elements["PNT_951"] = default_button("Bright",                                                  devices.EXTANIM,         device_commands.BFI_BRIGHT, 951)
-- elements["PNT_952"] = default_button("STD",                                                     devices.EXTANIM,         device_commands.AltPressureStd, 952)
-- elements["PNT_953"] = default_axis("BARO",                                                      devices.EXTANIM,         device_commands.AltPressureKnob, 953, 0.0, 0.2, false, true)

-- ICE PROTECTION
-- elements["PNT_991"] = default_2_position_tumb("Propeller (On/Off)",                             devices.ICEPROT, device_commands.IcePropeller,   991,TOGGLECLICK_MID_FWD)
-- elements["PNT_992"] = default_3_1_position_tumb("Windshield (Start/Set/Off)",                   devices.ICEPROT, device_commands.IceWindshield,  992,nil,true,TOGGLECLICK_MID_FWD)
-- elements["PNT_993"] = default_2_position_tumb("Pitot / Stat - Pri/Tat (On/Off)",                devices.ICEPROT, device_commands.IcePitotPri,    993,TOGGLECLICK_MID_FWD)
-- elements["PNT_994"] = default_2_position_tumb("Pitot / Stat - Sec (On/Off)",                    devices.ICEPROT, device_commands.IcePitotSec,    994,TOGGLECLICK_MID_FWD)

-- INTERNAL LIGHTS
-- elements["PNT_941"] = default_axis_limited("Panel (Off/Brightness)",                            devices.INTLIGHTS, device_commands.IntLightPnl,    941, 0.0,0.15)
-- elements["PNT_942"] = default_2_position_tumb("Storm (On/Off)",                                 devices.INTLIGHTS, device_commands.IntLightStorm,  942,TOGGLECLICK_MID_FWD)
-- elements["PNT_943"] = default_axis_limited("Console (Off/Brightness)",                          devices.INTLIGHTS, device_commands.IntLightCsl,    943, 0.0,0.15)


-- EXTERNAL LIGHTS
-- elements["PNT_931"] = default_2_position_tumb("Search (On/Off)",                                devices.EXTLIGHTS, device_commands.ExtLightSearch, 931,TOGGLECLICK_MID_FWD)
-- elements["PNT_932"] = default_2_position_tumb("Beacon (On/Off)",                                devices.EXTLIGHTS, device_commands.ExtLightBeacon, 932,TOGGLECLICK_MID_FWD)
-- elements["PNT_933"] = default_2_position_tumb("Strobe (On/Off)",                                devices.EXTLIGHTS, device_commands.ExtLightStrobe, 933,TOGGLECLICK_MID_FWD)
-- elements["PNT_934"] = default_2_position_tumb("Formation Infrared (On/Off)",                    devices.EXTLIGHTS, device_commands.ExtLightInfrared, 934,TOGGLECLICK_MID_FWD)
-- elements["PNT_935"] = default_3_position_tumb("Formation Normal (Brt/Dim/Off)",                 devices.EXTLIGHTS, device_commands.ExtLightNormal, 935,nil,true,TOGGLECLICK_MID_FWD)
-- elements["PNT_936"] = default_2_position_tumb("Navigation (On/Off)",                            devices.EXTLIGHTS, device_commands.ExtLightNav,    936,TOGGLECLICK_MID_FWD)
-- elements["PNT_937"] = default_3_position_tumb("Taxi (On/Auto/Off)",                             devices.EXTLIGHTS, device_commands.ExtLightTaxi,   937,nil,true,TOGGLECLICK_MID_FWD)
-- elements["PNT_938"] = default_2_position_tumb("Landing (On/Off)",                               devices.EXTLIGHTS, device_commands.ExtLightLng,    938,TOGGLECLICK_MID_FWD)

-- ENGINE
-- elements["PNT_921"] = default_2_position_tumb("PMU (Auto/Manual)",                              devices.ENGINE,  device_commands.EnginePMU,      921,TOGGLECLICK_MID_FWD)
-- elements["PNT_922"] = default_3_position_tumb("Ignition (On/Auto/Off)",                         devices.ENGINE,  device_commands.EngineIgnition, 922,nil,true,TOGGLECLICK_MID_FWD)
-- elements["PNT_923"] = springloaded_3_pos_tumb("Start (Start/No Function/Interrupt",	    	    devices.ENGINE,	 device_commands.EngineStart,    923, true)
-- elements["PNT_924"] = default_2_position_tumb("Innertial Separation (Open/Close)",              devices.ENGINE,  device_commands.EngineInnSep,   924,TOGGLECLICK_MID_FWD)
-- FUEL / HYDRAULIC / BLEED SHUTOFF
-- elements["PNT_871"] = default_3_position_tumb("Fuel/Hydraulic/Bleed Shutoff (Open/Close/Close)",devices.ENGINE,  device_commands.FuelHydBleed, 871,nil,true,TOGGLECLICK_MID_FWD)

-- THROTTLE
-- elements["PNT_911"] = default_movable_axis("Throttle",                                          devices.EXTANIM, device_commands.Throttle,       911, 0.0,0.1, true, false)
-- elements["PNT_912"] = default_2_position_tumb("Flaps (Up/Stop/Down)",                           devices.EXTANIM, device_commands.Flaps,          912,nil,true,TOGGLECLICK_MID_FWD)
-- elements["PNT_913"] = default_movable_axis("Friction",                                          devices.EXTANIM, device_commands.Friction,       913, 0.0,0.1, true, false)

-- TRIMS
-- elements["PNT_901"] = springloaded_3_pos_tumb("Aileron Emergency (Left/Stop/Right)",            devices.AVIONICS, device_commands.TrimEmerAil,    901,true,TOGGLECLICK_MID_FWD)
-- elements["PNT_902"] = springloaded_3_pos_tumb("Elevator Emergency (Down/Stop/Up)",              devices.AVIONICS, device_commands.TrimEmerElev,   902,true,TOGGLECLICK_MID_FWD)
-- elements["PNT_903"] = default_3_position_tumb("Auto Rudder (Engage/Power/Off)",                 devices.AVIONICS, device_commands.AutoRudder,     903,nil,true,TOGGLECLICK_MID_FWD)

-- SEAT
-- elements["PNT_891"] = springloaded_3_pos_tumb("Seat (Up/Stop/Down)",                            devices.EXTANIM, device_commands.SeatAdj,        891,true,TOGGLECLICK_MID_FWD)

-- EMERGENCY SPEED BREAK
-- elements["PNT_881"] = default_3_position_tumb("Emergency Spead Break (Close/Off/Normal)",       devices.EXTANIM, device_commands.EmerSpdBrk, 881,nil,true,TOGGLECLICK_MID_FWD)


-- ANTI-G TEST
-- elements["PNT_861"] = default_button("Anti-G Suit Test",                                        devices.EXTANIM, device_commands.AntiG, 861)


-- AVIONICS
-- elements["PNT_841"] = default_2_position_tumb("MDP 1 (On/Off)",                                 devices.ELECTRIC_SYSTEM, device_commands.AviMdp1,        841,TOGGLECLICK_MID_FWD)
-- elements["PNT_842"] = default_2_position_tumb("MDP 2 (On/Off)",                                 devices.ELECTRIC_SYSTEM, device_commands.AviMdp2,        842,TOGGLECLICK_MID_FWD)
-- elements["PNT_843"] = default_2_position_tumb("Avionics Master (On/Off)",                       devices.ELECTRIC_SYSTEM, device_commands.AviMst,         843,TOGGLECLICK_MID_FWD)
-- elements["PNT_844"] = default_2_position_tumb("SMS (On/Off)",                                   devices.ELECTRIC_SYSTEM, device_commands.AviSms,         844,TOGGLECLICK_MID_FWD)
-- elements["PNT_845"] = default_2_position_tumb("V/UHF (Guard/Normal)",                           devices.ELECTRIC_SYSTEM, device_commands.AviVuhf,        845,TOGGLECLICK_MID_FWD)

-- ENVIRONMENTAL CONTROL SYSTEM
-- elements["PNT_831"] = default_movable_axis("Temperature (Cold/Hot)",                            devices.ENVIRON, device_commands.EnvTemp,        831, 0.0,0.1, true, false)
-- elements["PNT_832"] = default_2_position_tumb("Air Conditioner (On/Off)",                       devices.ENVIRON, device_commands.EnvAC,          832,TOGGLECLICK_MID_FWD)
-- elements["PNT_833"] = default_2_position_tumb("ECS (Auto/Manual)",                              devices.ENVIRON, device_commands.EnvECS,         833,TOGGLECLICK_MID_FWD)
-- elements["PNT_834"] = default_2_position_tumb("Recirculating Fan (On/Off)",                     devices.ENVIRON, device_commands.EnvRecFan,      834,TOGGLECLICK_MID_FWD)

-- LANDING GEAR

-- elements["PNT_822"] = default_button("Beep Supress",                                            devices.GEAR,    device_commands.LndGearBeep,    822)
-- elements["PNT_823"] = default_button("Down Lock Override",                                      devices.GEAR,    device_commands.LndGearOvr,     823)
-- elements["PNT_851"] = default_2_position_tumb("Gear Emergency Down (Emergency Down/Normal)",    devices.GEAR,    device_commands.LndGearEmer, 851,TOGGLECLICK_MID_FWD)


-- FUEL
-- elements["PNT_801"] = multiposition_switch_limited("Fuel Main Pump (Auto/Off)",                 devices.FUEL, device_commands.FuelMain,         801, 2, 1.0, false, 0, TOGGLECLICK_MID_FWD)
-- elements["PNT_802"] = multiposition_switch_limited("Fuel Aux Pump (LH/Auto/RH/Both)",           devices.FUEL, device_commands.FuelAux,          802, 4,0.25, false, TOGGLECLICK_MID_FWD)
-- elements["PNT_803"] = default_3_position_tumb("Fuel Transfer (U-Wing/Ventral-Auto/Off)",        devices.FUEL, device_commands.FuelXfr,          803, nil,true,TOGGLECLICK_MID_FWD)

-- PARKING BRAKES
-- elements["PNT_791"] = default_3_position_tumb("Emergency/Parking Brakes",                       devices.BRAKES, device_commands.EmerParkBrake, 791, nil, true)

-- WEAPONS

-- elements["PNT_782"] = default_3_position_tumb("Late Arm (On/Safe)",                             devices.WEAPON_SYSTEM, device_commands.LateArm,       782,nil,true,TOGGLECLICK_MID_FWD)
-- elements["PNT_811"] = default_button("Salvo",                                                   devices.WEAPON_SYSTEM, device_commands.Salvo,         811)

-- ELT
-- elements["PNT_771"] = default_3_position_tumb("ELT (On/Arm-Reset)",                             devices.EXTANIM, device_commands.EltOn,        771,nil,true,TOGGLECLICK_MID_FWD)
-- PIC NAV
-- elements["PNT_772"] = springloaded_3_pos_tumb("Manual Sync (CW/CCW)",                           devices.EXTANIM, device_commands.PicNavMan,     772,true,TOGGLECLICK_MID_FWD)
-- elements["PNT_773"] = default_3_position_tumb("Slave (Free/Slave/Fast Slave)",                  devices.EXTANIM, device_commands.PicNavSlave,   773,nil,true,TOGGLECLICK_MID_FWD)

-- AUDIO
-- elements["PNT_761"] = default_2_position_tumb("Audio Selector (Normal/Backup)",                 devices.GEAR,    device_commands.AudioNormal,        761,TOGGLECLICK_MID_FWD)

-- ASI
-- elements["PNT_751"] = 
-- {
    -- class				= {class_type.BTN, class_type.LEV},
	-- hint				= ("Cage/Adjust (Cage/Up/Down)"),
	-- device				= devices.EXTANIM,
	-- action				= {device_commands.ASICage, device_commands.ASIAdjust},
	-- stop_action			= {device_commands.ASICage, 0},
	-- is_repeatable		= {},
	-- arg					= {756, 755},
	-- arg_value			= {1.0, 1.0},
	-- arg_lim				= {{0, 1}, {-1, 1}},
	-- relative			= {false, false},
	-- cycle				= false,
	-- gain				= {1.0, 0.02},
	-- use_release_message	= {true, false},
	-- use_OBB 			= true,
-- }

-- CMFD1
-- elements["PNT_501"] = default_button("CMFD #1 OSS 1",                                        devices.CMFD, device_commands.CMFD1OSS1,         501)
-- elements["PNT_502"] = default_button("CMFD #1 OSS 2",                                        devices.CMFD, device_commands.CMFD1OSS2,         502)
-- elements["PNT_503"] = default_button("CMFD #1 OSS 3",                                        devices.CMFD, device_commands.CMFD1OSS3,         503)
-- elements["PNT_504"] = default_button("CMFD #1 OSS 4",                                        devices.CMFD, device_commands.CMFD1OSS4,         504)
-- elements["PNT_505"] = default_button("CMFD #1 OSS 5",                                        devices.CMFD, device_commands.CMFD1OSS5,         505)
-- elements["PNT_506"] = default_button("CMFD #1 OSS 6",                                        devices.CMFD, device_commands.CMFD1OSS6,         506)
-- elements["PNT_507"] = default_button("CMFD #1 OSS 7",                                        devices.CMFD, device_commands.CMFD1OSS7,         507)
-- elements["PNT_508"] = default_button("CMFD #1 OSS 8",                                        devices.CMFD, device_commands.CMFD1OSS8,         508)
-- elements["PNT_509"] = default_button("CMFD #1 OSS 9",                                        devices.CMFD, device_commands.CMFD1OSS9,         509)
-- elements["PNT_510"] = default_button("CMFD #1 OSS 10",                                       devices.CMFD, device_commands.CMFD1OSS10,        510)
-- elements["PNT_511"] = default_button("CMFD #1 OSS 11",                                       devices.CMFD, device_commands.CMFD1OSS11,        511)
-- elements["PNT_512"] = default_button("CMFD #1 OSS 12",                                       devices.CMFD, device_commands.CMFD1OSS12,        512)
-- elements["PNT_513"] = default_button("CMFD #1 OSS 13",                                       devices.CMFD, device_commands.CMFD1OSS13,        513)
-- elements["PNT_514"] = default_button("CMFD #1 OSS 14",                                       devices.CMFD, device_commands.CMFD1OSS14,        514)
-- elements["PNT_515"] = default_button("CMFD #1 OSS 15",                                       devices.CMFD, device_commands.CMFD1OSS15,        515)
-- elements["PNT_516"] = default_button("CMFD #1 OSS 16",                                       devices.CMFD, device_commands.CMFD1OSS16,        516)
-- elements["PNT_517"] = default_button("CMFD #1 OSS 17",                                       devices.CMFD, device_commands.CMFD1OSS17,        517)
-- elements["PNT_518"] = default_button("CMFD #1 OSS 18",                                       devices.CMFD, device_commands.CMFD1OSS18,        518)
-- elements["PNT_519"] = default_button("CMFD #1 OSS 19",                                       devices.CMFD, device_commands.CMFD1OSS19,        519)
-- elements["PNT_520"] = default_button("CMFD #1 OSS 20",                                       devices.CMFD, device_commands.CMFD1OSS20,        520)
-- elements["PNT_521"] = default_button("CMFD #1 OSS 21",                                       devices.CMFD, device_commands.CMFD1OSS21,        521)
-- elements["PNT_522"] = default_button("CMFD #1 OSS 22",                                       devices.CMFD, device_commands.CMFD1OSS22,        522)
-- elements["PNT_523"] = default_button("CMFD #1 OSS 23",                                       devices.CMFD, device_commands.CMFD1OSS23,        523)
-- elements["PNT_524"] = default_button("CMFD #1 OSS 24",                                       devices.CMFD, device_commands.CMFD1OSS24,        524)
-- elements["PNT_525"] = default_button("CMFD #1 OSS 25",                                       devices.CMFD, device_commands.CMFD1OSS25,        525)
-- elements["PNT_526"] = default_button("CMFD #1 OSS 26",                                       devices.CMFD, device_commands.CMFD1OSS26,        526)
-- elements["PNT_527"] = default_button("CMFD #1 OSS 27",                                       devices.CMFD, device_commands.CMFD1OSS27,        527)
-- elements["PNT_528"] = default_button("CMFD #1 OSS 28",                                       devices.CMFD, device_commands.CMFD1OSS28,        528)
-- elements["PNT_529"] = default_2_position_tumb("CMFD #1 Power (On/Off)",                      devices.CMFD, device_commands.CMFD1ButtonOn,        529)
-- elements["PNT_530"] = springloaded_3_pos_tumb("CMFD #1 Gain",                                devices.CMFD, device_commands.CMFD1ButtonGain,      530, true)
-- elements["PNT_531"] = springloaded_3_pos_tumb("CMFD #1 Symbology",                           devices.CMFD, device_commands.CMFD1ButtonSymb,      531, true)
-- elements["PNT_532"] = springloaded_3_pos_tumb("CMFD #1 Bright",                              devices.CMFD, device_commands.CMFD1ButtonBright,    532, true)

-- CMFD2
-- elements["PNT_551"] = default_button("CMFD #2 OSS 1",                                        devices.CMFD, device_commands.CMFD2OSS1,         551)
-- elements["PNT_552"] = default_button("CMFD #2 OSS 2",                                        devices.CMFD, device_commands.CMFD2OSS2,         552)
-- elements["PNT_553"] = default_button("CMFD #2 OSS 3",                                        devices.CMFD, device_commands.CMFD2OSS3,         553)
-- elements["PNT_554"] = default_button("CMFD #2 OSS 4",                                        devices.CMFD, device_commands.CMFD2OSS4,         554)
-- elements["PNT_555"] = default_button("CMFD #2 OSS 5",                                        devices.CMFD, device_commands.CMFD2OSS5,         555)
-- elements["PNT_556"] = default_button("CMFD #2 OSS 6",                                        devices.CMFD, device_commands.CMFD2OSS6,         556)
-- elements["PNT_557"] = default_button("CMFD #2 OSS 7",                                        devices.CMFD, device_commands.CMFD2OSS7,         557)
-- elements["PNT_558"] = default_button("CMFD #2 OSS 8",                                        devices.CMFD, device_commands.CMFD2OSS8,         558)
-- elements["PNT_559"] = default_button("CMFD #2 OSS 9",                                        devices.CMFD, device_commands.CMFD2OSS9,         559)
-- elements["PNT_560"] = default_button("CMFD #2 OSS 10",                                       devices.CMFD, device_commands.CMFD2OSS10,        560)
-- elements["PNT_561"] = default_button("CMFD #2 OSS 11",                                       devices.CMFD, device_commands.CMFD2OSS11,        561)
-- elements["PNT_562"] = default_button("CMFD #2 OSS 12",                                       devices.CMFD, device_commands.CMFD2OSS12,        562)
-- elements["PNT_563"] = default_button("CMFD #2 OSS 13",                                       devices.CMFD, device_commands.CMFD2OSS13,        563)
-- elements["PNT_564"] = default_button("CMFD #2 OSS 14",                                       devices.CMFD, device_commands.CMFD2OSS14,        564)
-- elements["PNT_565"] = default_button("CMFD #2 OSS 15",                                       devices.CMFD, device_commands.CMFD2OSS15,        565)
-- elements["PNT_566"] = default_button("CMFD #2 OSS 16",                                       devices.CMFD, device_commands.CMFD2OSS16,        566)
-- elements["PNT_567"] = default_button("CMFD #2 OSS 17",                                       devices.CMFD, device_commands.CMFD2OSS17,        567)
-- elements["PNT_568"] = default_button("CMFD #2 OSS 18",                                       devices.CMFD, device_commands.CMFD2OSS18,        568)
-- elements["PNT_569"] = default_button("CMFD #2 OSS 19",                                       devices.CMFD, device_commands.CMFD2OSS19,        569)
-- elements["PNT_570"] = default_button("CMFD #2 OSS 20",                                       devices.CMFD, device_commands.CMFD2OSS20,        570)
-- elements["PNT_571"] = default_button("CMFD #2 OSS 21",                                       devices.CMFD, device_commands.CMFD2OSS21,        571)
-- elements["PNT_572"] = default_button("CMFD #2 OSS 22",                                       devices.CMFD, device_commands.CMFD2OSS22,        572)
-- elements["PNT_573"] = default_button("CMFD #2 OSS 23",                                       devices.CMFD, device_commands.CMFD2OSS23,        573)
-- elements["PNT_574"] = default_button("CMFD #2 OSS 24",                                       devices.CMFD, device_commands.CMFD2OSS24,        574)
-- elements["PNT_575"] = default_button("CMFD #2 OSS 25",                                       devices.CMFD, device_commands.CMFD2OSS25,        575)
-- elements["PNT_576"] = default_button("CMFD #2 OSS 26",                                       devices.CMFD, device_commands.CMFD2OSS26,        576)
-- elements["PNT_577"] = default_button("CMFD #2 OSS 27",                                       devices.CMFD, device_commands.CMFD2OSS27,        577)
-- elements["PNT_578"] = default_button("CMFD #2 OSS 28",                                       devices.CMFD, device_commands.CMFD2OSS28,        578)
-- elements["PNT_579"] = default_2_position_tumb("CMFD #2 Power (On/Off)",                      devices.CMFD, device_commands.CMFD2ButtonOn,        579)
-- elements["PNT_580"] = springloaded_3_pos_tumb("CMFD #2 Gain",                                devices.CMFD, device_commands.CMFD2ButtonGain,      580, true)
-- elements["PNT_581"] = springloaded_3_pos_tumb("CMFD #2 Symbology",                           devices.CMFD, device_commands.CMFD2ButtonSymb,      581, true)
-- elements["PNT_582"] = springloaded_3_pos_tumb("CMFD #2 Bright",                              devices.CMFD, device_commands.CMFD2ButtonBright,    582, true)

-- CLOCK
-- elements["PNT_491"] = default_button("Clock Selection",                                     devices.EXTANIM, device_commands.ClockSel,           491)
-- elements["PNT_492"] = default_button("Clock Control",                                       devices.EXTANIM, device_commands.ClockCtrl,          492)

-- UFCP
-- elements["PNT_451"] = default_button("COM 1",                                           	devices.UFCP, device_commands.UFCP_COM1,          	451)
-- elements["PNT_452"] = default_button("COM 2",                                           	devices.UFCP, device_commands.UFCP_COM2,          	452)
-- elements["PNT_453"] = default_button("NAV AIDS",                                           	devices.UFCP, device_commands.UFCP_NAVAIDS,     	453)
-- elements["PNT_454"] = default_button("A/G",                                           		devices.UFCP, device_commands.UFCP_A_G,          	454)
-- elements["PNT_455"] = default_button("NAV",                                           		devices.UFCP, device_commands.UFCP_NAV,          	455)
-- elements["PNT_456"] = default_button("A/A",                                           		devices.UFCP, device_commands.UFCP_A_A,          	456)
-- elements["PNT_457"] = default_button("BARO/RALT",                                         	devices.UFCP, device_commands.UFCP_BARO_RALT,       457)
-- elements["PNT_458"] = default_button("IDNT",                                           		devices.UFCP, device_commands.UFCP_IDNT,          	458)
-- elements["PNT_459"] = default_button("1",                                           		devices.UFCP, device_commands.UFCP_1,          		459)
-- elements["PNT_460"] = default_button("2",                                           		devices.UFCP, device_commands.UFCP_2,          		460)
-- elements["PNT_461"] = default_button("3",                                     				devices.UFCP, device_commands.UFCP_3,          		461)
-- elements["PNT_462"] = default_button("4",                                     				devices.UFCP, device_commands.UFCP_4,          		462)
-- elements["PNT_463"] = default_button("5",                                     				devices.UFCP, device_commands.UFCP_5,          		463)
-- elements["PNT_464"] = default_button("6",                                     				devices.UFCP, device_commands.UFCP_6,          		464)
-- elements["PNT_465"] = default_button("7",                                     				devices.UFCP, device_commands.UFCP_7,          		465)
-- elements["PNT_466"] = default_button("8",                                     				devices.UFCP, device_commands.UFCP_8,          		466)
-- elements["PNT_467"] = default_button("9",                                     				devices.UFCP, device_commands.UFCP_9,          		467)
-- elements["PNT_468"] = default_button("0",                                     				devices.UFCP, device_commands.UFCP_0,          		468)
-- elements["PNT_469"] = default_button("Clear",                                           	devices.UFCP, device_commands.UFCP_CLR,          	469)
-- elements["PNT_470"] = default_button("Enter",                                           	devices.UFCP, device_commands.UFCP_ENTR,          	470)
-- elements["PNT_471"] = default_button("CZ",                                           		devices.UFCP, device_commands.UFCP_CZ,          	471)
-- elements["PNT_472"] = default_button("Airspeed",                                           	devices.UFCP, device_commands.UFCP_AIRSPD,          472)
-- elements["PNT_473"] = default_button("Warning Reset",                                       devices.UFCP, device_commands.UFCP_WARNRST,         473)
-- elements["PNT_474"] = default_button("Up",                                           		devices.UFCP, device_commands.UFCP_UP,          	474)
-- elements["PNT_475"] = default_button("Down",                                           		devices.UFCP, device_commands.UFCP_DOWN,          	475)

-- elements["PNT_476"] = default_3_position_tumb("Day/Night/Auto",                        		devices.UFCP, device_commands.UFCP_DAY_NIGHT,     	476, false, true)
-- elements["PNT_477"] = default_2_position_tumb("Radar Altimeter Transmit / Off",       		devices.UFCP, device_commands.UFCP_RALT,          	477)
-- elements["PNT_478"] = default_3_position_tumb("DVR Rec/Standby/Off",                		devices.UFCP, device_commands.UFCP_DVR,          	478, false, true)
-- elements["PNT_479"] = multiposition_switch_limited("EGI Nav/Align/Storage Heading/Off/Test",devices.UFCP, device_commands.UFCP_EGI,          	479,5,0.25)
-- elements["PNT_480"] = default_axis_limited("UFC BRT/OFF",									devices.UFCP , device_commands.UFCP_UFC,          	480, 0, 0.15)
-- elements["PNT_481"] = default_2_position_tumb("HUD Test",									devices.UFCP, device_commands.UFCP_HUD_TEST,      	481)
-- elements["PNT_482"] = default_2_position_tumb("SBS On",										devices.UFCP, device_commands.UFCP_SBS_ON,      	482)
-- elements["PNT_483"] = default_axis_limited("HUD Britghness",								devices.HUD, device_commands.UFCP_HUD_BRIGHT,     	483)
-- elements["PNT_484"] = default_axis_limited("SBS Adjust",	   								devices.UFCP, device_commands.UFCP_SBS_ADJUST,   	484)

-- elements["PNT_485"] = default_button("Right",												devices.UFCP, device_commands.UFCP_JOY_RIGHT,   	485)
-- elements["PNT_486"] = default_button("Left",												devices.UFCP, device_commands.UFCP_JOY_LEFT,  	 	486)
-- elements["PNT_487"] = default_button("Up",													devices.UFCP, device_commands.UFCP_JOY_UP,   		487)
-- elements["PNT_488"] = default_button("Down",												devices.UFCP, device_commands.UFCP_JOY_DOWN,  	 	488)

-- elements["PNT_441"] = default_button("Warning",												devices.ALARM, device_commands.WARNING_PRESS,  		441)
-- elements["PNT_442"] = default_button("Caution",												devices.ALARM, device_commands.CAUTION_PRESS,  	 	442)





-- --[[  Remove tail hook level from clickables, until we can solve the tail hook problem in DCS replays. For now it moves to a gauge in mainpanel_init.lua
-- elements["PNT_10"] = default_2_position_tumb("Tail Hook Handle", devices.GEAR, device_commands.Hook, 10)
-- elements["PNT_10"].animated        = {true, true}
-- elements["PNT_10"].animation_speed = {2, 2} -- multiply these numbers by the base 1.0 second animation speed to get final speed.  2 means animates in 0.5 seconds.
-- --]]
-- elements["PNT_83"] = multiposition_switch_limited("Master Lighting ON/OFF/Momentary", devices.EXT_LIGHTS, device_commands.extlight_master, 83, 3, 1, false, -1.0, TOGGLECLICK_LEFT_MID)

-- --Spoilers
-- elements["PNT_84"] = default_2_position_tumb("Spoiler Arm Switch",devices.SPOILERS, device_commands.spoiler_arm,84,TOGGLECLICK_LEFT_MID)
-- elements["PNT_133"] = default_2_position_tumb("JATO ARM-OFF Switch",devices.AVIONICS, device_commands.JATO_arm,133,TOGGLECLICK_LEFT_MID)
-- elements["PNT_134"] = default_2_position_tumb("JATO JETTISON-SAFE Switch",devices.AVIONICS, device_commands.JATO_jettison,134,TOGGLECLICK_LEFT_MID)
-- --Speedbrake
-- elements["PNT_85"] = default_2_position_tumb("Speedbrake switch",devices.AIRBRAKES, device_commands.speedbrake,85,TOGGLECLICK_LEFT_MID)
-- elements["PNT_128"] = default_3_position_tumb("Speedbrake emergency",devices.AIRBRAKES, device_commands.speedbrake_emer,128)

-- -- canopy lever
-- elements["PNT_129"] = default_2_position_tumb("Canopy", devices.CANOPY, Keys.Canopy, 0)

-- elements["PNT_132"] = multiposition_switch_limited("Flaps Lever", devices.FLAPS, device_commands.flaps, 132, 3, 1, false, -1.0)

-- -- THROTTLE PANEL
-- elements["PNT_80"] 	= default_3_position_tumb("Throttle", devices.ENGINE, device_commands.throttle_click,0, false, true)
-- elements["PNT_82"] 	= default_axis_limited("Rudder trim", devices.TRIM, device_commands.rudder_trim, 82, 0.0, 0.3, false, false, {-1,1})

-- --ENGINE CONTROL PANEL
-- elements["PNT_100"] = default_2_position_tumb("Starter switch",devices.ENGINE, device_commands.push_starter_switch,100)
-- elements["PNT_100"].sound = {{PUSHPRESS,PUSHRELEASE}}
-- elements["PNT_101"] = default_3_position_tumb("Drop Tanks Pressurization and Flight Refuel switch", devices.ENGINE, device_commands.ENGINE_drop_tanks_sw, 101, false, true, TOGGLECLICK_LEFT_MID) -- NO COMMAND
-- elements["PNT_103"] = default_3_position_tumb("Emer Transfer and Wing Fuel Dump switch", devices.ENGINE, device_commands.ENGINE_wing_fuel_sw, 103, false, true, TOGGLECLICK_LEFT_MID) -- NO COMMAND
-- elements["PNT_104"] = default_2_position_tumb("Fuel control switch",devices.ENGINE, device_commands.ENGINE_fuel_control_sw,104, TOGGLECLICK_LEFT_MID)
-- elements["PNT_130"] = default_2_position_tumb("Manual Fuel Shutoff Lever",devices.ENGINE, device_commands.ENGINE_manual_fuel_shutoff, 130, nil, 3)
-- -- elements["PNT_130"].updatable = false
-- -- elements["PNT_130"].use_OBB = false
-- elements["PNT_131"] = default_2_position_tumb("Manual Fuel Shutoff Catch",devices.ENGINE, device_commands.ENGINE_manual_fuel_shutoff_catch, 131, nil, 2) -- NO COMMAND
-- --elements["PNT_201"] = default_3_position_tumb("Throttle cutoff",devices.ENGINE, device_commands.throttle,201,false)

-- -- OXYGEN and ANTI-G PANEL
-- elements["PNT_125"] = default_2_position_tumb("Oxygen Switch",devices.AVIONICS, device_commands.oxygen_switch, 125, TOGGLECLICK_LEFT_MID)

-- -- RADAR CONTROL PANEL #6
-- elements["PNT_120"] = multiposition_switch_limited( "Radar Mode", devices.RADAR, device_commands.radar_mode, 120, 5, 0.10, nil, nil, KNOBCLICK_LEFT_MID )
-- elements["PNT_120"].animated        = {true, true}
-- elements["PNT_120"].animation_speed = {4, 4}  -- multiply these numbers by the base 1.0 second animation speed to get final speed.  4 means animates in 0.25 seconds.
-- elements["PNT_121"] = default_2_position_tumb( "Radar AoA Compensation", devices.RADAR, device_commands.radar_aoacomp, 121, TOGGLECLICK_LEFT_MID)
-- elements["PNT_122"] = default_axis_limited( "Radar Antenna Elevation", devices.RADAR, device_commands.radar_angle, 122, 0.4, 0.1, false, false, {0,1} )
-- elements["PNT_123"] = default_axis_limited( "Radar Warning Volume", devices.RADAR, device_commands.radar_volume, 123, 0.0, 0.3, false, false, {-1,1} )

-- -- APPROACH POWER COMPENSATOR PANEL #17A
-- elements["PNT_135"] = multiposition_switch_limited("APC Enable/Stby/Off", devices.AFCS, device_commands.apc_engagestbyoff, 135, 3, 1.0, false, -1.0, TOGGLECLICK_LEFT_FWD)
-- elements["PNT_136"] = multiposition_switch_limited("APC Cold/Std/Hot", devices.AFCS, device_commands.apc_hotstdcold, 136, 3, 1.0, false, -1.0, TOGGLECLICK_LEFT_FWD)

-- elements["PNT_139"] = default_button("Reset Accelerometer", devices.AVIONICS, device_commands.accel_reset, 139, nil, nil, TOGGLECLICK_MID_FWD)

-- elements["PNT_146"] = default_button("Stopwatch", devices.CLOCK, device_commands.clock_stopwatch, 146)

-- -- ANGLE OF ANGLE INDEXER
-- elements["PNT_853"] = default_axis_limited( "AOA Indexer Dimming Wheel", devices.AVIONICS, device_commands.AOA_dimming_wheel_AXIS, 853, 1.0, 0.2, false, false, {-1,1} )

-- -- AFCS PANEL #8  (Aircraft Flight Control System)
-- elements["PNT_160"] = default_2_position_tumb("AFCS standby",devices.AFCS, device_commands.afcs_standby,160, TOGGLECLICK_LEFT_AFT)
-- elements["PNT_161"] = default_2_position_tumb("AFCS engage",devices.AFCS, device_commands.afcs_engage,161, TOGGLECLICK_LEFT_AFT)
-- elements["PNT_162"] = default_2_position_tumb("AFCS preselect heading",devices.AFCS, device_commands.afcs_hdg_sel,162, TOGGLECLICK_LEFT_AFT)
-- elements["PNT_163"] = default_2_position_tumb("AFCS altitude hold",devices.AFCS, device_commands.afcs_alt,163, TOGGLECLICK_LEFT_AFT)
-- elements["PNT_164"] = default_axis_limited( "AFCS heading selector", devices.AFCS, device_commands.afcs_hdg_set, 164, 0.0, 0.3, false, true, {0,1} )
-- elements["PNT_165"] = default_2_position_tumb("AFCS stability aug (unimplemented)",devices.AFCS, device_commands.afcs_stab_aug,165, TOGGLECLICK_LEFT_AFT)
-- elements["PNT_166"] = default_2_position_tumb("AFCS aileron trim (unimplemented)",devices.AFCS, device_commands.afcs_ail_trim,166, TOGGLECLICK_LEFT_AFT)

-- -- RADAR SCOPE #20
-- elements["PNT_400"] = default_axis_limited("Radar Storage", devices.RADAR, device_commands.radar_storage, 400, 0.0, 0.3, false, false, {-1,1})
-- elements["PNT_401"] = default_axis_limited("Radar Brilliance", devices.RADAR, device_commands.radar_brilliance, 401, 0.0, 0.3, false, false, {-1,1})
-- elements["PNT_402"] = default_axis_limited("Radar Detail", devices.RADAR, device_commands.radar_detail, 402, 0.0, 0.3, false, false, {-1,1})
-- elements["PNT_403"] = default_axis_limited("Radar Gain", devices.RADAR, device_commands.radar_gain, 403, 0.0, 0.3, false, false, {-1,1})
-- elements["PNT_404"] = default_axis_limited("Radar Reticle", devices.RADAR, device_commands.radar_reticle, 404, 0.0, 0.3, false, false, {-1,1})
-- elements["PNT_405"] = default_2_position_tumb("Radar Filter Plate", devices.RADAR, device_commands.radar_filter, 405)
-- elements["PNT_405"].animated        = {true, true}
-- elements["PNT_405"].animation_speed = {4, 4}  -- animation duration = 1/value.  4 means animates in .25 seconds.

-- elements["PNT_390"] = multiposition_switch_limited("GunPods: Charge/Off/Clear", devices.WEAPON_SYSTEM, device_commands.gunpod_chargeclear, 390, 3, 1, false, -1, TOGGLECLICK_LEFT_FWD)
-- elements["PNT_391"] = default_2_position_tumb("GunPods: Left Enable", devices.WEAPON_SYSTEM, device_commands.gunpod_l, 391, TOGGLECLICK_LEFT_FWD)
-- elements["PNT_392"] = default_2_position_tumb("GunPods: Center Enable", devices.WEAPON_SYSTEM, device_commands.gunpod_c, 392, TOGGLECLICK_LEFT_FWD)
-- elements["PNT_393"] = default_2_position_tumb("GunPods: Right Enable", devices.WEAPON_SYSTEM, device_commands.gunpod_r, 393, TOGGLECLICK_LEFT_FWD)


-- elements["PNT_522"] = multiposition_switch_limited("Countermeasures: Bank Select", devices.COUNTERMEASURES, device_commands.cm_bank, 522, 3, 1, true, -1, TOGGLECLICK_LEFT_FWD)
-- elements["PNT_523"] = default_button("Countermeasures: Auto Pushbutton", devices.COUNTERMEASURES, device_commands.cm_auto, 523, 1, nil, TOGGLECLICK_LEFT_FWD)
-- elements["PNT_524"] = default_axis("Countermeasures: Bank 1 Adjust", devices.COUNTERMEASURES, device_commands.cm_adj1, 524, 0.0, 1, false, true)
-- elements["PNT_525"] = default_axis("Countermeasures: Bank 2 Adjust", devices.COUNTERMEASURES, device_commands.cm_adj2, 525, 0.0, 1, false, true)
-- elements["PNT_530"] = default_2_position_tumb("Countermeasures: Power Toggle", devices.COUNTERMEASURES, device_commands.cm_pwr, 530, TOGGLECLICK_LEFT_FWD)

-- -- RADAR ALTIMETER #30
-- -- combined 2 position switch and rotatable knob. The switch turns the radar altimeter
-- -- on and off, and the knob sets the indexer
-- -- NOTE: There is supposed to be a 'push-to-test' function too, but currently
-- -- unknown how to implement this together with the 2position toggle switch.. if the first member of class is BTN,
-- -- then you get a push button, but not a 2pos switch anymore.. and if you amke the first entry in arg_lim {-1,1} then
-- -- you get a 3position switch, which is also undesirable
-- -- The master press-to-test switch on the misc switches panel also tests the radar altimeter, so perhaps good
-- -- enough for this switch/knob here to only represent on/off and not test mode
-- elements["PNT_602"] = default_button_axis("Radar altitude warning",devices.RADARWARN, device_commands.radar_alt_switch, device_commands.radar_alt_indexer,603,602)
-- elements["PNT_602"].class = {class_type.TUMB, class_type.LEV}
-- elements["PNT_602"].relative = {false,true}
-- elements["PNT_602"].arg_lim = {{-1, 0}, {0, 1}}
-- elements["PNT_602"].stop_action = nil

-- -- STANDBY ATTITUDE INDICATOR #33
-- elements["PNT_662"] = default_button_axis("Standby attitude horizon",devices.AVIONICS, device_commands.stby_att_index_button, device_commands.stby_att_index_knob,663,662)
-- elements["PNT_662"].relative = {false,true}
-- elements["PNT_662"].updatable = nil
-- elements["PNT_662"].animated = nil
-- elements["PNT_662"].animation_speed = nil
-- elements["PNT_662"].arg_lim = {{0, 1}, {0, 1}}

-- --ARMAMENT PANEL #35
-- --elements["PNT_700"] = default_3_position_tumb("Emergency selector switch",devices.WEAPON_SYSTEM, device_commands.arm_emer_sel,700)
-- elements["PNT_700"] = multiposition_switch_limited("Emergency release selector",devices.WEAPON_SYSTEM, device_commands.arm_emer_sel,700,7,0.1,false,nil,KNOBCLICK_MID_FWD)
-- --elements["PNT_700"].animated        = {true, true}
-- --elements["PNT_700"].animation_speed = {2, 2}
-- elements["PNT_701"] = default_2_position_tumb("Guns switch",devices.WEAPON_SYSTEM, device_commands.arm_gun,701,TOGGLECLICK_MID_FWD)
-- elements["PNT_702"] = default_3_position_tumb("Bomb arm switch",devices.WEAPON_SYSTEM, device_commands.arm_bomb,702,nil,true,TOGGLECLICK_MID_FWD)
-- elements["PNT_703"] = default_2_position_tumb("Station 1 select",devices.WEAPON_SYSTEM, device_commands.arm_station1,703,TOGGLECLICK_MID_FWD)
-- elements["PNT_704"] = default_2_position_tumb("Station 2 select",devices.WEAPON_SYSTEM, device_commands.arm_station2,704,TOGGLECLICK_MID_FWD)
-- elements["PNT_705"] = default_2_position_tumb("Station 3 select",devices.WEAPON_SYSTEM, device_commands.arm_station3,705,TOGGLECLICK_MID_FWD)
-- elements["PNT_706"] = default_2_position_tumb("Station 4 select",devices.WEAPON_SYSTEM, device_commands.arm_station4,706,TOGGLECLICK_MID_FWD)
-- elements["PNT_707"] = default_2_position_tumb("Station 5 select",devices.WEAPON_SYSTEM, device_commands.arm_station5,707,TOGGLECLICK_MID_FWD)
-- elements["PNT_708"] = multiposition_switch_limited("Function selector",devices.WEAPON_SYSTEM, device_commands.arm_func_selector,708,6,0.1,false,nil,KNOBCLICK_MID_FWD, 2)

-- --elements["PNT_708"].animated        = {true, true}
-- --elements["PNT_708"].animation_speed = {2, 2}
-- elements["PNT_709"] = default_2_position_tumb("Master armament",devices.ELECTRIC_SYSTEM, device_commands.arm_master,709,TOGGLECLICK_MID_FWD)
-- elements["PNT_721"] = default_2_position_tumb("Radar Plan/Profile",devices.RADAR, device_commands.radar_planprofile,721,TOGGLECLICK_MID_FWD)
-- elements["PNT_722"] = default_2_position_tumb("Radar Long/Short Range",devices.RADAR, device_commands.radar_range,722,TOGGLECLICK_MID_FWD)
-- elements["PNT_724"] = multiposition_switch_limited("BDHI mode",devices.NAV,device_commands.bdhi_mode,724,3,1.0,false,-1.0,TOGGLECLICK_MID_FWD)    -- values = -1,0,1

-- -- AIRCRAFT WEAPONS RELEASE SYSTEM PANEL #37
-- elements["PNT_740"] = multiposition_switch_limited("AWRS quantity selector",devices.WEAPON_SYSTEM, device_commands.AWRS_quantity,740,12,0.05,false,nil,KNOBCLICK_MID_FWD, 1)
-- elements["PNT_742"] = default_axis_limited("AWRS drop interval",devices.WEAPON_SYSTEM, device_commands.AWRS_drop_interval,742,0,0.05,false,false, {0, 0.9})
-- -- elements["PNT_742"].arg_lim = {0,0.9}

-- elements["PNT_743"] = default_2_position_tumb("AWRS multiplier",devices.WEAPON_SYSTEM, device_commands.AWRS_multiplier,743,TOGGLECLICK_MID_FWD)
-- elements["PNT_744"] = multiposition_switch_limited("AWRS mode",devices.WEAPON_SYSTEM, device_commands.AWRS_stepripple,744,6,0.1,false,nil,KNOBCLICK_MID_FWD, 2)
-- --elements["PNT_744"].animated        = {true, true}
-- --elements["PNT_744"].animation_speed = {4, 4}  -- multiply these numbers by the base 1.0 second animation speed to get final speed.  4 means animates in 0.25 seconds.

-- -- MISC SWITCHES PANEL #36
-- elements["PNT_720"] = default_button("Show EXT Fuel", devices.AVIONICS, device_commands.FuelGaugeExtButton, 720)
-- elements["PNT_723"] = default_button("Master test", devices.AVIONICS, device_commands.master_test, 723)
-- elements["PNT_725"] = multiposition_switch_limited( "Shrike Selector Knob", devices.WEAPON_SYSTEM, device_commands.shrike_selector, 725, 5, 0.1, false, nil, KNOBCLICK_MID_FWD, 2)
-- elements["PNT_726"] = default_axis_limited( "Sidewinder Volume Knob", devices.WEAPON_SYSTEM, device_commands.shrike_sidewinder_volume, 726, 0, 0.1, false, false, {-1.0,1.0} )


-- -- ALTIMETER PANEL #41
-- elements["PNT_827"] = default_axis("Altimeter Setting", devices.AVIONICS, device_commands.AltPressureKnob, 827, 0, 0.05, false, true)

-- -- IAS Gauge
-- elements["PNT_884"] = default_button_axis("IAS Index",devices.AVIONICS, device_commands.ias_index_button, device_commands.ias_index_knob,885,884)
-- elements["PNT_884"].relative = {false,true}
-- elements["PNT_884"].gain = {1.0, 0.2}

-- -- GUNSIGHT
-- elements["PNT_895"] = default_axis("Gunsight Light Control",devices.GUNSIGHT, device_commands.GunsightBrightness,895,0,0.05,false,false)
-- elements["PNT_891"] = default_2_position_tumb("Gunsight Day/Night Switch",devices.GUNSIGHT, device_commands.GunsightDayNight,891,TOGGLECLICK_MID_FWD)
-- elements["PNT_892"] = default_movable_axis("Gunsight Elevation Control", devices.GUNSIGHT, device_commands.GunsightKnob, 892, 1.0, 0.05, false, false)

-- -- ARN-52V TACAN
-- elements["PNT_900"] = multiposition_switch_limited("TACAN Mode", devices.NAV, device_commands.tacan_mode, 900, 4, 0.1, false, nil, KNOBCLICK_RIGHT_MID)
-- elements["PNT_900"].animated        = {true, true}
-- elements["PNT_900"].animation_speed = {4, 4}  -- multiply these numbers by the base 1.0 second animation speed to get final speed.  4 means animates in 0.25 seconds.
-- elements["PNT_901"] = multiposition_switch_limited("TACAN Channel Major", devices.NAV, device_commands.tacan_ch_major, 901, 13, 0.05, false, nil, KNOBCLICK_RIGHT_MID)
-- elements["PNT_902"] = multiposition_switch_limited("TACAN Channel Minor", devices.NAV, device_commands.tacan_ch_minor, 902, 10, 0.1, false,nil, KNOBCLICK_RIGHT_MID)
-- --elements["PNT_902"] = default_button_tumb("TACAN Channel Minor", devices.NAV, device_commands.tacan_ch_minor_dec, device_commands.tacan_ch_minor_inc, 902)
-- elements["PNT_903"] = default_axis_limited("TACAN Volume", devices.NAV, device_commands.tacan_volume, 903, 0.0, 0.3, false, false, {-1,1} )

-- -- DOPPLER NAVIGATION COMPUTER #50 (ASN-41 / APN-153)
-- elements["PNT_170"] = multiposition_switch_limited("APN-153 Doppler Radar Mode",devices.NAV, device_commands.doppler_select,170,5,0.1,false,nil, KNOBCLICK_RIGHT_FWD)
-- elements["PNT_170"].animated        = {true, true}
-- elements["PNT_170"].animation_speed = {4, 4}  -- multiply these numbers by the base 1.0 second animation speed to get final speed.  4 means animates in 0.25 seconds.
-- elements["PNT_247"] = default_button("APN-153 Memory Light Test", devices.NAV, device_commands.doppler_memory_test, 247)

-- elements["PNT_176"] = multiposition_switch_limited("ASN-41 Function Selector Switch",devices.NAV, device_commands.nav_select,176,5,0.1,false,nil, KNOBCLICK_RIGHT_FWD)
-- elements["PNT_176"].animated        = {true, true}
-- elements["PNT_176"].animation_speed = {4, 4}  -- multiply these numbers by the base 1.0 second animation speed to get final speed.  4 means animates in 0.25 seconds.
-- elements["PNT_177"] = default_button_axis("ASN-41 Present Position - Latitude Knob", devices.NAV, device_commands.ppos_lat_push, device_commands.ppos_lat, 236, 177, 1, 1)
-- elements["PNT_177"].relative[2] = true
-- elements["PNT_177"].arg_value[2] = 1
-- elements["PNT_177"].animated = {true, false}
-- elements["PNT_177"].animation_speed = {16.0, 0}
-- elements["PNT_177"].sound = {{KNOBCLICK_RIGHT_FWD}, {KNOBCLICK_RIGHT_MID}}
-- elements["PNT_183"] = default_button_axis("ASN-41 Present Position - Longitude Knob", devices.NAV, device_commands.ppos_lon_push, device_commands.ppos_lon, 237, 183, 1, 1)
-- elements["PNT_183"].relative[2] = true
-- elements["PNT_183"].arg_value[2] = 1
-- elements["PNT_183"].animated = {true, false}
-- elements["PNT_183"].animation_speed = {16.0, 0}
-- elements["PNT_183"].sound = {{KNOBCLICK_RIGHT_FWD}, {KNOBCLICK_RIGHT_MID}}
-- elements["PNT_190"] = default_button_axis("ASN-41 Destination - Latitude Knob", devices.NAV, device_commands.dest_lat_push, device_commands.dest_lat, 238, 190, 1, 1)
-- elements["PNT_190"].relative[2] = true
-- elements["PNT_190"].arg_value[2] = 1
-- elements["PNT_190"].animated = {true, false}
-- elements["PNT_190"].animation_speed = {16.0, 0}
-- elements["PNT_190"].sound = {{KNOBCLICK_RIGHT_FWD}, {KNOBCLICK_RIGHT_MID}}
-- elements["PNT_196"] = default_button_axis("ASN-41 Destination - Longitude Knob", devices.NAV, device_commands.dest_lon_push, device_commands.dest_lon, 239, 196, 1, 1)
-- elements["PNT_196"].relative[2] = true
-- elements["PNT_196"].arg_value[2] = 1
-- elements["PNT_196"].animated = {true, false}
-- elements["PNT_196"].animation_speed = {16.0, 0}
-- elements["PNT_196"].sound = {{KNOBCLICK_RIGHT_FWD}, {KNOBCLICK_RIGHT_MID}}

-- elements["PNT_203"] = default_button_axis("ASN-41 Magnetic Variation Knob", devices.NAV, device_commands.asn41_magvar_push, device_commands.asn41_magvar, 240, 203, 1, 1)
-- elements["PNT_203"].relative[2] = true
-- elements["PNT_203"].arg_value[2] = 1
-- elements["PNT_203"].animated = {true, false}
-- elements["PNT_203"].animation_speed = {16.0, 0}
-- elements["PNT_203"].sound = {{KNOBCLICK_RIGHT_FWD}, {KNOBCLICK_RIGHT_MID}}
-- elements["PNT_209"] = default_button_axis("ASN-41 Wind Speed Knob", devices.NAV, device_commands.asn41_windspeed_push, device_commands.asn41_windspeed, 241, 209, 1, 1)
-- elements["PNT_209"].relative[2] = true
-- elements["PNT_209"].arg_value[2] = 1
-- elements["PNT_209"].animated = {true, false}
-- elements["PNT_209"].animation_speed = {16.0, 0}
-- elements["PNT_209"].sound = {{KNOBCLICK_RIGHT_FWD}, {KNOBCLICK_RIGHT_MID}}
-- elements["PNT_213"] = default_button_axis("ASN-41 Wind Direction Knob", devices.NAV, device_commands.asn41_winddir_push, device_commands.asn41_winddir, 242, 213, 1, 1)
-- elements["PNT_213"].relative[2] = true
-- elements["PNT_213"].arg_value[2] = 1
-- elements["PNT_213"].animated = {true, false}
-- elements["PNT_213"].animation_speed = {16.0, 0}
-- elements["PNT_213"].sound = {{KNOBCLICK_RIGHT_FWD}, {KNOBCLICK_RIGHT_MID}}

-- -- LIGHTS SWITCHES PANEL #47
-- -- see also PNT_83 on the throttle, for master external lighting switch
-- elements["PNT_217"] = multiposition_switch_limited("Probe Light", devices.EXT_LIGHTS, device_commands.extlight_probe, 217, 3, 1, true, -1.0, TOGGLECLICK_RIGHT_MID)
-- elements["PNT_218"] = default_2_position_tumb("Taxi Light", devices.EXT_LIGHTS, device_commands.extlight_taxi, 218, TOGGLECLICK_RIGHT_MID)
-- elements["PNT_219"] = default_2_position_tumb("Anti-Collision Lights", devices.EXT_LIGHTS, device_commands.extlight_anticoll, 219, TOGGLECLICK_RIGHT_MID)
-- elements["PNT_220"] = multiposition_switch_limited("Fuselage Lights", devices.EXT_LIGHTS, device_commands.extlight_fuselage, 220, 3, 1, true, -1.0, TOGGLECLICK_RIGHT_MID)
-- elements["PNT_221"] = default_2_position_tumb("Lighting Flash/Steady mode", devices.EXT_LIGHTS, device_commands.extlight_flashsteady, 221, TOGGLECLICK_RIGHT_MID)
-- elements["PNT_222"] = multiposition_switch_limited("Navigation Lights", devices.EXT_LIGHTS, device_commands.extlight_nav, 222, 3, 1, true, -1.0, TOGGLECLICK_RIGHT_MID)
-- elements["PNT_223"] = multiposition_switch_limited("Tail Light", devices.EXT_LIGHTS, device_commands.extlight_tail, 223, 3, 1, true, -1.0, TOGGLECLICK_RIGHT_MID)

-- -- MISC SWITCHES PANEL #53
-- elements["PNT_1061"] = default_2_position_tumb("Emergency generator bypass",devices.ELECTRIC_SYSTEM, device_commands.emer_gen_bypass,1061, TOGGLECLICK_RIGHT_AFT)

-- -- INTERIOR LIGHTING PANEL #54
-- elements["PNT_106"] = default_axis_limited( "Instrument Lighting", devices.AVIONICS, device_commands.intlight_instruments, 106, 0.0, 0.3, false, false, {0,1} )
-- elements["PNT_107"] = default_axis_limited( "Console Lighting", devices.AVIONICS, device_commands.intlight_console, 107, 0.0, 0.3, false, false, {0,1} )
-- elements["PNT_108"] = multiposition_switch_limited("Console Light Intensity", devices.AVIONICS, device_commands.intlight_brightness, 108, 3, 1, true, -1.0, TOGGLECLICK_RIGHT_AFT)
-- elements["PNT_110"] = default_axis_limited( "White Floodlight Control", devices.AVIONICS, device_commands.intlight_whiteflood, 110, 0.0, 0.3, false, false, {0,1} )

-- -- AN/ARC-51 UHF RADIO #67
-- elements["PNT_361"] = multiposition_switch_limited("ARC-51 UHF Preset Channel", devices.RADIO, device_commands.arc51_freq_preset, 361, 20, 0.05, false, 0.00, KNOBCLICK_RIGHT_MID)
-- elements["PNT_365"] = default_axis_limited("ARC-51 UHF Volume", devices.RADIO, device_commands.arc51_volume, 365, 0.5, 0.3, false, false, {0,1})
-- elements["PNT_366"] = multiposition_switch_limited("ARC-51 UHF Frequency Mode", devices.RADIO, device_commands.arc51_xmitmode, 366, 3, 1, true, -1, KNOBCLICK_RIGHT_MID)
-- elements["PNT_367"] = multiposition_switch_limited("ARC-51 UHF Manual Frequency 10 MHz", devices.RADIO, device_commands.arc51_freq_XXxxx, 367, 18, 0.05, false, 0, KNOBCLICK_RIGHT_MID)
-- elements["PNT_368"] = multiposition_switch_limited("ARC-51 UHF Manual Frequency 1 MHz", devices.RADIO, device_commands.arc51_freq_xxXxx, 368, 10, 0.1, false, 0, KNOBCLICK_RIGHT_MID)
-- elements["PNT_369"] = multiposition_switch_limited("ARC-51 UHF Manual Frequency 50 kHz", devices.RADIO, device_commands.arc51_freq_xxxXX, 369, 20, 0.05, false, 0, KNOBCLICK_RIGHT_MID)
-- elements["PNT_370"] = default_2_position_tumb("ARC-51 UHF Squelch Disable", devices.RADIO, device_commands.arc51_squelch, 370, TOGGLECLICK_RIGHT_MID)
-- elements["PNT_372"] = multiposition_switch_limited("ARC-51 UHF Mode", devices.RADIO, device_commands.arc51_mode, 372, 4, 0.1, false, 0, KNOBCLICK_RIGHT_MID)

-- -- COMPASS CONTROLLER
-- elements["PNT_509"] = default_axis_limited("Compass latitude knob", devices.COMPASS, device_commands.COMPASS_latitude, 509, 0, 0.3, false, false, {-1,1})
-- elements["PNT_511"] = springloaded_3_pos_tumb("Compass heading set knob", devices.COMPASS, device_commands.COMPASS_set_heading, 511, true, KNOBCLICK_RIGHT_MID)
-- elements["PNT_512"] = default_2_position_tumb("Compass Free/Slaved Mode Switch", devices.COMPASS, device_commands.COMPASS_free_slaved_switch, 512, TOGGLECLICK_RIGHT_MID) -- NO COMMAND
-- elements["PNT_513"] = default_button("Compass Push to Sync", devices.COMPASS, device_commands.COMPASS_push_to_sync, 513) -- NO COMMAND


-- -- T handles
-- elements["PNT_1240"] = default_2_position_tumb("Emergency gear release",devices.GEAR, device_commands.emer_gear_release,1240)
-- elements["PNT_1240"].animated        = {true, true}
-- elements["PNT_1240"].animation_speed = {15, 15}
-- elements["PNT_1241"] = default_2_position_tumb("Emergency bomb release",devices.WEAPON_SYSTEM, device_commands.emer_bomb_release,1241)
-- elements["PNT_1241"].animated        = {true, true}
-- elements["PNT_1241"].animation_speed = {15, 15}
-- elements["PNT_1242"] = default_2_position_tumb("Manual Flight Control",devices.HYDRAULIC_SYSTEM, device_commands.man_flt_control_override,1242)
-- elements["PNT_1242"].animated        = {true, true}
-- elements["PNT_1242"].animation_speed = {15, 15}
-- elements["PNT_1243"] = default_2_position_tumb("Emergency generator deploy",devices.ELECTRIC_SYSTEM, device_commands.emer_gen_deploy,1243)
-- elements["PNT_1243"].animated        = {true, true}
-- elements["PNT_1243"].animation_speed = {15, 15}

-- -- ECM panel
-- elements["PNT_503"] = default_2_position_tumb("Audio APR/25 - APR/27",devices.RWR,device_commands.ecm_apr25_audio,	503,TOGGLECLICK_LEFT_MID)
-- elements["PNT_504"] = default_2_position_tumb("APR/25 on/off",	devices.RWR, device_commands.ecm_apr25_off,		504,TOGGLECLICK_LEFT_MID)
-- elements["PNT_501"] = default_2_position_tumb("APR/27 on/off",	devices.RWR, device_commands.ecm_apr27_off,		501,TOGGLECLICK_LEFT_MID)

-- elements["PNT_507"] = default_button("APR/27 test", devices.RWR, device_commands.ecm_systest_upper, 507)--,TOGGLECLICK_LEFT_MID)
-- elements["PNT_510"] = default_button("APR/27 light", devices.RWR, device_commands.ecm_systest_lower, 510)--,TOGGLECLICK_LEFT_MID)

-- elements["PNT_506"] = default_axis_limited( "PRF volume (inner knob)", devices.RWR, device_commands.ecm_msl_alert_axis_inner, 506, 0.0, 0.3, false, false, {-0.8,0.8} )
-- elements["PNT_505"] = default_axis_limited( "MSL volume (outer knob)", devices.RWR, device_commands.ecm_msl_alert_axis_outer, 505, 0.0, 0.3, false, false, {-0.8,0.8} )

-- elements["PNT_502"] = multiposition_switch_limited("ECM selector knob",devices.RWR, device_commands.ecm_selector_knob,502,4,0.33,false,0.0,KNOBCLICK_MID_FWD, 5)

-- -- AIR CONDITIONING PANEL
-- elements["PNT_1251"] = default_2_position_tumb("Cabin Pressure Switch", devices.ELECTRIC_SYSTEM, device_commands.cabin_pressure , 224, TOGGLECLICK_LEFT_MID)
-- elements["PNT_225"] = default_3_position_tumb("Windshield Defrost", devices.ELECTRIC_SYSTEM, device_commands.windshield_defrost , 225, nil, nil, TOGGLECLICK_MID_FWD)
-- elements["PNT_226"] = default_axis_limited("Cabin Temp Knob", devices.ELECTRIC_SYSTEM, device_commands.cabin_temp , 226, 0.0, 0.3, false, false, {0,1} )

-- -- EJECTION SEAT
-- elements["PNT_24"] = default_2_position_tumb("Shoulder Harness Inertia Reel Control", devices.AVIONICS ,device_commands.CPT_shoulder_harness, 24, nil)
-- elements["PNT_24"].animated        = {true, true}
-- elements["PNT_24"].animation_speed = {7, 7}
-- elements["PNT_25"] = default_2_position_tumb("Secondary Ejection Handle", devices.AVIONICS ,device_commands.CPT_secondary_ejection_handle, 25, nil)
-- elements["PNT_25"].animated        = {true, true}
-- elements["PNT_25"].animation_speed = {7, 7}

-- Commented out because it doesn't seem to be required anymore [HECLAK]
-- Can be removed if someone figures out what the original requirement was
-- for i,o in pairs(elements) do
-- 	if  o.class[1] == class_type.TUMB or 
-- 	   (o.class[2]  and o.class[2] == class_type.TUMB) or
-- 	   (o.class[3]  and o.class[3] == class_type.TUMB)  then
-- 	   o.updatable = true
-- 	   o.use_OBB   = true
-- end


-------------------------------------------------------
--FC3 Commands
-------------------------------------------------------

-------------------------------------------------------
--Left Console Panel
------------------------------------------------------- 

-------------------------------------------------------
--Left Auxiliary Console
-------------------------------------------------------

-------------------------------------------------------
--UCP (Upfront Control Panel)
-------------------------------------------------------

-------------------------------------------------------
--Instrument Panel
-------------------------------------------------------

-------------------------------------------------------
--LD
-------------------------------------------------------
-------------------------------------------------------
--CD
-------------------------------------------------------
-------------------------------------------------------
--RD (Check FC3 Commands)
-------------------------------------------------------

-------------------------------------------------------
--Right Auxiliary Console
-------------------------------------------------------

-------------------------------------------------------
--Right Console Panel
-------------------------------------------------------
-------------------------------------------------------
--HOTAS
-------------------------------------------------------

-------------------------------------------------------
--Ejection Seat
-------------------------------------------------------