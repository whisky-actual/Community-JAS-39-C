function get_hyd_flight_control_ok()
    return hyd_flight_control_ok:get()==1 and true or false
end

function get_hyd_utility_ok()
    return hyd_utility_ok:get()==1 and true or false
end

function get_hyd_brakes_ok()
    return hyd_brakes_ok:get()==1 and true or false
end

hyd_flight_control_ok = get_param_handle("HYD_FLIGHT_CONTROL_OK")   -- 1 or 0
hyd_utility_ok = get_param_handle("HYD_UTILITY_OK")                 -- 1 or 0
hyd_brakes_ok = get_param_handle("HYD_BRAKES_OK")                   -- 1 or 0

--[[
The various systems are on the hydraulic systems (see FO-6 in NATOPS):
(lines beginning with = have already been "connected"
the rest need to be done still (if possible and relevant))

1. Flight Control System

Ailerons
Canards
Rudder

2. Utility System

Ailerons
Elevators
Rudder
Spoilers
Flaps
Landing Gear
Speedbrakes

3. Brake System

Left Wheel Brake
Right Wheel Brake
--]]