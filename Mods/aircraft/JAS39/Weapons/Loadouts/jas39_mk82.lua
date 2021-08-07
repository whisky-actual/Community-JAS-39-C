local jas39_mk82_name = 'Mk-82 500 lb GP Bomb'
local jas39_mk82_mass = 232

local jas39_MK82_BOMB = {
	category  = CAT_BOMBS,
	name   = jas39_mk82_name,
	model    = "mk-82",  
	user_name   = _(jas39_mk82_name),
	wsTypeOfWeapon = {wsType_Weapon,wsType_Bomb,wsType_Bomb_A,WSTYPE_PLACEHOLDER},
	
	scheme = "bomb-common",
	type    = 0,
	mass    = 241.0,
	hMin    = 100.0,
	hMax    = 12000.0,
	Cx      = 0.00016,
	VyHold  = -100.0,
	Ag      = -1.23,

	warhead = simple_warhead(180),
	warhead_air = simple_warhead(180),

	fm =
	{
		mass            = jas39_mk82_mass,
		caliber         = 0.273000,
		cx_coeff        = {1.000000, 0.290000, 0.710000, 0.140000, 1.280000},
		L               = 2.210000,
		I               = 94.425933,
		Ma              = 2.746331,
		Mw              = 2.146083,
		wind_time       = 1000.000000,
		wind_sigma      = 80.000000,
	},

	shape_table_data =
	{
		{
			name  = "jas39_mk82_name",
			file  = "mk-82", 
			life  = 1,
			fire  = { 0, 1},
			username = "MK82",
			index = WSTYPE_PLACEHOLDER,
		},
	},

	targeting_data =
	{
		char_time = 20.320000, 
	}

}

declare_weapon(jas39_MK82_BOMB)

declare_loadout({
	category 		= CAT_BOMBS,
	CLSID	 		= "{JAS39_MK82}",
	attribute		= jas39_MK82_BOMB.wsTypeOfWeapon,
	Count 			= 1,
	Cx_pil			= jas39_MK82_BOMB.Cx,
	Picture			= "gbu12.png",
	displayName		= jas39_MK82_BOMB.user_name,
	Weight			= jas39_MK82_BOMB.mass,
	Elements  		= {{ShapeName = "mk-82"}},

})

declare_loadout({
	category 		= CAT_BOMBS,
	CLSID	 		= "{JAS39_BRU33_MK82}",
	wsTypeOfWeapon	= jas39_MK82_BOMB.wsTypeOfWeapon,
	attribute		= {4, 5, 32, WSTYPE_PLACEHOLDER},
	Count 			= 2,
	Cx_pil			= jas39_MK82_BOMB.Cx,
	Picture			= "mk83.png",
	displayName		= _('2 x ' .. jas39_MK82_BOMB.user_name),
	Weight			= (jas39_MK82_BOMB.mass * 2) + 75,
	Elements = { {
			IsAdapter = true,
			ShapeName = "BRU_33A"
		}, {
			ShapeName = "mk-82",
			connector_name = "Point02"
		}, {
			ShapeName = "mk-82",
			connector_name = "Point01"
		} },
})
