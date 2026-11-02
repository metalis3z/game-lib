-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Layers = require(script.Parent.Parent.Layers)
return function(v1) -- line 7 | captures: Layers
    local Host = v1.Host
    local v2 = Layers.Paint(Host, {
        Palette = "Fire",
        Rotation = -75,
        Drift = v1.Drift
    })
    local v3 = Layers.Turn(v2, v2.gradient, 0, v1.Drift)
    local v4 = Layers.Edge(Host, v1.Width)
    local v5 = Layers.Paint(v4.outline, {
        Palette = "Fire",
        Rotation = 75,
        Drift = -v1.Drift
    })
    return Layers.Result({ v2, v5, v4 }, { v3 })
end
