range_scale 		  	= 60000.0
TDC_range_carret_size 	= 5000
render_debug_info 		= false--true


perfomance = 
{
	roll_compensation_limits	= {math.rad(-180.0), math.rad(180.0)},
	pitch_compensation_limits	= {math.rad(-45.0), math.rad(45.0)},

	
	tracking_azimuth   			= { -math.rad(30),math.rad(30)},
	tracking_elevation 			= { -math.rad(30),math.rad(30)},
	
	scan_volume_azimuth 	= math.rad(60),		--is left+right so 60 is -30,30+
	scan_volume_elevation	= math.rad(30),		
	scan_beam				= math.rad(60),
	scan_speed				= math.rad(3*60),
	
	
	max_available_distance  = 20000.0,--200*60000.0,
	dead_zone 				= 300.0,
	
	ground_clutter =
	{-- spot RCS = A + B * random + C * random 
		sea		   	   = {0 ,0,0},
		land 	   	   = {0 ,0,0},		
		artificial 	   = {0 ,0,0},
		rays_density   = 0.01,
		max_distance   = 60000,
	}
	
}


------------------------------------------------------------------------------

dev 	    	= GetSelf()
DEBUG_ACTIVE 	= false



update_time_step 	= 0.01666		--0.166 --once every 6 times a sec
device_timer_dt		= 0.01666

make_default_activity(update_time_step) 



Radar = 	{
				mode_h 		= get_param_handle("RADAR_MODE"),
				szoe_h 		= get_param_handle("SCAN_ZONE_ORIGIN_ELEVATION"),
				szoa_h 		= get_param_handle("SCAN_ZONE_ORIGIN_AZIMUTH"),
				
				opt_pb_stab_h 	= get_param_handle("RADAR_PITCH_BANK_STABILIZATION"),
				opt_bank_stab_h = get_param_handle("RADAR_BANK_STABILIZATION"),
				opt_pitch_stab_h= get_param_handle("RADAR_PITCH_STABILIZATION"),
				
				
				tdc_azi_h 		= get_param_handle("RADAR_TDC_AZIMUTH"),
				tdc_range_h 	= get_param_handle("RADAR_TDC_RANGE"),
				tdc_closet_h	= get_param_handle("CLOSEST_RANGE_RESPONSE"),
				
				tdc_rcsize_h	= get_param_handle("RADAR_TDC_RANGE_CARRET_SIZE"),
				tdc_acqzone_h   = get_param_handle("ACQUSITION_ZONE_VOLUME_AZIMUTH"),
				

				
				stt_azimuth_h 	= get_param_handle("RADAR_STT_AZIMUTH"),
				stt_elevation_h = get_param_handle("RADAR_STT_ELEVATION"),
				
				sz_azimuth_h 	= get_param_handle("SCAN_ZONE_ORIGIN_AZIMUTH"),
				sz_elevation_h 	= get_param_handle("SCAN_ZONE_ORIGIN_ELEVATION"),
				
				tdc_ele_up_h 	= get_param_handle("RADAR_TDC_ELEVATION_AT_RANGE_UPPER"),
				tdc_ele_down_h 	= get_param_handle("RADAR_TDC_ELEVATION_AT_RANGE_LOWER"),
				
				ws_ir_slave_azimuth_h	= get_param_handle("WS_IR_MISSILE_SEEKER_DESIRED_AZIMUTH"),
				ws_ir_slave_elevation_h	= get_param_handle("WS_IR_MISSILE_SEEKER_DESIRED_ELEVATION"),
				
				iff_status_h			= get_param_handle("IFF_INTERROGATOR_STATUS"),
				bit_h 					= get_param_handle("RADAR_BIT"),
				BATTERY 		= get_param_handle("BATTERY"),

			}

function post_initialize()

	print_message_to_user("Radar - INIT")
		
		dev:listen_command(86)
		dev:listen_command(87)
		dev:listen_command(88)
		dev:listen_command(89)
		dev:listen_command(90)
		dev:listen_command(91)
		
		dev:listen_command(100)
		
		dev:listen_command(139)		--scanzone left
		dev:listen_command(140)		--scanzone right
		
		dev:listen_command(141)		--scanzone up
		dev:listen_command(142)		--scanzone down
		
		dev:listen_command(394)		--change PRF (radar puls freqency)
	
		dev:listen_command(509)		--lock start
		dev:listen_command(510)		--lock finish
		
		dev:listen_command(285)		--Change radar mode RWS/TWS 
		
		dev:listen_command(2025)
		dev:listen_command(2026)
		dev:listen_command(2031)
		dev:listen_command(2032)
		

		Radar.opt_pb_stab_h:set(1)
		Radar.opt_pitch_stab_h:set(1)
		Radar.opt_bank_stab_h:set(1)
		
	
end

function SetCommand(command,value)
	--print_message_to_user(string.format("Radar SetCom: C %i   V%.8f",command,value))
	
---------------------------------------------------------------------
	
	if command == 141 and value == 0.0 then
		Radar.sz_elevation_h:set(Radar.sz_elevation_h:get() + 0.003)
	elseif command == 142 and value == 0.0 then
		Radar.sz_elevation_h:set(Radar.sz_elevation_h:get() - 0.003)
	end
	
	if command == 139 and value == 0.0 then
		Radar.sz_azimuth_h:set(Radar.sz_azimuth_h:get() + 0.003)
	elseif command == 140 and value == 0.0 then
		Radar.sz_azimuth_h:set(Radar.sz_azimuth_h:get() - 0.003)
	end
	
----------------------------------------------------------------------	
	
	if Radar.tdc_range_h:get() > 20000 then
		Radar.tdc_range_h:set(20000)
	elseif Radar.tdc_range_h:get() < 0 then
		Radar.tdc_range_h:set(0)
	end
		
	if Radar.tdc_azi_h:get() > 0.5 then
		Radar.tdc_azi_h:set(0.5)
	elseif Radar.tdc_azi_h:get() < -0.5 then
		Radar.tdc_azi_h:set(-0.5)
	end
	
-------------------------------------------------
	
	if command == 2032  then
			Radar.tdc_range_h:set(Radar.tdc_range_h:get()- value*200000)
		
	end
	
	if command == 2031  then
			Radar.tdc_azi_h:set(Radar.tdc_azi_h:get()+ value*10)
	
	end

-------------------------------------------------	
	
	
	
	
end


function update()
	
	Sensor_Data_Raw = get_base_data()

	
	Radar.tdc_ele_up_h:set(((Sensor_Data_Raw.getBarometricAltitude() + math.tan(Radar.sz_elevation_h:get() + (perfomance.scan_volume_elevation/2)  ) * Radar.tdc_range_h:get())))
	Radar.tdc_ele_down_h:set(((Sensor_Data_Raw.getBarometricAltitude() + math.tan(Radar.sz_elevation_h:get() - (perfomance.scan_volume_elevation/2)  ) * Radar.tdc_range_h:get())))
	
	
	
end


