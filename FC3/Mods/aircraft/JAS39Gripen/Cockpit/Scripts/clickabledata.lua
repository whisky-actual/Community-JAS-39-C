dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."devices.lua")

local gettext = require("i_18n")
_ = gettext.translate

cursor_mode = 
{ 
    CUMODE_CLICKABLE = 0,
    CUMODE_CLICKABLE_AND_CAMERA  = 1,
    CUMODE_CAMERA = 2,
};

clickable_mode_initial_status  = cursor_mode.CUMODE_CLICKABLE
use_pointer_name			   = true

function default_button(hint_,device_,command_,upcommand_,arg_,arg_val_,arg_lim_)

	local   arg_val_ = arg_val_ or 1
	local   arg_lim_ = arg_lim_ or {0,1}

	return  {	
				class 				= {class_type.BTN},
				hint  				= hint_,
				device 				= device_,
				action 				= {command_},
				stop_action 		= {upcommand_},
				arg 				= {arg_},
				arg_value			= {arg_val_}, 
				arg_lim 			= {arg_lim_},
				use_release_message = {true}
			}
end

function default_1_position_tumb(hint_, device_, command_, arg_, arg_val_, arg_lim_)
	local   arg_val_ = arg_val_ or 1
	local   arg_lim_ = arg_lim_ or {0,1}
	return  {	
				class 		= {class_type.TUMB},
				hint  		= hint_,
				device 		= device_,
				action 		= {command_},
				arg 	  	= {arg_},
				arg_value 	= {arg_val_}, 
				arg_lim   	= {arg_lim_},
				updatable 	= true, 
				use_OBB 	= true
			}
end

function default_2_position_tumb(hint_, device_, command_, arg_)
	return  {	
				class 		= {class_type.TUMB,class_type.TUMB},
				hint  		= hint_,
				device 		= device_,
				action 		= {command_,command_},
				arg 	  	= {arg_,arg_},
				arg_value 	= {-1,1}, 
				arg_lim   	= {{0,1},{0,1}},
				updatable 	= true, 
				use_OBB 	= true
			}
end

-- default_2_position_tumb GRINNELLI F22 VERSION WITH SOUND
-- function default_2_position_tumb(hint_, device_, command_, arg_, sound_)
-- 	return  {	
-- 				class 		= {class_type.TUMB,class_type.TUMB},
-- 				hint  		= hint_,
-- 				device 		= device_,
-- 				action 		= {command_,command_},
-- 				arg 	  	= {arg_,arg_},
-- 				arg_value 	= {-1,1}, 
-- 				arg_lim   	= {{0,1},{0,1}},
-- 				updatable 	= true, 
-- 				use_OBB 	= true,
-- 				sound = sound_ and {{sound_,sound_}} or nil
-- 			}
-- end

function default_3_position_tumb(hint_,device_,command_,arg_,cycled_,inversed_)
	local cycled = true
	
	
	local val =  1
	if inversed_ then
	      val = -1
	end
	if cycled_ ~= nil then
	   cycled = cycled_
	end
	return  {	
				class 		= {class_type.TUMB,class_type.TUMB},
				hint  		= hint_,
				device 		= device_,
				action 		= {command_,command_},
				arg 	  	= {arg_,arg_},
				arg_value 	= {val,-val}, 
				arg_lim   	= {{-1,1},{-1,1}},
				updatable 	= true, 
				use_OBB 	= true,
				cycle       = cycled
			}
end

function default_axis(hint_,device_,command_,arg_, default_, gain_,updatable_,relative_)
	
	local default = default_ or 1
	local gain = gain_ or 0.1
	local updatable = updatable_ or false
	local relative  = relative_ or false
	
	return  {	
				class 		= {class_type.LEV},
				hint  		= hint_,
				device 		= device_,
				action 		= {command_},
				arg 	  	= {arg_},
				arg_value 	= {default}, 
				arg_lim   	= {{0,1}},
				updatable 	= updatable, 
				use_OBB 	= true,
				gain		= {gain},
				relative    = {relative}, 				
			}
end

function default_movable_axis(hint_,device_,command_,arg_, default_, gain_,updatable_,relative_)
	
	local default = default_ or 1
	local gain = gain_ or 0.1
	local updatable = updatable_ or false
	local relative  = relative_ or false
	
	return  {	
				class 		= {class_type.MOVABLE_LEV},
				hint  		= hint_,
				device 		= device_,
				action 		= {command_},
				arg 	  	= {arg_},
				arg_value 	= {default}, 
				arg_lim   	= {{0,1}},
				updatable 	= updatable, 
				use_OBB 	= true,
				gain		= {gain},
				relative    = {relative}, 				
			}
end

function default_axis_limited(hint_,device_,command_,arg_, default_, gain_,updatable_,relative_, arg_lim_)
	
	local relative = false
	local default = default_ or 0
	local updatable = updatable_ or false
	if relative_ ~= nil then
		relative = relative_
	end

	local gain = gain_ or 0.1
	return  {	
				class 		= {class_type.LEV},
				hint  		= hint_,
				device 		= device_,
				action 		= {command_},
				arg 	  	= {arg_},
				arg_value 	= {default}, 
				arg_lim   	= {arg_lim_},
				updatable 	= updatable, 
				use_OBB 	= false,
				gain		= {gain},
				relative    = {relative},  
			}
end


function multiposition_switch(hint_,device_,command_,arg_,count_,delta_,inversed_, min_)
    local min_   = min_ or 0
	local delta_ = delta_ or 0.5
	
	local inversed = 1
	if	inversed_ then
		inversed = -1
	end
	
	return  {	
				class 		= {class_type.TUMB,class_type.TUMB},
				hint  		= hint_,
				device 		= device_,
				action 		= {command_,command_},
				arg 	  	= {arg_,arg_},
				arg_value 	= {-delta_ * inversed,delta_ * inversed}, 
				arg_lim   	= {{min_, min_ + delta_ * (count_ -1)},
							   {min_, min_ + delta_ * (count_ -1)}},
				updatable 	= true, 
				use_OBB 	= true
			}
end

function multiposition_switch_limited(hint_,device_,command_,arg_,count_,delta_,inversed_,min_)
    local min_   = min_ or 0
	local delta_ = delta_ or 0.5
	
	local inversed = 1
	if	inversed_ then
		inversed = -1
	end
	
	return  {	
				class 		= {class_type.TUMB,class_type.TUMB},
				hint  		= hint_,
				device 		= device_,
				action 		= {command_,command_},
				arg 	  	= {arg_,arg_},
				arg_value 	= {-delta_ * inversed,delta_ * inversed}, 
				arg_lim   	= {{min_, min_ + delta_ * (count_ -1)},
							   {min_, min_ + delta_ * (count_ -1)}},
				updatable 	= true, 
				use_OBB 	= true,
				cycle     	= false, 
			}
end

function default_button_axis(hint_, device_,command_1, command_2, arg_1, arg_2, limit_1, limit_2)
	local limit_1_   = limit_1 or 1.0
	local limit_2_   = limit_2 or 1.0
return {
			class		=	{class_type.BTN, class_type.LEV},
			hint		=	hint_,
			device		=	device_,
			action		=	{command_1, command_2},
			stop_action =   {command_1, 0},
			arg			=	{arg_1, arg_2},
			arg_value	= 	{1, 0.5},
			arg_lim		= 	{{0, limit_1_}, {0,limit_2_}},
			animated        = {false,true},
			animation_speed = {0, 0.4},
			gain = {0, 0.1},
			relative	= 	{false, false},
			updatable 	= 	true, 
			use_OBB 	= 	true,
			use_release_message = {true, false}
	}
end

function default_animated_lever(hint_, device_, command_, arg_, animation_speed_,arg_lim_)
local arg_lim__ = arg_lim_ or {0.0,1.0}
return  {	
	class  = {class_type.TUMB, class_type.TUMB},
	hint   	= hint_, 
	device 	= device_,
	action 	= {command_, command_},
	arg 		= {arg_, arg_},
	arg_value 	= {1, 0},
	arg_lim 	= {arg_lim__, arg_lim__},
	updatable  = true, 
	gain 		= {0.1, 0.1},
	animated 	= {true, true},
	animation_speed = {animation_speed_, 0},
	cycle = true
}
end

function default_button_tumb(hint_, device_, command1_, command2_, arg_)
	return  {	
				class 		= {class_type.BTN,class_type.TUMB},
				hint  		= hint_,
				device 		= device_,
				action 		= {command1_,command2_},
				stop_action = {command1_,0},
				arg 	  	= {arg_,arg_},
				arg_value 	= {-1,1}, 
				arg_lim   	= {{-1,0},{0,1}},
				updatable 	= true, 
				use_OBB 	= true,
				use_release_message = {true,false}
			}
end

elements = {}

-- Systems
-- elements["PNT_083"] = default_2_position_tumb("Landing Gear Handle", devices.GEAR_SYSTEM, click_cmd.GearLevel, 83)
-- elements["PNT_107"] = default_2_position_tumb("Battery Switch", devices.ELECTRIC_SYSTEM, Keys.BatteryPower, 107)

-- Power
           --function default_2_position_tumb(hint_, device_, command_, arg_)
elements["Battery"] 		 	= default_2_position_tumb("Battery On/Off",  devices.ELECTRIC_SYSTEM, device_commands.BatterySwitchClick, 700)
elements["L_Gen"] 		 		= default_2_position_tumb("Left Gen On/Off",  devices.ELECTRIC_SYSTEM, device_commands.GenRightSwitch, 702)
elements["R_Gen"] 		 		= default_2_position_tumb("Right Gen On/Off",  devices.ELECTRIC_SYSTEM, device_commands.GenLeftSwitch, 703)
elements["Parking_Brake"] 		= default_2_position_tumb("Parking Brake On/Off",  devices.PARKING_BRAKE, device_commands.ParkingBrakeSwitch, 706)

elements["Fuel_prove_Cover"]    = default_2_position_tumb("Fuel Cover", devices.UTILITIES , device_commands.FuelProbeCover, 750)
elements["Fuel_Probe"]    		= default_2_position_tumb("Fuel Prove Switch", devices.UTILITIES , device_commands.FuelProbeSwitch, 751)
elements["Hook"]    			= default_2_position_tumb("Hook Up/Down", devices.UTILITIES , device_commands.HookSwitch, 707)


elements["R_Engine_cover"]      = default_2_position_tumb("Right Engine Cover", devices.ENGINE , device_commands.FuelPumpRCover, 704)
elements["R_Engine_Crank"]    	= default_2_position_tumb("Engine Right Crank Switch", devices.ENGINE , device_commands.FuelPumpRight, 705)
elements["L_Engine_cover"]      = default_2_position_tumb("Left Engine Cover", devices.ENGINE , device_commands.FuelPumpLCover, 699)
elements["L_Engine_Crank"]    	= default_2_position_tumb("Engine Left Crank Switch", devices.ENGINE , device_commands.FuelPumpLeft, 698)

elements["Canopy_click"]	    = default_2_position_tumb("Canopy Open/Close", devices.CANOPY, device_commands.CanopySwitch, 701)

for i,o in pairs(elements) do
	if  o.class[1] == class_type.TUMB or 
	   (o.class[2]  and o.class[2] == class_type.TUMB) or
	   (o.class[3]  and o.class[3] == class_type.TUMB)  then
	   o.updatable = true
	   o.use_OBB   = true
	end
end
