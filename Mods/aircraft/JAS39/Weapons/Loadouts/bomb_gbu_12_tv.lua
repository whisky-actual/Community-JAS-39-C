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


 

local gbu_49_tv =
{
	category		= CAT_BOMBS,
	wsTypeOfWeapon	= {wsType_Weapon, wsType_Bomb, wsType_Bomb_Guided, WSTYPE_PLACEHOLDER},
	type			= 4,
	mass			= 275.0,
	hMin			= 400.0,
	hMax			= 15000.0,
	Cx				= 0.000365,
	VyHold			= -100.0,
	Ag				= -1.0,
	
	name			= "gbu-49",
	model			= "gbu-49",
	user_name		= _("GBU-49 500lb TV Guided Bomb"),   --Note/ made these 49s since they look the same and we already have the laser guided 12s. 
	scheme			= "bomb_jdam",
	class_name		= "wAmmunitionChangeableTrajectory",
	
	warhead = predefined_warhead("GBU_12"),
	warhead_air = predefined_warhead("GBU_12"),
	fm =
    {
        mass			= 275.0,
		wind_time		= 1600.0,
		wind_sigma		= 0,
		A				= 0.6,
		maxAoa			= math.rad(7),
		finsTau			= 0.1,
		dCydA			= {0.066, 0.036},
		caliber			= 0.279000,
		cx_coeff        = {1.0, 0.39, 0.6, 0.168, 1.31},
		L               = 3.00276000,
		Sw				= 0.6,
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
			name     = "gbu-49",
			file     = "gbu-49",
			life     = 1,
			fire     = {0, 1},
			username = _("gbu-49"),
			index    = WSTYPE_PLACEHOLDER,
		},
	},
	
	targeting_data = 
	{
		char_time				= 20.25,
	}
}

declare_weapon(gbu_49_tv)

declare_loadout({
	category 		= CAT_BOMBS,
	CLSID	 		= "JAS_GBU49_TV",
	attribute		= gbu_49_tv.wsTypeOfWeapon,
	Count 			= 1,
	Cx_pil			= gbu_49_tv.Cx,
	Picture			= "gbu12.png",
	displayName		= gbu_49_tv.user_name,
	Weight			= gbu_49_tv.mass,
	Elements	=	{{ShapeName	=	"gbu-49"}},
				



})