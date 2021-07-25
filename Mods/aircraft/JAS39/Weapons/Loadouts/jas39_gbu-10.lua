local jas39_gbu_10 =
{
	category		= CAT_BOMBS,
	wsTypeOfWeapon	= {wsType_Weapon, wsType_Bomb, wsType_Bomb_Guided, WSTYPE_PLACEHOLDER},
	type			= 4,
	mass			= 934.0,
	hMin			= 1000.0,
	hMax			= 40000.0,
	Cx				= 0.000508, 
	VyHold			= -100.0,
	Ag				= -2.0,
	
	name			= "jas39_gbu-10",
	model			= "gbu-10",
	user_name		= _("GBU-10 2000 lb Laser-guided Bomb"),
	scheme			= "bomb-paveway-III-afm",
	class_name		= "wAmmunitionLaserHoming",
	
	warhead			= predefined_warhead("GBU_10"),
	
	fm =
    {
        mass			= 934.0,
		wind_time		= 1000.0,
		wind_sigma		= 0,
		A				= 0.36,
		maxAoa			= math.rad(7),
		finsTau			= 0.1,
		dCydA			= {0.066, 0.036},
		caliber			= 0.457,
		cx_coeff        = {1.037, 0.91, 0.6, 0.382, 1.34},
		L               = 4.368,
		I				= 1 / 12 * 934.0 * 4.28 * 4.28,
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
			name		= "jas39_gbu-10",
			file		= "gbu-10",
			life		= 1,
			fire		= {0, 1},
			username	= _("GBU10"),
			index		= WSTYPE_PLACEHOLDER,
		},
	},
	
	targeting_data = 
	{
		char_time		= 20.3,
	}
}

declare_weapon(jas39_gbu_10)

declare_loadout({
	category 		= CAT_BOMBS,
	CLSID	 		= "JAS39_GBU10",
	attribute		= jas39_gbu_10.wsTypeOfWeapon,
	Count 			= 1,
	Cx_pil			= jas39_gbu_10.Cx,
	Picture			= "gbu10.png",
	displayName		= jas39_gbu_10.user_name,
	Weight			= jas39_gbu_10.mass,
	Elements  		= {{ShapeName = "gbu-10"}},

})
