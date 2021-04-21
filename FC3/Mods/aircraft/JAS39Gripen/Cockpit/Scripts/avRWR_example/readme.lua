--put this line into your device_init.lua----------
dofile(LockOn_Options.script_path.."avRadar_example/radarexample_device_init.lua")


--in the part where you define your AC, you need to as that it has an RWR:-----


Sensors = {
		RWR = "Abstract RWR",
		},



