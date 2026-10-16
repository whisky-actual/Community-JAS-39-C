-- This script exists for the sole purpose of giving us the getAmmoCount() function.
-- Don't remove this script, use GetDevice(devices["gun"]):getAmmoCount() to get the amount of ammunition left in the gun.



dofile(LockOn_Options.script_path .. "command_defs.lua")
dofile(LockOn_Options.script_path .. "devices.lua")
dofile(LockOn_Options.script_path .. "utils.lua")



local updateTimeStep = 1 / 120 -- Refresh rate of device script.
make_default_activity(updateTimeStep)


local gun = GetSelf()
local baseData = get_base_data()
--------------------------------------------------------------------------------
-- gunPiper.lua  (v3)  -  Predictive gun pipper for the Gripen mod
--
-- Pipeline
--   1. RADAR_STT_AZIMUTH / ELEVATION are HUD-frame angles that were rotated by
--      the aircraft roll.  They are rotated BACK by roll to get the direction in
--      the roll-free (leveled) frame, then turned into a world-frame target
--      position with heading + pitch only.  Roll never enters the world track.
--   2. A g-h-k filter on the inertial target position gives velocity and
--      acceleration. Closure speed comes from it (STT_Closure_Speed is written).
--   3. Bullet flight (aircraft velocity + muzzle velocity, drag, gravity) is
--      iterated until bullet and predicted target meet at the same time.
--   4. Pipper = lead offset in the leveled frame, smoothed, then rotated by roll
--      into the HUD frame (the same rotation the radar angles went through).
--
-- The direction of the roll rotation applied to the radar angles is not known
-- for sure, so two trackers (+roll / -roll) run side by side and the one with
-- the smoother track wins (roll_sign = 0).  Set roll_sign to +1 / -1 once known.
--
-- Units: SI only.  World (DCS local): x north, y up, z east.
-- Leveled / body axes: x forward, y up, z right.
--
-- Outputs (rad, same sign convention as RADAR_STT_AZIMUTH / ELEVATION):
--   GunPiperAz / GunPiperElev : put the target icon here for the shot to hit
--   GunLeadAz  / GunLeadElev  : where the gun line must point (aim point)
--   GunPiperValid             : 1 = show piper
--   STT_Closure_Speed         : closing speed [m/s], positive = closing
--------------------------------------------------------------------------------

if limit == nil then
	function limit(x, lo, hi)
		if lo > hi then lo, hi = hi, lo end
		if x ~= x then return lo end
		if x < lo then return lo end
		if x > hi then return hi end
		return x
	end
end

local sqrt, sin, cos, asin, exp, log, abs = math.sqrt, math.sin, math.cos, math.asin, math.exp, math.log, math.abs
local atan2 = math.atan2 or function (y, x) return math.atan(y, x) end
local G = 9.80665

--------------------------------------------------------------------------------
-- Configuration
--------------------------------------------------------------------------------
local CFG = {
	-- Ballistics (default: 27 mm BK-27 HE, approximate - match your shell table)
	muzzle_velocity = 1025, -- [m/s]
	shell_mass      = 0.26, -- [kg]
	shell_diameter  = 0.027, -- [m]
	shell_cd        = 0.35, -- average drag coefficient

	-- Ranges
	default_range = 457, -- [m] virtual target range when not in STT
	min_range     = 10, -- [m]
	max_range     = 3000, -- [m] piper hidden beyond this

	-- Tracker
	filter_tau       = 0.3, -- [s] track smoothing (larger = smoother, laggier)
	settle_time      = 0.5, -- [s] piper hidden this long after (re)acquiring
	accel_gain       = 1.0, -- 0 = ignore target acceleration, 1 = full
	max_target_accel = 150, -- [m/s^2]
	stale_time       = 1.0, -- [s] no radar update for this long -> restart
	jump_range       = 150, -- [m]   range jump that means a different target
	jump_angle       = 0.3, -- [rad] angle jump that means a different target
	output_tau       = 0.05, -- [s] pipper smoothing (0 = off), done in the roll-free frame

	max_tof = 8, -- [s]

	-- Interfaces / conventions
	stt_mode     = 3, -- RADAR_MODE value for STT
	az_sign      = 1, -- +1: azimuth positive right, elevation positive up
	el_sign      = 1,
	roll_sign    = 0, -- 0 = auto, +1 / -1 = fixed direction of the roll rotation
	heading_sign = 1, -- +1: heading increases clockwise from north
	pitch_sign   = 1, -- +1: nose up positive
	angle_scale  = math.pi/2, -- 1 = radians (per DCS docs); pi/180 if your build gives degrees
	max_output   = 1.0, -- [rad]

	debug = true -- print diagnostics once per second
}

--------------------------------------------------------------------------------
-- Param handles
--------------------------------------------------------------------------------
local GunPiperElev  = get_param_handle("GunPiperElev")
local GunPiperAz    = get_param_handle("GunPiperAz")
local GunLeadElev   = get_param_handle("GunLeadElev")
local GunLeadAz     = get_param_handle("GunLeadAz")
local GunPiperValid = get_param_handle("GunPiperValid")
local ClosureOut    = get_param_handle("STT_Closure_Speed")
local RadarMode     = get_param_handle("RADAR_MODE")
local SttRange      = get_param_handle("RADAR_STT_RANGE")
local SttAz         = get_param_handle("RADAR_STT_AZIMUTH")
local SttEl         = get_param_handle("RADAR_STT_ELEVATION")

--------------------------------------------------------------------------------
-- Derived constants
--------------------------------------------------------------------------------
local RHO0      = 1.225
local AREA      = math.pi * (CFG.shell_diameter / 2)^2
-- Bullet speed: V(t) = V0 / (1 + V0*t/LAMBDA),  LAMBDA = 2m / (rho*Cd*A)
local LAMBDA_SL = 2 * CFG.shell_mass / (RHO0 * CFG.shell_cd * AREA)
local DTS       = 0.05
local NSTEPS    = math.floor(CFG.max_tof / DTS)
local SCORE_TAU = 2.0

--------------------------------------------------------------------------------
-- State
--------------------------------------------------------------------------------
local clock, last_time = 0, nil
local last_dbg = -10
local OWN = {0, 0, 0}   -- dead-reckoned own position
local pvx, pvy, pvz, own_have = 0, 0, 0, false
local last_raw = {0, 0, 0}
local last_stt = false
local n_warm = nil
local pip_s = {az = 0, el = 0, laz = 0, lel = 0, ok = false}   -- smoothed pipper + lead offset, roll-free frame
local S = {}                                                   -- solver registers

local function new_tracker()
	return {
		X = {0, 0, 0},
		V = {0, 0, 0},
		A = {0, 0, 0},
		Z = {0, 0, 0},
		count = 0,
		t_meas = 0,
		t_start = 0,
		score = 0
	}
end
local TRK = {new_tracker(), new_tracker()}   -- hypothesis 1: +roll, 2: -roll
local HYP = {1, -1}
local sel = (CFG.roll_sign < 0) and 2 or 1

--------------------------------------------------------------------------------
-- Helpers
--------------------------------------------------------------------------------
local function air_density(h)
	h = limit(h, 0, 20000)
	if h < 11000 then
		return RHO0 * (1 - 2.25577e-5 * h)^4.25588
	end
	return 0.36392 * exp(-(h - 11000) / 6341.62)
end

-- Roll-free (leveled) axes in world coordinates from heading and pitch.
local function level_axes(h, p)
	local ch, sh, cp, sp = cos(h), sin(h), cos(p), sin(p)
	local fx, fy, fz = cp * ch, sp, cp * sh                                 -- forward
	local rx, ry, rz = -sh, 0, ch                                           -- right, horizontal
	local ux, uy, uz = ry * fz - rz * fy, rz * fx - rx * fz, rx * fy - ry * fx -- up
	return fx, fy, fz, ux, uy, uz, rx, ry, rz
end

-- Rotate a direction given as (az, el) about the boresight by psi (right wing down = +)
local function roll_angles(az, el, psi)
	local ce = cos(el)
	local y, z = sin(el), ce * sin(az)
	local x = ce * cos(az)
	local cs, sn = cos(psi), sin(psi)
	local y2, z2 = y * cs + z * sn, -y * sn + z * cs
	return atan2(z2, x), asin(limit(y2, -1, 1))
end

local function tick()
	local dt
	if get_model_time then
		local t = get_model_time()
		dt = last_time and (t - last_time) or (update_rate or update_time_step or 0.02)
		if last_time and t < last_time then -- mission restarted
			for k = 1, 2 do TRK[k].count = 0 end
			n_warm, own_have, pip_s.ok, dt = nil, false, false, 0
		end
		last_time, clock = t, t
	else
		dt = update_rate or update_time_step or 0.02
		clock = clock + dt
	end
	return limit(dt, 0, 0.1)
end

local function reset_tracks()
	for k = 1, 2 do TRK[k].count = 0 end
	n_warm, pip_s.ok = nil, false
end

-- g-h-k fading-memory filter; also scores the innovation (track smoothness)
local function trk_update(tk, z, T)
	local X, V, A = tk.X, tk.V, tk.A
	tk.count = tk.count + 1
	if tk.count == 1 then
		tk.t_start = clock
		for i = 1, 3 do X[i], V[i], A[i] = z[i], 0, 0 end
	elseif tk.count == 2 then
		for i = 1, 3 do
			V[i] = (z[i] - X[i]) / T; X[i] = z[i]; A[i] = 0
		end
	else
		local th = exp(-T / CFG.filter_tau)
		local g = 1 - th^3
		local h = 1.5 * (1 - th)^2 * (1 + th)
		local k = 0.5 * (1 - th)^3
		local inn = 0
		for i = 1, 3 do
			local xp  = X[i] + V[i] * T + 0.5 * A[i] * T * T
			local vp  = V[i] + A[i] * T
			local res = z[i] - xp
			inn       = inn + res * res
			X[i]      = xp + g * res
			V[i]      = vp + h / T * res
			A[i]      = A[i] + 2 * k / (T * T) * res
		end
		tk.score = tk.score + (1 - exp(-T / SCORE_TAU)) * (sqrt(inn) - tk.score)
	end
	tk.Z[1], tk.Z[2], tk.Z[3] = z[1], z[2], z[3]
	tk.t_meas = clock
end

-- Pick the roll-rotation direction that gives the smoother target track
local function select_hypothesis()
	if CFG.roll_sign ~= 0 then
		sel = (CFG.roll_sign < 0) and 2 or 1
		return
	end
	local a, b = TRK[1].score, TRK[2].score
	if sel == 1 and a > 2.5 * b + 0.5 then
		sel = 2
	elseif sel == 2 and b > 2.5 * a + 0.5 then
		sel = 1
	end
end

-- Predicted target position relative to own aircraft, t seconds from now
local function target_at(t)
	local h = 0.5 * t * t
	return S.rx + S.vtx * t + S.atx * h,
		S.ry + S.vty * t + S.aty * h,
		S.rz + S.vtz * t + S.atz * h
end

-- Fly a bullet along (nx,ny,nz) until it passes the predicted target along the
-- barrel direction. Returns T, miss vector (target - bullet), path length.
local function intercept(nx, ny, nz)
	local VM, lam = CFG.muzzle_velocity, S.lam
	local px, py, pz = 0, 0, 0
	local vx, vy, vz = S.vox + VM * nx, S.voy + VM * ny, S.voz + VM * nz
	local pu = S.rx * nx + S.ry * ny + S.rz * nz
	if pu <= 0 then return nil end
	local hk = G * DTS * 0.5

	for i = 1, NSTEPS do
		local ox, oy, oz = px, py, pz
		vy = vy - hk -- half gravity kick
		local sp = sqrt(vx * vx + vy * vy + vz * vz)
		local q = sp * DTS / lam
		local k = lam * log(1 + q) / sp -- exact drag step
		px, py, pz = px + vx * k, py + vy * k, pz + vz * k
		local sc = 1 / (1 + q)
		vx, vy, vz = vx * sc, vy * sc - hk, vz * sc -- half gravity kick

		local tx, ty, tz = target_at(i * DTS)
		local u = (tx - px) * nx + (ty - py) * ny + (tz - pz) * nz
		if u <= 0 then
			local f = pu / (pu - u)
			local T = (i - 1 + f) * DTS
			local bx, by, bz = ox + (px - ox) * f, oy + (py - oy) * f, oz + (pz - oz) * f
			tx, ty, tz = target_at(T)
			return T, tx - bx, ty - by, tz - bz, sqrt(bx * bx + by * by + bz * bz)
		end
		pu = u
	end
	return nil
end

local function solve_aim(nx, ny, nz)
	local VM = CFG.muzzle_velocity
	local T
	for _ = 1, 6 do
		local mx, my, mz, s
		T, mx, my, mz, s = intercept(nx, ny, nz)
		if not T then return nil end
		local par = mx * nx + my * ny + mz * nz
		local ex, ey, ez = mx - par * nx, my - par * ny, mz - par * nz
		local sens = s * VM / (VM + S.va) -- impact shift per rad of launch angle
		local cx, cy, cz = ex / sens, ey / sens, ez / sens
		nx, ny, nz = nx + cx, ny + cy, nz + cz
		local len = sqrt(nx * nx + ny * ny + nz * nz)
		nx, ny, nz = nx / len, ny / len, nz / len
		if cx * cx + cy * cy + cz * cz < 2.5e-9 then break end
	end
	return nx, ny, nz, T
end

--------------------------------------------------------------------------------
-- Main update (call every frame)
--------------------------------------------------------------------------------
function updateAAGunPiper()
	local dt = tick()
	if dt <= 0 then return end
	local sd = sensor_data or get_base_data()

	-- Own aircraft -----------------------------------------------------------
	local vx, vy, vz = sd.getSelfVelocity()
	if own_have then
		OWN[1] = OWN[1] + 0.5 * (pvx + vx) * dt
		OWN[2] = OWN[2] + 0.5 * (pvy + vy) * dt
		OWN[3] = OWN[3] + 0.5 * (pvz + vz) * dt
	end
	pvx, pvy, pvz, own_have = vx, vy, vz, true
	local va = sqrt(vx * vx + vy * vy + vz * vz)

	local sc                                 = CFG.angle_scale
	local heading                            = CFG.heading_sign * sc * sd.getHeading()
	local pitch                              = CFG.pitch_sign * sc * sd.getPitch()
	local roll                               = sc * sd.getRoll()
	local fx, fy, fz, ux, uy, uz, rx, ry, rz = level_axes(heading, pitch)

	-- Radar -------------------------------------------------------------------
	local stt = RadarMode:get() == CFG.stt_mode
	local range = stt and SttRange:get() or 0
	if not range or range < CFG.min_range then stt = false end

	if stt ~= last_stt or (TRK[1].count > 0 and clock - TRK[1].t_meas > CFG.stale_time) then
		reset_tracks()
	end
	last_stt = stt

	local D, gx, gy, gz = CFG.default_range, 1, 0, 0 -- default: virtual target on boresight
	local az_b, el_b = 0, 0
	local new_data = true
	if stt then
		D = range
		local raw_az, raw_el = SttAz:get(), SttEl:get()
		new_data = (range ~= last_raw[1]) or (raw_az ~= last_raw[2]) or (raw_el ~= last_raw[3])
		if new_data and TRK[1].count > 0 then
			local T = clock - TRK[1].t_meas
			local dang = sqrt((raw_az - last_raw[2])^2 + (raw_el - last_raw[3])^2)
			if abs(range - last_raw[1]) > CFG.jump_range + 900 * T or dang > CFG.jump_angle + 5 * T then
				reset_tracks()
			end
		end
		last_raw[1], last_raw[2], last_raw[3] = range, raw_az, raw_el
		az_b, el_b = CFG.az_sign * raw_az, CFG.el_sign * raw_el
		local ce = cos(el_b)
		gx, gy, gz = ce * cos(az_b), sin(el_b), ce * sin(az_b)
	end

	-- Trackers (one per roll direction) ------------------------------------------
	if new_data then
		for k = 1, 2 do
			local tk = TRK[k]
			-- rotate HUD-frame direction back by roll -> roll-free frame
			local psi = HYP[k] * roll
			local cp_, sp_ = cos(psi), sin(psi)
			local ny = gy * cp_ - gz * sp_
			local nz = gy * sp_ + gz * cp_
			local z = {
				OWN[1] + D * (gx * fx + ny * ux + nz * rx),
				OWN[2] + D * (gx * fy + ny * uy + nz * ry),
				OWN[3] + D * (gx * fz + ny * uz + nz * rz)}
			local T = clock - tk.t_meas
			if tk.count == 0 or T > 1e-4 then
				trk_update(tk, z, math.max(T, 1e-3))
			end
		end
		select_hypothesis()
	end

	local tk = TRK[sel]
	local psi = HYP[sel] * roll

	-- Target state now ----------------------------------------------------------------
	local age = clock - tk.t_meas
	local h = 0.5 * age * age
	local Rx = tk.Z[1] + tk.V[1] * age + tk.A[1] * h - OWN[1]
	local Ry = tk.Z[2] + tk.V[2] * age + tk.A[2] * h - OWN[2]
	local Rz = tk.Z[3] + tk.V[3] * age + tk.A[3] * h - OWN[3]
	local rng = sqrt(Rx * Rx + Ry * Ry + Rz * Rz)

	local vtx, vty, vtz = tk.V[1] + tk.A[1] * age, tk.V[2] + tk.A[2] * age, tk.V[3] + tk.A[3] * age
	local atx, aty, atz = tk.A[1] * CFG.accel_gain, tk.A[2] * CFG.accel_gain, tk.A[3] * CFG.accel_gain
	local am = sqrt(atx * atx + aty * aty + atz * atz)
	if am > CFG.max_target_accel then
		local s = CFG.max_target_accel / am
		atx, aty, atz = atx * s, aty * s, atz * s
	end

	local closure = -((Rx * (vtx - vx) + Ry * (vty - vy) + Rz * (vtz - vz)) / rng)
	ClosureOut:set(stt and closure or 0)

	local settled = tk.count >= 3 and (clock - tk.t_start) >= CFG.settle_time
	if not settled or rng > CFG.max_range or rng < CFG.min_range then
		pip_s.ok = false
		GunPiperValid:set(0)
		return
	end

	-- Ballistic solution -----------------------------------------------------------------
	S.rx, S.ry, S.rz = Rx, Ry, Rz
	S.vtx, S.vty, S.vtz = vtx, vty, vtz
	S.atx, S.aty, S.atz = atx, aty, atz
	S.vox, S.voy, S.voz = vx, vy, vz
	S.va = va
	S.lam = LAMBDA_SL * RHO0 / air_density(sd.getBarometricAltitude())

	local nx, ny, nz, TOF
	if n_warm then
		nx, ny, nz = n_warm[1], n_warm[2], n_warm[3]
	else
		nx, ny, nz = Rx / rng, Ry / rng, Rz / rng
	end
	nx, ny, nz, TOF = solve_aim(nx, ny, nz)
	if not nx then
		n_warm, pip_s.ok = nil, false
		GunPiperValid:set(0)
		return
	end
	n_warm = {nx, ny, nz}

	-- Lead in the roll-free frame ----------------------------------------------------
	-- Lead point: aim direction n.  Pipper: where the target appears once the
	-- nose has been turned (heading/pitch only) onto n.
	local az_n = atan2(nx * rx + ny * ry + nz * rz, nx * fx + ny * fy + nz * fz)
	local el_n = asin(limit(nx * ux + ny * uy + nz * uz, -1, 1))
	local nfx, nfy, nfz, nux, nuy, nuz, nrx, nry, nrz = level_axes(atan2(nz, nx), el_n)
	local tx, ty, tz = Rx / rng, Ry / rng, Rz / rng
	local p_az = atan2(tx * nrx + ty * nry + tz * nrz, tx * nfx + ty * nfy + tz * nfz)
	local p_el = asin(limit(tx * nux + ty * nuy + tz * nuz, -1, 1))
	-- Lead point = target direction + lead offset.  Only the (slowly changing)
	-- offsets are smoothed, so the result follows the target without lag.
	local az_t = atan2(tx * rx + ty * ry + tz * rz, tx * fx + ty * fy + tz * fz)
	local el_t = asin(limit(tx * ux + ty * uy + tz * uz, -1, 1))
	local d_az, d_el = az_n - az_t, el_n - el_t

	if pip_s.ok and CFG.output_tau > 0 then
		local a   = 1 - exp(-dt / CFG.output_tau)
		pip_s.az  = pip_s.az + a * (p_az - pip_s.az)
		pip_s.el  = pip_s.el + a * (p_el - pip_s.el)
		pip_s.laz = pip_s.laz + a * (d_az - pip_s.laz)
		pip_s.lel = pip_s.lel + a * (d_el - pip_s.lel)
	else
		pip_s.az, pip_s.el, pip_s.laz, pip_s.lel, pip_s.ok = p_az, p_el, d_az, d_el, true
	end

	-- Back into the HUD frame: same roll rotation the radar angles went through
	local pip_az, pip_el = roll_angles(pip_s.az, pip_s.el, psi)
	local lead_az, lead_el = roll_angles(az_t + pip_s.laz, el_t + pip_s.lel, psi)

	local m = CFG.max_output
	GunPiperAz:set(CFG.az_sign * limit(pip_az, -m, m))
	GunPiperElev:set(CFG.el_sign * limit(pip_el, -m, m))
	GunLeadAz:set(CFG.az_sign * limit(lead_az, -m, m))
	GunLeadElev:set(CFG.el_sign * limit(lead_el, -m, m))
	GunPiperValid:set(1)

	-- Diagnostics -----------------------------------------------------------------------
	if CFG.debug and print_message_to_user and clock - last_dbg > 1 then
		last_dbg = clock
		local d2r = 180 / math.pi
		local trk_deg = atan2(vz, vx)
		local dh = ((heading - trk_deg + math.pi) % (2 * math.pi) - math.pi) * d2r
		local gamma = asin(limit(vy / math.max(va, 1), -1, 1))
		local aoa = sd.getAngleOfAttack and sd.getAngleOfAttack() or 0
		print_message_to_user(
			string.format(
				"GunPiper: roll dir %+d (scores %.2f / %.2f m) | heading-track %.1f deg | pitch %.1f vs path+AoA %.1f deg | closure %.0f m/s | TOF %.2f s | pip %.1f/%.1f mrad",
				HYP[sel], TRK[1].score, TRK[2].score, dh, pitch * d2r, (gamma + aoa) * d2r,
				closure, TOF, pip_az * 1000, pip_el * 1000), 1
		)
	end
end


function update()
	--updateAAGunPiper()
end




need_to_be_closed = false