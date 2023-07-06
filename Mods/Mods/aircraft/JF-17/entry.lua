
local self_ID  = 'JF-17 by Deka Ironwork Simulations'
local ac_name  = 'JF-17'
local bin_name = 'JF-17_ASM'

dofile(current_mod_path .. '/preload.lua')

declare_plugin(self_ID, {
    installed     = true,
    dirName       = current_mod_path,
    displayName   = _(ac_name),
    shortName     = ac_name,
    fileMenuName  = _(ac_name),
    version       = "EA",
    state         = 'installed',
    developerName = _('Deka Ironwork Simulations'),
    info          = _("JF-17 is a single seat, single engine, multirole light fighter that joint developed by AVIC Chengdu and Pakistan Aeronautical Complex (PAC). The design phase of JF-17 'Thunder' finished on May 31st, 2002, and the maiden flight was made on August 25th, 2003. 'Thunder' has a bubble canopy of great view, pretty strake-wing layout and advanced avionics. KLJ-7 radar provides excellent air to ground capability. WMD-7 targeting pod can help 'Thunder' searching for targets in combat. Although 'Thunder' has small size, remember that: she is one of the most advanced fighter jets in the DCS World."),
    binaries      = { bin_name, },
    update_id     = 'DEKA_JF-17',
    InputProfiles = {
        [ac_name] = current_mod_path .. '/Input/JF-17',
    },
    Skins = {
        { name = ac_name, dir = 'Skins/1' },
    },
    Missions = {
        { name = _(ac_name), dir = 'Missions', CLSID = '{JF-17 missions}', },
    },
    LogBook = {
        { name = _(ac_name), type = ac_name },
    },
    Options =
    {
        {
            name   = _(ac_name),
            nameId = ac_name,
            dir    = 'Options',
            CLSID  = '{JF-17 options}',
            --AircraftSettingsFile = 'AircraftSettings.lua'
        },
    },
    preload_resources = preload_files,
    infoWaitScreen = _('DCS: JF-17 by Deka Ironwork Simulations.'),
})

---------------------------------------------------------------------------------------
mount_vfs_model_path   (current_mod_path .. '/Cockpit/Shapes')
mount_vfs_texture_path (current_mod_path .. '/Cockpit/Shapes/Textures')
mount_vfs_texture_path (current_mod_path .. '/Cockpit/Textures/IndicationTextures')
mount_vfs_liveries_path(current_mod_path .. '/Liveries')
mount_vfs_texture_path (current_mod_path .. '/Skins/1/ME')


local cfg_path = current_mod_path .. '/FM/config.lua'
dofile(cfg_path)

JF17_FM[1]           = self_ID
JF17_FM[2]           = bin_name
JF17_FM.config_path  = cfg_path
JF17_FM.user_options = ac_name

---------------------------------------------------------------------------------------
dofile(current_mod_path..'/JF-17/Payload.lua')
is_entry = true
dofile(current_mod_path .. '/Views.lua')

make_view_settings(ac_name, ViewSettings, SnapViews)
---------------------------------------------------------------------------------------
make_flyable(ac_name, current_mod_path .. '/Cockpit/Scripts/', JF17_FM, current_mod_path .. '/Comm/comm.lua')

plugin_done()
