-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AnimationAssets = require(ReplicatedStorage.Shared.Utils.AnimationAssets)
require(script.Parent.Parent.Types)
local v1 = table.freeze({
    DropWeight = 1,
    Looped = true,
    Play = { 0.15 },
    Stop = { 0.5 }
})
return table.freeze({
    FlatRadius = 20,
    HitDistance = 4,
    HomeImpulseBoostDistanceXZ = 130,
    WalkSpeed = 62,
    _id = "Desert",
    AttackAnimation = AnimationAssets.Get("rbxassetid://119198140301396"),
    AttackSound = {
        Looped = false,
        MaxDistance = 150,
        PlaybackSpeed = 1.0700000524520874,
        SoundId = "rbxassetid://110085353753447",
        Volume = 2
    },
    FootstepSound = {
        Looped = true,
        MaxDistance = 60,
        PlaybackSpeed = 1,
        SoundId = "rbxassetid://107380502781564",
        Volume = 1.5
    },
    IdleAnimation = AnimationAssets.Get("rbxassetid://136184383783263", v1),
    Rarity = require(game:GetService("ReplicatedStorage").Data.Rarity).Rarities.Rare,
    SleepAnimation = AnimationAssets.Get("rbxassetid://125383074097286", v1),
    SleepSound = {
        Looped = false,
        MaxDistance = 40,
        PlaybackSpeed = 1,
        SoundId = "rbxassetid://85712182278317",
        Volume = 0.800000011920929
    },
    WakeSound = {
        Looped = false,
        MaxDistance = 250.48046875,
        PlaybackSpeed = 1.0700000524520874,
        SoundId = "rbxassetid://117777670599081",
        Volume = 0.30000001192092896
    },
    WalkAnimation = AnimationAssets.Get("rbxassetid://97304647285980", v1)
})
