local dev = GetSelf()
dofile(LockOn_Options.script_path.."command_defs.lua")

local update_time_step = 0.01 
make_default_activity(update_time_step) 

local sensor_data = get_base_data()
local rate_met2knot = 0.539956803456
local fmt = '%.2f'
local LIFT_DUMP_TARGET = 0
local TRIM_STATE = 0
local TRIM_TARGET_DOWN = 1
local TRIM_TARGET_UP = 0
local TrimTimeSec = 3
local TrimIncrement = update_time_step / TrimTimeSec
local AIRBRAKE_OUT = false
local TRIMMED = false
local WHEELBRAKE_ON = false

dev:listen_command(74)--Brakes on

function getIASKnots()
	local self_vel_l,self_vel_v,self_vel_h = sensor_data.getSelfAirspeed()
	self_gs	= math.sqrt(self_vel_h^2 + self_vel_l^2) 							-- speed in m/s
	ias_knots = self_gs * 3.6 * rate_met2knot									-- speed in knots
    WONW = sensor_data.getWOW_NoseLandingGear()								    -- Weight on nose wheel
	WOLW = sensor_data.getWOW_LeftMainLandingGear()								-- Weight on left wheel
    RPM = sensor_data.getEngineLeftRPM()										-- Engine Rpm %
end

function SetCommand(command,value)	
	if (command == 74) then
		WHEELBRAKE_ON = true
	else 
		WHEELBRAKE_ON = false
	end	
end

function update()
    getIASKnots()
    if (RPM <= 75 ) and (ias_knots >= 21) and (WONW == 1) and (WHEELBRAKE_ON == true) then
        if LIFT_DUMP_TARGET ~= 1 then
            LIFT_DUMP_TARGET = LIFT_DUMP_TARGET + 0.005
        end
        if LIFT_DUMP_TARGET >= 1 then
            LIFT_DUMP_TARGET = 1
        end
    else
        if LIFT_DUMP_TARGET ~= 0 then
            LIFT_DUMP_TARGET = LIFT_DUMP_TARGET - 0.005
        elseif LIFT_DUMP_TARGET <= 0  then
            LIFT_DUMP_TARGET = 0
        end
        if LIFT_DUMP_TARGET <= 0 then
            LIFT_DUMP_TARGET = 0
        end
    end
	set_aircraft_draw_argument_value(35,LIFT_DUMP_TARGET)
    --print_message_to_user(LIFT_DUMP_TARGET)
	
---------------Trim-------------------	
	
	if (RPM <= 75 ) and (WOLW == 1) and (WONW == 0) then --When throttle is close to idle, left wheel is on the ground and nose wheel in the air
		if (AIRBRAKE_OUT == false) then	
			dispatch_action(nil,147)  					 --Airbrake out
			AIRBRAKE_OUT = true							 -- declares airbrake is out
		end
		if (TRIM_STATE < TRIM_TARGET_DOWN) then
			TRIM_STATE = TRIM_STATE + TrimIncrement
			dispatch_action(nil,96)				 --Trim down
			TRIMMED = true						 --declares aircraft is trimmed
			--print_message_to_user("Trim down")
		end
	end
	
	if (AIRBRAKE_OUT == true) and (RPM >= 85) and (WOLW == 1) then	-- retract airbrake when preforming a touch and go landing
		dispatch_action(nil,148)					--Airbrake in
		AIRBRAKE_OUT = false
	end
	
	if (RPM <= 75 ) and (WOLW == 1) and (WONW == 1) then
		if (TRIMMED == true) then							-- two instances of trim seems to be required to begin trimming while on the ground
			dispatch_action(nil,97)							-- trims once then makes itself not run again
			TRIMMED = false
			--print_message_to_user("Trim once")
		end
		
		if (TRIM_STATE > TRIM_TARGET_UP) then				
			TRIM_STATE = TRIM_STATE - TrimIncrement
			dispatch_action(nil,95)							--Trim up
			--print_message_to_user("Trim up")
		end
		
		if (AIRBRAKE_OUT == true) and (ias_knots <= 21) then 
			dispatch_action(nil,148)  						--Airbrake in
			AIRBRAKE_OUT = false
		end
	end
	
	--print_message_to_user(TRIM_STATE)
		
	if (TRIM_STATE > 1 ) then		-- makes sure TRIM_STATE won't go above 1 or below 0
		TRIM_STATE = 1
	elseif (TRIM_STATE < 0 ) then
		TRIM_STATE = 0
	end	
	
	--print_message_to_user(TRIM_STATE)
 

end

need_to_be_closed = false