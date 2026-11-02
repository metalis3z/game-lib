-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Layers = require(script.Parent.Parent.Layers)
return function(v1) -- line 7 | captures: Layers
    local Host = v1.Host
    local Ghost = Layers.AlphaStops("Ghost")
    local v2 = Layers.Paint(Host, {
        Palette = "Ghost",
        Alpha = Ghost,
        Drift = v1.Drift,
        AlphaDrift = v1.Drift * 0.9
    })
    local v3 = Layers.Edge(Host, v1.Width)
    local v4 = Layers.Paint(v3.outline, {
        Palette = "Ghost",
        Alpha = Ghost,
        Drift = -v1.Drift * 0.9,
        AlphaDrift = -v1.Drift * 0.9
    })
    return Layers.Result({ v2, v4, v3 })
end
