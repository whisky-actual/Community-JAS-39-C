dofile(LockOn_Options.common_script_path .. "../../../Database/wsTypes.lua")
dofile(LockOn_Options.script_path .. "command_defs.lua")
dofile(LockOn_Options.script_path .. "devices.lua")
dofile(LockOn_Options.script_path .. "utils.lua")



local WS = GetSelf()
WS:listen_command(350)
WS:listen_command(keys.Trigger)
make_default_activity(1 / 60)

local LaunchCommanded = false
local LockCommanded = false

function update()
	LockBVR()
	LaunchBVR()
end

function SetCommand(command, value)
	if command == keys.Trigger then
		Initiate_Launch()
	end
end


function Initiate_Launch()
	-- if WEAPONMODE:get() == BVRMode[1] then
	if get_param_handle("RADAR_MODE"):get() == 1 then  -- If no existing lock
		dispatch_action(nil, 509, 1)                   -- Lock
		LaunchCommanded = true                         -- Tell LaunchBVR() to launch next frame
	elseif get_param_handle("RADAR_MODE"):get() == 3 then -- If coming from a prevoius prif and lock exists
		-- dispatch_action(nil, 509, 1)                   -- Unlock
		LaunchCommanded = true
		-- LockCommanded = true                           -- Tell LockBVR() to lock next frame
	else
		for i = 0, 10 do
			WS:launch_station(i)
		end
	end
	-- elseif WEAPONMODE:get() == WVRMode[1] then
	-- WS:launch_station(ActivePylon)
	-- elseif WEAPONMODE:get() == gunMode[1] then
	-- dispatch_action(nil, 84)
	-- print_message_to_user("BRRRRT")
	-- elseif WEAPONMODE:get() == ASmode[3] then
	-- print_message_to_user("Skjuter AS")
	-- WS:launch_station(ActivePylon)
	-- else
	-- WS:launch_station(ActivePylon)
	-- end
end

function LockBVR()
	if LockCommanded and get_param_handle("RADAR_MODE"):get() < 3 then
		dispatch_action(nil, 509, 1)
		LaunchCommanded = true
		LockCommanded = false
	end
end

function LaunchBVR()
	if LaunchCommanded and get_param_handle("RADAR_MODE"):get() == 3 then
		for i = 0, 10 do
			WS:launch_station(i)
		end
		LaunchCommanded = false
	end
end