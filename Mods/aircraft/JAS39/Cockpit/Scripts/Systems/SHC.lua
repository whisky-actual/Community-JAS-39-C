dofile(LockOn_Options.script_path .. "command_defs.lua")
dofile(LockOn_Options.script_path .. "devices.lua")
dofile(LockOn_Options.script_path .. "utils.lua")



local updateTimeStep = 1 / 60
make_default_activity(updateTimeStep)

local SHC = GetSelf()

SHC:listen_command(keys.S10SpanScaleUp)
SHC:listen_command(keys.S10SpanScaleDown)


local CDScale = get_param_handle("CDScale")
local RDRFullRange = get_param_handle("RDRFullRange")
local RDRHalfRange = get_param_handle("RDRHalfRange")



function post_initialize()
	CDScale:set(getScale(800)) -- 40 nm (1:800)
	RDRFullRange:set(40)
	RDRHalfRange:set(20)
end

function update()

end

function SetCommand(command, value)
	if command == keys.S10SpanScaleUp then
		if CDScale:get() ~= 240000 then
			CDScale:set(CDScale:get() * 2)
			RDRFullRange:set(getRange(CDScale:get()))
		end
	elseif command == keys.S10SpanScaleDown then
		if CDScale:get() ~= 15000 then
			CDScale:set(CDScale:get() / 2)
			RDRFullRange:set(getRange(CDScale:get()))
		end
	end

	RDRHalfRange:set(RDRFullRange:get() / 2)
end


function getRange(value)
	return value / 3000
end

function getScale(value)
	return value * 150 -- Should be 1000, but for some reason is the unit on the displays FOV instead of meters... 
end



need_to_be_closed = false