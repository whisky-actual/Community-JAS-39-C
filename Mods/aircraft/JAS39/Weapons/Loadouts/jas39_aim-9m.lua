local jas_aim9m_name = 'AIM-9M Sidewinder IR AAM'
local jas_aim9m_mass = 85
local pylon_mass = 1.0

JAS_AIM9M_AA = {
    category        = CAT_AIR_TO_AIR,
    name            = jas_aim9m_name,
    user_name       = _(jas_aim9m_name),
    wsTypeOfWeapon  = {4,4,7,WSTYPE_PLACEHOLDER},
    Escort          = 0,
    Head_Type       = 1,
    sigma           = {3, 3, 3},
    M               = jas_aim9m_mass,
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
		warhead = enhanced_a2a_warhead(9.4, 127),       
		exhaust = { 0.8, 0.8, 0.8, 1.0 },
		X_back = -1.66,
		Y_back = 0.0,
		Z_back = 0.0,
        Reflection = 0.0162,
        KillDistance = 5.0,
    --seeker sensivity params
    SeekerSensivityDistance = 20000, -- The range of target with IR value = 1. In meters.
    ccm_k0        = 0.55,  -- Counter Countermeasures Probability Factor. Value = 0 - missile has absolutely resistance to countermeasures. Default = 1 (medium probability)
    SeekerCooled  = true, -- True is cooled seeker and false is not cooled seeker.

    shape_table_data = {
        {
            name     = jas_aim9m_name,
            file     = 'aim-9l',
            life     = 1,
            fire     = {0, 1},
            username = "AIM9M",
            index    = WSTYPE_PLACEHOLDER,
        },
    },

    ModelData = {
        58 ,  -- model params count
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

declare_weapon(JAS_AIM9M_AA)
JAS_AIM9M_AA.shape_table_data.index = JAS_AIM9M_AA.wsTypeOfWeapon[4]

declare_loadout({
    category     	= CAT_AIR_TO_AIR,
    CLSID        	= "{JAS39_AIM-9M}",
    Picture     	= 'us_aim-9l.png',
    attribute       = {4,4,32,WSTYPE_PLACEHOLDER},
	wsTypeOfWeapon	= JAS_AIM9M_AA.wsTypeOfWeapon,
    displayName 	= _(jas_aim9m_name),
    Cx_pil      	= 0.0001,
    Count       	= 1,
    Weight      	= jas_aim9m_mass + pylon_mass,
    Elements    	= {
		[1]	=
		{
			Position	=	{0, 0, 0},
			ShapeName	=	"aero-3b",
			IsAdapter 	= true,
		},
		[2]	=
		{
			Position	=	{0.0,	-0.10,	0}, 
			ShapeName	=	"aim-9l",
		},
    }, -- end of Elements
})
