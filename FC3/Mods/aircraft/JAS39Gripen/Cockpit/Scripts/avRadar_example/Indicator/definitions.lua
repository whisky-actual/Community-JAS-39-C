dofile(LockOn_Options.common_script_path.."elements_defs.lua")
SetScale(FOV)

RADAR_DEFAULT_LEVEL = 4
RADAR_DEFAULT_NOCLIP_LEVEL  = RADAR_DEFAULT_LEVEL - 1
RADAR_SCALE = 0.7--1

function AddElement(object)
    object.use_mipfilter    = true
	object.additive_alpha   = true
	object.h_clip_relation  = h_clip_relations.COMPARE
	object.level			= RADAR_DEFAULT_LEVEL
    Add(object)
end



--{"change_color_when_parameter_equal_to_number", 1, 0.7, 0/255,128/255,0/255},
--{"change_color_when_parameter_equal_to_number", 1, 0.7, 0/255,255/255,0/255},
----Colors--------------------------------
	BG_BLACK_COLOR		= {30, 30, 30, 255}
	TEXT_GREEN_COLOR 	= {0, 255, 50, 255}
	TEXT_BLACK_COLOR 	= BG_BLACK_COLOR--{2, 2, 2, 255}
------------------------------------------


MATERIAL_BLACK   	= MakeMaterial(nil,{25,25,25,255})
RADAR_BG_BLACK		= MakeMaterial(nil,BG_BLACK_COLOR)--{20,20,20,255})			
RADAR_SOLID_BLACK   = MakeMaterial(nil,{0,0,0,255,255})

MFCD_GREEN			= MakeMaterial(nil,{0, 255, 5, 255})
MFCD_GREEN_SOFT		= MakeMaterial(nil,{25, 255, 25, 128})


-------FONTS------------------------------------------------------------------------------

HUD_FONT 	= MakeFont({used_DXUnicodeFontData = "font_arial_17"},TEXT_GREEN_COLOR)		--5 "font_arial_17"  is good 
HUD_FONT_INV= MakeFont({used_DXUnicodeFontData = "font_arial_17"},TEXT_BLACK_COLOR)

FONT_SCALE = 1 

local font_size 					= 0.008						* FONT_SCALE
local default_char_height  			= font_size or 0.004		* FONT_SCALE
local default_char_width   			= 0.3 * default_char_height	* FONT_SCALE
local default_char_vert_spaceing 	= -0.001							--must be adjustet manualy to scale (scale 0.8   	-0.001

txt_box_stringdefs 	= 	{default_char_height		, default_char_width		,0, default_char_vert_spaceing} 
txt_head_stringdefs = 	{default_char_height * 1.3 	, default_char_width * 1.3	,0, -0.0025} 

txt_wpt_stringdefs 	= 	{default_char_height * 1.2 	, default_char_width * 1.2	,0, default_char_vert_spaceing} 

txt_stringdefs 	= 	{default_char_height * 1		, default_char_width * 1		,0, default_char_vert_spaceing} 
txt_s_stringdefs= 	{default_char_height * 1 * 0.5	, default_char_width * 1 * 0.5	,0, default_char_vert_spaceing} 
txt_m_stringdefs= 	{default_char_height * 1 * 0.75	, default_char_width * 1 * 0.75	,0, default_char_vert_spaceing} 
txt_1_stringdefs= 	{default_char_height * 1		, default_char_width * 1		,-0.00051, default_char_vert_spaceing}
-----------------------------------------------------------------------------------------
