mount_vfs_texture_archives("Bazar/Textures/AvionicsCommon")

local script_path = LockOn_Options.script_path

dofile(LockOn_Options.common_script_path.."tools.lua")
dofile(script_path.."devices.lua")
dofile(script_path.."materials.lua")

--dofile(script_path.."snds.lua")
dofile(script_path.."sounds_init.lua")

layoutGeometry = {}

--MainPanel = {"ccMainPanel", script_path .. "mainpanel_init.lua"}
MainPanel = {"DEKA_Device::JF_17::ccMainPanel", script_path .. "mainpanel_init.lua"}

---- Avionics devices initialization example
--    items in <...> are optional
-- creators[DEVICE_ID] = {"NAME_OF_CONTROLLER_CLASS",
--                          <"CONTROLLER_SCRIPT_FILE",>
--                          <{devices.LINKED_DEVICE1, devices.LINKED_DEVICE2, ...},>
--                          <"INPUT_COMMANDS_SCRIPT_FILE",>
--                          <{{"NAME_OF_INDICATOR_CLASS", "INDICATOR_SCRIPT_FILE"}, ...}>
--                         }

----------------------------------------------------------------------------------------------------------------
-- Devices
----------------------------------------------------------------------------------------------------------------
creators = {}

creators[devices.CANOPY]     			= {"avLuaDevice"			,LockOn_Options.script_path.."Systems/Canopy.lua"}


creators[devices.ELECTRIC_SYSTEM] = {"DEKA_Device::JF_17::avPowerSystem", script_path .. "PowerSystem/avPowerSystem.lua", {}}
creators[devices.AAP]             = {"DEKA_Device::JF_17::avAAP",         script_path .. "PowerSystem/avAAP.lua", {}}

creators[devices.LIGHTS]          = {"DEKA_Device::JF_17::avLights",        script_path .. "Lights/avLights.lua", {}}
creators[devices.WARNING_SYSTEM]  = {"DEKA_Device::JF_17::avWarningSystem", script_path .. "WarningSystem/avWarningSystem.lua", {}}

creators[devices.EMMC]            = {"DEKA_Device::JF_17::avEMMC", script_path .. "Avionics/avEMMC.lua", {}}
creators[devices.ADC]             = {"DEKA_Device::JF_17::avADC",  script_path .. "Avionics/avADC.lua", {}}
creators[devices.DTC]             = {"DEKA_Device::JF_17::avDTC",  script_path .. "Avionics/avDTC.lua", {}}

creators[devices.RDR]             = {"DEKA_Device::JF_17::avPDRadarKLJ7", script_path .. "Sensor/avPDRadarKLJ7.lua", {}}

creators[devices.RWR]             = {"DEKA_Device::JF_17::avEWS",  script_path .. "Defense/avEWS.lua", {}}
creators[devices.OESP]            = {"DEKA_Device::JF_17::avOESP", script_path .. "Defense/avOESP.lua", {}}
creators[devices.SPJ]             = {"DEKA_Device::JF_17::avSPJ",  script_path .. "Defense/avSPJ.lua", {}}
creators[devices.IFF]             = {"DEKA_Device::JF_17::avSimpleIFF", script_path .. "Defense/avSimpleIFF.lua", {}}

creators[devices.FCS]             = {"DEKA_Device::JF_17::avFCS", script_path .. "FCS/avFCS.lua", {}}
creators[devices.WCS]             = {"DEKA_Device::JF_17::avWCS", script_path .. "WCS/avWCS.lua", {}}
creators[devices.SMS]             = {"DEKA_Device::JF_17::avSMS", script_path .. "WCS/avSMS.lua", {}}

creators[devices.HUD]             = {"DEKA_Device::JF_17::avHUD",  script_path .. "HUD/avHUD.lua", {}}
creators[devices.UFCP]            = {"DEKA_Device::JF_17::avUFCP", script_path .. "UFCP/avUFCP_init.lua", {}}
creators[devices.MFCD]            = {"DEKA_Device::JF_17::avMFCD", script_path .. "MFCD/avMFCD.lua", {}}

creators[devices.SHARS]           = {"DEKA_Device::JF_17::avSHARS",      script_path .. "Nav/avSHARS.lua", {}}
creators[devices.INS]             = {"DEKA_Device::JF_17::avINS",        script_path .. "Nav/avINS.lua", {}}
creators[devices.NAVCOMP]         = {"DEKA_Device::JF_17::avNavComp",    script_path .. "Nav/avNavComp.lua", {}}
creators[devices.DMAP]            = {"DEKA_Device::JF_17::avDigitalMap", script_path .. "Nav/avDigitalMap.lua", {}}

creators[devices.RALT]            = {"DEKA_Device::JF_17::avRAltMeter",    script_path .. "Nav/avRAltMeter.lua", {}}
creators[devices.SNS]             = {"DEKA_Device::JF_17::avSNS_Receiver", script_path .. "Nav/avSNS_Receiver.lua", {}}
creators[devices.MLS]             = {"DEKA_Device::JF_17::avMLS",          script_path .. "Nav/avMLS.lua", {}}
creators[devices.TACAN]           = {"DEKA_Device::JF_17::avTCN",          script_path .. "Nav/avTCN.lua", {}}

creators[devices.INTERCOM]        = {"DEKA_Device::JF_17::avRadioINT",   script_path .. "Radio/avRadioINT.lua", {}}
creators[devices.COMM1]           = {"DEKA_Device::JF_17::avRadioComm1", script_path .. "Radio/avRadioComm1.lua", {}}
creators[devices.COMM2]           = {"DEKA_Device::JF_17::avRadioComm2", script_path .. "Radio/avRadioComm2.lua", {}}
creators[devices.DATALINK]        = {"DEKA_Device::JF_17::avDataLink",   script_path .. "Radio/avDataLink.lua", {}}

creators[devices.CNI]             = {"DEKA_Device::JF_17::avCNI",       script_path .. "Avionics/avCNI.lua", {}}
creators[devices.ACP]             = {"DEKA_Device::JF_17::avACP",       script_path .. "Avionics/avACP.lua", {}}

creators[devices.ECS]             = {"DEKA_Device::JF_17::avECS",       script_path .. "Avionics/avECS.lua", {}}
creators[devices.OXYGEN]          = {"DEKA_Device::JF_17::avOxySystem", script_path .. "Avionics/avOxySystem.lua", {}}

creators[devices.GEAR]            = {"DEKA_Device::JF_17::avGEAR",   script_path .. "Mech/avGear.lua", {}}
creators[devices.FUEL]            = {"DEKA_Device::JF_17::avFUEL",   script_path .. "Mech/avFuel.lua", {}}
creators[devices.ENGINE]          = {"DEKA_Device::JF_17::avENGINE", script_path .. "Mech/avEngine.lua", {}}
creators[devices.HYDRAULICS]      = {"DEKA_Device::JF_17::avHydraulicsSystem", script_path .. "Mech/avHydraulicsSystem.lua", {}}
creators[devices.PNEUMATIC]       = {"DEKA_Device::JF_17::avPneumaticSystem",  script_path .. "Mech/avPneumaticSystem.lua", {}}
creators[devices.CANARDS]      			= {"avLuaDevice"			,LockOn_Options.script_path.."Systems/Canards.lua"}


creators[devices.ZCP]             = {"DEKA_Device::JF_17::avZCP",  script_path .. "Avionics/avZCP.lua", {}}
creators[devices.MISC]            = {"DEKA_Device::JF_17::avMISC", script_path .. "Avionics/avMISC.lua", {}}

creators[devices.CLOCK]           = {"DEKA_Device::JF_17::avClock", script_path .. "Clock/avClock.lua", {}}

-- CONTROL_INDICATOR
creators[devices.CTRL_IND]        = {"avLuaDevice", script_path .. "ControlsIndicator/ctrl_indicator_data.lua", {}}
creators[devices.MACRO]           = {"DEKA_Device::JF_17::avMacro", LockOn_Options.common_script_path .. "Macro_handler.lua", {}}

--creators[devices.NVG]             = {"avNightVisionGoggles", script_path .. "HELMET/NVG.lua", {}}
creators[devices.NVG]             = {"DEKA_Device::JF_17::avNVG", script_path .. "HELMET/NVG.lua", {}}

-- Experimental
--creators[devices.PITO]            = {"DEKA_Device::JF_17::avPito", script_path .. "Avionics/avPito.lua", {}}
--creators[devices.TEST_DEV]        = {"DEKA_Device::JF_17::avTestDev", ""}

creators[devices.EFFECT]          = {"DEKA_Device::JF_17::avEffect", script_path .. "Effects/avEffect.lua", {}}

----------------------------------------------------------------------------------------------------------------
-- Indicators
----------------------------------------------------------------------------------------------------------------
indicators = {}

-- imGUI debug window
indicators[#indicators + 1] = {"DEKA_Device::Common::ccDebugWin", script_path .. "DebugWindow/DebugWindow_page_init.lua"}

-- throttle/rudder/pitch/bank/brake/flaps/gears
indicators[#indicators + 1] = {"ccIndicator", script_path .. "ControlsIndicator/Indicator/ctrl_indicator_page_init.lua"}

-- HMD
--indicators[#indicators + 1] = {"DEKA_Device::JF_17::ccHMD", script_path .. "HMD/Indicator/HMD_page_init.lua"}

-- HUD
indicators[#indicators + 1] = {"DEKA_Device::JF_17::ccHUD", script_path .. "HUD/Indicator/HUD_page_init.lua", devices.HUD, {{"CPT-HUD-CENTER"},{sx_l = 0,sy_l = 0,sz_l = 0,sh = 0,sw = 0}}}

-- UFCP LCD window
indicators[#indicators + 1] = {"DEKA_Device::JF_17::ccUFCP", script_path .. "UFCP/UFCP_init_1.lua", devices.UFCP, {{"CPT-UFCP-1-CENTER","CPT-UFCP-1-DOWN","CPT-UFCP-1-RIGHT"}}}
indicators[#indicators + 1] = {"DEKA_Device::JF_17::ccUFCP", script_path .. "UFCP/UFCP_init_2.lua", devices.UFCP, {{"CPT-UFCP-2-CENTER","CPT-UFCP-2-DOWN","CPT-UFCP-2-RIGHT"}}}
indicators[#indicators + 1] = {"DEKA_Device::JF_17::ccUFCP", script_path .. "UFCP/UFCP_init_3.lua", devices.UFCP, {{"CPT-UFCP-3-CENTER","CPT-UFCP-3-DOWN","CPT-UFCP-3-RIGHT"}}}
indicators[#indicators + 1] = {"DEKA_Device::JF_17::ccUFCP", script_path .. "UFCP/UFCP_init_4.lua", devices.UFCP, {{"CPT-UFCP-4-CENTER","CPT-UFCP-4-DOWN","CPT-UFCP-4-RIGHT"}}}

-- RCB
indicators[#indicators + 1] = {"DEKA_Device::JF_17::ccRadio",script_path .. "Radio/Indicator/RADIO_init.lua", devices.INTERCOM, {{"CPT-RADIO-CENTER","CPT-RADIO-DOWN","CPT-RADIO-RIGHT"}}}

tv_map_render_id ={1, 2, 3, 4};
--indicators[#indicators + 1] = {"ccXXX", script_path , Linked avDevice, { {"CENTER","DOWN","RIGHT"},{}, tv_map_render_id[x]} }

-- MFCD
indicators[#indicators + 1] = {"DEKA_Device::JF_17::ccMFCD", script_path .. "MFCD/MFCD_init_LEFT.lua", devices.MFCD,   { {"CPT-MFCD-L-CENTER","CPT-MFCD-L-DOWN","CPT-MFCD-L-RIGHT"}, {sx=0, sy=0, sz=0}, tv_map_render_id[2] } }
indicators[#indicators + 1] = {"DEKA_Device::JF_17::ccMFCD", script_path .. "MFCD/MFCD_init_CENTER.lua", devices.MFCD, { {"CPT-MFCD-M-CENTER","CPT-MFCD-M-DOWN","CPT-MFCD-M-RIGHT"}, {sx=0, sy=0, sz=0}, tv_map_render_id[1] } }
indicators[#indicators + 1] = {"DEKA_Device::JF_17::ccMFCD", script_path .. "MFCD/MFCD_init_RIGHT.lua", devices.MFCD,  { {"CPT-MFCD-R-CENTER","CPT-MFCD-R-DOWN","CPT-MFCD-R-RIGHT"}, {sx=0, sy=0, sz=0}, tv_map_render_id[3] } }

-- Clock
indicators[#indicators + 1] = {"DEKA_Device::JF_17::ccClock", script_path .. "Clock/Clock_init_1.lua", devices.CLOCK, {{"CPT-CLK-U-CENTER","CPT-CLK-U-DOWN","CPT-CLK-U-RIGHT"}}}
indicators[#indicators + 1] = {"DEKA_Device::JF_17::ccClock", script_path .. "Clock/Clock_init_2.lua", devices.CLOCK, {{"CPT-CLK-D-CENTER","CPT-CLK-D-DOWN","CPT-CLK-D-RIGHT"}}}

kneeboard_implementation = "DEKA_Device::JF_17::ccKneeBrdExt"
dofile(LockOn_Options.common_script_path .. "KNEEBOARD/declare_kneeboard_device.lua")

--------------------------------------

-- Vaicom Pro
--[[
local file_exists = function(filename)
    local f = io.open(filename,"r")
    if f ~= nil then
        io.close(f)
        return true
    else
        return false
    end
end

local file = LockOn_Options.common_script_path.."VAICOMPRO/declare_VAICOMPRO_device.lua"

if file_exists(file) then
    dofile(file)
end
]]