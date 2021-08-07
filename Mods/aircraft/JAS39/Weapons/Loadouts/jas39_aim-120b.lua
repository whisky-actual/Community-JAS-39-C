
local jas_aim120b_name = 'AIM-120B AMRAAM Active Rdr AAM'
local jas_aim120b_mass = 156.0
local pylon_mass = 1.0

local jas_aim120b_warhead = enhanced_a2a_warhead(11, 178)

local JAS_AIM120B_AA = {
    category        = CAT_AIR_TO_AIR,
    name            = jas_aim120b_name,
    model           = 'aim-120b',
    user_name       = _(jas_aim120b_name),
	wsTypeOfWeapon 	= {wsType_Weapon,wsType_Missile,wsType_AA_Missile,WSTYPE_PLACEHOLDER},
    mass            = jas_aim120b_mass,

    Escort          = 0,
    Head_Type       = 2,
    sigma           = {5, 5, 5},
    M               = jas_aim120b_mass,
    H_max           = 20000.0,
    H_min           = 1.0,
    Diam            = 178.0,
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
	Loft			= 1,
	Hoj 			= 1,
	ccm_k0 			= 0.2,
	loft_factor 	= 1.1,	

	active_radar_lock_dist	= 15000.0,
	go_active_by_default	= 1,

	PN_coeffs = {3, 				-- Number of Entries	
				15000.0 ,1.0,		-- Less 5 km to target Pn = 1
				25000.0, 0.5,		-- Between 10 and 5 km  to target, Pn smoothly changes from 0.5 to 1.0. 
				40000.0, 0.25};		-- Between 15 and 10 km  to target, Pn smoothly changes from 0.2 to 0.5. Longer then 15 km Pn = 0.2.

    warhead         = jas_aim120b_warhead,
    warhead_air     = jas_aim120b_warhead,

    shape_table_data = {
        {
            name     = jas_aim120b_name,
            file     = 'aim-120b',
            life     = 1,
            fire     = {0, 1},
            username = "AIM120B",		--Shortened name for cockpit displays
            index    = WSTYPE_PLACEHOLDER,
        },
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
        50000.0, -- дальность ракурс   180(навстречу) град,  Н=10000м, V=900км/ч, м
        15000.0, -- дальность ракурс 0(в догон) град,  Н=10000м, V=900км/ч
        20000.0, -- дальность ракурс     180(навстречу) град, Н=1000м, V=900км/ч
        0.2,
        0.6,
        1.4,
        -3.0,
        0.5,
    },
}

declare_weapon(JAS_AIM120B_AA)

declare_loadout({
    category    = CAT_AIR_TO_AIR,
    CLSID       = "{JAS39_AIM120B}",
    Picture     = 'us_AIM-120B.png',
    wsTypeOfWeapon   = JAS_AIM120B_AA.wsTypeOfWeapon,
    displayName = _(jas_aim120b_name),
	attribute	=	{4,	4,	32,	WSTYPE_PLACEHOLDER},
    Count       = 1,
    Weight      = jas_aim120b_mass + pylon_mass,
    Elements    = 
	{
		{
		
			ShapeName	=	"aim-120b",
			Position	=	{0,	0,	0}
		},
	}, 	
})
