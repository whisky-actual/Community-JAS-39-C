
local jas_aim9x_name = 'AIM-9X Sidewinder IR AAM'
local jas_aim9x_mass = 85.5
local pylon_mass = 1.0

JAS_AIM9X_AA = {
    category        = CAT_AIR_TO_AIR,
    name            = jas_aim9x_name,
    user_name       = _(jas_aim9x_name),
    wsTypeOfWeapon  = {4,4,7,WSTYPE_PLACEHOLDER},
		Escort = 0,
        Head_Type = 1,
		sigma = {2, 2, 2},
        M = 85.5,
        H_max = 18000.0,
        H_min = -1,
        Diam = 127.0,
        Cx_pil = 1.88,
        D_max = 11000.0,
        D_min = 200.0,
        Head_Form = 0,
        Life_Time = 60.0,
        Nr_max = 55,
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
        Fi_excort = 1.57,
        Fi_search = 0.09,
        OmViz_max = 1.10,
        warhead = enhanced_a2a_warhead(5.0),
        exhaust = { 0.7, 0.7, 0.7, 0.08 };
        X_back = -1.65,
        Y_back = 0.0,
        Z_back = 0.0,
        Reflection = 0.03,
        KillDistance = 7.0,

    --seeker sensivity params
    SeekerSensivityDistance = 14000, -- The range of target with IR value = 1. In meters.
    ccm_k0        = 0.05,  -- Counter Countermeasures Probability Factor. Value = 0 - missile has absolutely resistance to countermeasures. Default = 1 (medium probability)
    SeekerCooled  = true, -- True is cooled seeker and false is not cooled seeker.

	PN_coeffs = {3, 				-- Number of Entries	
			3000.0 ,1.0,		-- Less 3 km to target Pn = 1
			5000.0, 0.5,		-- Between 5 and 3 km  to target, Pn smoothly changes from 0.5 to 1.0. 
			10000.0, 0.2};		-- Between 10 and 5 km  to target, Pn smoothly changes from 0.2 to 0.5. Longer then 10 km Pn = 0.2.


    shape_table_data = {
        {
            name     = jas_aim9x_name,
            file     = 'aim-9x',
            life     = 1,
            fire     = {0, 1},
            username = "AIM9X",
            index    = WSTYPE_PLACEHOLDER,
        },
    },

ModelData = {   58 ,  -- model params count
				0.35 ,   -- characteristic square (характеристическая площадь)
				
				-- параметры зависимости Сx
				0.04 , -- Cx_k0 планка Сx0 на дозвуке ( M << 1)
				0.08 , -- Cx_k1 высота пика волнового кризиса
				0.02 , -- Cx_k2 крутизна фронта на подходе к волновому кризису
				0.05, -- Cx_k3 планка Cx0 на сверхзвуке ( M >> 1)
				1.2 , -- Cx_k4 крутизна спада за волновым кризисом 
				1.0 , -- коэффициент отвала поляры (пропорционально sqrt (M^2-1))
				
				-- параметры зависимости Cy
				0.9 , -- Cy_k0 планка Сy0 на дозвуке ( M << 1)
				0.8	 , -- Cy_k1 планка Cy0 на сверхзвуке ( M >> 1)
				1.2  , -- Cy_k2 крутизна спада(фронта) за волновым кризисом  
				
				0.7 , -- 7 Alfa_max  максимальный балансировачный угол, радианы
				10.0, -- Extra G by trust vector
				
			-- Engine data. Time, fuel flow, thrust.	
			--	t_statr		t_b		t_accel		t_march		t_inertial		t_break		t_end			-- Stage
				-1.0,		-1.0,	5.0,  		0.0,		0.0,			0.0,		1.0e9,         -- time of stage, sec
				 0.0,		0.0,	5.44,		0.0,		0.0,			0.0,		0.0,           -- fuel flow rate in second, kg/sec(секундный расход массы топлива кг/сек)
				 0.0,		0.0,	12802.0,	0.0,	0.0,			0.0,		0.0,           -- thrust, newtons
			
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

				 -- DLZ. Данные для рассчета дальностей пуска (индикация на прицеле)
				 14.0, 
				 -15.0, 
				 -2.5, 
				 8500, 
				 2900, 
				 14000,
				 5500, 
				 5800, 
				 1700, 
				 1500, 
				 0.5, 
				 -0.014, 
				 0.5,
					},
}

declare_weapon(JAS_AIM9X_AA)
JAS_AIM9X_AA.shape_table_data.index = JAS_AIM9X_AA.wsTypeOfWeapon[4]

declare_loadout({
    category     	= CAT_AIR_TO_AIR,
    CLSID        	= "{JAS39_AIM-9X}",
    Picture     	= 'us_aim-9x.png',
    attribute       = {4,4,32,WSTYPE_PLACEHOLDER},
	wsTypeOfWeapon	= JAS_AIM9X_AA.wsTypeOfWeapon,
    displayName 	= _(jas_aim9x_name),
    Cx_pil      	= 0.0001,
    Count       	= 1,
    Weight      	= jas_aim9x_mass + pylon_mass,
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
			ShapeName	=	"aim-9x",
		},
    }, -- end of Elements
})
