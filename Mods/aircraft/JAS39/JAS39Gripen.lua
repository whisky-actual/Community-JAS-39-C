--	=================== BK-27 SHELLS  ================================================================================
declare_weapon({category = CAT_SHELLS, name = "BK_27_HE", user_name = _("27 mm HE"),	
	model_name    = "tracer_bullet_yellow",
	v0    = 1025.0,
	Dv0   = 0.0040,
	Da0     = 0.00005,
	Da1     = 0.0,
	mass      = 0.26,
	round_mass = 0.516,
	explosive     = 0.119,
	life_time     = 5,
	caliber     = 27.0,
	s         = 0.0,
	j         = 0.0,
	l         = 0.0,
	charTime    = 0,
	cx        = {1,0.605,0.8,0.22,1.9},
	k1        = 6.3e-09,
	tracer_off    = -1,
	scale_tracer  = 1,
	scale_smoke	= 1.5,
	cartridge = 0,
});

	declare_weapon({category = CAT_SHELLS, name = "BK_27_AP", user_name = _("27 mm AP"),
	model_name    = "tracer_bullet_yellow",
	v0    = 1025.0,
	Dv0   = 0.0040,
	Da0     = 0.00005,
	Da1     = 0.0,
	mass      = 0.26,
	round_mass = 0.516,
	explosive     = 0.0,
	life_time     = 5,
	caliber     = 27.0,
	AP_cap_caliber = 15.0,
	s         = 0.0,
	j         = 0.0,
	l         = 0.0,
	charTime    = 0,
	cx        = {1,0.605,0.8,0.22,1.9},
	k1        = 6.3e-09,
	tracer_off    = -1,
	scale_tracer  = 1,
	scale_smoke	= 1.5,	  
	cartridge = 0,
});

	declare_weapon({category = CAT_SHELLS, name = "BK_27_APHE", user_name = _("27 mm APHE"),
	model_name    = "tracer_bullet_yellow",
	v0    = 1025.0,
	Dv0   = 0.0040,
	Da0     = 0.00005,
	Da1     = 0.0,
	mass      = 0.26,
	round_mass = 0.516,
	explosive     = 0.033,
	life_time     = 5,
	caliber     = 27.0,
	AP_cap_caliber = 10.0,
	s         = 0.0,
	j         = 0.0,
	l         = 0.0,
	charTime    = 0,
	cx        = {1,0.605,0.8,0.22,1.9},
	k1        = 6.3e-09,
	tracer_off    = -1,
	scale_tracer  = 1,
	scale_smoke	= 1.5,
	cartridge = 0,
});

	declare_weapon({category = CAT_SHELLS, name = "BK_27_PELE", user_name = _("27 mm PELE"),
	model_name    = "tracer_bullet_yellow",
	v0    = 1025.0,
	Dv0   = 0.0040,
	Da0     = 0.00005,
	Da1     = 0.0,
	mass      = 0.26,
	round_mass = 0.516,
	explosive     = 0.0,
	life_time     = 5,
	caliber     = 27.0,
	subcalibre = true,	
	AP_cap_caliber = 15.0,
	piercing_mass = 0.150,
	s         = 0.0,
	j         = 0.0,
	l         = 0.0,
	charTime    = 0,
	cx        = {1,0.605,0.8,0.22,1.9},
	k1        = 6.3e-09,
	tracer_off    = -1,
	scale_tracer  = 1,
	scale_smoke	= 1.5,
	cartridge = 0,
});

	declare_weapon({category = CAT_SHELLS, name = "BK_27_PELET", user_name = _("27 mm PELE-T"),
	model_name    = "tracer_bullet_yellow",
	v0    = 1025.0,
	Dv0   = 0.0040,
	Da0     = 0.00005,
	Da1     = 0.0,
	mass      = 0.26,
	round_mass = 0.516,
	explosive     = 0.0,
	life_time     = 5,
	caliber     = 27.0,
	subcalibre = true,
	AP_cap_caliber = 15.0,
	piercing_mass = 0.150,
	s         = 0.0,
	j         = 0.0,
	l         = 0.0,
	charTime    = 0,
	cx        = {1,0.605,0.8,0.22,1.9},
	k1        = 6.3e-09,
	tracer_off    = 2,
	scale_tracer  = 1,
	scale_smoke	= 1.5,
	cartridge = 0,
});

--	=================== BK-27 CANNON ================================================================================
local function bk27_cannon(tbl)

    tbl.category = CAT_GUN_MOUNT
    tbl.name =  "bk_27"
    tbl.display_name =  _("BK-27 Cannon")
    tbl.supply      =
    {
        shells = {"BK_27_HE", "BK_27_AP", "BK_27_APHE", "BK_27_PELE", "BK_27_PELET"},
        mixes  = { {1,2,3},{4,4,4,4,5} },
        count  = 120, -- corrected amount
    }
    if tbl.mixes then
       tbl.supply.mixes = tbl.mixes
       tbl.mixes        = nil
    end
    tbl.gun =
    {
        max_burst_length    = 10,
        rates               = {1700},
        recoil_coeff        = 0.7*1.3,
        barrels_count       = 1,
    }
    if tbl.rates then
       tbl.gun.rates        =  tbl.rates
       tbl.rates            = nil
    end

    tbl.ejector_pos             = {0, 0, 0}
    tbl.ejector_pos_connector   = "Gun_ejector"	
    tbl.ejector_dir             = {0, -1, 0}	
    tbl.supply_position         = {0,  0, 0}
    tbl.aft_gun_mount           = false
    tbl.effective_fire_distance = 2500
    tbl.drop_cartridge          = 203
    tbl.muzzle_pos              = {0,0,0}     -- all position from connector
    tbl.muzzle_pos_connector    = "Gun_point" -- all position from connector
    tbl.azimuth_initial         = 0
    tbl.elevation_initial       = 0
    tbl.smoke_dir               = {0, 0, 0}
    if  tbl.effects == nil then
        tbl.effects = {{ name = "FireEffect", arg = tbl.effect_arg_number or 350 },{name = "SmokeEffect", smoke_exhaust = "Gun_point" , add_speed = {10,0,0}}} 
    end
    return declare_weapon(tbl)
	
end

--	=================== PYLONS ===================================================================================

local tips 		= {
--	=================== INFRARED AIR TO AIR MISSILES =============================================================
	{ CLSID = "{JAS39_IRIS-T}", arg_value = 0.14, required = {{station = 10,loadout = {"{JAS39_ELINT}"}}, {station = 11,loadout = {"{JAS39_EWS39}"}}} }, -- IRIS-T
	{ CLSID = "{JAS39_AIM-9L}", attach_point_position = {0.1, 0.0, 0.0}, arg_value = 0.51, required = {{station = 10,loadout = {"{JAS39_ELINT}"}}, {station = 11,loadout = {"{JAS39_EWS39}"}}} }, -- AIM-9L
	{ CLSID = "{JAS39_A-DARTER}", attach_point_position = {-0.45, -0.025, 0.0}, arg_value = 0.16, required = {{station = 10,loadout = {"{JAS39_ELINT}"}}, {station = 11,loadout = {"{JAS39_EWS39}"}}} }, -- A-Darter
	{ CLSID = "{JAS39_AIM-9M}", attach_point_position = {0.1, 0.0, 0.0}, arg_value = 0.52, required = {{station = 10,loadout = {"{JAS39_ELINT}"}}, {station = 11,loadout = {"{JAS39_EWS39}"}}} }, -- AIM-9M
	{ CLSID = "{JAS39_AIM-9X}", attach_point_position = {0.1, 0.0, 0.0}, arg_value = 0.53, required = {{station = 10,loadout = {"{JAS39_ELINT}"}}, {station = 11,loadout = {"{JAS39_EWS39}"}}} }, -- AIM-9X	
	{ CLSID = "{JAS39_PYTHON-5}", attach_point_position = {-0.1, -0.12, 0.0}, arg_value = 0.15, required = {{station = 10,loadout = {"{JAS39_ELINT}"}}, {station = 11,loadout = {"{JAS39_EWS39}"}}} }, -- Python-5		
	{ CLSID = "{JAS39_ASRAAM}", attach_point_position = {0.1, -0.10, 0.0}, arg_value = 0.17, required = {{station = 10,loadout = {"{JAS39_ELINT}"}}, {station = 11,loadout = {"{JAS39_EWS39}"}}} }, -- AIM-132 ASRAAM	
	
--	=================== SMOKE ====================================================================================
	{ CLSID = "{AIS_ASQ_T50}", arg_increment = 0.0, attach_point_position = {0.30,  0.0,  0.0}},-- ACMI pod
    { CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E741}", arg_increment = 0.0}, -- Smoke blue
    { CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E742}", arg_increment = 0.0}, -- Smoke green
    { CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E743}", arg_increment = 0.0}, -- Smoke orange
    { CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E744}", arg_increment = 0.0}, -- Smoke red
    { CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E745}", arg_increment = 0.0}, -- Smoke white
    { CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E746}", arg_increment = 0.0}, -- Smoke yellow
}

local outboard 	= {
--	=================== INFRARED AIR TO AIR MISSILES ==============================================================
    { CLSID = "{JAS39_IRIS-T}", attach_point_position = {0.20, -0.14, 0.0}, arg_value = 0.14 },  -- IRIS-T
	{ CLSID = "{JAS39_AIM-9L}", attach_point_position = {0.25, 0.0, 0.0}, arg_value = 0.51 },    -- AIM-9L
	{ CLSID = "{JAS39_A-DARTER}", attach_point_position = {0.0, -0.14, 0.0}, arg_value = 0.16 }, -- A-Darter
	{ CLSID = "{JAS39_AIM-9M}", attach_point_position = {0.25, 0.0, 0.0}, arg_value = 0.52 }, -- AIM-9M
	{ CLSID = "{JAS39_AIM-9X}", attach_point_position = {0.25, 0.0, 0.0}, arg_value = 0.53 }, -- AIM-9X
	{ CLSID = "{JAS39_PYTHON-5}", attach_point_position = {0.1, -0.23, 0.0}, arg_value = 0.15 }, -- Python-5	
	{ CLSID = "{JAS39_ASRAAM}", attach_point_position = {0.40, -0.23, 0.0}, arg_value = 0.17 }, -- AIM-132 ASRAAM
	
--	=================== BVR AIR TO AIR MISSILES ==============================================================	
	{ CLSID = "{JAS39_Meteor}", attach_point_position = {0.4, -0.12, 0.0}, arg_value = 0.22 }, -- Meteor
	{ CLSID = "{JAS39_AIM120B}" ,arg_value = 0.18, attach_point_position = {0.30, -0.13, 0.0}},   -- AIM-120B
	{ CLSID = "{JAS39_AIM120C5}" ,arg_value = 0.19, attach_point_position = {0.30, -0.13, 0.0}},  -- AIM-120C-5
	{ CLSID = "{JAS39_AIM120C7}" ,arg_value = 0.20, attach_point_position = {0.30, -0.13, 0.0}},  -- AIM-120C-7
	{ CLSID = "{JAS39_Derby}", attach_point_position = {0.1, -0.23, 0.0}, arg_value = 0.21 }, -- I-Derby ER		

--	=================== UNGUIDED BOMBS ============================================================================
	{ CLSID = "{JAS39_MK82}", arg_value = 0.69 }, -- Mk-82
	{ CLSID = "{JAS39_MK83}", arg_value = 0.70 }, -- Mk-83
	{ CLSID = "{JAS39_BRU33_MK82}", arg_value = 0.69, Type = 1}, -- Mk-82 x 2	
	{ CLSID = "{JAS39_M71LD}", attach_point_position = {-0.70, 0.0, 0.0}, arg_value = 0.68 }, -- M71 x 4
		
--	=================== UNGUIDED ROCKETS ==========================================================================
    { CLSID = "{JAS39_M70BHE}", attach_point_position = {-0.1, 0.0, 0.0}, arg_value = 0.64}, -- M70B HE 
	{ CLSID = "{JAS39_M70BAP}", attach_point_position = {-0.1, 0.0, 0.0}, arg_value = 0.63}, -- M70B AP

}

local inboard 	= {
--	=================== INFRARED AIR TO AIR MISSILES ==============================================================
    { CLSID = "{JAS39_AIM-9L}", attach_point_position = {0.25, 0.0, 0.0}, arg_value = 0.51 },    -- AIM-9L
	{ CLSID = "{JAS39_IRIS-T}", attach_point_position = {0.20, -0.14, 0.0}, arg_value = 0.14 },  -- IRIS-T
	{ CLSID = "{JAS39_A-DARTER}", attach_point_position = {0.0, -0.14, 0.0}, arg_value = 0.16 }, -- A-Darter
	{ CLSID = "{JAS39_AIM-9M}", attach_point_position = {0.25, 0.0, 0.0}, arg_value = 0.52 }, -- AIM-9M
	{ CLSID = "{JAS39_AIM-9X}", attach_point_position = {0.25, 0.0, 0.0}, arg_value = 0.53 }, -- AIM-9X	
	{ CLSID = "{JAS39_PYTHON-5}", attach_point_position = {0.15, -0.23, 0.0}, arg_value = 0.15 }, -- Python-5
	{ CLSID = "{JAS39_ASRAAM}", attach_point_position = {0.30, -0.23, 0.0}, arg_value = 0.17 }, -- AIM-132 ASRAAM
	
--	=================== BVR AIR TO AIR MISSILES ==============================================================	
	{ CLSID = "{JAS39_Meteor}", attach_point_position = {0.0, -0.12, 0.0}, arg_value = 0.22 }, -- Meteor
	{ CLSID = "{JAS39_AIM120B}" ,arg_value = 0.18, attach_point_position = {-0.1, -0.13, 0.0}},   -- AIM-120B
	{ CLSID = "{JAS39_AIM120C5}" ,arg_value = 0.19, attach_point_position = {-0.1, -0.13, 0.0}},  -- AIM-120C-5
	{ CLSID = "{JAS39_AIM120C7}" ,arg_value = 0.20, attach_point_position = {-0.1, -0.13, 0.0}},  -- AIM-120C-7
	{ CLSID = "{JAS39_Derby}", attach_point_position = {-0.3, -0.23, 0.0}, arg_value = 0.21 }, -- I-Derby ER		
	
--	=================== UNGUIDED BOMBS ============================================================================
	{ CLSID = "{JAS39_MK82}", arg_value = 0.69 }, -- Mk-82
	{ CLSID = "{JAS39_MK83}", arg_value = 0.70 }, -- Mk-83
	{ CLSID = "{JAS39_MK84}", arg_value = 0.71 }, -- Mk-84
	{ CLSID = "{JAS39_BRU33_MK82}", arg_value = 0.69, Type = 1}, -- Mk-82 x 2	
	{ CLSID = "{JAS39_BRU33_MK83}", arg_value = 0.70, Type = 1}, -- Mk-83 x 2		
	{ CLSID = "{JAS39_M71LD}", attach_point_position = {-0.70, 0.0, 0.0}, arg_value = 0.68 }, -- M71LD x 4

--	=================== UNGUIDED ROCKETS ==========================================================================
	{ CLSID = "{JAS39_M70BHE}", attach_point_position = {-0.1, 0.0, 0.0}, arg_value = 0.64}, -- M70B HE 
	{ CLSID = "{JAS39_M70BAP}", attach_point_position = {-0.1, 0.0, 0.0}, arg_value = 0.63}, -- M70B AP	
	
--	=================== DROP TANKS ================================================================================
    { CLSID = "{JAS39_TANK1100}", arg_value = 0.90 }, -- Drop tank 1100 litre				
	-- { CLSID = "{JAS39_TANK1700}", arg_value = 0.91 }, -- Drop tank 1700 litre

}

local fuselageLeft	= {
	--
}

local fuselageRight	= {
--	=================== PODS =====================================================================================
	{ CLSID = "{JAS39_Litening}", arg_value = 0.86, required = {{station = 9,loadout = {"{JAS39_FLIR}"}}} },

}

local centerline 	= {
--	=================== UNGUIDED BOMBS ============================================================================
	-- { CLSID = "{JAS39_MK82}", arg_value = 0.69 }, -- Mk-82
	-- { CLSID = "{JAS39_MK83}", arg_value = 0.70 }, -- Mk-83
	-- { CLSID = "{JAS39_MK84}", arg_value = 0.71 }, -- Mk-84
	-- { CLSID = "{JAS39_BRU33_MK82}", arg_value = 0.69, Type = 1}, -- Mk-82 x 2	
	-- { CLSID = "{JAS39_BRU33_MK83}", arg_value = 0.70, Type = 1}, -- Mk-83 x 2	
	-- { CLSID = "{JAS39_M71LD}", attach_point_position = {-0.50, 0.0, 0.0}, arg_value = 0.68 }, -- M71 x 4

--	=================== DROP TANKS ================================================================================
    { CLSID = "{JAS39_TANK1100}", arg_value = 0.90 }, -- Drop tank 1100 litre
	
}

JAS39Gripen =  {
      
		Name 			= 'JAS39Gripen',
		DisplayName		= _('JAS 39 Gripen A/A'),
        Picture 		= "JAS39Gripen.png",
        Rate 			= "50",
        Shape			= "JAS39Gripen",
        WorldID			=  WSTYPE_PLACEHOLDER, 

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
    },
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
    },   
		
	shape_table_data 	= 
	{
		{
			file  	 	= 'JAS39Gripen';
			life  	 	= 20; -- lifebar
			vis   	 	= 3; -- visibility gain.
			desrt    	= 'JAS39Gripen-oblomok'; -- Name of destroyed object file name
			fire  	 	= { 300, 2}; 			-- Fire on the ground after destoyed: 300sec 2m
			username	= 'JAS39Gripen';
			index       =  WSTYPE_PLACEHOLDER;
			classname   = "lLandPlane";
			positioning = "BYNORMAL";
		},
		{
			name  		= "JAS39Gripen-oblomok";
			file  		= "JAS39Gripen-oblomok";
			fire  		= { 240, 2};
		},
	},
	
	net_animation ={  
		0, -- front gear
		2, -- nose wheel steering
		3, -- right gear
		5, -- left gear
		38, -- canopy
		89, -- engine nozzle 
		134, -- nose wheel damage
        135, -- main wheel damage
        136,  -- main wheel damage	
		182, -- left and right air brake
		182, -- left and right air brake
		190, -- left front red navigation light
		191, -- right front green navigation light
		192, -- rear white navigation lights
		193, -- rear tail fin anticollision light
		200, -- formation lights
		201, -- wingtip lights
		208, -- landing lights
		209, -- taxi lights
		479, -- canard right
		480, -- canard left
		478, -- lef left	
		477, -- lef right
        484, -- elevon outer left	
        485, -- elevon inner left
        486, -- elevon inner right
        487, -- elevon outer right
		488, -- rudder
		498, -- gear bay doors
		499  -- wheel chocks and ladder
	}, 
	

	mapclasskey 		= "P0091000024",
	attribute  			= {wsType_Air, wsType_Airplane, wsType_Fighter, WSTYPE_PLACEHOLDER, wsType_Battleplane, "Fighters", "Refuelable", "Datalink", "Link16",},
	Categories= {"{78EFB7A2-FD52-4b57-A6A6-3BF0E1D6555F}", "Interceptor",},
	
		M_empty						=	6880,	-- kg  with pilot and nose load, JAS 39C
		M_nominal					=	9430,	-- kg (Empty Plus Full Internal Fuel)
		M_max						=	14000,	-- kg (Maximum Take Off Weight)
		M_fuel_max					=	2550,	-- kg (Internal Fuel Only)
		H_max						=	16000,	-- m  (Maximum Operational Ceiling)
		average_fuel_consumption	=	0.021,
		CAS_min						=	58,		-- Minimum CAS speed (m/s) (for AI)
		V_opt						=	220,	-- Cruise speed (m/s) (for AI)
		V_take_off					=	61,		-- Take off speed in m/s (for AI)
		V_land						=	66,		-- Land speed in m/s (for AI) 66
		has_afteburner				=	true,
		has_speedbrake				=	true,
		radar_can_see_ground		=	true,

		nose_gear_pos 				                = {4.488,	-2.045,	0},   -- nosegear coord 
	    nose_gear_amortizer_direct_stroke   		=  0.05,      -- down from nose_gear_pos !!!
	    nose_gear_amortizer_reversal_stroke  		=  -0.4,  -- up
	    nose_gear_amortizer_normal_weight_stroke 	=  -0.27,   -- up 
	    nose_gear_wheel_diameter 	                =   1.0, -- in m
	
	    main_gear_pos 						 	    = {-0.800,	-1.96,	1.25}, -- main gear coords -1.95
	    main_gear_amortizer_direct_stroke	 	    =   0,     --  down from main_gear_pos !!!
	    main_gear_amortizer_reversal_stroke  	    =   -0.228, --  up 
	    main_gear_amortizer_normal_weight_stroke    =   -0.114,-- down from main_gear_pos
	    main_gear_wheel_diameter 				    =   1.0, -- in m

		AOA_take_off				=	0.16,	-- AoA in take off (for AI)
		stores_number				=	12,
		bank_angle_max				=	60,		-- Max bank angle (for AI)
		Ny_min						=	-3,		-- Min G (for AI)
		Ny_max						=	9,		-- Max G (for AI)
		V_max_sea_level				=	403,	-- Max speed at sea level in m/s (for AI)
		V_max_h						=	736.11,	-- Max speed at max altitude in m/s (for AI)
		wing_area					=	30,	-- wing area in m2
		thrust_sum_max				=	5200,	-- thrust in kgf (54.0 kN)
		thrust_sum_ab				=	8566,	-- thrust in kgf (81.0 kN)
		Vy_max						=	275,	-- Max climb speed in m/s (for AI)
		flaps_maneuver				=	1.0,
		Mach_max					=	2.5,	-- Max speed in Mach (for AI)
		range						=	2540,	-- Max range in km (for AI)
		RCS							=	1.5,		-- Radar Cross Section m2 -- Changed from 1.0, that was overpowered
		Ny_max_e					=	9,		-- Max G (for AI)
		detection_range_max			=	350,
		IR_emission_coeff			=	0.45,	-- Normal engine -- IR_emission_coeff = 1 is Su-27 without afterburner. It is reference.
		IR_emission_coeff_ab		=	1.50,		-- With afterburner
		tand_gear_max				=	0.84,--XX  1.732 FA18 3.73, old 3.73 very much too high 3.73
		tanker_type					=	2,--F14=2/S33=4/ M29=0/S27=0/F15=1/ F16=1/To=0/F18=2/A10A=1/ M29K=4/F4=0/
		wing_span					=	8.40,	--XX  wing span in m
		wing_type 					= 	0,		-- 0=FIXED_WING/ 1=VARIABLE_GEOMETRY/ 2=FOLDED_WING/ 3=ARIABLE_GEOMETRY_FOLDED
		length						=	14.1,
		height						=	4.5,
		crew_size					=	1, --XX
		engines_count				=	1, --XX
		wing_tip_pos 				= 	{-3.404,	-0.164,	4.05},
		
		EPLRS 						= true,
		TACAN_AA					= true,
		mechanimations = {
            Door0 = {
                {Transition = {"Close", "Open"},  Sequence = {{C = {{"Arg", 38, "to", 0.9, "in", 8.0},},},}, Flags = {"Reversible"},},
                {Transition = {"Open", "Close"},  Sequence = {{C = {{"Arg", 38, "to", 0.0, "in", 8.0},},},}, Flags = {"Reversible", "StepsBackwards"},},
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
				diameter    =   1.05,-- AFB cone diameter   Kreis Ø --1.0
                exhaust_length_ab   =   10,--lenght in m  Kreis Ø kegel efekt
                exhaust_length_ab_K =   0.707,--animation geschwindigkeit
                smokiness_level     =   0.01, --0.05
				afterburner_circles_count = 11,
				afterburner_circles_pos = {0.2, 0.8},
				afterburner_circles_scale = 0.95,
				afterburner_effect_texture = "afterburner_gripen",
			}, -- end of [1]
		}, -- end of engines_nozzles		
		crew_members = 
        {
            [1] = 
            {
                    ejection_seat_name    =    17,
                    drop_canopy_name    =    "jas39gripen-fonar",
                    pos =     {3.9,    1.4,    0},
                    ejection_order         = 1,
                    canopy_arg          = 38, 
                    can_be_playable     = true,
                    ejection_added_speed = {-5,15,0},
                    role                  = "pilot",
                    role_display_name    = _("Pilot"),
					g_suit              = 5,
             }, -- end of [1]
            [2] = 
            {
            },-- end of [2]
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
			{effect = "OVERWING_VAPOR", file = current_mod_path.."/Effects/JAS39Gripen_overwingVapor.lua"},
		},
		
		chaff_flare_dispenser = 
		{
		[1] = { dir = {0, 1.0, 0}, pos = {-3.25, 0.35, 0.8}, },
        [2] = { dir = {0, -1.0, 0}, pos = {-3.25, 0.35, 0.8}, },
        [3] = { dir = {0, -1.0, 0}, pos = {-3.25, 0.35, 0.8}, },
        [4] = { dir = {0, 1.0, 0}, pos = {-3.25, 0.35, 0.8}, }, 
		}, -- end of chaff_flare_dispenser  

        -- Countermeasures
passivCounterm 		= {
CMDS_Edit 			= true,
SingleChargeTotal 	= 120,
chaff 				= {default = 80, increment = 40, chargeSz = 1},
flare 				= {default = 40, increment = 20, chargeSz = 1}
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

Guns = {
        bk27_cannon({muzzle_pos_connector   = "GUN_POINT",
            supply_position        = {2.6, -0.4, 0.0},
            -- drop_cartridge         = 204,
            ejector_pos_connector  = "GUN_EJECTOR_01",
            ejector_dir            = {2,-2,0},
			elevation_initial = 0.0,
            -- elevation_initial = -1.50,
        }),
		
		},
    				
		ammo_type_default = 2,
		ammo_type ={
			_("HE/AP/APHE"),
			_("PELE/PELE-T"),				
		},

--pylons_enumeration = {1, 11, 10, 2, 3, 9, 4, 8, 5, 7, 6},

		Pylons =     {

        pylon(1, 0, 0, 0, 0,
			{
				arg = 308,
				arg_value = 0.5,				
				DisplayName = "1",
  				use_full_connector_position = true,
				connector = "Pylon1",	--Wing tip left
			},
			tips
		),
        pylon(2, 0, 0, 0, 0,
			{
				arg = 309,
				arg_value = 0.5,
				DisplayName = "2",
				use_full_connector_position = true,
				connector = "Pylon2",	--Outer left
			},
			
			outboard
		),
        pylon(3, 0, 0, 0, 0,
			{
				arg = 310,
				arg_value = 0.5,
				DisplayName = "3",
				use_full_connector_position = true,
				connector = "Pylon3",	--inner left
			},
			inboard
		),
        pylon(4, 1, 0, 0, 0,
			{
				arg = 313,
				arg_value = 0,
				DisplayName = "4",
				use_full_connector_position = true,
				connector = "Pylon6",		--Centerline
			},
			centerline
		),
        pylon(5, 1, 0, 0, 0,
            {
				arg = 315,
				arg_value = 0,
				DisplayName = "5",--6
            	use_full_connector_position = true,
				connector = "Pylon7",		--cheek
			},
			fuselageRight
		),
        pylon(6, 0, 0, 0, 0,
			{
				arg = 316,
				arg_value = 0.5,
				DisplayName = "6",
				use_full_connector_position = true,
				connector = "Pylon9",		--inner right
			},
			
			inboard
		),
        pylon(7, 0, 0, 0, 0,
			{
				arg = 317,
				arg_value = 0.5,
				DisplayName = "7",
				use_full_connector_position = true,
				connector = "Pylon10",		--outer right
			},
			outboard
		),
		pylon(8, 0, 0, 0, 0,
			{
				arg = 318,
				arg_value = 0.5,				
				DisplayName = "8",
				use_full_connector_position = true,
				connector = "Pylon11",	--Wing tip right
			},
			tips
		),
		pylon(9, 2, 0, 0, 0,--26
			{
				arg = 319,
				arg_value = 0,
				DisplayName = "FLIR",
				use_full_connector_position = true,
				connector = "Pylon12",		--LDP FLIR
			},
			{	
				{ CLSID = "{JAS39_FLIR}" }, -- Litening Laser Designator Pod FLIR
			}
		),
        pylon(10, 2, 0, 0, 0,--26
			{
				arg = 312,
				arg_value = 0,
				DisplayName = "ELINT",
				use_full_connector_position = true,
				connector = "Pylon5",		--integrated Elint
			},
			{
				{ CLSID = "{JAS39_ELINT}",attach_point_position = {0, 0 ,0 } },-- ELINT
			}
		),	
		pylon(11, 2, 0, 0, 0,--26
			{
				arg = 314,
				arg_value = 0,
				DisplayName = "ECM",
				use_full_connector_position = true,
				connector = "Pylon8",		--integrated Ecm
			},
			{	
				{ CLSID = "{JAS39_EWS39}" }, -- EWS39 Integrated ECM
			}
		),		
},
	
	Tasks = {
        aircraft_task(Intercept), -- 10
        aircraft_task(CAP), -- 11
        aircraft_task(Reconnaissance), -- 17
        aircraft_task(Escort), -- 18
        aircraft_task(FighterSweep), -- 19									
    },	
	DefaultTask = aircraft_task(FighterSweep),

SFM_Data = {
        aerodynamics = { -- Cx = Cx_0 + Cy^2*B2 +Cy^4*B4
            Cy0        = 0,      -- zero AoA lift coefficient
            Mzalfa     = 5.5,  -- coefficients for pitch agility
            Mzalfadt   = 0.8,    -- coefficients for pitch agility
            kjx        = 4.20,		--- roll inertia
            kjz        = 0.00125,	--- pitch inertia
            Czbe       = -0.016, -- coefficient, along Z axis (perpendicular), affects yaw, negative value means force orientation in FC coordinate system
            cx_gear    = 0.08,    -- coefficient, drag, gear
            cx_flap    = 0.010,   -- coefficient, drag, full flaps
            cy_flap    = 0.56,    -- coefficient, normal force, lift, flaps
            cx_brk     = 0.12,   -- coefficient, drag, breaks
            table_data = {
                  --  	 Mach    Cx0   		 Cya     B    		 B4     Omxmax   Aldop      Cymax
					{ 0.000,	 0.0470,	0.078,	0.0310,		 0.19,	 0.68,	 25.000,	 1.14 },
					{ 0.050, 	 0.0475, 	0.078, 	0.0310, 	 0.19, 	 0.95, 	 25.000, 	 1.15 }, 
					{ 0.100, 	 0.0475, 	0.078, 	0.0310, 	 0.19, 	 1.20, 	 25.000, 	 1.16 },
					{ 0.200,	 0.0475,	0.078,	0.0295,		 0.19,	 2.15,	 25.000,	 1.170 },
					{ 0.300,	 0.0475,	0.076,	0.0295,		 0.19,	 2.80,	 25.000,	 1.177 },
					{ 0.400,	 0.0454,	0.075,	0.0280,		 0.15,	 3.70, 	 25.000,	 1.184 },
					{ 0.500,	 0.0430,	0.074,	0.0250,		 0.11,	 4.45, 	 25.000,	 1.192 },
					{ 0.600,	 0.0410,	0.073,	0.0250,		 0.11,	 4.55,	 25.000,	 1.200 },
					{ 0.700,	 0.0390,	0.070,	0.0290,		 0.11,	 4.55,	 25.000,	 1.200 },
					{ 0.800,	 0.0380,	0.068,	0.0318,		 0.13,	 4.50,	 25.000,	 1.200 },
					{ 0.850,	 0.0370,	0.065,	0.0348,		 0.16,	 4.47,	 25.000,	 1.210 },
					{ 0.900,	 0.0370,	0.055,	0.0370,		 0.16,	 4.45,	 25.000,	 1.220 },
																							
					{ 1.000,	 0.0370,	0.053,	0.0400, 	 0.16,	 4.10, 	 25.000,	 9.300 },
					{ 1.050,	 0.0370,	0.052,	0.0428,		 0.16,	 4.07,	 25.000,	 9.300 },
					{ 1.100,	 0.0370,	0.050, 	0.0459, 	 0.16,	 4.05,	 25.000,	 9.300 },
					{ 1.200,	 0.0370,	0.049, 	0.0500, 	 0.15,	 4.00, 	 25.000,	 9.300 },
					{ 1.300,	 0.0370,	0.049, 	0.0529, 	 0.15,	 3.97,	 25.000,	 9.300 },
					{ 1.500,	 0.0372,	0.049, 	0.0569, 	 0.14,	 3.84,	 25.000,	 9.300 },
					{ 1.700,	 0.0375,	0.048, 	0.0600, 	 0.13,	 3.76,	 25.000,	 9.300 },
					{ 1.850,	 0.0377,	0.048, 	0.0629, 	 0.12,	 3.69,	 25.000,	 9.300 },
					{ 2.000,	 0.0384,	0.048, 	0.0659, 	 0.12,	 3.56,	 25.000,	 9.300 },
					{ 2.200,	 0.0390,	0.048, 	0.0689, 	 0.12, 	 3.45,	 25.000,	 9.300 }, 
																								
					{ 2.400,	 0.3300,	0.090, 	1.149, 		 1.69,	 0.70,	 25.000,	 9.300 },
					{ 2.500,	 0.6900,	0.040, 	1.35,		 1.10,	 0.70,	 25.000,	 9.300 },
					{ 3.900,	 0.6900,	0.040, 	1.35,		6.380,	 0.70,	 25.000, 	 9.300 },
            }, -- end of table
            -- M    - Mach number
            -- Cx0    - Coefficient, drag, profile, of the airplane
            -- Cya    - Normal force coefficient of the wing and body of the aircraft in the normal direction to that of flight. Inversely proportional to the available G-loading at any Mach value. (lower the Cya value, higher G available) per 1 degree AOA
            -- B    - Polar quad coeff
            -- B4    - Polar 4th power coeff
            -- Omxmax    - roll rate, rad/s
            -- Aldop    - Alfadop Max AOA at current M - departure threshold
            -- Cymax    - Coefficient, lift, maximum possible (ignores other calculations if current Cy > Cymax)
        }, -- end of aerodynamics

        engine = {
            Nmg        = 60.05,    -- RPM at idle
            MinRUD     = 0,    -- Min state of the throttle
            MaxRUD     = 1,    -- Max state of the throttle
            MaksRUD    = 0.85,    -- Military power state of the throttle
            ForsRUD    = 0.91,    -- Afterburner state of the throttle
            typeng     = 1,
                --[[
                    E_TURBOJET = 0
                    E_TURBOJET_AB = 1
                    E_PISTON = 2
                    E_TURBOPROP = 3
                    E_TURBOFAN    = 4
                    E_TURBOSHAFT = 5
                --]]
            hMaxEng    = 17,        -- Max altitude for safe engine operation in km
            dcx_eng    = 0.0124,    -- Engine drag coeficient
            cemax      = 1.24,      -- not used for fuel calulation , only for AI routines to check flight time ( fuel calculation algorithm is built in )
            cefor      = 2.56,      -- not used for fuel calulation , only for AI routines to check flight time ( fuel calculation algorithm is built in )
            dpdh_m     = 2500,      --  altitude coefficient for max thrust. Higher value means lower thrust at high altitudes
            dpdh_f     = 2500,      --  altitude coefficient for AB thrust
            table_data = {
            --            M     Pmax    	 Pfor
                [1]  =  { 0.00, 44453*1.45,  75230 },
                [2]  =  { 0.20, 43262*1.40,  75230 },
                [3]  =  { 0.30, 44896*1.33,  75230 },
                [4]  =  { 0.40, 45535*1.33,  81230 },
                [5]  =  { 0.50, 47803*1.33,  85230 },
                [6]  =  { 0.60, 49979*1.33,  85230 },
                [7]  =  { 0.70, 51133*1.33,  97896 },
                [8]  =  { 0.80, 52093*1.33,  98147 },
                [9]  =  { 0.97, 49117*1.0,  99727 },
                [10] =  { 1.00, 49651*0.8,  100451 },
                [11] =  { 1.05, 48569*0.9,  111151 },
                [12] =  { 1.10, 43486*0.9,  111121 },
                [13] =  { 1.15, 40698*0.9,  115076 },
                [14] =  { 1.20, 36910*0.9,  117101 },
                [15] =  { 1.30, 33933*0.9,  118449 },
                [16] =  { 1.40, 32150*0.9,  113915 },
                [17] =  { 1.50, 30362*0.9,  110733 },
                [18] =  { 1.60, 28579*0.9,  110436 },
                [19] =  { 1.70, 26791*0.9,  114836 },
                [20] =  { 1.85, 25003*0.9,  114436 },
                [21] =  { 1.90, 24220*0.9,  110917 },
				[22] =  { 2.00, 23220*0.9,  109117 },
                [23] =  { 2.20, 19649*0.9,  98079 },
				[24] =  { 3.90, 16649*0.9,  61279 },
            }, -- end of table_data
            -- M    - Mach number
            -- Pmax    - Engine thrust at military power
            -- Pfor    - Engine thrust at AFB
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
	[39] = {critical_damage = 2,  args = {244}}, --FIN_L_TOP  
	[40] = {critical_damage = 2,  args = {241}, deps_cells = {54}},--FIN_R_TOP
	[43] = {critical_damage = 2,  args = {243}, deps_cells = {39, 53}},--FIN_L_BOTTOM
	[44] = {critical_damage = 2,  args = {242}, deps_cells = {40, 54}},--FIN_R_BOTTOM
	[51] = {critical_damage = 2,  args = {240}},--ELEVATOR_L
	[52] = {critical_damage = 2,  args = {238}},--ELEVATOR_R
	[53] = {critical_damage = 2,  args = {248}}, --RUDDER_L
	[54] = {critical_damage = 2,  args = {247}},--RUDDER_R
	[56] = {critical_damage = 2,  args = {158}},--TAIL_LEFT_SIDE
	[57] = {critical_damage = 2,  args = {157}},--TAIL_RIGHT_SIDE
	[59] = {critical_damage = 3,  args = {148}},--NOSE_BOTTOM
	[61] = {critical_damage = 2,  args = {147}},--FUEL_TANK_F
	[82] = {critical_damage = 2,  args = {152}},--FUSELAGE_BOTTOM
	},
	
	DamageParts = 
	{  
		[1] = "JAS39Gripen-oblomok-wing-r", -- wing R
		[2] = "JAS39Gripen-oblomok-wing-l", -- wing L
	},
-- DCS World\Scripts\Aircrafts\_Common\Lights.lua

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
			-- SPOTS -- LANDING LIGHTS AND TAXI LIGHTS ARE SWAPPED TO FIT THE GRIPEN SETUP
			[WOLALIGHT_LANDING_LIGHTS] = { 
					typename = "collection",
					lights = {
						{ typename  = "argumentlight",	argument  = 209, },
					},
			},
			[WOLALIGHT_TAXI_LIGHTS] = { 
					typename = "collection",
					lights = {
						{ typename  = "argumentlight",	argument  = 208, },
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

add_aircraft(JAS39Gripen) --AA


