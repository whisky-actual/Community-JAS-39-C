
local sd10_name = 'METEOR'
local sd10_mass = 25.0
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
    sigma           = {5, 5, 5},
    Escort          = 0,
    Head_Type       = 2,
    sigma           = {5, 5, 5},
    M = 250.0,
        H_max = 40000.0,
        H_min = 10.0,
        Diam = 380.0,
        Cx_pil = 3,
        D_max = 95000.0,
        D_min = 1000.0,
        Head_Form = 1,
        Life_Time = 240.0,
        Nr_max = 12,
        v_min = 140.0,
        v_mid = 960.0,
        Mach_max = 4.5,
        t_b = 0.1,
        t_acc = 6.0,
        t_marsh = 100.0,
        Range_max = 280000.0,
        H_min_t = 20.0,
        Fi_start = 0.3,
        Fi_rak = 3.14152,
        Fi_excort = 0.87,
        Fi_search = 0.87,
        OmViz_max = 0.35,
		warhead = enhanced_a2a_warhead(25.0),
		exhaust = { 1, 1, 1, 1 },
        X_back = -1.333,
        Y_back = -0.193,
        Z_back = 0.0,
        Reflection = 0.081,
        KillDistance = 20.0,

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

    ModelData = {   58 ,  -- model params count
						0.6 ,   -- characteristic square (характеристическая площадь)
						
						-- параметры зависимости Сx
						0.07 , -- Cx_k0 планка Сx0 на дозвуке ( M << 1)
						0.08 , -- Cx_k1 высота пика волнового кризиса
						0.02 , -- Cx_k2 крутизна фронта на подходе к волновому кризису
						0.012, -- Cx_k3 планка Cx0 на сверхзвуке ( M >> 1)
						2.5 , -- Cx_k4 крутизна спада за волновым кризисом 
						1.2 , -- коэффициент отвала поляры (пропорционально sqrt (M^2-1))
						
						-- параметры зависимости Cy
						0.6 , -- Cy_k0 планка Сy0 на дозвуке ( M << 1)
						0.3	 , -- Cy_k1 планка Cy0 на сверхзвуке ( M >> 1)
						1.2  , -- Cy_k2 крутизна спада(фронта) за волновым кризисом  
						
						0.2 , -- 7 Alfa_max  максимальный балансировачный угол, радианы
						0.0, --угловая скорость создаваймая моментом газовых рулей
						
					-- Engine data. Time, fuel flow, thrust.	
					--	t_statr		t_b		t_accel		t_march		t_inertial		t_break		t_end			-- Stage
						-1.0,	   -1.0,	6.0,  		60.0,		0.0,			0.0,		1.0e9,         -- time of stage, sec
						 0.0,		0.0,	15.00,		3.0,		0.0,			0.0,		0.0,           -- fuel flow rate in second, kg/sec(секундный расход массы топлива кг/сек)
						 0.0,		0.0,	23000.0,	10000.0,	0.0,			0.0,		0.0,           -- thrust, newtons
					
						 1.0e9, -- таймер самоликвидации, сек
						 200.0, -- время работы энергосистемы, сек
						 0, -- абсолютная высота самоликвидации, м
						 2.5, -- время задержки включения управления (маневр отлета, безопасности), сек
						 80000.0, -- дальность до цели в момент пуска, при превышении которой ракета выполняется маневр "горка", м
						 80000.0, -- дальность до цели, при которой маневр "горка" завершается и ракета переходит на чистую пропорциональную навигацию (должен быть больше или равен предыдущему параметру), м 
						 0.15,  -- синус угла возвышения траектории набора горки
						 30.0, -- продольное ускорения взведения взрывателя
						 0.0, -- модуль скорости сообщаймый катапультным устройством, вышибным зарядом и тд
						 0.19, -- характристика системы САУ-РАКЕТА,  коэф фильтра второго порядка K0
						 0.10, -- характристика системы САУ-РАКЕТА,  коэф фильтра второго порядка K1
						 0.20, -- характристика системы САУ-РАКЕТА,  полоса пропускания контура управления	
						 0.0,
						 0.0,
						 0.0,
						 0.0,
						 0.0,
						  -- DLZ. Данные для рассчета дальностей пуска (индикация на прицеле)
						 160000.0, -- дальность ракурс   180(навстречу) град,  Н=10000м, V=900км/ч, м
						 100000.0, -- дальность ракурс 0(в догон) град,  Н=10000м, V=900км/ч
						 95000.0, -- дальность ракурс 	180(навстречу) град, Н=1000м, V=900км/ч
						 0.2, -- Уменьшение разрешенной дальности пуска при отклонении вектора скорости носителя от линии визирования цели.
						 0.7, -- Вертикальная плоскость. Наклон кривой разрешенной дальности пуска в нижнюю полусферу. Уменьшение дальности при стрельбе вниз.
						 1.0, -- Вертикальная плоскость. Наклон кривой разрешенной дальности пуска в верхнюю полусферу. Увеличение дальности при стрельбе вверх.
						-3.0, -- Вертикальная плоскость. Угол перегиба кривой разрешенной дальности, верхняя - нижняя полусфера.
						 0.5, -- Изменение коэффициентов наклона кривой в верхнюю и нижнюю полусферы от высоты носителя.
					},
}

declare_weapon(SD_10_AA)
SD_10_AA.shape_table_data.index = SD_10_AA.wsTypeOfWeapon[4]

declare_loadout({
    category    = CAT_AIR_TO_AIR,
    CLSID       = 'DIS_SD-10',
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
    CLSID          = 'DIS_SD-10_DUAL_L',
    Picture        = 'meteor.png',
    wsTypeOfWeapon = SD_10_AA.wsTypeOfWeapon,
    attribute      = {4,4,32,WSTYPE_PLACEHOLDER},
    displayName    = _(sd10_name .. ' x 2'),
    Cx_pil         = 0.000859765625 * 1.31,
    Count          = 2,
    Weight         = 2 * sd10_mass + pylon_dual_mass,
--    Elements       = {
--        { ShapeName = 'lau-115C+2_lau7', IsAdapter = true, },
--        { ShapeName = 'pl12',            connector_name = 'Point02', },
--        { ShapeName = 'pl12',            connector_name = 'Point03', },
--    }, -- end of Elements
 
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
				Position	=	{0.1, -0.05, -0.205},
				ShapeName	=	"pl12",
					},
			[3]	=
			{
				Rotation	=	{-80, 0, -0.5},
				Position	=	{0.1, -0.05,  0.205},
				ShapeName	=	"pl12",
					},
	},

 JettisonSubmunitionOnly = true,
})

declare_loadout({
    category       = CAT_AIR_TO_AIR,
    CLSID          = 'DIS_SD-10_DUAL_R',
    Picture        = 'meteor.png',
    wsTypeOfWeapon = SD_10_AA.wsTypeOfWeapon,
    attribute      = {4,4,32,WSTYPE_PLACEHOLDER},
    displayName    = _(sd10_name .. ' x 2'),
    Cx_pil         = 0.000859765625 * 1.31,
    Count          = 2,
    Weight         = 2 * sd10_mass + pylon_dual_mass,
--    Elements       = {
--        { ShapeName = 'lau-115C+2_lau7', IsAdapter = true, },
--        { ShapeName = 'pl12',            connector_name = 'Point03', },
--        { ShapeName = 'pl12',            connector_name = 'Point02', },
--    }, -- end of Elements

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
				Position	=	{0.1, -0.05, -0.205},
				ShapeName	=	"pl12",
					},
			[3]	=
			{
				Rotation	=	{-80, 0, -0.5},
				Position	=	{0.1, -0.05,  0.205},
				ShapeName	=	"pl12",
					},
	},
    JettisonSubmunitionOnly = true,
})

