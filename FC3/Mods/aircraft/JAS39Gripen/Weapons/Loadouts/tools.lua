dofile('Scripts/Database/Weapons/warheads.lua')

function RocketPod(shape, element, count, pattern)
    local ret = {{ShapeName = shape, IsAdapter = true}}

    if element ~= nil and count ~= nil then
        local pattern = pattern or "tube_%02d"
        for i = 1, count do
            if i > 9 then
                ret[#ret + 1] = {
                    ShapeName      = element,
                    connector_name = "tube_" .. tostring(i),
                    DrawArgs  = {
                        [1] = {2, 1.0},
                    }
                }
            elseif i > 0 then
                ret[#ret + 1] = {
                    ShapeName      = element,
                    connector_name = "tube_0" .. i,
                    DrawArgs  = {
                        [1] = {2, 1.0},
                    }
                }
            end
        end
    end
    
    return ret
end

