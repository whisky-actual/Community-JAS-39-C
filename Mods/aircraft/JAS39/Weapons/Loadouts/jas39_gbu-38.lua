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


 

local jas_gbu_38 =
{
	category		= CAT_BOMBS,
	wsTypeOfWeapon	= {wsType_Weapon, wsType_Bomb, wsType_Bomb_Guided, WSTYPE_PLACEHOLDER},
	type			= 4,
    mass   			= 241.0,
    hMin   			= 300.0,
    hMax   			= 15000.0,
    Cx     			= 0.00074,
    VyHold 			= -100.0,
    Ag     			= -1.23,
	
	name			= "jas_gbu-38",
	model			= "gbu-38",
	user_name		= _("GBU-38 500lb TV Guided Glide-Bomb"),
	scheme			= "bomb_jdam",
	class_name		= "wAmmunitionChangeableTrajectory",
	
	warhead = simple_warhead(180),
	warhead_air = simple_warhead(180),

	fm = {
		mass			= 253.1,
		caliber			= 0.274,
		cx_coeff		= {1, 0.45, 0.8, 0.15, 1.55},
		L				= 0.274/5,
		I				= 65.1,
		I_x				= 2.85,
		wind_time		= 0.0,
		wind_sigma		= 0.0,
		dCydA			= {0.04, 0.022},
		A				= 0.6,
		maxAoa			= math.rad(25),
		finsTau			= 0.1,
		fins_gain		= 100,
		ideal_fins 		= 1,
		Sw				= 0.059*5,
		Ma				= 6.3,
		Mw				= 3.0,
		Ma_x			= 9.5,
		Mw_x			= 3.5,
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
		Kd					= 390.0,
		Ka					= 6.0,
		Tc					= 0.1,
		Kx					= 0.1,
		Krx					= 4.0,
		gload_limit			= 2.5,
		fins_limit			= math.rad(30),
		fins_limit_x		= math.rad(5),
		null_roll			= math.rad(-45),
		KD0					= 0.059 / 253,
		KDI					= 0.6 * 253 / 0.3,
		KLM					= 0.7 * 0.059 * 5 / 253,
	},
	
	shape_table_data =
	{
		{
			name     = "jas_gbu-38",
			file     = "gbu-38",
			life     = 1,
			fire     = {0, 1},
			username = _("GBU38"),
			index    = WSTYPE_PLACEHOLDER,
		},
	},
	
	targeting_data = 
	{
		char_time				= 20.25,
	}
}

declare_weapon(jas_gbu_38)

declare_loadout({
	category 		= CAT_BOMBS,
	CLSID	 		= "JAS39_GBU38",
	attribute		= jas_gbu_38.wsTypeOfWeapon,
	Count 			= 1,
	Cx_pil			= jas_gbu_38.Cx,
	Picture			= "gbu38.png",
	displayName		= jas_gbu_38.user_name,
	Weight			= jas_gbu_38.mass,
	Elements  		= {{ShapeName = "gbu-38"}},
})
