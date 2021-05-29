Presets = 
{
    JAS_39_VAPOR_CONE =
    {
        {
            Type = "speedSmoke",	-- .fx file
            Texture = "smoke6_nm.dds", -- texture
            Tech = "Steam",				-- no file found
            
            ParticlesLimit = 10000,
            LODdistance    = 500,	
            BaseColor      = {0.1*1.4, 0.12*1.4, 0.14*1.4},
            Radius         = 0.35, -- meters
            RadiusMax      = 1.55, -- max rotation radius of each particle, m
            ScaleBase      = 1.2, --  meters  density

            ScaleJitter = {
                {  20, 2},
                { 100, 2},
                {1000, 1}
            },
            ConvectionSpeed = { --
                {1, 100},
                {5, 200},
            },
            OffsetMax = { -- The maximum range of the smoke ball, the larger the number, the smaller the range
                {  20, 0.25},
                {1000, 0.15}
            },
            FrequencyMin = {
                {  20, 0.025},
                {1000, 0.700}
            },
            FrequencyJitter = {
                {  20, 25},
                {1000, 25}
            },
            AngleJitter = { -- No effect found
                {20, 0.5},
                {1000, 0.2}
            },
            DistMax = {     -- Determine the density of smoke, the smaller the density, the greater the density
                {   3, 6},
                {  20, 3},
                {1000, 0.05},
                {2000, 1}
            },
            TrailLength = { --Departure speed
                {   1, 1},
                {  20, 2},
                { 300, 4},
                {1000, 8},
                {2000, 16}
            }

        }
    }
}

