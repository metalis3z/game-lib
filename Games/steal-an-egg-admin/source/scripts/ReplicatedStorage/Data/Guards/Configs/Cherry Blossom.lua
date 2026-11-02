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
    AnimationBaseWalkSpeed = 28,
    FlatRadius = 20,
    HitDistance = 7,
    HomeImpulseBoostDistanceXZ = 300,
    WalkSpeed = 222,
    _id = "Cherry Blossom",
    AfterWakeSound = {
        Looped = false,
        MaxDistance = 250.48046875,
        PlaybackSpeed = 1,
        SoundId = "rbxassetid://82222283296425",
        Volume = 5
    },
    AttackAnimation = AnimationAssets.Get("rbxassetid://137994459472824"),
    AttackSound = {
        Looped = false,
        MaxDistance = 150,
        PlaybackSpeed = 1.0700000524520874,
        SoundId = "rbxassetid://85403192831247",
        Volume = 2
    },
    FootstepSound = {
        Looped = true,
        MaxDistance = 60,
        PlaybackSpeed = 1,
        SoundId = "rbxassetid://109714058718761",
        Volume = 1.5
    },
    IdleAnimation = AnimationAssets.Get("rbxassetid://131845142324148", v1),
    Rarity = require(game:GetService("ReplicatedStorage").Data.Rarity).Rarities.Divine,
    SleepAnimation = AnimationAssets.Get("rbxassetid://88466596648495", v1),
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
    WalkAnimation = AnimationAssets.Get("rbxassetid://89515470947519", v1)
})
