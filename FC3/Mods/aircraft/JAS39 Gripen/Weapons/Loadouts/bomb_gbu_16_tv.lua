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


 

local gbu_16_tv =
{
	category		= CAT_BOMBS,
	wsTypeOfWeapon	= {wsType_Weapon, wsType_Bomb, wsType_Bomb_Guided, WSTYPE_PLACEHOLDER},
	type			= 4,
	mass			= 934.0,
	hMin			= 400.0,
	hMax			= 15000.0,
	Cx				= 0.00133,
	VyHold			= -80.0,
	Ag				= -1.0,
	
	name			= "gbu-16",
	model			= "gbu-16",
	user_name		= _("GBU-16 1000lb TV Guided Bomb"),
	scheme			= "bomb_jdam",
	class_name		= "wAmmunitionChangeableTrajectory",
	
	warhead = predefined_warhead("GBU_16"),
	warhead_air = predefined_warhead("GBU_16"),
	fm =
    {
        mass			= 934.0,
		wind_time		= 1600.0,
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
		model_roll 		= 0,
    },  
	
	seeker = {
		coalition				= 0,
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
			name     = "gbu-16",
			file     = "gbu-16",
			life     = 1,
			fire     = {0, 1},
			username = _("gbu-16"),
			index    = WSTYPE_PLACEHOLDER,
		},
	},
	
	targeting_data = 
	{
		char_time				= 20.25,
	}
}

declare_weapon(gbu_16_tv)

declare_loadout({
	category 		= CAT_BOMBS,
	CLSID	 		= "JAS_GBU16_TV",
	attribute		= gbu_16_tv.wsTypeOfWeapon,
	Count 			= 1,
	Cx_pil			= gbu_16_tv.Cx,
	Picture			= "gbu16.png",
	displayName		= gbu_16_tv.user_name,
	Weight			= gbu_16_tv.mass,
	Elements  		= {{ShapeName = "gbu-16"}},
})
