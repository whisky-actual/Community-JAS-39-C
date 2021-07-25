local dev = GetSelf()

local update_time_step = 0.01
make_default_activity(update_time_step)

local sensor_data = get_base_data()

local GEAR_BAY_STATE = 0
local GEAR_BAY_TARGET_OPEN = 1	
local GEAR_BAY_TARGET_CLOSE = 0

local BayDoorOpenCloseTimeSec = 3
local BayDoorOpenCloseIncrement = update_time_step / BayDoorOpenCloseTimeSec

function update()		
	
	local self_vel_l,self_vel_v,self_vel_h = sensor_data.getSelfAirspeed()
	self_gs	= math.sqrt(self_vel_h^2 + self_vel_l^2) -- speed in m/s

	local rpm = sensor_data.getEngineLeftRPM()
    local WOW = sensor_data.getWOW_LeftMainLandingGear()
	
	if (rpm < 55) and (WOW > 0) then
		if GEAR_BAY_STATE < GEAR_BAY_TARGET_OPEN then
		GEAR_BAY_STATE = GEAR_BAY_STATE + BayDoorOpenCloseIncrement
		end

	elseif (self_gs > 5.7) and (WOW > 0) then -- 5.7 m/s = 11 kts
		if GEAR_BAY_STATE > GEAR_BAY_TARGET_CLOSE then
		GEAR_BAY_STATE = GEAR_BAY_STATE - BayDoorOpenCloseIncrement
		end

    elseif (WOW < 1) then
		GEAR_BAY_STATE = -1
	
	end
	
    if GEAR_BAY_TARGET_CLOSE < 0 then
        GEAR_BAY_TARGET_CLOSE = 0
    elseif GEAR_BAY_TARGET_OPEN > 1 then
        GEAR_BAY_TARGET_OPEN = 1
    end

	set_aircraft_draw_argument_value(498,GEAR_BAY_STATE)
	
end

need_to_be_closed = false




