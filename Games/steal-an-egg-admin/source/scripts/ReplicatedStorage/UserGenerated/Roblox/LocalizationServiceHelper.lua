-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local LocalizationService = game:GetService("LocalizationService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Cache = require(ReplicatedStorage.UserGenerated.Concurrency.Cache)
local Asserts = require(ReplicatedStorage.UserGenerated.Lang.Asserts)
local new = Cache.new
local v1 = {}

function v1.Callback(v2) -- line 13 | captures: Players, LocalizationService
    local v3 = Players:GetPlayerByUserId(v2)
    assert(v3, "PlayerNotOnline")
    return LocalizationService:GetCountryRegionForPlayerAsync(v3)
end

v1.AssertKey = Asserts.Integer

local v4 = new(v1)
Players.PlayerRemoving:Connect(function(v5) -- line 20 | captures: Players, v4
    local UserId = v5.UserId
    task.delay(60, function() -- line 22 | captures: UserId, Players, v4
        if not Players:GetPlayerByUserId(UserId) then
            v4:Delete(UserId)
        end
    end)
end)

if RunService:IsServer() then
    Players.PlayerAdded:Connect(function(v6) -- line 33 | captures: v4
        v4:GetAsync(v6.UserId)
    end)
else
    task.spawn(function() -- line 29 | captures: Players, v4
        v4:GetAsync(Players.LocalPlayer.UserId)
    end)
end
local freeze = table.freeze
local v7 = {}

function v7.GetCountryRegionForPlayerAsync(v8, v9) -- line 38 | captures: Asserts, v4
    Asserts.Player(v8)
    Asserts.Optional(Asserts.Boolean)(v9)
    if v9 then
        return v4:Get(v8.UserId)
    end
    return v4:GetAsync(v8.UserId)
end

return freeze(v7)
