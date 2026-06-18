dofile(LockOn_Options.script_path .. "devices.lua")
package.path = package.path .. ";" .. LockOn_Options.script_path .. "DTU/?.lua"
json = require("dkjson")



make_default_activity(1 / 12)


local DTU     = nil
local logFile = nil

local DTUContent = nil

local DTUFilePath    = LockOn_Options.script_path .. "DTU/DTU.json"
local DTULogFilePath = LockOn_Options.script_path .. "DTU/DTU.log"

local lines = {}

local lineCounter = 0

local logging = true -- True for debugging in "\Cockpit\Scripts\DTU\DTU.log".
local editable = false



function post_initialize()

end

function update()

end

function SetCommand(command, value)

end



function readDTU(row)
	DTU = io.open(DTUFilePath, "r")

	lineCounter = 1


	for i in DTU:lines() do
		if lineCounter == row then
			DTU:close()
			if logging == true then
				logFile = io.open(DTULogFilePath, "a")
				logFile:write(os.date("%Y-%m-%d %H:%M:%S READ    Line: '") .. row .. "' Which had the content: '" .. i .. "'.\n")
				logFile:close()
			end

			return i
		end

		lineCounter = lineCounter + 1
	end
end

function editDTU(row, string)
	io.open(DTUFilePath, "w"):close()

	DTU = io.open(DTUFilePath, "w")
	DTU:write(string)
	DTU:close()

	if editable == true then
		DTU        = io.open(DTUFilePath, "r")
		DTUContent = DTU:read("*all")
		DTU:close()

		lines = {}


		for i in DTUContent:gmatch("[^\r\n]+") do
			table.insert(lines, i)
		end

		lines[row] = string


		DTU = io.open(DTUFilePath, "w")
		DTU:write(table.concat(lines, "\n"))
		DTU:close()
	end

	if logging == true then
		logFile = io.open(DTULogFilePath, "a")
		logFile:write(os.date("%Y-%m-%d %H:%M:%S EDIT    Line: '") .. row .. "' Which had the content: '" .. lines[row] .. "', and now has the content: '" .. string .. "'.\n")
		logFile:close()
	end
end