-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Layers = require(script.Parent.Parent.Layers)
return function(v1) -- line 7 | captures: Layers
    local Host = v1.Host
    local v2 = v1.Color or Layers.HostColor(Host)
    local v3 = Layers.Edge(Host, v1.Width)
    local v4 = Layers.Paint(v3.outline, { Palette = Layers.ShinePalette(v2, 0.6) })
    local v5 = Layers.Turn(v4, v3.outline, 0.75, v1.Drift)
    return Layers.Result({ v4, v3 }, { v5 })
end
