dofile(LockOn_Options.script_path.."command_defs.lua")
local update_time_step = 0.05 
make_default_activity(update_time_step)
local dev = GetSelf()
-------------------------------------------------------
-- Local Variables
-------------------------------------------------------
local Page_changed = 0
local RDR_UP = 0 -- Add variable for complexe actions
local RDR_DOWN = 0
local RDR_LEFT = 0
local RDR_RIGHT = 0
local MIRROR	= get_param_handle("MIRROR")
local RKneeboardDraw	= get_param_handle("LKneeboardDraw")
local LKneeboardDraw	= get_param_handle("RKneeboardDraw")
local JoystickDraw	= get_param_handle("JoystickDraw")
local ATT_LIGHT = get_param_handle("ATT_LIGHT")
local ALT_LIGHT = get_param_handle("ALT_LIGHT")
local MAN_LIGHT = get_param_handle("MAN_LIGHT")
-------------------------------------------------------
-- Initialization Functions	
-------------------------------------------------------
function post_initialize()	-- modes / toggle default settings
	MIRROR:set(-1)
	LKneeboardDraw:set(-1)
	RKneeboardDraw:set(-1)
	JoystickDraw:set(1)
	ATT_LIGHT:set(-1)
	ALT_LIGHT:set(-1)
	MAN_LIGHT:set(0)
end
-------------------------------------------------------
-- Params
-------------------------------------------------------
dev:listen_command(deviceCommands.COM1)
dev:listen_command(deviceCommands.COM2)
dev:listen_command(deviceCommands.COM3)
dev:listen_command(deviceCommands.AP_ALT)
dev:listen_command(deviceCommands.AP_ATT)
dev:listen_command(deviceCommands.AP_OFF)
dev:listen_command(deviceCommands.NAV_NEXT)
dev:listen_command(deviceCommands.NAV_PREV)
dev:listen_command(deviceCommands.RDR_PRF)
dev:listen_command(deviceCommands.RDR_PWR)
dev:listen_command(deviceCommands.RDR_MODE)
dev:listen_command(deviceCommands.RDR_IN)
dev:listen_command(deviceCommands.RDR_OUT)
dev:listen_command(deviceCommands.RDR_UP)
dev:listen_command(deviceCommands.RDR_DOWN)
dev:listen_command(deviceCommands.RDR_LEFT)
dev:listen_command(deviceCommands.RDR_RIGHT)

dev:listen_command(deviceCommands.MIRROR)
dev:listen_command(deviceCommands.LKneeboardDraw)
dev:listen_command(deviceCommands.RKneeboardDraw)
dev:listen_command(deviceCommands.JoystickDraw)
dev:listen_command(deviceCommands.MAP)
dev:listen_command(deviceCommands.KNEEBOARD)
dev:listen_command(keys.Plane_CockpitShowPilotOnOff)	-- pilot show/hide

dev:listen_command(deviceCommands.UCP_MENU)
-------------------------------------------------------
-- Complexe Functions
-------------------------------------------------------

function SetCommand(command,value) -- Post initialize gets called once on mission start. SetCommand gets called when ever there is a button clicked

	if command == deviceCommands.RDR_UP then
	   if RDR_UP == 0 then
	
	    dispatch_action (nil,141)
	    RDR_UP = 1 -- GO
	
	   else
	    dispatch_action (nil,230)
	   RDR_UP = 0 -- STOP
	   end
	end
	
	if command == deviceCommands.RDR_DOWN then
	   if RDR_DOWN == 0 then
	
	    dispatch_action (nil,142)
	   RDR_DOWN = 1 -- GO
	
	   else
	    dispatch_action (nil,230)
	   RDR_DOWN = 0 -- STOP
	   end
	end
	
	if command == deviceCommands.RDR_LEFT then
	   if RDR_LEFT == 0 then
	
	    dispatch_action (nil,139)
	   RDR_LEFT= 1 -- GO
	
	   else
	    dispatch_action (nil,230)
	   RDR_LEFT = 0 -- STOP
	   end
	end
	
	if command == deviceCommands.RDR_RIGHT then
	   if RDR_RIGHT == 0 then
			dispatch_action (nil,140)
			RDR_RIGHT= 1 -- GO
		else
			dispatch_action (nil,230)
			RDR_RIGHT = 0 -- STOP
	   end
	end
	
	if command == deviceCommands.MIRROR then
	   if MIRROR:get()== 1 then
			MIRROR:set(-1)
		else
			MIRROR:set(1)
		end
	end

	if command == deviceCommands.LKneeboardDraw then
	   if LKneeboardDraw:get()== 1 then
			LKneeboardDraw:set(-1)
		else
			LKneeboardDraw:set(1)
		end
	end

	if command == deviceCommands.RKneeboardDraw then
	   if RKneeboardDraw:get()== 1 then
			RKneeboardDraw:set(-1)
		else
			RKneeboardDraw:set(1)
		end
	end

		if command == deviceCommands.JoystickDraw then
	   if JoystickDraw:get()== 1 then
			JoystickDraw:set(-1)
		else
			JoystickDraw:set(1)
		end
	end

	if command == deviceCommands.AP_ALT then
	   if AP_ALT == 0 then
	
	    dispatch_action (nil,408)
		ALT_LIGHT:set(-1) 
		ATT_LIGHT:set(-1)
		MAN_LIGHT:set(1) 
	   AP_ALT= 1 -- ON
	
	   else
	    dispatch_action (nil,389)
		ALT_LIGHT:set(1)
		ATT_LIGHT:set(-1)
		MAN_LIGHT:set(-1) 
		AP_ALT = 0 -- OFF
	   end
	end
	
	if command == deviceCommands.AP_ATT then
	   if AP_ATT == 0 then
	
	    dispatch_action (nil,408)
		ALT_LIGHT:set(-1) 
		ATT_LIGHT:set(-1)
		MAN_LIGHT:set(1) 
	   AP_ATT= 1 -- PFF
	
	   else
	    dispatch_action (nil,387)
		ALT_LIGHT:set(-1)
		ATT_LIGHT:set(1)
		MAN_LIGHT:set(-1) 
	   AP_ATT = 0 -- STOP
	   end
	end
	
	if command == deviceCommands.AP_OFF then
	   if AP_OFF == 0 then
	
	    dispatch_action (nil,408)
		MAN_LIGHT:set(1) 
		ALT_LIGHT:set(-1)
		ATT_LIGHT:set(-1)
	   AP_OFF= 1 -- GO
	
	   else
	    dispatch_action (nil,408)
		MAN_LIGHT:set(1)
		ALT_LIGHT:set(-1)
		ATT_LIGHT:set(-1)
	   AP_OFF = 0 -- STOP
	   end
	end

-------------------------------------------------------	
-- Simple Functions 
-------------------------------------------------------
	if command == deviceCommands.COM1 then
		dispatch_action(nil,179)
	end
	
	if command == deviceCommands.COM2 then
		dispatch_action(nil,1560)
	end

	if command == deviceCommands.COM3 then
	   dispatch_action(nil,62)
	end

	if command == deviceCommands.AP_RSET then
		dispatch_action(nil,388)
	end

	if command == deviceCommands.EO then
		dispatch_action(nil,87)
	end

	if command == deviceCommands.NAV_NEXT then
		dispatch_action(nil,102)
	end

	if command == deviceCommands.NAV_PREV then
		dispatch_action(nil,1315)
	end

	if command == deviceCommands.RDR_PRF then
		dispatch_action(nil,394)
	end

	if command == deviceCommands.RDR_PWR then
		dispatch_action(nil,86)
	end

	if command == deviceCommands.RDR_MODE then
		dispatch_action(nil,285)
	end

	if command == deviceCommands.RDR_IN then
		dispatch_action(nil,103)
	end

	if command == deviceCommands.RDR_OUT then
		dispatch_action(nil,104)
	end
	
	if command == deviceCommands.RDR_LEFT then
		dispatch_action(nil,263)
	end

	if command == deviceCommands.RDR_RIGHT then
		dispatch_action(nil,262)
	end

	if command == deviceCommands.MAP then
		dispatch_action(nil,1587)
	end

		if command == deviceCommands.KNEEBOARD then
		dispatch_action(nil,975)
	end
-------------------------------------------------------
--Test Functions
-------------------------------------------------------	

	if command == deviceCommands.UCP_MENU then
		dispatch_action(nil,390)
	end

end

need_to_be_closed = false