dofile(LockOn_Options.script_path.."command_defs.lua")
local update_time_step = 0.05 
make_default_activity(update_time_step)
local dev = GetSelf()
-- Local variables ==================
local Page_changed = 0

-- params =====================================================
-- LEFT DISPLAY ===================
local LD_UPPER = get_param_handle("LD_UPPER")		
local LD_LOWER = get_param_handle("LD_LOWER")		
local LD_EMGY_MODE = get_param_handle("LD_EMGY_MODE")		
local STORES_TOGGLE = get_param_handle("STORES_TOGGLE")		
local altMode = get_param_handle("altMode")		
local CURSOR_TOGGLE = get_param_handle("CURSOR_TOGGLE")		
local HUD_ON_MFD_TOGGLE = get_param_handle("HUD_ON_MFD_TOGGLE")		
local CABIN_TOGGLE = get_param_handle("CABIN_TOGGLE")		
local EPERROR_TOGGLE = get_param_handle("EPERROR_TOGGLE")		
local ECON_TOGGLE = get_param_handle("ECON_TOGGLE")		
local HCAM_TOGGLE = get_param_handle("HCAM_TOGGLE")		
local headingMode = get_param_handle("headingMode")		
local EWS_MODE = get_param_handle("EWS_MODE")		
local FLAR_TOGGLE = get_param_handle("FLAR_TOGGLE")		
local CHAF_TOGGLE = get_param_handle("CHAF_TOGGLE")		
local SCAL_MODE = get_param_handle("SCAL_MODE")		
local NORM_MODE	= get_param_handle("NORM_MODE")	
local UNIT_MODE = get_param_handle("UNIT_MODE")
local MLAS_TOGGLE = get_param_handle("MLAS_TOGGLE")
local SYMB_TOGGLE = get_param_handle("SYMB_TOGGLE")
local SRCH_TRCK_MODE = get_param_handle("SRCH_TRCK_MODE")
local BOST_TOGGLE = get_param_handle("BOST_TOGGLE")
local WHOT_TOGGLE = get_param_handle("WHOT_TOGGLE")
local IFB_TOGGLE = get_param_handle("IFB_TOGGLE")
-- EMGY specific
local LD_TEMP_TOGGLE = get_param_handle("LD_TEMP_TOGGLE")
local LD_ENG_TOGGLE = get_param_handle("LD_ENG_TOGGLE")
local LD_VSI_TOGGLE = get_param_handle("LD_VSI_TOGGLE")
-- Hide 3d object blocking ldp
local LDP_BACKGROUND = get_param_handle("LDP_BACKGROUND")
-- Hide 3d object blocking rwr
local RWR_BACKGROUND = get_param_handle("RWR_BACKGROUND")
local RDR_BACKGROUND = get_param_handle("RDR_BACKGROUND")

local PLAYER_SELECTED_STATION = get_param_handle("PLAYER_SELECTED_STATION")
local LDBrightness  = get_param_handle("LDBrightness")
local CDBrightness = get_param_handle("CDBrightness")
local RDBrightness = get_param_handle("RDBrightness")
get_param_handle("ONE"):set(1)

local HOURTIME = get_param_handle("HOURTIME")
local MINUTESTIME = get_param_handle("MINUTESTIME")
local SECONDSTIME = get_param_handle("SECONDSTIME")

-- INDX = Number of pages
local LD_UPPER_INDX = 4	
local LD_LOWER_INDX = 3

local LD_last_page_was = 1
-- CENTER DISPLAY ===================
local CD_EMGY_MODE = get_param_handle("CD_EMGY_MODE")
local CD_LDG_TOGGLE = get_param_handle("CD_LDG_TOGGLE")
local CD_EWS_TOGGLE = get_param_handle("CD_EWS_TOGGLE")
local CD_FIX_TOGGLE = get_param_handle("CD_FIX_TOGGLE")
-- EMGY specific
local CD_TEMP_TOGGLE = get_param_handle("CD_TEMP_TOGGLE")
local CD_ENG_TOGGLE = get_param_handle("CD_ENG_TOGGLE")
local CD_VSI_TOGGLE = get_param_handle("CD_VSI_TOGGLE")

-- RIGHT DISPLAY ===================
local RD_EMGY_MODE = get_param_handle("RD_EMGY_MODE")

-- EMGY specific
local RD_TEMP_TOGGLE = get_param_handle("RD_TEMP_TOGGLE")
local RD_ENG_TOGGLE = get_param_handle("RD_ENG_TOGGLE")
local RD_VSI_TOGGLE = get_param_handle("RD_VSI_TOGGLE")



local HUDBrightness = get_param_handle("HUDBrightness")


-- commands =====================================================
-- LEFT DISPLAY ===================
--Keybinds
dev:listen_command(keys.LDSK_1) 
dev:listen_command(keys.LDSK_2) 
dev:listen_command(keys.LDSK_3) 
dev:listen_command(keys.LDSK_4)
dev:listen_command(keys.LDSK_5) 
dev:listen_command(keys.LDSK_6) 
dev:listen_command(keys.LDSK_7) 
dev:listen_command(keys.LDSK_8) 
dev:listen_command(keys.LDSK_9) 
dev:listen_command(keys.LDSK_10)
dev:listen_command(keys.LDSK_11) 
dev:listen_command(keys.LDSK_12) 
dev:listen_command(keys.LDSK_13)
dev:listen_command(keys.LDSK_14) 
dev:listen_command(keys.LDSK_15)
dev:listen_command(keys.LDSK_16)
dev:listen_command(keys.LDSK_17) 
dev:listen_command(keys.LDSK_18) 
dev:listen_command(keys.LDSK_19)
dev:listen_command(keys.LDSK_20) 

dev:listen_command(keys.LD_Brightness_Up)
dev:listen_command(keys.LD_Brightness_Down)


--Clickable
dev:listen_command(deviceCommands.LDSK_1)
dev:listen_command(deviceCommands.LDSK_2)
dev:listen_command(deviceCommands.LDSK_3)
dev:listen_command(deviceCommands.LDSK_4)
dev:listen_command(deviceCommands.LDSK_5)
dev:listen_command(deviceCommands.LDSK_6)
dev:listen_command(deviceCommands.LDSK_7)
dev:listen_command(deviceCommands.LDSK_8)
dev:listen_command(deviceCommands.LDSK_9)
dev:listen_command(deviceCommands.LDSK_10)
dev:listen_command(deviceCommands.LDSK_11)
dev:listen_command(deviceCommands.LDSK_12)
dev:listen_command(deviceCommands.LDSK_13)
dev:listen_command(deviceCommands.LDSK_14)				
dev:listen_command(deviceCommands.LDSK_15)     	
dev:listen_command(deviceCommands.LDSK_16)
dev:listen_command(deviceCommands.LDSK_17)
dev:listen_command(deviceCommands.LDSK_18)
dev:listen_command(deviceCommands.LDSK_19)
dev:listen_command(deviceCommands.LDSK_20)

dev:listen_command(deviceCommands.LD_Brightness_Up)
dev:listen_command(deviceCommands.LD_Brightness_Down)

-- CENTER DISPLAY ===================
dev:listen_command(keys.CDSK_1) 
dev:listen_command(keys.CDSK_2) 
dev:listen_command(keys.CDSK_3) 
dev:listen_command(keys.CDSK_4)
dev:listen_command(keys.CDSK_5) 
dev:listen_command(keys.CDSK_6) 
dev:listen_command(keys.CDSK_7) 
dev:listen_command(keys.CDSK_8) 
dev:listen_command(keys.CDSK_9) 
dev:listen_command(keys.CDSK_10)
dev:listen_command(keys.CDSK_11) 
dev:listen_command(keys.CDSK_12) 
dev:listen_command(keys.CDSK_13)
dev:listen_command(keys.CDSK_14) 
dev:listen_command(keys.CDSK_15)
dev:listen_command(keys.CDSK_16)
dev:listen_command(keys.CDSK_17) 
dev:listen_command(keys.CDSK_18) 
dev:listen_command(keys.CDSK_19)
dev:listen_command(keys.CDSK_20) 

dev:listen_command(keys.CD_Brightness_Up)
dev:listen_command(keys.CD_Brightness_Down)

dev:listen_command(keys.RD_Brightness_Up)
dev:listen_command(keys.RD_Brightness_Down)

--Clickable
dev:listen_command(deviceCommands.CDSK_1)
dev:listen_command(deviceCommands.CDSK_2)
dev:listen_command(deviceCommands.CDSK_3)
dev:listen_command(deviceCommands.CDSK_4)
dev:listen_command(deviceCommands.CDSK_5)
dev:listen_command(deviceCommands.CDSK_6)
dev:listen_command(deviceCommands.CDSK_7)
dev:listen_command(deviceCommands.CDSK_8)
dev:listen_command(deviceCommands.CDSK_9)
dev:listen_command(deviceCommands.CDSK_10)
dev:listen_command(deviceCommands.CDSK_11)
dev:listen_command(deviceCommands.CDSK_12)
dev:listen_command(deviceCommands.CDSK_13)
dev:listen_command(deviceCommands.CDSK_14)				
dev:listen_command(deviceCommands.CDSK_15)     	
dev:listen_command(deviceCommands.CDSK_16)
dev:listen_command(deviceCommands.CDSK_17)
dev:listen_command(deviceCommands.CDSK_18)
dev:listen_command(deviceCommands.CDSK_19)
dev:listen_command(deviceCommands.CDSK_20)

dev:listen_command(deviceCommands.CD_Brightness_Up)
dev:listen_command(deviceCommands.CD_Brightness_Down)

dev:listen_command(deviceCommands.RDSK_1)
dev:listen_command(keys.RDSK_1)
dev:listen_command(deviceCommands.RD_Brightness_Up)
dev:listen_command(deviceCommands.RD_Brightness_Down)

dev:listen_command(deviceCommands.HIDE_HUD)


-- UCP ===================
dev:listen_command(deviceCommands.LANDING_MODE)

-- HUD ===================

dev:listen_command(deviceCommands.HUD_Brightness)


dev:listen_command(136) 	-- active jamming
--dev:listen_command(10060) 	-- landing mode
--[[
	PlaneModeNAV							= 105,
	PlaneModeBVR							= 106,
	PlaneModeVS								= 107,
	PlaneModeBore							= 108,
	PlaneModeHelmet							= 109,	-- Night vision, not HMD
	PlaneModeFI0							= 110,
	PlaneModeGround							= 111,
--]]
dev:listen_command(105)
dev:listen_command(106)
dev:listen_command(107)
dev:listen_command(108)
dev:listen_command(109)
dev:listen_command(110)
dev:listen_command(111)

dev:listen_command(keys.CannonMode) -- Cannon

local masterMode = get_param_handle("masterMode")
masterMode:set(1)
local HMDMode = get_param_handle("HMDMode")
HMDMode:set(1)
local RedHUD = 0

dev:listen_command(87)	-- TGP on


function post_initialize()	-- modes / toggle default settings
-- LEFT DISPLAY ===================	

	LD_UPPER:set(1)		-- 1 = GEN, 2 = def, 3 = AAR, 4 = LDP
	LD_LOWER:set(3)		-- 1 = General, 3 = Engine, 2 = Monitor
	LD_EMGY_MODE:set(0)	-- 1 = on , 0 = off
	STORES_TOGGLE:set(1)	-- 1 = on , 0 = off
	altMode:set(1)		-- 1 = barometric, 2 = Radar 
	CURSOR_TOGGLE:set(0)		-- 1 = on , 0 = off
	HUD_ON_MFD_TOGGLE:set(0)	-- 1 = on , 0 = off
	CABIN_TOGGLE:set(0)			-- 1 = on , 0 = off
	EPERROR_TOGGLE:set(0)		-- 1 = on , 0 = off
	ECON_TOGGLE:set(0)			-- 1 = on , 0 = off
	HCAM_TOGGLE:set(0)			-- 1 = on , 0 = off
	headingMode:set(1)			-- 1 = True, 2 = Magnetic 
	EWS_MODE:set(0)				-- 0 = manual, 1 = semi automatic, 2 = automatic

	SCAL_MODE:set(1)			-- 4 modes. TODO: determain ranges. 800 is one of them
	NORM_MODE:set(1)			-- 1 = Normal flight, 2 = refueling
	UNIT_MODE:set(1)			-- 1 = % , 2 = Litres, 3 = Lbs, 4 = Kg
	MLAS_TOGGLE:set(0) 			-- 1 = on , 0 = off
	SYMB_TOGGLE:set(0) 			-- 1 = on , 0 = off
	SRCH_TRCK_MODE:set(1) 			-- 1 = SEARCH , 2 = TRACK
	BOST_TOGGLE:set(0) 			-- 1 = on , 0 = off
	WHOT_TOGGLE:set(0)			-- 1 = on , 0 = off
	IFB_TOGGLE:set(0) 			-- 1 = on , 0 = off
-- EMGY specific
	LD_TEMP_TOGGLE:set(0)			-- 1 = on , 0 = off
	LD_ENG_TOGGLE:set(0)			-- 1 = on , 0 = off
	LD_VSI_TOGGLE:set(0)			-- 1 = on , 0 = off
	
	PLAYER_SELECTED_STATION:set(0) -- First pylon: selected by default
	
-- CENTER DISPLAY ===================

	CD_EMGY_MODE:set(0)
	CD_LDG_TOGGLE:set(0)
	CD_EWS_TOGGLE:set(0)

	RWR_BACKGROUND:set(1)
-- EMGY specific
	CD_TEMP_TOGGLE:set(0)			-- 1 = on , 0 = off
	CD_ENG_TOGGLE:set(0)			-- 1 = on , 0 = off
	CD_VSI_TOGGLE:set(0)			-- 1 = on , 0 = off	
	CD_FIX_TOGGLE:set(0)

-- RIGHT DISPLAY ===================	
	RD_EMGY_MODE:set(0)
-- EMGY specific
	RD_TEMP_TOGGLE:set(1)			-- 1 = on , 0 = off
	RD_ENG_TOGGLE:set(1)			-- 1 = on , 0 = off
	RD_VSI_TOGGLE:set(1)			-- 1 = on , 0 = off	

	BrightnessAtSpawn()
	HideFc3Hud()
	ChangeHudColor()
	
	local birth = LockOn_Options.init_conditions.birth_place
    if birth=="GROUND_HOT" then
		FLAR_TOGGLE:set(1) 			-- 1 = on , 0 = off
		CHAF_TOGGLE:set(1) 			-- 1 = on , 0 = off	
    elseif birth=="AIR_HOT" then
		FLAR_TOGGLE:set(1) 			-- 1 = on , 0 = off
		CHAF_TOGGLE:set(1) 			-- 1 = on , 0 = off	
		LD_UPPER:set(2)
		LD_LOWER:set(1)
    elseif birth=="GROUND_COLD" then
		FLAR_TOGGLE:set(0) 			-- 1 = on , 0 = off
		CHAF_TOGGLE:set(0) 			-- 1 = on , 0 = off
    end
end

function SetCommand(command,value) 

if get_param_handle("mainpower"):get() == 1 then

	if command == keys.RDSK_1 or command == deviceCommands.RDSK_1 then
		if RD_EMGY_MODE:get() == 0 then
			RD_EMGY_MODE:set(1)
			RDR_BACKGROUND:set(1)
		else
			RD_EMGY_MODE:set(0)
			RDR_BACKGROUND:set(0)
		end
	end


-- CENTER DISPLAY ===================
	if (command == keys.CDSK_1) or (command == deviceCommands.CDSK_1) then			-- Emergency page toggle. EMGY, always visible and functional
		if CD_EMGY_MODE:get() == 0 then
			CD_EMGY_MODE:set(1)
			RWR_BACKGROUND:set(-1)
		else
			CD_EMGY_MODE:set(0)

			if CD_FIX_TOGGLE:get() == 1 then
				RWR_BACKGROUND:set(0)
			end
		end
	end	


	if CD_EMGY_MODE:get() == 0 then
	
-- left row	
	--[[
		if (command == keys.CDSK_2) or (command == deviceCommands.CDSK_2) then	

		end	
		--]]
		if (command == keys.CDSK_3) or (command == deviceCommands.CDSK_3) then	
				dispatch_action(nil, 136)
		end		
		--[[
		if (command == keys.CDSK_4) or (command == deviceCommands.CDSK_4) then	

		end			
		
		if (command == keys.CDSK_5) or (command == deviceCommands.CDSK_5) then	

		end		
		--]]
		if (command == keys.CDSK_6) or (command == deviceCommands.CDSK_6) then	
			if CD_FIX_TOGGLE:get() == 0 then
				CD_FIX_TOGGLE:set(1)
				RWR_BACKGROUND:set(1)
			else
				CD_FIX_TOGGLE:set(0)
				RWR_BACKGROUND:set(-1)
			end
		end			
		--[[
		if (command == keys.CDSK_7) or (command == deviceCommands.CDSK_7) then	

		end			
-- Bottom row

		if (command == keys.CDSK_8) or (command == deviceCommands.CDSK_8) then	

		end			
		
		if (command == keys.CDSK_9) or (command == deviceCommands.CDSK_9) then	

		end			
		
		if (command == keys.CDSK_10) or (command == deviceCommands.CDSK_10) then	

		end			
		
		if (command == keys.CDSK_11) or (command == deviceCommands.CDSK_11) then	

		end			
		
		if (command == keys.CDSK_12) or (command == deviceCommands.CDSK_12) then	

		end	

		if (command == keys.CDSK_13) or (command == deviceCommands.CDSK_13) then	

		end	
		
-- Right row

		if (command == keys.CDSK_14) or (command == deviceCommands.CDSK_14) then	

		end	

		if (command == keys.CDSK_15) or (command == deviceCommands.CDSK_15) then	

		end	

		if (command == keys.CDSK_16) or (command == deviceCommands.CDSK_16) then	

		end	

		if (command == keys.CDSK_17) or (command == deviceCommands.CDSK_17) then	

		end	

		if (command == keys.CDSK_18) or (command == deviceCommands.CDSK_18) then	

		end		
	
		
			
		if (command == keys.CDSK_19) or (command == deviceCommands.CDSK_19) then	
			

			
		end	
		
		if (command == keys.CDSK_20) or (command == deviceCommands.CDSK_20) then	

		end			
		--]]
	
			-- END OF NON-EMGY 
	
	else				-- IF EMGY PAGE IS ENABLED
	
		if (command == keys.CDSK_6) or (command == deviceCommands.CDSK_6) then	
			if CD_TEMP_TOGGLE:get() == 1 then											-- toggle temperature indication
				CD_TEMP_TOGGLE:set(0)
			else
				CD_TEMP_TOGGLE:set(1)
			end
		
		elseif (command == keys.CDSK_7) or (command == deviceCommands.CDSK_7) then	
			if CD_ENG_TOGGLE:get() == 1 then											-- toggle Engine performance indication
				CD_ENG_TOGGLE:set(0)
			else
				CD_ENG_TOGGLE:set(1)
			end 
		
		elseif (command == keys.CDSK_14) or (command == deviceCommands.CDSK_14) then	
			if CD_VSI_TOGGLE:get() == 1 then											-- toggle vertical speed indicationend
				CD_VSI_TOGGLE:set(0)
			else
				CD_VSI_TOGGLE:set(1)
			end
		end
	-- END OF EMGY 
	end

-- LEFT DISPLAY ===================
	if (command == keys.LDSK_1) or (command == deviceCommands.LDSK_1) then			-- Emergency page toggle. EMGY, always visible and functional
		if LD_EMGY_MODE:get() == 0 then
			LD_EMGY_MODE:set(1)
			LD_last_page_was = LD_UPPER:get()
			LD_UPPER:set(0)
		else
			LD_EMGY_MODE:set(0)
			LD_UPPER:set(LD_last_page_was)
		end
	end	
--visible and functional on all pages except EMGY page	
	if LD_EMGY_MODE:get() == 0 then
		if (command == keys.LDSK_7) or (command == deviceCommands.LDSK_7) then				-- Upper area cycle. MENU 
			if LD_UPPER:get() == LD_UPPER_INDX then
				LD_UPPER:set(1)
				--MLAS_TOGGLE:set(0) 			-- 1 = on , 0 = off
				SYMB_TOGGLE:set(0) 			-- 1 = on , 0 = off
				SRCH_TRCK_MODE:set(1) 		-- 1 = SEARCH , 2 = TRACK
				BOST_TOGGLE:set(0) 			-- 1 = on , 0 = off
				WHOT_TOGGLE:set(0)			-- 1 = on , 0 = off
				IFB_TOGGLE:set(0) 			-- 1 = on , 0 = off
			else
				LD_UPPER:set(LD_UPPER:get() + 1)

			end
			
		elseif (command == keys.LDSK_6) or (command == deviceCommands.LDSK_6) then		-- CURS toggle
			if CURSOR_TOGGLE:get() == 0 then
				CURSOR_TOGGLE:set(1)
			else 
				CURSOR_TOGGLE:set(0)
			end	
		
		elseif (command == keys.LDSK_15) or (command == deviceCommands.LDSK_15) then			-- Cycle presentation on lower area of left mfd
			if LD_LOWER:get() == LD_LOWER_INDX then
				LD_LOWER:set(1)
			else 
				LD_LOWER:set(LD_LOWER:get() + 1)
			end		
			
		elseif (command == keys.LDSK_16) or (command == deviceCommands.LDSK_16) then		--Toggle stores
			if STORES_TOGGLE:get() == 1 then
				STORES_TOGGLE:set(0)
			else
				STORES_TOGGLE:set(1)
			end	
			
		elseif (command == keys.LDSK_14) or (command == deviceCommands.LDSK_14) then			-- Cycle altitude
			if altMode:get() == 1 then
				altMode:set(2)
			else
				altMode:set(1)
			end	
			
		end	

--visible and functional on exlusively General page (upper area)
		if LD_UPPER:get() == 1 then
			if (command == keys.LDSK_2) or (command == deviceCommands.LDSK_2) then				-- Toggle hud presentaion on left display
				if HUD_ON_MFD_TOGGLE:get() == 1 then
					HUD_ON_MFD_TOGGLE:set(0)
				else
					HUD_ON_MFD_TOGGLE:set(1)
				end
			
			elseif (command == keys.LDSK_3) or (command == deviceCommands.LDSK_3) then		-- Toggle cabin presentation 
				if CABIN_TOGGLE:get() == 1 then
					CABIN_TOGGLE:set(0)
				else
					CABIN_TOGGLE:set(1)			
															-- when CAB is toggled on, de-toggle EPE
					if EPERROR_TOGGLE:get() == 1 then
						EPERROR_TOGGLE:set(0)
					end
				end
			
			elseif (command == keys.LDSK_4) or (command == deviceCommands.LDSK_4) then		-- Toggle Estimated position error presentation
				if EPERROR_TOGGLE:get() == 1 then
					EPERROR_TOGGLE:set(0)
				
				else
					EPERROR_TOGGLE:set(1)		
														-- when EPE is toggled on, de-toggle CAB
					if CABIN_TOGGLE:get() == 1 then
						CABIN_TOGGLE:set(0)
					end					
					
					
				end
				
			elseif (command == keys.LDSK_5) or (command == deviceCommands.LDSK_5) then		-- Toggle economy mode
				if ECON_TOGGLE:get() == 1 then
					ECON_TOGGLE:set(0)
				else
					ECON_TOGGLE:set(1)
				end
			
			elseif (command == keys.LDSK_19) or (command == deviceCommands.LDSK_19) then			-- Toggle HUD Camera
				if HCAM_TOGGLE:get() == 1 then
					HCAM_TOGGLE:set(0)
				else
					HCAM_TOGGLE:set(1)
				end
				
			elseif (command == keys.LDSK_20) or (command == deviceCommands.LDSK_20) then		-- Cycle true/ mag heading
				if headingMode:get() == 1 then
					headingMode:set(2)
				else
					headingMode:set(1)
				end
			end
-- Defensive page
		elseif LD_UPPER:get() == 2 then			
			if (command == keys.LDSK_2) or (command == deviceCommands.LDSK_2) then	-- Cycle EW modes
				if EWS_MODE:get() == 2 then
					EWS_MODE:set(0)
				else
					EWS_MODE:set(EWS_MODE:get() + 1)
				end
			
			elseif (command == keys.LDSK_3) or (command == deviceCommands.LDSK_3) then	-- Flares soft-saftey and presentation, toggle
				if FLAR_TOGGLE:get() == 1 then
					FLAR_TOGGLE:set(0)
				else
					FLAR_TOGGLE:set(1)
				end
				
			elseif (command == keys.LDSK_4) or (command == deviceCommands.LDSK_4) then		-- Chaff soft-saftey and presentation, toggle
				if CHAF_TOGGLE:get() == 1 then
					CHAF_TOGGLE:set(0)
				else
					CHAF_TOGGLE:set(1)
				end

			elseif (command == keys.LDSK_5) or (command == deviceCommands.LDSK_5) then		-- Cycle HSI scale
				if SCAL_MODE:get() == 4 then	-- I made up 4 modes, no idea of the actual amount
					SCAL_MODE:set(1)
				else
					SCAL_MODE:set(SCAL_MODE:get() + 1)
				end
			end
-- Air to air refueling page		
		elseif LD_UPPER:get() == 3 then
			if (command == keys.LDSK_4) or (command == deviceCommands.LDSK_4) then		-- Toggle depressurization of fuel tanks, allowing AAR
				if NORM_MODE:get() == 2 then
					NORM_MODE:set(1)
				else
					NORM_MODE:set(2)
				end
		
			elseif (command == keys.LDSK_17) or (command == deviceCommands.LDSK_17) then
				if UNIT_MODE:get() == 4 then		-- cycle fuel measurement units
					UNIT_MODE:set(1)
				else 
					UNIT_MODE:set(UNIT_MODE:get() + 1)
				end
			end
-- Laser Designator Pod Page
		elseif LD_UPPER:get() == 4 then
			if (command == keys.LDSK_2) or (command == deviceCommands.LDSK_2) then			-- toggle laser
				if MLAS_TOGGLE:get() == 1 then
					MLAS_TOGGLE:set(0) 
					dispatch_action(nil,392)	-- toggle su25 laser ranger
				else
					MLAS_TOGGLE:set(1) 			-- toggle mfd indication
					dispatch_action(nil,392)
				end
			
			elseif (command == keys.LDSK_3) or (command == deviceCommands.LDSK_3) then		-- toggle crosshair (?)
				if SYMB_TOGGLE:get() == 1 then
					SYMB_TOGGLE:set(0) 
				else
					SYMB_TOGGLE:set(1) 
				end
			
			elseif (command == keys.LDSK_4) or (command == deviceCommands.LDSK_4) then	-- toggle Search
				if SRCH_TRCK_MODE:get() == 2 then
					SRCH_TRCK_MODE:set(1)  
					dispatch_action(nil,104) -- zoom out ldp
				end
				
			elseif (command == keys.LDSK_5) or (command == deviceCommands.LDSK_5) then	-- toggle TRACK
				if SRCH_TRCK_MODE:get() == 1 then
					SRCH_TRCK_MODE:set(2) 
					dispatch_action(nil,103) -- zoom in ldp
				end	
				
			elseif (command == keys.LDSK_18) or (command == deviceCommands.LDSK_18) then	-- toggle boost (brightness)
				if BOST_TOGGLE:get() == 1 then
					BOST_TOGGLE:set(0) 
				else
					BOST_TOGGLE:set(1) 
				end	
			
			elseif (command == keys.LDSK_19) or (command == deviceCommands.LDSK_19) then
				if WHOT_TOGGLE:get() == 1 then										-- toggle IR picute ldp
					WHOT_TOGGLE:set(0) 
					dispatch_action(nil,393)	-- toggle IR imaging ldp
					dispatch_action(nil,87) 	-- LDP on off. Going from ir back to tv turns the pod off, this turns is back on
					SRCH_TRCK_MODE:set(1)

				else
					WHOT_TOGGLE:set(1) 
					dispatch_action(nil,393)	-- toggle IR imaging ldp
					SRCH_TRCK_MODE:set(1)
				end
				
			elseif (command == keys.LDSK_20) or (command == deviceCommands.LDSK_20) then
				if IFB_TOGGLE:get() == 1 then										-- toggle Aiming cross in hud, ldp
					IFB_TOGGLE:set(0) 
				else
					IFB_TOGGLE:set(1) 
				end	
			end	
			
			if (command == 87) then
				
				--SYMB_TOGGLE:set(0) 			-- 1 = on , 0 = off
				SRCH_TRCK_MODE:set(1) 		-- 1 = SEARCH , 2 = TRACK
				--BOST_TOGGLE:set(0) 			-- 1 = on , 0 = off
				WHOT_TOGGLE:set(0)			-- 1 = on , 0 = off
				IFB_TOGGLE:set(0) 			-- 1 = on , 0 = off
				if (WHOT_TOGGLE:get() == 1) then
					MLAS_TOGGLE:set(0) 			-- 1 = on , 0 = off
				end
			end

		end
	
-- EMGY Page
	else
		if (command == keys.LDSK_6) or (command == deviceCommands.LDSK_6) then	
			if LD_TEMP_TOGGLE:get() == 1 then											-- toggle temperature indication
				LD_TEMP_TOGGLE:set(0)
			else
				LD_TEMP_TOGGLE:set(1)
			end
		
		elseif (command == keys.LDSK_7) or (command == deviceCommands.LDSK_7) then	
			if LD_ENG_TOGGLE:get() == 1 then											-- toggle Engine performance indication
				LD_ENG_TOGGLE:set(0)
			else
				LD_ENG_TOGGLE:set(1)
			end 
		
		elseif (command == keys.LDSK_14) or (command == deviceCommands.LDSK_14) then	
			if LD_VSI_TOGGLE:get() == 1 then											-- toggle vertical speed indication
				LD_VSI_TOGGLE:set(0)
			else
				LD_VSI_TOGGLE:set(1)
			end
		end
	end	-- end of LD_EMGY_MODE:get() == 0
	
	
	
		if command == keys.LD_Brightness_Down or command == deviceCommands.LD_Brightness_Down then
			LDBrightness:set(math.min(LDBrightness:get() + (1 - LDBrightness:get()) / 2, .96875)) -- f(x) = x + (1 - x) / 2
		elseif command == keys.LD_Brightness_Up or command == deviceCommands.LD_Brightness_Up then
			LDBrightness:set(math.max(2 * LDBrightness:get() - 1, 0)) -- f(x) = 2x - 1
		end

		if command == keys.CD_Brightness_Down or command == deviceCommands.CD_Brightness_Down then
			CDBrightness:set(math.min(CDBrightness:get() + (1 - CDBrightness:get()) / 2, .96875))
		elseif (command == keys.CD_Brightness_Up) or (command == deviceCommands.CD_Brightness_Up) then
			CDBrightness:set(math.max(2 * CDBrightness:get() - 1, 0))
		end

		if command == keys.RD_Brightness_Down or command == deviceCommands.RD_Brightness_Down then
			RDBrightness:set(math.min(RDBrightness:get() + (1 - RDBrightness:get()) / 2, .96875))
		elseif command == keys.RD_Brightness_Up or command == deviceCommands.RD_Brightness_Up then
			RDBrightness:set(math.max(2 * RDBrightness:get() - 1, 0))
		end

	
	if command == 136 then
		if CD_EWS_TOGGLE:get() == 0 then
			CD_EWS_TOGGLE:set(1)
		else
			CD_EWS_TOGGLE:set(0)
		end
	end

	if command == 105 then
		HMDMode:set(1)
	  elseif command == 106 then
		HMDMode:set(2)
	  elseif command == 107 then
		HMDMode:set(3)
	  elseif command == 108 then
		HMDMode:set(4)
	  elseif command == 109 then
		HMDMode:set(5)
	  elseif command == 110 then
		HMDMode:set(6)
	  elseif command == 111 then
		HMDMode:set(7)
	  end
	
	if (command == 105) or (command == 106) or (command == 107) or (command == 108) or (command == 109) or (command == 110) then
-- if fc3 hud mode is changed from a2g, reset all LDP-related values	
		MLAS_TOGGLE:set(0) 			-- 1 = on , 0 = off
		SYMB_TOGGLE:set(0) 			-- 1 = on , 0 = off
		SRCH_TRCK_MODE:set(1) 		-- 1 = SEARCH , 2 = TRACK
		BOST_TOGGLE:set(0) 			-- 1 = on , 0 = off
		WHOT_TOGGLE:set(0)			-- 1 = on , 0 = off
		IFB_TOGGLE:set(0) 			-- 1 = on , 0 = off
	end                                                


	if command == 105 then
		--print_message_to_user("NAV")
		if masterMode:get() ~= 1 then
			masterMode:set(1)
			HideFc3Hud()
			if RedHUD == 0 then
				ChangeHudColor()
			end
		else 
			masterMode:set(0)
			ShowFc3Hud()
			ChangeHudColor()
		end
		
	elseif command == 106 then
		--print_message_to_user("BVR")
		if masterMode:get() ~= 2 then
			masterMode:set(2)
			HideFc3Hud()
			if RedHUD == 0 then
				ChangeHudColor()
			end
		else 
			masterMode:set(0)
			ShowFc3Hud()
			if RedHUD == 1 then
				ChangeHudColor()
			end
		end
		
	elseif command == 107 then
		--print_message_to_user("VS")
		if masterMode:get() ~= 3 then
			masterMode:set(3)
			HideFc3Hud()
			if RedHUD == 0 then
				ChangeHudColor()
			end
		else 
			masterMode:set(0)
			ShowFc3Hud()
			if RedHUD == 1 then
				ChangeHudColor()
			end
		end
		
	elseif command == 108 then
		--print_message_to_user("BORE")
		if masterMode:get() ~= 4 then
			masterMode:set(4)
			HideFc3Hud()
			if RedHUD == 0 then
				ChangeHudColor()
			end
		else 
			masterMode:set(0)
			ShowFc3Hud()
			if RedHUD == 1 then
				ChangeHudColor()
			end
		end

	elseif command == 109 then
		--print_message_to_user("HMD")
		if masterMode:get() ~= 5 then
			masterMode:set(5)
			HideFc3Hud()
			if RedHUD == 0 then
				ChangeHudColor()
			end
		else 
			masterMode:set(0)
			ShowFc3Hud()
			if RedHUD == 1 then
				ChangeHudColor()
			end
		end
		
	elseif command == 110 then
		--print_message_to_user("LNGT")
		if masterMode:get() ~= 6 then
			masterMode:set(6)
			HideFc3Hud()
			if RedHUD == 0 then
				ChangeHudColor()
			end
		else 
			masterMode:set(0)
			ShowFc3Hud()
			ChangeHudColor()
			
		end

		
	elseif command == 111 then
		--print_message_to_user("AIR TO GROUND")
		
		if masterMode:get() ~= 7 then
			masterMode:set(7)
			ShowFc3Hud()
			if RedHUD == 1 then
				ChangeHudColor()
			end
		else 
			masterMode:set(0)
			HideFc3Hud()
			if RedHUD == 0 then
				ChangeHudColor()
			end
		end
	end

	if command == keys.CannonMode then
		if masterMode:get() == 1 then
			if get_param_handle("GRIPEN_TYPE"):get() == 1 then
			
				
				if RedHUD == 1 then
					ChangeHudColor()
					ShowFc3Hud()
				else 
					ChangeHudColor()
					HideFc3Hud()
				
				end
				
			end
		
		elseif masterMode:get() == 2 then
			
			if RedHUD == 1 then
				ChangeHudColor()
				ShowFc3Hud()
			else 
				ChangeHudColor()
				HideFc3Hud()
			
			end
		
		elseif masterMode:get() == 3 then
			
			if RedHUD == 1 then
				ChangeHudColor()
				ShowFc3Hud()
			else 
				ChangeHudColor()
				HideFc3Hud()
			
			end
		
		elseif masterMode:get() == 4 then
			
			if RedHUD == 1 then
				ChangeHudColor()
				ShowFc3Hud()
			else 
				ChangeHudColor()
				HideFc3Hud()
			
			end
		
		elseif masterMode:get() == 6 then
			
			if RedHUD == 1 then
				ChangeHudColor()
				ShowFc3Hud()
			else 
				ChangeHudColor()
				HideFc3Hud()
			
			end
		end
	end
	
-- HUD ===================	
	if command == deviceCommands.HUD_Brightness then
		if HUDBrightness:get() > 1 then
			HUDBrightness:set(1)
		else
			HUDBrightness:set(value^2)
		end
    end	
	
end	
end -- end of function


function HideFc3Hud()
local i = 100
	for i =  100, 1, -1 do 
		dispatch_action(nil, 747)
	end
	
end

function ShowFc3Hud()
local i = 100
	for i =  100, 1, -1 do 
		dispatch_action(nil, 746)
	end
	

end



function ChangeHudColor()



local i = 5

	for i =  5, 1, -1 do 
		dispatch_action(nil, 156)

	end

	if RedHUD == 0 then
		RedHUD = 1
		
	else
		RedHUD = 0
	end
	
	get_param_handle("RED_HUD"):set(RedHUD)
end

function DigitalClock()
local abstime = get_absolute_model_time() -- gives local time of day in seconds
local hour = abstime/3600.0

local Corrected_Hour = math.floor(hour)


if Corrected_Hour < 24 then
	HOURTIME:set(Corrected_Hour)
elseif Corrected_Hour < 48 then
	HOURTIME:set(Corrected_Hour-24)
elseif Corrected_Hour < 72 then
	HOURTIME:set(Corrected_Hour-48)
end

local int,frac = math.modf(hour)
MINUTESTIME:set(math.floor(frac*60))
local int1,frac1 = math.modf(frac*60)


SECONDSTIME:set(frac1*59.49)


end

function BrightnessAtSpawn()
	DigitalClock()



	if HOURTIME:get() <= 5 then -- Might need tweaking
		LDBrightness:set(.96875)
	elseif HOURTIME:get() < 7 then
		LDBrightness:set(.9375)
	elseif HOURTIME:get() < 8 then
		LDBrightness:set(.875)
	elseif HOURTIME:get() < 9 then
		LDBrightness:set(.75)
	elseif HOURTIME:get() < 10 then
		LDBrightness:set(.75)
	elseif HOURTIME:get() < 11 then
		LDBrightness:set(.75)
	elseif HOURTIME:get() < 12 then
		LDBrightness:set(.5)
	elseif HOURTIME:get() < 14 then
		LDBrightness:set(.5)
	elseif HOURTIME:get() < 17 then
		LDBrightness:set(.75)
	elseif HOURTIME:get() < 18 then
		LDBrightness:set(.875)
	elseif HOURTIME:get() < 19 then
		LDBrightness:set(.9375)
	elseif HOURTIME:get() >= 19 then
		LDBrightness:set(.96875)
	end

	CDBrightness:set(LDBrightness:get())
	RDBrightness:set(LDBrightness:get())

	local birth = LockOn_Options.init_conditions.birth_place
	if birth == "GROUND_HOT" or birth == "AIR_HOT" then
		dev:performClickableAction(deviceCommands.HUD_Brightness, 1, true)
		HUDBrightness:set(1)
	elseif birth == "GROUND_COLD" then
		dev:performClickableAction(deviceCommands.HUD_Brightness, 0, true)
		HUDBrightness:set(0)
	end
end

function update()

	DigitalClock()
	
	if get_param_handle("CURRENT_PHASE_ROT"):get() > 0.0 then
		Page_changed = 0
	elseif (Page_changed == 0) and (get_param_handle("CURRENT_PHASE_LO"):get() > 0.0) and ((LD_UPPER:get() ~= 2) or (LD_LOWER:get() ~= 1)) then	-- at lift off and the correct pages aren't already selected
		LD_UPPER:set(2)-- Defensive mode, HSI
		LD_LOWER:set(1)--General mode, flight data
		Page_changed = 1
	elseif get_param_handle("CURRENT_PHASE_CO"):get() > 0.0 then	
		Page_changed = 0
	elseif (Page_changed == 0) and (get_param_handle("CURRENT_PHASE_TD"):get() > 0.0) and ((LD_UPPER:get() ~= 1) or (LD_LOWER:get() ~= 2)) then	-- at touch down and the correct pages aren't already selected
		LD_UPPER:set(1)	-- General mode, flight data
		LD_LOWER:set(3)	-- Engine mode, engine data
		Page_changed = 1
	end
	
	
	if (LD_UPPER:get() == 4) and (LDP_BACKGROUND:get() == 0)  then	
		LDP_BACKGROUND:set(1)
	elseif (LD_UPPER:get() ~= 4) and (LDP_BACKGROUND:get() == 1) or (LD_EMGY_MODE:get() == 1) then	
		LDP_BACKGROUND:set(0)
	end

end

need_to_be_closed = false