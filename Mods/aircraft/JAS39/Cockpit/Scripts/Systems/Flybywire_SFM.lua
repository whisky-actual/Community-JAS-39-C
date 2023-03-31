dofile(LockOn_Options.script_path.."command_defs.lua")
local update_time_step = 1/1000
make_default_activity(update_time_step)
local FBW = GetSelf()
local sensor_data = get_base_data()

--================================= // TimeSec adjusts the speed of change in control value fed to the SFM. Higher = Slower
local RudderTimeSec = 1.1
local PITCHTimeSec = 0.9
local ROLLTimeSec = 0.375
local KB_RudderTimeSec = 1			  --pls help panda adjust these
local KB_ROLLTimeSec = 2	          --pls help panda adjust these
local KB_PITCHTimeSec = 0.066	      --pls help panda adjust these
local RecenteringFactor = math.pi	  --pls help panda adjust these, this is kinda OK though
--=================================

local ROLL_INPUT = 0
local PITCH_INPUT = 0
local RUDDER_INPUT = 0
local KB_RudderIncrement = update_time_step / KB_RudderTimeSec
local KB_PITCHIncrement = update_time_step / KB_PITCHTimeSec
local KB_ROLLIncrement = update_time_step / KB_ROLLTimeSec
local RudderIncrement = update_time_step / RudderTimeSec
local PITCHIncrement = update_time_step / PITCHTimeSec
local ROLLIncrement = update_time_step / ROLLTimeSec
local KB_ROLL_TARGET = 0
local KB_YAW_TARGET = 0
local KB_ROLL_STATE = 0
local PITCH_TARGET = 0
local KB_YAW_STATE = 0
local PITCH_STATE = 0 
local ROLL_TARGET = 0
local ROLL_STATE = 0
local YAW_TARGET = 0
local YAW_STATE = 0
local current_phase_PARKED = get_param_handle("CURRENT_PHASE_PARKED")
local JOYSTICK_PITCH_ANIM = get_param_handle("JOYSTICK_PITCH_ANIM")
local JOYSTICK_ROLL_ANIM = get_param_handle("JOYSTICK_ROLL_ANIM")
local RUDDER_PEDAL_ANIM = get_param_handle("RUDDER_PEDAL_ANIM")
local PITCH_OUTPUT = get_param_handle("CURRENT_PITCH_OUTPUT")
local ROLL_OUTPUT = get_param_handle("CURRENT_ROLL_OUTPUT")
local YAW_OUTPUT = get_param_handle("CURRENT_YAW_OUTPUT")
local AltHoldToggle = 0  --AUTO
local self_gs = 0
local Recentering = false

PITCH_OUTPUT:set(0.0)
ROLL_OUTPUT:set(0.0)
YAW_OUTPUT:set(0.0)

FBW:listen_command(10061)--Pitch axis
FBW:listen_command(10062)--roll
FBW:listen_command(10063)--rudder/yaw
FBW:listen_command(Keys.NoHotas) -- Enable keyboard controls
FBW:listen_command(device_commands.MadeUpAltHoldCommand) -- AUTO
FBW:listen_command(Keys.GripenPlaneUpStart)
FBW:listen_command(Keys.GripenPlaneDownStart)
FBW:listen_command(Keys.GripenPlaneLeftStart)
FBW:listen_command(Keys.GripenPlaneRightStart)
FBW:listen_command(Keys.GripenPlaneLeftRudderStart)
FBW:listen_command(Keys.GripenPlaneRightRudderStart)
FBW:listen_command(Keys.GripenPlaneLeftStop)
FBW:listen_command(Keys.GripenPlaneRightStop)
FBW:listen_command(Keys.GripenPlaneLeftRudderStop)
FBW:listen_command(Keys.GripenPlaneRightRudderStop)


function AxisControl(AxisState, AxisTarget, Increment, Keyboard, Rudder)

	local limit = 1
	
	if Rudder == true and GroundSteeringNeedsHelp(8) == true then	
		Increment = Increment / 2
		limit = self_gs * limit / 8
	elseif Keyboard == true and Recentering == true then
		Increment = Increment * RecenteringFactor --Control will decrease faster than increase (in absolute value)
	end
	
	if (AxisState < AxisTarget) and (AxisTarget - AxisState >= Increment) then
		AxisState = AxisState + Increment
	elseif (AxisState > AxisTarget) and (AxisState - AxisTarget >= Increment) then
		AxisState = AxisState - Increment
	end

	if (AxisState < -limit) then							
		AxisState = -limit
	elseif (AxisState > limit) then
		AxisState = limit
	end

return AxisState
end


function SetCommand(command,value)

	if command == 10061 then
		PITCH_INPUT = value
		--print_message_to_user(value)
	end
	if command == 10062 then
		ROLL_INPUT = value
	end
	if command == 10063 then
		RUDDER_INPUT = value		
	end
	
--FC3====================
	if command == Keys.GripenPlaneUpStart then
		if PITCH_INPUT > -1 + KB_PITCHIncrement then	
			PITCH_INPUT = PITCH_INPUT - KB_PITCHIncrement
		end
	end
	
	if command == Keys.GripenPlaneDownStart then
		if PITCH_INPUT < 1 - KB_PITCHIncrement then
			PITCH_INPUT = PITCH_INPUT + KB_PITCHIncrement
		end
	end

	if command == Keys.GripenPlaneRightStart then 
		KB_ROLL_TARGET = 1
		
		if KB_ROLL_STATE > 0 + KB_ROLLIncrement then
			Recentering = false
		else
			Recentering = true
		end
	end
		
	if command == Keys.GripenPlaneLeftStart then 
		KB_ROLL_TARGET = -1
		
		if KB_ROLL_STATE < 0 - KB_ROLLIncrement then
			Recentering = false
		else
			Recentering = true
		end
	end
	
	if command == Keys.GripenPlaneRightStop or command == Keys.GripenPlaneLeftStop then
		KB_ROLL_TARGET = 0
		Recentering = true
	end
	
	if command == Keys.GripenPlaneLeftRudderStart then
		KB_YAW_TARGET = -1
		Recentering = false
	end
	
	if command == Keys.GripenPlaneRightRudderStart then
		KB_YAW_TARGET = 1
		Recentering = false
	end
	
	if command == Keys.GripenPlaneLeftRudderStop or command == Keys.GripenPlaneRightRudderStop then
		KB_YAW_TARGET = 0
		Recentering = true
	end
	
	if command == MadeUpAltHoldCommand then
		if AltHoldToggle == 0 then
		
			dispatch_action (nil,389)
			AltHoldToggle = 1 -- on ALT Hold
		else
			dispatch_action (nil,408)
			AltHoldToggle = 0 -- off Alt Hold
		end
	end
	
end


function Sensor_data() 
	local self_vel_l,self_vel_v,self_vel_h = sensor_data.getSelfAirspeed()		-- Prereq for ground speed in kts
	self_gs = math.sqrt(self_vel_h^2 + self_vel_l^2) * 1.944 				-- Ground speed in kts
end


function Joystick_Animation()
	JOYSTICK_PITCH_ANIM:set(PITCH_INPUT)
	JOYSTICK_ROLL_ANIM:set(ROLL_INPUT + KB_ROLL_STATE)
	RUDDER_PEDAL_ANIM:set(RUDDER_INPUT + KB_YAW_STATE)
end



function GroundSteeringNeedsHelp(Velocity)

	if (current_phase_PARKED:get() == 1) and (self_gs < Velocity) then
		return true
	else 
		return false
	end

end

function AxisCommands()

	PITCH_TARGET = PITCH_INPUT 
	ROLL_TARGET = ROLL_INPUT

	if GroundSteeringNeedsHelp(20) == true then
		YAW_TARGET = ((RUDDER_INPUT / 20) * self_gs)
	else 
		YAW_TARGET = RUDDER_INPUT
	end
end


function update()
Sensor_data()
AxisCommands()
Joystick_Animation()

	--======================= Landing Roll =========================
	if get_param_handle("CURRENT_PHASE_LR"):get() > 0.0 then
		if get_param_handle("BRAKE_FORCE"):get() > 0.0 then
			PITCH_TARGET = -get_param_handle("BRAKE_FORCE"):get() 		--Apply pitch forward proportional to braking force
		end
	end	

	PITCH_STATE = AxisControl(PITCH_STATE, PITCH_TARGET, PITCHIncrement, false, false)
	ROLL_STATE = AxisControl(ROLL_STATE, ROLL_TARGET, ROLLIncrement, false, false)
	YAW_STATE = AxisControl(YAW_STATE, YAW_TARGET, RudderIncrement, false, false)
	
		--KB_PITCH_STATE = AxisControl(KB_PITCH_STATE, KB_PITCH_TARGET, KB_PITCHIncrement)
	KB_ROLL_STATE = AxisControl(KB_ROLL_STATE, KB_ROLL_TARGET, KB_ROLLIncrement, true, false)
	KB_YAW_STATE = AxisControl(KB_YAW_STATE, KB_YAW_TARGET, KB_RudderIncrement, true, true)

-- Axis commands
	
	PITCH_OUTPUT:set(PITCH_STATE)
	dispatch_action(nil, 2001, PITCH_STATE)	--PITCH
	
	ROLL_OUTPUT:set(ROLL_STATE + KB_ROLL_STATE)
	dispatch_action(nil, 2002, ROLL_STATE + KB_ROLL_STATE)	--ROLL
	
	YAW_OUTPUT:set(YAW_STATE + KB_YAW_STATE)
	dispatch_action(nil, 2003, YAW_STATE + KB_YAW_STATE) 	--RUDDER/YAW
end

need_to_be_closed = 0