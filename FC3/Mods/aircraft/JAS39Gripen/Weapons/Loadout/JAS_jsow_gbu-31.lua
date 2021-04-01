local function KAB(main, fm, autopilot, tgdata)
	local t = main
	
	t.category  = CAT_BOMBS
	t.wsTypeOfWeapon = {wsType_Weapon, wsType_Bomb, wsType_Bomb_Guided, WSTYPE_PLACEHOLDER}
    t.hMin    = 1000.0
    t.VyHold  = -80.0
    t.Ag      = -1.0
	
	t.fm				= fm
	
	t.fm.mass			= t.mass
	t.fm.wind_time		= 1000.000000
	t.fm.wind_sigma		= 0
	t.fm.A				= 0.6
	t.fm.maxAoa			= math.rad(7)
	t.fm.finsTau		= 0.1
	t.fm.dCydA			= {0.066, 0.036}
	
	t.bang_bang_autopilot = autopilot
	t.targeting_data = tgdata

	t.shape_table_data ={
		{
			name     = t.name,
			file     = t.model,
			life     = 1,
			fire     = {0, 1},
			username = t.user_name,
			index    = WSTYPE_PLACEHOLDER,
		},
	}
	
	declare_weapon(t)
	return t
end


 KAB_1500T = KAB({
	--main--
	Name    		= KAB_1500T,
	name			= "KAB_1500T",
	type			= 3,
	model			= "kab-1500t",
	user_name		= _("KAB-1500Kr"),
	mass			= 1525,
	hMax    		= 15000.0,
    Cx      		= 0.00436,
	scheme			= "bomb_guided_pn",
	class_name		= "wAmmunitionSelfHoming",
   	warhead			= predefined_warhead("KAB_1500F"),
},
{	--fm--
	caliber			= 0.58,
	cx_coeff        = {1.000000, 0.400000, 0.370000, 0.288000, 1.310000},
	L               = 4.63,
	Sw				= 3.4,
	dCydA			= {0.066, 0.036}
},
{	--bang_bang_autopilot--
	Kg			= 0.25,
	Ki			= 0.0,
	finsLimit	= 0.35,
	delay		= 2.0
},
{	--targeting_data--
	char_time = 20.46
})

declare_loadout({
	category 		= CAT_BOMBS,
	CLSID	 		= "{KAB_1500Kr_LOADOUT}",
	attribute		= KAB_1500T.wsTypeOfWeapon,
	Count 			= 1,
	Cx_pil			= KAB_1500T.Cx,
	Picture			= "kab1500kr.png",
	displayName		= KAB_1500T.user_name,
	Weight			= KAB_1500T.mass,
	Elements  		= {{ShapeName = "kab-1500t"}},
})


local KAB_1500LG =
{
	category		= CAT_BOMBS,
	wsTypeOfWeapon	= {wsType_Weapon, wsType_Bomb, wsType_Bomb_Guided, WSTYPE_PLACEHOLDER},
	type			= 4,
	mass			= 1525.0,
	hMin			= 1000.0,
	hMax			= 10000.0,
	Cx				= 0.00133,
	VyHold			= -80.0,
	Ag				= -1.0,
	
	name			= "KAB_1500LG",
	model			= "kab-1500lg",
	user_name		= _("KAB-1500LG-Pr"),
	scheme			= "bomb-paveway-III-afm",
	class_name		= "wAmmunitionLaserHoming",
	
	warhead			= predefined_warhead("KAB_1500Kr"),
	
	fm =
    {
        mass			= 1525,
		wind_time		= 1000.0,
		wind_sigma		= 0,
		A				= 0.6,
		maxAoa			= math.rad(7),
		finsTau			= 0.1,
		dCydA			= {0.066, 0.036},
		caliber			= 0.58,
		cx_coeff        = {1.0, 0.4, 0.37, 0.288, 1.31},
		L               = 4.28,
		I				= 1 / 12 * 1525 * 4.28 * 4.28,
		Sm				= 0.2642,
		Sw				= 1.5,
		Ma				= 0.85,
		Mw				= 4.55,
		Ma_x			= 0.9,
		Ma_z			= 0.5,
		Mw_x			= 2.0,
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
			name		= "KAB_1500LG",
			file		= "kab-1500lg",
			life		= 1,
			fire		= {0, 1},
			username	= _("KAB-1500LG-Pr"),
			index		= WSTYPE_PLACEHOLDER,
		},
	},
	
	targeting_data = 
	{
		char_time		= 20.3,
	}
}

declare_weapon(KAB_1500LG)

declare_loadout({
	category 		= CAT_BOMBS,
	CLSID	 		= "{KAB_1500LG_LOADOUT}",
	attribute		= KAB_1500LG.wsTypeOfWeapon,
	Count 			= 1,
	Cx_pil			= KAB_1500LG.Cx,
	Picture			= "kab1500lg.png",
	displayName		= KAB_1500LG.user_name,
	Weight			= KAB_1500LG.mass,
	Elements  		= {{ShapeName = "kab-1500lg"}},
})


local gbu_31 =
{
	category		= CAT_BOMBS,
	wsTypeOfWeapon	= {wsType_Weapon, wsType_Bomb, wsType_Bomb_Guided, WSTYPE_PLACEHOLDER},
	type			= 4,
	mass			= 500.0,
	hMin			= 1000.0,
	hMax			= 10000.0,
	Cx				= 0.00133,
	VyHold			= -80.0,
	Ag				= -1.0,
	
	name			= "gbu-31",
	model			= "gbu-31",
	user_name		= _("GBU-31"),
	scheme			= "bomb_jdam",
	class_name		= "wAmmunitionChangeableTrajectory",
	
	warhead = simple_warhead(850, 457),
	warhead_air = simple_warhead(850, 457),
	fm =
    {
        mass			= 500,
		wind_time		= 1000.0,
		wind_sigma		= 0,
		A				= 0.6,
		maxAoa			= math.rad(7),
		finsTau			= 0.1,
		dCydA			= {0.066, 0.036},
		caliber			= 0.4,
		cx_coeff        = {1.0, 0.39, 0.6, 0.168, 1.31},
		L               = 3.00,
		Sw				= 0.8,
		Ma_x			= 0.5,
		Ma_z			= 0.5,
		Kw_x			= 0.03,
		model_roll 		= math.rad(-45),
    },  
	
	seeker = {
		coalition				= 1,
		coalition_rnd_coeff		= 5.0,
	},
	
	autopilot = {
		delay				= 1.0,
		op_time				= 9000,
		Tf					= 0.05,
		Knav				= 3.0,
		Kd					= 390.0,
		Ka					= 6.0,
		Tc					= 0.1,
		Kx					= 0.4,
		Krx					= 4.0,
		gload_limit			= 2.5,
		fins_limit			= math.rad(40),
		fins_limit_x		= math.rad(5),
		null_roll			= math.rad(-45),
		
		KD0					= 0.125 / 500,
		KDI					= 0.6 * 500 / 0.3,
		KLM					= 0.8 * 0.125 * 6 / 500,
	},
	
	shape_table_data =
	{
		{
			name     = "gbu-31",
			file     = "gbu-31",
			life     = 1,
			fire     = {0, 1},
			username = _("gbu-31"),
			index    = WSTYPE_PLACEHOLDER,
		},
	},
	
	targeting_data = 
	{
		char_time				= 20.25,
	}
}

declare_weapon(gbu_31)

declare_loadout({
	category 		= CAT_BOMBS,
	CLSID	 		= "JAS_GBU31",
	attribute		= gbu_31.wsTypeOfWeapon,
	Count 			= 1,
	Cx_pil			= gbu_31.Cx,
	Picture			= "gbu31.png",
	displayName		= gbu_31.user_name,
	Weight			= gbu_31.mass,
	Elements  		= {{ShapeName = "gbu-31"}},
})
