dofile(LockOn_Options.script_path .. "command_defs.lua")
dofile(LockOn_Options.script_path .. "devices.lua")



local updateTimeStep = 1 / 180 -- Refresh rate of device script.
make_default_activity(updateTimeStep)


local FD = GetSelf()


local pCAS         = get_param_handle("CAS")
local txtCAS       = get_param_handle("txtCAS")
local txtGS        = get_param_handle("txtGS")
local machWhole    = get_param_handle("machWhole")
local machDecimals = get_param_handle("machDecimals")

local AoA = get_param_handle("AoA")

local altMode = get_param_handle("altMode")
local altTape = get_param_handle("altTape")
local txtAlt  = get_param_handle("txtAlt")
local txtRalt = get_param_handle("txtRalt")

local pitchRad = get_param_handle("pitchRad")
local rollRad = get_param_handle("rollRad")

local currentPhase = get_param_handle("currentPhase")


local baseData = get_base_data()


local MS_TO_KTS = 1.94384449
local M_TO_FT = 3.28083989501312335958


local CAS, selfVelL, selfVelV, selfVelH, GS, mach
local spdUpdateFreq = 0.3

local baroAlt, rAlt



function post_initialize()
	show_param_handles_list(true) -- For testing.
end

function update()
	CAS = baseData.getIndicatedAirSpeed() * MS_TO_KTS
	selfVelL, selfVelV, selfVelH = baseData.getSelfAirspeed() -- Prereq for ground speed in kts.
	GS = math.sqrt(selfVelL^2 + selfVelH^2) * MS_TO_KTS

	if CAS > 80 then
		pCAS:set(CAS)
	else
		pCAS:set(GS)
	end


	if spdUpdateFreq >= 0.3 then
		if GS > 5 or CAS > 5 then
			if currentPhase:get() <= 4 or currentPhase:get() == 10 then
				if CAS > 80 then
					txtCAS:set(CAS)
				else
					txtCAS:set(GS)
				end
			else
				txtCAS:set(CAS)
			end

			txtGS:set(GS)
		else
			txtCAS:set(0)
		end

		spdUpdateFreq = 0
	else
		spdUpdateFreq = spdUpdateFreq + updateTimeStep
	end


	mach = baseData.getMachNumber()

	if mach > 0.15 then
		machWhole:set(mach)

		machDec = mach * 0.1

		if machDec < 0.995 then
			machDec = machDec * 1000
		end

		machDecimals:set(machDec)
	else
		machWhole:set(0)
		machDecimals:set(0)
	end



	if (GS >= 40 and currentPhase:get() <= 4) or CAS >= 40 then
		AoA:set(math.deg(baseData.getAngleOfAttack()))
	else
		AoA:set(0)
	end



	pitchRad:set(baseData.getPitch())
	rollRad:set(baseData.getRoll())



	baroAlt = baseData.getBarometricAltitude() * M_TO_FT
	if math.abs(math.deg(pitchRad:get())) >= 30 or math.abs(math.deg(rollRad:get())) >= 30 then
		rAlt = get_param_handle("GPSAlt"):get() - get_param_handle("terrainAlt"):get()
	else
		rAlt = baseData.getRadarAltitude() * M_TO_FT
	end


	txtAlt:set(math.floor((baroAlt + 5) / 10) * 10)
	txtRalt:set(math.floor((rAlt + 5) / 10) * 10)

	if altMode:get() == 1 then
		altTape:set(baroAlt)
	elseif altMode:get() == 2 then
		altTape:set(rAlt)
	end
end

function SetCommand(command, value)

end



need_to_be_closed = false