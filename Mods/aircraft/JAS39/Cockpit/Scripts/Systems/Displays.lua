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
local ALTITUDE_MODE = get_param_handle("ALTITUDE_MODE")		
local CURSOR_TOGGLE = get_param_handle("CURSOR_TOGGLE")		
local HUD_ON_MFD_TOGGLE = get_param_handle("HUD_ON_MFD_TOGGLE")		
local CABIN_TOGGLE = get_param_handle("CABIN_TOGGLE")		
local EPERROR_TOGGLE = get_param_handle("EPERROR_TOGGLE")		
local ECON_TOGGLE = get_param_handle("ECON_TOGGLE")		
local HCAM_TOGGLE = get_param_handle("HCAM_TOGGLE")		
local HEADING_MODE = get_param_handle("HEADING_MODE")		
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
local LD_BRIGHTNESS = get_param_handle("LD_BRIGHTNESS")
local CD_BRIGHTNESS = get_param_handle("CD_BRIGHTNESS")
local RD_BRIGHTNESS = get_param_handle("RD_BRIGHTNESS")

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



local HUD_BRIGHTNESS = get_param_handle("HUD_BRIGHTNESS")

-- commands =====================================================
-- LEFT DISPLAY ===================
--Keybinds
dev:listen_command(Keys.LDSK_1) 
dev:listen_command(Keys.LDSK_2) 
dev:listen_command(Keys.LDSK_3) 
dev:listen_command(Keys.LDSK_4)
dev:listen_command(Keys.LDSK_5) 
dev:listen_command(Keys.LDSK_6) 
dev:listen_command(Keys.LDSK_7) 
dev:listen_command(Keys.LDSK_8) 
dev:listen_command(Keys.LDSK_9) 
dev:listen_command(Keys.LDSK_10)
dev:listen_command(Keys.LDSK_11) 
dev:listen_command(Keys.LDSK_12) 
dev:listen_command(Keys.LDSK_13)
dev:listen_command(Keys.LDSK_14) 
dev:listen_command(Keys.LDSK_15)
dev:listen_command(Keys.LDSK_16)
dev:listen_command(Keys.LDSK_17) 
dev:listen_command(Keys.LDSK_18) 
dev:listen_command(Keys.LDSK_19)
dev:listen_command(Keys.LDSK_20) 

dev:listen_command(Keys.LD_Brightness_Up)
dev:listen_command(Keys.LD_Brightness_Down)


--Clickable
dev:listen_command(device_commands.LDSK_1)
dev:listen_command(device_commands.LDSK_2)
dev:listen_command(device_commands.LDSK_3)
dev:listen_command(device_commands.LDSK_4)
dev:listen_command(device_commands.LDSK_5)
dev:listen_command(device_commands.LDSK_6)
dev:listen_command(device_commands.LDSK_7)
dev:listen_command(device_commands.LDSK_8)
dev:listen_command(device_commands.LDSK_9)
dev:listen_command(device_commands.LDSK_10)
dev:listen_command(device_commands.LDSK_11)
dev:listen_command(device_commands.LDSK_12)
dev:listen_command(device_commands.LDSK_13)
dev:listen_command(device_commands.LDSK_14)				
dev:listen_command(device_commands.LDSK_15)     	
dev:listen_command(device_commands.LDSK_16)
dev:listen_command(device_commands.LDSK_17)
dev:listen_command(device_commands.LDSK_18)
dev:listen_command(device_commands.LDSK_19)
dev:listen_command(device_commands.LDSK_20)

dev:listen_command(device_commands.LD_Brightness_Up)
dev:listen_command(device_commands.LD_Brightness_Down)

-- CENTER DISPLAY ===================
dev:listen_command(Keys.CDSK_1) 
dev:listen_command(Keys.CDSK_2) 
dev:listen_command(Keys.CDSK_3) 
dev:listen_command(Keys.CDSK_4)
dev:listen_command(Keys.CDSK_5) 
dev:listen_command(Keys.CDSK_6) 
dev:listen_command(Keys.CDSK_7) 
dev:listen_command(Keys.CDSK_8) 
dev:listen_command(Keys.CDSK_9) 
dev:listen_command(Keys.CDSK_10)
dev:listen_command(Keys.CDSK_11) 
dev:listen_command(Keys.CDSK_12) 
dev:listen_command(Keys.CDSK_13)
dev:listen_command(Keys.CDSK_14) 
dev:listen_command(Keys.CDSK_15)
dev:listen_command(Keys.CDSK_16)
dev:listen_command(Keys.CDSK_17) 
dev:listen_command(Keys.CDSK_18) 
dev:listen_command(Keys.CDSK_19)
dev:listen_command(Keys.CDSK_20) 

dev:listen_command(Keys.CD_Brightness_Up)
dev:listen_command(Keys.CD_Brightness_Down)

dev:listen_command(Keys.RD_Brightness_Up)
dev:listen_command(Keys.RD_Brightness_Down)

--Clickable
dev:listen_command(device_commands.CDSK_1)
dev:listen_command(device_commands.CDSK_2)
dev:listen_command(device_commands.CDSK_3)
dev:listen_command(device_commands.CDSK_4)
dev:listen_command(device_commands.CDSK_5)
dev:listen_command(device_commands.CDSK_6)
dev:listen_command(device_commands.CDSK_7)
dev:listen_command(device_commands.CDSK_8)
dev:listen_command(device_commands.CDSK_9)
dev:listen_command(device_commands.CDSK_10)
dev:listen_command(device_commands.CDSK_11)
dev:listen_command(device_commands.CDSK_12)
dev:listen_command(device_commands.CDSK_13)
dev:listen_command(device_commands.CDSK_14)				
dev:listen_command(device_commands.CDSK_15)     	
dev:listen_command(device_commands.CDSK_16)
dev:listen_command(device_commands.CDSK_17)
dev:listen_command(device_commands.CDSK_18)
dev:listen_command(device_commands.CDSK_19)
dev:listen_command(device_commands.CDSK_20)

dev:listen_command(device_commands.CD_Brightness_Up)
dev:listen_command(device_commands.CD_Brightness_Down)

dev:listen_command(device_commands.RDSK_1)
dev:listen_command(Keys.RDSK_1)
dev:listen_command(device_commands.RD_Brightness_Up)
dev:listen_command(device_commands.RD_Brightness_Down)

dev:listen_command(device_commands.HIDE_HUD)


-- UCP ===================
dev:listen_command(device_commands.LANDING_MODE)

-- HUD ===================

dev:listen_command(device_commands.HUD_Brightness)


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

dev:listen_command(Keys.CannonMode) -- Cannon

local HUD_MODE = get_param_handle("HUD_MODE")
HUD_MODE:set(1)
local RedHUD = 0

dev:listen_command(87)	-- TGP on


function post_initialize()	-- modes / toggle default settings
-- LEFT DISPLAY ===================	

	LD_UPPER:set(1)		-- 1 = GEN, 2 = def, 3 = AAR, 4 = LDP
	LD_LOWER:set(3)		-- 1 = General, 3 = Engine, 2 = Monitor
	LD_EMGY_MODE:set(0)	-- 1 = on , 0 = off
	STORES_TOGGLE:set(1)	-- 1 = on , 0 = off
	ALTITUDE_MODE:set(1)		-- 1 = barometric, 2 = Radar 
	CURSOR_TOGGLE:set(0)		-- 1 = on , 0 = off
	HUD_ON_MFD_TOGGLE:set(0)	-- 1 = on , 0 = off
	CABIN_TOGGLE:set(0)			-- 1 = on , 0 = off
	EPERROR_TOGGLE:set(0)		-- 1 = on , 0 = off
	ECON_TOGGLE:set(0)			-- 1 = on , 0 = off
	HCAM_TOGGLE:set(0)			-- 1 = on , 0 = off
	HEADING_MODE:set(1)			-- 1 = True, 2 = Magnetic 
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

if get_param_handle("MAINPOWER"):get() == 1 then

	if command == Keys.RDSK_1 or command == device_commands.RDSK_1 then
		if RD_EMGY_MODE:get() == 0 then
			RD_EMGY_MODE:set(1)
			RDR_BACKGROUND:set(1)
		else
			RD_EMGY_MODE:set(0)
			RDR_BACKGROUND:set(0)
		end
	end


-- CENTER DISPLAY ===================
	if (command == Keys.CDSK_1) or (command == device_commands.CDSK_1) then			-- Emergency page toggle. EMGY, always visible and functional
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
		if (command == Keys.CDSK_2) or (command == device_commands.CDSK_2) then	

		end	
		--]]
		if (command == Keys.CDSK_3) or (command == device_commands.CDSK_3) then	
				dispatch_action(nil, 136)
		end		
		--[[
		if (command == Keys.CDSK_4) or (command == device_commands.CDSK_4) then	

		end			
		
		if (command == Keys.CDSK_5) or (command == device_commands.CDSK_5) then	

		end		
		--]]
		if (command == Keys.CDSK_6) or (command == device_commands.CDSK_6) then	
			if CD_FIX_TOGGLE:get() == 0 then
				CD_FIX_TOGGLE:set(1)
				RWR_BACKGROUND:set(1)
			else
				CD_FIX_TOGGLE:set(0)
				RWR_BACKGROUND:set(-1)
			end
		end			
		--[[
		if (command == Keys.CDSK_7) or (command == device_commands.CDSK_7) then	

		end			
-- Bottom row

		if (command == Keys.CDSK_8) or (command == device_commands.CDSK_8) then	

		end			
		
		if (command == Keys.CDSK_9) or (command == device_commands.CDSK_9) then	

		end			
		
		if (command == Keys.CDSK_10) or (command == device_commands.CDSK_10) then	

		end			
		
		if (command == Keys.CDSK_11) or (command == device_commands.CDSK_11) then	

		end			
		
		if (command == Keys.CDSK_12) or (command == device_commands.CDSK_12) then	

		end	

		if (command == Keys.CDSK_13) or (command == device_commands.CDSK_13) then	

		end	
		
-- Right row

		if (command == Keys.CDSK_14) or (command == device_commands.CDSK_14) then	

		end	

		if (command == Keys.CDSK_15) or (command == device_commands.CDSK_15) then	

		end	

		if (command == Keys.CDSK_16) or (command == device_commands.CDSK_16) then	

		end	

		if (command == Keys.CDSK_17) or (command == device_commands.CDSK_17) then	

		end	

		if (command == Keys.CDSK_18) or (command == device_commands.CDSK_18) then	

		end		
	
		
			
		if (command == Keys.CDSK_19) or (command == device_commands.CDSK_19) then	
			

			
		end	
		
		if (command == Keys.CDSK_20) or (command == device_commands.CDSK_20) then	

		end			
		--]]
	
			-- END OF NON-EMGY 
	
	else				-- IF EMGY PAGE IS ENABLED
	
		if (command == Keys.CDSK_6) or (command == device_commands.CDSK_6) then	
			if CD_TEMP_TOGGLE:get() == 1 then											-- toggle temperature indication
				CD_TEMP_TOGGLE:set(0)
			else
				CD_TEMP_TOGGLE:set(1)
			end
		
		elseif (command == Keys.CDSK_7) or (command == device_commands.CDSK_7) then	
			if CD_ENG_TOGGLE:get() == 1 then											-- toggle Engine performance indication
				CD_ENG_TOGGLE:set(0)
			else
				CD_ENG_TOGGLE:set(1)
			end 
		
		elseif (command == Keys.CDSK_14) or (command == device_commands.CDSK_14) then	
			if CD_VSI_TOGGLE:get() == 1 then											-- toggle vertical speed indicationend
				CD_VSI_TOGGLE:set(0)
			else
				CD_VSI_TOGGLE:set(1)
			end
		end
	-- END OF EMGY 
	end

-- LEFT DISPLAY ===================
	if (command == Keys.LDSK_1) or (command == device_commands.LDSK_1) then			-- Emergency page toggle. EMGY, always visible and functional
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
		if (command == Keys.LDSK_7) or (command == device_commands.LDSK_7) then				-- Upper area cycle. MENU 
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
			
		elseif (command == Keys.LDSK_6) or (command == device_commands.LDSK_6) then		-- CURS toggle
			if CURSOR_TOGGLE:get() == 0 then
				CURSOR_TOGGLE:set(1)
			else 
				CURSOR_TOGGLE:set(0)
			end	
		
		elseif (command == Keys.LDSK_15) or (command == device_commands.LDSK_15) then			-- Cycle presentation on lower area of left mfd
			if LD_LOWER:get() == LD_LOWER_INDX then
				LD_LOWER:set(1)
			else 
				LD_LOWER:set(LD_LOWER:get() + 1)
			end		
			
		elseif (command == Keys.LDSK_16) or (command == device_commands.LDSK_16) then		--Toggle stores
			if STORES_TOGGLE:get() == 1 then
				STORES_TOGGLE:set(0)
			else
				STORES_TOGGLE:set(1)
			end	
			
		elseif (command == Keys.LDSK_14) or (command == device_commands.LDSK_14) then			-- Cycle altitude
			if ALTITUDE_MODE:get() == 1 then
				ALTITUDE_MODE:set(2)
			else
				ALTITUDE_MODE:set(1)
			end	
			
		end	

--visible and functional on exlusively General page (upper area)
		if LD_UPPER:get() == 1 then
			if (command == Keys.LDSK_2) or (command == device_commands.LDSK_2) then				-- Toggle hud presentaion on left display
				if HUD_ON_MFD_TOGGLE:get() == 1 then
					HUD_ON_MFD_TOGGLE:set(0)
				else
					HUD_ON_MFD_TOGGLE:set(1)
				end
			
			elseif (command == Keys.LDSK_3) or (command == device_commands.LDSK_3) then		-- Toggle cabin presentation 
				if CABIN_TOGGLE:get() == 1 then
					CABIN_TOGGLE:set(0)
				else
					CABIN_TOGGLE:set(1)			
															-- when CAB is toggled on, de-toggle EPE
					if EPERROR_TOGGLE:get() == 1 then
						EPERROR_TOGGLE:set(0)
					end
				end
			
			elseif (command == Keys.LDSK_4) or (command == device_commands.LDSK_4) then		-- Toggle Estimated position error presentation
				if EPERROR_TOGGLE:get() == 1 then
					EPERROR_TOGGLE:set(0)
				
				else
					EPERROR_TOGGLE:set(1)		
														-- when EPE is toggled on, de-toggle CAB
					if CABIN_TOGGLE:get() == 1 then
						CABIN_TOGGLE:set(0)
					end					
					
					
				end
				
			elseif (command == Keys.LDSK_5) or (command == device_commands.LDSK_5) then		-- Toggle economy mode
				if ECON_TOGGLE:get() == 1 then
					ECON_TOGGLE:set(0)
				else
					ECON_TOGGLE:set(1)
				end
			
			elseif (command == Keys.LDSK_19) or (command == device_commands.LDSK_19) then			-- Toggle HUD Camera
				if HCAM_TOGGLE:get() == 1 then
					HCAM_TOGGLE:set(0)
				else
					HCAM_TOGGLE:set(1)
				end
				
			elseif (command == Keys.LDSK_20) or (command == device_commands.LDSK_20) then		-- Cycle true/ mag heading
				if HEADING_MODE:get() == 1 then
					HEADING_MODE:set(2)
				else
					HEADING_MODE:set(1)
				end
			end
-- Defensive page
		elseif LD_UPPER:get() == 2 then			
			if (command == Keys.LDSK_2) or (command == device_commands.LDSK_2) then	-- Cycle EW modes
				if EWS_MODE:get() == 2 then
					EWS_MODE:set(0)
				else
					EWS_MODE:set(EWS_MODE:get() + 1)
				end
			
			elseif (command == Keys.LDSK_3) or (command == device_commands.LDSK_3) then	-- Flares soft-saftey and presentation, toggle
				if FLAR_TOGGLE:get() == 1 then
					FLAR_TOGGLE:set(0)
				else
					FLAR_TOGGLE:set(1)
				end
				
			elseif (command == Keys.LDSK_4) or (command == device_commands.LDSK_4) then		-- Chaff soft-saftey and presentation, toggle
				if CHAF_TOGGLE:get() == 1 then
					CHAF_TOGGLE:set(0)
				else
					CHAF_TOGGLE:set(1)
				end

			elseif (command == Keys.LDSK_5) or (command == device_commands.LDSK_5) then		-- Cycle HSI scale
				if SCAL_MODE:get() == 4 then	-- I made up 4 modes, no idea of the actual amount
					SCAL_MODE:set(1)
				else
					SCAL_MODE:set(SCAL_MODE:get() + 1)
				end
			end
-- Air to air refueling page		
		elseif LD_UPPER:get() == 3 then
			if (command == Keys.LDSK_4) or (command == device_commands.LDSK_4) then		-- Toggle depressurization of fuel tanks, allowing AAR
				if NORM_MODE:get() == 2 then
					NORM_MODE:set(1)
				else
					NORM_MODE:set(2)
				end
		
			elseif (command == Keys.LDSK_17) or (command == device_commands.LDSK_17) then
				if UNIT_MODE:get() == 4 then		-- cycle fuel measurement units
					UNIT_MODE:set(1)
				else 
					UNIT_MODE:set(UNIT_MODE:get() + 1)
				end
			end
-- Laser Designator Pod Page
		elseif LD_UPPER:get() == 4 then
			if (command == Keys.LDSK_2) or (command == device_commands.LDSK_2) then			-- toggle laser
				if MLAS_TOGGLE:get() == 1 then
					MLAS_TOGGLE:set(0) 
					dispatch_action(nil,392)	-- toggle su25 laser ranger
				else
					MLAS_TOGGLE:set(1) 			-- toggle mfd indication
					dispatch_action(nil,392)
				end
			
			elseif (command == Keys.LDSK_3) or (command == device_commands.LDSK_3) then		-- toggle crosshair (?)
				if SYMB_TOGGLE:get() == 1 then
					SYMB_TOGGLE:set(0) 
				else
					SYMB_TOGGLE:set(1) 
				end
			
			elseif (command == Keys.LDSK_4) or (command == device_commands.LDSK_4) then	-- toggle Search
				if SRCH_TRCK_MODE:get() == 2 then
					SRCH_TRCK_MODE:set(1)  
					dispatch_action(nil,104) -- zoom out ldp
				end
				
			elseif (command == Keys.LDSK_5) or (command == device_commands.LDSK_5) then	-- toggle TRACK
				if SRCH_TRCK_MODE:get() == 1 then
					SRCH_TRCK_MODE:set(2) 
					dispatch_action(nil,103) -- zoom in ldp
				end	
				
			elseif (command == Keys.LDSK_18) or (command == device_commands.LDSK_18) then	-- toggle boost (brightness)
				if BOST_TOGGLE:get() == 1 then
					BOST_TOGGLE:set(0) 
				else
					BOST_TOGGLE:set(1) 
				end	
			
			elseif (command == Keys.LDSK_19) or (command == device_commands.LDSK_19) then
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
				
			elseif (command == Keys.LDSK_20) or (command == device_commands.LDSK_20) then
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
		if (command == Keys.LDSK_6) or (command == device_commands.LDSK_6) then	
			if LD_TEMP_TOGGLE:get() == 1 then											-- toggle temperature indication
				LD_TEMP_TOGGLE:set(0)
			else
				LD_TEMP_TOGGLE:set(1)
			end
		
		elseif (command == Keys.LDSK_7) or (command == device_commands.LDSK_7) then	
			if LD_ENG_TOGGLE:get() == 1 then											-- toggle Engine performance indication
				LD_ENG_TOGGLE:set(0)
			else
				LD_ENG_TOGGLE:set(1)
			end 
		
		elseif (command == Keys.LDSK_14) or (command == device_commands.LDSK_14) then	
			if LD_VSI_TOGGLE:get() == 1 then											-- toggle vertical speed indication
				LD_VSI_TOGGLE:set(0)
			else
				LD_VSI_TOGGLE:set(1)
			end
		end
	end	-- end of LD_EMGY_MODE:get() == 0
	
	
	
	if (command == Keys.LD_Brightness_Down) or (command == device_commands.LD_Brightness_Down) then
		if LD_BRIGHTNESS:get() > 0.051 then
			LD_BRIGHTNESS:set(LD_BRIGHTNESS:get() -0.05)
			--print_message_to_user(LD_BRIGHTNESS:get())
		end
	
	elseif (command == Keys.LD_Brightness_Up) or (command == device_commands.LD_Brightness_Up) then
		if LD_BRIGHTNESS:get() < 1 then
			LD_BRIGHTNESS:set(LD_BRIGHTNESS:get() +0.05)
			--print_message_to_user(LD_BRIGHTNESS:get())
		end
	end

	if (command == Keys.CD_Brightness_Down) or (command == device_commands.CD_Brightness_Down) then
		if CD_BRIGHTNESS:get() > 0.051 then
			CD_BRIGHTNESS:set(CD_BRIGHTNESS:get() -0.05)
			--print_message_to_user(LD_BRIGHTNESS:get())
		end
	
	elseif (command == Keys.CD_Brightness_Up) or (command == device_commands.CD_Brightness_Up) then
		if CD_BRIGHTNESS:get() < 1 then
			CD_BRIGHTNESS:set(CD_BRIGHTNESS:get() +0.05)
			--print_message_to_user(LD_BRIGHTNESS:get())
		end
	end

	if (command == Keys.RD_Brightness_Down) or (command == device_commands.RD_Brightness_Down) then
		if RD_BRIGHTNESS:get() > 0.051 then
			RD_BRIGHTNESS:set(RD_BRIGHTNESS:get() -0.05)
			--print_message_to_user(RD_BRIGHTNESS:get())
		end
	
	elseif (command == Keys.RD_Brightness_Up) or (command == device_commands.RD_Brightness_Up) then
		if RD_BRIGHTNESS:get() < 1 then
			RD_BRIGHTNESS:set(RD_BRIGHTNESS:get() +0.05)
			--print_message_to_user(RD_BRIGHTNESS:get())
		end
	end

	
	if command == 136 then
		if CD_EWS_TOGGLE:get() == 0 then
			CD_EWS_TOGGLE:set(1)
		else
			CD_EWS_TOGGLE:set(0)
		end
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
		if HUD_MODE:get() ~= 1 then
			HUD_MODE:set(1)
			HideFc3Hud()
			if RedHUD == 0 then
				ChangeHudColor()
			end
		else 
			HUD_MODE:set(0)
			ShowFc3Hud()
			ChangeHudColor()
		end
		
	elseif command == 106 then
		--print_message_to_user("BVR")
		if HUD_MODE:get() ~= 2 then
			HUD_MODE:set(2)
			HideFc3Hud()
			if RedHUD == 0 then
				ChangeHudColor()
			end
		else 
			HUD_MODE:set(0)
			ShowFc3Hud()
			if RedHUD == 1 then
				ChangeHudColor()
			end
		end
		
	elseif command == 107 then
		--print_message_to_user("VS")
		if HUD_MODE:get() ~= 3 then
			HUD_MODE:set(3)
			HideFc3Hud()
			if RedHUD == 0 then
				ChangeHudColor()
			end
		else 
			HUD_MODE:set(0)
			ShowFc3Hud()
			if RedHUD == 1 then
				ChangeHudColor()
			end
		end
		
	elseif command == 108 then
		--print_message_to_user("BORE")
		if HUD_MODE:get() ~= 4 then
			HUD_MODE:set(4)
			HideFc3Hud()
			if RedHUD == 0 then
				ChangeHudColor()
			end
		else 
			HUD_MODE:set(0)
			ShowFc3Hud()
			if RedHUD == 1 then
				ChangeHudColor()
			end
		end

	elseif command == 109 then
		--print_message_to_user("HMD")
		if HUD_MODE:get() ~= 8 then
			HUD_MODE:set(8)
			ShowFc3Hud()
			if RedHUD == 1 then
				ChangeHudColor()
			end
		-- else 
			-- HUD_MODE:set(0)
			-- ShowFc3Hud()
			-- ChangeHudColor()
		end
		
	elseif command == 110 then
		--print_message_to_user("LNGT")
		if HUD_MODE:get() ~= 6 then
			HUD_MODE:set(6)
			HideFc3Hud()
			if RedHUD == 0 then
				ChangeHudColor()
			end
		else 
			HUD_MODE:set(0)
			ShowFc3Hud()
			ChangeHudColor()
			
		end

		
	elseif command == 111 then
		--print_message_to_user("AIR TO GROUND")
		
		if HUD_MODE:get() ~= 7 then
			HUD_MODE:set(7)
			ShowFc3Hud()
			if RedHUD == 1 then
				ChangeHudColor()
			end
		else 
			HUD_MODE:set(0)
			HideFc3Hud()
			if RedHUD == 0 then
				ChangeHudColor()
			end
		end
	end

	if command == Keys.CannonMode then
		if HUD_MODE:get() == 1 then
			if get_param_handle("GRIPEN_TYPE"):get() == 1 then
			
				
				if RedHUD == 1 then
					ChangeHudColor()
					ShowFc3Hud()
				else 
					ChangeHudColor()
					HideFc3Hud()
				
				end
				
			end
		
		elseif HUD_MODE:get() == 2 then
			
			if RedHUD == 1 then
				ChangeHudColor()
				ShowFc3Hud()
			else 
				ChangeHudColor()
				HideFc3Hud()
			
			end
		
		elseif HUD_MODE:get() == 3 then
			
			if RedHUD == 1 then
				ChangeHudColor()
				ShowFc3Hud()
			else 
				ChangeHudColor()
				HideFc3Hud()
			
			end
		
		elseif HUD_MODE:get() == 4 then
			
			if RedHUD == 1 then
				ChangeHudColor()
				ShowFc3Hud()
			else 
				ChangeHudColor()
				HideFc3Hud()
			
			end
		
		elseif HUD_MODE:get() == 6 then
			
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
	if command == device_commands.HUD_Brightness then
            HUD_BRIGHTNESS:set(value*value)
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

	if (HOURTIME:get() < 7) then
		LD_BRIGHTNESS:set(0.05)
	elseif (HOURTIME:get() < 8) then
		LD_BRIGHTNESS:set(0.15)
	elseif (HOURTIME:get() < 9) then
		LD_BRIGHTNESS:set(0.25)
	elseif (HOURTIME:get() < 10) then
		LD_BRIGHTNESS:set(0.4)
	elseif (HOURTIME:get() < 11) then
		LD_BRIGHTNESS:set(0.6)
	elseif (HOURTIME:get() < 14) then
		LD_BRIGHTNESS:set(0.75)
	elseif (HOURTIME:get() < 17) then
		LD_BRIGHTNESS:set(0.75)	
	elseif (HOURTIME:get() < 18) then
		LD_BRIGHTNESS:set(0.5)	
	elseif (HOURTIME:get() < 19) then
		LD_BRIGHTNESS:set(0.3)	
	elseif (HOURTIME:get() >= 19) then
		LD_BRIGHTNESS:set(0.5)		
	end
		
	CD_BRIGHTNESS:set(LD_BRIGHTNESS:get())
	RD_BRIGHTNESS:set(LD_BRIGHTNESS:get())
	dev:performClickableAction(device_commands.HUD_Brightness,1, true)
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