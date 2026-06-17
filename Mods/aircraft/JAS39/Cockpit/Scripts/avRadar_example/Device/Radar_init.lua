dofile(LockOn_Options.script_path .. "utils.lua")


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

	RADAR_STT_AZIMUTH   = get_param_handle("RADAR_STT_AZIMUTH"), -- =READ= Azimuth to STT target in radians, normalized with roll
	RADAR_STT_ELEVATION = get_param_handle("RADAR_STT_ELEVATION"), -- =READ= Elevation to STT target in radians, normalized with roll
	RADAR_STT_RANGE     = get_param_handle("RADAR_STT_RANGE"),  -- =READ= Range to STT target in meters
	RADAR_STT_FRIENDLY  = get_param_handle("RADAR_STT_FRIENDLY"), -- =READ= IFF status of target. -1: IFF is off, 0: Hostile or unknown, 1: Friendly

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
		-- vel = get_param_handle(contactSTR .. "vel"), -- Velocity in kts
		-- horVel = get_param_handle(contactSTR .. "horVel"), -- Hozisontal velocity in kts
		relHdg = get_param_handle(contactSTR .. "relHdg"), -- Heading of contact
		RDX = get_param_handle(contactSTR .. "RDX"),     -- X coordinate of contact on RD
		RDY = get_param_handle(contactSTR .. "RDY"),     -- Y coordinate of contact on RD
		RDVelvec = get_param_handle(contactSTR .. "RDVelvec"), -- Length of contact velocity vector on RD
		alt = get_param_handle(contactSTR .. "alt"),
		altK = get_param_handle(contactSTR .. "altK"), -- Length of contact velocity vector on RD
		altScpRange = get_param_handle(contactSTR .. "altScpRange"),
		pitch = get_param_handle(contactSTR .. "pitch"),
		altScpVelvec = get_param_handle(contactSTR .. "altScpVelvec"),
		selfAltFt = 0,
		selfPitch = 0,
		antennaEl = get_param_handle(contactSTR .. "antennaEl"),
		prevTime = 11,
		HUDEl = get_param_handle(contactSTR .. "HUDEl")
	}
end

local CDScale = get_param_handle("CDScale")
local RDRFullRange = get_param_handle("RDRFullRange")
local RDRElLimUpperX = get_param_handle("RDRElLimUpperX")
local RDRElLimUpperY = get_param_handle("RDRElLimUpperY")
local RDRElLimLowerX = get_param_handle("RDRElLimLowerX")
local RDRElLimLowerY = get_param_handle("RDRElLimLowerY")


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
local detectionDist = 530000
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



local function updateBaseData()
	selfAltFt = baseData.getBarometricAltitude() * M_TO_FT
	selfPitch = baseData.getPitch()
end

get_param_handle("hejsan"):set(0)
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

	print_message_to_user("Radar - INIT")


	radar.RADAR_PITCH_BANK_STABILIZATION:set(1)
	radar.RADAR_PITCH_STABILIZATION:set(1)
	radar.RADAR_BANK_STABILIZATION:set(1)
	radar.IFF_INTERROGATOR_STATUS:set(1)
	radar.SCAN_ZONE_VOLUME_ELEVATION:set(math.rad(elSettings[1]) * 2)
	-- radar.SCAN_ZONE_VOLUME_ELEVATION:set(math.rad(120))
end

function update()
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

			contact.relHdg:set(TWOPI - (math.atan2(rawVX, rawVZ) + HALFPI) - ownHdg)

			-- deltaCX = math.cos(rawAz + math.pi / 2) * rawRange
			-- contactX = selfX - deltaCX
			-- deltaCZ = math.sin(rawAz + math.pi / 2) * rawRange
			-- contactZ = selfZ - deltaCZ
			-- dx = math.cos(ownHdg) * -deltaCZ - math.sin(ownHdg) * deltaCX
			-- dz = math.cos(ownHdg) * deltaCX + math.sin(ownHdg) * deltaCZ



			if get_param_handle("RDRScopeMode"):get() == 1 then
				displayZoom = CDScale:get() * RDMult

				contact.RDX:set((math.cos(-rawAz + HALFPI) * rawRange) / displayZoom)
				contact.RDY:set((math.sin(-rawAz + HALFPI) * rawRange) / displayZoom)

				contact.RDVelvec:set((horVel * 30) / displayZoom)
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

	if radar.RADAR_TDC_AZIMUTH:get() > .5 then
		radar.RADAR_TDC_AZIMUTH:set(.5)
	elseif radar.RADAR_TDC_AZIMUTH:get() < -.5 then
		radar.RADAR_TDC_AZIMUTH:set(-.5)
	end

	-------------------------------------------------

	if command == 2032 then
		radar.RADAR_TDC_RANGE:set(radar.RADAR_TDC_RANGE:get() - value * 200000)
	end

	if command == 2031 then
		radar.RADAR_TDC_AZIMUTH:set(radar.RADAR_TDC_AZIMUTH:get() + value * 10)
	end
end


