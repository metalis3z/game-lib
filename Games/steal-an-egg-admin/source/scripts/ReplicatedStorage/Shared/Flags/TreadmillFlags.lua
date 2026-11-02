-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.UserGenerated.Lang.Asserts)
local FastFlags = require(ReplicatedStorage.UserGenerated.FastFlags)
local v1 = FastFlags.Replicated("Game.Treadmill.CommentsDisabled", Asserts.Boolean, true)
local v2 = FastFlags.Replicated("Game.Treadmill.VideoPlayerDisabled", Asserts.Boolean, true)
local v3 = FastFlags.Replicated("Game.Treadmill.CameraAutoFrameDisabled", Asserts.Boolean, true)
local v4 = FastFlags.Replicated("Game.Treadmill.PolicyServiceVideoEnabled", Asserts.Boolean, true)
local v5 = FastFlags.Replicated("Game.Treadmill.PhoneEnabled", Asserts.Boolean, false)
return table.freeze({
    CommentsDisabled = v1,
    VideoPlayerDisabled = v2,
    CameraAutoFrameDisabled = v3,
    PolicyServiceVideoEnabled = v4,
    PhoneEnabled = v5
})
