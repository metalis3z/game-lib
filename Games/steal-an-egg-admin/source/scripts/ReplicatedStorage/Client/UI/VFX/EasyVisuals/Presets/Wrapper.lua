-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Layers = require(script.Parent.Parent.Layers)
return function(v1) -- line 7 | captures: Layers
    local v2 = Layers.Paint(v1.Host, {
        Palette = v1.Color,
        Drift = v1.Drift
    })
    Layers.Replay(v2, v1.Chain)
    return Layers.Result({ v2 })
end
