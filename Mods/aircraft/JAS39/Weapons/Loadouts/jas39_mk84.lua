local jas39_mk84_name = 'Mk-84 2000 lb GP Bomb'
local jas39_mk84_mass = 894

local jas39_mk84_BOMB = {
	category  = CAT_BOMBS,
	name   = jas39_mk84_name,
	model    = "mk-84",  
	user_name   = _(jas39_mk84_name),
	wsTypeOfWeapon = {wsType_Weapon,wsType_Bomb,wsType_Bomb_A,WSTYPE_PLACEHOLDER},
	
	scheme = "bomb-common",
	type    = 0,
	mass    = 894.0,
	hMin    = 300.0,
	hMax    = 12000.0,
	Cx      = 0.000357,
	VyHold  = -100.0,
	Ag      = -1.23,

	warhead = simple_warhead(850),
	warhead_air = simple_warhead(850),

	fm =
	{
		mass            = jas39_mk84_mass,
		caliber         = 0.457000,
		cx_coeff        = {1.000000, 0.390000, 0.60000, 0.1680000, 1.310000},
		L               = 2.5,
		I               = 864.446267,
		Ma              = 2.746331,
		Mw              = 2.146083,
		wind_time       = 1000.000000,
		wind_sigma      = 220.000000,
	},

	shape_table_data =
	{
		{
			name  = "jas39_mk84_name",
			file  = "mk-84", 
			life  = 1,
			fire  = { 0, 1},
			username = "MK84",
			index = WSTYPE_PLACEHOLDER,
		},
	},

	targeting_data =
	{
		char_time = 20.318, 
	}

}

declare_weapon(jas39_mk84_BOMB)

declare_loadout({
	category 		= CAT_BOMBS,
	CLSID	 		= "{JAS39_MK84}",
	attribute		= jas39_mk84_BOMB.wsTypeOfWeapon,
	Count 			= 1,
	Cx_pil			= jas39_mk84_BOMB.Cx,
	Picture			= "mk84.png",
	displayName		= jas39_mk84_BOMB.user_name,
	Weight			= jas39_mk84_BOMB.mass,
	Elements  		= {{ShapeName = "mk-84"}},
})
