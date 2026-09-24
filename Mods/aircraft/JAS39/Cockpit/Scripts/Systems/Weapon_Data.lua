wTypes = {
	none = -1,
	AA = 1,    -- General A/A (S5 up), all A/A weapons in one priority list
	dogfight = 2, -- Dogfight (S5 left), only IR-missiles and the gun
	gun = 3,   -- Used in Weapon_System.lua
	AS = 4,
	pod = 5,
	tank = 6,
	smoke = 7,
	integrated = 8
}


weaponData = {
	["{JAS39_Meteor}"]                         = {modes = {{wTypes.AA, 1}}, name = "BVR"},
	["{JAS39_Derby}"]                          = {modes = {{wTypes.AA, 2}}, name = "BVR"},
	["{JAS39_AIM120C7}"]                       = {modes = {{wTypes.AA, 3}}, name = "M120"},
	["{JAS39_AIM120C5}"]                       = {modes = {{wTypes.AA, 4}}, name = "M120"},
	["{JAS39_AIM120B}"]                        = {modes = {{wTypes.AA, 5}}, name = "M120"},
	["{JAS39_ASRAAM}"]                         = {modes = {{wTypes.AA, 6}, {wTypes.dogfight, 2}}, name = "WVR"},
	["{JAS39_IRIS-T}"]                         = {modes = {{wTypes.AA, 7}, {wTypes.dogfight, 1}}, name = "IRIS"},
	["{JAS39_A-DARTER}"]                       = {modes = {{wTypes.AA, 8}, {wTypes.dogfight, 3}}, name = "WVR"},
	["{JAS39_PYTHON-5}"]                       = {modes = {{wTypes.AA, 9}, {wTypes.dogfight, 4}}, name = "WVR"},
	["{JAS39_AIM-9X}"]                         = {modes = {{wTypes.AA, 10}, {wTypes.dogfight, 5}}, name = "AIM9"},
	["{JAS39_AIM-9M}"]                         = {modes = {{wTypes.AA, 11}, {wTypes.dogfight, 6}}, name = "AIM9"},
	["{JAS39_AIM-9L}"]                         = {modes = {{wTypes.AA, 12}, {wTypes.dogfight, 7}}, name = "AIM9"},
	["{JAS39_RBS15}"]                          = {modes = {{wTypes.AS, 1}}, name = "AGM"},
	["{JAS39_KEPD350_ARM}"]                    = {modes = {{wTypes.AS, 2}}, name = "AGM"},
	["{JAS39_STORMSHADOW_ARM}"]                = {modes = {{wTypes.AS, 3}}, name = "AGM"},
	["{JAS39_SPEAREW}"]                        = {modes = {{wTypes.AS, 4}}, name = "AGM"},
	["{JAS39_SPEAR3}"]                         = {modes = {{wTypes.AS, 5}}, name = "AGM"},
	["{JAS39_MAR-1}"]                          = {modes = {{wTypes.AS, 6}}, name = "AGM"},
	["{JAS39_BRIMSTONE}"]                      = {modes = {{wTypes.AS, 7}}, name = "AGM"},
	["{JAS39_AGM_65K}"]                        = {modes = {{wTypes.AS, 8}}, name = "65K"},
	["{JAS39_AGM_65H}"]                        = {modes = {{wTypes.AS, 9}}, name = "65H"},
	["{JAS39_DWS39_ARM}"]                      = {modes = {{wTypes.AS, 10}}, name = "AGM"},
	["{JAS39_DWS39_TV}"]                       = {modes = {{wTypes.AS, 11}}, name = "AGM"},
	["{JAS39_SDB}"]                            = {modes = {{wTypes.AS, 12}}, name = "GB39"},
	["{JAS39_GBU31_BLU109}"]                   = {modes = {{wTypes.AS, 13}}, name = "GB31"},
	["{JAS39_GBU31}"]                          = {modes = {{wTypes.AS, 14}}, name = "GB31"},
	["{JAS39_BRU33_GBU32}"]                    = {modes = {{wTypes.AS, 15}}, name = "GB32"},
	["{JAS39_GBU32}"]                          = {modes = {{wTypes.AS, 16}}, name = "GB32"},
	["{JAS39_BRU33_GBU49}"]                    = {modes = {{wTypes.AS, 17}}, name = "GB39"},
	["{JAS39_GBU49}"]                          = {modes = {{wTypes.AS, 18}}, name = "GB39"},
	["{JAS39_BRU33_GBU38}"]                    = {modes = {{wTypes.AS, 19}}, name = "GB38"},
	["{JAS39_GBU38}"]                          = {modes = {{wTypes.AS, 20}}, name = "GB38"},
	["{JAS39_GBU10}"]                          = {modes = {{wTypes.AS, 21}}, name = "GB10"},
	["{JAS39_BRU33_GBU16}"]                    = {modes = {{wTypes.AS, 22}}, name = "GB16"},
	["{JAS39_GBU16}"]                          = {modes = {{wTypes.AS, 23}}, name = "GB16"},
	["{JAS39_BRU33_GBU12}"]                    = {modes = {{wTypes.AS, 24}}, name = "GB12"},
	["{JAS39_GBU12}"]                          = {modes = {{wTypes.AS, 25}}, name = "GB12"},
	["{JAS39_MK84}"]                           = {modes = {{wTypes.AS, 26}}, name = "84FF"},
	["{JAS39_BRU33_MK83}"]                     = {modes = {{wTypes.AS, 27}}, name = "83FF"},
	["{JAS39_MK83}"]                           = {modes = {{wTypes.AS, 28}}, name = "83FF"},
	["{JAS39_BRU33_MK82}"]                     = {modes = {{wTypes.AS, 29}}, name = "82FF"},
	["{JAS39_MK82}"]                           = {modes = {{wTypes.AS, 30}}, name = "82FF"},
	["{JAS39_M71HD}"]                          = {modes = {{wTypes.AS, 31}}, name = "M71H"},
	["{JAS39_M71LD}"]                          = {modes = {{wTypes.AS, 32}}, name = "M71L"},
	["{JAS39_M70BHE}"]                         = {modes = {{wTypes.AS, 33}}, name = "M70"},
	["{JAS39_M70BAP}"]                         = {modes = {{wTypes.AS, 34}}, name = "M70"},
	["{JAS39_Litening}"]                       = {modes = {{wTypes.pod, 1}}, name = "LDP"},
	["{AIS_ASQ_T50}"]                          = {modes = {{wTypes.pod, 2}}, name = "ASQ"},
	["{JAS39_TANK1100}"]                       = {modes = {{wTypes.tank, 1}}, name = "XF11"},
	["{A4BCC903-06C8-47bb-9937-A30FEDB4E741}"] = {modes = {{wTypes.smoke, 1}}, name = "SMK"},
	["{A4BCC903-06C8-47bb-9937-A30FEDB4E742}"] = {modes = {{wTypes.smoke, 2}}, name = "SMK"},
	["{A4BCC903-06C8-47bb-9937-A30FEDB4E743}"] = {modes = {{wTypes.smoke, 3}}, name = "SMK"},
	["{A4BCC903-06C8-47bb-9937-A30FEDB4E744}"] = {modes = {{wTypes.smoke, 4}}, name = "SMK"},
	["{A4BCC903-06C8-47bb-9937-A30FEDB4E745}"] = {modes = {{wTypes.smoke, 5}}, name = "SMK"},
	["{A4BCC903-06C8-47bb-9937-A30FEDB4E746}"] = {modes = {{wTypes.smoke, 6}}, name = "SMK"},
	["{JAS39_FLIR}"]                           = {modes = {{wTypes.integrated, 1}}, name = "FLIR"},
	["{JAS39_ELINT}"]                          = {modes = {{wTypes.integrated, 2}}, name = "ELINT"},
	["{JAS39_EWS39}"]                          = {modes = {{wTypes.integrated, 3}}, name = "EWS39"}
}





-- Prio list per mode:
-- A/A (S5 up. The whole list is cycled through, with the gun last):
-- Meteor
-- I-DERBY ER
-- 120C-7
-- 120C-5
-- 120B
-- ASRAAM
-- IRIS-T
-- A-Darter
-- Python-5
-- 9X
-- 9M
-- 9L
-- Gun
--
-- Dogfight (S5 left. Only IR-missiles, and pushing again toggles between the best IR-missile and the gun):
-- IRIS-T
-- ASRAAM
-- A-Darter
-- Python-5
-- 9X
-- 9M
-- 9L
-- Gun
--
-- AS:
-- RBS-15
-- KEPD 350
-- Storm Shadow
-- SPEAR-EW
-- SPEAR-3
-- MAR-1
-- Brimstone
-- 65K
-- 65H
-- DWS 39 ARM
-- DWS 39 TV
-- GBU 39 SDB
-- GBU-31 BLU-109
-- GBU-31
-- GBU-32
-- GBU-49
-- GBU-38
-- GBU-10
-- GBU-16
-- GBU-12
-- Mk84
-- Mk83
-- Mk82
-- M71 HD
-- M71 LD
-- M70B HE
-- M70B AP