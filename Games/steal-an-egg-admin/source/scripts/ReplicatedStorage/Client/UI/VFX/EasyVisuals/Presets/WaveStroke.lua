-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Layers = require(script.Parent.Parent.Layers)
local v1 = {}
local v2 = { 0.25, 1 }
local v3 = { 0.5, 1 }

v1[1] = { 0, 0 }
v1[2] = v2
v1[3] = v3
v1[4] = { 0.75, 1 }
v1[5] = { 1, 0 }

local v4 = table.create(#v1)
for v5, v6 in v1 do
    v4[v5] = NumberSequenceKeypoint.new(v6[1], v6[2])
end
local v7 = NumberSequence.new(v4)
return function(v8) -- line 26 | captures: Layers, v7
    local v9 = Layers.Edge(v8.Host, v8.Width)
    local v10 = Layers.Paint(v9.outline, {
        Palette = Layers.FlatPalette(v8.Color),
        Alpha = v7,
        Drift = v8.Drift,
        AlphaDrift = v8.Drift * 0.9
    })
    return Layers.Result({ v10, v9 })
end
