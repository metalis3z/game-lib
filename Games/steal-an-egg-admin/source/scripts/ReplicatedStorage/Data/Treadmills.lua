-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Data.Rarity)
local Configs = script.Configs
local v1 = {
    OPTREADMILL = require(Configs.OPTREADMILL),
    AngelicTreadmill = require(Configs.AngelicTreadmill),
    CelebrityTreadmill = require(Configs.CelebrityTreadmill),
    DemonicTreadmill = require(Configs.DemonicTreadmill),
    FlameTreadmill = require(Configs.FlameTreadmill),
    GoldenTreadmill = require(Configs.GoldenTreadmill),
    HackerTreadmill = require(Configs.HackerTreadmill)
}

v1["Lucky BlockTreadmill"] = require(Configs["Lucky BlockTreadmill"])
v1["Sci-FiTreadmill"] = require(Configs["Sci-FiTreadmill"])
v1["The FreezeTreadmill"] = require(Configs["The FreezeTreadmill"])
v1.Treadmill = require(Configs.Treadmill)
table.freeze(v1)
local v2 = {}
local v3 = {}
for v4, v5 in pairs(v1) do
    if not v5.Standalone then
        table.insert(v2, v5)
    end
end
table.sort(v2, function(v6, v7) -- line 30
    return v6.Price < v7.Price
end)
for v8, v9 in ipairs(v2) do
    v3[v9._id] = v8
end
table.freeze(v2)
table.freeze(v3)
local freeze = table.freeze
local v10 = { Directory = v1 }

function v10.TreadmillNameExists(v11) -- line 41 | captures: v1
    if v1[v11] == nil then
        return false, (("Treadmills name \"%*\" does not exist in the Treadmills directory."):format(v11))
    end
    return true
end

function v10.GetOrdered() -- line 47 | captures: v2
    return table.clone(v2)
end

function v10.GetByUpgradeLevel(v12) -- line 50 | captures: v2
    return v2[v12]
end

function v10.GetUpgradeLevel(v13) -- line 53 | captures: v3
    return v3[v13]
end

return freeze(v10)
