local mar1 = {

	category		= CAT_MISSILES,
	name			= "mar1",
	user_name		= _("Mar-1"),
	wsTypeOfWeapon 	= {wsType_Weapon, wsType_Missile, wsType_AS_Missile, WSTYPE_PLACEHOLDER},
	scheme			= "anti_radiation_missile",              
	class_name		= "wAmmunitionSelfHoming",                          
	model			= "mar1",
	 mass = 640,
	
	
	
	
      
        Escort = 0,
        Head_Type = 3,
		    sigma = {8, 8, 8},
        M = 628.0,
        H_max = 10000.0,
        H_min = -1,
        Diam = 343.0,
        Cx_pil = 6,
        D_max = 125000.0,  --85000.0,
        D_min = 2000.0,
        Head_Form = 0,
        Life_Time = 1850.0,
        Nr_max = 18,
        v_min = 170.0,
        v_mid = 272.0,
        Mach_max = 1.2, --0.9,
        t_b = 0.0,
        t_acc = 5.0,
        t_marsh = 1800.0,
        Range_max = 159000.0,  --139000.0,
        H_min_t = 0.0,
        Fi_start = 0.5,
        Fi_rak = 3.14152,
        Fi_excort = 1.05,
        Fi_search = 99.9,
        OmViz_max = 99.9,
        --warhead = warheads["AGM_84E"],
        -- No exhaust (turbo)
        X_back = -1.581,
        Y_back = -0.173,
        Z_back = 0.0,
        Reflection = 0.121,
        KillDistance = 11.0, --0.0,
		add_attributes = {"Cruise missiles"},
		
    
	 
	shape_table_data =
	{
		{
			name	 = "mar1",
			file	 = "mar1",
			life	 = 1,
			fire	 = { 0, 1},
			username = _("mar1"),
			index	 = WSTYPE_PLACEHOLDER,
				
			
		},
	},
	
	
	
	fm = {
		mass        = 640,  
		caliber     = 0.380,  
		cx_coeff    = {1,0.4,1.1,0.5,1.4},
		L           = 4.8,
		I           = 1 / 12 * 640 * 4.8 * 4.8,
		Ma          = 0.3,
		Mw          = 1.116,
		wind_sigma	= 0.0,
		wind_time	= 0.0,
		Sw			= 1.65,
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
		op_time				= 600,--200Kh58
		keep_aim_time		= 4,
		pos_memory_time		= 200,
		sens_near_dist		= 300.0,
		sens_far_dist		= 70000.0,
		err_correct_time	= 2.5,
		err_val				= 0.0036,
		calc_aim_dist		= 500000,
		blind_rad_val		= 0.1,
		blind_ctrl_dist		= 2800,
		aim_y_offset		= 4.5,
	},
	
	simple_gyrostab_seeker = {
		omega_max	= math.rad(8)
	},
	
	fuze_proximity = {
		ignore_inp_armed = 1,
	},
	
	autopilot = {
		delay			 = 1.0,
		K				 = 300.0,
		Kg				 = 5.0,
		Ki				 = 0.0,
		finsLimit		 = 0.1,
		useJumpByDefault = 1,
		J_Power_K		 = 1.2,
		J_Diff_K		 = 0.3,
		J_Int_K			 = 0.0,
		J_Angle_K		 =  math.rad(08),       -- 11 --angle de recherche horizontale ( axe X ) à 50m de la cible
		J_FinAngle_K	 =  math.rad(05),  		-- 18 --angle de cabrage ( axe Y ) après le shoot
		J_Angle_W		 = 1.5,                 -- 3.5 --angle de plongée (axe Y) vers le bas à 50m de la cible
	},
	
	start_helper = {
		delay				= 1.0,
		power				= 0.1,
		time				= 1,
		use_local_coord		= 0,
		max_vel				= 200,
		max_height			= 200,
		vh_logic_or			= 0,
	},
	
	controller = {
		boost_start	= 0.501,
		march_start = 1.0,  --0.51,
	},
	
booster = {
		impulse								= 450,      --195,
		fuel_mass							= 75.26,    --112.18,
		work_time							= 2.5,      --3.6,
		boost_time							= 0,
		boost_factor						= 0,
		nozzle_position						=  {{-2.30, 0.0, 0}},            --{{-2.20, 0.15, 0}},
		nozzle_orientationXYZ				= {{0.0, 0.0, 0.0}},
		tail_width							= 0.4,
		smoke_color							= {1.0, 1.0, 1.0},
		smoke_transparency					= 1.3,      --0.9,
		custom_smoke_dissipation_factor		= 0.0,    --0.2,	
	},
	
	march = {
		impulse								= 320,        --210,
		fuel_mass							= 320.50,   --220.50,     --70.86,
		work_time							= 75,  --65,  --45,
		boost_time							= 0,
		boost_factor						= 0,
		nozzle_position						= {{-2.25, 0.0, 0}},  -- -1.5, -0.19, 0
		nozzle_orientationXYZ				= {{0.0, 0.0, 0.0}},
		tail_width							=  0.1,       --0.4,
		smoke_color							= {0.6, 0.6, 0.6},  --{1.0, 1.0, 1.0},
		smoke_transparency					= 0.5,  --0.9,
		custom_smoke_dissipation_factor		= 0.1,	
	},
	
	engine_control = {
		default_speed	= 237,
		K				= 265,
		Kd				= 0.01,
		Ki				= 0.001,
		-- burst_signal = 9999, -- used in 'anti_ship_missile_tb' scheme
	
	},
		
	warhead		= antiship_penetrating_warhead(3310, 3370), -- 3310 3370
	warhead_air = antiship_penetrating_warhead(3310, 3370), --3310 3370	
	--warhead = predefined_warhead("X_58"),
	--warhead_air = predefined_warhead("X_58"),
   
}

declare_weapon(mar1)





declare_loadout({
	category 		= CAT_MISSILES,
	CLSID	 		= "JAS_MAR-1",
	attribute		= mar1.wsTypeOfWeapon,
	Count 			= 1,
	Cx_pil			= mar1.Cx,
	Picture			= "mar-1.png",
	displayName		= mar1.user_name,
	Weight			= mar1.mass,
	Elements  		= {{ShapeName = mar1.model}},
	
		
	
	
})