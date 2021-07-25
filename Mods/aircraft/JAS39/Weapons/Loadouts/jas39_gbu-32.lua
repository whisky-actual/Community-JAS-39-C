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


 

local jas_gbu_32 =
{
	category		= CAT_BOMBS,
	wsTypeOfWeapon	= {wsType_Weapon, wsType_Bomb, wsType_Bomb_Guided, WSTYPE_PLACEHOLDER},
	type			= 4,
	mass   			= 454.0,
	hMin   			= 1000.0,
	hMax   			= 40000.0,
	Cx     			= 0.000410,
	VyHold 			= -100.0,
	Ag     			= -2.0,
	
	name			= "jas_gbu-32",
	model			= "gbu-32",
	user_name		= _("GBU-32 1000lb TV Guided Glide-Bomb"),
	scheme			= "bomb_jdam",
	class_name		= "wAmmunitionChangeableTrajectory",
	
	warhead = simple_warhead(400),
	warhead_air = simple_warhead(400),

	fm =
    {
		mass			= 467.0,
		caliber			= 0.356,
		cx_coeff		= {1, 0.45, 0.8, 0.15, 1.55},
		L				= 0.356,
		I				= 202.5,
		I_x				= 8.2,
		wind_time		= 0.0,
		wind_sigma		= 0.0,
		dCydA			= {0.066, 0.036},
		A				= 0.6,
		maxAoa			= math.rad(25),
		finsTau			= 0.1,
		fins_gain		= 100,
		ideal_fins 		= 1,
		finsTau			= 0.1,
		Sw				= 0.1*3,
		Ma				= 6.3,
		Mw				= 3.0,
		Ma_x			= 1.5,
		Mw_x			= 6.5,
		model_roll 		= math.rad(-45),
    },
	
	seeker = {
		CEP 					= 5.0,
		coalition				= 2,
		coalition_rnd_coeff		= 5.0,
	},
	
	autopilot = {
		delay				= 1.0,
		op_time				= 9000,
		Tf					= 0.05,
		Knav				= 3.0,
		Kd					= 690.0,
		Ka					= 10.0,
		Tc					= 0.1,
		Kx					= 0.4,
		Krx					= 4.0,
		gload_limit			= 3.0,
		fins_limit			= math.rad(35),
		fins_limit_x		= math.rad(5),
		null_roll			= math.rad(-45),
		KD0					= 0.1 / 467,
		KDI					= 0.6 * 467 / 0.3,
		KLM					= 1.2 * 0.1 * 3 / 467,
	},
	
	shape_table_data =
	{
		{
			name     = "jas_gbu-32",
			file     = "gbu-32",
			life     = 1,
			fire     = {0, 1},
			username = _("GBU32"),
			index    = WSTYPE_PLACEHOLDER,
		},
	},
	
	targeting_data = 
	{
		char_time				= 20.25,
	}
}

declare_weapon(jas_gbu_32)

declare_loadout({
	category 		= CAT_BOMBS,
	CLSID	 		= "JAS39_GBU32",
	attribute		= jas_gbu_32.wsTypeOfWeapon,
	Count 			= 1,
	Cx_pil			= jas_gbu_32.Cx,
	Picture			= "gbu32.png",
	displayName		= jas_gbu_32.user_name,
	Weight			= jas_gbu_32.mass,
	Elements  		= {{ShapeName = "gbu-32"}},
})
