local jas39_gbu_12 =
{
	category		= CAT_BOMBS,
	wsTypeOfWeapon	= {wsType_Weapon, wsType_Bomb, wsType_Bomb_Guided, WSTYPE_PLACEHOLDER},
	type			= 4,
	mass			= 275.0,
	hMin			= 1000.0,
	hMax			= 10000.0,
	Cx				= 0.000010, --0.00133
	VyHold			= -80.0,
	Ag				= -1.0,
	
	name			= "jas39_gbu-12",
	model			= "gbu-12",
	user_name		= _("GBU-12 500 lb Laser-guided Bomb"),
	scheme			= "bomb-paveway-III-afm",
	class_name		= "wAmmunitionLaserHoming",
	
	warhead			= predefined_warhead("GBU_12"),
	
	fm =
    {
        mass			= 275.0,
		wind_time		= 1000.0,
		wind_sigma		= 0,
		A				= 0.6,
		maxAoa			= math.rad(7),
		finsTau			= 1.1,
		dCydA			= {0.066, 0.036},
		caliber			= 0.58,
		cx_coeff        = {1.0, 0.4, 0.37, 0.288, 1.31},
		L               = 6.276000,
		I				= 1 / 12 * 1525 * 4.28 * 4.28,
		Sm				= 0.2642,
		Sw				= 0.5,
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
			name		= "jas39_gbu-12",
			file		= "gbu-12",
			life		= 1,
			fire		= {0, 1},
			username	= _("GBU12"),
			index		= WSTYPE_PLACEHOLDER,
		},
	},
	
	targeting_data = 
	{
		char_time		= 20.3,
	}
}

declare_weapon(jas39_gbu_12)

declare_loadout({
	category 		= CAT_BOMBS,
	CLSID	 		= "JAS39_GBU12",
	attribute		= jas39_gbu_12.wsTypeOfWeapon,
	Count 			= 1,
	Cx_pil			= jas39_gbu_12.Cx,
	Picture			= "gbu12.png",
	displayName		= jas39_gbu_12.user_name,
	Weight			= jas39_gbu_12.mass,
	Elements  		= {{ShapeName = "gbu-12"}},





--[[Elements	=	
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
						ShapeName	=	"jas39_gbu-12",
				
					}, 
				}, -- end of Elements



--]]
})
