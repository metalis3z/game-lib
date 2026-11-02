-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Layers = require(script.Parent.Parent.Layers)
return function(v1) -- line 7 | captures: Layers
    local Host = v1.Host
    local v2 = Layers.Paint(Host, {
        Palette = "Gold",
        Rotation = -75,
        Drift = v1.Drift
    })
    local v3 = Layers.Edge(Host, v1.Width)
    local v4 = Layers.Paint(v3.outline, {
        Palette = "Gold",
        Rotation = 75,
        Drift = -v1.Drift
    })
    return Layers.Result({ v2, v4, v3 })
end
