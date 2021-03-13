-- BEGIN -- this part of the file is not intended for an end-user editing
--[[ --------------------------------------------------------------- ]]--

F15FM = {
center_of_mass		= {-0.172  ,  -0.6,	   0},--x,y,z
moment_of_inertia 	= {38912  ,254758,223845,-705},--Ix,Iy,Iz,Ixy
suspension 			= {
	  { -- NOSE WHEEL
		  self_attitude     = true,
		  --amortizer_min_length     = 0.0,
		  amortizer_max_length     = 0.43,
		  amortizer_basic_length     = 0.43,
		  amortizer_spring_force_factor   = 990000.0, -- force = spring_force_factor * pow(reduce_length, amortizer_spring_force_factor_rate
		  amortizer_spring_force_factor_rate  = 2,
		  amortizer_static_force     = 47500.0,
		  amortizer_reduce_length     = 0.43,
		  amortizer_direct_damper_force_factor = 50000,
		  amortizer_back_damper_force_factor  = 60000,

		  anti_skid_installed = false,

		  wheel_radius      = 0.377,
		  wheel_static_friction_factor  = 0.75 ,
		  wheel_side_friction_factor    = 0.85 ,
		  wheel_roll_friction_factor    = 0.08 ,
		  wheel_glide_friction_factor   = 0.65 ,
		  wheel_damage_force_factor     = 450.0,

		  arg_post     = 0,
		  arg_amortizer    = 1,
		  arg_wheel_rotation = 101,
		  arg_wheel_damage   = 134
	  },
	  { -- LEFT WHEEL
		  --amortizer_min_length     = 0.0,
		  amortizer_max_length     = 0.228, 
		  amortizer_basic_length     = 0.228, 
		  amortizer_spring_force_factor   = 29370398.0, -- force = spring_force_factor * pow(reduce_length, amortizer_spring_force_factor_rate
		  amortizer_spring_force_factor_rate  = 3,
		  amortizer_static_force     = 202394.0, 
		  amortizer_reduce_length     = 0.221, 
		  amortizer_direct_damper_force_factor = 50000.0,
		  amortizer_back_damper_force_factor  = 25000.0,

		  anti_skid_installed = true,

		  wheel_radius      = 0.486,
		  wheel_static_friction_factor  = 0.75 ,
		  wheel_side_friction_factor    = 0.85 ,
		  wheel_roll_friction_factor    = 0.08 ,
		  wheel_glide_friction_factor   = 0.65 ,
		  wheel_damage_force_factor     = 450.0,
		  wheel_brake_moment_max		= 15000.0,

		  arg_post     = 5,
		  arg_amortizer    = 6,
		  arg_wheel_rotation = 102,
		  arg_wheel_damage   = 136
	  },
	  {  -- RIGHT WHEEL
		  --amortizer_min_length     = 0.0,
		  amortizer_max_length     = 0.228, 
		  amortizer_basic_length     = 0.228,
		  amortizer_spring_force_factor   = 29370398.0, -- 10000 -- force = spring_force_factor * pow(reduce_length, amortizer_spring_force_factor_rate
		  amortizer_spring_force_factor_rate  = 3,
		  amortizer_static_force     = 202394.0, 
		  amortizer_reduce_length     = 0.221, 
		  amortizer_direct_damper_force_factor = 50000.0,
		  amortizer_back_damper_force_factor  = 25000.0,

		  anti_skid_installed = true,

		  wheel_radius      = 0.486,
		  wheel_static_friction_factor  = 0.75 ,
		  wheel_side_friction_factor    = 0.85 ,
		  wheel_roll_friction_factor    = 0.08 ,
		  wheel_glide_friction_factor   = 0.65 ,
		  wheel_damage_force_factor     = 450.0,
		  wheel_brake_moment_max		= 15000.0,

		  arg_post     = 3,
		  arg_amortizer    = 4,
		  arg_wheel_rotation = 103,
		  arg_wheel_damage   = 135
	  }
	}, -- gears
	
disable_built_in_oxygen_system	= true,
--[[ ------------------------------------------------------------- ]]--
-- END -- this part of the file is not intended for an end-user editing

-- view shake amplitude
minor_shake_ampl = 0.21,
major_shake_ampl = 0.5,

-- debug
debugLine = "{M}:%1.3f {IAS}:%4.1f {AoA}:%2.1f {ny}:%2.1f {nx}:%1.2f {AoS}:%2.1f {mass}:%2.1f {Fy}:%2.1f {Fx}:%2.1f {wx}:%.1f {wy}:%.1f {wz}:%.1f {Vy}:%2.1f {dPsi}:%2.1f",
record_enabled = false,
}