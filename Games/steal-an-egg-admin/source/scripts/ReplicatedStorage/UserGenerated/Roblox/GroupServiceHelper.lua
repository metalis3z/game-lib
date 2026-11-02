-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local GroupService = game:GetService("GroupService")
local RunService = game:GetService("RunService")
local Cache = require(game.ReplicatedStorage.UserGenerated.Concurrency.Cache)
local Asserts = require(game.ReplicatedStorage.UserGenerated.Lang.Asserts)
local new = Cache.new
local v1 = { MaxAge = (1/0) }

function v1.Callback(v2) -- line 13 | captures: GroupService
    return GroupService:GetGroupsAsync(v2)
end

v1.AssertKey = Asserts.Integer

local v3 = new(v1)
Players.PlayerRemoving:Connect(function(v4) -- line 18 | captures: Players, v3
    local UserId = v4.UserId
    task.delay(60, function() -- line 20 | captures: UserId, Players, v3
        if not Players:GetPlayerByUserId(UserId) then
            v3:Delete(UserId)
        end
    end)
end)

if RunService:IsServer() then
    Players.PlayerAdded:Connect(function(v5) -- line 31 | captures: v3
        v3:GetAsync(v5.UserId)
    end)
else
    task.spawn(function() -- line 27 | captures: Players, v3
        v3:GetAsync(Players.LocalPlayer.UserId)
    end)
end
local freeze = table.freeze
local v6 = { Cache = v3 }

function v6.GetGroupsAsync(v7, v8) -- line 37 | captures: Asserts, v3
    Asserts.Integer(v7)
    Asserts.Optional(Asserts.Boolean)(v8)
    if v8 then
        return v3:Get(v7)
    end
    return v3:GetAsync(v7)
end

return freeze(v6)
