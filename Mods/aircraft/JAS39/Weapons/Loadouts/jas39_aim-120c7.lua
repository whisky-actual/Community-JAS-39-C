
local jas_aim120c7_name = 'AIM-120C-7 AMRAAM Active Rdr AAM'
local jas_aim120c7_mass = 161.5
local pylon_mass = 1.0

local jas_aim120c7_warhead = enhanced_a2a_warhead(9, 178)

local JAS_aim120c7_AA = {
    category        = CAT_AIR_TO_AIR,
    name            = jas_aim120c7_name,
    model           = 'aim-120c',
    user_name       = _(jas_aim120c7_name),
	wsTypeOfWeapon 	= {wsType_Weapon,wsType_Missile,wsType_AA_Missile,WSTYPE_PLACEHOLDER},
    mass            = jas_aim120c7_mass,

	Escort 			= 0,
    Head_Type 		= 2,
	sigma 			= {5, 5, 5},
    M 				= jas_aim120c7_mass,
    H_max 			= 20000.0,
    H_min 			= 1.0,
    Diam			= 178.0,
    Cx_pil 			= 2.5,
    D_max 			= 29000.0,
    D_min 			= 700.0,
    Head_Form 		= 1,
    Life_Time 		= 90.0,
    Nr_max 			= 30,
    v_min 			= 140.0,
    v_mid 			= 700.0,
    Mach_max 		= 4.0,
    t_b 			= 0.0,
    t_acc 			= 0.0,
    t_marsh 		= 8.0,
    Range_max 		= 100000.0,
    H_min_t 		= 1.0,
    Fi_start 		= 0.5,
    Fi_rak 			= 3.14152,
    Fi_excort 		= 1.05,
    Fi_search 		= 1.05,
    OmViz_max 		= 0.52,
    exhaust 		= {0.8, 0.8, 0.8, 0.05 };
    X_back 			= -1.98,
    Y_back 			= 0.0,
    Z_back 			= 0.0,
    Reflection 		= 0.04,
    KillDistance 	= 15.0,
	loft 			= 1,
	hoj 			= 1,
	ccm_k0 			= 0.1,

    warhead         = jas_aim120c7_warhead,
    warhead_air     = jas_aim120c7_warhead,

    shape_table_data = {
        {
            name     = jas_aim120c7_name,
            file     = 'aim-120c',
            life     = 1,
            fire     = {0, 1},
            username = "AIM120C7",		--Shortened name for cockpit displays
            index    = WSTYPE_PLACEHOLDER,
        },
    },

	ModelData = {   58 ,  -- model params count
					0.4 ,   -- characteristic square (характеристическая площадь)
					
					-- параметры зависимости Сx
					0.029 , -- Cx_k0 планка Сx0 на дозвуке ( M << 1)
					0.06 , -- Cx_k1 высота пика волнового кризиса
					0.01 , -- Cx_k2 крутизна фронта на подходе к волновому кризису
					-0.245, -- Cx_k3 планка Cx0 на сверхзвуке ( M >> 1)
					0.08 , -- Cx_k4 крутизна спада за волновым кризисом 
					0.7 , -- коэффициент отвала поляры (пропорционально sqrt (M^2-1))
					
					-- параметры зависимости Cy
					1.4 , -- Cy_k0 планка Сy0 на дозвуке ( M << 1)
					0.6	 , -- Cy_k1 планка Cy0 на сверхзвуке ( M >> 1)
					1.2  , -- Cy_k2 крутизна спада(фронта) за волновым кризисом  
					
					0.5 , -- 7 Alfa_max  максимальный балансировачный угол, радианы
					0.0, --угловая скорость создаваймая моментом газовых рулей
					
				-- Engine data. Time, fuel flow, thrust.	
				--	t_statr		t_b		t_accel		t_march		t_inertial		t_break		t_end			-- Stage
					-1.0,		-1.0,	9.0,  		0.0,		0.0,			0.0,		1.0e9,         -- time of stage, sec
					 0.0,		0.0,	8.5,		0.0,		0.0,			0.0,		0.0,           -- fuel flow rate in second, kg/sec(секундный расход массы топлива кг/сек)
					 0.0,		0.0,	20000.0,	0.0,		0.0,			0.0,		0.0,           -- thrust, newtons
				
					 1.0e9, -- таймер самоликвидации, сек
					 90.0, -- время работы энергосистемы, сек
					 0, -- абсолютная высота самоликвидации, м
					 1.0, -- время задержки включения управления (маневр отлета, безопасности), сек
					 25000, --40000 -- дальность до цели в момент пуска, при превышении которой ракета выполняется маневр "горка", м
					 15000, --40000 -- дальность до цели, при которой маневр "горка" завершается и ракета переходит на чистую пропорциональную навигацию (должен быть больше или равен предыдущему параметру), м 
					 0.52356,--0.17, -- синус угла возвышения траектории набора горки
					 50.0, -- продольное ускорения взведения взрывателя
					 0.0, -- модуль скорости сообщаймый катапультным устройством, вышибным зарядом и тд
					 1.19, -- характристика системы САУ-РАКЕТА,  коэф фильтра второго порядка K0
					 1.0, -- характристика системы САУ-РАКЕТА,  коэф фильтра второго порядка K1
					 2.0, -- характристика системы САУ-РАКЕТА,  полоса пропускания контура управления
					 25200.0, -- дальность полета в горизонт с располагаемой перегрузкой Navail >= 1.0 на высоте H=2000
					 3.92, -- крутизна зависимости  дальность полета в горизонт с располагаемой перегрузкой Navail >= 1.0 от высоты H
					 3.2,
					 0.75, -- безразмерный коэф. эффективности САУ ракеты
					 70.0, -- расчет времени полета
					  -- DLZ. Данные для рассчета дальностей пуска (индикация на прицеле)
					 40000.0, -- дальность ракурс   180(навстречу) град,  Н=10000м, V=900км/ч, м
					 35000.0, -- дальность ракурс 0(в догон) град,  Н=10000м, V=900км/ч
					 14000.0, -- дальность ракурс 	180(навстречу) град, Н=1000м, V=900км/ч
					 0.2, 
					 0.6,
					 1.4,
					-3.0,
					0.5,
    },
}

declare_weapon(JAS_aim120c7_AA)

declare_loadout({
	category		=	CAT_AIR_TO_AIR,
	CLSID			= 	"JAS39_AIM120C7",
	Picture			=	"us_AIM-120C.png",
	wsTypeOfWeapon	=	JAS_aim120c7_AA.wsTypeOfWeapon,
	displayName		=	_(jas_aim120c7_name),
	attribute		=	{4,	4,	32,	103,	WSTYPE_PLACEHOLDER},
	Count			=	1,
	Weight			=	jas_aim120c7_mass + pylon_mass,
	Elements		=	
	{
		{
		
			ShapeName	=	"aim-120c",
			Position	=	{0,	0,	0}
		},
	}, 	
	
	
})