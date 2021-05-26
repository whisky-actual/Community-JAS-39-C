local brimstone_warhead =
{
    mass                 = 6.3, 
    caliber              = 120,
    expl_mass            = 6.3,
    piercing_mass        = 6.3*1.2,
    other_factors        = { 1.0, 1.0, 1.0 },
    concrete_factors     = { 1.0, 1.0, 1.0 },
    concrete_obj_factor  = 0.0,
    obj_factors          = { 1.0, 1.0 },
    cumulative_factor    = 4.0,
    cumulative_thickness = 1.75, 
}
local pylon_mass = 1.0

local brimstone_name  = 'Brimstone Laser Guided Missile'
local brimstone_mass  = 48.5
local brimstone_model = 'brimstone'


BRIM_STONE =
{


declare_weapon(BRIM_STONE)

declare_loadout({
    category        = CAT_MISSILES,
    CLSID           = "JAS_BRIMSTONE",
    wsTypeOfWeapon  = BRIM_STONE.wsTypeOfWeapon,
    attribute       = {4, 4, 32, WSTYPE_PLACEHOLDER},
    Count           = 3,
    Cx_pil          = 0.0001,
    Picture         = "brimstone.png",
    displayName     = _(brimstone_name),
    Weight          = 48.5*3+50,
	Elements = {
	
		{
			ShapeName	=	"brimstone_triple_rack",
			IsAdapter = true,
		},
		
		{
			DrawArgs = {[1] = {1,1},[2] = {2,1},},
			Position	=	{0.15,	-0.18,	0.3}, --1
			ShapeName	=	"brimstone",
			Rotation = {0,0,0},
		},
		
		{
			DrawArgs = {[1] = {1,1},[2] = {2,1},},
			Position	=	{0.15,	-0.18,	-0.3}, --2
			ShapeName	=	"brimstone",
			Rotation = {0,0,0},
		},
		
		{
			DrawArgs = {[1] = {1,1},[2] = {2,1},},
			Position	=	{0.15,	-0.26, 0.0}, --3
			ShapeName	=	"brimstone",
			Rotation = {0,0,0},
		},		
		
	},
    
    JettisonSubmunitionOnly = false,
})
