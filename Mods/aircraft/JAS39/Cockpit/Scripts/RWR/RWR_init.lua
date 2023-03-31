dofile(LockOn_Options.common_script_path .. "devices_defs.lua")
dofile(LockOn_Options.script_path .. "command_defs.lua")
dofile(LockOn_Options.script_path .. "devices.lua")
dofile(LockOn_Options.script_path .. "RWR/symboles.lua")

local gettext = require("i_18n")

sensor_data = get_base_data()

local RWRPOWER_STATE = get_param_handle("RWRPOWER_STATE")
-- local RWR_VOL  = get_param_handle("RWR_VOL")

local RWRAIR = get_param_handle("RWRAIR")
local RWRAAA = get_param_handle("RWRAAA")
local RWRSAM = get_param_handle("RWRSAM")
local RWREWR = get_param_handle("RWREWR")
local RWRSEA = get_param_handle("RWRSEA")
local RWRMIS = get_param_handle("RWRMIS")

-- local RWR_TXT  = get_param_handle("RWRTXT")
-- local RWR_COUNT_T  = get_param_handle("RWR_COUNT_T")

RWRAIR:set(1)
RWRAAA:set(1)
RWRSAM:set(1)
RWREWR:set(1)
RWRSEA:set(1)
RWRMIS:set(1)

device_timer_dt = 0.0166
MaxThreats = 20
EmitterLiveTime = 10.0
EmitterSoundTime = 0.1
LaunchSoundDelay = 40

DefaultType = 10
RWR_detection_coeff = 1

RWR_SEARCHSIGNAL = 1
RWR_LOCKSIGNAL = 2
RWR_LAUNCHSIGNAL = 3

eyes = {}
eyes[1] = {
    position = {
        x = 10.178,
        y = 0.612,
        z = 0
    },
    orientation = {
        azimuth = math.rad(45),
        elevation = math.rad(0.0)
    },
    field_of_view = math.rad(360)
}
eyes[2] = {
    position = {
        x = 9.186,
        y = -0.739,
        z = 0
    },
    orientation = {
        azimuth = math.rad(-45),
        elevation = math.rad(0.0)
    },
    field_of_view = math.rad(360)
}
eyes[3] = {
    position = {
        x = -5.145,
        y = 2.89,
        z = 2.156
    },
    orientation = {
        azimuth = math.rad(135),
        elevation = math.rad(0.0)
    },
    field_of_view = math.rad(360)
}
eyes[4] = {
    position = {
        x = -5.145,
        y = 2.89,
        z = -2.156
    },
    orientation = {
        azimuth = math.rad(-135),
        elevation = math.rad(0.0)
    },
    field_of_view = math.rad(360)
}
-------------------------------------------------------------------------
update_time_step = 0.01666 -- 0.0166 --once every 1/60 sec

make_default_activity(update_time_step)
dev = GetSelf()

function string:split(inSplitPattern, outResults)
    if not outResults then
        outResults = {}
    end
    local theStart = 1
    local theSplitStart, theSplitEnd = string.find(self, inSplitPattern, theStart)
    while theSplitStart do
        table.insert(outResults, string.sub(self, theStart, theSplitStart - 1))
        theStart = theSplitEnd + 1
        theSplitStart, theSplitEnd = string.find(self, inSplitPattern, theStart)
    end
    table.insert(outResults, string.sub(self, theStart))
    return outResults
end
-------------------------------------------------------------------------
rwr = {}
for ia = 1, MaxThreats do
    local i = ''

    if ia < 10 then
        i = "_0" .. ia .. "_"
    else
        i = "_" .. ia .. "_"
    end

    rwr[ia] = {
        elevation_h = get_param_handle("RWR_CONTACT" .. i .. "ELEVATION"),
        azimuth_h = get_param_handle("RWR_CONTACT" .. i .. "AZIMUTH"),
        power_h = get_param_handle("RWR_CONTACT" .. i .. "POWER"),
        unit_type_h = get_param_handle("RWR_CONTACT" .. i .. "UNIT_TYPE"),

        general_type_h = get_param_handle("RWR_CONTACT" .. i .. "GENERAL_TYPE"),
        signal_h = get_param_handle("RWR_CONTACT" .. i .. "SIGNAL"),
        time_h = get_param_handle("RWR_CONTACT" .. i .. "TIME"),

        unit_type_sym_h = get_param_handle("RWR_CONTACT" .. i .. "UNIT_TYPE_SYM"),
        unit_type_syn_h = get_param_handle("RWR_CONTACT" .. i .. "UNIT_TYPE_SYN"),
        lock_sym_h = get_param_handle("RWR_CONTACT" .. i .. "LOCK_SYM"),
        lock_sym = get_param_handle("RWR_CONTACT" .. i .. "LOCK"),
        power_sym_h = get_param_handle("RWR_CONTACT" .. i .. "POWER_SYM"),
        power_syn_h = get_param_handle("RWR_CONTACT" .. i .. "POWER_SYN"),
        cur_priority_h = get_param_handle("RWR_CONTACT" .. i .. "CURPRIORITY"),

        is_shown = get_param_handle("RWR" .. i .. "SHOWN"),
        is_num = get_param_handle("RWR" .. i .. "ISNUM"),

        obj_type = get_param_handle("RWR" .. i .. "OBJ_TYPE"),

        unit_type_ut = get_param_handle("RWR_CONTACT_" .. ia .. "_UT"),

        hdg = get_param_handle("RWR_CONTACT" .. i .. "HDG"),

        elevation_hud = get_param_handle("RWR_CONTACT" .. i .. "ELEVATION_HUD"),
        azimuth_hud = get_param_handle("RWR_CONTACT" .. i .. "AZIMUTH_HUD")

    }
end

-- DIFFERENCES--
function post_initialize()
    GetDevice(devices.RWR):set_power(true)
    -- show_param_handles_list(true)--for testing
end
---------------------------------
function SetCommand(command, value)

end

---------------------------------
function update()

    prep_contacts()
    -- ADDED--------------------------
    local infile = io.open(LockOn_Options.script_path .. "RWR/symboles.lua", "r")
    if infile then
        instr = infile:read()
        while instr ~= nil do
            data = instr:split(",")
            symbols[string.upper(data[1])] = {
                name = data[2],
                sym = data[3]
            }
            instr = infile:read()
        end
        infile:close()
    end
    -------------------------------	
end

-----
function prep_contacts()

    local esam_search = false

    -----START RWR CODE-------------
    -- ***************************

    for i = 1, MaxThreats do
        local tmp_rwr_signal = 0 -- keep those variable scope inside the loop prevent unexpected problem
        local tmp_rwr_type = 0
        local tmp_rwr_power = 0
        local tmp_nb_contacts = 0
        local tmp_gen_type = 0
        local tmp_pitch = 0
        local tmp_roll = 0
        local tmp_power = 0
        local tmp_elevation = 0
        local tmp_azimuth = 0
        local vtmp_rwr_type = 0

        rwr[i].cur_priority_h:set(0)
        if i == 1 then
            rwr[i].cur_priority_h:set(1)
        end
        tmp_rwr_type = rwr[i].unit_type_h:get()
        tmp_gen_type = rwr[i].general_type_h:get()

        rwr[i].unit_type_ut:set("")
        tmp_rwr_signal = rwr[i].signal_h:get()

        if tmp_rwr_type ~= nil and tmp_rwr_type ~= 0 and tmp_rwr_signal > 0 then
            tmp_nb_contacts = tmp_nb_contacts + 1
            -- *********
            vtmp_rwr_type = tmp_rwr_type -- (tmp_rwr_type, 1)
            rwr[i].unit_type_ut:set(vtmp_rwr_type)
            -- *********			
            if tmp_rwr_signal == RWR_LOCKSIGNAL then -- 2 Lock  RWR_LOCKSIGNAL = 2
                rwr[i].lock_sym_h:set(1)
                rwr[i].lock_sym:set(1)
                ------
            elseif tmp_rwr_signal == RWR_LAUNCHSIGNAL then -- 3 Launch RWR_LAUNCHSIGNAL = 3
                -- tmp_timeer = tmp_timeer + 1 It's not using anywhere else

                local a = rwr[i].lock_sym:get()
                ------------
                if a == 1 then
                    rwr[i].lock_sym:set(0)
                else
                    rwr[i].lock_sym:set(1)
                end

                if rwr[i].lock_sym_h:get() == 1 then
                    rwr[i].lock_sym_h:set(0)
                else
                    rwr[i].lock_sym_h:set(1)
                end

            else -- else 1 - Search RWR_SEARCHSIGNAL = 1
                rwr[i].lock_sym_h:set(0)
                rwr[i].lock_sym:set(0)

            end
            ------------
            local vtmp_rwr_type2 = get_threat_type(tmp_rwr_type, 2) -- keep variable immutable
            if tonumber(vtmp_rwr_type2) ~= nil then
                rwr[i].unit_type_syn_h:set(vtmp_rwr_type2)
                -- Not populated? clean!
                rwr[i].unit_type_sym_h:set(0)

                rwr[i].is_num:set(1)
            else
                rwr[i].unit_type_sym_h:set(vtmp_rwr_type2)
                -- Not populated? clean!
                rwr[i].unit_type_syn_h:set(0)
                rwr[i].is_num:set(0.2)
            end

            esam_search = true
            if tmp_gen_type == 1 then -- Plane
                rwr[i].obj_type:set(TYPESearchRadar)
                rwr[i].is_shown:set(RWRSAM:get())
            elseif tmp_gen_type == 2 then -- SearchRadar
                rwr[i].obj_type:set(TYPEPlane)
                rwr[i].is_shown:set(RWRAIR:get())
            elseif tmp_gen_type == 0 then -- EWR
                rwr[i].obj_type:set(TYPEEWR)
                rwr[i].is_shown:set(RWREWR:get())
            elseif tmp_gen_type == 3 then -- SEA
                rwr[i].obj_type:set(TYPESEA)
                rwr[i].is_shown:set(RWRSEA:get())
            elseif tmp_gen_type == 4 then -- Missil
                rwr[i].obj_type:set(TYPEMissile)
                rwr[i].is_shown:set(1)
            else
                rwr[i].obj_type:set(0)
                rwr[i].is_shown:set(0)

            end
        end

        tmp_pitch = -(math.deg(sensor_data.getPitch()))
        tmp_roll = sensor_data.getRoll()
        tmp_power = rwr[i].power_h:get()
        tmp_elevation = rwr[i].elevation_h:get()
        tmp_azimuth = rwr[i].azimuth_h:get()

        rwr[i].elevation_hud:set(rwr[i].elevation_h:get() - tmp_roll)
        rwr[i].azimuth_hud:set(rwr[i].azimuth_h:get() - tmp_pitch)

        local myhdg = math.deg(sensor_data.getHeading())
        local hdg = (360 / tmp_azimuth) + myhdg
        if hdg < 0 then
            hdg = 360 + hdg
        end
        hdg = hdg % 360
        rwr[i].hdg:set(hdg)

        local tmp = 0
        local tmp_power = rwr[i].power_h:get()

        if tmp_gen_type == 4 then -- for missile

            -- At least 0.85 for a pitbull missile  
            -- when x = 0 f(x) ~ 0.85
            -- when x = 0.3 f(x) ~ 0.87
            -- when x = 0.6 f(x) ~ 0.9
            -- when x = 1   f(x) ~ 1 
            -- See the graph here for the equation: https://www.symbolab.com/graphing-calculator?or=input&functions=f(x)=0.85%2B(%5Cfrac%7B(1-0.85)%7D%7B(1-0.05)%5E%7B3%7D%7D)%5Ccdot%5C:(x-0.05)%5E%7B3%7D

            tmp_power = 0.85+(1-0.85)/(1-0.05)^3*(tmp_power-0.05)^3 

            if (tmp_power >= 0.95) then 
                tmp_power = 0.95
            end

            -- No need constant for missile.  Already considered in the equation.
            tmp = 1 - tmp_power

        else
            
            tmp = 1 - tmp_power + 0.1

        end

        rwr[i].power_sym_h:set(tmp)

        if tmp >= 0.82 and tmp_rwr_signal == 1 then
            rwr[i].power_syn_h:set(0.82)
        else
            rwr[i].power_syn_h:set(tmp)
        end
    end
end