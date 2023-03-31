ViewSettings = {
	Cockpit = {
	[1] = {-- player slot 1
		CockpitLocalPoint      = {4.20,0.70,0.000},--Cockpit placement, Forward/back, Up/down, Left/right
		CameraViewAngleLimits  = {20.000000,160.000000},
		CameraAngleRestriction = {false,90.000000,0.400000},
		CameraAngleLimits      = {190.000000,-75.000000,115.000000},--head turn = left right, down, up
		EyePoint               = {0.05,1.50,0.00},--front/back,up/down,left/right}<-'neck dimension'in meters 
		limits_6DOF            = {x = {-0.05,0.47},y ={-0.3,0.035},z = {-0.25,0.25},roll = 90},--Move = back forwards, up down, left right
		ShoulderSize		   = 0.15,-- moves body when azimuth value is more than 90 degrees
		Allow360rotation	   = false,
	},	
	}, -- Cockpit 
	Chase = {
		LocalPoint      = {2.510000,3.604000,0.000000},
		AnglesDefault   = {180.000000,-8.000000},
	}, -- Chase 
	Arcade = {
		LocalPoint      = {-13.790000,6.204000,0.000000},
		AnglesDefault   = {0.000000,-8.000000},
	}, -- Arcade 
}

SnapViews = {
[1] = {-- player slot 1
	[1] = {--LWin + Num0 : Snap View 0
		viewAngle = 60.000000,--FOV
		hAngle	 = 0.000000,
		vAngle	 = 0.000000,
		x_trans	 = 0.000000,
		y_trans	 = 0.000000,
		z_trans	 = 0.000000,
		rollAngle = 0.000000,
	},
	[2] = {--LWin + Num1 : Snap View 1
		viewAngle = 60.000000,--FOV
		hAngle	 = 0.000000,
		vAngle	 = 0.000000,
		x_trans	 = 0.000000,
		y_trans	 = 0.000000,
		z_trans	 = 0.000000,
		rollAngle = 0.000000,
	},
	[3] = {--LWin + Num2 : Snap View 2
		viewAngle = 60.000000,--FOV
		hAngle	 = 0.000000,
		vAngle	 = 0.000000,
		x_trans	 = 0.000000,
		y_trans	 = 0.000000,
		z_trans	 = 0.000000,
		rollAngle = 0.000000,
	},
	[4] = {--LWin + Num3 : Snap View 3
		viewAngle = 60.000000,--FOV
		hAngle	 = 0.000000,
		vAngle	 = 0.000000,
		x_trans	 = 0.000000,
		y_trans	 = 0.000000,
		z_trans	 = 0.000000,
		rollAngle = 0.000000,
	},
	[5] = {--LWin + Num4 : Snap View 4
		viewAngle = 60.000000,--FOV
		hAngle	 = 0.000000,
		vAngle	 = 0.000000,
		x_trans	 = 0.000000,
		y_trans	 = 0.000000,
		z_trans	 = 0.000000,
		rollAngle = 0.000000,
	},
	[6] = {--LWin + Num5 : Snap View 5
		viewAngle = 60.000000,--FOV
		hAngle	 = 0.000000,
		vAngle	 = 0.000000,
		x_trans	 = 0.000000,
		y_trans	 = 0.000000,
		z_trans	 = 0.000000,
		rollAngle = 0.000000,
	},
	[7] = {--LWin + Num6 : Snap View 6
		viewAngle = 60.000000,--FOV
		hAngle	 = 0.000000,
		vAngle	 = 0.000000,
		x_trans	 = 0.000000,
		y_trans	 = 0.000000,
		z_trans	 = 0.000000,
		rollAngle = 0.000000,
	},
	[8] = {--LWin + Num7 : Snap View 7
		viewAngle = 60.000000,--FOV
		hAngle	 = 0.000000,
		vAngle	 = 0.000000,
		x_trans	 = 0.000000,
		y_trans	 = 0.000000,
		z_trans	 = 0.000000,
		rollAngle = 0.000000,
	},
	[9] = {--LWin + Num8 : Snap View 8
		viewAngle = 60.000000,--FOV
		hAngle	 = 0.000000,
		vAngle	 = 0.000000,
		x_trans	 = 0.000000,
		y_trans	 = 0.000000,
		z_trans	 = 0.000000,
		rollAngle = 0.000000,
	},
	[10] = {--LWin + Num9 : Snap View 9
		viewAngle = 60.000000,--FOV
		hAngle	 = 0.000000,
		vAngle	 = 0.000000,
		x_trans	 = 0.000000,
		y_trans	 = 0.000000,
		z_trans	 = 0.000000,
		rollAngle = 0.000000,
	},
	[11] = {--look at left  mirror
		viewAngle = 60.000000,--FOV
		hAngle	 = 0.000000,
		vAngle	 = 0.000000,
		x_trans	 = 0.000000,
		y_trans	 = 0.000000,
		z_trans	 = 0.000000,
		rollAngle = 0.000000,
	},
	[12] = {--look at right mirror
		viewAngle = 60.000000,--FOV
		hAngle	 = 0.000000,
		vAngle	 = 0.000000,
		x_trans	 = 0.000000,
		y_trans	 = 0.000000,
		z_trans	 = 0.000000,
		rollAngle = 0.000000,
	},
	[13] = {--default view
		viewAngle		= 116.442848,--FOV
		hAngle			= 0.000000,
		vAngle			= 0.000000,
		x_trans			= 0.120896,
		y_trans			= -0.063220,
		z_trans			= 0.000000,
		rollAngle		= 0.000000,
		cockpit_version	= 0,
	},
	[14] = {--default view - VR
		viewAngle		= 84.146729,--FOV
		hAngle			= 0.482289,
		vAngle			= -1.885273,
		x_trans			= 0.180238,
		y_trans			= -0.048741,
		z_trans			= -0.005050,
		rollAngle		= -0.186661,
		cockpit_version	= 0,
	},
},
}