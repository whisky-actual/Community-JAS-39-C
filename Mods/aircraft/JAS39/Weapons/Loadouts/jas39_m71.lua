local jas39_m70ld_name = 'M/71 120 kg GP Bomb Low-drag '
local jas39_m70ld_mass = 120

local jas39_M71LD_BOMB = {
	category  = CAT_BOMBS,
	name   = "M71LD",
	model    = "jas39_M71LD",  
	user_name   = _(jas39_m70ld_name),
	wsTypeOfWeapon = {wsType_Weapon,wsType_Bomb,wsType_Bomb_A,WSTYPE_PLACEHOLDER},
	
	scheme = "bomb-common",
	type = 0,
	mass = jas39_m70ld_mass,
	hMin = 100.0,
	hMax = 15000.0,
	Cx = 0.00018, 
	VyHold = -100.0,
	Ag = -1.23,

	fm =
	{
		mass            = jas39_m70ld_mass,
		caliber         = 0.214000 * 2.0,
		cx_coeff        = {1.000000, 0.290000, 0.710000, 0.140000, 1.280000},
		L               = 2.210000,
		I               = 94.425933,
		Ma              = 2.746331,
		Mw              = 2.146083,
		wind_time       = 1000.000000,
		wind_sigma      = 80.000000,
	},
warhead = simple_warhead(125,450); -- Explosive 60 kg + fragments bonus


	
	shape_table_data =
	{
		{
			name  = "jas39_M71LD",
			file  = "jas39_M71LD", 
			life  = 1,
			fire  = { 0, 1},
			username = "M71LD",
			index = WSTYPE_PLACEHOLDER,
		},
	},

	targeting_data =
	{
		char_time = 21.02, 
	}

}

declare_weapon(jas39_M71LD_BOMB)

declare_loadout(
{
	category			= CAT_BOMBS,
	CLSID				= "{JAS39_M71LD}",
	attribute			= {4,	5,	32,	32},	
	wsTypeOfWeapon		= jas39_M71LD_BOMB.wsTypeOfWeapon,
	Count				= 4,
	Cx_pil	=			(jas39_M71LD_BOMB.Cx*4)+0.0003,


	Picture				= "jas39_M71LD.png",
	displayName			= _('4 x ' .. jas39_m70ld_name),
	Weight				=  (jas39_m70ld_mass * 4) + 125,
Elements	=	{
					[1]	=	
					{
						Position	=	{0,	0,	0},
						ShapeName	=	"jas39_PylonM71",
						IsAdapter 	= true,
					}, 
					[2]	=	
					{ -- Back left
						DrawArgs	=	
						{
							[1]	=	{1,	1},
							[2]	=	{2,	1},
						}, -- end of DrawArgs
						Position	=	{-0.674,	-0.343,	-0.217},
						ShapeName	=	"jas39_M71LD",
						Rotation    = 	{0,0,0},
					}, 
					[3]	=	
					{ -- Back right
						DrawArgs	=	
						{
							[1]	=	{1,	1},
							[2]	=	{2,	1},
						}, -- end of DrawArgs
						Position	=	{-0.674,	-0.343, 0.217},
						ShapeName	=	"jas39_M71LD",
						Rotation    = 	{0,0,0},
					}, 
					[4]	=	
					{ -- Front left
						DrawArgs	=	
						{
							[1]	=	{1,	1},
							[2]	=	{2,	1},
						}, -- end of DrawArgs
						Position	=	{1.275,	-0.343, -0.217},
						ShapeName	=	"jas39_M71LD",
						Rotation    = 	{0,0,0},
					}, 
					[5]	=	
					{ -- Front right
						DrawArgs	=	
						{
							[1]	=	{1,	1},
							[2]	=	{2,	1},
						}, -- end of DrawArgs
						Position	=	{1.275,	-0.343, 0.217},
						ShapeName	=	"jas39_M71LD",
						Rotation    = 	{0,0,0},
					}, 
				}, -- end of Elements
}
)
