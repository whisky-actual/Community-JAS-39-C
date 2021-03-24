local wsType_HEBOMB = 11033

local HEBOMB = {
	category  = CAT_BOMBS,
	name   = "HEBOMB",
	model    = "SB71LD",  --/N/ you HAVE to use existing 3D model, either Vig custom or some that exist in DCS
	user_name   = _("M/71 HE-Bomb"),
	wsTypeOfWeapon = {wsType_Weapon,wsType_Bomb,wsType_Bomb_A,wsType_HEBOMB},--
	
	scheme = "bomb-common",--"bomb-parashute",--"bomb-sab",
	type = 0,
	mass = 121.0, --!!!!!
	 hMin = 100.0,
	 hMax = 15000.0,
	 Cx = 0.00018, -- T changed 0602 
	 VyHold = -100.0,
	 Ag = -1.23,

	fm =
	{
		mass            = 121.000000, --!!!!!
		caliber         = 0.214000 * 2.0,
		cx_coeff        = {1.000000, 0.290000, 0.710000, 0.140000, 1.280000},
		L               = 2.210000,
		I               = 94.425933,
		Ma              = 2.746331,
		Mw              = 2.146083,
		wind_time       = 1000.000000,
		wind_sigma      = 80.000000,
	},
warhead = warhead["m71"],


	
	shape_table_data =
	{
		{
			name  = "SB71LD",
			file  = "SB71LD", --/N/ you HAVE to use existing 3D model, either Vig custom or some that exist in DCS
			life  = 1,
			fire  = { 0, 1},
			username = "SB71LD",
			index = WSTYPE_PLACEHOLDER,
		},
	},

	targeting_data =
	{
		char_time = 21.02, 
	}

}

declare_weapon(HEBOMB)

declare_loadout(
{
	category			= CAT_BOMBS,
	CLSID				= "{M71BOMB}",
	attribute			= {4,	5,	32,	32},	--attribute			= {4,	5,	9,	wsType_HEBOMB},--{wsType_Weapon,wsType_Bomb,wsType_Bomb_Lighter,wsType_HEBOMB},--WSTYPE_PLACEHOLDER},
	wsTypeOfWeapon		= HEBOMB.wsTypeOfWeapon,
	Count				= 4,
	Cx_pil	=	(HEBOMB.Cx*4)+0.0003,--0.001, -- This needs to be more than the sum of the Cx_pil for the 4 bombs.


	Picture				= "SB71LD.png",
	displayName			= _("4 M/71 HE-Bomb"),--HEBOMB.user_name,
	Weight				=  (HEBOMB.mass * 4) + 125,
Elements	=	{
					[1]	=	
					{
						Position	=	{0,	0,	0},
						ShapeName	=	"PylonM71",
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
						ShapeName	=	"SB71LD",
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
						ShapeName	=	"SB71LD",
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
						ShapeName	=	"SB71LD",
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
						ShapeName	=	"SB71LD",
						Rotation    = 	{0,0,0},
					}, 
				}, -- end of Elements
}
)
