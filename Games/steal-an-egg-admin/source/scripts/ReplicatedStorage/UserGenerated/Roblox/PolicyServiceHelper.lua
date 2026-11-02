-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local PolicyService = game:GetService("PolicyService")
local RunService = game:GetService("RunService")
local Cache = require(game.ReplicatedStorage.UserGenerated.Concurrency.Cache)
local Asserts = require(game.ReplicatedStorage.UserGenerated.Lang.Asserts)
local v1 = {
    Discord = 0,
    Facebook = 1,
    Twitch = 2,
    YouTube = 3,
    X = 4,
    GitHub = 5,
    Guilded = 6
}
table.freeze(v1)
local new = Cache.new
local v2 = {}

function v2.Callback(v3) -- line 22 | captures: Players, PolicyService
    local v4 = Players:GetPlayerByUserId(v3)
    assert(v4, "PlayerNotOnline")
    return PolicyService:GetPolicyInfoForPlayerAsync(v4)
end

v2.AssertKey = Asserts.Integer

local v5 = new(v2)
Players.PlayerRemoving:Connect(function(v6) -- line 29 | captures: Players, v5
    local UserId = v6.UserId
    task.delay(60, function() -- line 31 | captures: UserId, Players, v5
        if not Players:GetPlayerByUserId(UserId) then
            v5:Delete(UserId)
        end
    end)
end)

if RunService:IsServer() then
    Players.PlayerAdded:Connect(function(v7) -- line 38 | captures: v5
        v5:GetAsync(v7.UserId)
    end)
end
local v8 = { ExternalLinkReference = v1 }

function v8.ExternalLinkReferencesToInts(v9) -- line 43 | captures: v1
    local v10 = {}
    for v11, v12 in ipairs(v9) do
        local v13 = v1[v12]
        if v13 then
            table.insert(v10, v13)
        end
    end
    return v10
end

function v8.GetPolicyInfoForPlayerAsync(v14, v15) -- line 54 | captures: Asserts, v5
    Asserts.Player(v14)
    Asserts.Optional(Asserts.Boolean)(v15)
    if v15 then
        return v5:Get(v14.UserId)
    end
    return v5:GetAsync(v14.UserId)
end

return table.freeze(v8)
