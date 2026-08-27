--[[
PID Controller class (Proportional-Integral-Derivative Controller)
(backward Euler discrete form)
--]]

PID = {}          -- the table representing the class, which will double as the metatable for the instances
PID.__index = PID -- failed table lookups on the instances should fallback to the class table, to get methods
setmetatable(PID, {
	__call = function (cls, ...)
		return cls.new(...) -- automatically call constructor when class is called like a function, e.g. a=PID() is equivalent to a=PID.new()
	end
})

function PID.new(Kp, Ki, Kd, umin, umax, uscale)
	local self = setmetatable({}, PID)

	self.Kp = Kp or 1 -- default to a weight=1 "P" controller
	self.Ki = Ki or 0
	self.Kd = Kd or 0

	self.k1 = self.Kp + self.Ki + self.Kd
	self.k2 = -self.Kp - 2 * self.Kd
	self.k3 = self.Kd

	self.e2 = 0 -- error term history for I/D functions
	self.e1 = 0
	self.e = 0

	self.du = 0 -- delta U()
	self.u = 0 -- U() term for output

	self.umax = umax or 999999 -- allow bounding of e for PID output limits
	self.umin = umin or -999999
	self.uscale = uscale or 1 -- allow embedded output scaling and range limiting

	return self
end

-- used to tune Kp on the fly
function PID:set_Kp(val)
	self.Kp = val
	self.k1 = self.Kp + self.Ki + self.Kd
	self.k2 = -self.Kp - 2 * self.Kd
end

-- used to tune Kp on the fly
function PID:get_Kp()
	return self.Kp
end

-- used to tune Ki on the fly
function PID:set_Ki(val)
	self.Ki = val
	self.k1 = self.Kp + self.Ki + self.Kd
end

-- used to tune Ki on the fly
function PID:get_Ki()
	return self.Ki
end

-- used to tune Kd on the fly
function PID:set_Kd(val)
	self.Kd = val
	self.k1 = self.Kp + self.Ki + self.Kd
	self.k2 = -self.Kp - 2 * self.Kd
	self.k3 = self.Kd
end

-- used to tune Kd on the fly
function PID:get_Kd()
	return self.Kd
end

function PID:run(setpoint, mv)
	self.e2 = self.e1
	self.e1 = self.e
	self.e = setpoint - mv

	-- backward Euler discrete PID function
	self.du = self.k1 * self.e + self.k2 * self.e1 + self.k3 * self.e2
	self.u = self.u + self.du

	if self.u < self.umin then
		self.u = self.umin
	elseif self.u > self.umax then
		self.u = self.umax
	end

	return self.u * self.uscale
end

-- reset dynamic state
function PID:reset(u)
	self.e2 = 0
	self.e1 = 0
	self.e = 0

	self.du = 0
	if u then
		self.u = u / self.uscale
	else
		self.u = 0
	end
end


PID_alt = {}
PID_alt.__index = PID_alt
setmetatable(PID_alt, {
	__call = function (cls, ...)
		return cls.new(...) -- automatically call constructor when class is called like a function, e.g. a=PID() is equivalent to a=PID.new()
	end
})

function PID_alt.new(kp, ki, kd, centre, errIMin, errIMax)
	local self = setmetatable({}, PID_alt)
	self.kp = kp
	self.ki = ki
	self.kd = kd

	self.errIMin = errIMin or -100000000.0
	self.errIMax = errIMax or 100000000.0

	self.errorD = 0.0
	self.errorI = 0.0
	self.centre = centre or 0.0

	return self
end

function PID_alt:run(setpoint, process_variable)
	local error = setpoint - process_variable

	self.errorI = clamp(self.errorI + error, self.errIMin, self.errIMax)

	local p = self.kp * error
	local i = self.ki * self.errorI
	local d = self.kd * (error - self.errorD)

	self.errorD = error

	return self.centre + p + i + d
end

function PID_alt:reset(centre)
	self.errorD = 0.0
	self.errorI = 0.0
	self.centre = centre
end


function MoveControlSurface(State, Target, Increment)

	if (State < Target) and (Target - State >= Increment) then
		State = State + Increment
	elseif (State > Target) and (State - Target >= Increment) then
		State = State - Increment
	end

	if (State < -1) then
		State = -1
	elseif (State > 1) then
		State = 1
	end
	return State
end



function wrapValue(low, high, value)
	local step = high - low

	if value > high then
		return low + ((value - high - 1) % step) + 1
	elseif value < low then
		return high - ((low - value - 1) % step) - 1
	else
		return value
	end
end


local lastprint = {}
--- Instead of printing the same message multiple times, this function will only print it once per id.
--- @param input string The message to print.
--- @param id string The identifier for the message group.
function printButBetter(input, id)
	if input ~= lastprint[id] then
		print_message_to_user(input)
	end

	lastprint[id] = input
end



function clampToCircle(x, y, r)
	local distance = math.sqrt((x)^2 + (y)^2)
	if distance > r then
		local angle = math.atan2(y, x)
		local clamped_x = r * math.cos(angle)
		local clamped_y = r * math.sin(angle)
		return clamped_x, clamped_y, 1
	else
		return x, y, 0
	end
end

--- Limits coordinates to a rectangle.
--- @param x number Point x coordinate.
--- @param y number Point y coordinate.
--- @param rx number Half width of the rectangle.
--- @param ry number Half height of the rectange.
--- @param originX number x coordinate of the middle of the rectangle.
--- @param originY number y coordinate of the middle of the rectangle.
--- @return number clamped x coordinate.
--- @return number clamped y coordinate.
--- @return boolean isClamped True if coordinate is clamped, false if not.
function clampToRect(x, y, rx, ry, originX, originY)
	-- defaults
	rx = rx or 1
	ry = ry or rx
	originX = originX or 0
	originY = originY or 0

	-- translate point into rectangle-local coordinates (center at origin)
	local lx = x - originX
	local ly = y - originY

	local clamped_local_x = lx
	local clamped_local_y = ly
	local clamped = false

	if lx > rx then
		clamped_local_x = rx
		clamped = true
	elseif lx < -rx then
		clamped_local_x = -rx
		clamped = true
	end

	if ly > ry then
		clamped_local_y = ry
		clamped = true
	elseif ly < -ry then
		clamped_local_y = -ry
		clamped = true
	end

	-- translate back to original coordinate space
	local finalX = clamped_local_x + originX
	local finalY = clamped_local_y + originY

	return finalX, finalY, clamped
end


--- Basic rotation of a point around the origin.
function rotatePoint(x, y, theta)
	local cos_t = math.cos(theta)
	local sin_t = math.sin(theta)

	local x_new = x * cos_t - y * sin_t
	local y_new = x * sin_t + y * cos_t

	return x_new, y_new
end


--- Checks if a table contains a specific value.
--- @param table table: The table to check.
--- @param value any: The value to search for.
--- @return boolean: Returns true if the value is found in the table, otherwise false.
function tableContains(table, value)
	for _, el in ipairs(table) do
		if el == value then
			return true
		end
	end
	return false
end



function recursively_print(table_to_print, max_depth, max_number_tables, filepath)
	local file = io.open(filepath, "w")
	file:write("Key,Value\n")

	local stack = {}

	table.insert(stack, {key = "start", value = table_to_print, level = 0})

	local total = 0

	local hash_table = {}

	hash_table[tostring(hash_table)] = 2
	hash_table[tostring(stack)] = 2

	local item = true
	while (item) do
		item = table.remove(stack)

		if (item == nil) then
			break
		end
		local key = item.key
		local value = item.value
		local level = item.level

		file:write(string.rep("\t", level) .. tostring(key) .. " = " .. tostring(value) .. "\n")

		local hash = hash_table[tostring(value)]
		local valid_table = (hash == nil or hash < 2)

		if (type(value) == "table" and valid_table) then
			for k, v in pairs(value) do
				if (v ~= nil and level <= max_depth and total < max_number_tables) then
					table.insert(stack, {key = k, value = v, level = level + 1})
					if (type(v) == "table") then
						if (hash_table[tostring(v)] == nil) then
							hash_table[tostring(v)] = 1
						elseif (hash_table[tostring(v)] < 2) then
							hash_table[tostring(v)] = 2
						end
						total = total + 1
					end
				end
			end
		end

		if (getmetatable(value) and valid_table) then
			for k, v in pairs(getmetatable(value)) do
				if (v ~= nil and level <= max_depth and total < max_number_tables) then
					table.insert(stack, {key = k, value = v, level = level + 1})
					if (type(v) == "table") then
						if (hash_table[tostring(v)] == nil) then
							hash_table[tostring(v)] = 1
						elseif (hash_table[tostring(v)] < 2) then
							hash_table[tostring(v)] = 2
						end
						total = total + 1
					end
				end
			end
		end
	end

	file:close()
end



function Dump(o)
	if type(o) == "table" then
		local s = "{ "
		for k, v in pairs(o) do
			if type(k) ~= "number" then k = '"' .. k .. '"' end
			s = s .. "[" .. k .. "] = " .. Dump(v) .. ","
		end
		return s .. "} "
	else
		return tostring(o)
	end
end



Math = {}           -- The table representing the class, which will double as the metatable for the instances
Math.__index = Math -- Failed table lookups on the instances should fallback to the class table, to get methods

--- Returns the cotangent of `x` (assumed to be in radians).
function Math.cot(x)
	return math.cos(x) / math.sin(x)
end

--- Returns the arccotangent of `x` (assumed to be in radians).
function Math.acot(x)
	return math.tan(1 - x)
end


--- Comparing a varible to a never ending fraction (e.g 1/3) will give `false`.
--- This function solves that, returns `true` if `input` and `value` are close enough.
function aboutEqualTo(input, value, resolution)
	local res = resolution or .01

	return ((input - res) < value and (input + res) > value)
end