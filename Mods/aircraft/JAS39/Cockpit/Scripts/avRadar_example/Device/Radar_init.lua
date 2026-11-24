dofile(LockOn_Options.script_path .. "command_defs.lua")
dofile(LockOn_Options.script_path .. "utils.lua")
local lock = 0
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
		prevAzVel = 0,
		fPrevAz = 0,     -- used by the filter to spot a new radar return
		fPrevEl = 0,
		fPrevRange = 0,
		ownerTrack = 0,  -- filtered track this slot last fed
		ownerGen = 0
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

-- ============================================================
-- FILTERED CONTACTS
-- A persistent track list built from the raw radar returns.
-- Tracks are stored in WORLD coordinates (X = north, Z = east, metres),
-- so they don't care how far you move or turn between radar returns.
--
-- Every filtered contact exposes the same params as a raw contact
-- (FILTERED_CONTACT__01_AZIMUTH, ..._RANGE, ..._BSX, ..._NCTR, etc.)
-- so the draw file can point at them instead of RADAR_CONTACT_xx_*.
-- Extra params only filtered contacts have:
--   FRESH  - 1 while the track exists, 0 for an empty slot
--   WORLDX - track position in metres (north)
--   WORLDZ - track position in metres (east)
-- ============================================================

local MAX_FILTERED = 99

local filteredParamNames = {
	-- same as RADAR_CONTACT_xx_*
	"AZIMUTH", "ELEVATION", "FRIENDLY", "NCTR", "NOISE", "RANGE", "RCS", "RCS_COEFF", "RND", "TIME", "VX", "VY", "VZ",
	"vel", "horVel", "relHdg", "heading", "RDX", "RDY", "RDVelvecX", "RDVelvecY", "RDVelvec",
	"BSX", "BSY", "BSVelvec", "BSHdg", "alt", "altK", "altScpRange", "pitch", "altScpVelvec",
	"antennaEl", "HUDEl", "isFresh",
	-- filtered only
	"FRESH", "WORLDX", "WORLDZ"
}

local filteredContacts = {}
for n = 1, MAX_FILTERED do
	local fi
	if n < 10 then
		fi = "_0" .. n .. "_"
	else
		fi = "_" .. n .. "_"
	end
	local filteredSTR = "FILTERED_CONTACT_" .. fi

	local ft = {
		-- internal state (not params)
		active = false,
		worldX = 0,        -- metres, north
		worldZ = 0,        -- metres, east
		vx = 0,            -- m/s, world frame
		vy = 0,
		vz = 0,
		el = 0,            -- elevation of the last return
		nctr = "",
		age = 0,           -- seconds since the last confirmed return
		index = n,
		gen = 0,           -- changes every time this slot starts a new track
		srcSlot = 0,       -- raw slot that last fed this track
		velInit = false,   -- true once a speed has been measured
		refX = 0,          -- where the last speed measurement started (metres)
		refZ = 0,
		refT = 0,          -- and when (filterClock)

		-- needed by processContact(), same as the raw contacts
		selfAltFt = 0,
		selfPitch = 0,
		prevTime = 11
	}

	for _, name in ipairs(filteredParamNames) do
		ft[name] = get_param_handle(filteredSTR .. name)
	end

	filteredContacts[n] = ft
end

-- Filter tuning (ive got it down pretty good but i think it can be improved)
local gateDistanceMeters = 7000   -- a return within this distance of a track (in the world) joins that track
local blendFactor = 1             -- 1 = new return replaces the position, lower = smoother but laggier
local trackTimeoutSeconds = 2     -- seconds without a confirmed return before a track is dropped. Raise it if tracks flicker between scan passes
local coastTracks = true          -- keep moving a track along its velocity between returns
local nctrEmptyIsWildcard = false -- false: different NCTR never combine. true: an empty NCTR can combine with any
local HDG_SIGN = 1                -- (DONT CHANGE THIS IT DONT WORK)0 = work out which way your heading counts from how you actually fly or forces it with 1 or -1
local velocityMinInterval = 6   -- seconds between the two positions used to measure speed
local velocityBlend = 0.5         -- how much each new speed measurement counts (1 just overwrites the earlier ones, 0.5 seems the best)
local velocityMaxInterval = 8     -- a measurement spanning more than this many seconds are thrown away
local velocityMaxSpeed = 1200     -- m/s, a measurement faster than this is thrown away(this needs change)
local filterClock = 0.5             -- seconds, only used to time the speed measurements
local filterDebug = false         -- true: print the track count once a second




local CDScale = get_param_handle("CDScale")
local RDRFullRange = get_param_handle("RDRFullRange")
local RDRElLimUpperX = get_param_handle("RDRElLimUpperX")
local RDRElLimUpperY = get_param_handle("RDRElLimUpperY")
local RDRElLimLowerX = get_param_handle("RDRElLimLowerX")
local RDRElLimLowerY = get_param_handle("RDRElLimLowerY")

local radarScopeMode = get_param_handle("radarScopeMode")

local SnappedContactNum = get_param_handle("SnappedContactNum")

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

	simpleRadar:listen_command(keys.S5StageOne) -- gives a target priority
	simpleRadar:listen_command(keys.S5StageTwo) -- takes a targets priority
	simpleRadar:listen_command(keys.S1PriorityStep) -- cycles through the priority targets
	simpleRadar:listen_command(keys.S11Lock) -- locks priority target, STT for now
	
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

-- ============================================================
-- CURSOR
-- The cursor is its own thing: it has its own azimuth/range and the hat moves THAT.
-- The hat no longer touches RADAR_TDC_AZIMUTH / RADAR_TDC_RANGE. The radar's TDC is only
-- sent to the cursor when you press lock (or every frame if tdcFollowsCursor is true).
-- ============================================================
-- The cursor lives ON THE SCREEN. cursorX / cursorY are in the same units as Cursor_X / Cursor_Y,
-- so where it sits and how fast it moves don't depend on the radar's range scale at all.
-- The range scale only matters when you press lock: that converts the screen position
-- into an azimuth and range using whatever scale is selected at that moment.
local cursorX = 0
local cursorY = 0
local cursorStepX = 0.0075 / (perfomance.scan_volume_azimuth / 2) * scopeHalfExtent -- per hat press (0.0075 rad, same as before)
local cursorStepY = 0.0054                   -- per hat press (this is what 300 m was on a 40 nm scale)
local cursorXLimit = 1.04 / (perfomance.scan_volume_azimuth / 2) * scopeHalfExtent   -- left/right edge (1.04 rad, same as before)
local cursorMinY = 0                         -- bottom of the scope
local cursorMaxY = scopeHalfExtent * 2 / 1.2 -- the full-range line. Raise it if you want the cursor able to leave the top

local bscopeYDivisor = 1.2 -- shared by computeBscopePos and bscopeToPolar so they can't drift apart

-- Screen position -> azimuth (radians) and range (nautical miles) at the CURRENT range scale.
-- This is the exact inverse of computeBscopePos.
local function bscopeToPolar(x, y)
	local az = (x / scopeHalfExtent) * (perfomance.scan_volume_azimuth / 2)
	local rangeNM = y * bscopeYDivisor / (scopeHalfExtent * 2) * RDRFullRange:get()

	return az, rangeNM
end

-- Commands that mean "lock what the cursor is on". Press your lock button and read the
-- "RDR SC: C: ..." message, then keep only the number your button sends.
local lockCommands = {[509] = true, [100] = true}

-- true: RADAR_TDC_* copies the cursor every frame. Turn it on if the FIRST lock press
-- locks the old position (the radar read the TDC before this script wrote to it).
local tdcFollowsCursor = false

-- Counts down after S11 so the normal lock doesn't drag the TDC back to the cursor
local priorityLockTimer = 0

-- What the cursor is pointing at: a snapped contact's exact az/range, otherwise the free cursor
local function getCursorTarget()
	if snappedContactIndex then
		local sc = contacts[snappedContactIndex]

		if sc.TIME:get() > 0 and sc.isFresh:get() == 1 then
			return sc.AZIMUTH:get(), sc.RANGE:get()
		end
	end

	local az, rangeNM = bscopeToPolar(cursorX, cursorY)

	return az, rangeNM * NMI_TO_M
end

local function moveTDCToCursor()
	if priorityLockTimer > 0 then
		return -- a priority lock just pointed the TDC at its target, don't override it
	end

	local az, range = getCursorTarget()

	radar.RADAR_TDC_AZIMUTH:set(az)
	radar.RADAR_TDC_RANGE:set(range)
end


-- ============================================================
-- PRIORITY TARGETS (a simple pseudo TWS)
--
-- Up to MAX_PRIORITY filtered tracks can be given a priority number 1..N.
--   S5StageOne      gives the target under the cursor the next free number (1, 2, 3, 4)
--   S5StageTwo      takes the priority off the target under the cursor (the numbers close up)
--   S1PriorityStep  rotates the numbers: 1 -> N, 2 -> 1, 3 -> 2, ...
--   S11Lock         points the TDC at priority 1 and starts the lock (STT for now)
--
-- PRIORITY_CONTACT_01_* is ALWAYS the priority 1 target, _02_ the priority 2 target, and so on.
-- Each group has the same params as a filtered contact (AZIMUTH, RANGE, BSX, BSY, NCTR, WORLDX, ...) plus
--   priority - the group's number (1..N), 0 for an empty group
--   FRESH    - 1 while the group holds a target
-- NumberOfPriorityTargets says how many groups are in use.
-- ============================================================

local MAX_PRIORITY = 4              -- the most priority targets at once. Change this to change the limit (the draw file needs matching icons)
local prioritySelectGate = 0.08     -- how close (screen units) the cursor must be to a track to pick it
local priorityLockSendsCommand = true -- true: S11 also starts the radar's lock itself. false: S11 only points the TDC at the target
local priorityLockStart = 509       -- sent to the radar when S11 is pressed
local priorityLockFinish = 510      -- sent to the radar when S11 is released
local priorityLockHold = 0.5        -- seconds after S11 during which the normal lock won't move the TDC back to the cursor

local priorityTargets = {}
for k = 1, MAX_PRIORITY do
	local sfx
	if k < 10 then
		sfx = "_0" .. k .. "_"
	else
		sfx = "_" .. k .. "_"
	end
	local prioritySTR = "PRIORITY_CONTACT" .. sfx

	local pt = {
		active = false,   -- true while this group holds a target
		trackIndex = 0,   -- which filtered track it is
		trackGen = 0      -- that track's generation, so a reused slot isn't mistaken for it
	}

	for _, name in ipairs(filteredParamNames) do
		pt[name] = get_param_handle(prioritySTR .. name)
	end
	pt.priority = get_param_handle(prioritySTR .. "priority")

	priorityTargets[k] = pt
end

local NumberOfPriorityTargets = get_param_handle("NumberOfPriorityTargets")
local priorityLockPressed = false

local function countPriority()
	local n = 0

	for k = 1, MAX_PRIORITY do
		if priorityTargets[k].active then
			n = n + 1
		end
	end

	return n
end

local function findPriorityOfTrack(trackIndex)
	for k = 1, MAX_PRIORITY do
		local pt = priorityTargets[k]

		if pt.active and pt.trackIndex == trackIndex and pt.trackGen == filteredContacts[trackIndex].gen then
			return k
		end
	end

	return nil
end

-- removes a priority target and closes the gap: everything below it moves up one group
local function removePriority(k)
	for j = k, MAX_PRIORITY - 1 do
		local a, b = priorityTargets[j], priorityTargets[j + 1]

		a.active, a.trackIndex, a.trackGen = b.active, b.trackIndex, b.trackGen
	end

	local last = priorityTargets[MAX_PRIORITY]
	last.active = false
	last.trackIndex = 0
	last.trackGen = 0
end

-- the filtered track closest to the cursor, if it's near enough
local function trackUnderCursor()
	local cx, cy = Cursor_X:get(), Cursor_Y:get()
	local best, bestDist = nil, prioritySelectGate

	for n = 1, MAX_FILTERED do
		local ft = filteredContacts[n]

		if ft.active then
			local dx = cx - ft.BSX:get()
			local dy = cy - ft.BSY:get()
			local d = math.sqrt(dx * dx + dy * dy)

			if d < bestDist then
				best, bestDist = n, d
			end
		end
	end

	return best
end

local function givePriority()
	local n = trackUnderCursor()
	if not n or findPriorityOfTrack(n) then
		return -- nothing there, or it's already a priority target
	end

	local count = countPriority()
	if count >= MAX_PRIORITY then
		return -- full
	end

	local pt = priorityTargets[count + 1]
	pt.active = true
	pt.trackIndex = n
	pt.trackGen = filteredContacts[n].gen
end

local function takePriority()
	local n = trackUnderCursor()
	if not n then
		return
	end

	local k = findPriorityOfTrack(n)
	if k then
		removePriority(k)
	end
end

-- 1 -> N, 2 -> 1, 3 -> 2, 4 -> 3 (the targets move between groups, the groups keep their numbers)
local function stepPriority()
	local count = countPriority()
	if count < 2 then
		return
	end

	local firstTrack, firstGen = priorityTargets[1].trackIndex, priorityTargets[1].trackGen

	for j = 1, count - 1 do
		local a, b = priorityTargets[j], priorityTargets[j + 1]

		a.trackIndex, a.trackGen = b.trackIndex, b.trackGen
	end

	priorityTargets[count].trackIndex = firstTrack
	priorityTargets[count].trackGen = firstGen
end

local function sendToRadar(command, value)
	local ok, err = pcall(function()
		simpleRadar:SetCommand(command, value)
	end)

	if not ok then
		print_message_to_user("PRIORITY LOCK: could not send command " .. tostring(command) .. " to the radar: " .. tostring(err))
	end
end

-- S11 pressed: point the TDC at priority 1 and start the lock
local function pressPriorityLock()
	local pt = priorityTargets[1]

	if pt.active then
		local ft = filteredContacts[pt.trackIndex]

		priorityLockTimer = priorityLockHold
		radar.RADAR_TDC_AZIMUTH:set(ft.AZIMUTH:get())
		radar.RADAR_TDC_RANGE:set(ft.RANGE:get())

		priorityLockPressed = true

		if priorityLockSendsCommand then
			sendToRadar(priorityLockStart, 1)
		end
	end
end

-- S11 released
local function releasePriorityLock()
	if not priorityLockPressed then
		return
	end

	priorityLockPressed = false
	priorityLockTimer = priorityLockHold

	if priorityLockSendsCommand then
		sendToRadar(priorityLockFinish, 1)
	end
end

local function updatePriorityTargets(dt)
	if priorityLockTimer > 0 then
		priorityLockTimer = priorityLockTimer - dt
	end

	-- a priority target whose track is gone is dropped, and the ones below it move up
	local g = 1
	while g <= MAX_PRIORITY do
		local pt = priorityTargets[g]

		if pt.active then
			local ft = filteredContacts[pt.trackIndex]

			if ft.active and ft.gen == pt.trackGen then
				g = g + 1
			else
				removePriority(g) -- the next target has moved into this group, so look at it again
			end
		else
			g = g + 1
		end
	end

	-- write the params: group k is the priority k target
	for k = 1, MAX_PRIORITY do
		local pt = priorityTargets[k]

		if pt.active then
			local ft = filteredContacts[pt.trackIndex]

			for _, name in ipairs(filteredParamNames) do
				pt[name]:set(ft[name]:get())
			end

			pt.priority:set(k)
		else
			pt.FRESH:set(0)
			pt.isFresh:set(0)
			pt.TIME:set(-1)
			pt.priority:set(0)
		end
	end

	NumberOfPriorityTargets:set(countPriority())
end



-- stuff which makes life easier


local function computeBscopePos(az, rangeNM)
	local bsAzLimit = perfomance.scan_volume_azimuth / 2
	local bsMaxRange = RDRFullRange:get()

	local x = (az / bsAzLimit) * scopeHalfExtent
	local y = (rangeNM / bsMaxRange) * (scopeHalfExtent * 2) / bscopeYDivisor

	x = math.max(-scopeHalfExtent, math.min(scopeHalfExtent, x))
	-- y = math.max(0, math.min(scopeHalfExtent * 2, y))

	return x, y
end


-- Works out every derived param (BSX/BSY, relHdg, RDX/RDY, alt, pitch, ...) for one contact.
-- Used for the raw RADAR_CONTACT_xx contacts AND the filtered contacts, so both always match.
local function processContact(contact, rawAz, rawEl, rawRange, rawTime, rawVX, rawVY, rawVZ)
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
		-- local selfZ, selfY, selfX = baseData.getSelfCoordinates()

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
		local predictSeconds = 20 -- how far ahead it will be

		local relX = math.sin(rawAz) * rawRange
		local relZ = math.cos(rawAz) * rawRange

		local velRelX = horVel * math.cos(relHdgVal)
		local velRelZ = horVel * math.sin(relHdgVal)

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



-- stuff to help with the filter



local function relativeToWorld(az, el, slantRange, selfX, selfZ, hdg)
	local hRange = math.cos(el) * slantRange
	local fwd = math.cos(az) * hRange
	local right = math.sin(az) * hRange

	return selfX + fwd * math.cos(hdg) - right * math.sin(hdg),
		selfZ + fwd * math.sin(hdg) + right * math.cos(hdg)
end

-- returns azimuth and HORIZONTAL range
local function worldToRelative(wx, wz, selfX, selfZ, hdg)
	local dx = wx - selfX
	local dz = wz - selfZ

	local fwd = dx * math.cos(hdg) + dz * math.sin(hdg)
	local right = -dx * math.sin(hdg) + dz * math.cos(hdg)

	return math.atan2(right, fwd), math.sqrt(fwd * fwd + right * right)
end

local function nctrCompatible(a, b)
	if a == b then
		return true
	end

	if nctrEmptyIsWildcard and (a == nil or a == "" or b == nil or b == "") then
		return true
	end

	return false
end

local function distanceToTrack(ft, wx, wz)
	local dx = wx - ft.worldX
	local dz = wz - ft.worldZ
	return math.sqrt(dx * dx + dz * dz)
end

-- Merge one radar return into a track
local function applyPlot(ft, p)
	local c = p.raw

	ft.worldX = ft.worldX + (p.wx - ft.worldX) * blendFactor
	ft.worldZ = ft.worldZ + (p.wz - ft.worldZ) * blendFactor
	ft.el = p.el

	-- Speed and heading come from where the target actually was (its world coordinates),
	-- not from the radar's own VX/VZ. The speed is measured between two positions at least
	-- velocityMinInterval seconds apart.
	local span = filterClock - ft.refT

	if span >= velocityMinInterval then
		if span <= velocityMaxInterval then
			local mx = (p.wx - ft.refX) / span
			local mz = (p.wz - ft.refZ) / span

			if math.sqrt(mx * mx + mz * mz) <= velocityMaxSpeed then
				if ft.velInit then
					ft.vx = ft.vx + (mx - ft.vx) * velocityBlend
					ft.vz = ft.vz + (mz - ft.vz) * velocityBlend
				else
					ft.vx = mx
					ft.vz = mz
					ft.velInit = true
				end
			end
		end

		ft.refX = p.wx
		ft.refZ = p.wz
		ft.refT = filterClock
	end

	-- this still comes from the radar might make it custom later
	ft.vy = c.VY:get()

	-- identity / signal fields are overwritten by the winning return
	ft.nctr = p.nctr
	ft.NCTR:set(p.nctr)
	ft.FRIENDLY:set(c.FRIENDLY:get())
	ft.NOISE:set(c.NOISE:get())
	ft.RCS:set(c.RCS:get())
	ft.RCS_COEFF:set(c.RCS_COEFF:get())
	ft.RND:set(c.RND:get())

	ft.age = 0
	ft.srcSlot = p.rawIndex
	c.ownerTrack = ft.index
	c.ownerGen = ft.gen
end

local function spawnTrack(p)
	for n = 1, MAX_FILTERED do
		local ft = filteredContacts[n]

		if not ft.active then
			ft.active = true
			ft.worldX = p.wx
			ft.worldZ = p.wz
			ft.selfAltFt = 0
			ft.selfPitch = 0
			ft.prevTime = 11
			ft.gen = ft.gen + 1

			-- no speed known yet, it's measured from the next returns
			ft.vx = 0
			ft.vy = 0
			ft.vz = 0
			ft.velInit = false
			ft.refX = p.wx
			ft.refZ = p.wz
			ft.refT = filterClock

			applyPlot(ft, p)
			return n
		end
	end

	return nil
end

local function deactivateTrack(ft)
	ft.active = false
	ft.srcSlot = 0

	ft.FRESH:set(0)
	ft.isFresh:set(0)
	ft.TIME:set(-1)
	ft.WORLDX:set(0)
	ft.WORLDZ:set(0)
end


-- this is the headache part, this turns the radar returns into coordinates using the aircrafts pos and heading
-- it uses where your going to compensate for your own movement(finally it works lmao)


local hdgSign = (HDG_SIGN ~= 0) and HDG_SIGN or 1
local hdgSignLocked = (HDG_SIGN ~= 0)
local hdgPrevX, hdgPrevZ = nil, nil
local hdgTimer = 0
local hdgScorePlus, hdgScoreMinus, hdgSamples = 0, 0, 0
local FilterHdgSign = get_param_handle("FilterHdgSign")

local function updateHeadingSign(selfX, selfZ, rawHdg, dt)
	FilterHdgSign:set(hdgSign)

	if hdgSignLocked then
		return
	end

	hdgTimer = hdgTimer + dt
	if hdgTimer < 0.5 then
		return
	end

	local span = hdgTimer
	hdgTimer = 0

	if hdgPrevX == nil then
		hdgPrevX, hdgPrevZ = selfX, selfZ
		return
	end

	local dx = selfX - hdgPrevX
	local dz = selfZ - hdgPrevZ
	hdgPrevX, hdgPrevZ = selfX, selfZ

	if math.sqrt(dx * dx + dz * dz) / span < 60 then
		return -- too slow to say which way you're going
	end

	if math.abs(math.sin(rawHdg)) < 0.35 then
		return -- pointing (nearly) north/south: both signs predict the same ground track
	end

	local track = math.atan2(dz, dx)

	hdgScorePlus = hdgScorePlus + math.cos(track - rawHdg)
	hdgScoreMinus = hdgScoreMinus + math.cos(track + rawHdg)
	hdgSamples = hdgSamples + 1

	if hdgSamples >= 6 then
		local plus = hdgScorePlus / hdgSamples
		local minus = hdgScoreMinus / hdgSamples

		if plus > 0.8 and minus < 0.5 then
			hdgSign = 1
			hdgSignLocked = true
		elseif minus > 0.8 and plus < 0.5 then
			hdgSign = -1
			hdgSignLocked = true

			-- everything so far was placed with the wrong sign, start the tracks again
			for n = 1, MAX_FILTERED do
				if filteredContacts[n].active then
					deactivateTrack(filteredContacts[n])
				end
			end

			print_message_to_user("FILTER: your heading counts the other way round, now using HDG_SIGN = -1")
		else
			print_message_to_user("FILTER: your ground track doesn't match your heading either way round, the x/z axes may be swapped")
		end

		FilterHdgSign:set(hdgSign)
		hdgScorePlus, hdgScoreMinus, hdgSamples = 0, 0, 0
	end
end


-- where a track will be on the B-scope in some seconds
local function projectedScreenPos(ft, seconds, selfX, selfZ, hdg)
	local wx = ft.worldX + ft.vx * seconds
	local wz = ft.worldZ + ft.vz * seconds

	local az, hRange = worldToRelative(wx, wz, selfX, selfZ, hdg)

	return computeBscopePos(az, (hRange / math.max(math.cos(ft.el), 0.2)) * M_TO_NMI)
end

-- Speed and heading params for a filtered track, from its coordinates.
-- Runs after processContact, so these replace what the radar's own velocity would have given. (these are more accurate)
local function applyTrackMotion(ft, selfX, selfZ, hdg)
	local vx, vz = ft.vx, ft.vz
	local speed = math.sqrt(vx * vx + vz * vz)

	ft.horVel:set(speed * MS_TO_KTS)                                  -- knots
	ft.vel:set(math.sqrt(speed * speed + ft.vy * ft.vy) * MS_TO_KTS)  -- knots


	local trueHdg = math.atan2(vz, vx)
	ft.heading:set(math.deg(trueHdg % TWOPI))
	ft.relHdg:set((trueHdg - hdg) % TWOPI)

	-- the heading line i think
	local bx, by = projectedScreenPos(ft, 0, selfX, selfZ, hdg)

	if speed > 1 then
		local bx2, by2 = projectedScreenPos(ft, 20, selfX, selfZ, hdg)
		ft.BSHdg:set(math.atan2(-(bx2 - bx), by2 - by))
	end

	if radarScopeMode:get() == 2 then
		-- 30 seconds of travel
		local bx3, by3 = projectedScreenPos(ft, 30, selfX, selfZ, hdg)
		local f = (scopeHalfExtent * 2) / bscopeYDivisor
		local vX = (bx3 - bx) / f
		local vY = (by3 - by) / f

		ft.RDVelvecX:set(vX)
		ft.RDVelvecY:set(vY)
		ft.RDVelvec:set(math.sqrt(vX * vX + vY * vY))
	end
end

local filterDebugTimer = 0

local function updateFilteredContacts()
	local searching = radar.RADAR_MODE:get() == 1

	local selfX, selfZ, _  = baseData.getSelfCoordinates()
	local dt = updateTimeStep

	filterClock = filterClock + dt
	updateHeadingSign(selfX, selfZ, baseData.getHeading(), dt)
	local hdg = baseData.getHeading() * hdgSign


	-- 1. Age and coast every active track
	for n = 1, MAX_FILTERED do
		local ft = filteredContacts[n]

		if ft.active then
			if searching then
				ft.age = ft.age + dt -- only searching ages a track out
			end

			if coastTracks then
				ft.worldX = ft.worldX + ft.vx * dt
				ft.worldZ = ft.worldZ + ft.vz * dt
			end
		end
	end


	-- 2. get new radar returns. A raw slot only counts when its az/el/range just changed,
	--    stale stuff is ignored(like when you roll)
	local plots = {}

	for i = 1, 99 do
		local c = contacts[i]

		local az = c.AZIMUTH:get()
		local el = c.ELEVATION:get()
		local rng = c.RANGE:get()

		local changed = az ~= c.fPrevAz or el ~= c.fPrevEl or rng ~= c.fPrevRange
		c.fPrevAz, c.fPrevEl, c.fPrevRange = az, el, rng

		if searching and changed and c.TIME:get() >= 0 and rng > 0 then
			local wx, wz = relativeToWorld(az, el, rng, selfX, selfZ, hdg)

			plots[#plots + 1] = {
				raw = c, rawIndex = i, el = el, wx = wx, wz = wz,
				nctr = c.NCTR:get(),
				track = nil, dist = math.huge
			}
		end
	end


	-- 3. finds other tracks in range and correct NCTR
	for _, p in ipairs(plots) do
		local bestTrack, bestDist = nil, gateDistanceMeters

		for n = 1, MAX_FILTERED do
			local ft = filteredContacts[n]

			if ft.active and nctrCompatible(ft.nctr, p.nctr) then
				local d = distanceToTrack(ft, p.wx, p.wz)

				if d < bestDist then
					bestTrack, bestDist = n, d
				end
			end
		end

		p.track, p.dist = bestTrack, bestDist
	end


	-- 4. closest one wins
	local winner = {}

	for pi, p in ipairs(plots) do
		if p.track then
			local w = winner[p.track]

			if not w or p.dist < plots[w].dist then
				winner[p.track] = pi
			end
		end
	end

	for n, pi in pairs(winner) do
		applyPlot(filteredContacts[n], plots[pi])
	end


	-- 5. Returns that matched nothing start new tracks
	for _, p in ipairs(plots) do
		if not p.track then
			local isCopy = false

			for n = 1, MAX_FILTERED do
				local ft = filteredContacts[n]

				if ft.active and nctrCompatible(ft.nctr, p.nctr)
				and distanceToTrack(ft, p.wx, p.wz) < gateDistanceMeters then
					isCopy = true
					break
				end
			end

			if not isCopy then
				spawnTrack(p)
			end
		end
	end


	-- 6. Drop old tracks, then write every param for the rest
	for n = 1, MAX_FILTERED do
		local ft = filteredContacts[n]

		-- How long since this track was last confirmed? Normally that's the time since the last
		-- merged return, but if the raw slot that feeds it is still being refreshed

		local ageNow = ft.age

		if ft.active and ft.srcSlot > 0 then
			local src = contacts[ft.srcSlot]

			if src.ownerTrack == ft.index and src.ownerGen == ft.gen then
				local srcTime = src.TIME:get()

				if srcTime > 0 and srcTime < ageNow then
					ageNow = srcTime
				end
			end
		end

		if ft.active and searching then
			ft.age = ageNow -- a long STT lock doesn't make the track look old
		end

		if ft.active and ageNow > trackTimeoutSeconds then
			deactivateTrack(ft)
		end

		if ft.active then
			-- the track lives in the world, so az/range are recomputed from where you are now
			local az, hRange = worldToRelative(ft.worldX, ft.worldZ, selfX, selfZ, hdg)
			local range = hRange / math.max(math.cos(ft.el), 0.2)
			local time = math.max(ageNow, dt)

			ft.AZIMUTH:set(az)
			ft.ELEVATION:set(ft.el)
			ft.RANGE:set(range)
			ft.TIME:set(time)

			ft.VX:set(ft.vx)
			ft.VY:set(ft.vy)
			ft.VZ:set(ft.vz)

			ft.WORLDX:set(ft.worldX)
			ft.WORLDZ:set(ft.worldZ)

			ft.FRESH:set(1)
			ft.isFresh:set(1)

			processContact(ft, az, ft.el, range, time, ft.vx, ft.vy, ft.vz)
			applyTrackMotion(ft, selfX, selfZ, hdg)
		end
	end


	if filterDebug then
		filterDebugTimer = filterDebugTimer - dt

		if filterDebugTimer <= 0 then
			filterDebugTimer = 1

			local count = 0
			for n = 1, MAX_FILTERED do
				if filteredContacts[n].active then
					count = count + 1
				end
			end

			local line = string.format("FILTER: %d tracks, %d new returns, hdgSign %d", count, #plots, hdgSign)

			for n = 1, MAX_FILTERED do
				local ft = filteredContacts[n]

				if ft.active then
					local src = contacts[ft.srcSlot > 0 and ft.srcSlot or 1]
					line = line .. string.format(" | track %d: %.0f kts hdg %.0f (radar says %.0f kts)", n,
						math.sqrt(ft.vx ^ 2 + ft.vz ^ 2) * MS_TO_KTS, math.deg(math.atan2(ft.vz, ft.vx) % TWOPI),
						math.sqrt(src.VX:get() ^ 2 + src.VZ:get() ^ 2) * MS_TO_KTS)
					break
				end
			end

			print_message_to_user(line)
		end
	end
end


function update()

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
		local cx, cy = cursorX, cursorY



		-- Check if we should release an existing snap
		if snappedContactIndex then
			local sc = contacts[snappedContactIndex]
			if sc.TIME:get() <= 0 or sc.isFresh:get() ~= 1 then
				snappedContactIndex = nil -- contact lost or flagged as a duplicate — release
			else
				local dx = cx - sc.BSX:get()
				local dy = cy - sc.BSY:get()
				if math.sqrt(dx * dx + dy * dy) > snapGate then
				snappedContactIndex = nil -- slewed far enough away — release
				end
			end
		end

		-- If not currently snapped, check whether the cursor is now close enough to grab one
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

		-- Output: snapped position if locked on, otherwise the free TDC position
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

	if tdcFollowsCursor then
		moveTDCToCursor()
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

			processContact(
				contact, contact.AZIMUTH:get(), contact.ELEVATION:get(), contact.RANGE:get(),
				contact.TIME:get(), contact.VX:get(), contact.VY:get(), contact.VZ:get()
			)
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

	updateFilteredContacts()
	updatePriorityTargets(updateTimeStep)
end

function SetCommand(command, value)
	print_message_to_user(string.format("RDR SC: C: %i   V: %.8f", command, value))

	-- Priority targets (only the press counts, not the release)
	if command == keys.S5StageOne then
		givePriority()
	elseif command == keys.S5StageTwo then
		takePriority()
	elseif command == keys.S1PriorityStep then
		stepPriority()
	elseif command == keys.S11Lock then
		if lock == 0 then
			pressPriorityLock()
		else
			releasePriorityLock()
			lock = 0
		end

		
	end



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

	-- The hat and the slew axes move the CURSOR on the screen (not the radar's TDC)
	if command == 2032 then
		cursorY = cursorY - value * 10
	end

	if command == 2031 then
		cursorX = cursorX + value * 10
	end

	if command == 88 then -- Left
		cursorX = cursorX - cursorStepX
	elseif command == 89 then -- Right
		cursorX = cursorX + cursorStepX
	end

	if command == 90 then -- Up
		cursorY = cursorY + cursorStepY
	elseif command == 91 then -- Down
		cursorY = cursorY - cursorStepY
	end

	cursorY = math.max(cursorMinY, math.min(cursorMaxY, cursorY))
	cursorX = math.max(-cursorXLimit, math.min(cursorXLimit, cursorX))

	-- Lock: send the radar's TDC to wherever the cursor is, so it locks what you're looking at
	if lockCommands[command] then
		moveTDCToCursor()
	end
end