-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Layers = require(script.Parent.Parent.Layers)
return function(v1) -- line 7 | captures: Layers
    local Host = v1.Host
    local v2 = Layers.Paint(Host, {
        Palette = "Chrome",
        Rotation = -90,
        Drift = v1.Drift
    })
    local v3, v4
    if Layers.AcceptsEdge(Host) then
        v4 = Layers.Edge(Host, v1.Width)
        v3 = Layers.Paint(v4.outline, {
            Palette = "Chrome",
            Rotation = -89,
            Drift = v1.Drift * 0.58
        })
    end
    return Layers.Result({ v2, v3, v4 })
end
