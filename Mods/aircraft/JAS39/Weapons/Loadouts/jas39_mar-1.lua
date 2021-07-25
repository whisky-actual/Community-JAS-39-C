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
local mass = 350.0

local mar1 = {

	category		= CAT_MISSILES,
	name			= "mar1",
	user_name		= _("MAR-1 High Speed Anti-Radiation Missile"),
	wsTypeOfWeapon 	= {wsType_Weapon, wsType_Missile, wsType_AS_Missile, WSTYPE_PLACEHOLDER},
	scheme			= "anti_radiation_missile",              
	class_name		= "wAmmunitionSelfHoming",                          
	model			= "jas39_mar1",
	mass 			= mass,
      
        Escort = 0,
        Head_Type = 3,
		sigma = {10, 10, 10},
        M = mass,
        H_max = 25000.0,
        H_min = -1,
        Diam = 231.0,
        Cx_pil = 2,
        D_max = 100000.0,
        D_min = 700.0,
        Head_Form = 0,
        Life_Time = 300.0,
        Nr_max = 25,
        v_min = 140.0,
        v_mid = 900.0,
        Mach_max = 3.0,
        t_b = 0.0,
        t_acc = 5.0,
        t_marsh = 15.0,
        Range_max = 100000.0,
        H_min_t = 0.0,
        Fi_start = 0.5236,
        Fi_rak = 3.14152,
        Fi_excort = 1.05,
        Fi_search = 1.05,
        OmViz_max = 0.52,
        X_back = -1.3,
        Y_back = -0.50,
        Z_back = 0.0,
        Reflection = 0.0329,
        KillDistance = 7.0,
		add_attributes = {"Cruise missiles"},
	 
	shape_table_data =
	{
		{
			name	 = "mar1",
			file	 = "jas39_mar1",
			life	 = 1,
			fire	 = { 0, 1},
			username = _("MAR1"),
			index	 = WSTYPE_PLACEHOLDER,			
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
		wind_sigma	= 0.0,
		wind_time	= 0.0,
		Sw			= 0.85,
		dCydA		= {0.07, 0.036},
		A			= 0.36,
		maxAoa		= 0.28,
		finsTau		= 0.1,
		
		Ma_x		= 0.001,
		Kw_x		= 0.001,
		I_x			= 50,
	},
	
	radio_seeker = {
		FOV					= math.rad(5),
		op_time				= 300,
		keep_aim_time		= 8,
		pos_memory_time		= 60,
		sens_near_dist		= 200.0,
		sens_far_dist		= 60000.0,
		err_correct_time	= 1.0,
		err_val				= 0.001,
		calc_aim_dist		= 500000,
		blind_rad_val		= 0.1,
		blind_ctrl_dist		= 1000,
		aim_y_offset		= 2.0,
	},
	
	simple_gyrostab_seeker = {
		omega_max	= math.rad(8)
	},
	
	fuze_proximity = {
		ignore_inp_armed = 1,
	},
	
	autopilot = {
		delay			 = 1.0,
		K				 = 100.0,
		Kg				 = 6.0,
		Ki				 = 0.0,
		finsLimit		 = 0.22,
		useJumpByDefault = 1,
		J_Power_K		 = 1.2,
		J_Diff_K		 = 0.1,
		J_Int_K			 = 0.0,
		J_Angle_K		 =  math.rad(12),      
		J_FinAngle_K	 =  math.rad(18),  		
		J_Angle_W		 = 1.5,                 
	},
	
	start_helper = {
		delay               = 0.2,
		power               = 0.02,
		time				= 2,
		use_local_coord		= 0,
		max_vel				= 200,
		max_height			= 400,
		vh_logic_or			= 0,
	},
	
	controller = {
		boost_start	= 0.501,
		march_start = 1.0,
	},
	
booster = {
		impulse								= 240,
		fuel_mass							= 50,
		work_time							= 5.0,
		boost_time							= 0,
		boost_factor						= 0,
		nozzle_position						= {{-1.65, 0.0, -0.0}},
		nozzle_orientationXYZ				= {{0.0, 0.0, 0.0}},
		tail_width							= 0.4,
		smoke_color							= {1.0, 1.0, 1.0},
		smoke_transparency					= 1.3,
		custom_smoke_dissipation_factor		= 0.2,
	},
	
	march = {
		impulse								= 100,
		fuel_mass							= 80,
		work_time							= 15,  
		boost_time							= 0,
		boost_factor						= 0,
		nozzle_position                     = {{-1.65, 0.0, -0.0}},
		nozzle_orientationXYZ				= {{0.0, 0.0, 0.0}},
		tail_width                          = 0.2,
		smoke_color							= {0.6, 0.6, 0.6},  
		smoke_transparency                  = 0.8,
		custom_smoke_dissipation_factor		= 0.2,	
	},
	
	engine_control = {
		default_speed	= 237,
		K				= 265,
		Kd				= 0.01,
		Ki				= 0.001,
	
	},
		
	warhead		= MAR_warhead,
	warhead_air = MAR_warhead,
	
}

declare_weapon(mar1)

declare_loadout({
	category 		= CAT_MISSILES,
	CLSID	 		= "JAS39_MAR-1",
	attribute		= mar1.wsTypeOfWeapon,
	Count 			= 1,
	Cx_pil			= mar1.Cx,
	Picture			= "jas39_mar-1.png",
	displayName		= mar1.user_name,
	Weight			= mar1.mass,
	Elements  		= {{ShapeName = mar1.model}},
		
})