local jas39_gbu_16 =
{
	category		= CAT_BOMBS,
	wsTypeOfWeapon	= {wsType_Weapon, wsType_Bomb, wsType_Bomb_Guided, WSTYPE_PLACEHOLDER},
	type			= 4,
	mass			= 454.000000,
	hMin			= 1000.0,
	hMax			= 40000.0,
	Cx				= 0.000410,
	VyHold			= -100.0,
	Ag				= -2.0,
	
	name			= "jas39_gbu-16",
	model			= "gbu-16",
	user_name		= _("GBU-16 1000 lb Laser-guided Bomb"),
	scheme			= "bomb-paveway-III-afm",
	class_name		= "wAmmunitionLaserHoming",
	
	warhead			= predefined_warhead("GBU_16"),
	
	fm =
    {
        mass			= 454.000000,
		wind_time		= 1000.0,
		wind_sigma		= 0,
		A				= 0.36,
		maxAoa			= math.rad(7),
		finsTau			= 0.1,
		dCydA			= {0.066, 0.036},
		caliber			= 0.356000,
		cx_coeff        = {1.000000, 0.290000, 0.710000, 0.130000, 1.280000},
		L               = 4.050000,
		I				= 1 / 12 * 454.0 * 4.28 * 4.28,
		Sm				= 0.2642,
		Sw				= 0.6,
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
			name		= "jas39_gbu-16",
			file		= "gbu-16",
			life		= 1,
			fire		= {0, 1},
			username	= _("GBU16"),
			index		= WSTYPE_PLACEHOLDER,
		},
	},
	
	targeting_data = 
	{
		char_time		= 20.280000,
	}
}

declare_weapon(jas39_gbu_16)

declare_loadout({
	category 		= CAT_BOMBS,
	CLSID	 		= "JAS39_GBU16",
	attribute		= jas39_gbu_16.wsTypeOfWeapon,
	Count 			= 1,
	Cx_pil			= jas39_gbu_16.Cx,
	Picture			= "gbu16.png",
	displayName		= jas39_gbu_16.user_name,
	Weight			= jas39_gbu_16.mass,
	Elements  		= {{ShapeName = "gbu-16"}},

})
