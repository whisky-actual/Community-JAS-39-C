dofile(LockOn_Options.script_path .. "command_defs.lua")
dofile(LockOn_Options.script_path .. "devices.lua")
dofile(LockOn_Options.script_path .. "utils.lua")



local updateTimeStep = 1 / 60
make_default_activity(updateTimeStep)


local HUD = GetSelf()

HUD:listen_command(keys.HUDDeclutt)
-- TODO: Move these to their correct files.
HUD:listen_command(10064) -- Toggle autothrottle
HUD:listen_command(10065) -- Toggle AoA 12/14

HUD:listen_command(389) -- on Alt hold
HUD:listen_command(408) -- off Alt hold


local baseData = get_base_data()


local zAScale
local WRAP_MARGIN = {.55, .625} -- Lower, upper


local M_TO_FT = 3.28083989501312335958
local M_PER_S_TO_FT_PER_MIN = M_TO_FT * 60


local HUDAltReadoutAvail     = get_param_handle("HUDAltReadoutAvail")
local HUDAltReadout          = get_param_handle("HUDAltReadout")
local HUDAltReadoutThousands = get_param_handle("HUDAltReadoutThousands")
local HUDAltReadoutHundreds  = get_param_handle("HUDAltReadoutHundreds")
local zeroAltLine            = get_param_handle("zeroAltLine")
local altRIndY               = get_param_handle("altRIndY")
local radarTerrainAlt        = get_param_handle("radarTerrainAlt")
local HUD77Y                 = get_param_handle("HUD77Y")
local HUD77Avail             = get_param_handle("HUD77Avail")
local altitudeDeclutt        = get_param_handle("altitudeDeclutt")

local CURRENT_PHASE = get_param_handle("CURRENT_PHASE")
local LANDING_MODE  = get_param_handle("LANDING_MODE")






-- Conversions
--

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
local primaryAltVal = get_param_handle("primaryAltVal")
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






local updateAltitudeScale

do -- Altitude Scale
	local NUM_ALT_LINES     = 9
	local STR_PREFIX        = ",       "
	local REGIME_BOUNDARIES = {-1000, -300, 300, 1000}  -- Ascending. Where the grid density / gap changes.
	local FINE_UP           = {[-1000] = 100, [-300] = 50} -- Where the grid gets finer going toward zero, the first step off the boundary is smaller than stepMag.
	local FINE_DOWN         = {[1000] = 100, [300] = 50}
	local CUBIC_1000
	local FLAT_GAP


	local altLanding = false -- LANDING_MODE == 1
	local altLineAlt = {}


	local HUDAltLineIsShort, HUDAltLineTextKS, HUDAltLineTextH = {}, {}, {}

	for i = 1, NUM_ALT_LINES do
		HUDAltLineIsShort[i] = get_param_handle("HUDAltLineIsShort_" .. i)
		HUDAltLineTextKS[i]  = get_param_handle("HUDAltLineTextKS_" .. i)
		HUDAltLineTextH[i]   = get_param_handle("HUDAltLineTextH_" .. i)
	end



	--- Distance between the long lines (100 ft) at x ft under 1000 ft.
	local function cubic(x)
		return -2.23489e-10 * x^3 + 8.02037e-7 * x^2 - .000984486 * x + .5 -- Formula from regression via Desmos: https://www.desmos.com/calculator/fnan1jxrz0
	end

	CUBIC_1000 = cubic(1000)
	FLAT_GAP   = CUBIC_1000 * 1.8559 -- Gap per 250 ft above 1000 ft. Derived from the cubic so the scroll rate stays constant through 1000 ft.

	--- Grid step magnitude at `alt`.
	local function stepMag(alt)
		if altLanding then return 50 end

		local absAlt = math.abs(alt)

		return absAlt >= 1000 and 250 or absAlt >= 300 and 100 or 50
	end

	local function nextGridUp(alt)
		return alt + (not altLanding and FINE_UP[alt] or stepMag(alt))
	end

	local function nextGridDown(alt)
		return alt - (not altLanding and FINE_DOWN[alt] or stepMag(alt))
	end

	local function gridFloor(alt)
		local step = stepMag(alt)

		return math.floor(alt / step) * step
	end

	local function isShortLine(alt)
		local absAlt = math.abs(alt)

		if not altLanding then
			if absAlt >= 1000 then return absAlt % 500 ~= 0 end
			if absAlt > 300 then return false end
		end

		return absAlt % 100 ~= 0
	end

	local function hasText(alt)
		local absAlt = math.abs(alt)

		if altLanding then
			return absAlt % 100 == 0
		elseif absAlt >= 1000 then
			return not isShortLine(alt)
		elseif absAlt >= 400 then
			return math.floor(alt / 100) % 2 == 0
		elseif absAlt >= 200 then
			return not isShortLine(alt)
		else
			return absAlt <= 100
		end
	end

	--- Scale gap per grid step for the step starting at `alt`, when flying at `currentAlt`.
	local function gapSize(alt, currentAlt)
		if altLanding then return CUBIC_1000 * 2 end

		local absAlt = math.abs(alt)

		if absAlt >= 1000 then return FLAT_GAP end

		local gap = cubic(math.min(1000, math.abs(currentAlt)))

		return absAlt >= 300 and gap or gap / 2
	end

	--- Offset of `lineAlt` relative to `currentAlt` in altitude scale height units. Split at every regime boundary crossed so each piece uses its own step size and gap.
	local function lineOffset(lineAlt, currentAlt)
		if lineAlt == currentAlt then return 0 end

		local lo, hi = math.min(lineAlt, currentAlt), math.max(lineAlt, currentAlt)
		local offset, segLo = 0, lo

		for _, b in ipairs(REGIME_BOUNDARIES) do
			if b > lo and b < hi then
				offset = offset + (b - segLo) / stepMag((segLo + b) / 2) * gapSize(segLo, currentAlt)
				segLo = b
			end
		end

		offset = offset + (hi - segLo) / stepMag((segLo + hi) / 2) * gapSize(segLo, currentAlt)

		return lineAlt > currentAlt and offset or -offset
	end

	--- Finds the altitude that lies at `targetOffset` on the scale, by bisection (`lineOffset` always increases with altitude).
	local function altAtOffset(targetOffset, currentAlt, searchRadius)
		searchRadius = searchRadius or 2000

		local lo, hi = currentAlt - searchRadius, currentAlt + searchRadius

		for _ = 1, 30 do
			local mid = (lo + hi) / 2

			if lineOffset(mid, currentAlt) < targetOffset then lo = mid else hi = mid end
		end

		return (lo + hi) / 2
	end


	local function updateReadout(currentAlt, declutt)
		if currentAlt > (altLanding and 10005 or 300) and not declutt then
			HUDAltReadoutAvail:set(0)
			return
		end

		HUDAltReadoutAvail:set(1)

		local verticalSpeed = baseData.getVerticalVelocity()

		-- Landing mode adds |n_z| to stop it from glitching when quickly going over the horizon line.
		if altLanding or declutt then verticalSpeed = verticalSpeed + math.abs(baseData.getVerticalAcceleration()) end

		verticalSpeed = math.abs(verticalSpeed) * M_PER_S_TO_FT_PER_MIN

		local res = verticalSpeed < 500 and 5 or verticalSpeed < 1000 and 10 or verticalSpeed < 1500 and 20 or 50
		local altReadout = math.floor((currentAlt + res / 2) / res) * res

		if altReadout <= 995 then
			HUDAltReadout:set(altReadout)
			HUDAltReadoutThousands:set(100) -- Doesn't render above 99
		elseif altReadout <= 10005 or declutt then
			local hundreds

			if not declutt then
				local function hundredsOf(c)
					return math.floor((math.floor(c - math.floor(c / 1000) * 1000) + res / 2) / res) * res
				end

				hundreds = 0

				if currentAlt > 1000 then
					hundreds = hundredsOf(currentAlt)
					if hundreds >= 1000 then hundreds = hundredsOf(currentAlt - res / 2) end -- Rounded up into the next thousand
				end
			else
				hundreds = math.floor((currentAlt - math.floor(currentAlt / 1000) * 1000) / 100) * 100

				if hundreds + math.floor(currentAlt / 1000) * 1000 == 900 then
					hundreds = 0
				end
			end

			HUDAltReadoutThousands:set(math.max(math.floor(currentAlt / 1000), 1))
			HUDAltReadoutHundreds:set(not declutt and string.format("%03d", hundreds) .. "       ," or hundreds) -- Comma hidden in the alt scale.
			HUDAltReadout:set(1000)                                                                     -- Doesn't render with values above 999
		end
	end

	--- Rebuilds the 9 lines around `currentAlt` and wraps any that are outside the scale to the opposite end.
	local function updateLines(currentAlt)
		local up, down = gridFloor(currentAlt), gridFloor(currentAlt)

		altLineAlt[1] = up

		for i = 1, 4 do
			up, down = nextGridUp(up), nextGridDown(down)
			altLineAlt[2 * i], altLineAlt[2 * i + 1] = up, down
		end

		for i = 1, NUM_ALT_LINES do
			local lineAlt = altLineAlt[i]
			local offset  = lineOffset(lineAlt, currentAlt)

			if offset > WRAP_MARGIN[2] then
				lineAlt = nextGridDown(math.min(unpack(altLineAlt)))
			elseif offset < -WRAP_MARGIN[1] then
				lineAlt = nextGridUp(math.max(unpack(altLineAlt)))
			end

			if lineAlt ~= altLineAlt[i] then
				altLineAlt[i] = lineAlt
				offset = lineOffset(lineAlt, currentAlt)
			end

			local isZero = lineAlt == 0
			local text   = not isZero and hasText(lineAlt)
			local isK    = text and lineAlt >= 1000

			get_param_handle("HUDAltLineTextKAvail_" .. i):set(isK and 1 or 0)
			get_param_handle("HUDAltLineTextHAvail_" .. i):set(text and not isK and 1 or 0)

			if isZero then
				HUDAltLineIsShort[i]:set(-1) -- Don't render
			else
				get_param_handle("HUDAltLineY_" .. i):set(offset)
				HUDAltLineIsShort[i]:set(isShortLine(lineAlt) and 1 or 0)
			end

			if isK then
				get_param_handle("HUDAltLineTextKL_" .. i):set(math.floor(lineAlt / 1000)) -- Spacer for rendering as a string
				HUDAltLineTextKS[i]:set(STR_PREFIX .. string.format("%03d", lineAlt % 1000))
			elseif text then
				HUDAltLineTextH[i]:set(lineAlt) -- Lines are always on the 50 ft grid, and labelled ones on the 100 ft grid (or 50 ft near 0), so no rounding needed.
			elseif not isZero then
				HUDAltLineTextKS[i]:set(" ")
			end
		end
	end

	--- Terrain marker (the "77" indicator). Compressed below the scale's bottom edge instead of leaving it.
	local function updateTerrainMarker(currentAlt)
		local terrain = radarTerrainAlt:get()
		local raltValue = currentAlt - baseData.getRadarAltitude() * M_TO_FT

		if radarAlt:get() < 30000 and (altMode:get() == 1 or (altMode:get() == 2 and math.abs(raltValue) >= 30)) and CURRENT_PHASE:get() > 3 and terrain ~= -9999 then
			local markerValue = altMode:get() == 1 and terrain or raltValue
			local y = lineOffset(markerValue, currentAlt)

			if y <= -.5 then
				local zeroY = zeroAltLine:get()

				y = zeroY + math.abs(-.5 - zeroY) * math.sqrt(math.abs(markerValue / altAtOffset(-.5, currentAlt))) * Math.sign(markerValue)
			end

			HUD77Avail:set(1)
			HUD77Y:set(y)
		else
			HUD77Avail:set(0)
		end
	end


	updateAltitudeScale = function (currentAlt, declutt)
		altLanding = LANDING_MODE:get() == 1

		updateReadout(currentAlt, declutt)

		if not declutt then
			local zeroScale = (not altLanding and math.abs(currentAlt) < 1000) and cubic(currentAlt) or CUBIC_1000 * (altLanding and 4 or 1)

			zeroAltLine:set(Math.clamp(-(currentAlt / 100) * zeroScale, -WRAP_MARGIN[1] - .275, WRAP_MARGIN[2] + .275))

			if altMode:get() == 2 then
				altRIndY:set(Math.clamp(zeroAltLine:get(), -WRAP_MARGIN[1] - .275, -WRAP_MARGIN[1]))
			end

			updateLines(currentAlt)
			updateTerrainMarker(currentAlt)


			get_param_handle("HUDAltMaskTop"):set(.6075)

			local bottom   = zeroAltLine:get() - .075
			local topLimit = -.53

			if HUD77Avail:get() == 1 then
				bottom = math.min(bottom, HUD77Y:get() - .1)
			end

			if altMode:get() ~= 1 then
				bottom   = math.min(bottom, altRIndY:get() - .2075)
				topLimit = -.525
			end

			get_param_handle("HUDAltMaskBottom"):set(Math.clamp(bottom, -9, topLimit))
		end
	end
end


--- Moves `param` linearly from `start` to `target` over `duration` seconds. Call every update.
--- @param start number Value the animation starts from (only used for speed and direction).
--- @param target number Value to stop at.
--- @param param table ParamHandle to animate.
--- @param duration number Time in seconds for the full start -> target distance.
local function linearAnimate(start, target, param, duration)
	local velocity = (target - start) / duration * updateTimeStep
	local value    = param:get() + velocity

	if velocity > 0 then
		value = math.min(value, target)
	else
		value = math.max(value, target)
	end

	param:set(value)
end


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
	if get_param_handle("weaponsMode"):get() ~= -1 or HUDDeclutt:get() == 1 then
		altitudeDeclutt:set(1)
		linearAnimate(0, -.0875, get_param_handle("HUDRightSideX"), .1)
	else
		altitudeDeclutt:set(0)
	end

	updateAltitudeScale(primaryAltVal:get(), altitudeDeclutt:get() == 1)












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

	local Hud_Ralt = baseData.getRadarAltitude() * 3.2808399

	local VerticalSpeed     = baseData.getVerticalVelocity() * 3.2808399
	local BarometricAltFeet = (baseData.getBarometricAltitude() * 3.2808399)
	TEXT_ALT:set(math.floor(BarometricAltFeet / 10) * 10)
	TEXT_RALT:set(math.floor(Hud_Ralt / 10) * 10)

	get_param_handle("rollRad"):set(baseData.getRoll())
	ROLL_HUD:set(baseData.getRoll())

	pitchRad:set(baseData.getPitch())


	local VelVec_x = math.rad(baseData.getAngleOfSlide())
	local VelVec_y = -baseData.getAngleOfAttack() -- -get_param_handle("FilteredAOA"):get()


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
		heading:set(360 - math.deg(baseData.getHeading()))
	else
		heading:set(math.deg(baseData.getMagneticHeading()))
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

	get_param_handle("ALTITUDE_BARO"):set(math.floor((baseData.getBarometricAltitude() * 3.2808399) / 10) * 10)
	get_param_handle("ALTITUDE_RALT"):set(math.floor((baseData.getRadarAltitude() * 3.2808399) / 10) * 10)

	ALT_77:set(get_param_handle("TERRAIN_ALT"):get() * -(BarometricAltFeet * .00001))
	-- Speeds =================================================================================================================================
	IAS = baseData.getIndicatedAirSpeed() * 1.94384449                 -- m/s to kts
	local self_vel_l, self_vel_v, self_vel_h = baseData.getSelfAirspeed() -- Prereq for ground speed in kts
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

	local SuperSonic = IAS / baseData.getMachNumber()
	transonicLower:set(SuperSonic * .95)
	transonicUpper:set(SuperSonic * 1.05)

	HUD_MACH = baseData.getMachNumber() * .1

	if HUD_MACH < .995 then
		HUD_MACH = HUD_MACH * 1000
	end

	machWhole:set(baseData.getMachNumber())
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
	if AT:get() == 1 and (get_param_handle("CURRENT_PHASE_LO"):get() > 0 or get_param_handle("CURRENT_PHASE_PAL"):get() > 0) then
		if Autothrottle_mode == 12 then
			AT_MODE:set(.5)
		elseif Autothrottle_mode == 14 then
			AT_MODE:set(1)
		end
	elseif get_param_handle("CURRENT_PHASE_LO"):get() < 1 or get_param_handle("CURRENT_PHASE_PAL"):get() < 1 or AT:get() < .5 then
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