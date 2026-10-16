dofile(LockOn_Options.script_path .. "command_defs.lua")
dofile(LockOn_Options.script_path .. "devices.lua")
dofile(LockOn_Options.script_path .. "utils.lua")
dev = GetSelf()
local updateTimeStep = .006 -- update will be called 166 times per second
make_default_activity(updateTimeStep)
local sensor_data = get_base_data()

-- Conversions

local RAD_TO_DEGREE = 57.29577951308233


-- hud indicator params
HUD_CUR_AOA            = get_param_handle("AoA")
local SNSRCAS          = get_param_handle("SNSRCAS") -- Airspeed.
local speedTimeCounter = .3
local SNSRGS           = get_param_handle("SNSRGS")
local machWhole        = get_param_handle("machWhole")
local machDecimals     = get_param_handle("machDecimals")
local transonicLower   = get_param_handle("transonicLower")
local transonicUpper   = get_param_handle("transonicUpper")

get_param_handle("ZERO"):set(0)
get_param_handle("ONE"):set(1)

local HUD_MACH = 0

local IAS             = 0
local GS              = 0
local ACC             = get_param_handle("ACC")
local DEACC           = get_param_handle("DEACC")
local OverSpeedBlink  = 0
local UnderSpeedBlink = 0
get_param_handle("ROTATE_SPEED"):set(128)

local Landing_Mode_Mov = 0
-- Direction related params

local pitchRad = get_param_handle("pitchRad")

local ROLL_HUD = get_param_handle("ROLL_HUD")

local heading = get_param_handle("heading")
local HEADING_MODE = get_param_handle("HEADING_MODE")

local RALTITUDE_HUD = get_param_handle("RALTITUDE_HUD")
local ALT_77        = get_param_handle("ALT_77")
local ALTITUDE_HUD  = get_param_handle("ALTITUDE_HUD")
local TEXT_RALT     = get_param_handle("TEXT_RALT")
local TEXT_ALT      = get_param_handle("TEXT_ALT")
local altMode       = get_param_handle("altMode")
local altTape       = get_param_handle("altTape")
local baroAlt       = get_param_handle("baroAlt")
local radarAlt      = get_param_handle("radarAlt")


local velVecHUDY = get_param_handle("velVecHUDY")
local velVecHUDX = get_param_handle("velVecHUDX")

local VV_LimitedLower = get_param_handle("VV_LimitedLower")
local VV_LimitedUpper = get_param_handle("VV_LimitedUpper")

local HUDDeclutt = get_param_handle("HUDDeclutt")

get_param_handle("HUD_PULLUPQUE"):set(101)

-- System indications
local AT = get_param_handle("AUTOTHROTTLE_ONOFF")
AT:set(0) -- 0 = off 1 = on
local AT_MODE = get_param_handle("AUTOTHROTTLE_MODE")
AT_MODE:set(0) -- 0 = off, .5 = 12, 1 = 14

local Autothrottle_mode = 12

local ALT_HOLD = get_param_handle("ALT_HOLD")
local GPS_ALTITUDE_FEET = get_param_handle("GPS_ALTITUDE_FEET")

local PreviousIAS = 0


dev:listen_command(keys.S1_Trigger)
dev:listen_command(keys.Trigger)

dev:listen_command(keys.HUDDeclutt)


dev:listen_command(10064) -- Toggle autothrottle
dev:listen_command(10065) -- Toggle AoA 12/14

dev:listen_command(389) -- on Alt hold
dev:listen_command(408) -- off Alt hold


function SetCommand(command, value)
	-- Auto throttle			
	if command == 10064 then
		if AT:get() == 1 then
			AT:set(0)
		else
			AT:set(1)
		end
	elseif command == 10065 then
		if Autothrottle_mode == 12 then
			Autothrottle_mode = 14
		else
			Autothrottle_mode = 12
		end
	end

	-- Autopilot
	if command == 389 then
		ALT_HOLD:set(1)
	end
	if command == 408 then
		ALT_HOLD:set(0)
	end

	-- HUD_DECLUTT
	if command == keys.HUDDeclutt and HUDDeclutt:get() == 0 then
		HUDDeclutt:set(1)
	elseif command == keys.HUDDeclutt and HUDDeclutt:get() == 1 then
		HUDDeclutt:set(0)
	end
end

function update()
	if get_param_handle("masterMode"):get() ~= 0 or HUDDeclutt:get() == 1 then
		get_param_handle("altitudeDeclutt"):set(1)
	else
		get_param_handle("altitudeDeclutt"):set(0)
	end

	if altMode:get() == 1 then
		altTape:set(baroAlt:get())
	elseif altMode:get() == 2 then
		altTape:set(radarAlt:get())
	end


	if altTape:get() <= 300 then
		get_param_handle("HUDAltReadout"):set(math.floor((altTape:get() + 2.5) / 5) * 5)
		get_param_handle("HUDAltReadoutShow"):set(1)
	else
		get_param_handle("HUDAltReadoutShow"):set(0)
	end


	local function scale(lineAlt, currentAlt)
		if lineAlt >= 1000 then
			return 0.4 -- height units per 250ft, i.e. 0.16 per 100ft... see note below
		else
			if currentAlt < 1000 then
				return -2.23489e-10 * currentAlt^3
					+ 8.02037e-7 * currentAlt^2
					- 0.000984486 * currentAlt
					+ 0.497469
			else
				return .09
			end
		end
	end

	local function lineOffset2(lineAlt, currentAlt)
		local s = scale(lineAlt, currentAlt) -- height units per 100ft, at this current altitude
		return ((lineAlt - currentAlt) / 100) * s
	end

	get_param_handle("zeroAltLine"):set(math.min(-lineOffset2(0, altTape:get()), .775))



	-- Grid: which altitudes have a line, and how far to the next one -----------

	local function stepUp(alt)
		if alt >= 1000 then
			return 250
		elseif alt >= 300 then
			return 100
		else
			return 50
		end
	end

	-- Only differs from stepUp exactly at the two boundaries, where the grid
	-- gets finer going down (1000 -> 900 is a 100ft step, not 250).
	local function stepDown(alt)
		if alt == 1000 then
			return 100
		elseif alt == 300 then
			return 50
		else
			return stepUp(alt)
		end
	end

	local function nextGridUp(alt) return alt + stepUp(alt) end
	local function nextGridDown(alt) return alt - stepDown(alt) end

	local function gridFloor(alt)
		local step = stepUp(alt)
		return math.floor(alt / step) * step
	end

	-- Long/short pattern ---------------------------------------------------------

	local function isShortLine(alt)
		local absAlt = math.abs(alt)

		if absAlt >= 1000 then
			return (absAlt % 500) ~= 0
		elseif absAlt > 300 then
			return false
		else
			return (absAlt % 100) ~= 0
		end
	end

	local function hasText(alt)
		local absAlt = math.abs(alt)

		if absAlt >= 1000 then
			return not isShortLine(alt)
		elseif absAlt >= 400 then
			return math.floor(alt / 100) % 2 == 0
		elseif absAlt >= 200 then
			return not isShortLine(alt)
		elseif absAlt <= 100 then
			return true
		end
	end

	-- Gap size for one grid step whose lower end is `alt` -------------------------
	-- currentAlt is clamped to [0, 1000] since the curve-fit only covers that
	-- range -- see note below the code about what this means in practice.

	local function gapSize(alt, currentAlt)
		if alt >= 1000 then return 0.2 * .8 end

		local c = math.max(0, math.min(1000, currentAlt))
		local gap = -2.23489e-10 * c^3
			+ 8.02037e-7 * c^2
			- 0.000984486 * c
			+ 0.5

		if alt >= 300 then
			return gap
		else
			return gap / 2
		end
	end

	-- Offset of lineAlt relative to currentAlt, in altitudeTapeHeight units ------
	-- Splits the (currentAlt, lineAlt) range at any regime boundary it crosses,
	-- so each piece uses its own regime's step size and gap.

	local REGIME_BOUNDARIES = {300, 1000}

	local function lineOffset(lineAlt, currentAlt)
		if lineAlt == currentAlt then return 0 end

		local lo, hi = math.min(lineAlt, currentAlt), math.max(lineAlt, currentAlt)
		local sign = (lineAlt > currentAlt) and 1 or -1

		local points = {lo}
		for _, b in ipairs(REGIME_BOUNDARIES) do
			if b > lo and b < hi then points[#points+1] = b end
		end
		points[#points+1] = hi

		local offset = 0
		for i = 1, #points - 1 do
			local segLo, segHi = points[i], points[i + 1]
			local step = stepUp((segLo + segHi) / 2)
			offset = offset + (segHi - segLo) / step * gapSize(segLo, currentAlt)
		end

		return sign * offset
	end

	local NUM_ALT_LINES = 9
	local WRAP_MARGIN = 0.55 -- just past the visible half-height; tune to your tape mask

	local altLineAlt        = {}
	local HUDAltLineY       = {}
	local HUDAltLineIsShort = {}
	local HUDAltLineTextKAvail = {}
	local HUDAltLineTextKL   = {}
	local HUDAltLineTextKS   = {}
	local altLinesInit      = false

	for i = 1, NUM_ALT_LINES do
		HUDAltLineY[i]       = get_param_handle("HUDAltLineY_" .. i)
		HUDAltLineIsShort[i] = get_param_handle("HUDAltLineIsShort_" .. i)
		HUDAltLineTextKAvail[i] = get_param_handle("HUDAltLineTextKAvail_" .. i)
		HUDAltLineTextKL[i]   = get_param_handle("HUDAltLineTextKL_" .. i)
		HUDAltLineTextKS[i]   = get_param_handle("HUDAltLineTextKS_" .. i)
	end

	local function initAltLines(currentAlt)
		local anchor = gridFloor(currentAlt)
		local up, down = anchor, anchor

		altLineAlt[1] = anchor
		for i = 1, 4 do
			up                    = nextGridUp(up)
			down                  = nextGridDown(down)
			altLineAlt[2 * i]     = up
			altLineAlt[2 * i + 1] = down
		end

		altLinesInit = true
	end

	local function updateAltTape(currentAlt)
		local lineAlt
		local STR_PREFIX = ",       "
		local hundreds

		if not altLinesInit then initAltLines(currentAlt) end

		for i = 1, NUM_ALT_LINES do
			local offset = lineOffset(altLineAlt[i], currentAlt)

			if offset > WRAP_MARGIN then
				local lowest = altLineAlt[1]
				for j = 2, NUM_ALT_LINES do
					if altLineAlt[j] < lowest then lowest = altLineAlt[j] end
				end
				altLineAlt[i] = nextGridDown(lowest)
				offset = lineOffset(altLineAlt[i], currentAlt)
			elseif offset < -WRAP_MARGIN then
				local highest = altLineAlt[1]
				for j = 2, NUM_ALT_LINES do
					if altLineAlt[j] > highest then highest = altLineAlt[j] end
				end
				altLineAlt[i] = nextGridUp(highest)
				offset = lineOffset(altLineAlt[i], currentAlt)
			end

			lineAlt = altLineAlt[i]

			if lineAlt ~= 0 then
				HUDAltLineY[i]:set(offset)
				HUDAltLineIsShort[i]:set(isShortLine(lineAlt) and 1 or 0)

				if hasText(lineAlt) then
					HUDAltLineTextKAvail[i]:set(1)

					if lineAlt >= 1000 then
						HUDAltLineTextKL[i]:set(math.floor(lineAlt / 1000)) -- Spacer for rendering as a string


						hundreds = lineAlt - math.floor(lineAlt / 1000) * 1000

						if hundreds == 0 then hundreds = hundreds .. "00" end
						
						HUDAltLineTextKS[i]:set(STR_PREFIX .. hundreds)
					else
						HUDAltLineTextKS[i]:set(" ")
					end
				else
					HUDAltLineTextKAvail[i]:set(0)
					HUDAltLineTextKS[i]:set(" ")
				end
			else
				HUDAltLineTextKAvail[i]:set(0)
				HUDAltLineIsShort[i]:set(-1) -- Don't render
			end
		end
	end

	updateAltTape(altTape:get())











	-- for i = 1, 9 do
	-- local longLine = lineOffset(100 * i, altTape:get())
	-- local counter = 0
	--
	-- currentLines[i] = (100 * i - counter)
	--
	-- get_param_handle("HUDAltLineLong_" .. i):set(longLine)
	-- get_param_handle("HUDAltLineShort_" .. i):set(wrapValue(-.5, .5, lineOffset(100 * i - 50, altTape:get())))
	--

	-- if longLine <= 999 then
	-- get_param_handle("HUDAltBig_" .. i):set(longLine)
	-- get_param_handle("HUDAltSmall_" .. i):set(" ")
	-- get_param_handle("HUDAltSmallStr_" .. i):set("")
	-- else
	-- local thousands = math.floor(longLine / 1000)
	-- local hundreds = math.floor((longLine % 1000) / 100)
	-- get_param_handle("HUDAltBig_" .. i):set(thousands)
	-- if hundreds == 0 then
	-- get_param_handle("HUDAltSmall_" .. i):set(".          000")
	-- get_param_handle("HUDAltSmallStr_" .. i):set(0)
	-- else
	-- get_param_handle("HUDAltSmall_" .. i):set(".          " .. hundreds .. "00")
	-- get_param_handle("HUDAltSmallStr_" .. i):set(hundreds)
	-- end
	-- end


	-- get_param_handle("HUD" .. i .. "AltLine"):set(lineOffset(100 * i, altTape:get()))

	-- end

	-- get_param_handle("RADAR_STT_RANGE_NM"):set(get_param_handle("RADAR_STT_RANGE"):get() * .00053)
	-- if get_param_handle("RADAR_STT_RANGE_NM"):get() / 1.35 > 2 then
	-- 	get_param_handle("RADAR_STT_RANGE_CARROT_RANGE"):set(2)
	-- else
	-- 	get_param_handle("RADAR_STT_RANGE_CARROT_RANGE"):set(get_param_handle("RADAR_STT_RANGE_NM"):get() / 1.35)
	-- end



	if get_param_handle("landingMode"):get() == 1 then
		if get_param_handle("GLIDE_SLOPE_MOVE"):get() <= math.rad(-2.86) then
			get_param_handle("GLIDE_SLOPE_MOVE"):set(math.rad(-2.86))
		else
			get_param_handle("GLIDE_SLOPE_MOVE"):set(get_param_handle("GLIDE_SLOPE_MOVE"):get() - (updateTimeStep * math.rad(2.86) / 5))
		end
	else
		get_param_handle("GLIDE_SLOPE_MOVE"):set(0)
	end

	local Hud_Ralt = sensor_data.getRadarAltitude() * 3.2808399

	local VerticalSpeed     = sensor_data.getVerticalVelocity() * 3.2808399
	local BarometricAltFeet = (sensor_data.getBarometricAltitude() * 3.2808399)
	TEXT_ALT:set(math.floor(BarometricAltFeet / 10) * 10)
	TEXT_RALT:set(math.floor(Hud_Ralt / 10) * 10)

	get_param_handle("rollRad"):set(sensor_data.getRoll())
	ROLL_HUD:set(sensor_data.getRoll())

	pitchRad:set(sensor_data.getPitch())


	local VelVec_x = math.rad(sensor_data.getAngleOfSlide())
	local VelVec_y = -sensor_data.getAngleOfAttack() -- -get_param_handle("FilteredAOA"):get()


	if get_param_handle("CURRENT_PHASE_STATIONARY"):get() == 1 or get_param_handle("CURRENT_PHASE_PARKED"):get() == 1 or get_param_handle("CURRENT_PHASE_TAXI"):get() == 1 or get_param_handle("CURRENT_PHASE_TGR"):get() == 1 or get_param_handle("CURRENT_PHASE_LR"):get() == 1 then
		get_param_handle("HUDSidesY"):set((VelVec_y - .06) + ((get_param_handle("HUD_VELVEC_VER_LINE_POS"):get() * 14) * .001) - .014) -- ((get_param_handle("HUD_VELVEC_VER_LINE_POS"):get() * 14) * .001) - .084
		get_param_handle("HUDSidesX"):set(0)
		if VelVec_y - .06 < -.225 then
			velVecHUDY:set(-.225)
		else
			velVecHUDY:set(VelVec_y - .06)
		end
		velVecHUDX:set(0)
		VV_LimitedLower:set(1)
	elseif get_param_handle("CURRENT_PHASE_ROT"):get() == 1 then
		if VelVec_y - .06 < -.225 then
			get_param_handle("HUDSidesY"):set(-.225)
		elseif VelVec_y > -.005 then
			get_param_handle("HUDSidesY"):set(-.005)
		else
			get_param_handle("HUDSidesY"):set((VelVec_y - .06) + ((get_param_handle("HUD_VELVEC_VER_LINE_POS"):get() * 14) * .001) - .014)
		end
		get_param_handle("HUDSidesX"):set(0)
		if VelVec_y - .06 < -.225 then
			velVecHUDY:set(-.225) -- 8aoa ska det vara.
		else
			velVecHUDY:set(VelVec_y - .06)
		end
		velVecHUDX:set(0)
	else
		if HUD_CUR_AOA:get() >= 14.5 then -- idk what I did here.
			VV_LimitedLower:set(1)
			velVecHUDY:set(math.rad(-14.5))
			get_param_handle("HUDSidesY"):set(math.rad(-14.5))
		elseif HUD_CUR_AOA:get() <= -4.5 then
			VV_LimitedUpper:set(1)
			velVecHUDY:set(math.rad(4.5))
		else
			VV_LimitedLower:set(0)
			VV_LimitedUpper:set(0)
			velVecHUDY:set(VelVec_y)
			get_param_handle("HUDSidesY"):set(VelVec_y)
		end
		if VelVec_x <= -.16 then
			velVecHUDX:set(-.16)
		elseif VelVec_x >= .16 then
			velVecHUDX:set(.16)
		else
			velVecHUDX:set(VelVec_x)
		end



		if VelVec_y >= -.036 then
			if VelVec_x < 0 then
				if VelVec_x < (-.06 - ((VelVec_y * .45) * -1)) then
					get_param_handle("HUDSidesX"):set((-.06 - ((VelVec_y * .45) * -1)))
				else
					get_param_handle("HUDSidesX"):set(VelVec_x)
				end
			elseif VelVec_x > 0 then
				if VelVec_x > (.05 - (VelVec_y * .45)) then
					get_param_handle("HUDSidesX"):set((.03 - (VelVec_y * .45))) -- .025
				else
					get_param_handle("HUDSidesX"):set(VelVec_x)
				end
			end
		elseif VelVec_y < -.036 and VelVec_y >= -.08 then
			if VelVec_x < 0 then
				if VelVec_x < (-.06 - (VelVec_y * .2)) then      -- - (VelVec_y * .3)
					get_param_handle("HUDSidesX"):set((-.06 - (VelVec_y * .2))) --- .065 ---.068
				else
					get_param_handle("HUDSidesX"):set(VelVec_x)
				end
			elseif VelVec_x > 0 then
				if VelVec_x > (.06 - (VelVec_y * .2)) then      -- - (VelVec_y * .3)
					get_param_handle("HUDSidesX"):set((.06 - (VelVec_y * .2))) --- .065 ---.068
				else
					get_param_handle("HUDSidesX"):set(VelVec_x)
				end
			end
		elseif VelVec_y < -.08 and get_param_handle("HUDSidesY"):get() > -.175 then
			if VelVec_x < 0 then
				if VelVec_x < (-.08 - (VelVec_y * .45)) then
					get_param_handle("HUDSidesX"):set((-.08 - (VelVec_y * .45)))
				else
					get_param_handle("HUDSidesX"):set(VelVec_x)
				end
			elseif VelVec_x > 0 then
				if VelVec_x > (.085 - ((VelVec_y * .45) * -1)) then
					get_param_handle("HUDSidesX"):set((.085 - ((VelVec_y * .45) * -1)))
				else
					get_param_handle("HUDSidesX"):set(VelVec_x)
				end
			end
		elseif get_param_handle("HUDSidesY"):get() <= -.225 then
			if VelVec_x < -.013 then
				get_param_handle("HUDSidesX"):set(-.013)
			elseif VelVec_x > .014 then
				get_param_handle("HUDSidesX"):set(.014)
			else
				get_param_handle("HUDSidesX"):set(VelVec_x)
			end
		end
	end

	-- if get_param_handle("weaponsMode"):get() == 3 and get_param_handle("RADAR_MODE"):get() == 3 then
	-- velVecHUDY:set(-get_param_handle("GunPiperElev"):get())
	-- velVecHUDX:set(get_param_handle("GunPiperAz"):get())
	-- end


	-- get_param_handle("TEST_PITCHER"):set(math.cos(ROLL_HUD:get()) * (pitchRad:get() + velVecHUDY:get()))

	-- get_param_handle("TEST_ROLLER"):set(math.sin(ROLL_HUD:get()) * (pitchRad:get() + velVecHUDY:get()))

	if (get_param_handle("PULLUPQUE"):get() + (math.rad(20) * 1000)) - (velVecHUDY:get() * 10) < -130 then
		get_param_handle("HUD_PULLUPQUE"):set(-130)
	else
		get_param_handle("HUD_PULLUPQUE"):set((get_param_handle("PULLUPQUE"):get() + (math.rad(20) * 1000)) - (velVecHUDY:get() * 10))
	end


	if get_param_handle("CURRENT_PHASE_CO"):get() == 1 then
		get_param_handle("DSI_UP"):set(0)
		if VV_LimitedLower:get() == 1 then
			get_param_handle("DSI_STATE"):set(0)
		else
			get_param_handle("DSI_STATE"):set(1)
		end
	elseif get_param_handle("CURRENT_PHASE_PAL"):get() == 1 then
		get_param_handle("DSI_STATE"):set(1)
		if get_param_handle("HUDSidesY"):get() < -.1 then
			get_param_handle("DSI_UP"):set(1)
		else
			get_param_handle("DSI_UP"):set(0)
		end
	else
		get_param_handle("DSI_STATE"):set(0)
	end



	if HEADING_MODE:get() == 1 then
		heading:set(360 - math.deg(sensor_data.getHeading()))
	else
		heading:set(math.deg(sensor_data.getMagneticHeading()))
	end


	if get_param_handle("AutoPilotMode"):get() == -2 or get_param_handle("AutoPilotMode"):get() == 2 then
		get_param_handle("HUD_AP_ALT_BOXES"):set(1)
	else
		get_param_handle("HUD_AP_ALT_BOXES"):set(0)
	end

	ALTITUDE_HUD:set(BarometricAltFeet)
	-- ALTITUDE_HUD:set(81000)
	if (Hud_Ralt > 5249.4) and (Hud_Ralt < 5249.6) then
		RALTITUDE_HUD:set(GPS_ALTITUDE_FEET:get() - get_param_handle("TERRAIN_ALT"):get())
		get_param_handle("RadarAltAvail"):set(0)
	else
		RALTITUDE_HUD:set(Hud_Ralt)
		get_param_handle("RadarAltAvail"):set(1)
	end

	get_param_handle("ALTITUDE_BARO"):set(math.floor((sensor_data.getBarometricAltitude() * 3.2808399) / 10) * 10)
	get_param_handle("ALTITUDE_RALT"):set(math.floor((sensor_data.getRadarAltitude() * 3.2808399) / 10) * 10)

	ALT_77:set(get_param_handle("TERRAIN_ALT"):get() * -(BarometricAltFeet * .00001))
	-- Speeds =================================================================================================================================
	IAS = sensor_data.getIndicatedAirSpeed() * 1.94384449                 -- m/s to kts
	local self_vel_l, self_vel_v, self_vel_h = sensor_data.getSelfAirspeed() -- Prereq for ground speed in kts
	GS = math.sqrt(self_vel_h^2 + self_vel_l^2) * 1.94384449
	get_param_handle("GS"):set(GS)


	-- Below 50 kts use ground speed reading instead
	if IAS < 50 then
		SNSRCAS:set(GS)
	else
		SNSRCAS:set(IAS)
	end

	if IAS > 5 then
		if speedTimeCounter + updateTimeStep >= .3 then
			if IAS > 80 then
				get_param_handle("textCAS"):set(IAS)
			else
				get_param_handle("textCAS"):set(GS)
			end
			SNSRGS:set(GS)

			speedTimeCounter = 0
		else
			speedTimeCounter = speedTimeCounter + updateTimeStep
		end
	else
		get_param_handle("textCAS"):set(0)
	end

	local SuperSonic = IAS / sensor_data.getMachNumber()
	transonicLower:set(SuperSonic * .95)
	transonicUpper:set(SuperSonic * 1.05)

	HUD_MACH = sensor_data.getMachNumber() * .1

	if HUD_MACH < .995 then
		HUD_MACH = HUD_MACH * 1000
	end

	machWhole:set(sensor_data.getMachNumber())
	machDecimals:set(HUD_MACH)


	local Acceleration = ((IAS - PreviousIAS) / updateTimeStep) * 5 -- 45
	PreviousIAS        = IAS
	if Acceleration < .1 then -- TODO: Fix so it doens't glitch
		ACC:set(0)
		DEACC:set(Acceleration + 22.5)
	else
		ACC:set(Acceleration - 22.5)
		DEACC:set(0)
	end



	if get_param_handle("CURRENT_PHASE_STATIONARY"):get() == 1 or get_param_handle("CURRENT_PHASE_PARKED"):get() == 1 or get_param_handle("CURRENT_PHASE_TAXI"):get() == 1 then
		get_param_handle("HUD_VELVEC_VER_LINE_POS"):set(0)
		get_param_handle("HUD_VELVEC_VER_LINE_BLINK"):set(0)
	elseif get_param_handle("CURRENT_PHASE_TGR"):get() == 1 or get_param_handle("CURRENT_PHASE_ROT"):get() == 1 or get_param_handle("CURRENT_PHASE_TD"):get() == 1 or get_param_handle("CURRENT_PHASE_LR"):get() == 1 then
		local TakeOffSpeed     = 0
		local TakeOffOverspeed = 0
		local RotationSpeed    = 128

		if SNSRCAS:get() < RotationSpeed then
			TakeOffOverspeed = 0
		else
			TakeOffSpeed     = 1
			TakeOffOverspeed = 1
		end
		if SNSRCAS:get() < RotationSpeed and SNSRCAS:get() >= 100 then
			TakeOffSpeed = (SNSRCAS:get() - 100) / (RotationSpeed - 100)
		end

		if TakeOffOverspeed == 1 then
			if OverSpeedBlink < 1 then
				OverSpeedBlink = OverSpeedBlink + updateTimeStep
			else
				OverSpeedBlink = 0
			end
		else
			OverSpeedBlink = 0
		end

		if get_param_handle("CURRENT_PHASE_TGR"):get() == 1 then
			get_param_handle("HUD_VELVEC_VER_LINE_BLINK"):set(OverSpeedBlink)
		else
			get_param_handle("HUD_VELVEC_VER_LINE_BLINK"):set(0)
		end
		get_param_handle("HUD_VELVEC_VER_LINE_POS"):set(TakeOffSpeed)
	elseif get_param_handle("CURRENT_PHASE_CO"):get() == 1 then
		get_param_handle("HUD_VELVEC_VER_LINE_BLINK"):set(0)
		if get_param_handle("masterMode"):get() ~= 0 then
			get_param_handle("HUD_VELVEC_VER_LINE_POS"):set(2.6)
		else
			get_param_handle("HUD_VELVEC_VER_LINE_POS"):set(.72)
		end
	elseif get_param_handle("CURRENT_PHASE_PAL"):get() == 1 then
		local Landing_Speed          = 128
		local Current_Approach_Speed = Landing_Speed - SNSRCAS:get()

		if Current_Approach_Speed == 0 then
			get_param_handle("HUD_VELVEC_VER_LINE_POS"):set(.72)
		else
			if .72 - Current_Approach_Speed * .05 < .32 then -- UnderSpeedBlink
				get_param_handle("HUD_VELVEC_VER_LINE_POS"):set(.32)
				if UnderSpeedBlink < 1 then
					UnderSpeedBlink = UnderSpeedBlink + updateTimeStep
				else
					UnderSpeedBlink = 0
				end
				get_param_handle("HUD_VELVEC_VER_LINE_BLINK"):set(UnderSpeedBlink)
			elseif .72 - Current_Approach_Speed * .05 > 1.13 then
				get_param_handle("HUD_VELVEC_VER_LINE_POS"):set(1.13)
				get_param_handle("HUD_VELVEC_VER_LINE_BLINK"):set(0)
			else
				get_param_handle("HUD_VELVEC_VER_LINE_POS"):set(.72 - Current_Approach_Speed * .05)
				get_param_handle("HUD_VELVEC_VER_LINE_BLINK"):set(0)
			end
		end
	end

	-- Auto Throttle ==========================================================================================================================
	if (AT:get() == 1) and ((get_param_handle("CURRENT_PHASE_LO"):get() > .0) or (get_param_handle("CURRENT_PHASE_PAL"):get() > .0)) then
		if Autothrottle_mode == 12 then
			AT_MODE:set(.5)
		elseif Autothrottle_mode == 14 then
			AT_MODE:set(1)
		end
	elseif (get_param_handle("CURRENT_PHASE_LO"):get() < 1.0) or (get_param_handle("CURRENT_PHASE_PAL"):get() < 1.0) or (AT:get() < .5) then
		AT_MODE:set(0)
	end
end
need_to_be_closed = false






--[[
getAngleOfAttack()
getAngleOfSlide()
getBarometricAltitude()
getCanopyPos()
getCanopyState()
getEngineLeftFuelConsumption()
getEngineLeftRPM()
getEngineLeftTemperatureBeforeTurbine()
getEngineRightFuelConsumption()
getEngineRightRPM()
getEngineRightTemperatureBeforeTurbine()
getFlapsPos()
getFlapsRetracted()
getHeading()
getHorizontalAcceleration()
getIndicatedAirSpeed()
getLandingGearHandlePos()
getLateralAcceleration()
getLeftMainLandingGearDown()
getLeftMainLandingGearUp()
getMachNumber()
getMagneticHeading()
getNoseLandingGearDown()
getNoseLandingGearUp()
getPitch()
getRadarAltitude()
getRateOfPitch()
getRateOfRoll()
getRateOfYaw()
getRightMainLandingGearDown()
getRightMainLandingGearUp()
getRoll()
getRudderPosition()
getSpeedBrakePos()
getSelfAirspeed()
getSelfCoordinates()
getSelfVelocity()
getStickPitchPosition()
getStickRollPosition()
getThrottleLeftPosition()
getThrottleRightPosition()
getTotalFuelWeight()
getTrueAirSpeed()
getVerticalAcceleration()
getVerticalVelocity()
getWOW_LeftMainLandingGear()
getWOW_NoseLandingGear()
getWOW_RightMainLandingGear()
--]]