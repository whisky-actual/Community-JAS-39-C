local dev = GetSelf()

dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")

local update_time_step = 0.05
make_default_activity(update_time_step)

local sensor_data = get_base_data()

function post_initialize()
    local birth = LockOn_Options.init_conditions.birth_place
	
    if birth=="GROUND_HOT" then
    elseif birth=="AIR_HOT" then
    elseif birth=="GROUND_COLD" then
    end
	
	Get_Loadout()	-- function to read pylon draw arguments 	
end


dev:listen_event("WeaponRearmComplete")

function CockpitEvent(event, val)												
    if event == "WeaponRearmComplete" then
		Get_Loadout()	-- function to read pylon draw arguments 
	end
end



-- Param handles used for displaying mfd elements
local WINGTIP_L_LOADOUT = get_param_handle("WINGTIP_L_LOADOUT")
local OUTER_PYLON_L_LOADOUT	= get_param_handle("OUTER_PYLON_L_LOADOUT")
local INNER_PYLON_L_LOADOUT = get_param_handle("INNER_PYLON_L_LOADOUT")
local CENTERLINE_PYLON_LOADOUT = get_param_handle("CENTERLINE_PYLON_LOADOUT")
local CHEEK_PYLON_LOADOUT = get_param_handle("CHEEK_PYLON_LOADOUT")
local INNER_PYLON_R_LOADOUT = get_param_handle("INNER_PYLON_R_LOADOUT")
local OUTER_PYLON_R_LOADOUT = get_param_handle("OUTER_PYLON_R_LOADOUT")
local WINGTIP_R_LOADOUT	= get_param_handle("WINGTIP_R_LOADOUT")

function Get_Loadout() 

WINGTIP_L_LOADOUT:set(math.floor((get_aircraft_draw_argument_value(308))*(10^2)+0.5)/10^2 )
OUTER_PYLON_L_LOADOUT:set( math.floor((get_aircraft_draw_argument_value(309))*(10^2)+0.5)/10^2 )
INNER_PYLON_L_LOADOUT:set( math.floor((get_aircraft_draw_argument_value(310))*(10^2)+0.5)/10^2 )
CENTERLINE_PYLON_LOADOUT:set( math.floor((get_aircraft_draw_argument_value(313))*(10^2)+0.5)/10^2 )
CHEEK_PYLON_LOADOUT:set( math.floor((get_aircraft_draw_argument_value(315))*(10^2)+0.5)/10^2 )
INNER_PYLON_R_LOADOUT:set( math.floor((get_aircraft_draw_argument_value(316))*(10^2)+0.5)/10^2 )
OUTER_PYLON_R_LOADOUT:set( math.floor((get_aircraft_draw_argument_value(317))*(10^2)+0.5)/10^2 )
WINGTIP_R_LOADOUT:set( math.floor((get_aircraft_draw_argument_value(318))*(10^2)+0.5)/10^2 )

end



need_to_be_closed = false