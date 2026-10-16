dofile(LockOn_Options.script_path .. "command_defs.lua")
local update_time_step = 0.006 -- same as efm
make_default_activity(update_time_step)
local FBW = GetSelf()
local sensor_data = get_base_data()

FBW:listen_command(keys.S3_AimingMode)
FBW:listen_command(keys.S4_AltitudeHold)
FBW:listen_command(deviceCommands.AP_ALT)
FBW:listen_command(deviceCommands.AP_ATT)
FBW:listen_command(deviceCommands.AP_MAN)


TRSAFE = get_param_handle("TRIGGER_SAFE_PARAM")
local Alfa = 0
local Alfa_dot = 0
local Alfa_prev = 0

function SetCommand(command, value)

	if command == keys.S3_AimingMode and TRSAFE:get() == 1 and get_param_handle("AimingMode"):get() == 0 then -- Cycle pitch rate / Nz
		get_param_handle("AimingMode"):set(1)
	elseif command == keys.S3_AimingMode and get_param_handle("AimingMode"):get() == 1 then
		get_param_handle("AimingMode"):set(0)
	elseif command == keys.S3_AimingMode and TRSAFE:get() == 0 and get_param_handle("MASTERMODE"):get() == 0 then
		dispatch_action(OP_PHASES, 10060)
	elseif get_param_handle("LANDING_MODE"):get() == 1 and get_param_handle("MASTERMODE"):get() ~= 0 then
		dispatch_action(OP_PHASES, 10060)
	elseif get_param_handle("MASTERMODE"):get() ~= 0 and command == keys.S3_AimingMode and TRSAFE:get() == 0 then
		get_param_handle("MASTERMODE"):set(0)
	elseif get_param_handle("MASTERMODE"):get() == 0 and TRSAFE:get() == 1 and get_param_handle("LANDING_MODE"):get() == 1 then
		dispatch_action(OP_PHASES, 10060)
	end

	if command == deviceCommands.AP_ALT or command == keys.S4_AltitudeHold then
		if get_param_handle("AutoPilotMode"):get() ~= 2 then
			get_param_handle("AutoPilotMode"):set(2)
		else
			get_param_handle("AutoPilotMode"):set(0)
		end
	end

	if command == deviceCommands.AP_ATT then
		if get_param_handle("AutoPilotMode"):get() ~= 1 then
			get_param_handle("AutoPilotMode"):set(1)
		else
			get_param_handle("AutoPilotMode"):set(0)
		end
	end

	if command == deviceCommands.AP_MAN then
		get_param_handle("AutoPilotMode"):set(0)
	end

end





function post_initialize()
	-- show_param_handles_list(true)

	TargetNzGains()
	TargetNyGains()
	TargetRollrategains()
	TargetPitchrategains()
	TargetYawrateGains()
	AutoPilot()
	SetLimits()
end


function TargetNzGains()
	get_param_handle("nz_PID_Kp"):set(6000)
	get_param_handle("nz_PID_Ki"):set(2750)
	get_param_handle("nz_PID_Kd"):set(256)
end


function TargetPitchrategains()
	-- TODO: Tweak these values when Aiming Mode is activiated to fix the osilation problem.

	if get_param_handle("AimingMode"):get() == 1 then
		get_param_handle("q_PID_Kp"):set(78000 * .7)
		get_param_handle("q_PID_Ki"):set((78000 * .7) / 2)
		get_param_handle("q_PID_Kd"):set(256 * 2)
	else
		get_param_handle("q_PID_Kp"):set(78000)
		get_param_handle("q_PID_Ki"):set(0)
		get_param_handle("q_PID_Kd"):set(256)
	end
end


function TargetRollrategains()
	-- TODO: Tweak these values (prob calculated for a clean loadout) to change with weight to fix the problem of slacky roll when having a full loadout.
	get_param_handle("p_PID_Kp"):set(21768)
	get_param_handle("p_PID_Ki"):set(5220)
	get_param_handle("p_PID_Kd"):set(167)
end


function TargetNyGains()
	get_param_handle("ny_PID_Kp"):set(8000)
	get_param_handle("ny_PID_Ki"):set(6000)
	get_param_handle("ny_PID_Kd"):set(5)
end


function TargetYawrateGains()
	get_param_handle("r_PID_Kp"):set(4000)
	get_param_handle("r_PID_Ki"):set(0)
	get_param_handle("r_PID_Kd"):set(5)
end


function AutoPilot()
	get_param_handle("Altitude_Kp"):set(0.0069)
	get_param_handle("Altitude_Ki"):set(0.0)
	get_param_handle("Altitude_Kd"):set(0.01337)

	get_param_handle("PitchAttitude_Kp"):set(1)
	get_param_handle("PitchAttitude_Ki"):set(1)
	get_param_handle("PitchAttitude_Kd"):set(1)

	get_param_handle("RollAttitude_Kp"):set(0.5)
	get_param_handle("RollAttitude_Ki"):set(0)
	get_param_handle("RollAttitude_Kd"):set(0.01)


	get_param_handle("rollyawinterconnect_r"):set(3500)
	get_param_handle("rollyawinterconnect_a"):set(1500)
	get_param_handle("rollyawinterconnect_b"):set(1500)
end


function SetLimits()
	get_param_handle("ny_min"):set(-1)
	get_param_handle("ny_max"):set(1)

	get_param_handle("r_min"):set(-1)
	get_param_handle("r_max"):set(1)

	get_param_handle("p_min"):set(-0.33333)
	get_param_handle("p_max"):set(0.33333)

	get_param_handle("q_max"):set(AlphaLimit(true))
	get_param_handle("q_min"):set(AlphaLimit(false))

	get_param_handle("nz_max"):set(AlphaLimit(true))
	get_param_handle("nz_min"):set(AlphaLimit(false))

	get_param_handle("Altitude_max"):set(2)
	get_param_handle("Altitude_min"):set(-2)

	get_param_handle("PitchAttitude_max"):set(1)
	get_param_handle("PitchAttitude_min"):set(-1)

	get_param_handle("RollAttitude_max"):set(1)
	get_param_handle("RollAttitude_min"):set(-1)

end


function AlphaLimit(Positive)

	Alfa = sensor_data.getAngleOfAttack()
	Alfa_dot = (Alfa - Alfa_prev) / update_time_step

	Alfa_prev = Alfa


	if Positive == true then
		return math.rad(26.49) - sensor_data.getAngleOfAttack() - Alfa_dot
	else
		return math.rad(-9) - sensor_data.getAngleOfAttack() - Alfa_dot
	end
end





function EFM()
	local nz = sensor_data.getVerticalAcceleration()
	local ny = sensor_data.getLateralAcceleration()


	get_param_handle("Curr_Nzlua"):set(nz) -- G force in pitch axis
	get_param_handle("Curr_Nylua"):set(ny) -- G force in yaw axis



	local t = 0

	if math.abs(nz) < 1 then
		t = 1
	else
		t = math.abs(nz)
	end

	local NzOnset = 14 / t

	get_param_handle("Autotrim_Onset"):set(NzOnset)

end


function update()
	EFM()


	get_param_handle("q_max"):set(AlphaLimit(true))
	get_param_handle("q_min"):set(AlphaLimit(false))

	get_param_handle("nz_max"):set(AlphaLimit(true))
	get_param_handle("nz_min"):set(AlphaLimit(false))


	-- if TRSAFE:get() == 0 then
	-- get_param_handle("AimingMode"):set(0)
	-- end


end

need_to_be_closed = 0



-- getAngleOfAttack()
-- getAngleOfSlide()
-- getBarometricAltitude()
-- getCanopyPos()
-- getCanopyState()
-- getEngineLeftFuelConsumption()
-- getEngineLeftRPM()
-- getEngineLeftTemperatureBeforeTurbine()
-- getEngineRightFuelConsumption()
-- getEngineRightRPM()
-- getEngineRightTemperatureBeforeTurbine()
-- getFlapsPos()
-- getFlapsRetracted()
-- getHeading()
-- getHorizontalAcceleration()
-- getIndicatedAirSpeed()
-- getLandingGearHandlePos()
-- getLateralAcceleration()
-- getLeftMainLandingGearDown()
-- getLeftMainLandingGearUp()
-- getMachNumber()
-- getMagneticHeading()
-- getNoseLandingGearDown()
-- getNoseLandingGearUp()
-- getPitch()
-- getRadarAltitude()
-- getRateOfPitch()
-- getRateOfRoll()
-- getRateOfYaw()
-- getRightMainLandingGearDown()
-- getRightMainLandingGearUp()
-- getRoll()
-- getRudderPosition()
-- getSpeedBrakePos()
-- getSelfAirspeed()
-- getSelfCoordinates()
-- getSelfVelocity()
-- getStickPitchPosition()
-- getStickRollPosition()
-- getThrottleLeftPosition()
-- getThrottleRightPosition()
-- getTotalFuelWeight()
-- getTrueAirSpeed()
-- getVerticalAcceleration()
-- getVerticalVelocity()
-- getWOW_LeftMainLandingGear()
-- getWOW_NoseLandingGear()
-- getWOW_RightMainLandingGear()