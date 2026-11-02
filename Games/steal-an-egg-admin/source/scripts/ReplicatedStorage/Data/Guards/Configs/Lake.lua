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
    HitDistance = 3,
    HomeImpulseBoostDistanceXZ = 100,
    WalkSpeed = 35,
    _id = "Lake",
    AttackAnimation = AnimationAssets.Get("rbxassetid://92680690642331"),
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
        SoundId = "rbxassetid://131376217168921",
        Volume = 1.5
    },
    IdleAnimation = AnimationAssets.Get("rbxassetid://134494686039045", v1),
    Rarity = require(game:GetService("ReplicatedStorage").Data.Rarity).Rarities.Uncommon,
    SleepAnimation = AnimationAssets.Get("rbxassetid://81368165765744", v1),
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
    WalkAnimation = AnimationAssets.Get("rbxassetid://74511176290799", v1)
})
