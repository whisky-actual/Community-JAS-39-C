dofile(LockOn_Options.common_script_path..'AN_ALR_SymbolsBase.lua')

TYPEPlane = 1
TYPESearchRadar = 2
TYPEEWR = 3
TYPESEA = 4
TYPEMissile = 5
 
symbols_strings_new = {
    ['MiG-23MLD']=    "23",
    ['MiG-29A']=      "29",
    ['MIG-29K']=      "29",
    ['MiG-29G']=      "29",
    ['MiG-29S']=      "29",
	
    ['Su-27']=        "27",
	['Su-30']=        "30",
    ['Su-33']=        "33",
	['Su-34']=        "34",
    ['F-14']=         "14",
    ['F-15']=         "15",
    ['F-15C']=        "15",
	['F-15E']=        "15",
    ['F-16']=         "16",
    ['F-16A']=        "16",
	
    ['F-2']=          "F2",
    ['Cy-30MC']=      "30",
    ['Su-30MKA']=     "30",
    ['Su-30MKI']=     "30",
    ['Su-30MKM']=     "30",
    ['Su-30MKK']=     "30",

    ['FA-18A']=       "18",
    ['FA-18C']=       "18",

    ['Mirage']=       "M2",
    ['F-4E']=         "F4",
    ['F-5E']=         "F5",
    ['Su-24']=        "24",
    ['Su-24MR']=      "24",
    ['AV-8B']=        "AV",
    ['EA-6B']=        "E6",
    ['F-111']=        "11",
    ['Tu-160']=       "BJ",
    ['B-1']=          "B1",
    ['Tu-22M3']=      "22",
    ['MiG-25PD']=     "25",
    ['MiG-31']=       "31",
    ['Tu-95']=        "95",
    ['Tu-142']=       "Tu",
    ['B-52']=         "52",
    ['A-50']=         "50",
    ['E-3']=          "E3",
    ['S-3A']=         "S3",
    ['S-3R']=         "S3",
    ['E-2C']=         "E2",
	['E-2D']=         "E2",
    ['C-17']=         "17",
    ['C-130']=        "13",
    ['IL-76']=        "76",
    ['AN-26B']=       "AN",
    ['AN-30M']=       "AN",
    ['KC-10']=        "KC",
    ['KC-135']=       "KC",
    ['IL-78']=        "78",
    ['Su-39']=        "39",	
    ['1L13 EWR']=             "S",	
    ['55G6 EWR']=             "S",
	
    ['S300PS SR 5N66M']=      "10",---
    ['S300PS SR 64H6E']=      "10",---
    ['RLO 9C15MT']=           "BD",---
    ['RLO 9C19M2']=           "HS",---
  --['Buk SR 9S18M1']=        "SD",---
	['SA-11 Buk SR 9S18M1']	= "SD",
    ['Kub 1S91 str']=         "6",
    ['Dog Ear radar']=        "DE",---
	['Roland ADS']=           "RO",	
    ['Roland Radar']=         "RO",		
	['Patriot str']=          "P",	
    ['Hawk SR ANMPQ 50']=     "HK",---
    ['S300PS TR 30N6']=       "10",
	['S-300PS 40B6M tr']=     "10",
	['S-300PS 40B6MD sr']=    "10",
	['S-300PS 64H6E sr']=     "10",
		
    ['RLS 5H63C']=            "5H",---
    ['RLS 9C32 1']=           "12",
    ['Hawk TR ANMPQ 46']=     "HK",
	['Hawk tr']=              "HK",
	['Hawk sr']=              "HK",
	['Hawk cwar']=            "HK",
	['Hawk pcp']=             "HK",		
    ['S300V 9A82']=           "12",
    ['S300V 9A83']=           "12",
    ['SA-11 Buk LN 9A310M1']= "11",
	['SA-11 Buk CC 9S470M1']= "11",	
    ['BUK LL']=               "11",
    ['Osa 9A33 ln']=          "8",	
    ['Tor 9A331']=            "TR",
    ['2S6 Tunguska']=         "2S",
	
    ['ZSU-23-4 Shilka']=      "A",
    ['Gepard']=               "AD",---
  --['Vulcan M163']=          "AU",---
	['Vulcan']=               "AU",
	['M1097 Avenger']=        "AU",
		
    ['KUZNECOW']=             "SW",
    ['Kuznecow']=             "SW",
    ['VINSON']=               "SS",	-- SUPCAR-159: Carriers unknown on RWR - made the same as other carriers
    ['MOSCOW']=               "MW",
    ['GROZNY']=               "HN",
    ['AZOV']=                 "AZ",---
    ['ALBATROS']=             "HP",
    ['AMETYST']=              "SC",
    ['OREL']=                 "HN",
    ['REZKY']=                "TP",
    ['PERRY']=                "49",
    ['OSA']=                  "DT",
    ['MOLNIYA']=              "PS",
    ['SKORY']=                "HN",
    ['SPRUANCE']=             "40",
    ['TICONDEROGA']=          "AE",
    ['BORA']=                 "CD",
    ['BOBRUISK']=             "CD",
    ['VETER']=                "PP",
    ['NEUSTRASH']=            "TP",
	
    ['MICA R']=               "M",---
    ['R-27AE']=               "M",
    ['R-77']=                 "M",
    ['R-37']=                 "M",
    ['AIM-54']=               "M",
  --['AIM-120']=              "M",
  --['AIM-120C']=             "M",
	--0020256: SA-3 as Unknown in the western RWR
    ['p-19 s-125 sr']=        "S",--P-19 		   - "Flat Face" radar (FF),
    ['snr s-125 tr']=         "3",--SNR S-125 Neva - "Low Blow" radar (LB).		
	['SNR_75V']=              "75",--SNR S-75 Волхов Fan Song
  --['S-200_Radar']=          "5",--SNR S-200 Ангара
    ['RPC_5N62V']=            "5",
	['RLS_19J6']=             "5",

	['MiG-21Bis']		= '21',	
	['F-5E-3']			= 'F5',
	['F-16C_50']		= '16',		-- F16CB50-359: F-16 is unknown on RWR
	['FA-18C_hornet']	= '18',
	['J-11A']			= '27',
	
	--0045150: Rapier is unknown on RWR
	['rapier_fsa_blindfire_radar'] = 'RP',
	['rapier_fsa_launcher']		   = 'RT',

	-- SUPCAR-159: Carriers unknown on RWR
	['CVN_71']			= 'SS',
	['CVN_72']			= 'SS',
	['CVN_73']			= 'SS',
    ['CVN_75']			= 'SS',
	['Stennis']			= 'SS',
    -- ['USS_Arleigh_Burke_IIa']	= 'AB',---
    ['CV_1143_5']		= 'KZ',
	--------------------------------
	['uda'] = 'UD',
	['Kirov_Class'] = 'KV',
	['Tarantula Class Corvette'] = 'TL',
	['osa_class']   = 'OS',	
	['Forrestal']   = 'FS',
	['USS Kidd DD-993']   = 'SP',
    ['HMS Duncan']  = 'DN',
	['WS_USS_Bainbridge']  = 'BN',
	['USS Bainbridge CG-25']  = 'BG',
	['USS Constellation FFGX-62']  = 'CL',
	['USS_Mount_Whitney']  = 'MW',
	['sao_paulo']  = 'SL',
	['PLAN_Liaoning']  = 'PL',
    ['Charles deGaulle']  = 'CD',
	['CharlesdeGaulle']  = 'CD',
	['QE-S']  = 'QE',
	['HMS_QE']  = 'QE',
    ['HMS_Ocean']  = 'OC',
	['HMS_Invincible']  = 'IN',
	['HMS_illustrious']  = 'IL',
	['Nam_Atlantico']  = 'AT',
    ['leander_class']  = 'LC',
	['leander_class_exocet']  = 'LC',
	['leander_class_exocet_array']  = 'LC',
	['leander_class_towed_array']  = 'LC',
	['mistral']  = 'ML',
	['DDG39']    = 'D9',
	['F100l']    = 'F0',
	['F105']     = 'F1',
	['USCGC Bertholf']     = 'CG',
    ['USCGC Galveston Island']     = 'CG',
    ['USCGC Virginia']     = 'CG',
	['USGCC Tampa 902']    = 'CG',
	['USNS Patuxtent']    = 'PX',
	['USS America LHA-6']    = 'AR',
	['USS Bowen FF-1079']    = 'BW',
	['USS_Nassau']    = 'TW',
	['USS_Saipan']    = 'TW',
	['USS Oak Hill LSD-51']    = 'OH',
	['USS San Antonio LPD-17'] = 'SA',
	['HSwMS_Visby'] = 'Vi',
	
	-- F-14 heatblur
	['F-14A-135-GR'] = '14',	-- F18-1387: F-14A appears as 'U' in RWR
	['F-14B']		 = '14',
	['F-14D']		 = '14',
  --['AIM 54A Mk60'] = "M",
  --['AIM 54A Mk47'] = "M",
  --['AIM 54C Mk47'] = "M",
  
	['AIM_54A_Mk60'] = "M",
	['AIM_54A_Mk47'] = "M",
	['AIM_54C_Mk47'] = "M",
    ['AIM_23']       = "M",
		
	--RAZBAM
	['LHA Tarawa']	 	= '40', -- same AN/SPS-40 as on Spruance
	['M-2000C']			= 'M2',
	['MiG-19P']			= '19',
	
	--Chinese
	['KJ-2000']			= '50',--0045208: KJ-2000 shows as Unknown on Western RWR
	['JF-17']			= 'JF',--DCSCORE-1655 JF-17 Unknown on Western RWR
	['HQ-7 LN SP']		= '7', --DCSCORE-1083 HQ-7 from China Asset Pack listed as unknown on NATO RWR
	['HQ-7 STR SP']		= 'HQ',--DCSCORE-1083 HQ-7 from China Asset Pack listed as unknown on NATO RWR
	['PL-12']			= "M",
	['SD-10']			= "M",
	['J-16']			= '16',
    ['Type_071']		= '71',---
    ['Type_052B']		= '52',---
    ['Type_052C']		= '52',---
    ['Type_054A']		= '54',---
	['NASAMS_Radar_MPQ64F1'] = 'NS',
	
	
  --NIGHTSTORM
  --Mods added by NIGHTSTORM
	['F-22A']		 		= '22',
	['F_15ADV']	 		    = '15',	
	['F_15EX']	 		    = '15',
	['F_15EXG']	 		    = '15',	
	['F-16I']		 		= '16',		
	['F-16I-Sufa']	 		= '16',
	['F_16I_SUFA']	 		= '16',
	['F16ISUFA_AG']	 		= '16',		
	['F-15_SMTD']	 		= '15',		
	['MirageF1'	]			= 'M1',		
	['MirageF1CT']			= 'M1',		
	['Rafale_A_S']			= 'RF',		
	['Rafale_B']			= 'RF',			
	['Rafale_M']			= 'RF',				
	['Rafale_M_NOUNOU']		= 'RF',					
	['A-4E-C']		 		= 'A4',	
	['A-6E']		 		= 'A6',		
	['MB-339PAN']			= 'MB',		
	['FA-18E']				= '18',		
	['FA-18F']				= '18',			
	['EA_6B']				= 'E6',		
	['EA-18G']				= '18',				
	['Hercules']			= '13',					
	['E-3A']				= 'E3',						
	['A400M_Atlas']			= 'AM',			
	['B2_Spirit']			= 'B2',				
	['C2A_Greyhound']		= 'C2',					
	['C5_Galaxy']			= 'C5',				
	['KC_10_Extender']		= 'KC',				
	['KC_10_Extender_D']	= 'KC',					
	['P3C_Orion']			= 'P3',				
	['V22_Osprey']			= 'V2',		
	['MQ9_PREDATOR_B']		= 'MQ',			
	['KJ-600']				= 'E2',	
	['J-7D']				= '21',
	['J-10A']				= 'J0',	
	['J-11B']				= '27',	
	['J-11D']				= '27',		
	['J-15']				= '33',	
	['J-16']				= '30',
	['J-16 Flanker']		= '30',	
	['J-16 07 Batch']		= '30',		
	['J-20']				= '20',			
	['J-20B']				= '20',
    ['H-6J']				= 'H6',
	
	['Mig-23']				= '29',
    ['MiG_21M']				= '29',
	['MiG-29M']				= '29',
	['MiG-25BM']			= '25',
	['MiG-31BM']			= '31',
	['Su_24CM']             = '24',
	['Su_27SM3']		 	= '35',	
	['Su-30SM2']            = '30',
	['Cy-30CM2_AG']		 	= '30',	
  --['Su-30SM']		 		= '30',
	['Su-33M']		 		= '33',
	['Su-33M_AG']		 	= '33',
	['Su-35SK']		 		= '35',
	['Su-35AG']		 		= '35',	
	['Su-57']		 		= '57',
	['JAS39Gripen']		 	= '39',
	['JAS39Gripen_AG']		= '39',
	['Eurofighter']		    = 'TY',
    ['RST_Eurofighter']		= 'TY',
	['RST_Eurofighter_AG']	= 'TY',
    ['CLP_E7A']	            = 'E7',
	['CLP_P8']	            = 'P8',
	['EC130']				= 'EC',
	['RC135RJ']				= 'RJ',
	['RC135CB']				= 'RJ',

--MISSILES
	['P_24R'] 				= "M",
	['P_60']  				= "M",
	['P_33E'] 				= "M",
	['P_27AE']				= "M",
	['P_27P'] 				= "M",
	['P_27PE']				= "M",
	['P_27T'] 				= "M",
	['P_27TE']				= "M",
	['P_27EM']				= "M",
	['P_73']  				= "M",
	['P_77']  				= "M",
	['P_37']  				= "M", 
	['AIM_7'] 				= "M",
	['AIM_9'] 				= "M",
	['AIM_54']				= "M",
	['AIM_120']				= "M",
	['P_23T']  				= "M",
	['P_24T']  				= "M",
	['P_40T']  				= "M",
	['R_550']  				= "M",
	['MICA_T'] 				= "M",
	['MICA_R']  			= "M",
	['Super_530'] 			= "M",
	['P_98']  				= "M",
	['P_4R'] 				= "M",
	['P_40R']				= "M", 	
	['MICA_R_']				= "M",
	['P_27AE_']				= "M",
	['P_77_ =']				= "M",	
	['P_37_	=']				= "M",
	['AIM_54_']				= "M",
	['AIM_120_']			= "M",
	['AIM_120C']			= "M",
	['SeaSparrow'] 			= "M", 
	['AIM_120A']	 		= "M",
	['AIM-120A']	 		= "M",
	['AIM_120C_5']	 		= "M",
	['AIM_120C']	 		= "M",
	['AIM_120C_6']	 		= "M",--AIM-120C-6		
	['AIM_120C_7']	 		= "M",	
	['AIM_120D']	 		= "M",
	['AIM_120']	 		    = "M",	
	['PL-12A']	 			= "M",				
	['PL-15']	 			= "M",			
	['PL-15E']	 			= "M",		
	['RVV-L']	 			= "M",
	['RVV-L_NUC']	 		= "M",
    ['R-24RM']	 		    = "M",
    ['R-27RM']	 		    = "M",
    ['R-27ERM']	 		    = "M",
    ['R-27EA']	 		    = "M",
	['RVV-M']	 			= "M",
	['R-37']	 			= "M",
    ['R-37NUC']	 			= "M",
    ['R-40RM']	 			= "M",	
	['R-77']	 			= "M",	
	['K-77M']	 			= "M",
	['RVV-AE']	 			= "M",
	['RVV-AE-PD']	 		= "M",
	['RVV-BD']	 		    = "M",
    ['RVV-SBD']	 		    = "M",
	['Astra']	 			= "M",
	['I-Derby ER BVRAAM Active Rdr AAM'] = "M",
	['Meteor BVRAAM Active Rdr AAM'] = "M",
	['MBDA_Meteor']	 		= "M",
	['METEOR']	 			= "M",
	['EF_Meteor']	 		= "M",
	['MICA_NG']	 			= "M",
	['MICA_R']	 			= "M",
  --['Matra_S530D']	 		= "M",	
  --['Super_530D']	 		= "M",
------------------------------------------------------------------	
	['Meteor-N'] 			= "M",		
	['Meteor BVRAAM (NUCLEAR) - Active Rdr AAM'] 			= "M",	
	['AIM-120B AMRAAM Active Rdr AAM'] 						= "M",	
	['AIM-120C-5 AMRAAM Active Rdr AAM'] 					= "M",	
	['AIM-120C-7 AMRAAM Active Rdr AAM'] 					= "M",		
-------------------------------------------------------------------

--VSN Aircraft	
	['VSN_A6A']				= 'A6',		
	['VSN_AJS37Viggen']		= 'VG',	
	['VSN_E2D']				= 'E2',		
	['VSN_Eurofighter']		= 'TY',								
	['VSN_Eurofighter_AG']	= 'TY',
	['VSN_F4B']		 		= 'F4',	
	['VSN_F4E']		 		= 'F4',		
	['VSN_F4E_AG']	 		= 'F4',		
	['VSN_F5E']		 		= 'F5',			
	['VSN_F5N']		 		= 'F5',			
	['VSN_F14A']			= '14',	
	['VSN_F14B']			= '14',		
	['VSN_F15E']	 		= '15',		
	['VSN_F15E_AA']	 		= '15',		
	['VSN_F16A']	 		= '16',	
	
	--['F_16MLU']	 		= '16',		
	--['F-16BL50'] 		    = '16',		
	--['F-16B_L52D'] 		= '16',	

	['VSN_F16AMLU']	 		= '16',		
	['VSN_F16CBL50'] 		= '16',		
	['VSN_F16CBL52D'] 		= '16',	
	['VSN_F16CMBL50'] 		= '16',			
	['VSN_F16CMBL50_AG'] 	= '16',	
	['VSN_F22']		 		= '22',			
	['VSN_F35A']	 		= 'L2',		
	['VSN_F35A_AG']	 		= 'L2',			
	['VSN_F35B']	 		= 'L2',		
	['VSN_F35B_AG']	 		= 'L2',			
	['VSN_F35C']	 		= 'L2',		
	['VSN_F35C_AG']	 		= 'L2',
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
    ['VSN_F104C']			= 'SF',	
	['VSN_F104G']			= 'SF',	   
	['VSN_F104G_AG']		= 'SF',	
	['VSN_F104S']			= 'SF',	
	['VSN_F104S_AG']		= 'SF',	
  --['VSN_F105D']			= 'F5',	
  --['VSN_F105G']			= 'F5',
	['VSN_F105D']			= 'TC',	
	['VSN_F105G']			= 'TC',	
	['VSN_FA18C_Lot20']		= '18',			
	['VSN_FA18C_Lot20_AG']	= '18',				
	['VSN_FA18C']	 		= '18',		
	['VSN_FA18C_AG']		= '18',			
	['VSN_FA18D']			= '18',			
	['VSN_FA18D_AG']		= '18',				
	['VSN_EA18G']			= '18',						
	['VSN_FA18F']			= '18',					
	['VSN_FA18F_AG']		= '18',						
	['VSN_Harrier']			= 'AV',		
	['VSN_JAS39Gripen']		= '39',			
	['VSN_JAS39Gripen_AG']	= '39',		
	['VSN_M2000']			= 'M2',			
	['VSN_MirageIIIC'	]	= 'M3',		
	['VSN_MirageIIIC_AG']	= 'M3',			
	['VSN_MirageIIIS']		= 'M3',				
	['VSN_SEM']				= 'SM',		
	['VSN_Su34']			= '34',						
	['VSN_Su34_AG']			= '34',							
	['VSN_TornadoGR4']		= 'TN',	
	['VSN_TornadoIDS']		= 'TN',	
    ['VSN_UFO']			    = 'UO',	
	['VSN_YF12A']			= '71',
	
--HIGHDIGITSAMS (Sensors)

	['SA-17 Buk TR']		= 'SD',	
	['SA-17 Buk M1-2 LN 9A310M1-2']		= 'SD',	
	['S-300V 9S32 tr']		= '10',		
	['S-300V 9S19 sr']		= '10',		
	['S-300V 9S15 sr']		= '10',		
	['S-300VM 9S32ME tr']	= '10',			
	['S-300VM 9S19M2 sr']	= '10',				
	['S-300VM 9S15M2 sr']	= '10',					
	['S-300PS 64H6E TRAILER sr']		= '10',						
	['S-300PS SA-10B 40B6MD MAST sr']	= '10',					
	['S-300PS 40B6M MAST tr']			= '10',						
	['S-300PS 30H6 TRAILER tr']			= '10',
	['S-300PS 30N6 TRAILER tr']			= '10',	
    ['S-300PMU1 30N6E tr']			    = '10',
    ['S-300PMU1 40B6M tr']			    = '10',
	['S-300PS SA-10B 40B6M MAST tr']	= '10',
	['S-300PMU1 64N6E sr']	            = '10',
	['Fire Can radar']	                = 'A',
		
	['S-300PMU2 64H6E2 sr']				= '10',					
	['S-300PMU2 92H6E tr']				= '10',						
	['SAMP/T ARABEL str']				= 'SD',				
	['SAMP/T NG GF300 str']				= 'SD',					
	['34Ya6E Gazetchik E decoy']		= '10',						
	--['SON-9 Fire Can TR']				= 'A',
	['HQ-7 LN SP']		= '7', --DCSCORE-1083 HQ-7 from China Asset Pack listed as unknown on NATO RWR
	['HQ-7 STR SP']		= 'HQ',--DCSCORE-1083 HQ-7 from China Asset Pack listed as unknown on NATO RWR
	['EWR 1L119 Nebo-SVU']				= 'EW',
	['EWR 55G6U NEBO-U']				= 'EW',
    ['EWR P-37 BAR LOCK']				= 'EW',
	['EWR Generic radar tower']		    = 'EW',
	
	['S-400 76N6 SR']				    = 'Gr',	
	['S-400 91N6E SR']				    = 'Gr',
	['S-400 92N6E TR']				    = 'Gr',
	['S-400 PDU 55K6E CP']				= 'Gr',

	['AH-64D']		                    = 'AP',
	['AH-64D_BLK_II']		            = 'AP',
  --['OH-58D']		                    = 'KW',
	
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
			return "U"
		end
	else
		if name_type == 2 then
			return tostring(vtmp_rwr_type)
		else
			return " "..tostring(vtmp_rwr_type)
		end 
	end
end