local dev = GetSelf()

local update_time_step = 0.001
make_default_activity(update_time_step)

local sensor_data = get_base_data()

local NOZZLE_STATE = 0
local NOZZLE_TARGET_STATE1 = 0

local FastNozzleOpenCloseTimeSec = 0.5
local FastNozzleOpenCloseIncrement = update_time_step / FastNozzleOpenCloseTimeSec

local SlowNozzleOpenCloseTimeSec = 3.0
local SlowNozzleOpenCloseIncrement = update_time_step / SlowNozzleOpenCloseTimeSec

-- NOZZLE ANIMATION: 0 = CLOSED, 1 = OPEN

function update()		

	local rpm = sensor_data.getEngineLeftRPM()

	local NOZZLE_TARGET_STATE3 = ((rpm - 101)*(1/(109-101)))	
	local NOZZLE_TARGET_STATE2 = math.abs(((rpm - 70)*(1/(100-70))-1))	
	
	if (rpm < 70) then 												-- State 1: Engine off: Nozzle closing
		if NOZZLE_STATE > NOZZLE_TARGET_STATE1 then
		NOZZLE_STATE = NOZZLE_STATE - SlowNozzleOpenCloseIncrement
		end

		elseif (rpm > 69) and (rpm < 71) then						-- State 1-2: Engine 70-100 rpm: Nozzle from fully open to closing at higher rpm	
		if NOZZLE_STATE > NOZZLE_TARGET_STATE2 then
		NOZZLE_STATE = NOZZLE_STATE - SlowNozzleOpenCloseIncrement
		end
		if NOZZLE_STATE < NOZZLE_TARGET_STATE2 then
		NOZZLE_STATE = NOZZLE_STATE + SlowNozzleOpenCloseIncrement
		end

		elseif (rpm > 70) and (rpm < 101) then						-- State 2: Engine 70-100 rpm: Nozzle from fully open to closing at higher rpm	
		if NOZZLE_STATE > NOZZLE_TARGET_STATE2 then
		NOZZLE_STATE = NOZZLE_STATE - FastNozzleOpenCloseIncrement
		end
		if NOZZLE_STATE < NOZZLE_TARGET_STATE2 then
		NOZZLE_STATE = NOZZLE_STATE + FastNozzleOpenCloseIncrement
		end
				
		elseif (rpm > 100) then										-- State 3: Engine 101-109 rpm AB: Nozzle from almost fully open to fully open
		if NOZZLE_STATE < NOZZLE_TARGET_STATE3 then
		NOZZLE_STATE = NOZZLE_STATE + FastNozzleOpenCloseIncrement
		end
		if NOZZLE_STATE > NOZZLE_TARGET_STATE3 then
		NOZZLE_STATE = NOZZLE_STATE - FastNozzleOpenCloseIncrement
		end
		
	end
	
    if NOZZLE_TARGET_STATE1 < 0 then
        NOZZLE_TARGET_STATE1 = 0
    elseif NOZZLE_TARGET_STATE1 > 1 then
        NOZZLE_TARGET_STATE1 = 1
    end
	
	if NOZZLE_TARGET_STATE2 < 0 then
        NOZZLE_TARGET_STATE2 = 0
    elseif NOZZLE_TARGET_STATE2 > 1 then
        NOZZLE_TARGET_STATE2 = 1
    end
	
	if NOZZLE_TARGET_STATE3 < 0 then
        NOZZLE_TARGET_STATE3 = 0
    elseif NOZZLE_TARGET_STATE3 > 1 then
        NOZZLE_TARGET_STATE3 = 1
    end

	set_aircraft_draw_argument_value(89,NOZZLE_STATE)
	
end

need_to_be_closed = false
