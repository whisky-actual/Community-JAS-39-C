local AAQ_name = 'Litening III POD (LLTV)'
local pylon_mass = 50.0


local gimbal = { 

            type = OPTIC_SENSOR_LLTV,
            scan_volume =
            {
                azimuth = {-150.0, 150.0},	--aaq-28
                elevation = {-150.0, 45.0}
            },
            view_volume_max = 
            {
                azimuth_sector = 18.4,
                elevation_sector = 24.1
            },
            lightness_limit = 0.04,
            magnifications = {20.0, 100.0, 280.0},	--aaq-28 CCD tv
            resolution = 0.085,
},
	
 






declare_loadout(
{
    category    = CAT_PODS,
    displayName = _(AAQ_name),
    Picture     = "AAQ-28.png",
    attribute    =    {4,    15,    44,    19},
    CLSID       = "JAS_Litening",
    
    Weight = 245 + pylon_mass,
    Cx_pil = 0.00105,
    shape_table_data =
    {
        {
            name = AAQ_name,
            file = "AAQ",
            life = 1,
            fire = { 0, 1},
            username = AAQ_name,
            index = WSTYPE_PLACEHOLDER,
        },
    },
    Elements =
    {
        [1] = {
            Position = {0, 0, 0},
            ShapeName = "kingal",
        },
    },
}
)