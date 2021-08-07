local jas39_mk83_name = 'Mk-83 1000 lb GP Bomb'
local jas39_mk83_mass = 447

local jas39_mk83_BOMB = {
	category  = CAT_BOMBS,
	name   = jas39_mk83_name,
	model    = "mk-83",  
	user_name   = _(jas39_mk83_name),
	wsTypeOfWeapon = {wsType_Weapon,wsType_Bomb,wsType_Bomb_A,WSTYPE_PLACEHOLDER},
	
	scheme = "bomb-common",
	type    = 0,
	mass    = 447.0,
	hMin    = 200.0,
	hMax    = 12000.0,
	Cx      = 0.000225,
	VyHold  = -100.0,
	Ag      = -1.23,

	warhead = simple_warhead(400),
	warhead_air = simple_warhead(400),

	fm =
	{
		mass            = jas39_mk83_mass,
		caliber         = 0.356000,
		cx_coeff        = {1.000000, 0.290000, 0.710000, 0.130000, 1.280000},
		L               = 3.000000,
		I               = 340.500000,
		Ma              = 2.746331,
		Mw              = 2.146083,
		wind_time       = 1000.000000,
		wind_sigma      = 150.000000,
	},

	shape_table_data =
	{
		{
			name  = "jas39_mk83_name",
			file  = "mk-83", 
			life  = 1,
			fire  = { 0, 1},
			username = "MK83",
			index = WSTYPE_PLACEHOLDER,
		},
	},

	targeting_data =
	{
		char_time = 20.280000, 
	}

}

declare_weapon(jas39_mk83_BOMB)

declare_loadout({
	category 		= CAT_BOMBS,
	CLSID	 		= "{JAS39_MK83}",
	attribute		= jas39_mk83_BOMB.wsTypeOfWeapon,
	Count 			= 1,
	Cx_pil			= jas39_mk83_BOMB.Cx,
	Picture			= "mk83.png",
	displayName		= jas39_mk83_BOMB.user_name,
	Weight			= jas39_mk83_BOMB.mass,
	Elements  		= {{ShapeName = "mk-83"}},

})

declare_loadout({
	category 		= CAT_BOMBS,
	CLSID	 		= "{JAS39_BRU33_MK83}",
	wsTypeOfWeapon	= jas39_mk83_BOMB.wsTypeOfWeapon,
	attribute		= {4, 5, 32, WSTYPE_PLACEHOLDER},
	Count 			= 2,
	Cx_pil			= jas39_mk83_BOMB.Cx,
	Picture			= "mk83.png",
	displayName		= _('2 x ' .. jas39_mk83_BOMB.user_name),
	Weight			= (jas39_mk83_BOMB.mass * 2) + 75,
	Elements = { {
			IsAdapter = true,
			ShapeName = "BRU_33A"
		}, {
			ShapeName = "mk-83",
			connector_name = "Point02"
		}, {
			ShapeName = "mk-83",
			connector_name = "Point01"
		} },
})

