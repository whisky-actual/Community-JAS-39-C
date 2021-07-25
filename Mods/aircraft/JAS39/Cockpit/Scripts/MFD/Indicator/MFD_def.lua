dofile(LockOn_Options.common_script_path.."elements_defs.lua")
dofile(LockOn_Options.common_script_path.."Fonts/symbols_locale.lua")
dofile(LockOn_Options.common_script_path.."Fonts/fonts_cmn.lua")


local IndicationFontPath = LockOn_Options.script_path.."../Textures/Fonts/"
MFD_IND_TEX_PATH        = LockOn_Options.script_path .. "Resources/"  

SetScale(FOV)

stringdefs = {0.012,0.75 * 0.012, 0, 0}
mfd_strdefs_text  = {0.007,0.002, 0, 0}
mfd_strdefs_digit = {0.008,0.002, 0, 0}
mfd_strdefs_digit_b = {0.01,0.002, 0, 0}
mfd_strdefs_digit_f = {0.01,0.0028, 0, 0}

materials = {}
materials["DBG_GREY"]    = {5, 5, 5, 255}
materials["DBG_BLACK"]   = {0, 0, 0, 255}
materials["DBG_BLUE"]    = {0, 0, 100, 255}
materials["DBG_GREEN"]   = {0, 80, 0, 255}
materials["DBG_RED"]     = {255, 0, 0, 255}
materials["DBG_WHITE"]   = {255, 255, 255, 255}
materials["DBG_CYAN"]    = {1, 244, 244, 255}
materials["BASE_GREEN"]  = {0,255,0, 255}

materials["DGREEN"]     = MakeMaterial(nil, materials["BASE_GREEN"])
materials["BGCOLOR"]    = MakeMaterial(nil,{242, 235, 179,255})

materials["MWHITE"]     = MakeMaterial(nil, materials["DBG_WHITE"])
materials["BBLACK"]     = MakeMaterial(nil, materials["DBG_BLACK"])

-------FONTS-------
fontdescription = {}

MPCD_size_mult = 2
MPCD_xsize = 29 * MPCD_size_mult
MPCD_ysize = 64 * MPCD_size_mult
fontdescription["font_HUD"] = {
	texture		= IndicationFontPath.."font_HUD.dds",
	size		= {8, 8},
	resolution	= {1024, 1024},
	default		= {MPCD_xsize, MPCD_ysize},
	chars		= {
		[1]   = {64,  MPCD_xsize, MPCD_ysize}, -- @ == ©
		[2]   = {18,  MPCD_xsize, MPCD_ysize}, -- ^ == \18
		[3]   = {20,  MPCD_xsize, MPCD_ysize}, -- ¶ == [] == \20
		[4]   = {26,  MPCD_xsize, MPCD_ysize}, -- > == -> == \26
		[5]   = {27,  MPCD_xsize, MPCD_ysize}, -- < == <- == \27
		[6]   = {31,  MPCD_xsize, MPCD_ysize}, -- SPARE 
		[7]   = {126, MPCD_xsize, MPCD_ysize}, -- ~
		[8]   = {32,  MPCD_xsize, MPCD_ysize}, -- [space]
		[9]   = {33,  MPCD_xsize, MPCD_ysize}, -- !
		[10]  = {35,  MPCD_xsize, MPCD_ysize}, -- #
		[11]  = {40,  MPCD_xsize, MPCD_ysize}, -- (
		[12]  = {41,  MPCD_xsize, MPCD_ysize}, -- )
		[13]  = {42,  MPCD_xsize, MPCD_ysize}, -- *
		[14]  = {43,  MPCD_xsize, MPCD_ysize}, -- +
		[15]  = {45,  MPCD_xsize, MPCD_ysize}, -- -
		[16]  = {46,  MPCD_xsize, MPCD_ysize}, -- .
		[17]  = {47,  MPCD_xsize, MPCD_ysize}, -- /
		[18]  = {48,  MPCD_xsize, MPCD_ysize}, -- 0
		[19]  = {49,  MPCD_xsize, MPCD_ysize}, -- 1
		[20]  = {50,  MPCD_xsize, MPCD_ysize}, -- 2
		[21]  = {51,  MPCD_xsize, MPCD_ysize}, -- 3
		[22]  = {52,  MPCD_xsize, MPCD_ysize}, -- 4
		[23]  = {53,  MPCD_xsize, MPCD_ysize}, -- 5
		[24]  = {54,  MPCD_xsize, MPCD_ysize}, -- 6
		[25]  = {55,  MPCD_xsize, MPCD_ysize}, -- 7
		[26]  = {56,  MPCD_xsize, MPCD_ysize}, -- 8
		[27]  = {57,  MPCD_xsize, MPCD_ysize}, -- 9
		[28]  = {58,  MPCD_xsize, MPCD_ysize}, -- :
		[29]  = {61,  MPCD_xsize, MPCD_ysize}, -- =
		[30]  = {63,  MPCD_xsize, MPCD_ysize}, -- ?
		[31]  = {65,  MPCD_xsize, MPCD_ysize}, -- A
		[32]  = {66,  MPCD_xsize, MPCD_ysize}, -- B
		[33]  = {67,  MPCD_xsize, MPCD_ysize}, -- C
		[34]  = {68,  MPCD_xsize, MPCD_ysize}, -- D
		[35]  = {69,  MPCD_xsize, MPCD_ysize}, -- E
		[36]  = {70,  MPCD_xsize, MPCD_ysize}, -- F
		[37]  = {71,  MPCD_xsize, MPCD_ysize}, -- G
		[38]  = {72,  MPCD_xsize, MPCD_ysize}, -- H
		[39]  = {73,  MPCD_xsize, MPCD_ysize}, -- I
		[40]  = {74,  MPCD_xsize, MPCD_ysize}, -- J
		[41]  = {75,  MPCD_xsize, MPCD_ysize}, -- K
		[42]  = {76,  MPCD_xsize, MPCD_ysize}, -- L
		[43]  = {77,  MPCD_xsize, MPCD_ysize}, -- M
		[44]  = {78,  MPCD_xsize, MPCD_ysize}, -- N
		[45]  = {79,  MPCD_xsize, MPCD_ysize}, -- O
		[46]  = {80,  MPCD_xsize, MPCD_ysize}, -- P
		[47]  = {81,  MPCD_xsize, MPCD_ysize}, -- Q
		[48]  = {82,  MPCD_xsize, MPCD_ysize}, -- R
		[49]  = {83,  MPCD_xsize, MPCD_ysize}, -- S
		[50]  = {84,  MPCD_xsize, MPCD_ysize}, -- T
		[51]  = {85,  MPCD_xsize, MPCD_ysize}, -- U
		[52]  = {86,  MPCD_xsize, MPCD_ysize}, -- V
		[53]  = {87,  MPCD_xsize, MPCD_ysize}, -- W
		[54]  = {88,  MPCD_xsize, MPCD_ysize}, -- X
		[55]  = {89,  MPCD_xsize, MPCD_ysize}, -- Y
		[56]  = {90,  MPCD_xsize, MPCD_ysize}, -- Z
		[57]  = {91,  MPCD_xsize, MPCD_ysize}, -- [
		[58]  = {93,  MPCD_xsize, MPCD_ysize}, -- ] 
		[59]  = {124, MPCD_xsize, MPCD_ysize}, -- | == ¦
		[60]  = {38,  MPCD_xsize, MPCD_ysize}, -- & == +- 
		[61]  = {59,  MPCD_xsize, MPCD_ysize}, -- ; == ° 
		[62]  = {95,  MPCD_xsize, MPCD_ysize}, -- _
		[63]  = {37,  MPCD_xsize, MPCD_ysize},-- %
		[64]  = {24,  MPCD_xsize, MPCD_ysize},-- alpha α
	}
}

fonts = {}

fonts["FONT_WHITE"]  = MakeFont({used_DXUnicodeFontData = "FUI/Fonts/font_arial_17"},materials["DBG_WHITE"],50,"test_font") --this is font object declaration. Mig-21 does not have fonts, therefore disabled.
fonts["FONT_BLUE"]   = MakeFont({used_DXUnicodeFontData = "FUI/Fonts/font_arial_17"},materials["DBG_BLUE"],50,"test_font") --this is font object declaration. Mig-21 does not have fonts, therefore disabled.
fonts["FONT_RED"]    = MakeFont({used_DXUnicodeFontData = "FUI/Fonts/font_arial_17"},materials["DBG_RED"],50,"test_font") --this is font object declaration. Mig-21 does not have fonts, therefore disabled.
fonts["FONT_GREEN"]  = MakeFont({used_DXUnicodeFontData = "FUI/Fonts/font_arial_17"}, materials["DBG_GREEN"],50,"test_font") 
fonts["FONT_BLACK"]  = MakeFont({used_DXUnicodeFontData = "FUI/Fonts/font_arial_17"}, materials["DBG_BLACK"],50,"test_font") 
fonts["FONT_WHITE"]  = MakeFont({used_DXUnicodeFontData = "FUI/Fonts/font_arial_17"}, materials["DBG_WHITE"],50,"test_font") 

--all vertices in files who include this file will be scaled in millyradians
-- SetScale(MILLYRADIANS)
 
DEGREE_TO_MRAD = 17.4532925199433
DEGREE_TO_RAD  = 0.0174532925199433
RAD_TO_DEGREE  = 57.29577951308233
MRAD_TO_DEGREE = 0.05729577951308233
 
MFD_DEFAULT_LEVEL = 7                               
MFD_DEFAULT_NOCLIP_LEVEL  = MFD_DEFAULT_LEVEL - 1  
 
DEBUG_COLOR                 = {0,255,0,200}
MFD_DAY_COLOR               = {255,255,255,255}
MFD_DARK_COLOR               = {0,0,0,255}

basic_MFD_material = MakeMaterial(MFD_IND_TEX_PATH.."Gear_B.png", MFD_DAY_COLOR)
MFD_ELEMENTS = MakeMaterial(MFD_IND_TEX_PATH.."MFD/Left_MFD.png", MFD_DAY_COLOR)
MFD_ELEMENTS_D = MakeMaterial(MFD_IND_TEX_PATH.."MFD/Left_MFD_D.png", MFD_DAY_COLOR)
headingtape  = MakeMaterial(MFD_IND_TEX_PATH.."MFD/headingtape.png", MFD_DAY_COLOR)
headingtape_d  = MakeMaterial(MFD_IND_TEX_PATH.."MFD/headingtape_d.png", MFD_DAY_COLOR)
MFD_RPM_DIGIT  = MakeMaterial(MFD_IND_TEX_PATH.."MFD/MFD_digits.png", MFD_DAY_COLOR)
MFD_RPM_DIGIT_D  = MakeMaterial(MFD_IND_TEX_PATH.."MFD/MFD_digits_d.png", MFD_DAY_COLOR)
 
default_MFD_x = 512
default_MFD_y = 512

default_MFD_z_offset = 0.8
default_MFD_rot_offset = 30

box_indices =
{
	0,1,2;0,2,3
}

function texture_box (UL_X,UL_Y,W,H, texture_size_x, texture_size_y)
local ux = UL_X / texture_size_x
local uy = UL_Y / texture_size_y
local w  = W / texture_size_x
local h  = H / texture_size_y
return {{ux	    ,uy},
		{ux + w ,uy},
		{ux + w ,uy + h},
		{ux	 	,uy + h}}
end
 
function create_mfd_tex(mfd_material, UL_X,UL_Y,DR_X,DR_Y, sale,CENTER_X,CENTER_Y)

if sale == nil then
	sale = 1.4
end

local mils_per_pixel =  sale/1024
local W 	   		 = DR_X - UL_X
local H 	   		 = DR_Y - UL_Y
local cx		     = (UL_X + 0.5 * W)
local cy		     = (UL_Y + 0.5 * H)

local CENTER_X 		 = CENTER_X or cx
local CENTER_Y 		 = CENTER_Y or cy
local dcx 		 	 = mils_per_pixel * (CENTER_X - cx)
local dcy 		     = mils_per_pixel * (CENTER_Y - cy)

local half_x 		 = 0.47 * W * mils_per_pixel
local half_y 		 = 0.49 * H * mils_per_pixel


local object = CreateElement "ceTexPoly"
	  object.material =  mfd_material
 	  object.vertices =  {{-half_x - dcx, half_y + dcy},
						  { half_x - dcx, half_y + dcy},
						  { half_x - dcx,-half_y + dcy},
						  {-half_x - dcx,-half_y + dcy}}
	  object.tex_coords = texture_box(UL_X,UL_Y,W,H, 2048, 2048)
	  object.indices	  = box_indices
	  return object
end

function create_hdg_textr_box(vth_hdg_material, UL_X,UL_Y,DR_X,DR_Y,scale, CENTER_X,CENTER_Y)

if scale == nil then
	scale = 1.4
end

local mils_per_pixel =  scale/4096

local W 	   		 = DR_X - UL_X
local H 	   		 = DR_Y - UL_Y
local cx		     = (UL_X + 0.5 * W)
local cy		     = (UL_Y + 0.5 * H)

local CENTER_X 		 = CENTER_X or cx
local CENTER_Y 		 = CENTER_Y or cy
local dcx 		 	 = mils_per_pixel * (CENTER_X - cx)
local dcy 		     = mils_per_pixel * (CENTER_Y - cy)

local half_x 		 = 0.5 * W * mils_per_pixel
local half_y 		 = 0.5 * H * mils_per_pixel


local object = CreateElement "ceTexPoly"
	  object.material =  vth_hdg_material
 	  object.vertices =  {{-half_x - dcx, half_y + dcy},
						  { half_x - dcx, half_y + dcy},
						  { half_x - dcx,-half_y + dcy},
						  {-half_x - dcx,-half_y + dcy}}
	  object.tex_coords = texture_box(UL_X,UL_Y,W,H, 4096,64)
	  object.indices	  = box_indices
	  return object
end

function create_mfd_tex_sq(mfd_material, UL_X,UL_Y,DR_X,DR_Y, sale,CENTER_X,CENTER_Y)

if sale == nil then
	sale = 1.4
end

local mils_per_pixel =  sale/1024
local W 	   		 = DR_X - UL_X
local H 	   		 = DR_Y - UL_Y
local cx		     = (UL_X + 0.5 * W)
local cy		     = (UL_Y + 0.5 * H)

local CENTER_X 		 = CENTER_X or cx
local CENTER_Y 		 = CENTER_Y or cy
local dcx 		 	 = mils_per_pixel * (CENTER_X - cx)
local dcy 		     = mils_per_pixel * (CENTER_Y - cy)

local half_x 		 = 0.5 * W * mils_per_pixel
local half_y 		 = 0.5 * H * mils_per_pixel


local object = CreateElement "ceTexPoly"
	  object.material =  mfd_material
 	  object.vertices =  {{-half_x - dcx, half_y + dcy},
						  { half_x - dcx, half_y + dcy},
						  { half_x - dcx,-half_y + dcy},
						  {-half_x - dcx,-half_y + dcy}}
	  object.tex_coords = texture_box(UL_X,UL_Y,W,H,2048,2048)
	  object.indices	  = box_indices
	  return object
end

function create_hdg_text_d(UL_X,UL_Y,DR_X,DR_Y, CENTER_X,CENTER_Y)
local mils_per_pixel =  2.2/1024

local W 	   		 = DR_X - UL_X
local H 	   		 = DR_Y - UL_Y
local cx		     = (UL_X + 0.5 * W)
local cy		     = (UL_Y + 0.5 * H)

local CENTER_X 		 = CENTER_X or cx
local CENTER_Y 		 = CENTER_Y or cy
local dcx 		 	 = mils_per_pixel * (CENTER_X - cx)
local dcy 		     = mils_per_pixel * (CENTER_Y - cy)

local half_x 		 = 0.5 * W * mils_per_pixel
local half_y 		 = 0.5 * H * mils_per_pixel
local object = CreateElement "ceTexPoly"
	  object.material =  MFD_RPM_DIGIT_D
 	  object.vertices =  {{-half_x - dcx, half_y + dcy},
						  { half_x - dcx, half_y + dcy},
						  { half_x - dcx,-half_y + dcy},
						  {-half_x - dcx,-half_y + dcy}}
	  object.tex_coords = texture_box(UL_X,UL_Y,W,H, 31, 324)
	  object.indices	  = box_indices
	  return object
end




function MFD_vert_gen(width, height)
    return {{(0 - width) / 2 / default_MFD_x , (0 + height) / 2 / default_MFD_y},
    {(0 + width) / 2 / default_MFD_x , (0 + height) / 2 / default_MFD_y},
    {(0 + width) / 2 / default_MFD_x , (0 - height) / 2 / default_MFD_y},
    {(0 - width) / 2 / default_MFD_x , (0 - height) / 2 / default_MFD_y},}
end

function MFD_duo_vert_gen(width, total_height, not_include_height)
    return {
        {(0 - width) / 2 / default_MFD_x , (0 + total_height) / 2 / default_MFD_y},
        {(0 + width) / 2 / default_MFD_x , (0 + total_height) / 2 / default_MFD_y},
        {(0 + width) / 2 / default_MFD_x , (0 + not_include_height) / 2 / default_MFD_y},
        {(0 - width) / 2 / default_MFD_x , (0 + not_include_height) / 2 / default_MFD_y},
        {(0 + width) / 2 / default_MFD_x , (0 - not_include_height) / 2 / default_MFD_y},
        {(0 - width) / 2 / default_MFD_x , (0 - not_include_height) / 2 / default_MFD_y},
        {(0 + width) / 2 / default_MFD_x , (0 - total_height) / 2 / default_MFD_y},
        {(0 - width) / 2 / default_MFD_x , (0 - total_height) / 2 / default_MFD_y},
    }
end

function tex_coord_gen(x_dis,y_dis,width,height,size_X,size_Y)
    return {{x_dis / size_X , y_dis / size_Y},
			{(x_dis + width) / size_X , y_dis / size_Y},
			{(x_dis + width) / size_X , (y_dis + height) / size_Y},
			{x_dis / size_X , (y_dis + height) / size_Y},}
end

function mirror_tex_coord_gen(x_dis,y_dis,width,height,size_X,size_Y)
    return {{(x_dis + width) / size_X , y_dis / size_Y},
			{x_dis / size_X , y_dis / size_Y},
			{x_dis / size_X , (y_dis + height) / size_Y},
			{(x_dis + width) / size_X , (y_dis + height) / size_Y},}
end

function AddElement(object)
	object.use_mipfilter    = true
	object.additive_alpha   = false
	object.change_opacity	 = false
	object.h_clip_relation  = h_clip_relations.compare
	object.level			= MFD_DEFAULT_LEVEL
    Add(object)
end

function AddElement2(object)
	object.use_mipfilter    = true
	object.additive_alpha   = false
	object.change_opacity	 = false
	-- object.h_clip_relation  = h_clip_relations.compare
	-- object.level			= MFD_DEFAULT_LEVEL
    Add(object)
end

function create_line(PosX, PosY, lLenght, lwidth, parent, material, vertices)
	vmaterial =  materials["MWHITE"]
	if material ~= nil then
		vmaterial =  materials[material]
	end
	vvertices = {{0, 0}, {lLenght,0}}
	if material ~= nil then
		vvertices = vertices
	end	
	line_object				 = CreateElement "ceSimpleLineObject"
	line_object.name		 = create_guid_string()
	line_object.material	 = vmaterial
	line_object.width		 = lwidth
	line_object.vertices	 =  vvertices
	line_object.init_pos     = {PosX, PosY}
	line_object.parent_element	= parent.name
	-- AddElement(line_object)
	return line_object
end

function create_rect(xpos, ypos, bw, bh, Border, parent, material)
	local rec_parent       		= CreateElement "ceSimple"
	rec_parent.name				= create_guid_string()
	rec_parent.init_pos       	= {xpos, ypos}
	rec_parent.parent_element	= parent.name
	
	local  rect_top_line 		= create_line(0 ,0 , bw * 2, Border, rec_parent, material)
	rect_top_line.init_pos 		= {-bw,bh}
	AddElement(rect_top_line)

	local  rect_bottom_line = Copy(rect_top_line)
	rect_bottom_line.init_pos 	= {-bw, -bh}
	AddElement(rect_bottom_line)

	local  rect_left_line 		= create_line(Border ,0 , Border, bh , rec_parent, material)
	rect_left_line.init_pos 	= {-bw +(Border ) - 0.005, 0}
	AddElement(rect_left_line)

	local  rect_right_line = Copy(rect_left_line)
	rect_right_line.init_pos 	= { bw -(Border ) , 0}
	AddElement(rect_right_line)
	
	return rec_parent
end


function AddCircle(xpos, ypos, radius, border, fill, parent_element, color)
	if border <=0 then
		border = 1
	end
	if color == nil then
		color =  "DBG_GREEN"
	end
	for i=1, border do
		    RWR_circle_i 				= CreateElement "ceMeshPoly"
			RWR_circle_i.name 			= create_guid_string()
			RWR_circle_i.primitivetype 	= "triangles"
			RWR_circle_i.init_pos       = {xpos, ypos}
			if fill == true then
				set_circle	(RWR_circle_i, radius + 0.0020 )
			else
				set_circle	(RWR_circle_i, radius + 0.0020, radius - 0.0020, 360, 36)
			end
			RWR_circle_i.material 		= color
			RWR_circle_i.parent_element = parent_element
			-- AddElement(RWR_circle_i)
			radius = radius + 0.001
	end
	

	return RWR_circle_i
end

function AddCircle_b(xpos, ypos, radius, border, fill, parent_element, color)

	local rec_parent       		= CreateElement "ceSimple"
	rec_parent.name				= create_guid_string()
	rec_parent.init_pos       	= {xpos, ypos}
	rec_parent.parent_element	= parent_element
	-- AddElement(rec_parent)
	
	if border <=0 then
		border = 1
	end
	if color == nil then
		color =  "DBG_GREEN"
	end
	for i=1, border do
		    RWR_circle_i 				= CreateElement "ceMeshPoly"
			RWR_circle_i.name 			= create_guid_string()
			RWR_circle_i.primitivetype 	= "triangles"
			RWR_circle_i.init_pos       = {0 , 0}
			if fill == true then
				set_circle	(RWR_circle_i, radius + 0.0020 )
			else
				set_circle	(RWR_circle_i, radius + 0.0020, radius - 0.0020, 360, 36)
			end
			RWR_circle_i.material 		= color
			RWR_circle_i.parent_element = rec_parent.name
			AddElement(RWR_circle_i)
			radius = radius + 0.001
	end
	

	return rec_parent
end

function add_text(text, posx, posy, pparent, font_mat, stringdefs, valign)

	local rec_parent       		= CreateElement "ceSimple"
	rec_parent.name				= create_guid_string()
	rec_parent.init_pos       	= {posx, posy}
	if pparent ~= nil then
		rec_parent.parent_element	= pparent.name
	end
	AddElement(rec_parent)
	-------------------
	if valign == nil then
		valign = "CenterCenter"
	end
	vfont_mat = fonts["FONT_GREEN"]
	if font_mat ~= nil then
		vfont_mat = fonts[font_mat]
	end
	if stringdefs == nil then
		stringdefs = mfd_strdefs_text
	end		
	-------------------
	if text ~= nil then
		local parent          = CreateElement "ceStringPoly"
		parent.name           = create_guid_string()
		parent.material       = vfont_mat
		parent.init_pos       = {0, 0}
		parent.stringdefs     = stringdefs
		parent.alignment	  = valign
		parent.value  	      = text
		parent.parent_element = rec_parent.name
		AddElement(parent)
		parent.level          = MFD_DEFAULT_LEVEL  
	end
	-------------------
	return rec_parent
end

function add_text_param(posx, posy, element_parm, tformat, pparent, stringdefs, font_mat, talignment)
	if tformat == nil then
		tformat = "%.0f"
	end
	if talignment == nil then
		talignment = "CenterCenter"
	end
	vfont_mat = fonts["FONT_GREEN"]
	if font_mat ~= nil then
		vfont_mat = fonts[font_mat]
	end	
	if stringdefs == nil then
		stringdefs = mfd_strdefs_text
	end	
	
	local parent          = CreateElement "ceStringPoly"
	parent.name           = create_guid_string()
	parent.material       = vfont_mat
	parent.init_pos       = {posx, posy}
	parent.stringdefs     = stringdefs
	parent.alignment	  = talignment
	if pparent ~= nil then
		parent.parent_element = pparent.name
	end
	parent.formats           = {tformat} 
	parent.element_params    = {element_parm,"%s"}
	parent.controllers       = {{"text_using_parameter",0},}
	AddElement(parent)
	parent.level          = MFD_DEFAULT_LEVEL  
	-------------------
	return parent
end
