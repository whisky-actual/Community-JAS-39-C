


local pl5eii_name = 'Rb98 IRIS-T'
local pl5eii_mass = 87.4
local pylon_mass = 1.0

PL_5EII_AA = {
    category        = CAT_AIR_TO_AIR,
    name            = pl5eii_name,
    user_name       = _(pl5eii_name),
    wsTypeOfWeapon  = {4,4,7,WSTYPE_PLACEHOLDER},
    Escort          = 0,
    Head_Type       = 1,
    sigma           = {2, 2, 2},
    M               = pl5eii_mass,
        H_max = 20000.0,
        H_min = -1,
        Diam = 127.0,
        Cx_pil = 1.88,
        D_max = 20000.0,
        D_min = 200.0,
        Head_Form = 0,
        Life_Time = 60.0,
        Nr_max = 60,
        v_min = 140.0,
        v_mid = 400.0,
        Mach_max = 3.0,
        t_b = 0.0,
        t_acc = 8.0,
        t_marsh = 0.0,
        Range_max = 25000.0,
        H_min_t = 1.0,
        Fi_start = 1.57,
        Fi_rak = 3.14152,
        Fi_excort = 1.57,
        Fi_search = 0.09,
        OmViz_max = 1.10,
		warhead = enhanced_a2a_warhead(11.4),       
        exhaust = { 0.84, 0.66, 0.43, 0.08 };				
		X_back = -1.48,
        Y_back = 0.0,
        Z_back = 0.0,
        Reflection = 0.035,
        KillDistance = 10.0,

    --seeker sensivity params
    SeekerSensivityDistance = 25000, -- The range of target with IR value = 1. In meters.
    ccm_k0        = 0.05,  -- Counter Countermeasures Probability Factor. Value = 0 - missile has absolutely resistance to countermeasures. Default = 1 (medium probability)
    SeekerCooled  = true, -- True is cooled seeker and false is not cooled seeker.

    shape_table_data = {
        {
            name     = pl5eii_name,
            file     = 'pl5eii',
            life     = 1,
            fire     = {0, 1},
            username = pl5eii_name,
            index    = WSTYPE_PLACEHOLDER,
        },
    },

    ModelData = {
        58 ,  -- model params count
        0.4 ,   -- characteristic square (характеристическая площадь)
        
        -- параметры зависимости Сx
        0.040 , -- Cx_k0 планка Сx0 на дозвуке ( M << 1)
        0.080 , -- Cx_k1 высота пика волнового кризиса
        0.020 , -- Cx_k2 крутизна фронта на подходе к волновому кризису
        0.050, -- Cx_k3 планка Cx0 на сверхзвуке ( M >> 1)
        1.0 , -- Cx_k4 крутизна спада за волновым кризисом 
        0.8 , -- коэффициент отвала поляры (пропорционально sqrt (M^2-1))
        
        -- параметры зависимости Cy
        0.9 , -- Cy_k0 планка Сy0 на дозвуке ( M << 1)
        0.8     , -- Cy_k1 планка Cy0 на сверхзвуке ( M >> 1)
        1.2  , -- Cy_k2 крутизна спада(фронта) за волновым кризисом  
        
        0.7 , -- 7 Alfa_max  максимальный балансировачный угол, радианы
        10.0, --угловая скорость создаваймая моментом газовых рулей
        
        -- Engine data. Time, fuel flow, thrust.    
        --    t_statr        t_b        t_accel        t_march        t_inertial        t_break        t_end            -- Stage
        -1.0,        -1.0,    6,          0.0,        0.0,            0.0,        1.0e9,         -- time of stage, sec
         0.0,        0.0,    5.0,        0.0,        0.0,            0.0,        0.0,           -- fuel flow rate in second, kg/sec(секундный расход массы топлива кг/сек)
         0.0,        0.0,    12500.0,    0.0,    0.0,            0.0,        0.0,           -- thrust, newtons
    
         1.0e9, -- таймер самоликвидации, сек
         60.0, -- время работы энергосистемы, сек
         0, -- абсолютная высота самоликвидации, м
         0.3, -- время задержки включения управления (маневр отлета, безопасности), сек
         1.0e9, -- дальность до цели в момент пуска, при превышении которой ракета выполняется маневр "горка", м
         1.0e9, -- дальность до цели, при которой маневр "горка" завершается и ракета переходит на чистую пропорциональную навигацию (должен быть больше или равен предыдущему параметру), м 
         0.0,  -- синус угла возвышения траектории набора горки
         30.0, -- продольное ускорения взведения взрывателя
         0.0, -- модуль скорости сообщаймый катапультным устройством, вышибным зарядом и тд
         1.19, -- характристика системы САУ-РАКЕТА,  коэф фильтра второго порядка K0
         1.0, -- характристика системы САУ-РАКЕТА,  коэф фильтра второго порядка K1
         2.0, -- характристика системы САУ-РАКЕТА,  полоса пропускания контура управления
         0.0, -- дальность полета в горизонт с располагаемой перегрузкой Navail >= 1.0 на высоте H=2000
         0.0, -- крутизна зависимости  дальность полета в горизонт с располагаемой перегрузкой Navail >= 1.0 от высоты H
         0.0,
         0.0, -- безразмерный коэф. эффективности САУ ракеты
         0.0, -- расчет времени полета
          -- DLZ. Данные для рассчета дальностей пуска (индикация на прицеле)
         20000.0, -- дальность ракурс   180(навстречу) град,  Н=10000м, V=900км/ч, м
         8000.0, -- дальность ракурс 0(в догон) град,  Н=10000м, V=900км/ч, м
         10000.0, -- дальность ракурс     180(навстречу) град, Н=1000м, V=900км/ч, м
         0.2, -- Уменьшение разрешенной дальности пуска при отклонении вектора скорости носителя от линии визирования цели.
         1.0, -- Вертикальная плоскость. Наклон кривой разрешенной дальности пуска в нижнюю полусферу. Уменьшение дальности при стрельбе вниз.
         1.4, -- Вертикальная плоскость. Наклон кривой разрешенной дальности пуска в верхнюю полусферу. Увеличение дальности при стрельбе вверх.
        -3.0, -- Вертикальная плоскость. Угол перегиба кривой разрешенной дальности, верхняя - нижняя полусфера.
        0.5, -- Изменение коэффициентов наклона кривой в верхнюю и нижнюю полусферы от высоты носителя.
    },
}

declare_weapon(PL_5EII_AA)
PL_5EII_AA.shape_table_data.index = PL_5EII_AA.wsTypeOfWeapon[4]

declare_loadout({
    category     = CAT_AIR_TO_AIR,
    CLSID        = 'IRIS-T',
    Picture      = 'irist.png',
    attribute    = PL_5EII_AA.wsTypeOfWeapon,
    displayName  = _(pl5eii_name),
    Cx_pil       = 0.00057,
    Count        = 1,
    Weight       = pl5eii_mass + pylon_mass,
    Elements     = {
        [1] =
        {
            DrawArgs =
            {
                [1] = {1, 1},
                [2] = {2, 1},
            }, -- end of DrawArgs
            Position  = {0, 0, 0},
            ShapeName = 'pl5eii',
        },
    }, -- end of Elements
})

declare_loadout({
    category     = CAT_AIR_TO_AIR,
    CLSID        = 'DIS_PL-5EII_TIP',
    Picture      = 'irist.png',
    attribute    = PL_5EII_AA.wsTypeOfWeapon,
    displayName  = _(pl5eii_name),
    Cx_pil       = 0.0,
    Count        = 1,
    Weight       = pl5eii_mass,
    Elements     = {
        [1] =
        {
            DrawArgs =
            {
                [1] = {1, 1},
                [2] = {2, 1},
            }, -- end of DrawArgs
            Position  = {0, 0, 0},
            ShapeName = 'pl5eii',
        },
    }, -- end of Elements
})

-- Rb74
local wsType_Rb74 = 11039

warhead = {}
--AA MISSILES
warhead["Rb74"] =  enhanced_a2a_warhead(9.4, 127); -- 2.9kg according to Arboga Robot Museum webpage,  ARBOGA IS USUALLY QUITE WRONG.

local Rb74 = { 

	category		= CAT_AIR_TO_AIR,
	name			= "Rb 74",
	user_name		= _("Rb 74"),
	--/N/ wrong -> wsTypeOfWeapon = {4, 4, 11, WSTYPE_PLACEHOLDER},
	wsTypeOfWeapon = {wsType_Weapon,wsType_Missile,wsType_AA_Missile, wsType_Rb74},
	NatoName		=	"(Rb74)",
	

	shape_table_data =
	{
		{
			name	 = "Robot74";
			file  = "AIM-9L"; -- <--/N/ replace this file name with proper one
			life  = 1;
			fire  = { 0, 1};
			username = "Robot 74";
			index = wsType_Rb74,
		},
	},

        Escort = 0,
        Head_Type = 1,
		sigma = {3, 3, 3},
        M = 85.0,
        H_max = 18000.0,
        H_min = -1,
        Diam = 127.0,
        Cx_pil = 2.58,
        D_max = 7000.0,
        D_min = 300.0,
        Head_Form = 0,
        Life_Time = 60.0,
        Nr_max = 40,
        v_min = 140.0,
        v_mid = 350.0,
        Mach_max = 2.7,
        t_b = 0.0,
        t_acc = 5.0,
        t_marsh = 0.0,
        Range_max = 14000.0,
        H_min_t = 1.0,
        Fi_start = 0.3,
        Fi_rak = 3.14152,
        Fi_excort = 0.79,
        Fi_search = 0.09,
        OmViz_max = 0.61,
        warhead = warhead["Rb74"],
		exhaust = { 0.7, 0.7, 0.7, 1.0 },
		X_back = -1.66,
		Y_back = 0.0,
		Z_back = 0.0,
        Reflection = 0.0182,
        KillDistance = 5.0,
		--seeker sensivity params
		SeekerSensivityDistance = 20000, -- The range of target with IR value = 1. In meters. In forward hemisphere.
		ccm_k0 = 0.75,  -- Counter Countermeasures Probability Factor. Value = 0 - missile has absolutely resistance to countermeasures. Default = 1 (medium probability)
		SeekerCooled			= true, -- True is cooled seeker and false is not cooled seeker.	

		supersonic_A_coef_skew = 0.25, -- наклон прямой коэффициента отвала поляры на сверхзвуке
		nozzle_exit_area =	0.0068, -- площадь выходного сечения сопла

		
		ModelData = {   58,  -- model params count
						0.35,   -- characteristic square (характеристическая площадь)
		
						-- параметры зависимости Сx
						0.049, -- Cx_k0 планка Сx0 на дозвуке ( M << 1)
						0.082, -- Cx_k1 высота пика волнового кризиса
						0.010, -- Cx_k2 крутизна фронта на подходе к волновому кризису
						0.001, -- Cx_k3 планка Cx0 на сверхзвуке ( M >> 1)
						0.550, -- Cx_k4 крутизна спада за волновым кризисом 
						0.8, -- коэффициент отвала поляры (пропорционально sqrt (M^2-1))
							
						-- параметры зависимости Cy
						2.5, -- Cy_k0 планка Сy0 на дозвуке ( M << 1)
						0.8, -- Cy_k1 планка Cy0 на сверхзвуке ( M >> 1)
						1.2, -- Cy_k2 крутизна спада(фронта) за волновым кризисом  
							
						0.13, -- 7 Alfa_max  максимальный балансировачный угол, радианы
						0.00, --угловая скорость создаваймая моментом газовых рулей
							
					-- Engine data. Time, fuel flow, thrust.	
					--	t_statr		t_b		t_accel		t_march		t_inertial		t_break		t_end			-- Stage
						-1.0,	   -1.0,	5.20,  		0.0,		0.0,			0.0,		1.0e9,         -- time of stage, sec
						 0.0,		0.0,	5.27,		0.0,		0.0,			0.0,		0.0,           -- fuel flow rate in second, kg/sec(секундный расход массы топлива кг/сек)
						 0.0,		0.0,	11890.0,	0.0,		0.0,			0.0,		0.0,           -- thrust, newtons
						
						1.0e9, -- таймер самоликвидации, сек
						60.0, -- время работы энергосистемы, сек
						0, -- абсолютная высота самоликвидации, м
						0.3, -- время задержки включения управления (маневр отлета, безопасности), сек
						1.0e9, -- дальность до цели в момент пуска, при превышении которой ракета выполняется маневр "горка", м
						1.0e9, -- дальность до цели, при которой маневр "горка" завершается и ракета переходит на чистую пропорциональную навигацию (должен быть больше или равен предыдущему параметру), м 
						0.0,  -- синус угла возвышения траектории набора горки
						30.0, -- продольное ускорения взведения взрывателя
						0.0, -- модуль скорости сообщаймый катапультным устройством, вышибным зарядом и тд
						1.19, -- характристика системы САУ-РАКЕТА,  коэф фильтра второго порядка K0
						1.0, -- характристика системы САУ-РАКЕТА,  коэф фильтра второго порядка K1
						2.0, -- характристика системы САУ-РАКЕТА,  полоса пропускания контура управления
						0.0,
						0.0,
						0.0,
						0.0,
						0.0,
						-- DLZ. Данные для рассчета дальностей пуска (индикация на прицеле)
						26800.0, -- дальность ракурс   180(навстречу) град,  Н=10000м, V=900км/ч, м
						11400.0, -- дальность ракурс 0(в догон) град,  Н=10000м, V=900км/ч, м
						13300.0, -- дальность ракурс 	180(навстречу) град, Н=1000м, V=900км/ч, м
						0.2, -- Уменьшение разрешенной дальности пуска при отклонении вектора скорости носителя от линии визирования цели.
						1.0, -- Вертикальная плоскость. Наклон кривой разрешенной дальности пуска в нижнюю полусферу. Уменьшение дальности при стрельбе вниз.
						1.4, -- Вертикальная плоскость. Наклон кривой разрешенной дальности пуска в верхнюю полусферу. Увеличение дальности при стрельбе вверх.
						-3.0, -- Вертикальная плоскость. Угол перегиба кривой разрешенной дальности, верхняя - нижняя полусфера.
						0.5, -- Изменение коэффициентов наклона кривой в верхнюю и нижнюю полусферы от высоты носителя.
					},
		
		
	
}

declare_weapon(Rb74)

declare_loadout(
	{		
		category			= CAT_AIR_TO_AIR,
		CLSID				= "{Robot74}",
		attribute			= {wsType_Weapon, wsType_Missile, wsType_Container, wsType_Rb74},
		wsTypeOfWeapon		= Rb74.wsTypeOfWeapon,
		Count				= 1,
		Picture				= "aim9m.png",
		displayName			= _("Rb74 AIM-9L"), -- Rb74.user_name.._(" with launcher"), --<-- /N/  put the launcher name here if any
		Weight				= 90, --<--/N/ missile + launcher weight (if any), this is important since the launcher stays on  aircraft! So this weight should be higher than a missile itself!
		Cx_pil				= 0.0001, --<--/N/ this is too low, you might have difficulties later to set up the human and AI FM (ignore the 21 code when it comes to weapons Cx, it is a special case) -- edited Jedi
		Elements			={
			[1]	=
			{
				Position	=	{0, 0, 0},
				ShapeName	=	"aero-3b", --<-- /N/  put the launcher shape name here if any
				IsAdapter 	= true,
			},
			[2]	=
			{
				Position	=	{0.0,	-0.10,	0}, 
				ShapeName	=	"AIM-9L", --<-- /N/  put the missile shape name here
			},
		},
	}
)



local sd10_warhead = enhanced_a2a_warhead(24, 203)


local sd10_name = 'Rb101 Meteor'
local sd10_mass = 190.0
local pylon_mass = 1.0
local pylon_dual_mass = 1.0
SD_10_AA = {

    category        = CAT_AIR_TO_AIR,
    name            = sd10_name,
    model           = 'pl12',
    user_name       = _(sd10_name),
    wsTypeOfWeapon  = {4,4,7,WSTYPE_PLACEHOLDER},
    mass            = sd10_mass,

    Escort          = 0,
    Head_Type       = 2,
    sigma           = {4, 4, 4},
    M               = sd10_mass,
    H_max           = 25000.0,
    H_min           = -1.0,
    Diam            = 178.0,
    Cx_pil          = 2.5,
    D_max           = 80000.0,
    D_min           = 1000.0,
    Head_Form       = 1,
    Life_Time       = 180.0,
    Nr_max          = 35,
    v_min           = 140.0,
    v_mid           = 2575.0,
    Mach_max        = 4.5,
    t_b             = 0.0,
    t_acc           = 6.0,
    t_marsh         = 50.0,
    Range_max       = 160000.0,
    H_min_t         = 1.0,
    Fi_start        = 0.780,
    Fi_rak          = 3.14152,
    Fi_excort       = 1.0472,
    Fi_search       = 1.05,
    OmViz_max       = 0.6981,
    exhaust         = { 1, 1, 1, 0.3 };
	X_back          = -1.74,
    Y_back          = -0.11,
    Z_back          = 0.0,
    Reflection      = 0.03,
    KillDistance    = 15.0,

    warhead         = sd10_warhead,
    warhead_air     = sd10_warhead,

    shape_table_data = {
        {
            name     = sd10_name,
            file     = 'pl12',
            life     = 1,
            fire     = {0, 1},
            username = sd10_name,
            index    = WSTYPE_PLACEHOLDER,
        },
    },

    --PN_coeffs = { 4,                 -- Number of Entries
    --              12000.0, 1.00,
    --              18000.0, 0.75,
    --              30000.0, 0.50,     -- Less 5 km to target Pn = 1
    --              48000.0, 0.20,     -- Between 15 and 5 km  to target, Pn smoothly changes from 0.4 to 1.0. Longer then 15 km Pn = 0.4.
    --           },
	PN_coeffs = {6, 				-- Number of Entries	
					1852.0, 1.0,		-- Less than 1nm to target PM goes to 1.0
					4630.0, 0.95,		-- At 2.5nm to target PM is .95
					9260.0, 0.85,		-- At 5.0nm to target PM is .85
					18520.0, 0.45,		-- At 10.0nm to target PM is .45
					27780.0, 0.10,		-- At 15.0nm to target PM is .10
					37040.0, 0.05,		-- At 20.0nm to target or higher PM is .05
					};	


    supersonic_A_coef_skew = 0.1, -- slope of the direct polarity factor of the polar on supersonic
    nozzle_exit_area       = 0.025, -- the nozzle exit area

    class_name      = 'wAmmunitionSelfHoming',
    scheme          = 'aa_missile_amraam',

    controller = {
        boost_start = 0.5,
        march_start = 1.5,
    },

    boost = {
        impulse                             = 252,
        fuel_mass                           = 42,
        work_time                           = 6.0,
        nozzle_position                     = {{-1.5, 0.0, 0}},
        nozzle_orientationXYZ               = {{0.0, 0.0, 0.0}},
        nozzle_exit_area                    = 0.175,
        tail_width                          = 0.4,
        smoke_color                         = {0.92, 0.92, 0.55},
        smoke_transparency                  = 0.0,
        custom_smoke_dissipation_factor     = 0.0,
    },

    march = {
        impulse                             = 800, 
        fuel_mass                           = 20,
        work_time                           = 50.0,
        nozzle_position                     = {{-1.4, 0.0, 0}},
        nozzle_orientationXYZ               = {{0.0, 0.0, 0.0}},
        nozzle_exit_area                    = 0.025,
        tail_width                          = 0.2,        
		smoke_color                         = {0.95, 0.95, 0.95},
        smoke_transparency                  = 0.6,
        custom_smoke_dissipation_factor     = 0.6,

    },

    fm = {
        mass                = sd10_mass,
        caliber             = 0.178,
        wind_sigma          = 0.0,
        wind_time           = 0.0,
        tail_first          = 0,
        fins_part_val       = 0,
        rotated_fins_inp    = 0,
        delta_max           = math.rad(20),
        draw_fins_conv      = {math.rad(90),1,1},
        L                   = 0.203,
        S                   = 0.0324,
        Ix                  = 1.5,
        Iy                  = 190,
        Iz                  = 190,

        Mxd                 = 0.1 * 57.3,
        Mxw                 = -15.8,

        table_scale         = 0.2,
        table_degree_values = 1,
        -- Mach   | 0.0        0.2        0.4        0.6        0.8         1.0        1.2         1.4         1.6          1.8          2.0          2.2         2.4         2.6         2.8         3.0         3.2         3.4         3.6         3.8         4.0         4.2         4.4         4.6         4.8         5.0 |
        Cx0 = {    0.4727,    0.4727,    0.4727,    0.4727,    0.4838,    0.7609,     0.8869,     0.86198,    0.81793,     0.76899,     0.72481,     0.68476,    0.64836,    0.61529,    0.58515,    0.55744,    0.53195,    0.50829,    0.48624,    0.46561,    0.4461,     0.42772,    0.41035,    0.3941,     0.37898,    0.366    },
        CxB = {    0.021,     0.021,     0.021,     0.021,     0.021,     0.138,      0.153,      0.146,      0.1382,      0.1272,      0.1167,      0.1073,     0.0987,     0.0909,     0.0837,     0.077,      0.0708,     0.065,      0.0595,     0.0544,     0.0495,     0.0449,     0.0406,     0.0364,     0.0324,     0.0286    },
        K1  = {    0.00264,   0.00264,   0.00264,   0.00264,   0.00264,   0.00264,    0.0022,     0.001873,   0.0016435,   0.0014752,   0.0013448,   0.0012436,  0.0011534,  0.0010742,  0.0010149,  0.0009484,  0.0009016,  0.0008476,  0.000795,   0.0007529,  0.0007122,  0.0006727,  0.0006343,  0.0006058,  0.0005781,  0.00056    },
        K2  = {    -0.00257,  -0.00257,  -0.00257,  -0.00257,  -0.00257,  -0.00265,   -0.002274,  -0.002034,  -0.0018241,  -0.0016225,  -0.0014468,  -0.001275,  -0.0011248, -0.0009777, -0.0008514, -0.0007274, -0.0006236, -0.0005217, -0.0004393, -0.0003584, -0.0002968, -0.0002363, -0.0001949, -0.0001546, -0.0001335, -0.000114    },
        Cya = {    0.3207,    0.3207,    0.3207,    0.3207,    0.3381,    0.4226,     0.4651,     0.5049,     0.5175,      0.5033,      0.4919,      0.4815,     0.4729,     0.4653,     0.4586,     0.4528,     0.4479,     0.444,      0.441,      0.4371,     0.4341,     0.4321,     0.43,       0.4271,     0.426,      0.424    },
        Cza = {    0.3207,    0.3207,    0.3207,    0.3207,    0.3381,    0.4226,     0.4651,     0.5049,     0.5175,      0.5033,      0.4919,      0.4815,     0.4729,     0.4653,     0.4586,     0.4528,     0.4479,     0.444,      0.441,      0.4371,     0.4341,     0.4321,     0.43,       0.4271,     0.426,      0.424    },
        Mya = {    -0.7724,   -0.7724,   -0.7724,   -0.7724,   -0.8442,   -1.0226,    -0.9581,    -0.85133,   -0.7413,     -0.59726,    -0.49729,    -0.42745,   -0.37784,   -0.3414,    -0.31341,   -0.29077,   -0.27141,   -0.25428,   -0.23854,   -0.22399,   -0.21035,   -0.19771,   -0.18616,   -0.1758,    -0.16696,   -0.16075    },
        Mza = {    -0.7724,   -0.7724,   -0.7724,   -0.7724,   -0.8442,   -1.0226,    -0.9581,    -0.85133,   -0.7413,     -0.59726,    -0.49729,    -0.42745,   -0.37784,   -0.3414,    -0.31341,   -0.29077,   -0.27141,   -0.25428,   -0.23854,   -0.22399,   -0.21035,   -0.19771,   -0.18616,   -0.1758,    -0.16696,   -0.16075    },
        Myw = {    -9.55874,  -9.55874,  -9.55874,  -9.55874,  -9.81248,  -12.17459,  -10.86314,  -10.80419,  -10.7503,    -10.67431,   -10.57881,   -10.46632,  -10.33913,  -10.19945,  -10.04929,  -9.89055,   -9.72493,   -9.55397,   -9.37918,   -9.20172,   -9.02292,   -8.84372,   -8.66508,   -8.48791,   -8.31347,   -8.14394    },
        Mzw = {    -9.55874,  -9.55874,  -9.55874,  -9.55874,  -9.81248,  -12.17459,  -10.86314,  -10.80419,  -10.7503,    -10.67431,   -10.57881,   -10.46632,  -10.33913,  -10.19945,  -10.04929,  -9.89055,   -9.72493,   -9.55397,   -9.37918,   -9.20172,   -9.02292,   -8.84372,   -8.66508,   -8.48791,   -8.31347,   -8.14394    },
        A1trim = { 27.6,      27.6,      27.6,      27.6,      27.55,     30.38,      31.982,     32.774,     33.234,      33.561,      33.829,      34.07,      34.286,     34.491,     34.687,     34.875,     35.056,     35.232,     35.401,     35.564,     35.721,     35.871,     36.015,     36.151,     36.279,     36.4    },
        A2trim = { 27.6,      27.6,      27.6,      27.6,      27.55,     30.38,      31.982,     32.774,     33.234,      33.561,      33.829,      34.07,      34.286,     34.491,     34.687,     34.875,     35.056,     35.232,     35.401,     35.564,     35.721,     35.871,     36.015,     36.151,     36.279,     36.4    },


        model_roll = math.rad(45),
        fins_stall = 1,
    },

    seeker = {
        delay                       = 1.5,
        op_time                     = 100,
        FOV                         = math.rad(120),
        max_w_LOS                   = math.rad(30),
        sens_near_dist              = 100,
        sens_far_dist               = 30000,
        ccm_k0                      = 0.001,
        aim_sigma                   = 7,
        height_error_k              = 20,
        height_error_max_vel        = 50,
        height_error_max_h          = 300,
        hoj                         = 1,
        rad_correction              = 1,
        active_radar_lock_dist      = 25000.0,
        active_dist_trig_by_default = 1,
    },

    autopilot = {
        delay                = 1.0,
        op_time              = 100, 
        Tf                   = 0.1,
        Knav                 = 4.0,
        Kd                   = 180.0,
        Ka                   = 16.0,
        T1                   = 309.0,
        Tc                   = 0.06,
        Kx                   = 0.1,
        Krx                  = 2.0,
        gload_limit          = 30.0,
        fins_limit           = math.rad(24),
        fins_limit_x         = math.rad(5),
        null_roll            = math.rad(45),
        accel_coeffs         = { 0, 11.5,-1.2,-0.25, 24.0,
                                 0.0324 * 0.75 * 0.0091 },

        loft_active          = 1,
        loft_factor          = 4.5,
        loft_sin             = math.sin(30/57.3),
        loft_min_range       = 30000,
        loft_off_range       = 18000,
        dV0                  = 393,
    },

    actuator = {
        Tf                   = 0.005,
        D                    = 250.0,
        T1                   = 0.002,
        T2                   = 0.006,
        max_omega            = math.rad(400),
        max_delta            = math.rad(20),
        fin_stall            = 1,
        sim_count            = 4,
    },

    proximity_fuze = {
        radius      = 12.0,
        arm_delay   = 1.5,
    },

    ModelData = {
        58 ,  -- model params count
        0.4 ,   -- characteristic square (характеристическая площадь) -- 9

        -- параметры зависимости Сx
        0.015 , -- планка Сx0 на дозвуке ( M << 1) cx_k0
        0.050 , -- высота пика волнового кризиса cx_k1
        0.012 , -- крутизна фронта на подходе к волновому кризису cx_k2
        0.004 , -- планка Cx0 на сверхзвуке ( M >> 1) cx_k3
        1.20  , -- крутизна спада за волновым кризисом cx_k4
        0.90  , -- коэффициент отвала поляры

        -- параметры зависимости Cy
        0.90 , -- планка Сy0 на дозвуке ( M << 1)
        0.75 , -- планка Cy0 на сверхзвуке ( M >> 1)
        1.20 , -- крутизна спада(фронта) за волновым кризисом

        0.5 , -- 7 Alfa_max  максимальный балансировачный угол, радианы
        0.00, --угловая скорость создаваймая моментом газовых рулей

        --    t_statr   t_b      t_accel  t_march   t_inertial   t_break  t_end
        -1.0,   -1.0,       6.0,     50.0,      0.0,          0.0,      1.0e9,           -- time interval
        0.0,    0.0,       6.0,     0.4,      0.0,          0.0,        0.0,           -- fuel flow rate in second kg/sec(секундный расход массы топлива кг/сек)
        0.0,    0.0,   20000.0,  20000.0,      0.0,          0.0,        0.0,           -- thrust

        1.0e9, -- таймер самоликвидации, сек  Self-destructive time, sec
        180.0, -- время работы энергосистемы, сек  Working time of power system, sec
        0, -- абсолютная высота самоликвидации, м  Absolute height of self-destruction, M
        0.5, -- время задержки включения управления (маневр отлета, безопасности), сек  Connection delay time (shunting departure, safety), sec
        30000, -- дальность до цели в момент пуска, при превышении которой ракета выполняется маневр 'горка', м
        18000, -- дальность до цели, при которой маневр 'горка' завершается и ракета переходит на чистую пропорциональную навигацию (должен быть больше или равен предыдущему параметру), м
        0.26,  -- синус угла возвышения траектории набора горки
        50.0, -- продольное ускорения взведения взрывателя  Longitudinal acceleration of fuze arming
        0.0, -- модуль скорости сообщаймый катапультным устройством, вышибным зарядом и тд
        1.19, -- характристика системы САУ-РАКЕТА,  коэф фильтра второго порядка K0
        1.0, -- характристика системы САУ-РАКЕТА,  коэф фильтра второго порядка K1
        2.0, -- характристика системы САУ-РАКЕТА,  полоса пропускания контура управления
        0.0, --30000.0, -- дальность полета в горизонт с располагаемой перегрузкой Navail >= 1.0 на высоте H=2000
        0.0, --3.92, -- крутизна зависимости  дальность полета в горизонт с располагаемой перегрузкой Navail >= 1.0 от высоты H
        0.0, --3.2,
        0.0, --0.75, -- безразмерный коэф. эффективности САУ ракеты
        0,0, --70.0, -- расчет времени полета
        -- DLZ. Данные для рассчета дальностей пуска (индикация на прицеле)
        72000.0, -- дальность ракурс   180(навстречу) град,  Н=10000м, V=900км/ч, м
        25000.0, -- дальность ракурс 0(в догон) град,  Н=10000м, V=900км/ч
        30000.0, -- дальность ракурс     180(навстречу) град, Н=1000м, V=900км/ч
        0.2,
        0.6,
        1.4,
        -3.0,
        0.5,
    },
}

declare_weapon(SD_10_AA)
SD_10_AA.shape_table_data.index = SD_10_AA.wsTypeOfWeapon[4]

declare_loadout({
    category    = CAT_AIR_TO_AIR,
    CLSID       = 'Meteor',
    Picture     = 'meteor.png',
    attribute   = SD_10_AA.wsTypeOfWeapon,
    displayName = _(sd10_name),
    Cx_pil      = 0.000859765625,
    Count       = 1,
    Weight      = sd10_mass + pylon_mass,
    Elements    = {
        [1] =
        {
            DrawArgs =
            {
                [1] = {1, 1},
                [2] = {2, 1},
            }, -- end of DrawArgs
            Position  = {0, 0, 0},
            ShapeName = 'pl12',
        },
    }, -- end of Elements
})


declare_loadout({
    category       = CAT_AIR_TO_AIR,
    CLSID          = 'Meteor_DUAL_L', --
    Picture        = 'meteor.png',
    wsTypeOfWeapon = SD_10_AA.wsTypeOfWeapon,
    attribute      = {4,4,32,WSTYPE_PLACEHOLDER},
    displayName    = _(sd10_name .. ' x 2'),
    Cx_pil         = 0.000859765625 * 1.31,
    Count          = 2,
    Weight         = 2 * sd10_mass + pylon_dual_mass,

	Elements	=
	{
			[1]	=
			{
				Position	=	{0,	0,	0},
				ShapeName	=	"LAU-115C+2_LAU127", IsAdapter = true,
					},
			[2]	=
			{	
				Rotation	=	{80, 0, 0.5},
				Position	=	{0.1, -0.065, -0.20},
				ShapeName	=	"pl12",
					},
			[3]	=
			{
				Rotation	=	{-80, 0, -0.5},
				Position	=	{0.1, -0.065, 0.20},
				ShapeName	=	"pl12",					
					},				
	},
    
	JettisonSubmunitionOnly = true,
})

declare_loadout({
    category       = CAT_AIR_TO_AIR,
    CLSID          = 'Meteor_DUAL_R',
    Picture        = 'meteor.png',
    wsTypeOfWeapon = SD_10_AA.wsTypeOfWeapon,
    attribute      = {4,4,32,WSTYPE_PLACEHOLDER},
    displayName    = _(sd10_name .. ' x 2'),
    Cx_pil         = 0.000859765625 * 1.31,
    Count          = 2,
    Weight         = 2 * sd10_mass + pylon_dual_mass,
	
	Elements	=
	{
			[1]	=
			{
				Position	=	{0,	0,	0},
				ShapeName	=	"LAU-115C+2_LAU127", IsAdapter = true,
					},
			[2]	=
			{	
				Rotation	=	{80, 0, 0.5},
				Position	=	{0.1, -0.065, -0.20},
				ShapeName	=	"pl12",
					},
			[3]	=
			{
				Rotation	=	{-80, 0, -0.5},
				Position	=	{0.1, -0.065, 0.20},
				ShapeName	=	"pl12",
					},
	},
	
    JettisonSubmunitionOnly = true,
})
local Rb99_name = 'Rb99 AIM-120B'
local Rb99_mass = 156.0
local pylon_mass = 1.0

local Rb99_warhead = enhanced_a2a_warhead(11, 169)

RB99_AA = {
    category        = CAT_AIR_TO_AIR,
    name            = Rb99_name,
    model           = 'aim-120b',
    user_name       = _(Rb99_name),
    wsTypeOfWeapon  = {4,4,7,WSTYPE_PLACEHOLDER},
    mass            = Rb99_mass,

    Escort          = 0,
    Head_Type       = 2,
    sigma           = {5, 5, 5},
    M               = Rb99_mass,
    H_max           = 20000.0,
    H_min           = 1.0,
    Diam            = 169.0,
    Cx_pil          = 2.5,
    D_max           = 14000.0,
    D_min           = 700.0,
    Head_Form       = 1,
    Life_Time       = 90.0,
    Nr_max          = 30,
    v_min           = 140.0,
    v_mid           = 700.0,
    Mach_max        = 4.0,
    t_b             = 0.0,
    t_acc           = 3.0,
    t_marsh         = 5.0,
    Range_max       = 57000.0,
    H_min_t         = 3.0,
    Fi_start        = 0.4,
    Fi_rak          = 3.14152,
    Fi_excort       = 1.05,
    Fi_search       = 1.05,
    OmViz_max       = 0.52,
    exhaust         = { 0.8, 0.8, 0.8, 0.05 };
	X_back          = -1.99,
    Y_back          = 0.0,
    Z_back          = 0.0,
    Reflection      = 0.04,
    KillDistance    = 15.0,
	Loft = 1,
	Hoj = 1,
	Loft_factor = 4.5,

    warhead         = Rb99_warhead,
    warhead_air     = Rb99_warhead,

    shape_table_data = {
        {
            name     = Rb99_name,
            file     = 'aim-120b',
            life     = 1,
            fire     = {0, 1},
            username = Rb99_name,
            index    = WSTYPE_PLACEHOLDER,
        },
    },


	PN_coeffs = {3, 				-- Number of Entries	
				15000.0 ,1.0,		-- Less 5 km to target Pn = 1
				25000.0, 0.5,		-- Between 10 and 5 km  to target, Pn smoothly changes from 0.5 to 1.0. 
				40000.0, 0.25};		-- Between 15 and 10 km  to target, Pn smoothly changes from 0.2 to 0.5. Longer then 15 km Pn = 0.2.
		
	supersonic_A_coef_skew = 0.1, -- наклон прямой коэффициента отвала поляры на сверхзвуке
	nozzle_exit_area =	0.011, -- площадь выходного сечения сопла

    class_name      = 'wAmmunitionSelfHoming',
    scheme          = 'aa_missile_amraam',

    controller = {
        boost_start = 0.5,
        march_start = 2.6,
    },

    boost = {
        impulse                             = 236,
        fuel_mass                           = 18.21,
        work_time                           = 2.1,
        nozzle_position                     = {{-1.9, 0.0, 0}},
        nozzle_orientationXYZ               = {{0.0, 0.0, 0.0}},
        nozzle_exit_area                    = 0.132,
        tail_width                          = 0.4,
        smoke_color                         = {0.8, 0.8, 0.8},
        smoke_transparency                  = 0.03,
        custom_smoke_dissipation_factor     = 0.2,
    },

    march = {
        impulse                             = 227, 
        fuel_mass                           = 28.33,
        work_time                           = 5.0,
        nozzle_position                     = {{-1.9, 0.0, 0}},
        nozzle_orientationXYZ               = {{0.0, 0.0, 0.0}},
        nozzle_exit_area                    = 0.0132,
        tail_width                          = 0.4,        
		smoke_color                         = {0.8, 0.8, 0.8},
        smoke_transparency                  = 0.03,
        custom_smoke_dissipation_factor     = 0.2,

    },

    fm = {
        mass                = Rb99_mass,
        caliber             = 0.178,
        wind_sigma          = 0.0,
        wind_time           = 0.0,
        tail_first          = 0,
        fins_part_val       = 0,
        rotated_fins_inp    = 0,
        delta_max           = math.rad(20),
        draw_fins_conv      = {math.rad(90),1,1},
        L                   = 0.178,
        S                   = 0.0248,
        Ix                  = 1.24,
        Iy                  = 130.12,
        Iz                  = 130.12,

        Mxd                 = 0.1 * 57.3,
        Mxw                 = -15.8,

        table_scale         = 0.2,
        table_degree_values = 1,
	--	Mach	  | 0.0		0.2		0.4		0.6		0.8		1.0		1.2		1.4		1.6		1.8		2.0		2.2		2.4		2.6		2.8		3.0		3.2		3.4		3.6		3.8		4.0	 	4.2		4.4		4.6		4.8		5.0 |
		Cx0 	= {	0.515,	0.515,	0.515,	0.515,	0.527,	0.85,	0.949,	0.905,	0.8605,	0.8094,	0.7636,	0.7204,	0.6813,	0.6458,	0.6135,	0.5839,	0.5567,	0.5316,	0.5082,	0.4864,	0.4659,	0.4468,	0.4288,	0.4121,	0.3968,	0.384  },
		CxB 	= {	0.021,	0.021,	0.021,	0.021,	0.021,	0.138,	0.153,	0.146,	0.1382,	0.1272,	0.1167,	0.1073,	0.0987,	0.0909,	0.0837,	0.077,	0.0708,	0.065,	0.0595,	0.0544,	0.0495,	0.0449,	0.0406,	0.0364,	0.0324,	0.0286 },
		K1		= { 0.0039,	0.0039,	0.0039,	0.0039,	0.0039,	0.0048,	0.004,	0.00325,	0.002845,	0.002602,	0.002378,	0.002176,	0.001994,	0.001832,	0.001689,	0.001564,	0.001456,	0.001366,	0.00129,	0.001229,	0.001182,	0.001147,	0.001123,	0.001108,	0.001101,	0.0011 },
		K2		= { -0.0041,-0.0041,-0.0041,-0.0041,-0.0041,-0.0049,-0.0042,-0.0036,	-0.003121,	-0.002725,	-0.002408,	-0.00213,	-0.001888,	-0.001677,	-0.001494,	-0.001334,	-0.001196,	-0.001077,	-0.000973,	-0.000884,	-0.000808,	-0.000743,	-0.000689,	-0.000646,	-0.000615,	-0.0006 },
		Cya		= { 0.345,	0.345,	0.345,	0.345,	0.357,	0.401,	0.448,	0.495,	0.513,	0.506,	0.5,	0.495,	0.49,	0.486,	0.482,	0.478,	0.474,	0.471,	0.468,	0.465,	0.462,	0.46,	0.457,	0.455,	0.453,	0.451 },
		Cza		= { 0.345,	0.345,	0.345,	0.345,	0.357,	0.401,	0.448,	0.495,	0.513,	0.506,	0.5,	0.495,	0.49,	0.486,	0.482,	0.478,	0.474,	0.471,	0.468,	0.465,	0.462,	0.46,	0.457,	0.455,	0.453,	0.451 },
		Mya		= { -1.316,-1.316,	-1.316,	-1.316,	-1.458,	-1.982,	-1.418,	-1.0883,-0.9411,-0.8255,-0.733,	-0.6574,-0.5942,-0.5403,-0.4935,-0.4525,-0.4164,-0.3846,-0.3568,-0.3328,-0.3125,-0.2959,-0.283,-0.2739,-0.2683,-0.2665 },
		Mza		= { -1.316,-1.316,	-1.316,	-1.316,	-1.458,	-1.982,	-1.418,	-1.0883,-0.9411,-0.8255,-0.733,	-0.6574,-0.5942,-0.5403,-0.4935,-0.4525,-0.4164,-0.3846,-0.3568,-0.3328,-0.3125,-0.2959,-0.283,-0.2739,-0.2683,-0.2665 },
		Myw		= { -16.3145,-16.3145,-16.3145,-16.3145,-16.8944,-19.8659,-18.1868,-17.1716,-16.504,-15.88,-15.2958,-14.7478,-14.2328,-13.7477,-13.2901,-12.8574,-12.4477,-12.0593,-11.6911,-11.3421,-11.0121,-10.7015,-10.4118,-10.1458,-9.9098,-9.7256 },
		Mzw		= { -16.3145,-16.3145,-16.3145,-16.3145,-16.8944,-19.8659,-18.1868,-17.1716,-16.504,-15.88,-15.2958,-14.7478,-14.2328,-13.7477,-13.2901,-12.8574,-12.4477,-12.0593,-11.6911,-11.3421,-11.0121,-10.7015,-10.4118,-10.1458,-9.9098,-9.7256 },
		A1trim	= { 24,		24,		24,		24,		23.5,	23,		25.16,	27.23,	29.04,	30.6,	31.93,	33.08,	34.07,	34.95,	35.74,	36.45,	37.09,	37.68,	38.2,	38.66,	39.06,	39.39,	39.66,	39.85,	39.96,	40 },
		A2trim	= { 24,		24,		24,		24,		23.5,	23,		25.16,	27.23,	29.04,	30.6,	31.93,	33.08,	34.07,	34.95,	35.74,	36.45,	37.09,	37.68,	38.2,	38.66,	39.06,	39.39,	39.66,	39.85,	39.96,	40 },
		
		model_roll = math.rad(45),
		fins_stall = 1,
    },

    seeker = {
        delay                       = 1.5,
        op_time                     = 80,
        FOV                         = math.rad(120),
        max_w_LOS                   = math.rad(30),
        sens_near_dist              = 100,
        sens_far_dist               = 30000,
        ccm_k0                      = 0.2,
        aim_sigma                   = 7.5,
        height_error_k              = 25,
        height_error_max_vel        = 60,
        height_error_max_h          = 300,
        hoj                         = 1,
        rad_correction              = 1,
        active_radar_lock_dist      = 15000.0,
        active_dist_trig_by_default = 1,
    },

    autopilot = {
        delay                = 1.0,
        op_time              = 80, 
        Tf                   = 0.1,
        Knav                 = 4.0,
        Kd                   = 110.0,
        Ka                   = 22.0,
        T1                   = 292.0,
        Tc                   = 0.04,
        Kx                   = 0.1,
        Krx                  = 2.0,
        gload_limit          = 30.0,
        fins_limit           = math.rad(18),
        fins_limit_x         = math.rad(5),
        null_roll            = math.rad(45),
        accel_coeffs         = { 0, 9.4,1.8,0.35, 23.6,
                                 0.0248 * 0.75 * 0.009 },

        loft_active          = 1,
        loft_factor          = 4.5,
        loft_sin             = math.sin(30/57.3),
        loft_off_range       = 15000,
        dV0                  = 347,
    },

    actuator = {
        Tf                   = 0.005,
        D                    = 250.0,
        T1                   = 0.002,
        T2                   = 0.006,
        max_omega            = math.rad(400),
        max_delta            = math.rad(20),
        fin_stall            = 1,
        sim_count            = 4,
    },

    proximity_fuze = {
        radius      = 7.0,
        arm_delay   = 1.6,
    },

    ModelData = {
        58 ,  -- model params count
        0.5 ,   -- characteristic square (характеристическая площадь) -- 9

        -- параметры зависимости Сx
        0.026 , -- планка Сx0 на дозвуке ( M << 1) cx_k0
        0.053 , -- высота пика волнового кризиса cx_k1
        0.01 , -- крутизна фронта на подходе к волновому кризису cx_k2
        -0.245 , -- планка Cx0 на сверхзвуке ( M >> 1) cx_k3
        0.075  , -- крутизна спада за волновым кризисом cx_k4
        0.7  , -- коэффициент отвала поляры

        -- параметры зависимости Cy
        1.5 , -- планка Сy0 на дозвуке ( M << 1)
        0.6 , -- планка Cy0 на сверхзвуке ( M >> 1)
        0.7 , -- крутизна спада(фронта) за волновым кризисом

        0.5 , -- 7 Alfa_max  максимальный балансировачный угол, радианы
        0.00, --угловая скорость создаваймая моментом газовых рулей

        --    t_statr   t_b      t_accel  t_march   t_inertial   t_break  t_end
        -1.0,   -1.0,       4.0,     4.0,      0.0,          0.0,      1.0e9,           -- time interval
        0.0,    0.0,       7.69,     3.94,      0.0,          0.0,        0.0,           -- fuel flow rate in second kg/sec(секундный расход массы топлива кг/сек)
        0.0,    0.0,   19600.0,  10045.0,      0.0,          0.0,        0.0,           -- thrust

        1.0e9, -- таймер самоликвидации, сек  Self-destructive time, sec
        80.0, -- время работы энергосистемы, сек  Working time of power system, sec
        0, -- абсолютная высота самоликвидации, м  Absolute height of self-destruction, M
        1.0, -- время задержки включения управления (маневр отлета, безопасности), сек  Connection delay time (shunting departure, safety), sec
        25000, -- дальность до цели в момент пуска, при превышении которой ракета выполняется маневр 'горка', м
        15000, -- дальность до цели, при которой маневр 'горка' завершается и ракета переходит на чистую пропорциональную навигацию (должен быть больше или равен предыдущему параметру), м
        0.52356,  -- синус угла возвышения траектории набора горки
        50.0, -- продольное ускорения взведения взрывателя  Longitudinal acceleration of fuze arming
        0.0, -- модуль скорости сообщаймый катапультным устройством, вышибным зарядом и тд
        1.19, -- характристика системы САУ-РАКЕТА,  коэф фильтра второго порядка K0
        1.0, -- характристика системы САУ-РАКЕТА,  коэф фильтра второго порядка K1
        2.0, -- характристика системы САУ-РАКЕТА,  полоса пропускания контура управления
        19700.0, --30000.0, -- дальность полета в горизонт с располагаемой перегрузкой Navail >= 1.0 на высоте H=2000
        3.69, --3.92, -- крутизна зависимости  дальность полета в горизонт с располагаемой перегрузкой Navail >= 1.0 от высоты H
        3.2, --3.2,
        0.75, --0.75, -- безразмерный коэф. эффективности САУ ракеты
        67.0, --70.0, -- расчет времени полета
        -- DLZ. Данные для рассчета дальностей пуска (индикация на прицеле)
        63000.0, -- дальность ракурс   180(навстречу) град,  Н=10000м, V=900км/ч, м
        20000.0, -- дальность ракурс 0(в догон) град,  Н=10000м, V=900км/ч
        24000.0, -- дальность ракурс     180(навстречу) град, Н=1000м, V=900км/ч
        0.2,
        0.6,
        1.4,
        -3.0,
        0.5,
    },
}

declare_weapon(RB99_AA)
RB99_AA.shape_table_data.index = RB99_AA.wsTypeOfWeapon[4]

declare_loadout({
    category    = CAT_AIR_TO_AIR,
    CLSID       = "{Rb99}",
    Picture     = 'us_AIM-120B.png',
    attribute   = RB99_AA.wsTypeOfWeapon,
    displayName = _(Rb99_name),
    Cx_pil      = 0.001959765625,
    Count       = 1,
    Weight      = Rb99_mass + pylon_mass,
    Elements    = {
        [1] =
        {
            DrawArgs =
            {
                [1] = {1, 1},
                [2] = {2, 1},
            }, -- end of DrawArgs
            Position  = {0, 0, 0},
            ShapeName = 'aim-120b',
        },
    }, -- end of Elements
})