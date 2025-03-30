dofile(LockOn_Options.common_script_path..'AN_ALR_SymbolsBase.lua')

TYPEPlane = 1
TYPESearchRadar = 2
TYPEEWR = 3
TYPESEA = 4
TYPEMissile = 5
 
symbols_strings_new = {
    ['MiG-23MLD']=    "M23",
    ['MiG-29A']=      "M29",
    ['MIG-29K']=      "M29",
    ['MiG-29G']=      "M29",
    ['MiG-29S']=      "M29",
	
    ['Su-27']=        "S27",
	['Su-30']=        "S30",
    ['Su-33']=        "S33",
	['Su-34']=        "S34",
    ['F-14']=         "F14",
    ['F-15']=         "F15",
    ['F-15C']=        "F15",
	['F-15E']=        "F15",
    ['F-16']=         "F16",
    ['F-16A']=        "F16",
	
    ['F-2']=          "F2",
    ['Cy-30MC']=      "S30",
    ['Su-30MKA']=     "S30",
    ['Su-30MKI']=     "S30",
    ['Su-30MKM']=     "S30",
    ['Su-30MKK']=     "S30",

    ['FA-18A']=       "F18",
    ['FA-18C']=       "F18",

    ['Mirage']=       "M2K",
    ['F-4E']=         "F4",
    ['F-5E']=         "F5",
    ['Su-24']=        "S24",
    ['Su-24MR']=      "S24",
    ['AV-8B']=        "AV8",
    ['EA-6B']=        "EA6",
    ['F-111']=        "111",
    ['Tu-160']=       "160",
    ['B-1']=          "B1",
    ['Tu-22M3']=      "T22",
    ['MiG-25PD']=     "M25",
    ['MiG-31']=       "M31",
    ['Tu-95']=        "T95",
    ['Tu-142']=       "142",
    ['B-52']=         "B52",
    ['A-50']=         "A50",
    ['E-3']=          "E3",
    ['S-3A']=         "S3",
    ['S-3R']=         "S3",
    ['E-2C']=         "E2",
	['E-2D']=         "E2",
    ['C-17']=         "C17",
    ['C-130']=        "130",
    ['IL-76']=        "I76",
    ['AN-26B']=       "A26",
    ['AN-30M']=       "A30",
    ['KC-10']=        "K10",
    ['KC-135']=       "135",
    ['IL-78']=        "I78",
    ['Su-39']=        "S39",	
    ['1L13 EWR']=             "SRC",	
    ['55G6 EWR']=             "SRC",
	
    ['S300PS SR 5N66M']=      "S10",---
    ['S300PS SR 64H6E']=      "S10",---
    ['RLO 9C15MT']=           "BD",---
    ['RLO 9C19M2']=           "HS",---
  --['Buk SR 9S18M1']=        "SD",---
	['SA-11 Buk SR 9S18M1']	= "S11",
    ['Kub 1S91 str']=         "SA6",
    ['Dog Ear radar']=        "DE",---
	['Roland ADS']=           "ROL",	
    ['Roland Radar']=         "ROL",		
	['Patriot str']=          "PAT",	
    ['Hawk SR ANMPQ 50']=     "HK",---
    ['S300PS TR 30N6']=       "S10",
	['S-300PS 40B6M tr']=     "S10",
	['S-300PS 40B6MD sr']=    "S10",
	['S-300PS 64H6E sr']=     "S10",
		
    ['RLS 5H63C']=            "5H",---
    ['RLS 9C32 1']=           "12",
    ['Hawk TR ANMPQ 46']=     "HWK",
	['Hawk tr']=              "HWK",
	['Hawk sr']=              "HWK",
	['Hawk cwar']=            "HWK",
	['Hawk pcp']=             "HWK",		
    ['S300V 9A82']=           "S12",
    ['S300V 9A83']=           "S12",
    ['SA-11 Buk LN 9A310M1']= "S11",
	['SA-11 Buk CC 9S470M1']= "S11",	
    ['BUK LL']=               "S11",
    ['Osa 9A33 ln']=          "SA8",	
    ['Tor 9A331']=            "S15",
    ['2S6 Tunguska']=         "2S6",
	
    ['ZSU-23-4 Shilka']=      "ZSU",
    ['Gepard']=               "AD",---
  --['Vulcan M163']=          "AU",---
	['Vulcan']=               "VUL",
	['M1097 Avenger']=        "VUL",
		
    ['KUZNECOW']=             "KUZ",
    ['Kuznecow']=             "KUZ",
    ['VINSON']=               "CVN",	-- SUPCAR-159: Carriers unknown on RWR - made the same as other carriers
    ['MOSCOW']=               "MOS",
    ['GROZNY']=               "GRO",
    ['AZOV']=                 "AZO",---
    ['ALBATROS']=             "ALB",
    ['AMETYST']=              "AME",
    ['OREL']=                 "ORE",
    ['REZKY']=                "REZ",
    ['PERRY']=                "PER",
    ['OSA']=                  "OSA",
    ['MOLNIYA']=              "MOL",
    ['SKORY']=                "SKO",
    ['SPRUANCE']=             "SPR",
    ['TICONDEROGA']=          "TIC",
    ['BORA']=                 "BOR",
    ['BOBRUISK']=             "BOB",
    ['VETER']=                "VET",
    ['NEUSTRASH']=            "NEU",
	
    ['MICA R']=               "MSL",---
    ['R-27AE']=               "MSL",
    ['R-77']=                 "MSL",
    ['R-37']=                 "MSL",
    ['AIM-54']=               "MSL",
  --['AIM-120']=              "MSL",
  --['AIM-120C']=             "MSL",
	--0020256: SA-3 as Unknown in the western RWR
    ['p-19 s-125 sr']=        "SRC",--P-19 		   - "Flat Face" radar (FF),
    ['snr s-125 tr']=         "SA3",--SNR S-125 Neva - "Low Blow" radar (LB).		
	['SNR_75V']=              "S75",--SNR S-75 Волхов Fan Song
  --['S-200_Radar']=          "SA5",--SNR S-200 Ангара
    ['RPC_5N62V']=            "SA5",
	['RLS_19J6']=             "SA5",

	['MiG-21Bis']		= 'M21',	
	['F-5E-3']			= 'F5',
	['F-16C_50']		= 'F16',		-- F16CB50-359: F-16 is unknown on RWR
	['FA-18C_hornet']	= 'F18',
	['J-11A']			= 'S27',
	
	--0045150: Rapier is unknown on RWR
	['rapier_fsa_blindfire_radar'] = 'RAP',
	['rapier_fsa_launcher']		   = 'RAP',

	-- SUPCAR-159: Carriers unknown on RWR
	['CVN_71']			= 'CVN',
	['CVN_72']			= 'CVN',
	['CVN_73']			= 'CVN',
    ['CVN_75']			= 'CVN',
	['Stennis']			= 'CVN',
    -- ['USS_Arleigh_Burke_IIa']	= 'AB',---
    ['CV_1143_5']		= 'CVN',
	--------------------------------
	['uda'] = 'UDA',
	['Kirov_Class'] = 'KIR',
	['Tarantula Class Corvette'] = 'TAR',
	['osa_class']   = 'OSA',	
	['Forrestal']   = 'FOR',
	['USS Kidd DD-993']   = 'KID',
    ['HMS Duncan']  = 'DUN',
	['WS_USS_Bainbridge']  = 'BAI',
	['USS Bainbridge CG-25']  = 'BAI',
	['USS Constellation FFGX-62']  = 'CON',
	['USS_Mount_Whitney']  = 'MOU',
	['sao_paulo']  = 'SAO',
	['PLAN_Liaoning']  = 'PLA',
    ['Charles deGaulle']  = 'CHA',
	['CharlesdeGaulle']  = 'CHA',
	['QE-S']  = 'QE',
	['HMS_QE']  = 'QE',
    ['HMS_Ocean']  = 'OCE',
	['HMS_Invincible']  = 'INV',
	['HMS_illustrious']  = 'ILL',
	['Nam_Atlantico']  = 'ATL',
    ['leander_class']  = 'LEC',
	['leander_class_exocet']  = 'LEC',
	['leander_class_exocet_array']  = 'LEC',
	['leander_class_towed_array']  = 'LEC',
	['mistral']  = 'MIS',
	['DDG39']    = 'DDG',
	['F100l']    = '001',
	['F105']     = '105',
	['USCGC Bertholf']     = 'BER',
    ['USCGC Galveston Island']     = 'GAL',
    ['USCGC Virginia']     = 'VIR',
	['USGCC Tampa 902']    = 'TAM',
	['USNS Patuxtent']    = 'PAT',
	['USS America LHA-6']    = 'AME',
	['USS Bowen FF-1079']    = 'BOW',
	['USS_Nassau']    = 'NAS',
	['USS_Saipan']    = 'SAI',
	['USS Oak Hill LSD-51']    = 'OAK',
	['USS San Antonio LPD-17'] = 'SAN',
	['HSwMS_Visby'] = 'VIS',
	
	-- F-14 heatblur
	['F-14A-135-GR'] = 'F14',	-- F18-1387: F-14A appears as 'U' in RWR
	['F-14B']		 = 'F14',
	['F-14D']		 = 'F14',
  --['AIM 54A Mk60'] = "MSL",
  --['AIM 54A Mk47'] = "MSL",
  --['AIM 54C Mk47'] = "MSL",
  
	['AIM_54A_Mk60'] = "MSL",
	['AIM_54A_Mk47'] = "MSL",
	['AIM_54C_Mk47'] = "MSL",
    ['AIM_23']       = "MSL",
		
	--RAZBAM
	['LHA Tarawa']	 	= '40', -- same AN/SPS-40 as on Spruance
	['M-2000C']			= 'M2K',
	['MiG-19P']			= 'M19',
	
	--Chinese
	['KJ-2000']			= 'J2K',--0045208: KJ-2000 shows as Unknown on Western RWR
	['JF-17']			= 'J17',--DCSCORE-1655 JF-17 Unknown on Western RWR
	['HQ-7 LN SP']		= 'HQ7', --DCSCORE-1083 HQ-7 from China Asset Pack listed as unknown on NATO RWR
	['HQ-7 STR SP']		= 'HQ7',--DCSCORE-1083 HQ-7 from China Asset Pack listed as unknown on NATO RWR
	['PL-12']			= "MSL",
	['SD-10']			= "MSL",
	['J-16']			= 'J16',
    ['Type_071']		= '071',---
    ['Type_052B']		= '052',---
    ['Type_052C']		= '052',---
    ['Type_054A']		= '054',---
	['NASAMS_Radar_MPQ64F1'] = 'NAS',
	
	
  --NIGHTSTORM
  --Mods added by NIGHTSTORM
	['F-22A']		 		= 'F22',
	['F_15ADV']	 		    = 'F15',	
	['F_15EX']	 		    = 'F15',
	['F_15EXG']	 		    = 'F15',	
	['F-16I']		 		= 'F16',		
	['F-16I-Sufa']	 		= 'F16',
	['F_16I_SUFA']	 		= 'F16',
	['F16ISUFA_AG']	 		= 'F16',		
	['F-15_SMTD']	 		= 'F15',		
	['MirageF1'	]			= 'MF1',		
	['MirageF1CT']			= 'MF1',		
	['Rafale_A_S']			= 'RAF',		
	['Rafale_B']			= 'RAF',			
	['Rafale_M']			= 'RAF',				
	['Rafale_M_NOUNOU']		= 'RAF',					
	['A-4E-C']		 		= 'A4',	
	['A-6E']		 		= 'A6',		
	['MB-339PAN']			= '339',		
	['FA-18E']				= 'F18',		
	['FA-18F']				= 'F18',			
	['EA_6B']				= 'EA6',		
	['EA-18G']				= 'E18',				
	['Hercules']			= '130',					
	['E-3A']				= 'E3',						
	['A400M_Atlas']			= '400',			
	['B2_Spirit']			= 'B2',				
	['C2A_Greyhound']		= 'C2',					
	['C5_Galaxy']			= 'C5',				
	['KC_10_Extender']		= 'K10',				
	['KC_10_Extender_D']	= 'K10',					
	['P3C_Orion']			= 'P3',				
	['V22_Osprey']			= 'V22',		
	['MQ9_PREDATOR_B']		= 'MQ9',			
	['KJ-600']				= 'E2',	
	['J-7D']				= 'M21',
	['J-10A']				= 'J10',	
	['J-11B']				= 'S27',	
	['J-11D']				= 'S27',		
	['J-15']				= 'S33',	
	['J-16']				= 'S30',
	['J-16 Flanker']		= 'S30',	
	['J-16 07 Batch']		= 'S30',		
	['J-20']				= 'J20',			
	['J-20B']				= 'J20',
    ['H-6J']				= 'H6',
	
	['Mig-23']				= 'M29',
    ['MiG_21M']				= 'M29',
	['MiG-29M']				= 'M29',
	['MiG-25BM']			= 'M25',
	['MiG-31BM']			= 'M31',
	['Su_24CM']             = 'S24',
	['Su_27SM3']		 	= 'S35',	
	['Su-30SM2']            = 'S30',
	['Cy-30CM2_AG']		 	= 'S30',	
  --['Su-30SM']		 		= 'S30',
	['Su-33M']		 		= 'S33',
	['Su-33M_AG']		 	= 'S33',
	['Su-35SK']		 		= 'S35',
	['Su-35AG']		 		= 'S35',	
	['Su-57']		 		= 'S57',
	['JAS39Gripen']		 	= 'JAS',
	['JAS39Gripen_AG']		= 'JAS',
	['Eurofighter']		    = 'EF2',
    ['RST_Eurofighter']		= 'EF2',
	['RST_Eurofighter_AG']	= 'EF2',
    ['CLP_E7A']	            = 'E7',
	['CLP_P8']	            = 'P8',
	['EC130']				= 'EC',
	['RC135RJ']				= 'RJ',
	['RC135CB']				= 'RJ',

--MISSILES
	['P_24R'] 				= "MSL",
	['P_60']  				= "MSL",
	['P_33E'] 				= "MSL",
	['P_27AE']				= "MSL",
	['P_27P'] 				= "MSL",
	['P_27PE']				= "MSL",
	['P_27T'] 				= "MSL",
	['P_27TE']				= "MSL",
	['P_27EM']				= "MSL",
	['P_73']  				= "MSL",
	['P_77']  				= "MSL",
	['P_37']  				= "MSL", 
	['AIM_7'] 				= "MSL",
	['AIM_9'] 				= "MSL",
	['AIM_54']				= "MSL",
	['AIM_120']				= "MSL",
	['P_23T']  				= "MSL",
	['P_24T']  				= "MSL",
	['P_40T']  				= "MSL",
	['R_550']  				= "MSL",
	['MICA_T'] 				= "MSL",
	['MICA_R']  			= "MSL",
	['Super_530'] 			= "MSL",
	['P_98']  				= "MSL",
	['P_4R'] 				= "MSL",
	['P_40R']				= "MSL", 	
	['MICA_R_']				= "MSL",
	['P_27AE_']				= "MSL",
	['P_77_ =']				= "MSL",	
	['P_37_	=']				= "MSL",
	['AIM_54_']				= "MSL",
	['AIM_120_']			= "MSL",
	['AIM_120C']			= "MSL",
	['SeaSparrow'] 			= "MSL", 
	['AIM_120A']	 		= "MSL",
	['AIM-120A']	 		= "MSL",
	['AIM_120C_5']	 		= "MSL",
	['AIM_120C']	 		= "MSL",
	['AIM_120C_6']	 		= "MSL",--AIM-120C-6		
	['AIM_120C_7']	 		= "MSL",	
	['AIM_120D']	 		= "MSL",
	['AIM_120']	 		    = "MSL",	
	['PL-12A']	 			= "MSL",				
	['PL-15']	 			= "MSL",			
	['PL-15E']	 			= "MSL",		
	['RVV-L']	 			= "MSL",
	['RVV-L_NUC']	 		= "MSL",
    ['R-24RM']	 		    = "MSL",
    ['R-27RM']	 		    = "MSL",
    ['R-27ERM']	 		    = "MSL",
    ['R-27EA']	 		    = "MSL",
	['RVV-M']	 			= "MSL",
	['R-37']	 			= "MSL",
    ['R-37NUC']	 			= "MSL",
    ['R-40RM']	 			= "MSL",	
	['R-77']	 			= "MSL",	
	['K-77M']	 			= "MSL",
	['RVV-AE']	 			= "MSL",
	['RVV-AE-PD']	 		= "MSL",
	['RVV-BD']	 		    = "MSL",
    ['RVV-SBD']	 		    = "MSL",
	['Astra']	 			= "MSL",
	['I-Derby ER BVRAAM Active Rdr AAM'] = "MSL",
	['Meteor BVRAAM Active Rdr AAM'] = "MSL",
	['MBDA_Meteor']	 		= "MSL",
	['METEOR']	 			= "MSL",
	['EF_Meteor']	 		= "MSL",
	['MICA_NG']	 			= "MSL",
	['MICA_R']	 			= "MSL",
  --['Matra_S530D']	 		= "MSL",	
  --['Super_530D']	 		= "MSL",
------------------------------------------------------------------	
	['Meteor-N'] 			= "MSL",		
	['Meteor BVRAAM (NUCLEAR) - Active Rdr AAM'] 			= "MSL",	
	['AIM-120B AMRAAM Active Rdr AAM'] 						= "MSL",	
	['AIM-120C-5 AMRAAM Active Rdr AAM'] 					= "MSL",	
	['AIM-120C-7 AMRAAM Active Rdr AAM'] 					= "MSL",		
-------------------------------------------------------------------

--VSN Aircraft	
	['VSN_A6A']				= 'A6',		
	['VSN_AJS37Viggen']		= 'AJS',	
	['VSN_E2D']				= 'E2',		
	['VSN_Eurofighter']		= 'EF2',								
	['VSN_Eurofighter_AG']	= 'EF2',
	['VSN_F4B']		 		= 'F4',	
	['VSN_F4E']		 		= 'F4',		
	['VSN_F4E_AG']	 		= 'F4',		
	['VSN_F5E']		 		= 'F5',			
	['VSN_F5N']		 		= 'F5',			
	['VSN_F14A']			= 'F14',	
	['VSN_F14B']			= 'F14',		
	['VSN_F15E']	 		= 'F15',		
	['VSN_F15E_AA']	 		= 'F15',		
	['VSN_F16A']	 		= 'F16',	
	
	--['F_16MLU']	 		= '16',		
	--['F-16BL50'] 		    = '16',		
	--['F-16B_L52D'] 		= '16',	

	['VSN_F16AMLU']	 		= 'F16',		
	['VSN_F16CBL50'] 		= 'F16',		
	['VSN_F16CBL52D'] 		= 'F16',	
	['VSN_F16CMBL50'] 		= 'F16',			
	['VSN_F16CMBL50_AG'] 	= 'F16',	
	['VSN_F22']		 		= 'F22',			
	['VSN_F35A']	 		= 'F35',		
	['VSN_F35A_AG']	 		= 'F35',			
	['VSN_F35B']	 		= 'F35',		
	['VSN_F35B_AG']	 		= 'F35',			
	['VSN_F35C']	 		= 'F35',		
	['VSN_F35C_AG']	 		= 'F35',
  --['VSN_F35A']	 		= 'F35',		
  --['VSN_F35A_AG']	 		= 'F35',			
  --['VSN_F35B']	 		= 'F35',		
  --['VSN_F35B_AG']	 		= 'F35',			
  --['VSN_F35C']	 		= 'F35',		
  --['VSN_F35C_AG']	 		= 'F35',	
  --['VSN_F104G']			= 'F5',	
  --['VSN_F104G_AG']		= 'F5',	
  --['VSN_F104S']			= 'F5',	
  --['VSN_F104S_AG']		= 'F5',
    ['VSN_F104C']			= '104',	
	['VSN_F104G']			= '104',	   
	['VSN_F104G_AG']		= '104',	
	['VSN_F104S']			= '104',	
	['VSN_F104S_AG']		= '104',	
  --['VSN_F105D']			= 'F5',	
  --['VSN_F105G']			= 'F5',
	['VSN_F105D']			= '105',	
	['VSN_F105G']			= '105',	
	['VSN_FA18C_Lot20']		= 'F18',			
	['VSN_FA18C_Lot20_AG']	= 'F18',				
	['VSN_FA18C']	 		= 'F18',		
	['VSN_FA18C_AG']		= 'F18',			
	['VSN_FA18D']			= 'F18',			
	['VSN_FA18D_AG']		= 'F18',				
	['VSN_EA18G']			= 'F18',						
	['VSN_FA18F']			= 'F18',					
	['VSN_FA18F_AG']		= 'F18',						
	['VSN_Harrier']			= 'AV8',		
	['VSN_JAS39Gripen']		= 'JAS',			
	['VSN_JAS39Gripen_AG']	= 'JAS',		
	['VSN_M2000']			= 'M2K',			
	['VSN_MirageIIIC'	]	= 'MI3',		
	['VSN_MirageIIIC_AG']	= 'MI3',			
	['VSN_MirageIIIS']		= 'MI3',				
	['VSN_SEM']				= 'SEM',		
	['VSN_Su34']			= 'S34',						
	['VSN_Su34_AG']			= 'S34',							
	['VSN_TornadoGR4']		= 'TOR',	
	['VSN_TornadoIDS']		= 'TOR',	
    ['VSN_UFO']			    = 'UFO',	
	['VSN_YF12A']			= 'F71',
	
--HIGHDIGITSAMS (Sensors)

	['SA-17 Buk TR']		= 'S17',	
	['SA-17 Buk M1-2 LN 9A310M1-2']		= 'S17',	
	['S-300V 9S32 tr']		= 'S10',		
	['S-300V 9S19 sr']		= 'S10',		
	['S-300V 9S15 sr']		= 'S10',		
	['S-300VM 9S32ME tr']	= 'S10',			
	['S-300VM 9S19M2 sr']	= 'S10',				
	['S-300VM 9S15M2 sr']	= 'S10',					
	['S-300PS 64H6E TRAILER sr']		= 'S10',						
	['S-300PS SA-10B 40B6MD MAST sr']	= 'S10',					
	['S-300PS 40B6M MAST tr']			= 'S10',						
	['S-300PS 30H6 TRAILER tr']			= 'S10',
	['S-300PS 30N6 TRAILER tr']			= 'S10',	
    ['S-300PMU1 30N6E tr']			    = 'S10',
    ['S-300PMU1 40B6M tr']			    = 'S10',
	['S-300PS SA-10B 40B6M MAST tr']	= 'S10',
	['S-300PMU1 64N6E sr']	            = 'S10',
	['Fire Can radar']	                = 'A',
		
	['S-300PMU2 64H6E2 sr']				= 'S10',					
	['S-300PMU2 92H6E tr']				= 'S10',						
	['SAMP/T ARABEL str']				= 'SAP',				
	['SAMP/T NG GF300 str']				= 'SAP',					
	['34Ya6E Gazetchik E decoy']		= 'S10',						
	--['SON-9 Fire Can TR']				= 'A',
	['HQ-7 LN SP']		= 'HQ7', --DCSCORE-1083 HQ-7 from China Asset Pack listed as unknown on NATO RWR
	['HQ-7 STR SP']		= 'HQ7',--DCSCORE-1083 HQ-7 from China Asset Pack listed as unknown on NATO RWR
	['EWR 1L119 Nebo-SVU']				= "EWR",
	['EWR 55G6U NEBO-U']				= "EWR",
    ['EWR P-37 BAR LOCK']				= "EWR",
	['EWR Generic radar tower']		    = "EWR",
	
	['S-400 76N6 SR']				    = 'S21',	
	['S-400 91N6E SR']				    = 'S21',
	['S-400 92N6E TR']				    = 'S21',
	['S-400 PDU 55K6E CP']				= 'S21',

	['AH-64D']		                    = 'H64',
	['AH-64D_BLK_II']		            = 'H64',
	['OH-58D']		                    = 'H58',
	
--HIGHDIGITSAMS (Sensors)	
}
 
function get_threat_type(tmp_rwr_type, name_type)
	local vtmp_rwr_type = symbols_strings[tmp_rwr_type]
	if vtmp_rwr_type == nil then
		vtmp_rwr_type = symbols_strings_new[tmp_rwr_type]
		if vtmp_rwr_type ~= nil then
			if name_type == 2 then
				return tostring(vtmp_rwr_type)
			else
				return " "..tostring(vtmp_rwr_type)
			end 
		else
			return "UNK"
		end
	else
		if name_type == 2 then
			return tostring(vtmp_rwr_type)
		else
			return " "..tostring(vtmp_rwr_type)
		end 
	end
end