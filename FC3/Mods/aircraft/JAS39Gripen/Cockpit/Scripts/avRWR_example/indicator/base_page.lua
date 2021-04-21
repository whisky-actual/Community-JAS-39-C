dofile(LockOn_Options.script_path.."avRWR_example/Indicator/definitions.lua")

--local TST  		 = MakeMaterial(nil,{80,17,7,200})
local TST  		 = MakeMaterial(nil,{220,220,220,5})

local SHOW_MASKS = true
--[[
total_field_of_view 				= CreateElement "ceMeshPoly"
total_field_of_view.name 			= "total_field_of_view"
total_field_of_view.primitivetype 	= "triangles"
total_field_of_view.vertices 		=  {{-1,1},{1,1},{1,-1},{-1,-1}}
total_field_of_view.indices			=  {0,1,2,0,2,3}
total_field_of_view.init_pos		= {0, 0, 0}
total_field_of_view.material		= TST
total_field_of_view.h_clip_relation = h_clip_relations.REWRITE_LEVEL
total_field_of_view.level			= RWR_DEFAULT_LEVEL
total_field_of_view.change_opacity	= false
total_field_of_view.collimated 		= false
total_field_of_view.isvisible		= SHOW_MASKS
Add(total_field_of_view)

]]--

local x_size        = 1 * RWR_SCALE	--MFD_SIZE-- * MFD_SCALE
local y_size        = 1 * RWR_SCALE	--MFD_SIZE --* MFD_SCALE
local corner		= 0.9


local vert		= {	{-x_size, y_size * corner},
					{ x_size, y_size * corner},
					{ x_size,-y_size * corner},
					{-x_size,-y_size * corner},
					
					{-x_size, 		y_size * corner},
					{ x_size, 		y_size * corner},
					{ x_size * corner, y_size},
					{-x_size * corner, y_size},
					
					{-x_size, 		-y_size * corner},
					{ x_size, 		-y_size * corner},
					{ x_size * corner,-y_size},
					{-x_size * corner,-y_size},
				}
local indi		 	= {	0, 1, 2, 0, 2, 3,
						4, 5, 6, 4, 6, 7,
						8, 9, 10, 8, 10, 11,
						} --default_box_indices





RWR_base               	= CreateElement "ceSimple"
RWR_base.name			= "RWR_base"
RWR_base.init_pos		= {0,0,0}
Add(RWR_base)

---------------------------------------------------
local 	total_field_of_view 				= CreateElement "ceMeshPoly"
		total_field_of_view.name 			= "total_field_of_view"
		total_field_of_view.primitivetype 	= "triangles"
		
		total_field_of_view.vertices		= vert
		total_field_of_view.indices		 	= indi
		
		--[[
		total_field_of_view.vertices		= {	{-x_size, y_size * 0.7},
												{ x_size, y_size * 0.7},
												{ x_size,-y_size * 0.7},
												{-x_size,-y_size * 0.7},
												
												{-x_size, 		y_size * 0.7},
												{ x_size, 		y_size * 0.7},
												{ x_size * 0.7, y_size},
												{-x_size * 0.7, y_size},
												
												{-x_size, 		-y_size * 0.7},
												{ x_size, 		-y_size * 0.7},
												{ x_size * 0.7,-y_size},
												{-x_size * 0.7,-y_size},
												
												}
		total_field_of_view.indices		 	= {	0, 1, 2, 0, 2, 3,
												4, 5, 6, 4, 6, 7,
												8, 9, 10, 8, 10, 11,
												} --default_box_indices
												]]--
												
		total_field_of_view.material		= MakeMaterial(nil,{255,1,1,255})
		total_field_of_view.h_clip_relation = h_clip_relations.REWRITE_LEVEL
		total_field_of_view.level			= RWR_DEFAULT_NOCLIP_LEVEL--MDF_FOV_LEVEL
		total_field_of_view.isdraw			= true
		total_field_of_view.collimated 		= false
		total_field_of_view.isvisible		= true --false 
		total_field_of_view.parent_element	= "RWR_base"
	Add(total_field_of_view)
---------------------------------

local 	black_background     			= CreateElement "ceTexPoly"
		black_background.primitivetype 	= "triangles"
		black_background.name			="black_background"
		black_background.init_pos		= {0,0,0}
		black_background.material      	= MakeMaterial(nil,{30, 30, 30, 255})
		
		black_background.vertices		= vert
		black_background.indices    	= indi
		--[[
		black_background.vertices		= {	{-x_size, y_size},
											{ x_size, y_size},
											{ x_size,-y_size},
											{-x_size,-y_size}}
		black_background.indices       	= {0, 1, 2, 0, 2, 3} 
		]]--
		black_background.parent_element = "RWR_base"
		black_background.h_clip_relation= h_clip_relations.INCREASE_IF_LEVEL
		black_background.level	  		= RWR_DEFAULT_NOCLIP_LEVEL--MDF_FOV_LEVEL
	Add(black_background)