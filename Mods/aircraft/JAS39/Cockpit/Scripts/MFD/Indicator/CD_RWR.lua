dofile(LockOn_Options.script_path.."MFD/Indicator/MFD_def.lua")
_ = gettext.translate

TYPEPlane = 1
TYPESearchRadar = 2
TYPEEWR = 3
TYPESEA = 4
TYPEMissile = 5
MaxThreats  = 20

local RS = 0.01
local contact_scale = 0.10

MFD_RWR 			= CreateElement "ceSimple"
MFD_RWR.init_pos	= {-0.025,-0.15}
MFD_RWR.name		= create_guid_string()
MFD_RWR.element_params = {"MAINPOWER", "RWRPOWER_STATE", "CD_EMGY_MODE", "CD_FIX_TOGGLE"}
MFD_RWR.controllers    = {{"parameter_compare_with_number",0, 1}, {"parameter_compare_with_number",1, 1}, {"parameter_compare_with_number",2, 0}, {"parameter_compare_with_number",3, 0}}
MFD_RWR.material			= MakeMaterial(nil,{0, 220, 0, 255})
MFD_RWR.isvisible		 = true
AddRWRElement(MFD_RWR)
----------------------------------------------------------------------------
local x_size = 0.1
local y_size = 0.1
local wmul = 0.88 

function RWR_SYMBOL(pparent, TYPE_OBJ, vController,index)

	OBJ_BASE 			= CreateElement "ceSimple"
	OBJ_BASE.init_pos	= {0.00,0.075}
	OBJ_BASE.name		= create_guid_string()
	OBJ_BASE.parent_element = pparent.name
	OBJ_BASE.element_params  	= {"RWR_CONTACT" .. index .. "AZIMUTH", "RWR" .. index .."SHOWN", }
	OBJ_BASE.controllers     	= {{"rotate_using_parameter" ,0,-1}, {"parameter_in_range" 	   		,1,0.1,1.1},}
	AddElement(OBJ_BASE)

	local 	RWR_OBJ_STR	 					= CreateElement "ceStringPoly"
			RWR_OBJ_STR.name			  	= create_guid_string()
			RWR_OBJ_STR.material        	= fonts["Gripen_Font_black"]
			RWR_OBJ_STR.stringdefs      	= mfd_strdefs_digit_XS
			RWR_OBJ_STR.alignment       	= "CenterCenter"
			RWR_OBJ_STR.formats		  		= {"%s"}
			RWR_OBJ_STR.element_params  	= { "RWR_CONTACT" .. index .. "UNIT_TYPE_SYM",
												"RWR_CONTACT" .. index .. "AZIMUTH",
												"RWR" .. index .."ISNUM",
												"RWR" .. index .."SHOWN"
											  }
			RWR_OBJ_STR.controllers     	= {	
												{"text_using_parameter"    		,0,0},
												{"parameter_in_range" 	   		,2,0.1,0.5},
												{"parameter_in_range" 	   		,3,0.9,1.1},
												{"opacity_using_parameter"		, 3}
											  }		
			RWR_OBJ_STR.parent_element 		= OBJ_BASE.name
			AddElement(RWR_OBJ_STR)
				
			local 	RWR_OBJ_NUM	 		= Copy(RWR_OBJ_STR)
			RWR_OBJ_NUM.formats		  	= {"%.0f"}
			RWR_OBJ_NUM.element_params  = { "RWR_CONTACT" .. index .. "UNIT_TYPE_SYN",
											"RWR_CONTACT" .. index .. "AZIMUTH",
											"RWR" .. index .."ISNUM",
											"RWR" .. index .."SHOWN"											
										  }
			RWR_OBJ_NUM.controllers     = {	
											{"text_using_parameter"    ,0,0},
											{"parameter_in_range" 	   ,2,0.9,1.1},
											{"parameter_in_range" 	   ,3,0.6,1.1},
											{"opacity_using_parameter" , 3}
										  }		
			AddElement(RWR_OBJ_NUM)	
	
	local 	RWR_priority	 				= CreateElement "ceStringPoly"
			RWR_priority.name			  	= create_guid_string()
			RWR_priority.init_pos		  	= {0.0,0.0,0} 
			RWR_priority.init_rot		  	= {0.0,0.0,0.0}
			RWR_priority.material    		= materials["RWRYELLOW"]	
			RWR_priority.vertices	   		= {	{-x_size 		,0				},
												{0 				, y_size 		},
												{0				, y_size * wmul	},
												{-x_size * wmul	,0				},	
												
												{ x_size 		,0				},
												{0 				, y_size 		},
												{0				, y_size * wmul	},
												{ x_size * wmul	,0				},	
												
												{-x_size 		,0				},
												{0 				, -y_size 		},
												{0				, -y_size * wmul},
												{-x_size * wmul	,0				},	
												
												{ x_size 		,0				},
												{0 				, -y_size 		},
												{0				, -y_size * wmul},
												{ x_size * wmul	,0				},	
											}		
			RWR_priority.indices	   		= 	{ 	0,1,2,	0,2,3,
												4,5,6,	4,6,7,
												8,9,10,	8,10,11,
												12,13,14,	12,14,15,}--{0, 1, 2, 0, 2, 3} 
			RWR_priority.element_params  	= {	"RWR_CONTACT" .. index .. "CURPRIORITY"}
			RWR_priority.controllers     	= {	
												{"parameter_in_range",0,0.9,1.1},
												{"opacity_using_parameter", 1}
											  } 
			RWR_priority.parent_element 	=  OBJ_BASE.name
			AddElement(RWR_priority)
			
		local 	RWR_lock	 			= CreateElement "ceStringPoly"
			RWR_lock.name			  	= create_guid_string()
			RWR_lock.init_pos		  	= {0.0,0.0,0} 
			RWR_lock.init_rot		  	= {0.0,0.0,0.0}
			RWR_lock.material    		= materials["RWRRED"]	
			RWR_lock.vertices	   		= {	{-x_size 		,0				},
												{0 				, y_size 		},
												{0				, y_size * wmul	},
												{-x_size * wmul	,0				},	
												
												{ x_size 		,0				},
												{0 				, y_size 		},
												{0				, y_size * wmul	},
												{ x_size * wmul	,0				},	
												
												{-x_size 		,0				},
												{0 				, -y_size 		},
												{0				, -y_size * wmul},
												{-x_size * wmul	,0				},	
												
												{ x_size 		,0				},
												{0 				, -y_size 		},
												{0				, -y_size * wmul},
												{ x_size * wmul	,0				},	
											}		
			RWR_lock.indices	   		= 	{ 	0,1,2,	0,2,3,
												4,5,6,	4,6,7,
												8,9,10,	8,10,11,
												12,13,14,	12,14,15,}--{0, 1, 2, 0, 2, 3} 
			RWR_lock.element_params  	= {	"RWR_CONTACT" .. index .. "LOCK"}
			RWR_lock.controllers     	= {	
												{"parameter_in_range",0,0.9,1.1},
												{"opacity_using_parameter", 1}
											  } 
			RWR_lock.parent_element 	=  OBJ_BASE.name
			AddElement(RWR_lock)
			AddElement(AddCircle(0, 0, 0.090, 8, false, RWR_lock.name, materials["RWRRED"]))
			AddElement(AddCircle(0, 0, 0.095, 8, false, RWR_lock.name, materials["RWRRED"]))
			AddElement(AddCircle(0, 0, 0.100, 1, false, RWR_lock.name, materials["RWRRED"]))		
		
end

for ia = 1,MaxThreats do
	local i = ""
	if ia  < 10 then
		i = "_0".. ia .."_"
	else
		i = "_".. ia .."_"
	end
	i = "_0".. ia .."_"
	
	local	RWR_contact			   			= CreateElement "ceSimple"
			RWR_contact.name		   		= "RWR_contact_" .. i .. "_name"
			RWR_contact.primitivetype		= "triangles"
			RWR_contact.controllers     	= { {"rotate_using_parameter"			,0,1},
												{"move_up_down_using_parameter"		,1,contact_scale},
												{"parameter_in_range"				,1,0.04,1.09}, -- Closest Contact 0.05 Farest Contact 1.08 
											  } 
			RWR_contact.element_params  	= {	
												"RWR_CONTACT"..i.."AZIMUTH",
												"RWR_CONTACT"..i.."POWER_SYN",
											  }
			RWR_contact.parent_element 		= MFD_RWR.name
			AddElement(RWR_contact)
	----	
	RWR_SYMBOL(RWR_contact, TYPEPlane		, "RWRAIR",i)
	RWR_SYMBOL(RWR_contact, TYPESearchRadar	, "RWRSAM",i)
	RWR_SYMBOL(RWR_contact, TYPEEWR, "RWRSAM",i)
	RWR_SYMBOL(RWR_contact, TYPEEWR, "RWREWR",i)
	RWR_SYMBOL(RWR_contact, TYPESEA, "RWRSEA",i)
	RWR_SYMBOL(RWR_contact, TYPEMissile,nil,i)		
end
-----------------------------------------------------------
--List contact possition
-----------------------------------------------------------
T_P1 				= CreateElement "ceSimple"
T_P1.init_pos		= {0.06,-0.05}
T_P1.name			= create_guid_string()
T_P1.parent_element = MFD_RWR.name
T_P1.controllers    = {{"parameter_in_range" ,0,1.9,2.1},}
AddRWRElement(T_P1)

T_P2 				= CreateElement "ceSimple"
T_P2.init_pos		= {0.06,-0.05}
T_P2.name			= create_guid_string()
T_P2.parent_element = MFD_RWR.name
T_P2.controllers    = {{"parameter_in_range" ,0,1.9,2.1},}
AddRWRElement(T_P2)
-----------------------------------------------------------
--List contact possition
-----------------------------------------------------------
rwr_pos_cd = 1
for number=1,5 do
	local RWR_threats	 			= CreateElement "ceStringPoly"
	RWR_threats.name			  	= create_guid_string()
	RWR_threats.material        	= fonts["Gripen_Font_black"]
	RWR_threats.init_pos		  	= {-1.00,(-1.00 + 0.35) - (rwr_pos_cd * 0.075),0} 
	RWR_threats.stringdefs      	= mfd_strdefs_digit_XS
	RWR_threats.alignment       	= "LeftTop"
	RWR_threats.formats		  		= {"%s"}
	if number <= 5 then
		RWR_threats.parent_element 	=	T_P1.name
	else
		RWR_threats.parent_element 	=	T_P2.name
	end
	RWR_threats.element_params  	= 	{ "RWR_CONTACT_"..tostring(number).."_UT"}
	RWR_threats.controllers     	= 	{ {"text_using_parameter",0,0}, {"opacity_using_parameter", 1}}
	AddRWRElement(RWR_threats)
	----------------------
	rwr_pos_cd = rwr_pos_cd + 1
	if rwr_pos_cd > 5 then
		rwr_pos_cd = 1
	end
end		
----------------------------------------------------------------------------