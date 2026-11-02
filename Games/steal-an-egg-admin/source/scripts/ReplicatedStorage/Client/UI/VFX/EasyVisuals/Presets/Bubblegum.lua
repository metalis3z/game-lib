-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Layers = require(script.Parent.Parent.Layers)
return function(v1) -- line 7 | captures: Layers
    local Host = v1.Host
    local v2 = Layers.Paint(Host, {
        Palette = "Bubblegum",
        Rotation = -90,
        Drift = v1.Drift
    })
    local v3 = Layers.Edge(Host, v1.Width)
    local v4 = Layers.Paint(v3.outline, {
        Palette = "Bubblegum",
        Rotation = -45,
        Drift = v1.Drift * 0.9
    })
    local v5 = Layers.Breathe(v3, v1.Width, v1.Width * 3, v1.Drift, 0.055)
    return Layers.Result({ v2, v4, v3 }, { v5 })
end
