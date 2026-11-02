-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local FastFlags = require(ReplicatedStorage.UserGenerated.FastFlags)
local t = require(ReplicatedStorage.Packages.t)
local freeze = table.freeze
local v1 = {}

v1.PauseNotificationEnabled = FastFlags.Replicated("Game.GuardTutorial.PauseNotificationEnabled", function(v2) -- line 9 | captures: t
    local v3, v4 = t.boolean(v2)
    assert(v3, v4)
    return v2
end, false)
return freeze(v1)
