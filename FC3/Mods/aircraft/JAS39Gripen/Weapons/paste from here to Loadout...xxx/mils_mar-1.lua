local name = 'MAR-1'
local mass = 350.0
local pylon_mass = 1.0
local pylon_dual_mass = 1.0

local MAR_warhead = 
{
    mass                 = 90, 
    caliber              = 231,
    expl_mass            = 90,
    piercing_mass        = 0.0,					
    other_factors        = { 1.0, 1.0, 1.0 },	
    concrete_factors     = { 1.0, 1.0, 1.0 },
    concrete_obj_factor  = 1.0,
    obj_factors          = { 2.0, 1.0 },
    cumulative_factor    = 2.0,
    cumulative_thickness = 0.0, 
}


  MAR_ARM = {
        category        = CAT_MISSILES,
        name            = name,
        model           = 'mar-1',
        user_name       = _(name),
        wsTypeOfWeapon  = {4,4,8,WSTYPE_PLACEHOLDER},
        mass            = mass,

        Escort          = 0,
        Head_Type       = 3,
        sigma           = {10, 10, 10},
        M               = mass,
        H_max           = 35000.0,
        H_min           = -1.0,
        Diam            = 231.0,
        Cx_pil          = 2,
        D_max           = 100000.0,
        D_min           = 700.0,
        Head_Form       = 1,
        Life_Time       = 200.0,
        Nr_max          = 25,
        v_min           = 140.0,
        v_mid           = 900.0,
        Mach_max        = 4.0,
        t_b             = 0.0,
        t_acc           = 3.0,
        t_marsh         = 5.0,
        Range_max       = 100000.0,
        H_min_t         = 1.0,
        Fi_start        = 0.5236,
        Fi_rak          = 3.14152,
        Fi_excort       = 1.05,
        Fi_search       = 1.05,
        OmViz_max       = 0.52,
        exhaust         = { 1, 1, 1, 0.5 },
        X_back          = -1.3,
        Y_back          = -0.50,
        Z_back          = 0.0,
        Reflection      = 0.0329,
        KillDistance    = 7.0,
		
		
		class_name      = "wAmmunitionSelfHoming",
        scheme          = "anti_radiation_missile2",

        shape_table_data = {
            {
                name     = name,
                file     = 'mar-1',
                life     = 1,
                fire     = {0, 1},
                username = name,
                index    = WSTYPE_PLACEHOLDER,
            },
        },
		
		fm = {
            mass        = mass,
            caliber     = 0.231,
            cx_coeff    = {1, 0.4, 1.1, 0.5, 1.4},
            L           = 3.8,
            I           = 1 / 12 * mass * 3.8 * 3.8,
            Ma          = 0.3,
            Mw          = 1.116,
            wind_sigma  = 0.0,
            wind_time   = 0.0,
            Sw          = 0.85,
            dCydA       = {0.07, 0.036},
            A           = 0.36,
            maxAoa      = 0.28,
            finsTau     = 0.1,

            Ma_x        = 0.001,
            Kw_x        = 0.001,
            I_x         = 50,
        },
		
		   start_helper = {
            delay               = 0.2,
            power               = 0.02,
            time                = 2,
            use_local_coord     = 0,
            max_vel             = 200,
            max_height          = 400,
            vh_logic_or         = 1,
        },
		
		autopilot = {
            K                = 100.0,
            Kg               = 6.0,
            Ki               = 0.0,
            finsLimit        = 0.22,
            useJumpByDefault = 0,
            J_Power_K        = 1.2,
            J_Diff_K         = 0.0,
            J_Int_K          = 0.0,
            J_Angle_K        = math.rad(12),
            J_FinAngle_K     = math.rad(18),
            J_Angle_W        = 3.5,
            delay            = 1.0,
        },

		 radio_seeker = {
            FOV                 = math.rad(5),
            op_time             = 185,
            keep_aim_time       = 8,
            pos_memory_time     = 60,
            sens_near_dist      = 200.0,
            sens_far_dist       = 60000.0,
            err_correct_time    = 1.0,
            err_val             = 0.001,
            calc_aim_dist       = 500000,
            blind_rad_val       = 0.2,
            blind_ctrl_dist     = 1000,
            aim_y_offset        = 2.0,
            min_sens_rad_val    = 0.00025,
        },
		
		simple_gyrostab_seeker = {
            omega_max = math.rad(8)
        },
		
	    fuze_proximity = {
            ignore_inp_armed    = 1,
            arm_delay           = 10,
            radius              = 10,
        },
		
		
		booster = {
		impulse								= 260,
		fuel_mass							= 150.18,
		work_time							= 12.0,
		boost_time							= 20,
		boost_factor						= 0,
		nozzle_position						= {{-2.0, -0.1, -0.0}},
		nozzle_orientationXYZ				= {{0.0, 0.0, 0.0}},
		tail_width							= 0.4,
		smoke_color							= {1.0, 1.0, 1.0},
		smoke_transparency					= 0.9,
		custom_smoke_dissipation_factor		= 0.2,	
		
		},

        march = {
            impulse                             = 205,
            fuel_mass                           = 100,
            work_time                           = 15,
            boost_time                          = 0,
            boost_factor                        = 0,
            nozzle_position                     = {{-2.0, -0.1, -0.0}},
            nozzle_orientationXYZ               = {{0.0, 0.0, 0.0}},
            tail_width                          = 0.3,
            smoke_color                         = {0.6, 0.6, 0.6},
            smoke_transparency                  = 0.8,
            custom_smoke_dissipation_factor     = 0.2,
        }, 
		
		controller = {
           boost_start = 0.5,
		   march_start = 0.5,
		   --suppres_march = 1.0,
        },


		
		 warhead     = MAR_warhead, -- HE_penetrating_warhead(70,203),
         warhead_air = MAR_warhead, -- HE_penetrating_warhead(70,203),

    }


declare_weapon(MAR_ARM)


declare_loadout({
    category    = CAT_MISSILES,
    CLSID       = 'DIS_LD-10',
    Picture     = 'mar-1.png',
    attribute   = MAR_ARM.wsTypeOfWeapon,
    displayName = _(name),
    Cx_pil      = 0.000859765625,
    Count       = 1,
    Weight      = mass + pylon_mass,
    Elements    = {
        [1] =
        {
            Position  = {0, 0, 0},
            ShapeName = 'mar-1',
        },
    }, -- end of Elements
})

declare_loadout({
    category       = CAT_MISSILES,
    CLSID          = 'DIS_LD-10_DUAL_L',
    Picture        = 'mar-1.png',
    wsTypeOfWeapon = MAR_ARM.wsTypeOfWeapon,
    attribute      = {4,4,32,WSTYPE_PLACEHOLDER},
    displayName    = _(name .. ' x 2'),
    Cx_pil         = 0.000859765625 * 1.31,
    Count          = 2,
    Weight         = 2 * mass + pylon_dual_mass,
    Elements       = {
        { ShapeName = 'LAU-115C+2_LAU127', IsAdapter = true, },
        { ShapeName = 'mar-1',            connector_name = 'Point02'},
        { ShapeName = 'mar-1',            connector_name = 'Point03'},
       
    },
    --ejectImpulse     = 140,
    JettisonSubmunitionOnly = true,
})

declare_loadout({
    category       = CAT_MISSILES,
    CLSID          = 'DIS_LD-10_DUAL_R',
    Picture        = 'mar-1.png',
    wsTypeOfWeapon = MAR_ARM.wsTypeOfWeapon,
    attribute      = {4,4,32,WSTYPE_PLACEHOLDER},
    displayName    = _(name .. ' x 2'),
    Cx_pil         = 0.000859765625 * 1.31,
    Count          = 2,
    Weight         = 2 * mass + pylon_dual_mass,
    Elements       = {
        { ShapeName = 'LAU-115C+2_LAU127', IsAdapter = true, },
        { ShapeName = 'mar-1',            connector_name = 'Point02'},
        { ShapeName = 'mar-1',            connector_name = 'Point03'},
       
    },
    --ejectImpulse     = 140,
    JettisonSubmunitionOnly = true,
})

