
JF17_FM = 
{
    disable_built_in_oxygen_system = true,
    center_of_mass    = { 0.05, 0.0, 0.0},
    moment_of_inertia  	= 	{2288.0, 3500.0, 70000.0, 0.0},   	-- moment of inertia of empty aircraft
    suspension = {
        {
            wheel_radius = 0.25,
            damper_coeff = 300.0,
            filter_yaw   = false,
            yaw_limit    = math.rad(32.0),
            moment_limit = 750.0,
            
            allowable_hard_contact_length = 0.15,
            
            anti_skid_installed = false,
            wheel_brake_moment_max               = 10000.0,
            amortizer_min_length                 = 0.0,
            amortizer_max_length                 = 0.20,
            amortizer_basic_length               = 0.21,
            amortizer_spring_force_factor        = 550000.0,
            amortizer_spring_force_factor_rate   = 2.0,
            amortizer_static_force               = 30000.0,
            amortizer_reduce_length              = 0.2,
            amortizer_direct_damper_force_factor = 40000.0,
            amortizer_back_damper_force_factor   = 20000.0,
            
            wheel_static_friction_factor = 0.75,
            wheel_side_friction_factor   = 0.35 ,
            wheel_roll_friction_factor   = 0.12 ,
            wheel_glide_friction_factor  = 0.35 ,
            wheel_damage_force_factor    = 450.0,
            wheel_damage_speed           = 102,
            wheel_damage_speedX          = 102,

            arg_post             = 0,
            arg_amortizer        = 1,
            arg_wheel_rotation   = 101,
            arg_wheel_yaw        = 2,
            collision_shell_name = 'WHEEL_F',
        },
        {
            mass         = 200,
            wheel_radius = 0.33,
            wheel_static_friction_factor  = 0.7 ,
            wheel_side_friction_factor    = 0.65 ,
            wheel_roll_friction_factor    = 0.04 ,
            wheel_glide_friction_factor   = 0.35 ,
            
            allowable_hard_contact_length = 0.196,
            
            anti_skid_installed = true,
            amortizer_min_length                 = 0.0,
            amortizer_max_length                 = 0.22,
            amortizer_basic_length               = 0.23,
            amortizer_spring_force_factor        = 10000000,
            amortizer_spring_force_factor_rate   = 3.0,
            amortizer_static_force               = 65000.0,
            amortizer_reduce_length              = 0.22,
            amortizer_direct_damper_force_factor = 40000.0,
            amortizer_back_damper_force_factor   = 20000.0,
            
            wheel_brake_moment_max               = 8200.0, 
            wheel_damage_force_factor            = 450.0,
            wheel_damage_speed                   = 102,
            wheel_damage_speedX                  = 102,


            arg_post             = 5,
            arg_amortizer        = 6,
            arg_wheel_rotation   = 102,
            arg_wheel_yaw        = -1,
            collision_shell_name = 'WHEEL_L',
        },
        {
            mass         = 200,
            wheel_radius = 0.33,
            wheel_static_friction_factor  = 0.7 ,
            wheel_side_friction_factor    = 0.65 ,
            wheel_roll_friction_factor    = 0.04 ,
            wheel_glide_friction_factor   = 0.35 ,
            
            allowable_hard_contact_length = 0.196,
            
            anti_skid_installed = true,
            amortizer_min_length                 = 0.0,
            amortizer_max_length                 = 0.22,
            amortizer_basic_length               = 0.23,
            amortizer_spring_force_factor        = 10000000,
            amortizer_spring_force_factor_rate   = 3.0,
            amortizer_static_force               = 65000.0,
            amortizer_reduce_length              = 0.22,
            amortizer_direct_damper_force_factor = 40000.0,
            amortizer_back_damper_force_factor   = 20000.0,
            
            wheel_brake_moment_max               = 8200.0, 
            wheel_damage_force_factor            = 450.0,
            wheel_damage_speed                   = 102,
            wheel_damage_speedX                  = 102,

            arg_post             = 3,
            arg_amortizer        = 4,
            arg_wheel_rotation   = 103,
            arg_wheel_yaw        = -1,
            collision_shell_name = 'WHEEL_R',
        },
    }
}