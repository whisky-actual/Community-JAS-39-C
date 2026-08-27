dofile(LockOn_Options.common_script_path .. "devices_defs.lua")
dofile(LockOn_Options.script_path .. "command_defs.lua")
dofile(LockOn_Options.script_path .. "devices.lua")
dofile(LockOn_Options.script_path .. "RWR/symboles.lua")
dofile(LockOn_Options.script_path .. "utils.lua")
local Terrain = require("terrain")



local updateTimeStep = 1 / 60
make_default_activity(updateTimeStep)


local RWR = GetSelf()


local RWRPower = get_param_handle("RWRPower")

local activeRWRThreats = get_param_handle("activeRWRThreats")

local typeEWR = 0
local typePlane = 1
local typeSearchRadar = 2
local typeSEA = 3
local typeMissile = 4

local searchSignal = 1
local lockSignal = 2
local launchSignal = 3

local contactSTR = ""
local testContactSTR = "RWR_CONTACT_21_"

local activeThreats = 0

-- Variables from example
-- render_debug_info = true

local gettext = require("i_18n")
_ = gettext.translate

device_timer_dt  = 0.0166



DefaultType         = 100

-- Variables from example

eyes = {}
eyes[1] = {
	position = {
		x = 10.178,
		y = .612,
		z = 0
	},
	orientation = {
		azimuth = math.rad(45),
		elevation = math.rad(0)
	},
	field_of_view = math.rad(360)
}
eyes[2] = {
	position = {
		x = 9.186,
		y = -.739,
		z = 0
	},
	orientation = {
		azimuth = math.rad(-45),
		elevation = math.rad(0)
	},
	field_of_view = math.rad(360)
}
eyes[3] = {
	position = {
		x = -5.145,
		y = 2.89,
		z = 2.156
	},
	orientation = {
		azimuth = math.rad(135),
		elevation = math.rad(0)
	},
	field_of_view = math.rad(360)
}
eyes[4] = {
	position = {
		x = -5.145,
		y = 2.89,
		z = -2.156
	},
	orientation = {
		azimuth = math.rad(-135),
		elevation = math.rad(0)
	},
	field_of_view = math.rad(360)
}
MaxThreats       = 20
EmitterLiveTime  = 11
RWR_detection_coeff = 0.85

-- power_bus_handle = ""

rwr = {}
for ia = 1, MaxThreats do
	local i = ""

	if ia < 10 then
		i = "_0" .. ia .. "_"
	else
		i = "_" .. ia .. "_"
	end

	contactSTR = "RWR_CONTACT" .. i

	rwr[ia] = {
		-- Standard from avSimpleRWR (CAPITALIZED):
		AZIMUTH = get_param_handle(contactSTR .. "AZIMUTH"), -- Azimuth of the contact in radians (0 to 2pi)
		ELEVATION = get_param_handle(contactSTR .. "ELEVATION"), -- Elevation of the contact in radians (-pi to pi)
		POWER = get_param_handle(contactSTR .. "POWER"),   -- Signal strength of the contact (0 = lowest, 1 = highest)

		GENERAL_TYPE = get_param_handle(contactSTR .. "GENERAL_TYPE"), -- "General type" of the contact (EWR = 0, plane = 1, search radar = 2, ship = 3, missile = 4)
		UNIT_TYPE = get_param_handle(contactSTR .. "UNIT_TYPE"), -- Full DCS name of contact (ex: E-3A, MOSCOW)

		SIGNAL = get_param_handle(contactSTR .. "SIGNAL"), -- Type of tracking (1 = search, 2 = lock, 3 = launch)
		TIME = get_param_handle(contactSTR .. "TIME"), -- Time since last ping
		SOURCE = get_param_handle(contactSTR .. "SOURCE"), -- Returns seemingly big random number, might be radar wave frequency?

		PRIORITY = get_param_handle(contactSTR .. "PRIORITY"), -- Number of how "important" the contact is, bigger number = higher priority

		-- Custom:
		prevAz = 0,
		prevEl = 0,
		fAz = get_param_handle(contactSTR .. "fAz"),
		prevFAz = 0,
		unNormAz = 0,
		fEl = get_param_handle(contactSTR .. "fEl"),
		prevFEl = 0,
		azHUD = get_param_handle(contactSTR .. "azHUD"),
		elHUD = get_param_handle(contactSTR .. "elHUD"),
		azHMD = get_param_handle(contactSTR .. "azHMD"),
		elHMD = get_param_handle(contactSTR .. "elHMD"),
		prevPitch = 0,
		prevHdg = 0,
		obs = {},
		phyRange = get_param_handle(contactSTR .. "phyCRange"),
		rangeConf = get_param_handle(contactSTR .. "CRangeConf"),

		hdg = get_param_handle(contactSTR .. "hdg"), -- The heading of the contact in radians (0 to 2pi)
		medium = get_param_handle(contactSTR .. "medium"), -- The medium of the contact (surface = 1, air = 2)
		range = get_param_handle(contactSTR .. "range"), -- Range from ownship, better visual distribution than POWER (0 = furthest, -1 = closest)

		beenThreat = 0,                                        -- Has the contact ever been a threat (lock or launch)
		threat = get_param_handle(contactSTR .. "threat"),     -- Threat level (color) of the contact (0 = unkown: yellow, 1 = threat: red)
		launch = get_param_handle(contactSTR .. "launch"),     -- Is the contact (launching) a missile (0 = no, 1 = yes)
		launchBlinkUpdate = .1,                                -- Timer for launch blinking
		launchBlink = get_param_handle(contactSTR .. "launchBlink"), -- Blinking param for launch indication

		name = get_param_handle(contactSTR .. "name") -- Name of the contact; text under the oval (ex: "M29": MiG-29)
	}
end


local baseData = get_base_data()



function post_initialize()
	-- -- Params for test contact:
	-- -- Standard from avSimpleRWR:
	-- local testAz          = get_param_handle(testContactSTR .. "AZIMUTH")
	-- local testEl          = get_param_handle(testContactSTR .. "ELEVATION")
	-- local testPower       = get_param_handle(testContactSTR .. "POWER")
	-- local testGeneralType = get_param_handle(testContactSTR .. "GENERAL_TYPE")
	-- local testUnitType    = get_param_handle(testContactSTR .. "UNIT_TYPE")
	-- local testSignal      = get_param_handle(testContactSTR .. "SIGNAL")
	-- local testTime        = get_param_handle(testContactSTR .. "TIME")
	-- local testSource      = get_param_handle(testContactSTR .. "SOURCE")
	-- local testPriority    = get_param_handle(testContactSTR .. "PRIORITY")

	-- testAz:set(math.rad(90))
	-- testEl:set(0)
	-- testPower:set(.75)
	-- testGeneralType:set(typePlane)
	-- testUnitType:set("MiG-29A")
	-- testSignal:set(searchSignal)
	-- testTime:set(1.1)
	-- testSource:set(160000000)
	-- testPriority:set(140)

	-- -- Custom:
	-- get_param_handle(testContactSTR .. "hdg"):set((2 * math.pi - testAz:get()) % (2 * math.pi))
	-- get_param_handle(testContactSTR .. "medium"):set((testGeneralType:get() == typePlane or testGeneralType:get() == typeMissile) and 2 or 1)
	-- get_param_handle(testContactSTR .. "range"):set(-.04 * testPower:get()^2)
	-- get_param_handle(testContactSTR .. "threat"):set(((testSignal:get() == lockSignal or testSignal:get() == launchSignal) or testPriority:get() >= 155) and 1 or 0)
	-- get_param_handle(testContactSTR .. "launch"):set((testSignal:get() == launchSignal or testGeneralType:get() == typeMissile) and 1 or 0)
	-- get_param_handle(testContactSTR .. "launchBlink"):set(1)
	-- get_param_handle(testContactSTR .. "name"):set(getThreatSTR(testUnitType:get()))
end

function update()
	GetDevice(devices.RWR):set_power(RWRPower:get() == 1)
	local jsonTbl = {}



	activeThreats = 0

	for i = 1, MaxThreats do
		local rawAz       = rwr[i].AZIMUTH:get()
		local rawEl       = rwr[i].ELEVATION:get()
		local rawPwr      = rwr[i].POWER:get()
		local rawGenType  = rwr[i].GENERAL_TYPE:get()
		local rawUnitType = rwr[i].UNIT_TYPE:get()
		local rawSignal   = rwr[i].SIGNAL:get()
		-- local rawTime     = rwr[i].TIME:get()
		local rawSource   = rwr[i].SOURCE:get()
		local rawPrio     = rwr[i].PRIORITY:get()



		if rawSource ~= 0 then
			local contactTable = jsonTbl[tostring(rawSource)]

			if contactTable ~= nil then
				rwr[i].prevAz = contactTable.prevAz
				rwr[i].prevEl = contactTable.prevEl
				rwr[i].fAz:set(contactTable.fAz)
				rwr[i].unNormAz = contactTable.unNormAz
				rwr[i].fEl:set(contactTable.fEl)
				rwr[i].azHUD:set(contactTable.azHUD)
				rwr[i].elHUD:set(contactTable.elHUD)
				-- rwr[i].azHMD:set(contactTable.azHMD)
				-- rwr[i].elHMD:set(contactTable.elHMD)
				rwr[i].prevPitch = contactTable.prevPitch
				rwr[i].prevHdg = contactTable.prevHdg
				rwr[i].obs = contactTable.obs
				rwr[i].phyRange:set(contactTable.phyRange)
				rwr[i].beenThreat = contactTable.beenThreat
			end


			local dHdg, hdg, HUDRotAz, HUDRotEl, HMDRotAz, HMDRotEl



			if rwr[i].prevAz ~= rawAz or rwr[i].prevEl ~= rawEl then
				local el = rawEl
				local az = rawAz

				local vec = {
					x = math.cos(el) * math.cos(az),
					y = math.cos(el) * math.sin(az),
					z = math.sin(el)
				}

				vec = rotateX(baseData.getRoll(), vec)
				vec = rotateY(baseData.getPitch(), vec)

				az = math.atan2(vec.y, vec.x)
				el = math.atan(vec.z, math.sqrt(vec.x * vec.x + vec.y * vec.y))


				rwr[i].unNormAz = az
				if az < 0 then
					az = az + 2 * math.pi
				end

				rwr[i].fAz:set(az)
				rwr[i].fEl:set(el)

				rwr[i].prevFAz = rwr[i].fAz:get()
				rwr[i].prevFEl = rwr[i].fEl:get()


				rwr[i].prevAz = rawAz
				rwr[i].prevEl = rawEl

				rwr[i].prevPitch = baseData.getPitch()
				rwr[i].prevHdg = baseData.getHeading()



				local function angleDiff(a, b)
					return math.abs((a - b + math.pi) % (2 * math.pi) - math.pi)
				end

				if angleDiff(rwr[i].prevFAz, rawAz) > math.rad(0.3) or angleDiff(rwr[i].prevFEl, rawEl) > math.rad(0.3) then
					-- spara observation
					local x, y, z = baseData.getSelfCoordinates()
					print_message_to_user(i .. #rwr[i].obs)
					rwr[i].obs[#rwr[i].obs+1] = {
						pos = {x = x, y = y, z = z},
						az = rwr[i].unNormAz,
						el = rwr[i].fEl:get(),
						pitch = baseData.getPitch(),
						roll = baseData.getRoll(),
						hdg = baseData.getHeading()
					}
					-- local d1 = worldDirFromObs(rwr[i].obs[1])
					-- local d2 = worldDirFromObs(rwr[i].obs[2])
					-- local targetPos = triangulate(rwr[i].obs[1].pos, d1, rwr[i].obs[#rwr[i].obs].pos, d2, i)
					pruneObs(rwr[i].obs)

					-- local o = rwr[i].obs[#rwr[i].obs]
					-- local d = worldDirFromObs(o)

					-- local sx, sy, sz = o.pos.x, o.pos.y, o.pos.z
					-- local a, b = Terrain.convertMetersToLatLon(sx + d.x * 8000, sz + d.z * 8000)
					-- print_message_to_user(
					-- 	string.format("ray @ %.0fm -> (%.1f, %.0f, %.1f)",
					-- 				  8000,
					-- 				  a,
					-- 				  0,
					-- 				  b
					-- 	)
					-- )


					-- local targetPos = triangulateLS(rwr[i].obs)
					-- local conf = triangulationConfidence(rwr[i].obs)
					-- if targetPos then
						-- local sx, sy, sz = baseData.getSelfCoordinates()
						-- local dx = targetPos.x - sx
						-- local dy = targetPos.y - sy
						-- local dz = targetPos.z - sz
						-- rwr[i].phyRange:set(math.sqrt(dx * dx + dy * dy + dz * dz))
						-- rwr[i].rangeConf:set(conf)
					-- end
				end
			end

			dHdg = rwr[i].prevHdg - baseData.getHeading()

			hdg = rwr[i].fAz:get() + dHdg
			if hdg < 0 then
				hdg = hdg + 2 * math.pi
			end

			rwr[i].hdg:set(hdg)


			HUDRotAz, HUDRotEl = rotatePoint(rwr[i].unNormAz + dHdg, (rwr[i].fEl:get() + rwr[i].prevPitch) - (rwr[i].prevPitch + baseData.getPitch()), -baseData.getRoll())
			rwr[i].azHUD:set(HUDRotAz)
			rwr[i].elHUD:set(HUDRotEl)

			-- local headVecX, headVecY = rotatePoint(get_param_handle("horizontalViewHMD"):get(), get_param_handle("verticalViewHMD"):get(), -baseData.getRoll())
			-- local headEl = headVecY + math.tan(baseData.getPitch())
			-- -- HMDRotAz, HMDRotEl = rotatePoint(rwr[i].unNormAz + dHdg, ((rwr[i].fEl:get() + rwr[i].prevPitch) - (rwr[i].prevPitch + baseData.getPitch())), -baseData.getRoll())
			-- rwr[i].azHMD:set(math.tan((rwr[i].unNormAz + dHdg) + headVecX))
			-- rwr[i].elHMD:set(math.tan(((rwr[i].fEl:get() + rwr[i].prevPitch) - (rwr[i].prevPitch + baseData.getPitch())) - headEl))


			rwr[i].medium:set((rawGenType == typePlane or rawGenType == typeMissile) and 2 or 1)


			rwr[i].range:set(rawGenType == typeMissile and -.04 * rawPwr^3 or -.04 * rawPwr^2) -- Quadratic (cubic for missiles) relation to power for more distributed visual (https://www.desmos.com/calculator/agulijslet).


			if rawSignal == lockSignal or rawSignal == launchSignal then
				rwr[i].beenThreat = 1
			end

			rwr[i].threat:set((rwr[i].beenThreat == 1 or rawPrio >= 155) and 1 or 0)

			activeThreats = activeThreats + rwr[i].threat:get() * rawPwr


			rwr[i].launch:set((rawSignal == launchSignal or rawGenType == typeMissile) and 1 or 0)


			if rwr[i].launch:get() == 1 then
				if rwr[i].launchBlinkUpdate >= .1 then
					rwr[i].launchBlink:set(rwr[i].launchBlink:get() == 1 and 0 or 1)

					rwr[i].launchBlinkUpdate = 0
				else
					rwr[i].launchBlinkUpdate = rwr[i].launchBlinkUpdate + updateTimeStep
				end
			else
				rwr[i].launchBlink:set(1)
			end


			rwr[i].name:set(getThreatSTR(rawUnitType))



			contactTable = {
				prevAz = rwr[i].prevAz,
				prevEl = rwr[i].prevEl,
				fAz = rwr[i].fAz:get(),
				unNormAz = rwr[i].unNormAz,
				fEl = rwr[i].fEl:get(),
				azHUD = rwr[i].azHUD:get(),
				elHUD = rwr[i].elHUD:get(),
				-- azHMD = rwr[i].azHMD:get(),
				-- elHMD = rwr[i].elHMD:get(),
				prevPitch = rwr[i].prevPitch,
				prevHdg = rwr[i].prevHdg,
				obs = rwr[i].obs,
				phyRange = rwr[i].phyRange:get(),
				beenThreat = rwr[i].beenThreat
			}
		end
	end

	activeRWRThreats:set(activeThreats)
end


function rotateX(theta, vector)
	local c = math.cos(theta)
	local s = math.sin(theta)

	return {
		x = vector.x,
		y = (c * vector.y - s * vector.z),
		z = (s * vector.y + c * vector.z)
	}
end

function rotateY(theta, vector)
	local c = math.cos(theta)
	local s = math.sin(theta)

	return {
		x = (c * vector.x - s * vector.z),
		y = vector.y,
		z = (s * vector.x + c * vector.z)
	}
end

function rotateZ(theta, vector)
	local c = math.cos(theta)
	local s = math.sin(theta)

	return {
		x = (c * vector.x - s * vector.y),
		y = (s * vector.x + c * vector.y),
		z = vector.z
	}
end


function dirFromAzEl(az, el)
	return {
		x = math.cos(el) * math.cos(az),
		y = math.sin(el), -- Y är upp
		z = math.cos(el) * math.sin(az)
	}
end


-- matrix inverse 3x3
local function inv3(A)
	local a11, a12, a13 = A[1][1], A[1][2], A[1][3]
	local a21, a22, a23 = A[2][1], A[2][2], A[2][3]
	local a31, a32, a33 = A[3][1], A[3][2], A[3][3]

	local det = a11 * (a22 * a33 - a23 * a32) - a12 * (a21 * a33 - a23 * a31) + a13 * (a21 * a32 - a22 * a31)
	if math.abs(det) < 1e-12 then return nil end
	local invdet = 1 / det

	local inv = {
		{(a22 * a33 - a23 * a32) * invdet, (a13 * a32 - a12 * a33) * invdet, (a12 * a23 - a13 * a22) * invdet},
		{(a23 * a31 - a21 * a33) * invdet, (a11 * a33 - a13 * a31) * invdet, (a13 * a21 - a11 * a23) * invdet},
		{(a21 * a32 - a22 * a31) * invdet, (a12 * a31 - a11 * a32) * invdet, (a11 * a22 - a12 * a21) * invdet}
	}
	return inv
end

local function matVec(M, v)
	return {
		x = M[1][1] * v.x + M[1][2] * v.y + M[1][3] * v.z,
		y = M[2][1] * v.x + M[2][2] * v.y + M[2][3] * v.z,
		z = M[3][1] * v.x + M[3][2] * v.y + M[3][3] * v.z
	}
end

local function dot(a, b) return a.x * b.x + a.y * b.y + a.z * b.z end
local function add(a, b) return {x = a.x + b.x, y = a.y + b.y, z = a.z + b.z} end
local function sub(a, b) return {x = a.x - b.x, y = a.y - b.y, z = a.z - b.z} end
local function scale(v, s) return {x = v.x * s, y = v.y * s, z = v.z * s} end
local function len(v) return math.sqrt(dot(v, v)) end
local function normalize(v)
	local L = len(v); if L == 0 then return {x = 0, y = 0, z = 0} end
	return {x = v.x / L, y = v.y / L, z = v.z / L}
end
function triangulate(P1, d1, P2, d2, index)
	local baseline = math.sqrt(dot(sub(P2, P1), sub(P2, P1)))
	print_message_to_user(
		string.format(
			"baseline=%.1f angle=%.2f deg",
			math.sqrt(dot(sub(rwr[index].obs[2].pos, rwr[index].obs[1].pos), sub(rwr[index].obs[2].pos, rwr[index].obs[1].pos))),
			math.deg(math.acos(dot(d1, d2)))
		)
	)

	if baseline < 50 then return end -- för liten rörelse
	local angle = math.acos(dot(d1, d2))
	if angle < math.rad(1) then return end -- nästan parallella
	local w0 = sub(P1, P2)
	local a = dot(d1, d1) -- = 1
	local b = dot(d1, d2)
	local c = dot(d2, d2) -- = 1
	local d = dot(d1, w0)
	local e = dot(d2, w0)
	local denom = a * c - b * b
	if math.abs(denom) < 1e-6 then
		return nil -- nästan parallella
	end
	local t = (b * e - c * d) / denom
	local s = (a * e - b * d) / denom
	local Q1 = add(P1, scale(d1, t))
	local Q2 = add(P2, scale(d2, s)) -- medelpunkt
	return scale(add(Q1, Q2), 0.5)
end
function worldDirFromObs(obs)
	-- riktning i BODY-koordinater
	local d = dirFromAzEl(obs.az, obs.el)

	-- PASSIV rotation: body → world
	d = rotateZ(-obs.hdg, d)
	d = rotateY(-obs.pitch, d)
	d = rotateX(-obs.roll, d)

	-- normalisera
	local len = math.sqrt(d.x * d.x + d.y * d.y + d.z * d.z)
	return {x = d.x / len, y = d.y / len, z = d.z / len}
end



-- compute distance from point P to ray (O + t d)
local function pointLineDist(P, O, d)
	local OP = sub(P, O)
	local t = dot(OP, d)
	local closest = add(O, scale(d, t))
	return len(sub(P, closest))
end

-- build outer product
local function outer(d)
	return {
		{d.x * d.x, d.x * d.y, d.x * d.z},
		{d.y * d.x, d.y * d.y, d.y * d.z},
		{d.z * d.x, d.z * d.y, d.z * d.z}
	}
end

-- Weighted least-squares triangulation
-- obs = array of {pos, az, el, pitch, roll, hdg, t}
-- options: {angle_ref_idx=1} (useful to compute angles relative to reference)
function triangulateWeighted(obs, options)
	options = options or {}
	if #obs < 2 then return nil end

	-- compute useful parameters for weighting: use first observation as ref
	local ref = obs[options.angle_ref_idx or 1]
	local A = {{0, 0, 0}, {0, 0, 0}, {0, 0, 0}}
	local b = {x = 0, y = 0, z = 0}
	local weights = {}
	local ds = {}

	for i, o in ipairs(obs) do
		local d = worldDirFromObs(o) -- normalized
		ds[i] = d
	end

	-- compute pair-wise angle with ref for weights and baseline
	local maxBaseline = 0
	for i, o in ipairs(obs) do
		local dp = sub(o.pos, ref.pos)
		local baseline = len(dp)
		maxBaseline = math.max(maxBaseline, baseline)
	end

	for i, o in ipairs(obs) do
		local d = ds[i]
		-- angle to reference (in radians), clamp dot
		local dotv = math.max(-1, math.min(1, dot(ds[1], d)))
		local angle = math.acos(dotv)
		-- weight composition:
		--   w_angle = sin(angle)  (0 for parallel, ~1 for ~90deg)
		--   w_baseline = min(baseline / 400, 1)
		--   w_age: prefer recent points if t present
		local dp = sub(o.pos, ref.pos)
		local baseline = len(dp)
		local w_angle = math.max(0.0001, math.sin(angle)) -- avoid zero
		local w_baseline = math.min(baseline / 400, 1)
		local w_age = 1.0
		if o.t then
			local age = (LoGetModelTime() - o.t)
			-- downweight older point: exponential
			w_age = math.max(0.1, math.exp(-age / 6)) -- tune 6s time constant
		end

		local w = (w_angle^2) * (0.2 + 0.8 * w_baseline) * w_age -- tuneable formula
		weights[i] = w

		-- build M = I - d d^T
		local dd = outer(d)
		local M = {
			{1 - dd[1][1], -dd[1][2],    -dd[1][3]},
			{-dd[2][1],    1 - dd[2][2], -dd[2][3]},
			{-dd[3][1],    -dd[3][2],    1 - dd[3][3]}
		}
		-- weighted accumulation: A += w*M ; b += w*M*P
		local Mp = matVec(M, o.pos)
		for r = 1, 3 do
			for c = 1, 3 do
				A[r][c] = A[r][c] + w * M[r][c]
			end
		end
		b.x = b.x + w * Mp.x
		b.y = b.y + w * Mp.y
		b.z = b.z + w * Mp.z
	end

	-- solve A X = b
	local invA = inv3(A)
	if not invA then return nil end
	local X = matVec(invA, b)

	-- compute residuals (distance from X to each ray) and RMS
	local sumsq = 0
	local used = 0
	local residuals = {}
	for i, o in ipairs(obs) do
		local d = ds[i]
		local dist = pointLineDist(X, o.pos, d)
		residuals[i] = dist
		sumsq = sumsq + weights[i] * dist * dist
		used = used + 1
	end
	local rms = math.sqrt(sumsq / math.max(1, used))

	-- estimate covariance for X: Cov_X ≈ inv(A) * sigma_rms^2
	local Cov = nil
	if rms > 0 then
		-- scale invA by rms^2
		Cov = {
			{invA[1][1] * rms * rms, invA[1][2] * rms * rms, invA[1][3] * rms * rms},
			{invA[2][1] * rms * rms, invA[2][2] * rms * rms, invA[2][3] * rms * rms},
			{invA[3][1] * rms * rms, invA[3][2] * rms * rms, invA[3][3] * rms * rms}
		}
	else
		-- fallback small covariance
		Cov = {
			{1, 0, 0}, {0, 1, 0}, {0, 0, 1}
		}
	end

	return {pos = X, cov = Cov, rms = rms, used = used, residuals = residuals, weights = weights}
end

-- project covariance to range direction from ownship -> X
function rangeVarianceFromCov(Cov, ownPos, Xpos)
	local v = sub(Xpos, ownPos)
	local L = len(v)
	if L < 1e-6 then return 1e6 end
	local u = { x = v.x / L, y = v.y / L, z = v.z / L } -- unit vector
	-- var = u^T * Cov * u
	local tmp = {
		x = Cov[1][1]*u.x + Cov[1][2]*u.y + Cov[1][3]*u.z,
		y = Cov[2][1]*u.x + Cov[2][2]*u.y + Cov[2][3]*u.z,
		z = Cov[3][1]*u.x + Cov[3][2]*u.y + Cov[3][3]*u.z
	}
	local var = dot(u, tmp)
	return math.max(0, var)
end



local MAX_OBS = 8
local MIN_BASELINE = 80 -- meter
local MIN_ANGLE_DEG = 1.0
local MAX_AGE = 8 -- sekunder

function pruneObs(obs)
	if #obs < 2 then return end

	-- local now = LoGetModelTime()

	-- -- 1) kasta gamla observationer
	-- for i = #obs, 1, -1 do
	-- 	if now - (obs[i].t or now) > MAX_AGE then
	-- 		table.remove(obs, i)
	-- 	end
	-- end

	if #obs < 2 then return end

	-- 2) kasta observationer som är för lika varandra
	for i = #obs, 2, -1 do
		local o1 = obs[i]
		local o0 = obs[i - 1]

		local dp = sub(o1.pos, o0.pos)
		local baseline = math.sqrt(dot(dp, dp))

		local d1 = worldDirFromObs(o1)
		local d0 = worldDirFromObs(o0)
		local angle = math.deg(math.acos(math.max(-1, math.min(1, dot(d1, d0)))))

		if baseline < MIN_BASELINE or angle < MIN_ANGLE_DEG then
			table.remove(obs, i)
		end
	end

	-- 3) behåll bara senaste MAX_OBS
	while #obs > MAX_OBS do
		table.remove(obs, 1)
	end
end

function triangulationConfidence(obs)
	if #obs < 2 then return 0 end

	local angles = {}
	local maxBaseline = 0

	for i = 2, #obs do
		local d1 = worldDirFromObs(obs[i])
		local d0 = worldDirFromObs(obs[1])

		local angle = math.deg(math.acos(
			math.max(-1, math.min(1, dot(d0, d1)))
		))
		table.insert(angles, angle)

		local dp = sub(obs[i].pos, obs[1].pos)
		maxBaseline = math.max(maxBaseline, math.sqrt(dot(dp, dp)))
	end

	-- geometri-score
	local avgAngle = 0
	for _, a in ipairs(angles) do avgAngle = avgAngle + a end
	avgAngle = avgAngle / #angles

	local angleScore = math.min(avgAngle / 8, 1) -- >8° är bra
	local baselineScore = math.min(maxBaseline / 400, 1)
	local countScore = math.min(#obs / 6, 1)

	return angleScore * baselineScore * countScore
end




need_to_be_closed = false



-- TODO:
-- Triangulation
-- Memory (if SAM was lost, remember until active again)
-- New contact blink
-- Threat circles
-- Variables keep to the same RWR ID