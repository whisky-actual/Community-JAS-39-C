
declare_loadout (
{
	CLSID	=	"JAS_BK90",
	Picture	=	"BK_90.png",
	displayName	=	_("BK-90"),
	Weight	=	605,
	wsTypeOfWeapon = {wsType_Weapon, wsType_Bomb, wsType_Bomb_Cluster}
	attribute	=	{4,	5,	38,	35},
	Count = 1,
	Cx_pil = 0.000413,
	
	
	
	Elements	=	
	{
		[1]	=	
		{
			DrawArgs	=	
			{
				[1]	=	{1,	1},
				[2]	=	{2,	1},
			}, -- end of DrawArgs
			Position	=	{0,	0,	0},
			ShapeName	=	"BK_90",
		}, 
	}, -- end of Elements
} )
