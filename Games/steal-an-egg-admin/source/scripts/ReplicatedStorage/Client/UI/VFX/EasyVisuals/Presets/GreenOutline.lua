-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Layers = require(script.Parent.Parent.Layers)
return function(v1) -- line 7 | captures: Layers
    local v2 = Layers.Edge(v1.Host, v1.Width)
    local v3 = Layers.Paint(v2.outline, {
        Palette = "Green",
        Alpha = Layers.AlphaStops("Green")
    })
    local v4 = Layers.Turn(v3, v2.outline, 5, v1.Drift)
    return Layers.Result({ v3, v2 }, { v4 })
end
