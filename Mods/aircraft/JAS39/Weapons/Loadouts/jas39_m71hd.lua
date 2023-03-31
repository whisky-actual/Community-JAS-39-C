local jas39_m71hd_name = 'M/71 120 kg GP Bomb High-drag'
local jas39_m71hd_mass = 120

local jas39_M71HD_BOMB = {
	category  = CAT_BOMBS,
	name   = "M71HD",
	model    = "jas39_M71HD",  
	user_name   = _(jas39_m71hd_name),
	wsTypeOfWeapon = {wsType_Weapon,wsType_Bomb,wsType_Bomb_A,WSTYPE_PLACEHOLDER},
	
	scheme = "bomb-parashute",
	type = 0,
	mass = jas39_m71hd_mass,
	hMin = 100.0,
	hMax = 15000.0,
	Cx = 0.00018, 
	VyHold = -100.0,
	Ag = -1.23,

	fm =
	{
		mass            = jas39_m71hd_mass,
		caliber         = 0.214000 * 2.0,
		cx_coeff        = {1.000000, 0.290000, 0.710000, 0.140000, 1.280000},
		L               = 2.210000,
		I               = 94.425933,
		Ma              = 2.746331,
		Mw              = 2.146083,
		wind_time       = 1000.000000,
		wind_sigma      = 80.000000,
		cx_factor   	= 30,
	},
warhead = simple_warhead(125,450); -- Explosive 60 kg + fragments bonus


	
	shape_table_data =
	{
		{
			name  = "jas39_M71HD",
			file  = "jas39_M71HD", 
			life  = 1,
			fire  = { 0, 1},
			username = "M71HD",
			index = WSTYPE_PLACEHOLDER,
		},
	},

control = 
    {
        open_delay = 1.0,
		delay_par   = 1.0,
    },

	targeting_data = 
	{	
		v0 = 500,
		data = 
		{
			{1.000000, 21.147949, 0.002807},
			{10.000000, 28.262668, -0.017193},
			{20.000000, 29.687629, -0.016767},
			{30.000000, 30.394407, -0.015892},
			{40.000000, 30.826322, -0.015080},
			{50.000000, 31.133114, -0.014428},
			{60.000000, 31.361560, -0.013889},
			{70.000000, 31.543970, -0.013440},
			{80.000000, 31.690640, -0.013045},
			{90.000000, 31.814418, -0.012713},
			{100.000000, 31.920050, -0.012425},
			{200.000000, 32.511629, -0.010723},
			{300.000000, 32.789778, -0.009863},
			{400.000000, 32.963413, -0.009307},
			{500.000000, 33.086372, -0.008907},
			{600.000000, 33.179450, -0.008596},
			{700.000000, 33.253103, -0.008346},
			{800.000000, 33.312920, -0.008139},
			{900.000000, 33.362577, -0.007968},
			{1000.000000, 33.404350, -0.007824},
			{1100.000000, 33.439925, -0.007702},
			{1200.000000, 33.470498, -0.007599},
			{1300.000000, 33.496988, -0.007513},
			{1400.000000, 33.520106, -0.007440},
			{1500.000000, 33.540403, -0.007378},
			{1600.000000, 33.558365, -0.007327},
			{1700.000000, 33.574326, -0.007285},
			{1800.000000, 33.588629, -0.007251},
			{1900.000000, 33.601489, -0.007224},
			{2000.000000, 33.613137, -0.007202},
			{3000.000000, 33.690673, -0.007191},
			{4000.000000, 33.737805, -0.007357},
			{5000.000000, 33.773738, -0.007590},
			{6000.000000, 33.802367, -0.007864},
			{7000.000000, 33.824277, -0.008170},
			{8000.000000, 33.839206, -0.008505},
			{9000.000000, 33.846586, -0.008868},
			{10000.000000, 33.845625, -0.009258},
		}    
	},

}

declare_weapon(jas39_M71HD_BOMB)

declare_loadout(
{
	category			= CAT_BOMBS,
	CLSID				= "{JAS39_M71HD}",
	attribute			= {4,	5,	32,	32},	
	wsTypeOfWeapon		= jas39_M71HD_BOMB.wsTypeOfWeapon,
	Count				= 4,
	Cx_pil	=			(jas39_M71HD_BOMB.Cx*4)+0.0003,


	Picture				= "jas39_M71HD.png",
	displayName			= _('4 x ' .. jas39_m71hd_name),
	Weight				=  (jas39_m71hd_mass * 4) + 125,
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
						ShapeName	=	"jas39_M71HD",
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
						ShapeName	=	"jas39_M71HD",
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
						ShapeName	=	"jas39_M71HD",
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
						ShapeName	=	"jas39_M71HD",
						Rotation    = 	{0,0,0},
					}, 
				}, -- end of Elements
}
)
