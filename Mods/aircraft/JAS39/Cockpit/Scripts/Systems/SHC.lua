dofile(LockOn_Options.script_path .. "command_defs.lua")
dofile(LockOn_Options.script_path .. "devices.lua")
dofile(LockOn_Options.script_path .. "utils.lua")



local updateTimeStep = 1 / 60
make_default_activity(updateTimeStep)

local SHC = GetSelf()

SHC:listen_command(keys.S10SpanScaleUp)
SHC:listen_command(keys.S10SpanScaleDown)


local CD_Scale = get_param_handle("CD_Scale")



function post_initialize()
	CD_Scale:set(getScale(800)) -- 40 nm (1:800)
	get_param_handle("CD_SCALE_SYM"):set(40)
end

function update()

end

function SetCommand(command, value)
	if command == keys.S10SpanScaleUp then
		if CD_Scale:get() ~= 240000 then
			CD_Scale:set(CD_Scale:get() * 2)
			get_param_handle("CD_SCALE_SYM"):set(getRange(CD_Scale:get()))
		end
	elseif command == keys.S10SpanScaleDown then
		if CD_Scale:get() ~= 15000 then
			CD_Scale:set(CD_Scale:get() / 2)
			get_param_handle("CD_SCALE_SYM"):set(getRange(CD_Scale:get()))
		end
	end
end


function getRange(value)
	return value / 3000
end

function getScale(value)
	return value * 150 -- Should be 1000, but for some reason is the unit on the displays FOV instead of meters... 
end



need_to_be_closed = false