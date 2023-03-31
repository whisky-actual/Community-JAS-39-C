--Livery credit: Whisky Actual
name = "SAAF-19"
countries = {}

livery = {
--MAIN MATERIALS DIFFUSE
	{"JAS39_mat1",	DIFFUSE			,	"08_jas39_mat1", true};
	{"JAS39_mat2",	DIFFUSE			,	"08_jas39_mat2", true};
	{"JAS39_mat3",	DIFFUSE			,	"jas39_mat3", true};
--MAIN MATERIALS NORMAL_MAP
	{"JAS39_mat1",	NORMAL_MAP			,	"jas39_mat1_b", true};      
	{"JAS39_mat2",	NORMAL_MAP			,	"jas39_mat2_b", true};	
	{"JAS39_mat3",	NORMAL_MAP			,	"jas39_mat3_b", true};
--MAIN MATERIALS ROUGHNESS_METALLIC
	{"JAS39_mat1",    ROUGHNESS_METALLIC            ,    "JAS39_Mat1_RoughMet", true};
	{"JAS39_mat2",    ROUGHNESS_METALLIC            ,    "JAS39_Mat2_RoughMet", true};
	{"JAS39_mat3",    ROUGHNESS_METALLIC            ,    "JAS39_Mat3_RoughMet", true};
--LIGTHS
	{"JAS39_landinglight",	DIFFUSE			,	"jas39_landinglight", true};
	{"JAS39_lightson",	DIFFUSE			,	"jas39_lightson", true};
	{"JAS39_lightsoff",	DIFFUSE			,	"jas39_lightsoff", true};
	{"JAS39_navred",	DIFFUSE			,	"jas39_navred", true};
	{"JAS39_navgreen",	DIFFUSE			,	"jas39_navgreen", true};
	{"JAS39_navwhite",	DIFFUSE			,	"jas39_navwhite", true};
--GLASS
	{"JAS39_hud",	DIFFUSE			,	"jas39_hud", true};
	{"JAS39_glass",	DIFFUSE			,	"jas39_glass", true};
	{"JAS39_glass",	SPECULAR			,	"jas39_glass_s", true};
--PILOT
	{"JAS39_pilot",	DIFFUSE			,	"jas39_pilot", true};
	{"JAS39_pilot",	NORMAL_MAP			,	"jas39_pilot_b", true};
	{"JAS39_pilothelmet",	DIFFUSE			,	"jas39_pilothelmet", true};
	{"JAS39_pilothelmet",	NORMAL_MAP			,	"jas39_pilothelmet_b", true};
	{"JAS39_sk60_helmet",	DIFFUSE				, "jas39_sk60_helmet", true};
	{"JAS39_sk60_helmet",	NORMAL_MAP			, "jas39_sk60_helmet_normal", true};
	{"JAS39_sk60_helmet",	ROUGHNESS_METALLIC	, "jas39_sk60_helmet_roughmet", true};	
	{"JAS39_sk60_mask",	DIFFUSE					, "jas39_sk60_mask", true};
	{"JAS39_sk60_mask",	NORMAL_MAP				, "jas39_sk60_mask_normal", true};
	{"JAS39_sk60_mask",	ROUGHNESS_METALLIC		, "jas39_sk60_mask_roughmet", true};	
	{"JAS39_sk60_visor",	DIFFUSE				, "jas39_sk60_visor", true};
	{"JAS39_sk60_visor",	NORMAL_MAP			, "jas39_sk60_visor_normal", true};
	{"JAS39_sk60_visor",	ROUGHNESS_METALLIC	, "jas39_sk60_visor_roughmet", true};	
	{"JAS39_sk60_pilothead",	DIFFUSE			, "jas39_sk60_pilothead", true};	
--ENGINES
	{"JAS39_engines",	DIFFUSE			,	"jas39_engines", true};
	{"JAS39_engines",	NORMAL_MAP			,	"jas39_engines_b", true};
	{"JAS39_engines",	ROUGHNESS_METALLIC			,	"jas39_engines_RoughMet", true};
-- OTHERS
	{"JAS39_afterburner",	DIFFUSE			,	"jas39_afterburner", true};
	{"JAS39_Wheel_chock_body", DIFFUSE   ,  "jas39_wheel_chock_body_diff", true};
	{"JAS39_Wheel_chock_body", NORMAL_MAP   ,  "jas39_wheel_chock_body_nm", true};
	{"JAS39_Wheel_chock_body", ROUGHNESS_METALLIC   ,  "jas39_wheel_chock_body_diff_roughmet", true};
	{"JAS39_Wheel_chock_rope", DIFFUSE   ,  "jas39_wheel_chock_rope_diff", true};
	{"JAS39_Wheel_chock_rope", NORMAL_MAP   ,  "jas39_wheel_chock_rope_nm", true};
	{"JAS39_Wheel_chock_rope", ROUGHNESS_METALLIC   ,  "jas39_wheel_chock_rope_diff_roughmet", true};	
	{"JAS39_Ladder_body", DIFFUSE   ,  "jas39_ladder_body_diff", true};
	{"JAS39_Ladder_body", NORMAL_MAP   ,  "jas39_ladder_body_nm", true};
	{"JAS39_Ladder_body", ROUGHNESS_METALLIC   ,  "jas39_ladder_body_diff_roughmet", true};	
	{"JAS39_Ladder_wheels", DIFFUSE   ,  "jas39_ladder_wheels_diff", true};
	{"JAS39_Ladder_wheels", NORMAL_MAP   ,  "jas39_ladder_wheels_nm", true};		
	{"JAS39_Ladder_wheels", ROUGHNESS_METALLIC   ,  "jas39_ladder_wheels_diff_roughmet", true};	
	{"JAS39_drop_tank_1100", DIFFUSE   ,  "jas39_drop_tank_1100_diff", true};
	{"JAS39_drop_tank_1100", NORMAL_MAP   ,  "jas39_drop_tank_1100_nm", true};		
	{"JAS39_drop_tank_1100", ROUGHNESS_METALLIC   ,  "jas39_drop_tank_1100_diff_roughmet", true};
	{"JAS39_drop_tank_1700", DIFFUSE , "jas39_drop_tank_1700_diff", true};	
	{"JAS39_drop_tank_1700", NORMAL_MAP   ,  "jas39_drop_tank_1700_nm", true};		
	{"JAS39_drop_tank_1700", ROUGHNESS_METALLIC   ,  "jas39_drop_tank_1700_diff_roughmet", true};
	{"JAS39_cd_light", DIFFUSE 					, "jas39_cd_light_day", true};	
	{"JAS39_ld_light", DIFFUSE 					, "jas39_ld_light_day", true};	
	{"JAS39_rd_light", DIFFUSE 					, "jas39_rd_light_day", true};	
	{"JAS39_mfd_black", DIFFUSE 				, "jas39_mfd_black", true};	
	{"JAS39_mfd_black", ROUGHNESS_METALLIC 		, "jas39_mfd_black_roughmet", true};
	{"JAS39_mk10l", DIFFUSE 					, "jas39_mk10l_diff", true};	
	{"JAS39_mk10l", NORMAL_MAP   				, "jas39_mk10l_nm", true};		
	{"JAS39_mk10l", ROUGHNESS_METALLIC   		, "jas39_mk10l_diff_roughmet", true};	
}
