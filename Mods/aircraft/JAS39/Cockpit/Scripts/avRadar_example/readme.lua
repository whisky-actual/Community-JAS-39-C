--put this line into your device_init.lua----------
dofile(LockOn_Options.script_path.."avRadar_example/radarexample_device_init.lua")


--in the part where you define your AC, you need to specify the radar:-----


Sensors = {
		--RADAR = "N-019", 
		RADAR = "AN/APQ-159",
		},







--Input---------------

{combos = {{key = 'Enter'}}, down = iCommandPlane_LockOn_start, up = iCommandPlane_LockOn_finish, name = 'Target Lock', category = 'Sensors'},

{combos = {{key = ';'}}, pressed = iCommandPlaneRadarUp, up = iCommandPlaneRadarStop, name = _('Target Designator Up'), category = _('Sensors')},
{combos = {{key = '.'}}, pressed = iCommandPlaneRadarDown, up = iCommandPlaneRadarStop, name = _('Target Designator Down'), category = _('Sensors')},
{combos = {{key = ','}}, pressed = iCommandPlaneRadarLeft, up = iCommandPlaneRadarStop, name = _('Target Designator Left'), category = _('Sensors')},
{combos = {{key = '/'}}, pressed = iCommandPlaneRadarRight, up = iCommandPlaneRadarStop, name = _('Target Designator Right'), category = _('Sensors')},