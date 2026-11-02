-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Layers = require(script.Parent.Parent.Layers)
return function(v1) -- line 7 | captures: Layers
    local Host = v1.Host
    local v2 = v1.Color or Layers.HostColor(Host)
    local v3 = Layers.Paint(Host, {
        Rotation = 60,
        Palette = Layers.ShinePalette(v2, 0.417505),
        Drift = v1.Drift * 0.6
    })
    return Layers.Result({ v3 })
end
