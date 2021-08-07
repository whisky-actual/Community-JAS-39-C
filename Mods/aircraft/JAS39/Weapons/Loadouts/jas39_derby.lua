
local jas_derby_name = 'I-Derby ER BVRAAM Active Rdr AAM'
local jas_derby_mass = 118.0
local pylon_mass = 1.0

local jas_derby_warhead = enhanced_a2a_warhead(23, 160)

JAS_MBDA_DERBY = {
    category        = CAT_AIR_TO_AIR,
    name            = jas_derby_name,
    model           = 'jas39_derby',
    user_name       = _(jas_derby_name),
	wsTypeOfWeapon 	= {wsType_Weapon,wsType_Missile,wsType_AA_Missile,WSTYPE_PLACEHOLDER},
    mass            = jas_derby_mass,

    Escort          = 0,
    Head_Type       = 2,
    sigma           = {4, 4, 4},
    M               = jas_derby_mass,
    H_max           = 20000.0,
    H_min           = 1.0,
    Diam            = 160.0,
    Cx_pil          = 2.0,
    D_max           = 50000.0,
    D_min           = 1000.0,
    Head_Form       = 1,
    Life_Time       = 180.0,
    Nr_max          = 35,
    v_min           = 140.0,
    v_mid           = 2575.0,
    Mach_max        = 4.0,
    t_b             = 0.0,
    t_acc           = 6.0,
    t_marsh         = 8.0,
    Range_max       = 100000.0,
    H_min_t         = 1.0,
    Fi_start        = 0.780,
    Fi_rak          = 3.14152,
    Fi_excort       = 1.0472,
    Fi_search       = 1.05,
    OmViz_max       = 0.6981,
    exhaust         = { 1, 1, 1, 0.3 };
	X_back          = -1.45,
    Y_back          = 0.0, -- -0.11
    Z_back          = 0.0,
    Reflection      = 0.03,
    KillDistance    = 15.0,
	loft 			= 1,
	hoj 			= 1,
	ccm_k0 			= 0.05,
	loft_factor 	= 1.1,	

	active_radar_lock_dist	= 20000.0,
	go_active_by_default	= 1,
	
	PN_coeffs = {11,                 -- Number of Entries
				0.0, 1.0,
				4000.0, 0.995,
				5000.0, 0.99,
				6000.0, 0.97,
				7000.0, 0.94,
				10000.0, 0.80,
				15000.0, 0.50,
				20000.0, 0.35,
				30000.0, 0.20,
				40000.0, 0.14,
				80000.0, 0.05,
				};
	
    warhead         = jas_derby_warhead,
    warhead_air     = jas_derby_warhead,

    shape_table_data = {
        {
            name     = jas_derby_name,
            file     = 'jas39_derby',
            life     = 1,
            fire     = {0, 1},
            username = "derby",
            index    = WSTYPE_PLACEHOLDER,
        },
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
        -1.0,   -1.0,       6.0,     6.0,      0.0,          0.0,      1.0e9,           -- time interval
        0.0,    0.0,       6.0,     0.4,      0.0,          0.0,        0.0,           -- fuel flow rate in second kg/sec(секундный расход массы топлива кг/сек)
        0.0,    0.0,   17000.0,  1000.0,      0.0,          0.0,        0.0,           -- thrust

        1.0e9, -- таймер самоликвидации, сек  Self-destructive time, sec
        180.0, -- время работы энергосистемы, сек  Working time of power system, sec
        0, -- абсолютная высота самоликвидации, м  Absolute height of self-destruction, M
        0.5, -- время задержки включения управления (маневр отлета, безопасности), сек  Connection delay time (shunting departure, safety), sec
        30000, -- дальность до цели в момент пуска, при превышении которой ракета выполняется маневр 'горка', м
        30000, -- дальность до цели, при которой маневр 'горка' завершается и ракета переходит на чистую пропорциональную навигацию (должен быть больше или равен предыдущему параметру), м
        0.26,  -- синус угла возвышения траектории набора горки
        50.0, -- продольное ускорения взведения взрывателя  Longitudinal acceleration of fuze arming
        0.0, -- модуль скорости сообщаймый катапультным устройством, вышибным зарядом и тд
        1.19, -- характристика системы САУ-РАКЕТА,  коэф фильтра второго порядка K0
        1.0, -- характристика системы САУ-РАКЕТА,  коэф фильтра второго порядка K1
        2.0, -- характристика системы САУ-РАКЕТА,  полоса пропускания контура управления
        30000, --30000.0, -- дальность полета в горизонт с располагаемой перегрузкой Navail >= 1.0 на высоте H=2000
        3.92, --3.92, -- крутизна зависимости  дальность полета в горизонт с располагаемой перегрузкой Navail >= 1.0 от высоты H
        3.2, --3.2,
        0.75, --0.75, -- безразмерный коэф. эффективности САУ ракеты
        70.0, --70.0, -- расчет времени полета
        -- DLZ. Данные для рассчета дальностей пуска (индикация на прицеле)
        80000.0, -- дальность ракурс   180(навстречу) град,  Н=10000м, V=900км/ч, м
        27000.0, -- дальность ракурс 0(в догон) град,  Н=10000м, V=900км/ч
        31000.0, -- дальность ракурс     180(навстречу) град, Н=1000м, V=900км/ч
        0.2,
        0.6,
        1.4,
        -3.0,
        0.5,
    },
}

declare_weapon(JAS_MBDA_DERBY)

declare_loadout({
    category    = CAT_AIR_TO_AIR,
    CLSID       = "{JAS39_Derby}",
    Picture     = 'jas39_derby.png',
    wsTypeOfWeapon   = JAS_MBDA_DERBY.wsTypeOfWeapon,
    displayName = _(jas_derby_name),
	attribute	=	{4,	4,	32, WSTYPE_PLACEHOLDER},
    Count       = 1,
    Weight      = jas_derby_mass + pylon_mass,
    Elements    =
	{
		{
		
			ShapeName	=	"jas39_derby",
			Position	=	{0,	0,	0}
		},
	},	
})
