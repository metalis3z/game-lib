-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Log = require(ReplicatedStorage.Packages.Log)
require(ReplicatedStorage.Client.Types.AssetSizeClassification)
local t = require(ReplicatedStorage.Packages.t)
local v1 = {
    {
        least = 45,
        label = "GARGANTUAN",
        hex = "FFD700",
        channels = { 255, 215, 0 }
    },
    {
        least = 25,
        label = "TITANIC",
        hex = "9B51E0",
        channels = { 155, 81, 224 }
    },
    {
        least = 10,
        label = "HUGE",
        hex = "2F80ED",
        channels = { 47, 128, 237 }
    },
    {
        least = 5,
        label = "BIG",
        hex = "34C759",
        channels = { 52, 199, 89 }
    }
}
local v2 = t.strict(t.number)
local v3 = {}
local v4 = Log.new()
local v5 = table.create(#v1)
for v6, v7 in v1 do
    local channels = v7.channels
    v5[v6] = {
        MinimumScale = v7.least,
        Prefix = v7.label,
        Color = Color3.fromRGB(channels[1], channels[2], channels[3]),
        RichText = ("<font color=\"#%s\">%s</font>"):format(v7.hex, v7.label)
    }
end
local v8 = table.freeze(v5)

function v3.Classify(v9) -- line 51 | captures: v2, v8
    v2(v9)
    local v10 = 1
    while v10 <= #v8 do
        if v8[v10].MinimumScale <= v9 then
            break
        end
        v10 += 1
    end
    return v8[v10]
end

function v3.Ladder() -- line 62 | captures: v4, v8
    v4:AtTrace():Log("Handed out the size ladder")
    return v8
end

return v3
