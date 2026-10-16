dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."utils.lua")
local update_time_step = 0.01 
make_default_activity(update_time_step)

local Rudder_system = GetSelf()
local sensor_data = get_base_data()
local arg17 = 0
local Rudder = 0
local RudderTimeSec = 1.11
local RudderIncrement = update_time_step / RudderTimeSec
local RUDDER_STATE = 0 
local RUDDER_TARGET = 0
local NWS_STATE = 0
local NWS_TARGET = 0

function get_data()
	arg17 = get_aircraft_draw_argument_value(17) 					--Raw values: 0.993, 0, -0.993 L/N/R
	local self_vel_l,self_vel_v,self_vel_h = sensor_data.getSelfAirspeed()		-- Prereq for ground speed in kts
	self_gs_kmh = math.sqrt(self_vel_h^2 + self_vel_l^2) * 3.6				-- Ground speed in kmh
	Rudder = -1 * get_param_handle("CURRENT_YAW_OUTPUT"):get()
	--print_message_to_user(Rudder)			
end

function update()
	get_data()
-- beginning of phases
-- ======================== Stationary =============================	
	if get_param_handle("CURRENT_PHASE_STATIONARY"):get() > 0.0 then
		RUDDER_TARGET = 0
		NWS_TARGET = 0
		
-- ========================= Parked ================================
	else
		RUDDER_TARGET = Rudder

		NWS_TARGET = -0.85 * get_param_handle("RUDDER_PEDAL_ANIM"):get()

		if self_gs_kmh > 65 then
			NWS_TARGET = NWS_TARGET / (self_gs_kmh * 0.1522765)
		end
			
	end	
-- end of phases

--===================== Animation ==========================
	RUDDER_STATE = MoveControlSurface(RUDDER_STATE, RUDDER_TARGET, RudderIncrement)
	NWS_STATE = MoveControlSurface(NWS_STATE, NWS_TARGET, RudderIncrement)

	set_aircraft_draw_argument_value(488,RUDDER_STATE - arg17)
	set_aircraft_draw_argument_value(2, NWS_STATE)				-- Nose wheel turning animation
	
end


need_to_be_closed = 0