
local Rb99_name = 'Rb99 AIM-120B AMRAAM Active Rdr AAM'
local Rb99_mass = 156.0
local pylon_mass = 1.0
local pylon_dual_mass = 1.0

local wsType_RB99 = 18839

local Rb99_warhead = enhanced_a2a_warhead(11, 169)

local RB99_AA = {
    category        = CAT_AIR_TO_AIR,
    name            = Rb99_name,
    model           = 'aim-120b',
    user_name       = _(Rb99_name),
    wsTypeOfWeapon  = {4,4,7,18839},
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
            username = "Rb99",		--Shortened name for cockpit displays
            index    = 18839,
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
    CLSID       = "JAS_Rb99",
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

declare_loadout({
    category    = CAT_AIR_TO_AIR,
    CLSID       = "JAS_Rb99_DUAL", 
    Picture     = 'us_AIM-120B.png',
	wsTypeOfWeapon = RB99_AA.wsTypeOfWeapon,
    attribute   = {4,4,32,18839},
    displayName = _(Rb99_name .. ' x 2'),
    Cx_pil      = 0.001959765625 * 1.31,
    Count       = 2,
    Weight      = 2 * Rb99_mass + pylon_dual_mass, 

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
				ShapeName	=	"aim-120b",
					},
			[3]	=
			{
				Rotation	=	{-80, 0, -0.5},
				Position	=	{0.1, -0.065, 0.20},
				ShapeName	=	"aim-120b",					
					},				
	},
    
	JettisonSubmunitionOnly = true,
})

