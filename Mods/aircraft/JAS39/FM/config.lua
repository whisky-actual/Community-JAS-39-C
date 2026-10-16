


local MainToNoseWidth = 1.3725 -- two frontwheels = 1.37 mainwheels wide




local mainGear = {
	--amortizer_min_length					= 0.0,
	amortizer_max_length					= 0.35, --3D Modell
	amortizer_basic_length					= 0.35, --3D Modell
	amortizer_spring_force_factor			= 4.8e+6, --F16 = 2.1e+7, F15 = 990000.0,(reduce_length)
	amortizer_spring_force_factor_rate		= 3,
	amortizer_static_force					= 1000,
	amortizer_reduce_length					= 0.227, -- damper range of motion in meters
	amortizer_direct_damper_force_factor	= 60000,
	amortizer_back_damper_force_factor		= 20000,
	allowable_hard_contact_length			= 0.1,

	anti_skid_installed = false,

	crossover_locked_wheel_protection			= true,
	crossover_locked_wheel_protection_speed_min	= 18.0,
	anti_skid_improved							= true,
	anti_skid_gain								= 400.0,

	wheel_radius					= 0.3245, 
	wheel_static_friction_factor	= 0.75,
	wheel_glide_friction_factor		= 0.6,
	wheel_side_friction_factor		= 0.75,
	wheel_roll_friction_factor		= 0.025,
	wheel_damage_force_factor		= 200.0, --450.0,
	wheel_brake_moment_max			= 7000,
	wheel_kz_factor					= 0.52,
	noise_k							= 0.05,
	wheel_damage_speedX				= 270, --115,
	wheel_damage_delta_speedX		= 22.5, --11.5,
}


FM = {
center_of_mass		= {-0.4617  ,  0,	  0.0}, -- x,y,z  



moment_of_inertia 	= {8131/0.73  ,41767/0.73 ,49019/0.73 ,-830/0.73},--Ix,Iy,Iz,Ixy = Roll, yaw pitch. Values from VSP but maybe too low (esp roll) testing conversion from slug/sqfeet to kg/m2




suspension 			= {
	  { -- NOSE WHEEL
			damage_element					= 83,
			wheel_axle_offset				= 0.0,
			self_attitude					= false,
			yaw_limit						= math.rad(67.0),	-- Real angle but is it to each side or in total? 33.5
			moment_limit					= 750.0,
			damper_coeff					= 300.0,
			allowable_hard_contact_length	= 0.25,
			filter_yaw						= true,

			amortizer_min_length						= 0.0,
			amortizer_max_length						= 0.424, -- measure 3d model //Panda
			amortizer_basic_length						= 0.49, -- measure 3d model //Panda
			amortizer_spring_force_factor				= 1.2e+6,
			amortizer_spring_force_factor_rate			= 3.5,
			amortizer_static_force						= 6000,
			amortizer_reduce_length						= 0.424, -- damper range of motion in meters
			amortizer_direct_damper_force_factor		= 15000,
			amortizer_back_damper_force_factor			= 15000,
			
			wheel_brake_moment_max			= 12000.0,
			anti_skid_installed							= true,

			wheel_radius								= 0.1845,	
			wheel_static_friction_factor				= 0.75,
			wheel_side_friction_factor					= 0.75 * 2, --0.45,
			wheel_roll_friction_factor					= 0.025,
			wheel_glide_friction_factor					= 0.6,
			wheel_damage_force_factor					= 450.0, --450.0,
			wheel_kz_factor								= 0.3,
			noise_k										= 0.1,
			wheel_damage_speedX							= 270.0, --115,
			wheel_damage_delta_speedX					= 22.5, --11.5,

			arg_post			= 0,
			arg_amortizer		= 1,
			arg_wheel_rotation	= 101,
			arg_wheel_damage	= 134
		},
	  { -- LEFT WHEEL
			damage_element					= 84,

			amortizer_max_length						= mainGear.amortizer_max_length,
			amortizer_basic_length						= mainGear.amortizer_basic_length,
			amortizer_spring_force_factor				= mainGear.amortizer_spring_force_factor, --
			amortizer_spring_force_factor_rate			= mainGear.amortizer_spring_force_factor_rate,
			amortizer_static_force						= mainGear.amortizer_static_force,
			amortizer_reduce_length						= mainGear.amortizer_reduce_length,
			amortizer_direct_damper_force_factor		= mainGear.amortizer_direct_damper_force_factor,
			amortizer_back_damper_force_factor			= mainGear.amortizer_back_damper_force_factor,
			allowable_hard_contact_length				= mainGear.allowable_hard_contact_length,

			anti_skid_installed							= mainGear.anti_skid_installed,

			crossover_locked_wheel_protection			= mainGear.crossover_locked_wheel_protection,
			crossover_locked_wheel_protection_wheel		= 2,
			crossover_locked_wheel_protection_speed_min	= mainGear.crossover_locked_wheel_protection_speed_min,
			anti_skid_improved							= mainGear.anti_skid_improved;
			anti_skid_gain								= mainGear.anti_skid_gain,

			wheel_radius								= mainGear.wheel_radius,
			wheel_static_friction_factor				= mainGear.wheel_static_friction_factor,
			wheel_side_friction_factor					= mainGear.wheel_side_friction_factor,
			wheel_roll_friction_factor					= mainGear.wheel_roll_friction_factor,
			wheel_glide_friction_factor					= mainGear.wheel_glide_friction_factor,
			wheel_damage_force_factor					= mainGear.wheel_damage_force_factor,
			wheel_brake_moment_max						= mainGear.wheel_brake_moment_max,
			wheel_kz_factor								= mainGear.wheel_kz_factor,
			noise_k										= mainGear.noise_k,
			wheel_damage_speedX							= mainGear.wheel_damage_speedX,
			wheel_damage_delta_speedX					= mainGear.wheel_damage_delta_speedX,

			arg_post			= 5,
			arg_amortizer		= 6,
			arg_wheel_rotation	= 102,
			arg_wheel_damage	= 136
		},
		{  -- RIGHT WHEEL
			damage_element					= 85,

			amortizer_max_length						= mainGear.amortizer_max_length,
			amortizer_basic_length						= mainGear.amortizer_basic_length,
			amortizer_spring_force_factor				= mainGear.amortizer_spring_force_factor, --
			amortizer_spring_force_factor_rate			= mainGear.amortizer_spring_force_factor_rate,
			amortizer_static_force						= mainGear.amortizer_static_force,
			amortizer_reduce_length						= mainGear.amortizer_reduce_length,
			amortizer_direct_damper_force_factor		= mainGear.amortizer_direct_damper_force_factor,
			amortizer_back_damper_force_factor			= mainGear.amortizer_back_damper_force_factor,
			allowable_hard_contact_length				= mainGear.allowable_hard_contact_length,

			anti_skid_installed							= mainGear.anti_skid_installed,

			crossover_locked_wheel_protection			= mainGear.crossover_locked_wheel_protection,
			crossover_locked_wheel_protection_wheel		= 1,
			crossover_locked_wheel_protection_speed_min	= mainGear.crossover_locked_wheel_protection_speed_min,
			anti_skid_improved							= mainGear.anti_skid_improved;
			anti_skid_gain								= mainGear.anti_skid_gain,

			wheel_radius								= mainGear.wheel_radius,
			wheel_static_friction_factor				= mainGear.wheel_static_friction_factor,
			wheel_side_friction_factor					= mainGear.wheel_side_friction_factor,
			wheel_roll_friction_factor					= mainGear.wheel_roll_friction_factor,
			wheel_glide_friction_factor					= mainGear.wheel_glide_friction_factor,
			wheel_damage_force_factor					= mainGear.wheel_damage_force_factor,
			wheel_brake_moment_max						= mainGear.wheel_brake_moment_max,
			wheel_kz_factor								= mainGear.wheel_kz_factor,
			noise_k										= mainGear.noise_k,
			wheel_damage_speedX							= mainGear.wheel_damage_speedX,
			wheel_damage_delta_speedX					= mainGear.wheel_damage_delta_speedX,

			arg_post			= 3,
			arg_amortizer		= 4,
			arg_wheel_rotation	= 103,
			arg_wheel_damage	= 135
		},
	}, -- gears suspension
	
disable_built_in_oxygen_system	= true,

}