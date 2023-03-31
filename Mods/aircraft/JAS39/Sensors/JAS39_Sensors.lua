--SENSOR CATEGORY
local SENSOR_OPTICAL = 0
local SENSOR_RADAR = 1
local SENSOR_IRST = 2
local SENSOR_RWR = 3
--RADAR
local RADAR_AS = 0
local RADAR_SS = 1
local RADAR_MULTIROLE = 2
--
local ASPECT_HEAD_ON = 0
local ASPECT_TAIL_ON = 1
--
local HEMISPHERE_UPPER = 0
local HEMISPHERE_LOWER = 1
--IRST
local ENGINE_MODE_FORSAGE = 0
local ENGINE_MODE_MAXIMAL = 1
local ENGINE_MODE_MINIMAL = 2
--OPTIC
local OPTIC_SENSOR_TV = 0
local OPTIC_SENSOR_LLTV = 1
local OPTIC_SENSOR_IR = 2

PS_05A = {
	Name = "PS-05/A",
	category = SENSOR_RADAR,
	
	type = RADAR_MULTIROLE,
	scan_volume =
	{
		azimuth = {-60.0, 60.0},
		elevation = {-60.0, 60.0}
	},
	max_measuring_distance = 180000.0,
	scan_period = 0.1,
	air_search = {          
		centered_scan_volume =
		{
			azimuth_sector = 30.0,
			elevation_sector = 30.0
		}, 
		RCS = 1,		
		detection_distance =
		{
			[HEMISPHERE_UPPER] =
			{
				[ASPECT_HEAD_ON] = 180000.0,
				[ASPECT_TAIL_ON] = 180000.0
			},
			[HEMISPHERE_LOWER] =
			{
				[ASPECT_HEAD_ON] = 180000.0,
				[ASPECT_TAIL_ON] = 180000.0
			}
		},
		lock_on_distance_coeff = 0.95,
		multiple_targets_tracking = true,
		TWS_max_targets = 4,		
		velocity_limits =
		{
			radial_velocity_min = 100.0 / 3.6,
			relative_radial_velocity_min = 100.0 / 3.6,
		},
	},
	surface_search = {
		vehicles_detection = true,
		RCS = 100,
		RBM_detection_distance = 135000.0,
		GMTI_detection_distance = 135000.0,
		HRM_detection_distance = 135000.0
	}
}

declare_sensor(PS_05A)

jas39rwr ={
            Name = "BOW-21 RWR",
            category = SENSOR_RWR,
            detection_dist_to_radar_detection_dist_max_ratio = 0.95,
            lock_on_detection = true
    }
	

declare_sensor(jas39rwr)
