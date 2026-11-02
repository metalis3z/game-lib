-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local VoiceChatService = game:GetService("VoiceChatService")
local Cache = require(game.ReplicatedStorage.UserGenerated.Concurrency.Cache)
local Asserts = require(game.ReplicatedStorage.UserGenerated.Lang.Asserts)
local new = Cache.new
local v1 = { MaxAge = (1/0) }

function v1.Callback(v2) -- line 12 | captures: VoiceChatService
    return VoiceChatService:IsVoiceEnabledForUserIdAsync(v2)
end

v1.AssertKey = Asserts.Integer

local v3 = new(v1)
Players.PlayerRemoving:Connect(function(v4) -- line 17 | captures: Players, v3
    local UserId = v4.UserId
    task.delay(60, function() -- line 19 | captures: UserId, Players, v3
        if not Players:GetPlayerByUserId(UserId) then
            v3:Delete(UserId)
        end
    end)
end)
task.spawn(function() -- line 25 | captures: Players, v3
    v3:GetAsync(Players.LocalPlayer.UserId)
end)
local freeze = table.freeze
local v5 = {}

function v5.IsVoiceEnabledForUserIdAsync(v6, v7) -- line 29 | captures: Asserts, v3
    Asserts.Integer(v6)
    Asserts.Optional(Asserts.Boolean)(v7)
    if v7 then
        return v3:Get(v6)
    end
    return v3:GetAsync(v6)
end

return freeze(v5)
