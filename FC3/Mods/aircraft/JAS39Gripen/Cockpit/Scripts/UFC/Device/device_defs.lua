dofile(LockOn_Options.common_script_path.."elements_defs.lua")
dofile(LockOn_Options.script_path.."materials.lua")

UFC_IND_TEX_PATH                = LockOn_Options.script_path.."../Textures/UFC/"

SetScale(FOV)

DEGREE_TO_MRAD = 17.4532925199433
DEGREE_TO_RAD = 0.0174532925199433
RAD_TO_DEGREE = 57.29577951308233
MRAD_TO_DEGREE = 0.05729577951308233

UFC_ASPECT_HEIGHT =  GetAspect()

UFC_DEFAULT_LEVEL = 4
UFC_DEFAULT_NOCLIP_LEVEL = UFC_DEFAULT_LEVEL - 1

local BlackColor  			= {0, 0, 0, 255}--RGBA
local WhiteColor 			= {255, 255, 255, 100}--RGBA
local MainColor 			= {255, 255, 255, 255}--RGBA
local GreenColor 		    = {0, 255, 0, 255}--RGBA
local YellowColor 			= {255, 255, 0, 255}--RGBA
local OrangeColor           = {255, 102, 0, 255}--RGBA
local RedColor 				= {255, 0, 0, 255}--RGBA
local TealColor 			= {0, 255, 255, 255}--RGBA
local ADIScreen             = {255,255,255,255}

UFC_CLIP      = MakeMaterial(UFC_IND_TEX_PATH.."SCREEN_clip.tga", BlackColor)
UFC_RPM_RING  = MakeMaterial(UFC_IND_TEX_PATH.."ring_rpm.dds", GreenColor)
UFC_RPM_ROT  = MakeMaterial(UFC_IND_TEX_PATH.."rpm_rot.dds", GreenColor)

default_ufc_x = 6000
default_ufc_y = 6000

function ufc_vert_gen(width, height)
    return {{(0 - width) / 2 / default_ufc_x , (0 + height) / 2 / default_ufc_y},
    {(0 + width) / 2 / default_ufc_x , (0 + height) / 2 / default_ufc_y},
    {(0 + width) / 2 / default_ufc_x , (0 - height) / 2 / default_ufc_y},
    {(0 - width) / 2 / default_ufc_x , (0 - height) / 2 / default_ufc_y},}
end

function ufc_duo_vert_gen(width, total_height, not_include_height)
    return {
        {(0 - width) / 2 / default_ufc_x , (0 + total_height) / 2 / default_ufc_y},
        {(0 + width) / 2 / default_ufc_x , (0 + total_height) / 2 / default_ufc_y},
        {(0 + width) / 2 / default_ufc_x , (0 + not_include_height) / 2 / default_ufc_y},
        {(0 - width) / 2 / default_ufc_x , (0 + not_include_height) / 2 / default_ufc_y},
        {(0 + width) / 2 / default_ufc_x , (0 - not_include_height) / 2 / default_ufc_y},
        {(0 - width) / 2 / default_ufc_x , (0 - not_include_height) / 2 / default_ufc_y},
        {(0 + width) / 2 / default_ufc_x , (0 - total_height) / 2 / default_ufc_y},
        {(0 - width) / 2 / default_ufc_x , (0 - total_height) / 2 / default_ufc_y},
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

function calculateCircle(object, rufcus, init_x, init_y, point_num)
	local verts = {}
    multiplier = math.rad(360.0/point_num)
    verts[1] = {init_x / default_ufc_x, init_y / default_ufc_y}
	for i = 2, point_num do
	  verts[i] = {(init_x + rufcus * math.cos(i * multiplier)) / default_ufc_x, (init_y + rufcus * math.sin(i * multiplier)) / default_ufc_y}
    end
    local indices = {}
	for i = 0, point_num - 3 do
	  indices[i * 3 + 1] = 0
	  indices[i * 3 + 2] = i + 1
	  indices[i * 3 + 3] = i + 2
    end
    indices[(point_num - 2) * 3 + 1] = 0
    indices[(point_num - 2) * 3 + 2] = 1
    indices[(point_num - 2) * 3 + 3] = point_num - 1
	object.vertices = verts
	object.indices  = indices
end