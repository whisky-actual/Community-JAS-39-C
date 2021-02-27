local res = external_profile("Config/Input/Aircrafts/base_keyboard_binding.lua")
-- dofile(LockOn_Options.script_path.."devices.lua")
-- dofile(LockOn_Options.script_path.."command_defs.lua")

-- ignore_features(res.keyCommands,{"dragchute"})

local SelectLeft    = 10000
local SelectRight   = 10001
local SelectCenter  = 10002
local SelectAll     = 10003
local SelectStep    = 10004
local Dogfight      = 10005
local AirORIDE      = 10006
local MasterArm     = 10007
local MasterArm_T   = 10008
local Battery       = 10009
local Battery_T     = 10010
local L_GEN         = 10011
local L_GEN_T       = 10012
local R_GEN         = 10013
local R_GEN_T       = 10014
local AAR           = 10015
local AAR_T         = 10016
local DayNight      = 10017
local DayNight_T    = 10018
local Park          = 10019
local Park_T        = 10020
local Detent_F      = 10021
local Detent_S      = 10022
local Brakes        = 10023  
local AirORIDE_T    = 10024    
local APU           = 10025   
local PICKLE        = 10026
local SMFD_Swap     = 10027  
local L_cutoff      = 10028
local R_cutoff      = 10029  
local FCSCenter     = 10030
local FCSNoseUp     = 10031
local FCSNoseDn     = 10032
local FCSRel        = 10033
local FCSMode       = 10034
local FCSAOA        = 10035
local FCSG          = 10036
local FCSStep       = 10037
local BrakesON      = 10038
local BrakesOFF     = 10039
local FCSpitch      = 10040
local ICP_COM1      = 10041
local ICP_COM2      = 10042
local ICP_NAV       = 10043
local ICP_STPT      = 10044
local ICP_ALT       = 10045
local ICP_HUD       = 10046
local ICP_AP        = 10047
local ICP_OP1       = 10048
local ICP_OP2       = 10049
local ICP_OP3       = 10050
local ICP_OP4       = 10051
local ICP_OP5       = 10052
local ICP_OTHR      = 10053
local CLIPBOARD_L   = 10054
local CLIPBOARD_R   = 10055
--local L_BRAKE       = 10056
--local R_BRAKE       = 10057
--Left MFD
    local LMFD_OSB_01    = 10061
    local LMFD_OSB_02    = 10062
    local LMFD_OSB_03    = 10063
    local LMFD_OSB_04    = 10064
    local LMFD_OSB_05    = 10065
    local LMFD_OSB_06    = 10066
    local LMFD_OSB_07    = 10067
    local LMFD_OSB_08    = 10068
    local LMFD_OSB_09    = 10069
    local LMFD_OSB_10    = 10070
    local LMFD_OSB_11    = 10071
    local LMFD_OSB_12    = 10072
    local LMFD_OSB_13    = 10073
    local LMFD_OSB_14    = 10074
    local LMFD_OSB_15    = 10075
    local LMFD_OSB_16    = 10076
    local LMFD_OSB_17    = 10077
    local LMFD_OSB_18    = 10078
    local LMFD_OSB_19    = 10079
    local LMFD_OSB_20    = 10080
--Right MFD
    local RMFD_OSB_01    = 10091
    local RMFD_OSB_02    = 10092
    local RMFD_OSB_03    = 10093
    local RMFD_OSB_04    = 10094
    local RMFD_OSB_05    = 10095
    local RMFD_OSB_06    = 10096
    local RMFD_OSB_07    = 10097
    local RMFD_OSB_08    = 10098
    local RMFD_OSB_09    = 10099
    local RMFD_OSB_10    = 10100
    local RMFD_OSB_11    = 10101
    local RMFD_OSB_12    = 10102
    local RMFD_OSB_13    = 10103
    local RMFD_OSB_14    = 10104
    local RMFD_OSB_15    = 10105
    local RMFD_OSB_16    = 10106
    local RMFD_OSB_17    = 10107
    local RMFD_OSB_18    = 10108
    local RMFD_OSB_19    = 10109
    local RMFD_OSB_20    = 10110
--Center MFD
    local CMFD_OSB_01    = 10111
    local CMFD_OSB_02    = 10112
    local CMFD_OSB_03    = 10113
    local CMFD_OSB_04    = 10114
    local CMFD_OSB_05    = 10115
    local CMFD_OSB_06    = 10116
    local CMFD_OSB_07    = 10117
    local CMFD_OSB_08    = 10118
    local CMFD_OSB_09    = 10119
    local CMFD_OSB_10    = 10120
    local CMFD_OSB_11    = 10121
    local CMFD_OSB_12    = 10122
    local CMFD_OSB_13    = 10123
    local CMFD_OSB_14    = 10124
    local CMFD_OSB_15    = 10125
    local CMFD_OSB_16    = 10126
    local CMFD_OSB_17    = 10127
    local CMFD_OSB_18    = 10128
    local CMFD_OSB_19    = 10129
    local CMFD_OSB_20    = 10130
--PMFD
    local PMFD_OSB_01    = 10131
    local PMFD_OSB_02    = 10132
    local PMFD_OSB_03    = 10133
    local PMFD_OSB_04    = 10134
    local PMFD_OSB_05    = 10135
    local PMFD_OSB_06    = 10136
    local PMFD_OSB_07    = 10137
    local PMFD_OSB_08    = 10138
    local PMFD_OSB_09    = 10139
    local PMFD_OSB_10    = 10140
    local PMFD_OSB_11    = 10141
    local PMFD_OSB_12    = 10142
    local PMFD_OSB_13    = 10143
    local PMFD_OSB_14    = 10144
    local PMFD_OSB_15    = 10145
    local PMFD_OSB_16    = 10146
    local PMFD_OSB_17    = 10147
    local PMFD_OSB_18    = 10148
    local PMFD_OSB_19    = 10149
    local PMFD_OSB_20    = 10150

    local LIGHT_TAXI      = 10151
    local LIGHT_TAXI_T    = 10152
    local LIGHT_LANDING   = 10153
    local LIGHT_LANDING_T = 10154

join(res.keyCommands,{
    
--SMFD Both    
    {down = SMFD_Swap,                  name = _('SMFD Page Swap'),                       category = _('F-22A Systems')},
--MFD LEFT
    {down = LMFD_OSB_01,                name = _('MFD Left OSB 1'),                       category = _('F-22A MFD Left')},
    {down = LMFD_OSB_02,                name = _('MFD Left OSB 2'),                       category = _('F-22A MFD Left')},
    {down = LMFD_OSB_03,                name = _('MFD Left OSB 3'),                       category = _('F-22A MFD Left')},
    {down = LMFD_OSB_04,                name = _('MFD Left OSB 4'),                       category = _('F-22A MFD Left')},
    {down = LMFD_OSB_05,                name = _('MFD Left OSB 5'),                       category = _('F-22A MFD Left')},
    {down = LMFD_OSB_06,                name = _('MFD Left OSB 6'),                       category = _('F-22A MFD Left')},
    {down = LMFD_OSB_07,                name = _('MFD Left OSB 7'),                       category = _('F-22A MFD Left')},
    {down = LMFD_OSB_08,                name = _('MFD Left OSB 8'),                       category = _('F-22A MFD Left')},
    {down = LMFD_OSB_09,                name = _('MFD Left OSB 9'),                       category = _('F-22A MFD Left')},
    {down = LMFD_OSB_10,                name = _('MFD Left OSB 10'),                      category = _('F-22A MFD Left')},
    {down = LMFD_OSB_11,                name = _('MFD Left OSB 11'),                      category = _('F-22A MFD Left')},
    {down = LMFD_OSB_12,                name = _('MFD Left OSB 12'),                      category = _('F-22A MFD Left')},
    {down = LMFD_OSB_13,                name = _('MFD Left OSB 13'),                      category = _('F-22A MFD Left')},
    {down = LMFD_OSB_14,                name = _('MFD Left OSB 14'),                      category = _('F-22A MFD Left')},
    {down = LMFD_OSB_15,                name = _('MFD Left OSB 15'),                      category = _('F-22A MFD Left')},
    {down = LMFD_OSB_16,                name = _('MFD Left OSB 16'),                      category = _('F-22A MFD Left')},
    {down = LMFD_OSB_17,                name = _('MFD Left OSB 17'),                      category = _('F-22A MFD Left')},
    {down = LMFD_OSB_18,                name = _('MFD Left OSB 18'),                      category = _('F-22A MFD Left')},
    {down = LMFD_OSB_19,                name = _('MFD Left OSB 19'),                      category = _('F-22A MFD Left')},
    {down = LMFD_OSB_20,                name = _('MFD Left OSB 20'),                      category = _('F-22A MFD Left')},
--MFD RIGHT
    {down = RMFD_OSB_01,                name = _('MFD Right OSB 1'),                      category = _('F-22A MFD Right')},
    {down = RMFD_OSB_02,                name = _('MFD Right OSB 2'),                      category = _('F-22A MFD Right')},
    {down = RMFD_OSB_03,                name = _('MFD Right OSB 3'),                      category = _('F-22A MFD Right')},
    {down = RMFD_OSB_04,                name = _('MFD Right OSB 4'),                      category = _('F-22A MFD Right')},
    {down = RMFD_OSB_05,                name = _('MFD Right OSB 5'),                      category = _('F-22A MFD Right')},
    {down = RMFD_OSB_06,                name = _('MFD Right OSB 6'),                      category = _('F-22A MFD Right')},
    {down = RMFD_OSB_07,                name = _('MFD Right OSB 7'),                      category = _('F-22A MFD Right')},
    {down = RMFD_OSB_08,                name = _('MFD Right OSB 8'),                      category = _('F-22A MFD Right')},
    {down = RMFD_OSB_09,                name = _('MFD Right OSB 9'),                      category = _('F-22A MFD Right')},
    {down = RMFD_OSB_10,                name = _('MFD Right OSB 10'),                     category = _('F-22A MFD Right')},
    {down = RMFD_OSB_11,                name = _('MFD Right OSB 11'),                     category = _('F-22A MFD Right')},
    {down = RMFD_OSB_12,                name = _('MFD Right OSB 12'),                     category = _('F-22A MFD Right')},
    {down = RMFD_OSB_13,                name = _('MFD Right OSB 13'),                     category = _('F-22A MFD Right')},
    {down = RMFD_OSB_14,                name = _('MFD Right OSB 14'),                     category = _('F-22A MFD Right')},
    {down = RMFD_OSB_15,                name = _('MFD Right OSB 15'),                     category = _('F-22A MFD Right')},
    {down = RMFD_OSB_16,                name = _('MFD Right OSB 16'),                     category = _('F-22A MFD Right')},
    {down = RMFD_OSB_17,                name = _('MFD Right OSB 17'),                     category = _('F-22A MFD Right')},
    {down = RMFD_OSB_18,                name = _('MFD Right OSB 18'),                     category = _('F-22A MFD Right')},
    {down = RMFD_OSB_19,                name = _('MFD Right OSB 19'),                     category = _('F-22A MFD Right')},
    {down = RMFD_OSB_20,                name = _('MFD Right OSB 20'),                     category = _('F-22A MFD Right')},
--MFD RIGHT
    {down = CMFD_OSB_01,                name = _('MFD Center OSB 1'),                     category = _('F-22A MFD Center')},
    {down = CMFD_OSB_02,                name = _('MFD Center OSB 2'),                     category = _('F-22A MFD Center')},
    {down = CMFD_OSB_03,                name = _('MFD Center OSB 3'),                     category = _('F-22A MFD Center')},
    {down = CMFD_OSB_04,                name = _('MFD Center OSB 4'),                     category = _('F-22A MFD Center')},
    {down = CMFD_OSB_05,                name = _('MFD Center OSB 5'),                     category = _('F-22A MFD Center')},
    {down = CMFD_OSB_06,                name = _('MFD Center OSB 6'),                     category = _('F-22A MFD Center')},
    {down = CMFD_OSB_07,                name = _('MFD Center OSB 7'),                     category = _('F-22A MFD Center')},
    {down = CMFD_OSB_08,                name = _('MFD Center OSB 8'),                     category = _('F-22A MFD Center')},
    {down = CMFD_OSB_09,                name = _('MFD Center OSB 9'),                     category = _('F-22A MFD Center')},
    {down = CMFD_OSB_10,                name = _('MFD Center OSB 10'),                    category = _('F-22A MFD Center')},
    {down = CMFD_OSB_11,                name = _('MFD Center OSB 11'),                    category = _('F-22A MFD Center')},
    {down = CMFD_OSB_12,                name = _('MFD Center OSB 12'),                    category = _('F-22A MFD Center')},
    {down = CMFD_OSB_13,                name = _('MFD Center OSB 13'),                    category = _('F-22A MFD Center')},
    {down = CMFD_OSB_14,                name = _('MFD Center OSB 14'),                    category = _('F-22A MFD Center')},
    {down = CMFD_OSB_15,                name = _('MFD Center OSB 15'),                    category = _('F-22A MFD Center')},
    {down = CMFD_OSB_16,                name = _('MFD Center OSB 16'),                    category = _('F-22A MFD Center')},
    {down = CMFD_OSB_17,                name = _('MFD Center OSB 17'),                    category = _('F-22A MFD Center')},
    {down = CMFD_OSB_18,                name = _('MFD Center OSB 18'),                    category = _('F-22A MFD Center')},
    {down = CMFD_OSB_19,                name = _('MFD Center OSB 19'),                    category = _('F-22A MFD Center')},
    {down = CMFD_OSB_20,                name = _('MFD Center OSB 20'),                    category = _('F-22A MFD Center')},
--PMFD
    {down = PMFD_OSB_01,                name = _('PMFD OSB 1'),                           category = _('F-22A PMFD')},
    {down = PMFD_OSB_02,                name = _('PMFD OSB 2'),                           category = _('F-22A PMFD')},
    {down = PMFD_OSB_03,                name = _('PMFD OSB 3'),                           category = _('F-22A PMFD')},
    {down = PMFD_OSB_04,                name = _('PMFD OSB 4'),                           category = _('F-22A PMFD')},
    {down = PMFD_OSB_05,                name = _('PMFD OSB 5'),                           category = _('F-22A PMFD')},
    {down = PMFD_OSB_06,                name = _('PMFD OSB 6'),                           category = _('F-22A PMFD')},
    {down = PMFD_OSB_07,                name = _('PMFD OSB 7'),                           category = _('F-22A PMFD')},
    {down = PMFD_OSB_08,                name = _('PMFD OSB 8'),                           category = _('F-22A PMFD')},
    {down = PMFD_OSB_09,                name = _('PMFD OSB 9'),                           category = _('F-22A PMFD')},
    {down = PMFD_OSB_10,                name = _('PMFD OSB 10'),                          category = _('F-22A PMFD')},
    {down = PMFD_OSB_11,                name = _('PMFD OSB 11'),                          category = _('F-22A PMFD')},
    {down = PMFD_OSB_12,                name = _('PMFD OSB 12'),                          category = _('F-22A PMFD')},
    {down = PMFD_OSB_13,                name = _('PMFD OSB 13'),                          category = _('F-22A PMFD')},
    {down = PMFD_OSB_14,                name = _('PMFD OSB 14'),                          category = _('F-22A PMFD')},
    {down = PMFD_OSB_15,                name = _('PMFD OSB 15'),                          category = _('F-22A PMFD')},
    {down = PMFD_OSB_16,                name = _('PMFD OSB 16'),                          category = _('F-22A PMFD')},
    {down = PMFD_OSB_17,                name = _('PMFD OSB 17'),                          category = _('F-22A PMFD')},
    {down = PMFD_OSB_18,                name = _('PMFD OSB 18'),                          category = _('F-22A PMFD')},
    {down = PMFD_OSB_19,                name = _('PMFD OSB 19'),                          category = _('F-22A PMFD')},
    {down = PMFD_OSB_20,                name = _('PMFD OSB 20'),                          category = _('F-22A PMFD')}, 
--CLIPBOARD BINDS
    {down = CLIPBOARD_L,                name = _('Clipboard Left Show/Hide'),            category = _('F-22A Systems')},
    {down = CLIPBOARD_R,                name = _('Clipboard Right Show/Hide'),           category = _('F-22A Systems')},    
--F-22 Weapons
    {down = Detent_F, up = Detent_F,    name = _('Weapons: Trigger First Detent'),       category = _('F-22A HOTAS')},
    {down = Detent_S, up = Detent_S,    name = _('Weapons: Trigger Second Detent'),      category = _('F-22A HOTAS')},
    {down = PICKLE, up = PICKLE,        name = _('Weapons: Release'),                    category = _('F-22A HOTAS')},
--ICP BINDS
    {down = ICP_COM1,                   name = _('ICP COMM 1'),                          category = _('F-22A ICP')},
    {down = ICP_COM2,                   name = _('ICP COMM 2'),                          category = _('F-22A ICP')},
    {down = ICP_NAV,                    name = _('ICP NAV'),                             category = _('F-22A ICP')},
    {down = ICP_STPT,                   name = _('ICP STPT'),                            category = _('F-22A ICP')},
    {down = ICP_ALT,                    name = _('ICP ALT'),                             category = _('F-22A ICP')},
    {down = ICP_HUD,                    name = _('ICP HUD'),                             category = _('F-22A ICP')},
    {down = ICP_AP,                     name = _('ICP AP'),                              category = _('F-22A ICP')},
    {down = ICP_OTHR,                   name = _('ICP OTHR'),                            category = _('F-22A ICP')},
    {down = ICP_OP1,                    name = _('ICP Option 1'),                        category = _('F-22A ICP')},
    {down = ICP_OP2,                    name = _('ICP Option 2'),                        category = _('F-22A ICP')},
    {down = ICP_OP3,                    name = _('ICP Option 3'),                        category = _('F-22A ICP')},
    {down = ICP_OP4,                    name = _('ICP Option 4'),                        category = _('F-22A ICP')},
    {down = ICP_OP5,                    name = _('ICP Option 5'),                        category = _('F-22A ICP')},
-- FCS BINDS
    {down = FCSNoseUp, up = FCSRel,     name = _('FCS Trim: Nose Up'),                   category = _('F-22A HOTAS')},
    {down = FCSNoseDn, up = FCSRel,     name = _('FCS Trim: Nose Down'),                 category = _('F-22A HOTAS')},
    {down = FCSCenter,                  name = _('FCS Trim: Center'),                    category = _('F-22A HOTAS')},
    {down = FCSMode,                    name = _('FCS Mode: AUTO/OFF'),                  category = _('F-22A HOTAS')},
    --{down = FCSAOA,                     name = _('FCS Mode: AOA Override'),              category = _('F-22A HOTAS')},
    --{down = FCSG,                       name = _('FCS Mode: G Override'),                category = _('F-22A HOTAS')},
    {down = FCSStep,                    name = _('FCS Mode: AUTO/AOA/G/OFF'),            category = _('F-22A HOTAS')},

    -- {down = L_cutoff, up = L_cutoff,   name = _('Throttle (Left) - OFF/IDLE'),          category = _('F-22A HOTAS')},
    -- {down = R_cutoff, up = R_cutoff,   name = _('Throttle (Right) - OFF/IDLE'),         category = _('F-22A HOTAS')},

--F-22 CUSTOM BINDS
    {down = SelectLeft,                 name = _('Weapon Bay Select Left'),             category = _('F-22A HOTAS')},
    {down = SelectRight,                name = _('Weapon Bay Select Right'),            category = _('F-22A HOTAS')},
    {down = SelectCenter,               name = _('Weapon Bay Select Center'),           category = _('F-22A HOTAS')},
    {down = SelectAll,                  name = _('Weapon Bay Select All'),              category = _('F-22A HOTAS')},
    {down = SelectStep,                 name = _('Weapon Bay Select Toggle'),           category = _('F-22A HOTAS')},
    {down = AirORIDE, up = AirORIDE,    name = _('Weapon Bay Override (AIR)'),          category = _('F-22A HOTAS')},
    {down = AirORIDE_T,                 name = _('Weapon Bay Override Toggle (AIR)'),   category = _('F-22A HOTAS')},
    {down = Dogfight,                   name = _('Dogfight MFD Override'),              category = _('F-22A HOTAS')},
    {down = APU, up = APU,              name = _('APU Start'),                          category = _('F-22A HOTAS')},
--Special Switch Functionality
    {down = Battery, up = Battery,      name = _('Battery On/Off'),                     category = _('F-22A Systems')},
    {down = Battery_T,                  name = _('Battery Toggle'),                     category = _('F-22A Systems')},
    {down = MasterArm, up = MasterArm,  name = _('Master Arm On/Off'),                  category = _('F-22A Systems')},
    {down = MasterArm_T,                name = _('Master Arm Toggle'),                  category = _('F-22A Systems')},
    {down = DayNight, up = DayNight,    name = _('Day/Night Mode'),                     category = _('F-22A Systems')},
    {down = DayNight_T,                 name = _('Day/Night Mode Toggle'),              category = _('F-22A Systems')},
    {down = L_GEN, up = L_GEN,          name = _('Left Generator On/Off'),              category = _('F-22A Systems')},
    {down = L_GEN_T,                    name = _('Left Generator Toggle'),              category = _('F-22A Systems')},
    {down = R_GEN, up = R_GEN,          name = _('Right Generator On/Off'),             category = _('F-22A Systems')},
    {down = R_GEN_T,                    name = _('Right Generator Toggle'),             category = _('F-22A Systems')},
    {down = AAR,   up = AAR,            name = _('Air-Air Refuel Open/Close'),          category = _('F-22A Systems')},
    {down = AAR_T,                      name = _('Air-Air Refuel Toggle'),              category = _('F-22A Systems')},
    {down = Park, up = Park,            name = _('Parking Brake On/Off'),               category = _('F-22A Systems')},
    {down = Park_T,                     name = _('Parking Brake Toggle'),               category = _('F-22A Systems')},
    {down = LIGHT_TAXI, up = LIGHT_TAXI,        name = _('Taxi Light On/Off'),          category = _('F-22A Systems')},   
    {down = LIGHT_TAXI_T,               name = _('Taxi Light Toggle'),                  category = _('F-22A Systems')},
    {down = LIGHT_LANDING, up = LIGHT_LANDING,  name = _('Landing Light On/Off'),       category = _('F-22A Systems')},   
    {down = LIGHT_LANDING_T,            name = _('Landing Light Toggle'),               category = _('F-22A Systems')}, 

    {down = BrakesON, up = BrakesOFF,   name = _('Wheel Brakes Both'), 	                category = _('F-22A Systems')},
    --{down = L_BRAKE,  up = BrakesOFF,   name = _('Wheel Brakes Left'),                  category = _('F-22A Systems')},
    --{down = R_BRAKE,  up = BrakesOFF,   name = _('Wheel Brakes Right'),                 category = _('F-22A Systems')},

-------------------------------------------------------------------------------------------------------------------------------------------------------

    -- Autopilot
    {combos = {{key = 'A'}, {key = '1', reformers = {'LAlt'}}}, down = iCommandPlaneAutopilot, name = _('Autopilot - Attitude Hold'), category = _('Autopilot')},
    {combos = {{key = 'H'}, {key = '2', reformers = {'LAlt'}}}, down = iCommandPlaneStabHbar, name = _('Autopilot - Altitude Hold'), category = _('Autopilot')},
    {combos = {{key = '9', reformers = {'LAlt'}}}, down = iCommandPlaneStabCancel, name = _('Autopilot Disengage'), category = _('Autopilot')},    
    --Flight Control
    {combos = {{key = 'T', reformers = {'LAlt'}}}, down = iCommandPlaneTrimOn, up = iCommandPlaneTrimOff, name = _('T/O Trim'), category = _('Flight Control')},
        -- Systems
    {combos = {{key = 'R', reformers = {'LCtrl'}}}, down = iCommandPlaneAirRefuel, name = _('Refueling Boom'), category = _('Systems')},
    {combos = {{key = 'R', reformers = {'LAlt'}}}, down = iCommandPlaneJettisonFuelTanks, name = _('Jettison Fuel Tanks'), category = _('Systems')},
    {combos = {{key = 'S'}}, down = iCommandPlane_HOTAS_NoseWheelSteeringButton, up = iCommandPlane_HOTAS_NoseWheelSteeringButton, name = _('Nose Gear Maneuvering Range'), category = _('Systems')},
    {combos = {{key = 'Q', reformers = {'LAlt'}}}, down = iCommandPlane_HOTAS_NoseWheelSteeringButtonOff, up = iCommandPlane_HOTAS_NoseWheelSteeringButtonOff, name = _('Nose Wheel Steering'), category = _('Systems')},
    {combos = {{key = 'A', reformers = {'LCtrl'}}}, down = iCommandPlaneWheelBrakeLeftOn, up = iCommandPlaneWheelBrakeLeftOff, name = _('Wheel Brake Left On/Off'), category = _('Systems')},
    {combos = {{key = 'A', reformers = {'LAlt'}}}, down = iCommandPlaneWheelBrakeRightOn, up = iCommandPlaneWheelBrakeRightOff, name = _('Wheel Brake Right On/Off'), category = _('Systems')},
    {combos = {{key = 'T', reformers = {'LShift'}}}, down = iCommandClockElapsedTimeReset, name = _('Elapsed Time Clock Start/Stop/Reset'), category = _('Systems')},
        -- Modes
    {combos = {{key = '2'}}, down = iCommandPlaneModeBVR, name = _('(2) Beyond Visual Range Mode'), category = _('Modes')},
    {combos = {{key = '3'}}, down = iCommandPlaneModeVS, name = _('(3) Close Air Combat Vertical Scan Mode'), category = _('Modes')},
    {combos = {{key = '4'}}, down = iCommandPlaneModeBore, name = _('(4) Close Air Combat Bore Mode'), category = _('Modes')},
    {combos = {{key = '5'}}, down = iCommandPlaneModeHelmet, name = _('(5) Close Air Combat HMD Helmet Mode'), category = _('Modes')},
    {combos = {{key = '6'}}, down = iCommandPlaneModeFI0, name = _('(6) Longitudinal Missile Aiming Mode/FLOOD mode'), category = _('Modes')},
    {combos = {{key = '7'}}, down = iCommandPlaneModeGround, name = _('(7) Air-To-Ground Mode'), category = _('Modes')},
    {combos = {{key = '8'}}, down = iCommandPlaneModeGrid, name = _('(8) Gunsight Reticle Switch'), category = _('Modes')},
        -- Sensors
    {combos = {{key = 'Enter'}}, down = iCommandPlaneChangeLock, up = iCommandPlaneChangeLockUp, name = _('Target Lock'), category = _('Sensors')},
    {combos = {{key = 'Back'}}, down = iCommandSensorReset, name = _('Radar - Return To Search/NDTWS'), category = _('Sensors')},
    {down = iCommandRefusalTWS, name = _('Unlock TWS Target'), category = _('Sensors')},
    {combos = {{key = 'I'}}, down = iCommandPlaneRadarOnOff, name = _('Radar On/Off'), category = _('Sensors')},
    {combos = {{key = 'I', reformers = {'RAlt'}}}, down = iCommandPlaneRadarChangeMode, name = _('Radar RWS/TWS Mode Select'), category = _('Sensors')},
    {combos = {{key = 'I', reformers = {'RCtrl'}}}, down = iCommandPlaneRadarCenter, name = _('Target Designator To Center'), category = _('Sensors')},
    {combos = {{key = 'I', reformers = {'RShift'}}}, down = iCommandPlaneChangeRadarPRF, name = _('Radar Pulse Repeat Frequency Select'), category = _('Sensors')},
    {combos = {{key = 'O'}}, down = iCommandPlaneEOSOnOff, name = _('Electro-Optical System On/Off'), category = _('Sensors')},
    {combos = {{key = 'O', reformers = {'RShift'}}}, down = iCommandPlaneLaserRangerOnOff, name = _('Laser Ranger On/Off'), category = _('Sensors')},
    {combos = {{key = 'O', reformers = {'RCtrl'}}}, down = iCommandPlaneNightTVOnOff, name = _('Night Vision (FLIR or LLTV) On/Off'), category = _('Sensors')},
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
    {combos = {{key = 'Space', reformers = {'RAlt'}}}, down = iCommandPlanePickleOn,	up = iCommandPlanePickleOff, name = _('Weapon Release'), category = _('Weapons')},
    {combos = {{key = 'C', reformers = {'LShift'}}}, down = iCommandChangeGunRateOfFire, name = _('Cannon Rate Of Fire / Cut Of Burst select'), category = _('Weapons')},
    })
    return res