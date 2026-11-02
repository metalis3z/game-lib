-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Log = require(ReplicatedStorage.Packages.Log)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Tutorial = ReplicatedStorage.Assets.UI.Tutorial
local v1 = Log.new()
local v2 = {}

function v2.Clone(v3, v4) -- line 12 | captures: Trove, Tutorial
    local v5 = Trove.new()
    local v6 = Tutorial[v3]:Clone()
    v6.Name = v4
    v5:Add(v6)
    return v6, v5
end

function v2.Teardown(v7, v8) -- line 19 | captures: v1
    return function() -- line 20 | captures: v7, v8, v1
        v1:AtTrace():Log(v7)
        v8:Destroy()
    end
end

return v2
