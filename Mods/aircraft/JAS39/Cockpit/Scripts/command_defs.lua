start_custom_command   = 10000
local __count_custom = start_custom_command-1
local function __custom_counter()
	__count_custom = __count_custom + 1
	return __count_custom
end

Keys =
{
	PlaneGear								= 68,
	PlaneFonar								= 71,
	PlaneSalvoOnOff							= 81,
	PlaneChangeWeapon						= 101,
	PlaneChangeWaypoint						= 102,
	PlaneZoomIn								= 103,
	PlaneZoomOut							= 104,
	PlaneBrightnessILS						= 156,
	PlaneLightsOnOff						= 175,
	PlaneDropSnarOnce						= 176,
	PlaneHeadLightOnOff						= 328,
	PlaneModeNAV							= 105,
	PlaneModeBVR							= 106,
	PlaneModeVS								= 107,
	PlaneModeBore							= 108,
	PlaneModeHelmet							= 109,
	PlaneModeFI0							= 110,
	PlaneModeGround							= 111,
	
	SwitchMasterArm							= 283,
	PlanePickleOn							= 350,
	PlanePickleOff							= 351,

	PlaneWheelBrakeLeftOn					= 961,
	PlaneWheelBrakeLeftOff					= 962,
	PlaneWheelBrakeRightOn	 				= 963,
	PlaneWheelBrakeRightOff					= 964,
		
	--[[ WARNING SYSTEM ]]--
	PlaneMasterCautionOff					= 379,
	
	PlaneGearUp								= 430,
	PlaneGearDown							= 431,
	
	PlaneDropSnarOnceOff					= 536,
	
		--[[ WARNING SYSTEM ]]--
	PlaneMasterCaution						= 252,
	
	PlaneScalesReject						= 253,
	PlaneBettyRepeat						= 254,
	ChangeGunRateOfFire						= 280,
	ChangeRippleQuantity					= 281,
	ChangeRippleInterval					= 282,
	SwitchMasterArm							= 283,
	ChangeReleaseMode						= 284,
	ChangeRippleIntervalDown				= 308,
	PlaneLaunchPermissionOverride			= 349,
	PlanePickleOn							= 350,
	PlanePickleOff							= 351,
	
	PlaneCMDDispence						= 364,
	PlaneCMDDispenceOff						= 365,
	PlaneCMDDispenceStop					= 366,
	PlaneCMDDispenceStopOff					= 367,
	PlaneCMDChangeRippleQuantity			= 368,
	PlaneCMDChangeRippleQuantityOff 		= 369,
	PlaneCMDChangeRippleInterval			= 370,
	PlaneCMDChangeRippleIntervalOff 		= 371,
	PlaneCMDChangeBurstAmount				= 372,
	PlaneCMDChangeBurstAmountOff			= 373,
	PlaneCMDCancelCurrentProgram			= 374,
	PlaneCMDCancelCurrentProgramOff 		= 375,
	PlaneCMDChangeBoard						= 376,
	PlaneCMDShowAmountOrProgram				= 377,
	
	
	--[[ WARNING SYSTEM ]]--
	PlaneMasterCautionOff					= 379,
	
	PlaneLaserRangerOnOff					= 392,
	PlaneGearUp								= 430,
	PlaneGearDown							= 431,
	PlaneNightVisionGogglesOnOff			= 438,
	
	--[[HOTAS--]]
	HOTAS_CoolieUp	 = 539,
	HOTAS_CoolieDown = 540,
	HOTAS_CoolieLeft = 541,
	HOTAS_CoolieRight= 542,
	HOTAS_CoolieOff  = 543,
	
	HOTAS_TargetManagementSwitchUp	  = 544,
	HOTAS_TargetManagementSwitchDown  = 545,
	HOTAS_TargetManagementSwitchLeft  = 546,
	HOTAS_TargetManagementSwitchRight = 547,
	HOTAS_TargetManagementSwitchOff   = 548,

	HOTAS_DataManagementSwitchUp   = 549,
	HOTAS_DataManagementSwitchDown = 550,
	HOTAS_DataManagementSwitchLeft = 551,
	HOTAS_DataManagementSwitchRight= 552,
	HOTAS_DataManagementSwitchOff  = 553,
--from iCommand.h
	PlaneSAUAutomatic = 58,				-- Стабилизация углов
	PlaneSAUHBarometric = 59,			-- Стабилизация абсолютной высоты
	PlaneSAUHRadio = 60,			-- Полет с огибанием рельефа
	PlaneSAUHorizon = 61,				-- Приведение к горизонту
	PlaneAutopilot = 62,					-- Автопилот
	PlaneAUTOnOff = 63,					-- Переключение режима АУТ
	PlaneAUTIncrease = 64,				-- Увеличить заданную скорость
	PlaneAUTDecrease = 65,				-- Уменьшить заданную скорость
	PlaneGear = 68,						-- Шасси
	PlaneHook = 69,						-- Гак
	PlanePackWing = 70,				-- Складывание крыльев
	PlaneFonar = 71,						-- Фонарь
	PlaneFlaps = 72,						-- Закрылки
	PlaneAirBrake = 73,					-- Воздушный тормоз
	PlaneWheelBrakeOn = 74,				-- Включение тормоза колес
	PlaneWheelBrakeOff = 75,				-- Выключение тормоза колес
	PlaneParachute = 76,					-- Парашют
	PlaneDropSnar = 77,					-- Сброс ловушек
	PlaneWingtipSmokeOnOff = 78,			-- Вкл/выкл дымовых шашек на концах крыльев
	PlaneFuelOn = 79,					-- Включение слива топлива или заправки
	PlaneFuelOff = 80,				-- Выключение слива топлива или заправки
	PlaneSalvoOnOff = 81,				-- Залповый режим вкл/выкл
	PiCommandSelecterUplaneJettisonWeapons = 82,			-- Сброс оружия парами
	PlaneEject = 83,						-- Катапультирование
	PlaneFire = 84,						-- Гашетка
	PlaneFireOff = 85,					-- Гашетку отпустили
	PlaneRadarOnOff = 86,				-- Включение / выключение радара
	PlaneEOSOnOff = 87,					-- Включение / выключение ОЛС
	PlaneRadarLeft = 88,					-- Поворот антенны РЛС влево
	PlaneRadarRight = 89,				-- Поворот антенны РЛС вправо
	PlaneRadarUp = 90,				-- Поворот антенны РЛС вверх
	PlaneRadarDown = 91,					-- Поворот антенны РЛС вниз
	PlaneRadarCenter = 92,				-- Возврат антенны РЛС в центр
	PlaneTrimLeft = 93,					-- Триммер влево
	PlaneTrimRight = 94,					-- Триммер вправо
	PlaneTrimUp = 95,					-- Триммер вверх
	PlaneTrimDown = 96,					-- Триммер вниз
	PlaneTrimCancel = 97,				-- Сброс триммера
	PlaneTrimLeftRudder = 98,			-- Триммер левой педали
	PlaneTrimRightRudder = 99,			-- Триммер правой педали
	PlaneChangeLock = 100,			-- Переключение подрежимов / захват
	PlaneChangeWeapon = 101,				-- Переключение подрежимов / перебор оружия
	PlaneChangeTarget = 102,				-- Перебор целей
	PlaneZoomIn = 103,					-- Изменение масштаба МФД +
	PlaneZoomOut = 104,					-- Изменение масштаба МФД -
	PlaneModeNAV = 105,					-- Переход в режим навигации
	PlaneModeBVR = 106,					-- Переход в режим дальнего воздушного боя
	PlaneModeVS = 107,					-- Переход в режим ближнего воздушного боя (полоса)
	PlaneModeBore = 108,					-- Переход в режим ближнего воздушного боя (кольцо)
	PlaneModeHelmet = 109,				-- Переход в режим ближнего воздушного боя (шлем)
	PlaneModeFI0 = 110,				-- Переход в режим FI0
	PlaneModeGround = 111,				-- Переход в режим атаки наземных целей
	PlaneModeGrid = 112,					-- Переход в режим "сетка"
	PlaneModeCannon = 113,				-- Включение/выключение пушки
	PlaneDoAndHome = 114,					-- Выполни задание и вернись на базу
	PlaneDoAndBack = 115,					-- Выполни задание и вернись ко мне
	PlaneFormation = 116,					-- Идти рассеянным/плотным строем
	PlaneJoinUp    = 117,					-- Собраться
	PlaneAttackMyTarget = 118,			-- Атакуй мою цель
	PlaneCoverMySix = 119,				-- Прикрой меня сзади
	PlaneShipTakeOff = 120,			-- Хочу взлететь с авианосца

	ActiveJamming = 136,
	LandDetailsIncrease = 137,			-- Отладочное увеличение детализации (Non-simulation Action)
	LandDetailsDecrease = 138,			-- Отладочное уменьшение детализации (Non-simulation Action)
	SelecterLeft = 139,				    -- движение маркера захвата целей на HUD влево
	SelecterRight = 140,			-- вправо
	SelecterUp  =141,					    -- вверх
	SelecterDown = 142,					-- вниз
	RefusalTWS = 143,						-- отказ от СНП
	PlaneResetMasterWarning = 144,
	PlaneFlapsOn = 145,
	PlaneFlapsOff = 146,
	PlaneAirBrakeOn = 147,
	PlaneAirBrakeOff = 148,
	PlaneAirRefuel = 155,				-- Переключатель положения штанги заправки
	BrightnessILS = 156,				-- Яркость ILS
	PlaneAUTIncreaseLeft = 161,
	PlaneAUTDecreaseLeft = 162,
	PlaneAUTIncreaseRight = 163,
	PlaneAUTDecreaseRight = 164,
	PlaneLightsOnOff = 175,			-- Вкл/выкл огни на своем самолете
	PlaneDropSnarOnce = 176,			-- Однократный сброс ловушек
	PlaneJettisonFuelTanks = 178,		-- Сброс топливных баков
	PlaneWingmenCommand = 179,		-- Вызов панели команд ведомым
	PlaneDown = 186,					-- Тонкое управление автопилотом по высоте
	PlaneUp = 187,
	PlaneLeft = 188,
	PlaneRight = 189,
    PlaneUpStart = 193,
    PlaneUpStop = 194,
    PlaneDownStart = 195,
    PlaneDownStop = 196,
    PlaneLeftStart = 197,
    PlaneLeftStop = 198,
    PlaneRightStart = 199,
    PlaneRightStop = 200,
    PlaneLeftRudderStart = 201,
    PlaneLeftRudderStop = 202,
    PlaneRightRudderStart = 203,
    PlaneRightRudderStop = 204,
    PlaneTrimStop = 215,
    SelecterUpRight = 226,
    SelecterDownRight = 227,
    SelecterDownLeft = 228,
    SelecterUpLeft = 229,
    SelecterStop = 230,
    PlaneRadarUpRight = 231,
    PlaneRadarDownRight = 232,
    PlaneRadarDownLeft = 233,
    PlaneRadarUpLeft = 234,
    PlaneRadarStop = 235,
	PlaneHUDFilterOnOff = 247,			-- Поднять/опустить светофильтр ИЛС (Ka-50)
	PlaneMasterCaution = 252,				-- Аналог "Экран вызов" (МиГ-29), кнопка-лампа ЦСО (Ка-50)
	PlaneScalesReject	= 253,				-- Scales reject / огранич. индикац. на ИЛС (Ка-50)
	PlaneBettyRepeat = 254,				-- Repeat Betty messages (Rf-50)
	ThreatMissilePadlock = 258,
	AllMissilePadlock = 259,
	DecreaseRadarScanArea = 262,
    IncreaseRadarScanArea = 263,
	AWACSHomeBearing = 267,
	AWACSTankerBearing = 268,
	AWACSBanditBearing = 269,
    AWACSDeclare = 270,
    EasyRadarOnOff = 271,
    AutoLockOnNearestAircraft = 272,
    AutoLockOnCenterAircraft = 273,
    AutoLockOnNextAircraft = 274,
    AutoLockOnPreviousAircraft = 275,
    AutoLockOnNearestSurfaceTarget = 276,
    AutoLockOnCenterSurfaceTarget = 277,
    AutoLockOnNextSurfaceTarget = 278,
    AutoLockOnPreviousSurfaceTarget = 279,
	ChangeGunRateOfFire = 280,
	ChangeRippleQuantity = 281,
	ChangeRippleInterval = 282,
	SwitchMasterArm = 283,
	ChangeReleaseMode = 284,
    PlaneRadarChangeMode = 285,
	ChangeRWRMode = 286,
	FlightClockReset = 288,
	PlaneCockpitIllumination = 300,
	ChangeRippleIntervalDown = 308,		-- Изменение интервала сброса бомб в залпе для А10 в обратном направлении
	EnginesStart = 309,				-- Запуск двигателей
	EnginesStop = 310,			-- Выключение двигателей

	LeftEngineStart = 311,			-- Запуск левого двигателя
	RightEngineStart = 312,			-- Запуск правого двигателя

	LeftEngineStop = 313,				-- Выключение левого двигателя
	RightEngineStop = 314,			-- Выключение правого двигателя

	PowerOnOff = 315,					-- Включение/выключение электропитания

	PowerGeneratorLeft = 711,
    PowerGeneratorRight = 712,

    BatteryPower = 1073,        -- iCommandBatteryPower

	AltimeterPressureIncrease = 316,	-- Увеличение давления на ВД
	AltimeterPressureDecrease = 317,	-- Уменьшение давления на ВД
	AltimeterPressureStop = 318,

	PlaneHeadLightOnOff = 328,		-- Вкл/выкл фары на передней стойке шасси
	
	PlaneLockPadlock = 329,				-- Следить за ближайшим объектом
	PlaneUnlockPadlock = 330,		-- Бросить следить за объектом

	PlaneLaunchPermissionOverride = 349,	-- Снятие блокировки с оружия
	PlanePickleOn = 350,		-- Пуск ракет/сброс бомб для западных самолетов
	PlanePickleOff = 351,
	PlaneDropFlareOnce = 357,			-- Однократный сброс ИК-ловушек
	PlaneDropChaffOnce = 358,			-- Однократный сброс дипольных отражателей

	-- CMD
	PlaneCMDDispence = 364,				-- Пассивные средства РЭБ выброс ловушек
	PlaneCMDDispenceOff = 365,
	PlaneCMDDispenceStop = 366,			-- Пассивные средства РЭБ остановка выброса ловушек
	PlaneCMDDispenceStopOff = 367,
	PlaneCMDChangeRippleQuantity = 368,	-- Пассивные средства РЭБ изменить количество в серии
	PlaneCMDChangeRippleQuantityOff = 369,
	PlaneCMDChangeRippleInterval = 370,	-- Пассивные средства РЭБ изменить интервал в серии
	PlaneCMDChangeRippleIntervalOff = 371,
	PlaneCMDChangeBurstAmount = 372,		-- Пассивные средства РЭБ изменить количество серий
	PlaneCMDChangeBurstAmountOff = 373,
	PlaneCMDCancelCurrentProgram = 374,	-- Пассивные средства РЭБ сброс программы
	PlaneCMDCancelCurrentProgramOff = 375,
	PlaneCMDChangeBoard = 376,			-- Пассивные средства РЭБ выбор борта
	PlaneCMDShowAmountOrProgram = 377,	-- Пассивные средства РЭБ смена индикации - наличие ловушек или текущая программа
	
	PlaneCancelWeaponsDelivery = 378,		-- сброс режима работы авионики (Ка - 50)
	PlaneMasterCautionOff = 379,
	PlaneStabTangBank = 386,			-- Стабилизация тангажа и крена
	PlaneStabHbarBank = 387,			-- Стабилизация Hbar и крена
	PlaneStabHorizon = 388,			-- Стабилизация тангажа и крена
	PlaneStabHbar = 389,				-- Стабилизация Hbar
	PlaneStabHrad = 390,				-- Стабилизация Hrad
	ActiveIRJamming = 391,			-- IR OnOff
	PlaneLaserRangerOnOff = 392, 		-- Вкл/Выкл лазерный дальномер
	PlaneNightTVOnOff = 393,         -- Вкл/Выкл ночной канал телевизионной системы (IR or LLTV) 
	PlaneChangeRadarPRF = 394,       -- Изменить частоту повторения импульсов радара
	PlaneStabCancel = 408,			-- Сброс всех режимов стабилизации и автопилота
	PlaneThreatWarnSoundVolumeDown = 409,	-- Уменьшение громкости звуковых сигналов СПО
	PlaneThreatWarnSoundVolumeUp = 410,	-- Увеличение громкости звуковых сигналов СПО
	ViewLaserOnOff = 411,
	PlaneIncreaseBase_Distance = 412,     -- Увеличение базы цели
	PlaneDecreaseBase_Distance = 413,     -- Уменьшение базы цели
	PlaneStopBase_Distance = 414,
	PlaneAutopilotOverrideOn =427,
	PlaneAutopilotOverrideOff = 428,
	PlaneRouteAutopilot = 429,
	PlaneGearUp = 430,
	PlaneGearDown = 431,
	ViewNightVisionGogglesOn = 438,
	PlaneDesignate_CageOn = 439,
	PlaneDesignate_CageOff = 440,
	PlaneDesignate_CageOn_vertical = 441,
	PlaneDesignate_CageOn_horizontal = 442,

	--Data Link Panel PRTs (Пульт Режимов Целеуказания ПРЦ)
	PlaneDLK_Target1 = 443,
	PlaneDLK_Target2 = 444,
	PlaneDLK_Target3 = 445,
	PlaneDLK_RefPoint = 446,
	PlaneDLK_Wingman1 = 447,
	PlaneDLK_Wingman2 = 448,
	PlaneDLK_Wingman3 = 449,
	PlaneDLK_Wingman4 = 450,
	PlaneDLK_All = 451,
	PlaneDLK_Erase = 452,
	PlaneDLK_Ingress = 453,
	PlaneDLK_SendMemory = 454,

	-- NAV panel controls (Ка-50 - щиток ПВИ)
	PlaneNavChangePanelModeRight = 455,
	PlaneNavChangePanelModeLeft = 456,
	PlaneNavSetFixtakingMode = 457,
	PlaneNav_DLK_OnOff = 458,
	PlaneNav_PB1 = 459,
	PlaneNav_PB2 = 460,
	PlaneNav_PB3 = 461,
	PlaneNav_PB4 = 462,
	PlaneNav_PB5 = 463,
	PlaneNav_PB6 = 464,
	PlaneNav_PB7 = 465,
	PlaneNav_PB8 = 466,
	PlaneNav_PB9 = 467,
	PlaneNav_PB0 = 468,
	PlaneNav_Steerpoints = 469,
	PlaneNav_INU_realign = 470,
	PlaneNav_POS_corrMode = 471,
	PlaneNav_INU_precise_align = 472,
	PlaneNav_Airfields =473,
	PlaneNav_INU_normal_align  = 474,
	PlaneNav_Targets = 475,
	PlaneNav_Enter = 476,
	PlaneNav_Cancel = 477,
	PlaneNav_POS_init = 478,
	PlaneNav_SelfCoord = 479,
	PlaneNav_CourseTimeRange = 480,
	PlaneNav_Wind = 481,
	PlaneNav_THeadingTimeRangeF = 482,
	PlaneNav_BearingRangeT = 483,


	PlaneCockpitIlluminationPanels = 493,
	PlaneCockpitIlluminationGauges = 494,

	Plane_RouteMode = 506,
	Plane_DescentMode = 507,
	Plane_DescentModeOff = 508,

	Plane_SpotLight_left  = 511,
	Plane_SpotLight_right = 512,
	Plane_SpotLight_up	= 513,
	Plane_SpotLight_down = 514,
	Plane_SpotLight_stop = 515,

	PlaneRotorTipLights = 516,
	Plane_SpotSelect_switch = 517,
	PlaneAntiCollisionLights = 518,
	PlaneNavLights_CodeModeOn = 519,
	PlaneNavLights_CodeModeOff = 520,
	PlaneFormationLights = 521,

	Plane_EngageAirDefenses = 522,
	Plane_EngageGroundTargets = 523,

	Plane_AutomaticTracking_Gunsight_switch  = 524,
	Plane_AutomaticTurn = 526,
	Plane_GroundMovingTarget = 527,
	Plane_AirborneTarget = 528,
	Plane_HeadOnAspect = 529,
	Plane_ChangeDeliveryMode_right = 530,
	Plane_ChangeDeliveryMode_left = 531,

	Plane_WeaponMode_Manual_Auto = 532,
	Plane_WeaponMode_switch = 533,
	Plane_AmmoTypeSelect = 534,
	Plane_FireRate = 535,

	PlaneDropSnarOnceOff = 536,

	HelicopterHover = 537,
	AutopilotEmergOFF = 538,
	
	Plane_HOTAS_CoolieUp = 539,
	Plane_HOTAS_CoolieDown = 540,
	Plane_HOTAS_CoolieLeft = 541,
	Plane_HOTAS_CoolieRight = 542,
	Plane_HOTAS_CoolieOff = 543,

	Plane_HOTAS_TargetManagementSwitchUp = 544,
	Plane_HOTAS_TargetManagementSwitchDown = 545,
	Plane_HOTAS_TargetManagementSwitchLeft = 546,
	Plane_HOTAS_TargetManagementSwitchRight = 547,
	Plane_HOTAS_TargetManagementSwitchOff = 548,

	Plane_HOTAS_DataManagementSwitchUp = 549,
	Plane_HOTAS_DataManagementSwitchDown = 550,
	Plane_HOTAS_DataManagementSwitchLeft = 551,
	Plane_HOTAS_DataManagementSwitchRight = 552,
	Plane_HOTAS_DataManagementSwitchOff = 553,
	
	Plane_HOTAS_TriggerSecondStage = 554,
	Plane_HOTAS_TriggerFirstStage = 555,
	
	Plane_HOTAS_CMS_Up = 556,
	Plane_HOTAS_CMS_Down = 557,
	Plane_HOTAS_CMS_Left = 558,
	Plane_HOTAS_CMS_Right = 559,
	Plane_HOTAS_CMS_Off = 560,

	Plane_HOTAS_MasterModeControlButton = 561,
	Plane_HOTAS_NoseWheelSteeringButton = 562,
	Plane_HOTAS_NoseWheelSteeringButtonOff = 606,
	
	Plane_HOTAS_BoatSwitchForward = 563,
	Plane_HOTAS_BoatSwitchAft = 564,
	Plane_HOTAS_BoatSwitchCenter = 565,
	
	Plane_HOTAS_ChinaHatForward = 566,
	Plane_HOTAS_ChinaHatAft = 567,
	Plane_HOTAS_ChinaHatOff = 589,

	Plane_HOTAS_PinkySwitchForward = 568,
	Plane_HOTAS_PinkySwitchAft = 569,
	Plane_HOTAS_PinkySwitchCenter = 570,

	Plane_HOTAS_LeftThrottleButton = 571,

	Plane_HOTAS_MIC_SwitchUp = 572,
	Plane_HOTAS_MIC_SwitchDown = 573,
	Plane_HOTAS_MIC_SwitchLeft = 574,
	Plane_HOTAS_MIC_SwitchRight = 575,
	Plane_HOTAS_MIC_SwitchOff = 576,

	Plane_HOTAS_SpeedBrakeSwitchForward = 577,
	Plane_HOTAS_SpeedBrakeSwitchAft = 578,
	Plane_HOTAS_SpeedBrakeSwitchCenter = 579,
	
	Plane_HOTAS_MasterModeControlButtonUP = 633,
	
	Plane_HOTAS_TDC_depress_on  = 634,
	Plane_HOTAS_TDC_depress_off = 635,

	Plane_HOTAS_TriggerSecondStage_Off = 638,
	Plane_HOTAS_TriggerFirstStage_Off  = 639,
	
	Plane_HOTAS_CMS_Zaxis 		= 1041,
	Plane_HOTAS_CMS_Zaxis_Off 	= 1042,

	Plane_HOTAS_BoatSwitchOff	= 822,
	Plane_HOTAS_BoatSwitchForwardMomentary = 823,
	Plane_HOTAS_BoatSwitchAftMomentary = 824,

	Plane_HOTAS_LeftThrottleButton_Off = 1557,

	
--end
-- analog commands
	PlaneRadarHorizontal 	   = 2025,
	PlaneRadarVertical 		   = 2026,
	PlaneRadarHorizontalAbs    = 2027,
	PlaneRadarVerticalAbs 	   = 2028,
	PlaneMFDZoom 		       = 2029,
	PlaneMFDZoomAbs			   = 2030,
	PlaneSelecterHorizontal    = 2031,
	PlaneSelecterVertical 	   = 2032,
	PlaneSelecterHorizontalAbs = 2033,
	PlaneSelecterVerticalAbs   = 2034,
	PlaneBase_Distance 		   = 2040,
	PlaneBase_DistanceAbs 	   = 2041,
	
		
	
	LampsControl							= 762,
	LampsControl_up							= 800,

}



-- add custom commands here --
device_commands =
{
	
	 BrakesON      = 10038,
	 BrakesOFF     = 10039,
	 L_BRAKE       = 10056,
	 R_BRAKE       = 10057,
	 B_BRAKE       = 10058,
	 Brakes        = 10023,
	 P_BRAKE	   = 10059,

}