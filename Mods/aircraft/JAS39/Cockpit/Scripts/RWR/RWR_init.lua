dofile(LockOn_Options.common_script_path .. "devices_defs.lua")
dofile(LockOn_Options.script_path .. "command_defs.lua")
dofile(LockOn_Options.script_path .. "devices.lua")
dofile(LockOn_Options.script_path .. "RWR/symboles.lua")



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
MaxThreats       = 20
EmitterLiveTime  = 11
EmitterSoundTime = 0.5
LaunchSoundDelay = 15

DefaultType         = 100
RWR_detection_coeff = 0.85
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
		AZIMUTH = get_param_handle(contactSTR .. "AZIMUTH"), -- Azimuth of the contact in radians (0 to 2pi).
		ELEVATION = get_param_handle(contactSTR .. "ELEVATION"), -- Elevation of the contact in radians (-pi to pi).
		POWER = get_param_handle(contactSTR .. "POWER"),   -- Signal strength of the contact (0 = lowest, 1 = highest).

		GENERAL_TYPE = get_param_handle(contactSTR .. "GENERAL_TYPE"), -- "General type" of the contact (EWR = 0, plane = 1, search radar = 2, ship = 3, missile = 4).
		UNIT_TYPE = get_param_handle(contactSTR .. "UNIT_TYPE"), -- Full DCS name of contact (ex: E-3A, MOSCOW).

		SIGNAL = get_param_handle(contactSTR .. "SIGNAL"), -- Type of tracking (1 = search, 2 = lock, 3 = launch).
		TIME = get_param_handle(contactSTR .. "TIME"), -- Time since last ping.
		SOURCE = get_param_handle(contactSTR .. "SOURCE"), -- Returns seemingly big random number, might be radar wave frequency?

		PRIORITY = get_param_handle(contactSTR .. "PRIORITY"), -- Number of how "important" the contact is, bigger number = higher priority.

		-- Custom:
		heading = get_param_handle(contactSTR .. "heading"), -- The heading of the contact in radians (0 to 2pi).
		medium = get_param_handle(contactSTR .. "medium"), -- The medium of the contact (surface = 1, air = 2).
		range = get_param_handle(contactSTR .. "range"), -- Range from ownship, better visual distribution than POWER (0 = furthest, -1 = closest).

		beenThreat = false,                                    -- Has the contact ever been a threat (lock or launch).
		threat = get_param_handle(contactSTR .. "threat"),     -- Threat level (color) of the contact (0 = unkown: yellow, 1 = threat: red).
		launch = get_param_handle(contactSTR .. "launch"),     -- Is the contact (launching) a missile (0 = no, 1 = yes).
		launchBlinkUpdate = .1,                                -- Timer for launch blinking.
		launchBlink = get_param_handle(contactSTR .. "launchBlink"), -- Blinking param for launch indication.

		name = get_param_handle(contactSTR .. "name"), -- Name of the contact; text under the oval (ex: "M29": MiG-29).
	}
end



function post_initialize()
	-- Params for test contact:
	-- Standard from avSimpleRWR:
	local testAzimuth     = get_param_handle(testContactSTR .. "AZIMUTH")
	local testElevation   = get_param_handle(testContactSTR .. "ELEVATION")
	local testPower       = get_param_handle(testContactSTR .. "POWER")
	local testGeneralType = get_param_handle(testContactSTR .. "GENERAL_TYPE")
	local testUnitType    = get_param_handle(testContactSTR .. "UNIT_TYPE")
	local testSignal      = get_param_handle(testContactSTR .. "SIGNAL")
	local testTime        = get_param_handle(testContactSTR .. "TIME")
	local testSource      = get_param_handle(testContactSTR .. "SOURCE")
	local testPriority    = get_param_handle(testContactSTR .. "PRIORITY")

	testAzimuth:set(math.rad(350))
	testElevation:set(0)
	testPower:set(1)
	testGeneralType:set(typePlane)
	testUnitType:set("MiG-29A")
	testSignal:set(launchSignal)
	testTime:set(1.1)
	testSource:set(160000000)
	testPriority:set(140)

	-- Custom:
	get_param_handle(testContactSTR .. "heading"):set((2 * math.pi - testAzimuth:get()) % (2 * math.pi))
	get_param_handle(testContactSTR .. "medium"):set((testGeneralType:get() == typePlane or testGeneralType:get() == typeMissile) and 2 or 1)
	get_param_handle(testContactSTR .. "range"):set(-.04 * testPower:get()^2)
	get_param_handle(testContactSTR .. "threat"):set(((testSignal:get() == lockSignal or testSignal:get() == launchSignal) or testPriority:get() >= 155) and 1 or 0)
	get_param_handle(testContactSTR .. "launch"):set((testSignal:get() == launchSignal or testGeneralType:get() == typeMissile) and 1 or 0)
	get_param_handle(testContactSTR .. "launchBlink"):set(1)
	get_param_handle(testContactSTR .. "name"):set(getThreatSTR(testUnitType:get()))
end

function update()
	GetDevice(devices.RWR):set_power(RWRPower:get() == 1)



	activeThreats = 0

	for i = 1, MaxThreats do
		local rawAzimuth     = rwr[i].AZIMUTH:get()
		-- local rawElevation   = rwr[i].ELEVATION:get()
		local rawPower       = rwr[i].POWER:get()
		local rawGeneralType = rwr[i].GENERAL_TYPE:get()
		local rawUnitType    = rwr[i].UNIT_TYPE:get()
		local rawSignal      = rwr[i].SIGNAL:get()
		-- local rawTime        = rwr[i].TIME:get()
		-- local rawSource      = rwr[i].SOURCE:get()
		local rawPriority    = rwr[i].PRIORITY:get()



		rwr[i].heading:set((2 * math.pi - rawAzimuth) % (2 * math.pi))


		rwr[i].medium:set((rawGeneralType == typePlane or rawGeneralType == typeMissile) and 2 or 1)


		rwr[i].range:set(rawGeneralType == typeMissile and -.04 * rawPower^3 or -.04 * rawPower^2) -- Quadratic (cubic for missiles) relation to power for more distributed visual (https://www.desmos.com/calculator/agulijslet).


		if rawSignal == lockSignal or rawSignal == launchSignal then
			rwr[i].beenThreat = true
		end

		rwr[i].threat:set((rwr[i].beenThreat or rawPriority >= 155) and 1 or 0)

		activeThreats = activeThreats + rwr[i].threat:get() * rawPower


		rwr[i].launch:set((rawSignal == launchSignal or rawGeneralType == typeMissile) and 1 or 0)


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
	end

	activeRWRThreats:set(activeThreats)
end



need_to_be_closed = false