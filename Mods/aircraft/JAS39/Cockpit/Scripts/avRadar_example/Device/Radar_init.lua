dofile(LockOn_Options.script_path .. "utils.lua")

--[[
-- Path to your DLL files folder
local dll_path = LockOn_Options.script_path:gsub("([^/]+/[^/]+/)$", "") .. "bin/" -- gsub removes "Cockpit\Script\" from the end


local function load_dll()
	package.cpath = package.cpath .. ";" .. dll_path .. "/?.dll"
	local success, result = pcall(require, "Avionics") -- DLL files name
	if not success then
		print_message_to_user("Avionics DLL failed to load from: " .. dll_path)
	end
	return result
end

local Avionics = load_dll()
print_message_to_user(tostring(Dump(Avionics)))
--]]



-- Variables from avDevice/other globals/init
local updateTimeStep = 1 / 60
make_default_activity(updateTimeStep)

local simpleRadar = GetSelf()

local baseData = get_base_data()


-- Param handles
local radar = {
	-- Standard from avSimpleRadar (CAPITALIZED):
	RADAR_TDC_RANGE             = get_param_handle("RADAR_TDC_RANGE"),          -- =WRITE= TDC range in meters
	RADAR_TDC_AZIMUTH           = get_param_handle("RADAR_TDC_AZIMUTH"),        -- =WRITE= TDC azimuth in radians
	RADAR_TDC_RANGE_CARRET_SIZE = get_param_handle("RADAR_TDC_RANGE_CARRET_SIZE"), -- =WRITE= Range sensitivity of TDC in meters. Larger value: Less range precision needed to lock, default: 6000

	-- STT params moved to the STTContact table below.
	-- RADAR_STT_AZIMUTH   = get_param_handle("RADAR_STT_AZIMUTH"), -- =READ= Azimuth to STT target in radians, normalized with roll
	-- RADAR_STT_ELEVATION = get_param_handle("RADAR_STT_ELEVATION"), -- =READ= Elevation to STT target in radians, normalized with roll
	-- RADAR_STT_RANGE     = get_param_handle("RADAR_STT_RANGE"),  -- =READ= Range to STT target in meters
	-- RADAR_STT_FRIENDLY  = get_param_handle("RADAR_STT_FRIENDLY"), -- =READ= IFF status of target. -1: IFF is off, 0: Hostile or unknown, 1: Friendly

	RADAR_MODE = get_param_handle("RADAR_MODE"),                        -- =READ= 1: Searching, 2: Attempting lock, 3: STT lock
	IFF_INTERROGATOR_STATUS = get_param_handle("IFF_INTERROGATOR_STATUS"), -- =WRITE= 0: IFF off, 1: IFF on

	SCAN_ZONE_ORIGIN_AZIMUTH = get_param_handle("SCAN_ZONE_ORIGIN_AZIMUTH"),  -- =WRITE= Azimuth angle of the radar antenna in radians
	SCAN_ZONE_ORIGIN_ELEVATION = get_param_handle("SCAN_ZONE_ORIGIN_ELEVATION"), -- =WRITE= Elevation angle of the radar antenna in radians

	SCAN_ZONE_VOLUME_AZIMUTH = get_param_handle("SCAN_ZONE_VOLUME_AZIMUTH"),  -- =WRITE= Total scan zone width in radians?
	SCAN_ZONE_VOLUME_ELEVATION = get_param_handle("SCAN_ZONE_VOLUME_ELEVATION"), -- =WRITE= Total scan zone height in radians? (higher value than perfomance.scan_beam will req. the rdr to make multiple sweeps to scan the desired scan area)

	RADAR_PITCH_BANK_STABILIZATION = get_param_handle("RADAR_PITCH_BANK_STABILIZATION"), -- =WRITE= 0: Combined stab. off, 1: Combined stab. on (see below)
	RADAR_PITCH_STABILIZATION      = get_param_handle("RADAR_PITCH_STABILIZATION"),   -- =WRITE= 0: Pitch stab. off, 1: Pitch stab. on - keeps rdr pointed at horizon as A/C pitches (within perfomance.pitch_compensation_limits)
	RADAR_BANK_STABILIZATION       = get_param_handle("RADAR_BANK_STABILIZATION"),    -- =WRITE= 0: Roll stab. off, 1: Roll stab. on - keeps rdr pointed at horizon as A/C rolls (within perfomance.roll_compensation_limits)

	ACQUSITION_ZONE_VOLUME_AZIMUTH = get_param_handle("ACQUSITION_ZONE_VOLUME_AZIMUTH"), -- =WRITE= Azimuthal tolerance of TDC in radians for acquisition (unverified), default: 0.087266 (5 degrees)

	SCAN_VOLUME_CUT_OFF_DISTANCE_MAX = get_param_handle("SCAN_VOLUME_CUT_OFF_DISTANCE_MAX"), -- =WRITE= Max distance for contact in meters (unverified), default: FLT_MAX
	SCAN_VOLUME_CUT_OFF_DISTANCE_MIN = get_param_handle("SCAN_VOLUME_CUT_OFF_DISTANCE_MIN"), -- =WRITE= Min distance for contact in meters (unverified), default: -FLT_MAX

	RADAR_BIT = get_param_handle("RADAR_BIT"), -- Unkown

	CLOSEST_RANGE_RESPONSE = get_param_handle("CLOSEST_RANGE_RESPONSE") -- Unkown, glithces between really large numbers

	-- Custom (camelCase):
}

local contacts = {}
for n = 1, 99 do
	local i
	local contactSTR

	if n < 10 then
		i = "_0" .. n .. "_"
	else
		i = "_" .. n .. "_"
	end

	contactSTR = "RADAR_CONTACT" .. i

	contacts[n] = {
		-- Standard from avSimpleRadar (CAPITALIZED):
		AZIMUTH = get_param_handle(contactSTR .. "AZIMUTH"), -- Azimuth of the contact in radians
		ELEVATION = get_param_handle(contactSTR .. "ELEVATION"), -- Elevation of the contact in radians
		FRIENDLY = get_param_handle(contactSTR .. "FRIENDLY"), -- Coalition of contact (-1 = unk (IFF off), 0 = Enemy, 1 = Friend)
		NCTR = get_param_handle(contactSTR .. "NCTR"),     -- Full DCS name of contact (ex: E-3A, MOSCOW)
		NOISE = get_param_handle(contactSTR .. "NOISE"),   -- Value that changes with ground clutter, ECM etc
		RANGE = get_param_handle(contactSTR .. "RANGE"),   -- Range to contact in meters
		RCS = get_param_handle(contactSTR .. "RCS"),       -- Radar Cross Section of contact in m^2
		RCS_COEFF = get_param_handle(contactSTR .. "RCS_COEFF"), -- Changes final_RCS as a multiplier of RCS that changes with ECM etc
		RND = get_param_handle(contactSTR .. "RND"),       -- Unknown
		TIME = get_param_handle(contactSTR .. "TIME"),     -- Time since detection
		VX = get_param_handle(contactSTR .. "VX"),         -- Velocity X in m/s
		VY = get_param_handle(contactSTR .. "VY"),         -- Velocity Y (VS) in m/s
		VZ = get_param_handle(contactSTR .. "VZ"),         -- Velocity Z in m/s

		-- Custom:
		priority = get_param_handle(contactSTR .. "priority"), -- Priority of contact (0-4) 0 = non priority
		vel = get_param_handle(contactSTR .. "vel"), -- Velocity in kts
		horVel = get_param_handle(contactSTR .. "horVel"), -- Hozisontal velocity in kts
		relHdg = get_param_handle(contactSTR .. "relHdg"), -- Heading of contact
		RDX = get_param_handle(contactSTR .. "RDX"),       -- X coordinate of contact on RD
		RDY = get_param_handle(contactSTR .. "RDY"),       -- Y coordinate of contact on RD
		RDVelvecX = get_param_handle(contactSTR .. "RDVelvecX"), -- Length of contact velocity vector on x-axis on RD
		RDVelvecY = get_param_handle(contactSTR .. "RDVelvecY"), -- Length of contact velocity vector on y-axis on RD
		RDVelvec = get_param_handle(contactSTR .. "RDVelvec"), -- Length of contact velocity vector on RD
		BSX = get_param_handle(contactSTR .. "BSX"),
		BSY = get_param_handle(contactSTR .. "BSY"),
		BSVelvec = get_param_handle(contactSTR .. "BSVelvec"),
		BSHdg = get_param_handle(contactSTR .. "BSHdg"),
		alt = get_param_handle(contactSTR .. "alt"),
		altK = get_param_handle(contactSTR .. "altK"), -- Length of contact velocity vector on RD
		altScpRange = get_param_handle(contactSTR .. "altScpRange"),
		pitch = get_param_handle(contactSTR .. "pitch"),
		altScpVelvec = get_param_handle(contactSTR .. "altScpVelvec"),
		selfAltFt = 0,
		selfPitch = 0,
		antennaEl = get_param_handle(contactSTR .. "antennaEl"),
		prevTime = 11,
		HUDEl = get_param_handle(contactSTR .. "HUDEl"),
		isFresh = get_param_handle(contactSTR .. "isFresh"),
		prevAz = 0,
		prevAzVel = 0
	}
end

local STTContactSTR = "RADAR_STT_"
local STTContact = {
	-- Standard from avSimpleRadar (CAPITALIZED):
	AZIMUTH = get_param_handle(STTContactSTR .. "AZIMUTH"),  -- Azimuth of the contact in radians
	ELEVATION = get_param_handle(STTContactSTR .. "ELEVATION"), -- Elevation of the contact in radians
	FRIENDLY = get_param_handle(STTContactSTR .. "FRIENDLY"), -- Coalition of contact (-1 = unk (IFF off), 0 = Enemy, 1 = Friend)
	RANGE = get_param_handle(STTContactSTR .. "RANGE"),      -- Range to contact in meters

	-- Custom:
	vel = get_param_handle(STTContactSTR .. "vel"), -- Velocity in kts
	-- horVel = get_param_handle(STTContactSTR .. "horVel"), -- Hozisontal velocity in kts
	azimuthdegrees = get_param_handle(STTContactSTR .. "azimuthdegrees"), -- Azimuth of contact in degrees
	relHdg = get_param_handle(STTContactSTR .. "relHdg"),    -- Heading of contact
	RANGEnmi = get_param_handle(STTContactSTR .. "RANGEnmi"),      -- Range to contact in nautical miles
	RDX = get_param_handle(STTContactSTR .. "RDX"),          -- X coordinate of contact on RD
	RDY = get_param_handle(STTContactSTR .. "RDY"),          -- Y coordinate of contact on RD
	RDVelvecX = get_param_handle(STTContactSTR .. "RDVelvecX"), -- Length of contact velocity vector on x-axis on RD
	RDVelvecY = get_param_handle(STTContactSTR .. "RDVelvecY"), -- Length of contact velocity vector on y-axis on RD
	RDVelvec = get_param_handle(STTContactSTR .. "RDVelvec"), -- Length of contact velocity vector on RD
	BSX = get_param_handle(STTContactSTR .. "BSX"),
	BSY = get_param_handle(STTContactSTR .. "BSY"),
	BSVelvec = get_param_handle(STTContactSTR .. "BSVelvec"),
	BSHdg = get_param_handle(STTContactSTR .. "BSHdg"),
	alt = get_param_handle(STTContactSTR .. "alt"), -- contact altitude in meters
	altnmi = get_param_handle(STTContactSTR .. "altnmi"), -- contact altitude in nautical miles
	altK = get_param_handle(STTContactSTR .. "altK"), -- Length of contact velocity vector on RD
	altScpRange = get_param_handle(STTContactSTR .. "altScpRange"),
	pitch = get_param_handle(STTContactSTR .. "pitch"),
	altScpVelvec = get_param_handle(STTContactSTR .. "altScpVelvec"),
	selfAltFt = 0,
	selfPitch = 0,
	antennaEl = get_param_handle(STTContactSTR .. "antennaEl"),
	prevTime = 11,
	HUDEl = get_param_handle(STTContactSTR .. "HUDEl"),
	isFresh = get_param_handle(STTContactSTR .. "isFresh"),
	prevAz = 0,
	prevAzVel = 0,
	altitude = get_param_handle(STTContactSTR .. "altitude") -- alitude in nautical miles
}

local MAX_FILTERED = 99 

local filteredContacts = {}
for n = 1, MAX_FILTERED do
	local fi
	if n < 10 then
		fi = "_0" .. n .. "_"
	else
		fi = "_" .. n .. "_"
	end
	local filteredSTR = "FILTERED_CONTACT" .. fi

	filteredContacts[n] = {
		FRESH = get_param_handle(filteredSTR .. "FRESH"),       -- 1 = active track, 0 = empty slot
		AZIMUTH = get_param_handle(filteredSTR .. "AZIMUTH"),   -- smoothed, radians
		RANGE = get_param_handle(filteredSTR .. "RANGE"),       -- smoothed, meters
		FRIENDLY = get_param_handle(filteredSTR .. "FRIENDLY"),
		BSX = get_param_handle(filteredSTR .. "BSX"),
		BSY = get_param_handle(filteredSTR .. "BSY"),
		BSHdg = get_param_handle(filteredSTR .. "BSHdg"),
		VX = get_param_handle(filteredSTR .. "VX"),
		VY = get_param_handle(filteredSTR .. "VY"),
		VZ = get_param_handle(filteredSTR .. "VZ"),
		PRIORITY = get_param_handle(filteredSTR .. "PRIORITY"),
		isFresh = get_param_handle(filteredSTR .. "isFresh"),


		
		active = false,
		az = 0,
		range = 0,
		vx = 0,
		vy = 0,
		vz = 0,
		framesSinceMatch = 0
	}
end

local gateAngle = math.rad(5)  -- matching gate — degrees converted to radians
local gateRangeMeters = 3000     -- matching gate — meters
local blendFactor = 1          -- position smoothing speed; higher = snappier, lower = smoother/laggier
local trackTimeoutFrames = 60   -- ~3s at 60fps before an unmatched track is dropped
local myspeed = get_param_handle("SPEEDOMETER_IAS")




local CDScale = get_param_handle("CDScale")
local RDRFullRange = get_param_handle("RDRFullRange")
local RDRElLimUpperX = get_param_handle("RDRElLimUpperX")
local RDRElLimUpperY = get_param_handle("RDRElLimUpperY")
local RDRElLimLowerX = get_param_handle("RDRElLimLowerX")
local RDRElLimLowerY = get_param_handle("RDRElLimLowerY")

local radarScopeMode = get_param_handle("radarScopeMode")

local SnappedContactNum = get_param_handle("SnappedContactNum")
local nextpriority = get_param_handle("nextpriority")

-- Constants
local NMI_TO_M = 1852
local M_TO_NMI = .000539956803
local M_TO_FT = 3.28083989501312335958
local MS_TO_KTS = 1.94384449
local NMI_TO_FEET = NMI_TO_M * M_TO_FT
local FT_TO_NMI = 1 / NMI_TO_FEET
local TWOPI = 2 * math.pi
local HALFPI = math.pi / 2


-- Variables
local scanAzimuthAngle = 60
local scanElevationAngle = 60
local detectionDist = 670820
local elSettings = {2.5, 5, 10}

local RDRAltScpW = 1.707094 / 2
local elLimMult = FT_TO_NMI * RDRAltScpW

local RDMult = 1.725 -- 1.725

local selfAltFt, selfPitch
local distFromTop, elLimUpper, elLimLower


-- ==From avSimpleRadar==
device_timer_dt   = updateTimeStep
power_bus_handle  = "ONE"
render_debug_info = false -- Doesn't work in MT

local heading = get_param_handle("HEADING")
local heading180 = get_param_handle("HEADING180")

perfomance = {
	tracking_azimuth = {-math.rad(scanAzimuthAngle), math.rad(scanAzimuthAngle)}, -- once locked, max azimuth to track

	roll_compensation_limits  = {-math.rad(180), math.rad(180)}, -- limits for RADAR_BANK_STABILIZATION
	pitch_compensation_limits = {-math.rad(30), math.rad(30)}, -- limits for RADAR_PITCH_STABILIZATION (when pitch is outside these values the scan zone will stop staying level with horizon)
	scan_volume_azimuth       = math.rad(2 * scanAzimuthAngle), -- is left+right so 120 deg is +-60 deg left/right
	scan_volume_elevation     = math.rad(2 * scanElevationAngle), -- limits search angle of radar +-5 up/down
	scan_beam                 = math.rad(scanElevationAngle / 2), -- 3, height of scan beam, max should be scan_volume_elevation (if less then it will do passes at different elevations)
	max_available_distance    = detectionDist,                 -- max distance (in Meters) for object with large (>100m^2) radar cross section, for smaller RCS such as Su-27 the actual detection distance will be much less


	-- scan_speed = math.rad(2 * 60), -- unknown (doesn't affect debug scan beam) ==Not found in CockpitBase.dll==
	-- dead_zone = 200.0, -- unknown. doesn't seem to be distance between targets or distance from radar to target ==Not found in CockpitBase.dll==


	ground_clutter =
	{ -- spot RCS = A + B * random + C * random
		sea          = {0, 0, 0},
		land         = {0, 0, 0},
		artificial   = {0, 0, 0},
		max_distance = detectionDist
		-- rays_density = .01
	}



	-- tracking_elevation        = {-math.rad(scanElevationAngle), math.rad(scanElevationAngle)}, -- once locked, max elevation to track ==Not found in CockpitBase.dll==
}
-- ==From avSimpleRadar==

local contactDebugTimer = 0

local function updateBaseData()
	selfAltFt = baseData.getBarometricAltitude() * M_TO_FT
	selfPitch = baseData.getPitch()
end

function post_initialize()
	simpleRadar:set_power(true)

	simpleRadar:listen_command(100)
	simpleRadar:listen_command(139) -- scanzone left
	simpleRadar:listen_command(140) -- scanzone right
	simpleRadar:listen_command(141) -- scanzone up
	simpleRadar:listen_command(142) -- scanzone down
	simpleRadar:listen_command(394) -- change PRF (radar puls freqency)
	simpleRadar:listen_command(509) -- lock start
	simpleRadar:listen_command(510) -- lock finish
	simpleRadar:listen_command(285) -- Change radar mode RWS/TWS
	simpleRadar:listen_command(2025)
	simpleRadar:listen_command(2026)
	simpleRadar:listen_command(2031)
	simpleRadar:listen_command(2032)

	-- print_message_to_user("Radar - INIT")


	radar.RADAR_PITCH_BANK_STABILIZATION:set(1)
	radar.RADAR_PITCH_STABILIZATION:set(1)
	radar.RADAR_BANK_STABILIZATION:set(1)
	radar.IFF_INTERROGATOR_STATUS:set(1)
	radar.SCAN_ZONE_VOLUME_ELEVATION:set(math.rad(elSettings[1]) * 2)
	-- radar.SCAN_ZONE_VOLUME_ELEVATION:set(math.rad(120))

	radar.RADAR_TDC_RANGE:set(0)
	radar.RADAR_TDC_AZIMUTH:set(0)
	radar.RADAR_TDC_RANGE_CARRET_SIZE:set(12000)
end


local Cursor_X = get_param_handle("Cursor_X")
local Cursor_Y = get_param_handle("Cursor_Y")
local scpsize = 1.6 / 2
local scopeHalfExtent = 0.8
local roll = get_param_handle("BASE_SENSOR_ROLL"):get()
local snappedContactIndex = nil
local snapGate = 0.05


function update()

	local myspeed = get_param_handle("SPEEDOMETER_IAS"):get() * 1.94384449
	local myspeedratio = 1 + (myspeed / 1100)
	local gateRangeMeters = 3000 * myspeedratio     -- matching gate — meters

	local function computeBscopePos(az, rangeNM)
		local bsAzLimit = perfomance.scan_volume_azimuth / 2
		local bsMaxRange = RDRFullRange:get()

		local x = (az / bsAzLimit) * scopeHalfExtent
		local y = (rangeNM / bsMaxRange) * (scopeHalfExtent * 2)/1.2

		x = math.max(-scopeHalfExtent, math.min(scopeHalfExtent, x))
		-- y = math.max(0, math.min(scopeHalfExtent * 2, y))

		return x, y
	end
	
	STTContact.altnmi:set(STTContact.alt:get() * M_TO_NMI)
	STTContact.RANGEnmi:set(STTContact.RANGE:get() * M_TO_NMI)
	STTContact.azimuthdegrees:set(math.deg(STTContact.AZIMUTH:get()) % 360)
	local newEL = (STTContact.AZIMUTH:get() * math.cos(-roll) + STTContact.ELEVATION:get() * math.sin(-roll))

	get_param_handle("STT_RDX_Clamped"):set(math.min(math.max(STTContact.RDX:get(), -0.7825), 0.7825))

	if get_param_handle("HEADING"):get() > 180 then
		get_param_handle("HEADING180"):set(get_param_handle("HEADING"):get() - 360)
	else
		get_param_handle("HEADING180"):set(get_param_handle("HEADING"):get())
	end
	get_param_handle("HEADINGoffset"):set(get_param_handle("HEADING"):get() + 360)

	STTContact.altitude:set(
		(get_param_handle("GPSalt"):get()*FT_TO_NMI) + 
		(STTContact.RANGEnmi:get() * math.sin(newEL - get_param_handle("BASE_SENSOR_PITCH"):get())
			)
		)



	if get_param_handle("RDRScopeMode"):get() == 1 then
		local tdcAz = radar.RADAR_TDC_AZIMUTH:get()
		local tdcRangeNM = radar.RADAR_TDC_RANGE:get() * M_TO_NMI

		local cx, cy = computeBscopePos(tdcAz, tdcRangeNM)



		-- contact filter

		local function angleDifference(a, b)
			return math.abs((a - b + math.pi) % (2 * math.pi) - math.pi)
		end



		local function angleDifference(a, b)
			return math.abs((a - b + math.pi) % (2 * math.pi) - math.pi)
		end


		--finds which ones fit to a already filtered contact

		local rawClaimed = {}

		for n = 1, MAX_FILTERED do

			local ft = filteredContacts[n]

			if ft.active then

				local bestRaw = nil
				local bestScore = math.huge

				for i = 1, 99 do

					local c = contacts[i]

					if c.TIME:get() > 0 then

						local rawAz = c.AZIMUTH:get()
						local rawRange = c.RANGE:get()

						local dAz =
							angleDifference(rawAz, ft.az)

						local dRange =
							math.abs(rawRange - ft.range)


						-- Matching zone
						if dAz <= gateAngle
						and dRange <= gateRangeMeters then

							-- Find the closest raw detection
							local score =
								(dAz / gateAngle) ^ 2 +
								(dRange / gateRangeMeters) ^ 2

							if score < bestScore then
								bestScore = score
								bestRaw = i
							end
						end
					end
				end




				if bestRaw then

					local c = contacts[bestRaw]

					rawClaimed[bestRaw] = true


					-- Immediately replace filtered data
					ft.az = c.AZIMUTH:get()
					ft.range = c.RANGE:get()

					ft.vx = c.VX:get()
					ft.vy = c.VY:get()
					ft.vz = c.VZ:get()


					-- Update parameters
					ft.AZIMUTH:set(ft.az)
					ft.RANGE:set(ft.range)

					ft.FRIENDLY:set(
						c.FRIENDLY:get()
					)

					ft.VX:set(ft.vx)
					ft.VY:set(ft.vy)
					ft.VZ:set(ft.vz)


					-- Contact was seen
					ft.framesSinceMatch = 0


				else

					-- No raw detection matched this track
					ft.framesSinceMatch =
						ft.framesSinceMatch + 1


					-- Keep contact for 3 seconds
					if ft.framesSinceMatch > trackTimeoutFrames then

						ft.active = false
						ft.FRESH:set(0)

					end
				end
			end
		end


		-- checks which ones fit

		for i = 1, 99 do

			local c = contacts[i]

			if c.TIME:get() > 0
			and not rawClaimed[i] then

				local belongsToExisting = false

				for n = 1, MAX_FILTERED do

					local ft = filteredContacts[n]

					if ft.active then

						local dAz =
							angleDifference(
								c.AZIMUTH:get(),
								ft.az
							)

						local dRange =
							math.abs(
								c.RANGE:get() -
								ft.range
							)


						if dAz <= gateAngle
						and dRange <= gateRangeMeters then

							belongsToExisting = true
							break

						end
					end
				end


				-- prevents it from creating another target
				if belongsToExisting then
					rawClaimed[i] = true
				end
			end
		end


		-- makes new contact for ones which dont fit

		for i = 1, 99 do

			local c = contacts[i]

			if c.TIME:get() > 0
			and not rawClaimed[i] then

				for n = 1, MAX_FILTERED do

					local ft = filteredContacts[n]

					if not ft.active then

						-- makes new filtered track
						ft.active = true

						ft.az =
							c.AZIMUTH:get()

						ft.range =
							c.RANGE:get()

						ft.vx =
							c.VX:get()

						ft.vy =
							c.VY:get()

						ft.vz =
							c.VZ:get()

						ft.framesSinceMatch = 0


						-- Output parameters
						ft.FRESH:set(1)

						ft.AZIMUTH:set(ft.az)
						ft.RANGE:set(ft.range)

						ft.FRIENDLY:set(
							c.FRIENDLY:get()
						)

						ft.VX:set(ft.vx)
						ft.VY:set(ft.vy)
						ft.VZ:set(ft.vz)

						ft.PRIORITY:set(0)



						rawClaimed[i] = true

						break
					end
				end
			end
		end


		-- gives each ones its position(used to combine filtered + unfiltered but that didnt work so it just copies the new data)
		-- for now this snaps to the raw data instead of the filtered data
		for n = 1, MAX_FILTERED do

			local ft = filteredContacts[n]

			if ft.active then

				-- Current B-scope position
				local bx, by =
					computeBscopePos(
						ft.az,
						ft.range * M_TO_NMI
					)

				ft.BSX:set(bx)
				ft.BSY:set(by)


				-- Horizontal velocity
				local horVel =
					math.sqrt(
						ft.vx^2 +
						ft.vz^2
					)


				local ownHdg =
					baseData.getHeading()


				local relHdgVal =
					TWOPI -
					(math.atan2(ft.vx, ft.vz) + HALFPI) -
					ownHdg


				local predictSeconds = 20


				-- Current relative position
				local relX =
					math.sin(ft.az) *
					ft.range

				local relZ =
					math.cos(ft.az) *
					ft.range


				-- Relative velocity
				local velRelX =
					horVel *
					math.sin(relHdgVal)

				local velRelZ =
					horVel *
					math.cos(relHdgVal)


				-- Predicted position
				local predRelX =
					relX +
					velRelX *
					predictSeconds

				local predRelZ =
					relZ +
					velRelZ *
					predictSeconds


				-- Predicted range
				local predRange =
					math.sqrt(
						predRelX^2 +
						predRelZ^2
					)


				-- Predicted azimuth
				local predAz =
					math.atan2(
						predRelX,
						predRelZ
					)


				-- Predicted B-scope position
				local bx2, by2 =
					computeBscopePos(
						predAz,
						predRange * M_TO_NMI
					)


				-- Predicted heading
				ft.BSHdg:set(
					math.atan2(
						-(bx2 - bx),
						by2 - by
					)
				)
			end
		end

		-- snapping to contacts
		if snappedContactIndex then
			local sc = contacts[snappedContactIndex]
			if sc.TIME:get() <= 0 or sc.isFresh:get() ~= 1 then
				snappedContactIndex = nil -- contact gone
			else
				local dx = cx - sc.BSX:get()
				local dy = cy - sc.BSY:get()
				if math.sqrt(dx * dx + dy * dy) > snapGate then
				snappedContactIndex = nil -- moved cursor too far away
				end
			end
		end

		-- the thing which actually snaps to the contact
		if not snappedContactIndex then
			local bestDist = snapGate
			for i = 1, 99 do
				local c = contacts[i]
				if c.TIME:get() > 0 and c.isFresh:get() == 1 then
					local dx = cx - c.BSX:get()
					local dy = cy - c.BSY:get()
					local dist = math.sqrt(dx * dx + dy * dy)
					if dist < bestDist then
						bestDist = dist
						snappedContactIndex = i
					end
				end
			end
		end

		-- output
		if snappedContactIndex then
			local sc = contacts[snappedContactIndex]
			cx = sc.BSX:get()
			cy = sc.BSY:get()
		end

		SnappedContactNum:set(snappedContactIndex or -1)

		Cursor_X:set(cx)
		get_param_handle("Cursor_X_Clamped"):set(math.min(math.max(cx, -0.7825), 0.7825))
		Cursor_Y:set(cy)
	end


	updateBaseData()


	--------------------
	-- Altitude scope --
	--------------------

	-- Elevation limits
	distFromTop = 60000 - selfAltFt

	elLimUpper = Math.cot(math.pi / 3 + selfPitch)
	if elLimUpper < 0 and selfPitch < 0 then
		RDRElLimUpperX:set(math.abs((elLimUpper * distFromTop * elLimMult) / RDRFullRange:get()))
		RDRElLimUpperY:set(-selfAltFt)
	else
		RDRElLimUpperX:set((elLimUpper * distFromTop * elLimMult) / RDRFullRange:get())
		RDRElLimUpperY:set(distFromTop)
	end

	elLimLower = Math.cot(math.pi / 3 - selfPitch)
	if elLimLower < 0 and selfPitch > 0 then
		RDRElLimLowerX:set(math.abs((elLimLower * selfAltFt * elLimMult) / RDRFullRange:get()))
		RDRElLimLowerY:set(distFromTop)
	else
		RDRElLimLowerX:set((elLimLower * selfAltFt * elLimMult) / RDRFullRange:get())
		RDRElLimLowerY:set(-selfAltFt)
	end

	-- Elevation cone
	-- TODO: Fix so the cone rotation is correct with the elevation limits



	-- TDCElUpper:set(((baseData.getBarometricAltitude() + math.tan(radar.SCAN_ZONE_ORIGIN_ELEVATION:get() + (perfomance.scan_volume_elevation / 2)) * radar.RADAR_TDC_RANGE:get())) * M_TO_FT)
	-- TDCElLower:set(((baseData.getBarometricAltitude() + math.tan(radar.SCAN_ZONE_ORIGIN_ELEVATION:get() - (perfomance.scan_volume_elevation / 2)) * radar.RADAR_TDC_RANGE:get())) * M_TO_FT)

	-- get_param_handle("TDC_rng"):set(radar.RADAR_TDC_RANGE:get() * .000539956803)

	if radar.RADAR_MODE:get() == 1 then
		local relPositions = {}

		for i = 1, 99 do
			local contact = contacts[i]
			local rawAz = contact.AZIMUTH:get()
			local rawEl = contact.ELEVATION:get()
			local rawRange = contact.RANGE:get()
			local rawTime = contact.TIME:get()

			local horDist = math.cos(rawEl) * rawRange
			local relX = math.sin(rawAz) * horDist
			local relZ = math.cos(rawAz) * horDist
			local relY = math.sin(rawEl) * rawRange

			if i == get_param_handle("SnappedContactNum"):get() and nextpriority:get() == 1 then
				contact.priority:set(1)
				nextpriority:set(0)
			end

			relPositions[i] = {x = relX, y = relY, z = relZ, active = rawTime > 0}
		end

		local dupDistanceMeters = 2

		for i = 1, 99 do
			local isDup = false

			if relPositions[i].active then
				for j = i + 1, 99 do
					if relPositions[j].active then
						local dx = relPositions[i].x - relPositions[j].x
						local dy = relPositions[i].y - relPositions[j].y
						local dz = relPositions[i].z - relPositions[j].z
						local dist = math.sqrt(dx * dx + dy * dy + dz * dz)

						if dist < dupDistanceMeters then
							isDup = true
							break
						end
					end
				end
			end

			contacts[i].isFresh:set((isDup or contacts[i].TIME:get() > 2 or contacts[i].TIME:get() == -1) and 0 or 1)
		end


		for i = 1, 99 do
			local contact = contacts[i]

			local rawAz    = contact.AZIMUTH:get()
			local rawEl    = contact.ELEVATION:get()
			-- local rawFriend   = contact.FRIENDLY:get()
			-- local rawNCTR     = contact.NCTR:get()
			-- local rawNoise    = contact.NOISE:get()
			local rawRange = contact.RANGE:get()
			-- local rawRCS      = contact.RCS:get()
			-- local rawRCSCoeff = contact.RCS_COEFF:get()
			-- local rawRND      = contact.RND:get()
			local rawTime  = contact.TIME:get()
			local rawVX    = contact.VX:get()
			local rawVY    = contact.VY:get()
			local rawVZ    = contact.VZ:get()



			local bsAzLimit = perfomance.scan_volume_azimuth / 2

			local bsMaxRange = RDRFullRange:get()

			local bx, by = computeBscopePos(rawAz, rawRange * M_TO_NMI)
			contact.BSX:set(bx)
			contact.BSY:set(by)



			--[[if contactDebugTimer <= 0 then
    		print_message_to_user(string.format(
        		"C%d: TIME=%.3f  FRIENDLY=%.0f  BSX=%.3f  BSY=%.3f",
        		i, contact.TIME:get(), contact.FRIENDLY:get(), contact.BSX:get(), contact.BSY:get()
    		))
		end]]


			if rawTime > 0 then
				local ownHdg = baseData.getHeading()
				-- local selfX, selfY, selfZ = baseData.getSelfCoordinates()

				local horVel, horVelKts, displayZoom, alt, u_hat, v_xz, v_hy, corrEl -- , deltaCX, deltaCZ, contactX, contactZ, dx, dz



				if rawTime < contact.prevTime then
					contact.selfAltFt = baseData.getBarometricAltitude()
					contact.selfPitch = baseData.getPitch()
					contact.antennaEl:set(radar.SCAN_ZONE_ORIGIN_ELEVATION:get())
				end

				corrEl = rawEl + math.tan(contact.antennaEl:get())
				contact.HUDEl:set(corrEl) -- + (contact.selfPitch - baseData.getPitch())) -- Why tf isn't this working

				horVel = math.sqrt(rawVX^2 + rawVZ^2)
				horVelKts = horVel * MS_TO_KTS
				-- contact.horVel:set(horVelKts)


				-- contact.vel:set(math.sqrt(horVelKts^2 + (rawVY * MS_TO_KTS)^2))

				local relHdgVal = TWOPI - (math.atan2(rawVX, rawVZ) + HALFPI) - ownHdg
				contact.relHdg:set(relHdgVal)

				-- Predicted-heading line for the B-scope
				local predictSeconds = 20 -- how far ahead to project

				local relX = math.sin(rawAz) * rawRange
				local relZ = math.cos(rawAz) * rawRange

				local velRelX = horVel * math.sin(relHdgVal)
				local velRelZ = horVel * math.cos(relHdgVal)

				local predRelX = relX + velRelX * predictSeconds
				local predRelZ = relZ + velRelZ * predictSeconds

				local predRange = math.sqrt(predRelX^2 + predRelZ^2)
				local predAz = math.atan2(predRelX, predRelZ)

				local bx2, by2 = computeBscopePos(predAz, predRange * M_TO_NMI)

				contact.BSHdg:set(math.atan2(-(bx2 - bx), by2 - by))

				-- deltaCX = math.cos(rawAz + math.pi / 2) * rawRange
				-- contactX = selfX - deltaCX
				-- deltaCZ = math.sin(rawAz + math.pi / 2) * rawRange
				-- contactZ = selfZ - deltaCZ
				-- dx = math.cos(ownHdg) * -deltaCZ - math.sin(ownHdg) * deltaCX
				-- dz = math.cos(ownHdg) * deltaCX + math.sin(ownHdg) * deltaCZ



				if radarScopeMode:get() == 1 then
					displayZoom = CDScale:get() * RDMult

					contact.RDX:set((math.cos(-rawAz + HALFPI) * rawRange) / displayZoom)
					contact.RDY:set((math.sin(-rawAz + HALFPI) * rawRange) / displayZoom)

					contact.RDVelvec:set((horVel * 30) / displayZoom)
				elseif radarScopeMode:get() == 2 then
					displayZoom = CDScale:get()
					-- local bx, by = computeBscopePos(rawAz, rawRange * M_TO_NMI)
					local bx, by = computeBscopePos(rawAz, rawRange * M_TO_NMI) -- TODO: Fix so this uses the cursorGain stuff
					contact.RDX:set(bx)
					contact.RDY:set(by)

					--[[
				local deltaAz = rawAz - contact.prevAz
				local angularVelocity

				if deltaAz ~= 0 then
					-- printButBetter("a", "RC" .. i)
					contact.prevAz = rawAz
					
					angularVelocity = deltaAz / updateTimeStep --[rad/s]
					contact.prevAzVel = angularVelocity
				else
					-- printButBetter("b", "RC" .. i)
					angularVelocity = contact.prevAzVel
				end
				
				--(math.sqrt(angularVelocity^2 + (rawVZ * M_TO_NMI)^2) * 30) / displayZoom
				--]]

					local RdVelvecY = (rawVZ * M_TO_NMI * 30) / displayZoom

					contact.RDVelvecX:set(Math.cot(contact.BSHdg:get() + math.rad(90)) * RdVelvecY) -- TODO: Fix and use the commented code above, this is flawed because the value blows up at some angles. (OLD: math.rad(angularVelocity) * 30)
					contact.RDVelvecY:set(RdVelvecY)
					contact.RDVelvec:set(math.sqrt(contact.RDVelvecX:get()^2 + contact.RDVelvecY:get()^2)) -- [math.sqrt(deg^2 + nmi^2)/s]
				end

				alt = (contact.selfAltFt + math.sin(corrEl) * rawRange) * M_TO_FT -- Flawed because there's no exact pos of the contact
				contact.alt:set(alt)
				contact.altK:set(alt / 1000)


				contact.altScpRange:set((rawRange * M_TO_NMI) / CDScale:get())
				u_hat = {
					x = math.cos(ownHdg),
					y = math.sin(ownHdg)
				}

				v_xz = {
					x = rawVX,
					y = rawVZ
				}

				v_hy = {
					x = u_hat.x * v_xz.x + u_hat.y * v_xz.y,
					y = rawVY
				}

				contact.pitch:set(math.atan2(v_hy.x, v_hy.y))
				contact.altScpVelvec:set((math.sqrt(v_hy.x^2 + v_hy.y^2) * 30 * M_TO_NMI) / CDScale:get())



				contact.prevTime = rawTime
			end
		end
	elseif radar.RADAR_MODE:get() == 3 then
		local contact = STTContact

		local rawAz    = contact.AZIMUTH:get()
		local rawEl    = contact.ELEVATION:get()
		-- local rawFriend   = contact.FRIENDLY:get()
		local rawRange = contact.RANGE:get()



		local bsAzLimit = perfomance.scan_volume_azimuth / 2

		local bsMaxRange = RDRFullRange:get()

		local bx, by = computeBscopePos(rawAz, rawRange * M_TO_NMI)



		local ownHdg = baseData.getHeading()
		-- local selfX, selfY, selfZ = baseData.getSelfCoordinates()

		local horVel, horVelKts, displayZoom, alt, u_hat, v_xz, v_hy, corrEl -- , deltaCX, deltaCZ, contactX, contactZ, dx, dz


		corrEl = rawEl + math.tan(contact.antennaEl:get())
		contact.HUDEl:set(corrEl) -- + (contact.selfPitch - baseData.getPitch())) -- Why tf isn't this working

		-- horVel = math.sqrt(rawVX^2 + rawVZ^2)
		-- horVelKts = horVel * MS_TO_KTS
		-- contact.horVel:set(horVelKts)


		-- contact.vel:set(math.sqrt(horVelKts^2 + (rawVY * MS_TO_KTS)^2))

		--local relHdgVal = TWOPI - (math.atan2(rawVX, rawVZ) + HALFPI) - ownHdg
		-- contact.relHdg:set(relHdgVal)

		-- Predicted-heading line for the B-scope
		local predictSeconds = 20 -- how far ahead to project

		local relX = math.sin(rawAz) * rawRange
		local relZ = math.cos(rawAz) * rawRange

		-- local velRelX = horVel * math.sin(relHdgVal)
		-- local velRelZ = horVel * math.cos(relHdgVal)

		-- local predRelX = relX + velRelX * predictSeconds
		-- local predRelZ = relZ + velRelZ * predictSeconds

		-- local predRange = math.sqrt(predRelX^2 + predRelZ^2)
		-- local predAz = math.atan2(predRelX, predRelZ)

		-- local bx2, by2 = computeBscopePos(predAz, predRange * M_TO_NMI)

		-- contact.BSHdg:set(math.atan2(-(bx2 - bx), by2 - by))

		-- deltaCX = math.cos(rawAz + math.pi / 2) * rawRange
		-- contactX = selfX - deltaCX
		-- deltaCZ = math.sin(rawAz + math.pi / 2) * rawRange
		-- contactZ = selfZ - deltaCZ
		-- dx = math.cos(ownHdg) * -deltaCZ - math.sin(ownHdg) * deltaCX
		-- dz = math.cos(ownHdg) * deltaCX + math.sin(ownHdg) * deltaCZ



		if radarScopeMode:get() == 1 then
			displayZoom = CDScale:get() * RDMult

			contact.RDX:set((math.cos(-rawAz + HALFPI) * rawRange) / displayZoom)
			contact.RDY:set((math.sin(-rawAz + HALFPI) * rawRange) / displayZoom)

			contact.RDVelvec:set((horVel * 30) / displayZoom)
		elseif radarScopeMode:get() == 2 then
			displayZoom = CDScale:get()
			-- local bx, by = computeBscopePos(rawAz, rawRange * M_TO_NMI)
			local bx, by = computeBscopePos(rawAz, rawRange * M_TO_NMI) -- TODO: Fix so this uses the cursorGain stuff
			contact.RDX:set(bx)
			contact.RDY:set(by)

			--[[
				local deltaAz = rawAz - contact.prevAz
				local angularVelocity

				if deltaAz ~= 0 then
					-- printButBetter("a", "RC" .. i)
					contact.prevAz = rawAz
					
					angularVelocity = deltaAz / updateTimeStep --[rad/s]
					contact.prevAzVel = angularVelocity
				else
					-- printButBetter("b", "RC" .. i)
					angularVelocity = contact.prevAzVel
				end
				
				--(math.sqrt(angularVelocity^2 + (rawVZ * M_TO_NMI)^2) * 30) / displayZoom
			--]]

			-- local RdVelvecY = (rawVZ * M_TO_NMI * 30) / displayZoom

			-- contact.RDVelvecX:set(Math.cot(contact.BSHdg:get() + math.rad(90)) * RdVelvecY) -- TODO: Fix and use the commented code above, this is flawed because the value blows up at some angles. (OLD: math.rad(angularVelocity) * 30)
			-- contact.RDVelvecY:set(RdVelvecY)
			-- contact.RDVelvec:set(math.sqrt(contact.RDVelvecX:get()^2 + contact.RDVelvecY:get()^2)) -- [math.sqrt(deg^2 + nmi^2)/s]
		end

		contact.selfAltFt = baseData.getBarometricAltitude()
		alt = (contact.selfAltFt + math.sin(corrEl) * rawRange) * M_TO_FT -- Flawed because there's no exact pos of the contact
		contact.alt:set(alt)
		contact.altK:set(alt / 1000)


		contact.altScpRange:set((rawRange * M_TO_NMI) / CDScale:get())
		u_hat = {
			x = math.cos(ownHdg),
			y = math.sin(ownHdg)
		}
	end
end

function SetCommand(command, value)
	print_message_to_user(string.format("RDR SC: C: %i   V: %.8f", command, value))



	if command == 285 then
		Avionics.initContacts()
		if radar.SCAN_ZONE_VOLUME_ELEVATION:get() < math.rad(elSettings[3]) then
			radar.SCAN_ZONE_VOLUME_ELEVATION:set(radar.SCAN_ZONE_VOLUME_ELEVATION:get() * 2)
		else
			radar.SCAN_ZONE_VOLUME_ELEVATION:set(math.rad(elSettings[1]))
		end
		print_message_to_user(math.deg(radar.SCAN_ZONE_VOLUME_ELEVATION:get()))
	end

	---------------------------------------------------------------------

	if command == 141 and value == 0 then
		radar.SCAN_ZONE_ORIGIN_ELEVATION:set(radar.SCAN_ZONE_ORIGIN_ELEVATION:get() + .003)
	elseif command == 142 and value == 0 then
		radar.SCAN_ZONE_ORIGIN_ELEVATION:set(radar.SCAN_ZONE_ORIGIN_ELEVATION:get() - .003)
	end

	if command == 139 and value == 0 then
		radar.SCAN_ZONE_ORIGIN_ELEVATION:set(radar.SCAN_ZONE_ORIGIN_ELEVATION:get() + .003)
	elseif command == 140 and value == 0 then
		radar.SCAN_ZONE_ORIGIN_ELEVATION:set(radar.SCAN_ZONE_ORIGIN_ELEVATION:get() - .003)
	end

	----------------------------------------------------------------------	

	if radar.RADAR_TDC_RANGE:get() < 0 then
		radar.RADAR_TDC_RANGE:set(0)
	end

	if radar.RADAR_TDC_AZIMUTH:get() > 1.05 then
		radar.RADAR_TDC_AZIMUTH:set(1.04)
	elseif radar.RADAR_TDC_AZIMUTH:get() < -1.05 then
		radar.RADAR_TDC_AZIMUTH:set(-1.04)
	end

	-------------------------------------------------

	if command == 2032 then
		radar.RADAR_TDC_RANGE:set(radar.RADAR_TDC_RANGE:get() - value * 200000)
	end

	if command == 2031 then
		radar.RADAR_TDC_AZIMUTH:set(radar.RADAR_TDC_AZIMUTH:get() + value * 10)
	end

	if command == 88 then -- Left
		radar.RADAR_TDC_AZIMUTH:set(radar.RADAR_TDC_AZIMUTH:get() - 0.015 / 2)
	elseif command == 89 then -- Right
		radar.RADAR_TDC_AZIMUTH:set(radar.RADAR_TDC_AZIMUTH:get() + 0.015 / 2)
	end

	if command == 90 then -- Up
		radar.RADAR_TDC_RANGE:set(radar.RADAR_TDC_RANGE:get() + 600 / 2)
	elseif command == 91 then -- Down
		radar.RADAR_TDC_RANGE:set(radar.RADAR_TDC_RANGE:get() - 600 / 2)
	end
end