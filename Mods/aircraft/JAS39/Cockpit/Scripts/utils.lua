
--[[
PID Controller class (Proportional-Integral-Derivative Controller)
(backward Euler discrete form)
--]]

PID = {} -- the table representing the class, which will double as the metatable for the instances
PID.__index = PID -- failed table lookups on the instances should fallback to the class table, to get methods
setmetatable(PID, {
  __call = function( cls, ... )
    return cls.new(...) -- automatically call constructor when class is called like a function, e.g. a=PID() is equivalent to a=PID.new()
  end,
})

function PID.new( Kp, Ki, Kd, umin, umax, uscale )
    local self = setmetatable({}, PID)

    self.Kp = Kp or 1   -- default to a weight=1 "P" controller
    self.Ki = Ki or 0
    self.Kd = Kd or 0

    self.k1 = self.Kp + self.Ki + self.Kd
    self.k2 = -self.Kp - 2*self.Kd
    self.k3 = self.Kd

    self.e2 = 0     -- error term history for I/D functions
    self.e1 = 0
    self.e = 0

    self.du = 0     -- delta U()
    self.u = 0      -- U() term for output

    self.umax = umax or 999999  -- allow bounding of e for PID output limits
    self.umin = umin or -999999
    self.uscale = uscale or 1   -- allow embedded output scaling and range limiting

    return self
end

-- used to tune Kp on the fly
function PID:set_Kp( val )
    self.Kp = val
    self.k1 = self.Kp + self.Ki + self.Kd
    self.k2 = -self.Kp - 2*self.Kd
end

-- used to tune Kp on the fly
function PID:get_Kp()
    return self.Kp
end

-- used to tune Ki on the fly
function PID:set_Ki( val )
    self.Ki = val
    self.k1 = self.Kp + self.Ki + self.Kd
end

-- used to tune Ki on the fly
function PID:get_Ki()
    return self.Ki
end

-- used to tune Kd on the fly
function PID:set_Kd( val )
    self.Kd = val
    self.k1 = self.Kp + self.Ki + self.Kd
    self.k2 = -self.Kp - 2*self.Kd
    self.k3 = self.Kd
end

-- used to tune Kd on the fly
function PID:get_Kd()
    return self.Kd
end

function PID:run( setpoint, mv )
    self.e2 = self.e1
    self.e1 = self.e
    self.e = setpoint - mv

    -- backward Euler discrete PID function
    self.du = self.k1*self.e + self.k2*self.e1 + self.k3*self.e2
    self.u = self.u + self.du

    if self.u < self.umin then
        self.u = self.umin
    elseif self.u > self.umax then
        self.u = self.umax
    end

    return self.u*self.uscale
end

-- reset dynamic state
function PID:reset(u)
    self.e2 = 0
    self.e1 = 0
    self.e = 0

    self.du = 0
    if u then
        self.u = u/self.uscale
    else
        self.u = 0
    end
end


PID_alt = {}
PID_alt.__index = PID_alt
setmetatable(PID_alt, {
  __call = function( cls, ... )
    return cls.new(...) -- automatically call constructor when class is called like a function, e.g. a=PID() is equivalent to a=PID.new()
  end,
})

function PID_alt.new(kp, ki, kd, centre, errIMin, errIMax)
  local self = setmetatable({}, PID_alt)
  self.kp = kp
  self.ki = ki
  self.kd = kd

  self.errIMin = errIMin or -100000000.0
  self.errIMax = errIMax or  100000000.0

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
