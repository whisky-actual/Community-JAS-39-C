local tips 		= {
	{ CLSID = "{6CEB49FC-DED8-4DED-B053-E1F033FF72D3}" ,arg_increment = 0.0}, --aim 9M
    { CLSID = "{9BFD8C90-F7AE-4e90-833B-BFD0CED0E536}" ,arg_increment = 0.0}, --aim 9p
	{ CLSID = "{C8E06185-7CD6-4C90-959F-044679E90751}" ,arg_increment = 0.0}, --AIM_120B
	{ CLSID = "{40EF17B7-F508-45de-8566-6FFECC0C1AB8}" ,arg_increment = 0.0}, --AIM_120C
	{ CLSID = "{AIS_ASQ_T50}" ,arg_increment = 0.0, attach_point_position = {0.30,  0.0,  0.0}},-- ACMI pod
    { CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E741}" ,arg_increment = 0.0}, -- smoke gen blue
    { CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E742}" ,arg_increment = 0.0}, -- smoke gen green
    { CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E743}" ,arg_increment = 0.0}, -- smoke gen orange
    { CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E744}" ,arg_increment = 0.0}, -- smoke gen red
    { CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E745}" ,arg_increment = 0.0}, -- smoke gen white
    { CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E746}" ,arg_increment = 0.0}, -- smoke gen yellow
}

local outboard 	= {
	{ CLSID = "LAU-115_2*LAU-127_AIM-9M"				,arg_increment = 0.8},	-- 2xAIM-9M
	{ CLSID = "LAU-115_2*LAU-127_CATM-9M"				,arg_increment = 0.8},	-- 2xCATM-9M
	{ CLSID = "LAU-115_2*LAU-127_AIM-9L"				,arg_increment = 0.8},	-- 2xAIM-9L
	{ CLSID = "LAU-115_2*LAU-127_AIM-9X"				,arg_increment = 0.8},	-- 2xAIM-9X
	{ CLSID = "LAU-115_LAU-127_AIM-9X"					,arg_increment = 0.8},	-- AIM-9X
	{ CLSID = "LAU-115_LAU-127_CATM-9M"					,arg_increment = 0.8},	-- CATM-9M
	{ CLSID = "LAU-115_LAU-127_AIM-9L"					,arg_increment = 0.8},	-- AIM-9L
	{ CLSID = "LAU-115_LAU-127_AIM-9M"					,arg_increment = 0.8},	-- AIM-9M
	{ CLSID = "{C8E06185-7CD6-4C90-959F-044679E90751}" ,arg_increment = 0.0, attach_point_position = {0.3, -0.22, 0.0}},--AIM-120B
	{ CLSID = "{40EF17B7-F508-45de-8566-6FFECC0C1AB8}" ,arg_increment = 0.0, attach_point_position = {0.3, -0.22, 0.0}},--AIM-120C	
	{ CLSID = "<CLEAN>"									,arg_increment = 1},
}

local inboard 	= {
	{ CLSID = "LAU-115_2*LAU-127_AIM-9M"				,arg_increment = 0.8},	-- 2xAIM-9M
	{ CLSID = "LAU-115_2*LAU-127_CATM-9M"				,arg_increment = 0.8},	-- 2xCATM-9M
	{ CLSID = "LAU-115_2*LAU-127_AIM-9L"				,arg_increment = 0.8},	-- 2xAIM-9L
	{ CLSID = "LAU-115_2*LAU-127_AIM-9X"				,arg_increment = 0.8},	-- 2xAIM-9X
	{ CLSID = "LAU-115_LAU-127_AIM-9X"					,arg_increment = 0.8},	-- AIM-9X
	{ CLSID = "LAU-115_LAU-127_CATM-9M"					,arg_increment = 0.8},	-- CATM-9M
	{ CLSID = "LAU-115_LAU-127_AIM-9L"					,arg_increment = 0.8},	-- AIM-9L
	{ CLSID = "LAU-115_LAU-127_AIM-9M"					,arg_increment = 0.8},	-- AIM-9M
	{ CLSID = "{C8E06185-7CD6-4C90-959F-044679E90751}" ,arg_increment = 0.0, attach_point_position = {0.0, -0.22, 0.0}},--AIM-120B
	{ CLSID = "{40EF17B7-F508-45de-8566-6FFECC0C1AB8}" ,arg_increment = 0.0, attach_point_position = {0.0, -0.22, 0.0}},--AIM-120C

	{ CLSID = "{jas39_1100_ptb}" 						,arg_increment = 0.8}, --Zusatztank 1100 Liter
	{ CLSID = "{jas39_1700_ptb}" 						,arg_increment = 0.8}, --Zusatztank 1700 Liter
	{ CLSID = "<CLEAN>"									,arg_increment = 1},
}

local fuselageLeft	= {
	--
}

local fuselageRight	= {
	{ CLSID = "<CLEAN>"									,arg_increment = 1},
}

local centerline 	= {
	{ CLSID = "{jas39_1100_ptb}" ,arg_increment = 0.0},               --Zusatztank 1100 Liter
	{ CLSID = "{jas39_1700_ptb}" ,arg_increment = 0.0},               --Zusatztank 1700 Liter
	{ CLSID = "<CLEAN>"									,arg_increment = 1},
}


local ECM_ELINT 	= {
	{ CLSID = "{44EE8698-89F9-48EE-AF36-5FD31896A82F}" }, --L005 Sorbtsiya ECM pod (left)
	{ CLSID = "{0519A264-0AB6-11d6-9193-00A0249B6F00}",attach_point_position = {0, 0 ,0 } },-- ELINT
	{ CLSID = "{INV-SMOKE-RED}		"},		--Smoke Generator - red
	{ CLSID = "{INV-SMOKE-GREEN}	"},		--Smoke Generator - green
	{ CLSID = "{INV-SMOKE-BLUE}		"},		--Smoke Generator - blue
	{ CLSID = "{INV-SMOKE-WHITE}	"},		--Smoke Generator - white
	{ CLSID = "{INV-SMOKE-YELLOW}	"},		--Smoke Generator - yellow
	{ CLSID = "{INV-SMOKE-ORANGE}	"},		--Smoke Generator - orange
}

VSN_JAS39Gripen =  {
      
		Name 			= 'VSN_JAS39Gripen',--AG
		DisplayName		= _('JAS 39 Gripen'),--AG
        Picture 		= "VSN_JAS39Gripen.png",
        Rate 			= "50",
        Shape			= "VSN_JAS39Gripen",--AG	
        WorldID			=  WSTYPE_PLACEHOLDER, 
        
	shape_table_data 	= 
	{
		{
			file  	 	= 'VSN_JAS39Gripen';--AG
			life  	 	= 20; -- lifebar
			vis   	 	= 3; -- visibility gain.
			desrt    	= 'VSN_JAS39Gripen-oblomok'; -- Name of destroyed object file name
			fire  	 	= { 300, 2}; 			-- Fire on the ground after destoyed: 300sec 2m
			username	= 'VSN_JAS39Gripen';--AG
			index       =  WSTYPE_PLACEHOLDER;
			classname   = "lLandPlane";
			positioning = "BYNORMAL";
		},
		{
			name  		= "VSN_JAS39Gripen-oblomok";
			file  		= "VSN_JAS39Gripen-oblomok";
			fire  		= { 240, 2};
		},
	},
	
	LandRWCategories = 
        {
        [1] = 
        {
			Name = "AircraftCarrier",
        },
        [2] = 
        {
            Name = "AircraftCarrier With Catapult",
        }, 
        [3] = 
        {
            Name = "AircraftCarrier With Tramplin",
        }, 
    }, -- end of LandRWCategories
        TakeOffRWCategories = 
        {
        [1] = 
        {
			Name = "AircraftCarrier",
        },
        [2] = 
        {
            Name = "AircraftCarrier With Catapult",
        }, 
        [3] = 
        {
            Name = "AircraftCarrier With Tramplin",
        }, 
    }, -- end of TakeOffRWCategories
	
	mapclasskey 		= "P0091000024",
	attribute  			= {wsType_Air, wsType_Airplane, wsType_Fighter, WSTYPE_PLACEHOLDER, "Fighters", "Refuelable", "Datalink", "Link16"},
	Categories= {"{78EFB7A2-FD52-4b57-A6A6-3BF0E1D6555F}", "Interceptor",},
	
		M_empty						=	13380,	-- kg  with pilot and nose load, F15
		M_nominal					=	19000,	-- kg (Empty Plus Full Internal Fuel)
		M_max						=	30845,	-- kg (Maximum Take Off Weight)
		M_fuel_max					=	6103,	-- kg (Internal Fuel Only)
		H_max						=	18300,	-- m  (Maximum Operational Ceiling)
		average_fuel_consumption	=	0.271,
		CAS_min						=	58,		-- Minimum CAS speed (m/s) (for AI)
		V_opt						=	220,	-- Cruise speed (m/s) (for AI)
		V_take_off					=	61,		-- Take off speed in m/s (for AI)
		V_land						=	71,		-- Land speed in m/s (for AI)
		has_afteburner				=	true,
		has_speedbrake				=	true,
		radar_can_see_ground		=	true,

		nose_gear_pos 				                = {4.488,	-2.140,	0},   -- nosegear coord 
	    nose_gear_amortizer_direct_stroke   		=  0,      -- down from nose_gear_pos !!!
	    nose_gear_amortizer_reversal_stroke  		=  -0.43,  -- up 
	    nose_gear_amortizer_normal_weight_stroke 	=  -0.215,   -- up 
	    nose_gear_wheel_diameter 	                =  0.544, -- in m
	
	    main_gear_pos 						 	    = {-0.800,	-2.020,	1.25}, -- main gear coords 
	    main_gear_amortizer_direct_stroke	 	    =   0,     --  down from main_gear_pos !!!
	    main_gear_amortizer_reversal_stroke  	    =   -0.228, --  up 
	    main_gear_amortizer_normal_weight_stroke    =   -0.114,-- down from main_gear_pos
	    main_gear_wheel_diameter 				    =   0.66, -- in m

		AOA_take_off				=	0.16,	-- AoA in take off (for AI)
		stores_number				=	12,
		bank_angle_max				=	60,		-- Max bank angle (for AI)
		Ny_min						=	-3,		-- Min G (for AI)
		Ny_max						=	8,		-- Max G (for AI)
		V_max_sea_level				=	403,	-- Max speed at sea level in m/s (for AI)
		V_max_h						=	736.11,	-- Max speed at max altitude in m/s (for AI)
		wing_area					=	56.5,	-- wing area in m2
		thrust_sum_max				=	13347,	-- thrust in kgf (64.3 kN)
		thrust_sum_ab				=	21952,	-- thrust in kgf (95.1 kN)
		Vy_max						=	275,	-- Max climb speed in m/s (for AI)
		flaps_maneuver				=	1,
		Mach_max					=	2,	-- Max speed in Mach (for AI)
		range						=	2540,	-- Max range in km (for AI)
		RCS							=	1.0,		-- Radar Cross Section m2
		Ny_max_e					=	8,		-- Max G (for AI)
		detection_range_max			=	250,
		IR_emission_coeff			=	0.6,	-- Normal engine -- IR_emission_coeff = 1 is Su-27 without afterburner. It is reference.
		IR_emission_coeff_ab		=	1.33,		-- With afterburner
		tand_gear_max				=	3.73,--XX  1.732 FA18 3.73, 
		tanker_type					=	2,--F14=2/S33=4/ M29=0/S27=0/F15=1/ F16=1/To=0/F18=2/A10A=1/ M29K=4/F4=0/
		wing_span					=	8.40,	--XX  wing spain in m
		wing_type 					= 	0,		-- 0=FIXED_WING/ 1=VARIABLE_GEOMETRY/ 2=FOLDED_WING/ 3=ARIABLE_GEOMETRY_FOLDED
		length						=	14.1,
		height						=	4.5,
		crew_size					=	1, --XX
		engines_count				=	1, --XX
		wing_tip_pos 				= 	{-3.404,	-0.164,	4.05},
		
		--EPLRS 						= true,--?
		TACAN_AA					= true,--?
		mechanimations = {
            Door0 = {
                {Transition = {"Close", "Open"},  Sequence = {{C = {{"Arg", 38, "to", 0.9, "in", 8.08},},},}, Flags = {"Reversible"},},
                {Transition = {"Open", "Close"},  Sequence = {{C = {{"Arg", 38, "to", 0.0, "in", 6.743},},},}, Flags = {"Reversible", "StepsBackwards"},},
                {Transition = {"Any", "Bailout"}, Sequence = {{C = {{"JettisonCanopy", 0},},},},},
            },
            CrewLadder = {
                {Transition = {"Dismantle", "Erect"}, Sequence = {{C = {{"Arg", 91, "to", -1.0, "in", 1.5}}}, {C = {{"Sleep", "for", 5.0}}}}, Flags = {"Reversible"}},
                {Transition = {"Erect", "Dismantle"}, Sequence = {{C = {{"Arg", 91, "to", 0.0, "in", 2.7}}}, {C = {{"Sleep", "for", 0.0}}}}, Flags = {"Reversible", "StepsBackwards"}},
            },
        },
		
		engines_nozzles = 
		{
			[1] = 
			{
				pos = 	{-6.231,	0.268,	0},-- Tribwerke   -5.231,	-0.468,	0
				elevation	=	0,-- AFB cone elevation  winkel nach oben unten
				diameter	=	1.0,-- AFB cone diameter   Kreis Ø
				exhaust_length_ab	=	9.0,--lenght in m  Kreis Ø kegel efekt
				exhaust_length_ab_K	=	0.707,--animation geschwindigkeit
				smokiness_level     = 	0.01, --0.05
			}, -- end of [1]
		}, -- end of engines_nozzles
		crew_members = 
		{
			[1] = 
			{
				ejection_seat_name	=	17,
				drop_canopy_name	=	"vsn_jas39gripen-fonar";
				pos = 	{3.9,	1.4,	0},
			}, -- end of [1]
		}, -- end of crew_members
		brakeshute_name	=	0,
		is_tanker	=	false,
		air_refuel_receptacle_pos = 	{-0.051,	0.911,	0},
		fires_pos = 
		{
			[1] = 	{-0.707,	0.553,	-0.213},
			[2] = 	{-0.037,	0.285,	1.391},
			[3] = 	{-0.037,	0.285,	-1.391},
			[4] = 	{-0.82,	0.265,	2.774},
			[5] = 	{-0.82,	0.265,	-2.774},
			[6] = 	{-0.82,	0.255,	4.274},
			[7] = 	{-0.82,	0.255,	-4.274},
			[8] = 	{-5.003,	0.261,	0},
			[9] = 	{-5.003,	0.261,	0},
			[10] = 	{-0.707,	0.453,	1.036},
			[11] = 	{-0.707,	0.453,	-1.036},
		}, -- end of fires_pos
		
		effects_presets = {
			{effect = "OVERWING_VAPOR", file = current_mod_path.."/Effects/VSN_JAS39Gripen_overwingVapor.lua"},
		},
		
		chaff_flare_dispenser = 
		{
			[1] = 
			{
				dir = 	{0,	1,	0},--0,	1,	0  vorne
				pos = 	{-2.776,	-1.0,	-0.422},---5.776,	1.4,	-0.422
			}, -- end of [1]
			[2] = 
			{
				dir = 	{0,	1,	0},--0,	1,	0
     			pos = 	{-2.776,	-1.0,	0.422},---5.776,	1.4,	0.422
			}, -- end of [2]
		}, -- end of chaff_flare_dispenser

        -- Countermeasures
passivCounterm 		= {
CMDS_Edit 			= true,
SingleChargeTotal 	= 180,
chaff 				= {default = 90, increment = 45, chargeSz = 1},
flare 				= {default = 45, increment = 45, chargeSz = 2}
 },
	
        CanopyGeometry 	= {
            azimuth 	= {-145.0, 145.0},-- pilot view horizontal (AI)
            elevation 	= {-50.0, 90.0}-- pilot view vertical (AI)
        },

Sensors = {
RADAR 			= "AN/APG-63",--F15
RWR 			= "Abstract RWR"--F15
},
Countermeasures = {
ECM 			= "AN/ALQ-135"--F15
},
	Failures = {
			{ id = 'asc', 		label = _('ASC'), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'autopilot', label = _('AUTOPILOT'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'hydro',  	label = _('HYDRO'), 	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'l_engine',  label = _('L-ENGINE'), 	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'r_engine',  label = _('R-ENGINE'), 	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'radar',  	label = _('RADAR'), 	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		  --{ id = 'eos',  		label = _('EOS'), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		  --{ id = 'helmet',  	label = _('HELMET'), 	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'mlws',  	label = _('MLWS'), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'rws',  		label = _('RWS'), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'ecm',   	label = _('ECM'), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'hud',  		label = _('HUD'), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'mfd',  		label = _('MFD'), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },		
	},
	HumanRadio = {
		frequency 		= 127.5,  -- Radio Freq
		editable 		= true,
		minFrequency	= 100.000,
		maxFrequency 	= 156.000,
		modulation 		= MODULATION_AM
	},

Guns = {gun_mount("BK_27", { count = 180 },{muzzle_pos = {3.10000, -0.300000, -0.450000}})--**180
},

--pylons_enumeration = {1, 11, 10, 2, 3, 9, 4, 8, 5, 7, 6},

	Pylons =     {

        pylon(1, 0, 0, 0, 0,
			{
				DisplayName = "1",
  				use_full_connector_position = true,
				connector = "Pylon1",
			},
			tips
		),
        pylon(2, 0, 0, 0, 0,
			{
				arg = 310,
				arg_value = 0,
				DisplayName = "3",
				use_full_connector_position = true,
				connector = "Pylon3",
			},
			inboard
		),
        pylon(3, 0, 0, 0, 0,
			{
				arg = 309,
				arg_value = 0,
				DisplayName = "2",
				use_full_connector_position = true,
				connector = "Pylon2",
			},
			outboard
		),
        pylon(4, 1, 0, 0, 0,
            {
				arg = 311,
				arg_value = 0,
				DisplayName = "-",--4
            	use_full_connector_position = true,
				connector = "Pylon4",
			},
			fuselageLeft
		),
        pylon(5, 2, 0, 0, 0,--26
			{
				arg = 312,
				arg_value = 0,
				DisplayName = "ELINT",
				use_full_connector_position = true,
				connector = "Pylon5",
			},
			ECM_ELINT
		),
        pylon(6, 1, 0, 0, 0,
			{
				arg = 313,
				arg_value = 0,
				DisplayName = "4",
				use_full_connector_position = true,
				connector = "Pylon6",
			},
			centerline
		),
		pylon(7, 2, 0, 0, 0,--26
			{
				arg = 314,
				arg_value = 0,
				DisplayName = "ECM",
				use_full_connector_position = true,
				connector = "Pylon8",
			},
			ECM_ELINT
		),
        pylon(8, 1, 0, 0, 0,
            {
				arg = 315,
				arg_value = 0,
				DisplayName = "5",--6
            	use_full_connector_position = true,
				connector = "Pylon7",
			},
			fuselageRight
		),
        pylon(9, 0, 0, 0, 0,
			{
				arg = 317,
				arg_value = 0,
				DisplayName = "7",
				use_full_connector_position = true,
				connector = "Pylon10",
			},
			outboard
		),
        pylon(10, 0, 0, 0, 0,
			{
				arg = 316,
				arg_value = 0,
				DisplayName = "6",
				use_full_connector_position = true,
				connector = "Pylon9",
			},
			inboard
		),
		pylon(11, 0, 0, 0, 0,
			{
				DisplayName = "8",
				use_full_connector_position = true,
				connector = "Pylon11",
			},
			tips
		),
},
	
	Tasks = {
        aircraft_task(CAP),
     	aircraft_task(Escort),
      	aircraft_task(FighterSweep),
		aircraft_task(Intercept),
		aircraft_task(Reconnaissance),
    },	
	DefaultTask = aircraft_task(FighterSweep),

	SFM_Data = {
	aerodynamics = --F15
		{
			Cy0	=	0,
			Mzalfa	=	6,
			Mzalfadt	=	1,
			kjx = 2.95,
			kjz = 0.00125,
			Czbe = -0.016,
			cx_gear = 0.0268,
			cx_flap = 0.06,
			cy_flap = 0.4,
			cx_brk = 0.06,
			table_data = 
			{
			--      M	 Cx0		 Cya		 B		 B4	      Omxmax	Aldop	Cymax
				{0.0,	0.0215,		0.055,		0.08,		0.22,	0.65,	25.0,	1.2 	},
				{0.2,	0.0215,		0.055,		0.08,		0.22,	1.80,	25.0,	1.2     },
				{0.4,	0.0215,		0.055,		0.08,	   	0.22,	3.00,	25.0,	1.2     },
				{0.6,	0.0215,		0.055,		0.05,		0.28,	4.20,	25.0,	1.2     },
				{0.7,	0.0215,		0.055,		0.05,		0.28,	4.20,	23.0,	1.15    },
				{0.8,	0.0215,		0.055,		0.05,		0.28,	4.20,	21.7,	1.1     },
				{0.9,	0.0230,		0.058,		0.09,		0.20,	4.20,	20.1,	1.07    },
				{1.0,	0.0320,		0.062,		0.17,		0.15,	4.20,	18.9,	1.04    },
				{1.1,	0.0430,		0.062,	   	0.235,		0.09,	3.78,	17.4,	1.02    },
				{1.2,	0.0460,		0.062,	   	0.285,		0.08,	2.94,	17.0,	1.00 	},		
				{1.3,	0.0470,		0.06,	   	0.29,		0.10,	2.10,	16.0,	0.92 	},				
				{1.4,	0.0470,		0.056,	   	0.3,		0.136,	1.80,	15.0,	0.80 	},					
				{1.6,	0.0470,		0.052,	   	0.34,		0.21,	1.08,	13.0,	0.7 	},					
				{1.8,	0.0460,		0.042,	   	0.34,		2.43,	0.96,	12.0,	0.55 	},		
				{2.2,	0.0420,		0.037,	   	0.49,		3.5,	0.84,	 10.0,	0.37 	},					
				{2.5,	0.0420,		0.033,		0.6,		4.7,	0.84,	 9.0,	0.3 	},		
				{3.9,	0.0400,		0.023,		0.9,		6.0,	0.84,	 7.0,	0.2		},
			}, -- end of table_data
		}, -- end of aerodynamics
		engine = 
		{
			Nmg	=	67.5,
			MinRUD	=	0,
			MaxRUD	=	1,
			MaksRUD	=	0.85,
			ForsRUD	=	0.91,
			type	=	"TurboJet",
			hMaxEng	=	19.5,
			dcx_eng	=	0.0114,
			cemax	=	1.24,
			cefor	=	2.56,
			dpdh_m	=	6000,
			dpdh_f	=	14000.0,
			table_data = {
			--   M		Pmax		 Pfor
				{0.0,	115000,		212000},
				{0.2,	 94000,		200000},
				{0.4,	 92000,		205000},
				{0.6,	103000,		207000},
				{0.7,	105000,		210000},
				{0.8,	105000,		220000},
				{0.9,	105000,		235000},
				{1.0,	107000,		250000},
				{1.1,	103000,		258000},
				{1.2,	 94000,		268000},
				{1.3,	 84000,		285000},
				{1.4,	 71000,		300000},
				{1.6,	 34000,		318000},
				{1.8,	 19000,		337000},
				{2.2,	 17000,		370000},
				{2.5,	 19000,		390000},
				{3.9,	 82000,		310000},
			}, -- end of table_data
		}, -- end of engine
	},


	--damage , index meaning see in  Scripts\Aircrafts\_Common\Damage.lua
	Damage = {
	[0]  = {critical_damage = 5,  args = {146}},--NOSE_CENTER
	[1]  = {critical_damage = 3,  args = {296}},--NOSE_LEFT_SIDE
	[2]  = {critical_damage = 3,  args = {297}},--NOSE_RIGHT_SIDE
	[3]  = {critical_damage = 8,  args = {65}}, --CABINA
	[4]  = {critical_damage = 2,  args = {298}},--CABIN_LEFT_SIDE
	[5]  = {critical_damage = 2,  args = {301}},--CABIN_RIGHT_SIDE
	[7]  = {critical_damage = 2,  args = {249}},--GUN
	[8]  = {critical_damage = 3,  args = {265}},--FRONT_GEAR_BOX
	[9]  = {critical_damage = 3,  args = {154}},--FUSELAGE_LEFT_SIDE
	[10] = {critical_damage = 3,  args = {153}},--FUSELAGE_RIGHT_SIDE
	[11] = {critical_damage = 1,  args = {167}},--ENGINE_L_IN
	[12] = {critical_damage = 1,  args = {161}},--ENGINE_R_IN
	[13] = {critical_damage = 2,  args = {169}},--MTG_L_BOTTOM
	[14] = {critical_damage = 2,  args = {163}},--MTG_R_BOTTOM
	[15] = {critical_damage = 2,  args = {267}},--LEFT_GEAR_BOX
	[16] = {critical_damage = 2,  args = {266}},--RIGHT_GEAR_BOX
	[17] = {critical_damage = 2,  args = {168}},--MTG_L  (ENGINE)
	[18] = {critical_damage = 2,  args = {162}},--MTG_R  (ENGINE)
	[20] = {critical_damage = 2,  args = {183}},--AIR_BRAKE_R
	[23] = {critical_damage = 5,  args = {223}},--WING_L_OUT
	[24] = {critical_damage = 5,  args = {213}},--WING_R_OUT
	[25] = {critical_damage = 2,  args = {226}},--ELERON_L
	[26] = {critical_damage = 2,  args = {216}},--ELERON_R
	[29] = {critical_damage = 5,  args = {224}, deps_cells = {23, 25}},--WING_L_CENTER
	[30] = {critical_damage = 5,  args = {214}, deps_cells = {24, 26}},--WING_R_CENTER
	[35] = {critical_damage = 6,  args = {225}, deps_cells = {23, 29, 25, 37}},--WING_L_IN
	[36] = {critical_damage = 6,  args = {215}, deps_cells = {24, 30, 26, 38}},--WING_R_IN
	[37] = {critical_damage = 2,  args = {228}},--FLAP_L
	[38] = {critical_damage = 2,  args = {218}},--FLAP_R
	[39] = {critical_damage = 2,  args = {244}, deps_cells = {53}},--FIN_L_TOP
	[40] = {critical_damage = 2,  args = {241}, deps_cells = {54}},--FIN_R_TOP
	[43] = {critical_damage = 2,  args = {243}, deps_cells = {39, 53}},--FIN_L_BOTTOM
	[44] = {critical_damage = 2,  args = {242}, deps_cells = {40, 54}},--FIN_R_BOTTOM
	[51] = {critical_damage = 2,  args = {240}},--ELEVATOR_L
	[52] = {critical_damage = 2,  args = {238}},--ELEVATOR_R
	[53] = {critical_damage = 2,  args = {248}},--RUDDER_L
	[54] = {critical_damage = 2,  args = {247}},--RUDDER_R
	[56] = {critical_damage = 2,  args = {158}},--TAIL_LEFT_SIDE
	[57] = {critical_damage = 2,  args = {157}},--TAIL_RIGHT_SIDE
	[59] = {critical_damage = 3,  args = {148}},--NOSE_BOTTOM
	[61] = {critical_damage = 2,  args = {147}},--FUEL_TANK_F
	[82] = {critical_damage = 2,  args = {152}},--FUSELAGE_BOTTOM
	},
	
	DamageParts = 
	{  
		[1] = "VSN_JAS39Gripen-oblomok-wing-r", -- wing R
		[2] = "VSN_JAS39Gripen-oblomok-wing-l", -- wing L
--		[3] = "VSN_JAS39Gripen-oblomok-noise", -- nose
--		[4] = "VSN_JAS39Gripen-oblomok-tail-r", -- tail
--		[5] = "VSN_JAS39Gripen-oblomok-tail-l", -- tail
	},
-- VSN DCS World\Scripts\Aircrafts\_Common\Lights.lua

	lights_data = {
		typename = "collection",
		lights = {
			-- STROBES
			[WOLALIGHT_STROBES] = { 
					typename = "collection",
					lights = {	
						{typename = "natostrobelight", argument = 193, period = 1.2, phase_shift = 0, color = {0.9, 1.0, 0.7, 0.4}, connector = "BANO_0_BACK"},
						--{typename = "argnatostrobelight", argument = 193, period = 1.2, phase_shift = 0, color = {0.9, 1.0, 0.7, 0.4}, connector = "BANO_0_BACK"},
					}
			},
			-- SPOTS
			[WOLALIGHT_LANDING_LIGHTS] = { 
					typename = "collection",
					lights = {
						{ typename  = "argumentlight",	argument  = 208, },
					},
			},
			[WOLALIGHT_TAXI_LIGHTS] = { 
					typename = "collection",
					lights = {
						{ typename  = "argumentlight",	argument  = 209, },
					},
			},
			-- NAVLIGHTS
			[WOLALIGHT_NAVLIGHTS]	= {	
					typename = "collection", -- nav_lights_default
					lights = {
						{typename = "argumentlight",argument = 190}, -- Left Position(red)
						{typename = "argumentlight",argument = 191}, -- Right Position(green)
						{typename = "argumentlight",argument = 192}, -- Tail Position white)
					},
			},
			-- FORMATION
			[WOLALIGHT_FORMATION_LIGHTS] = { 
					typename = "collection",
					lights = {
						{typename  = "argumentlight" ,argument  = 200,},--formation_lights_tail_1 = 200;
					},
			},
	[WOLALIGHT_REFUEL_LIGHTS]	= {},-- REFUEL
	[WOLALIGHT_BEACONS]	= {},-- STROBE / ANTI-COLLISION
	[WOLALIGHT_CABIN_NIGHT]	= {},--
	}},
}

add_aircraft(VSN_JAS39Gripen) --AG


local function jas39_1100_ptb(clsid, center)
	local data = {
		category	= CAT_FUEL_TANKS,
		CLSID		= clsid,
		attribute	=  {wsType_Air,wsType_Free_Fall,wsType_FuelTank,WSTYPE_PLACEHOLDER},
		Picture		= "PTB.png",
		displayName	= _("VSN_JAS39 Zusatztank 1100 Liter"),
		Weight_Empty	= 50,
		Weight			= 1100,	-- 330 gallons, 6.8 lb/gal 
		Cx_pil		= 0.00141885432,		--1.2*0.001313754,			-- TODO
		shape_table_data = 
		{
			{
				name	= "jas39-1100-ptb";
				file	= "jas39-1100-ptb";
				life	= 1;
				fire	= { 0, 1};
				username	= "jas39-1100-ptb";
				index	= WSTYPE_PLACEHOLDER;
			},
		},
		Elements	= 
		{
			{
				ShapeName	= "jas39-1100-ptb",
			}, 
		}, 
	}
	declare_loadout(data)
end

jas39_1100_ptb("{jas39_1100_ptb}")


local function jas39_1700_ptb(clsid, center)
	local data = {
		category	= CAT_FUEL_TANKS,
		CLSID		= clsid,
		attribute	=  {wsType_Air,wsType_Free_Fall,wsType_FuelTank,WSTYPE_PLACEHOLDER},
		Picture		= "PTB.png",
		displayName	= _("VSN_JAS39 Zusatztank 1700 Liter"),
		Weight_Empty	= 50,
		Weight			= 1700,	-- 330 gallons, 6.8 lb/gal 
		Cx_pil		= 0.00141885432,		--1.2*0.001313754,			-- TODO
		shape_table_data = 
		{
			{
				name	= "jas39-1700-ptb";
				file	= "jas39-1700-ptb";
				life	= 1;
				fire	= { 0, 1};
				username	= "jas39-1700-ptb";
				index	= WSTYPE_PLACEHOLDER;
			},
		},
		Elements	= 
		{
			{
				ShapeName	= "jas39-1700-ptb",
			}, 
		}, 
	}
	declare_loadout(data)
end

jas39_1700_ptb("{jas39_1700_ptb}")