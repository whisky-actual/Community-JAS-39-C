gbu10 =
{
	category		= CAT_BOMBS,
	wsTypeOfWeapon	= {wsType_Weapon, wsType_Bomb, wsType_Bomb_Guided, WSTYPE_PLACEHOLDER},
	type			= 4,
	mass			= 934.0,
	hMin			= 1000.0,
	hMax			= 10000.0,
	Cx				= 0.00133,
	VyHold			= -80.0,
	Ag				= -1.0,
	
	name			= "gbu-10",
	model			= "gbu-10",
	user_name		= _("gbu-10"),
	scheme			= "bomb-paveway-III-afm",
	class_name		= "wAmmunitionLaserHoming",
	
	warhead			= predefined_warhead("GBU_10"),
	
	fm =
    {
        mass			= 934.0,
		wind_time		= 1000.0,
		wind_sigma		= 0,
		A				= 0.6,
		maxAoa			= math.rad(7),
		finsTau			= 0.1,
		dCydA			= {0.066, 0.036},
		caliber			= 0.58,
		cx_coeff        = {1.0, 0.4, 0.37, 0.288, 1.31},
		L               = 4.368,
		I				= 1 / 12 * 1525 * 4.28 * 4.28,
		Sm				= 0.2642,
		Sw				= 2 * 1.75 * math.pow(24 * 2.45 * 0.01 / math.sin(2 * math.pi / 6), 2) / 2.5,
		Ma				= 0.85,
		Mw				= 4.55,
		Ma_x			= 0.1,
		Ma_z			= 0.5,
		Mw_x			= 1.0,
    },
	
	autopilot = {	
		K					= 1.0,
		Kg					= 0.3,
		Ki					= 0.0,
		finsLimit			= 0.7,
	},
	
	shape_table_data =
	{
		{
			name		= "gbu-10",
			file		= "gbu-10",
			life		= 1,
			fire		= {0, 1},
			username	= _("gbu10"),
			index		= WSTYPE_PLACEHOLDER,
		},
	},
	
	targeting_data = 
	{
		char_time		= 20.3,
	}
}

declare_weapon(gbu10)

declare_loadout({
	category 		= CAT_BOMBS,
	CLSID	 		= "JAS_GBU10",
	attribute		= gbu10.wsTypeOfWeapon,
	Count 			= 1,
	Cx_pil			= gbu10.Cx,
	Picture			= "gbu10.png",
	displayName		= gbu10.user_name,
	Weight			= gbu10.mass,
	Elements  		= {{ShapeName = "gbu-10"}},





Elements	=	
				{
					[1]	=	
					{
						Position	=	{0,	0,	0},
						ShapeName	=	"",
					}, 
					[2]	=	
					{
						DrawArgs	=	
						{
							[1]	=	{1,	1},
							[2]	=	{2,	1},
						}, -- end of DrawArgs
						Position	=	{0,	0.0, -0.70},--8.00    7.30
						ShapeName	=	"gbu-10",
				
					}, 
				}, -- end of Elements




})
