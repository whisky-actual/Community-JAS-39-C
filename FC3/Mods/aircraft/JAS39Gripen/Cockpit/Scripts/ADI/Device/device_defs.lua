dofile(LockOn_Options.common_script_path.."elements_defs.lua")
dofile(LockOn_Options.script_path.."materials.lua")

ADI_IND_TEX_PATH                = LockOn_Options.script_path.."../Textures/ADI/"

SetScale(FOV)

DEGREE_TO_MRAD = 17.4532925199433
DEGREE_TO_RAD = 0.0174532925199433
RAD_TO_DEGREE = 57.29577951308233
MRAD_TO_DEGREE = 0.05729577951308233

ADI_ASPECT_HEIGHT =  GetAspect()

ADI_DEFAULT_LEVEL = 4
ADI_DEFAULT_NOCLIP_LEVEL = ADI_DEFAULT_LEVEL - 1

local BlackColor  			= {0, 0, 0, 255}--RGBA
local WhiteColor 			= {255, 255, 255, 255}--RGBA
local MainColor 			= {255, 255, 255, 255}--RGBA
local GreenColor 		    = {0, 255, 0, 255}--RGBA
local YellowColor 			= {255, 255, 0, 255}--RGBA
local OrangeColor           = {255, 180, 0, 255}--RGBA
local RedColor 				= {255, 0, 0, 255}--RGBA
local TealColor 			= {0, 255, 255, 255}--RGBA
local ADIScreen             = {255,255,255,255}
local ADI_ladder_color      = {210,150,230,255}

ADI_CLIP      = MakeMaterial(ADI_IND_TEX_PATH.."SCREEN_clip.tga", ADIScreen)
FD_MATERIAL   = MakeMaterial(ADI_IND_TEX_PATH.."MFD_VDI_BACK_1.dds", WhiteColor)
FD_MATERIAL_N = MakeMaterial(ADI_IND_TEX_PATH.."MFD_VDI_BACK_n.tga", BlackColor)
FD_MATERIAL_B = MakeMaterial(ADI_IND_TEX_PATH.."MFD_VDI_BACK.dds", WhiteColor)
PtchLddrMat   = MakeMaterial(ADI_IND_TEX_PATH.."EADI_Pitch_Ladder.tga", ADI_ladder_color)
PtchBGMat     = MakeMaterial(ADI_IND_TEX_PATH.."EADI_Pitch_Background.tga", WhiteColor)
ADI_HDG       = MakeMaterial(ADI_IND_TEX_PATH.."MFD_HSI_ROSE.dds", OrangeColor)
ADI_YAW       = MakeMaterial(ADI_IND_TEX_PATH.."Yaw.dds",YellowColor)

default_adi_x = 6000
default_adi_y = 6000

function adi_vert_gen(width, height)
    return {{(0 - width) / 2 / default_adi_x , (0 + height) / 2 / default_adi_y},
    {(0 + width) / 2 / default_adi_x , (0 + height) / 2 / default_adi_y},
    {(0 + width) / 2 / default_adi_x , (0 - height) / 2 / default_adi_y},
    {(0 - width) / 2 / default_adi_x , (0 - height) / 2 / default_adi_y},}
end

function adi_duo_vert_gen(width, total_height, not_include_height)
    return {
        {(0 - width) / 2 / default_adi_x , (0 + total_height) / 2 / default_adi_y},
        {(0 + width) / 2 / default_adi_x , (0 + total_height) / 2 / default_adi_y},
        {(0 + width) / 2 / default_adi_x , (0 + not_include_height) / 2 / default_adi_y},
        {(0 - width) / 2 / default_adi_x , (0 + not_include_height) / 2 / default_adi_y},
        {(0 + width) / 2 / default_adi_x , (0 - not_include_height) / 2 / default_adi_y},
        {(0 - width) / 2 / default_adi_x , (0 - not_include_height) / 2 / default_adi_y},
        {(0 + width) / 2 / default_adi_x , (0 - total_height) / 2 / default_adi_y},
        {(0 - width) / 2 / default_adi_x , (0 - total_height) / 2 / default_adi_y},
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

function calculateCircle(object, radius, init_x, init_y, point_num)
	local verts = {}
    multiplier = math.rad(360.0/point_num)
    verts[1] = {init_x / default_adi_x, init_y / default_adi_y}
	for i = 2, point_num do
	  verts[i] = {(init_x + radius * math.cos(i * multiplier)) / default_adi_x, (init_y + radius * math.sin(i * multiplier)) / default_adi_y}
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