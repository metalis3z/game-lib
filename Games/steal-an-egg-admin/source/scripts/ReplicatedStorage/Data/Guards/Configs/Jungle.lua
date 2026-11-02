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
    AnimationBaseWalkSpeed = 14,
    FlatRadius = 20,
    HitDistance = 3,
    HomeImpulseBoostDistanceXZ = 160,
    WalkSpeed = 82,
    _id = "Jungle",
    AfterWakeSound = {
        {
            Looped = false,
            MaxDistance = 250.48046875,
            PlaybackSpeed = 1,
            SoundId = "rbxassetid://135222880779884",
            Volume = 5
        },
        {
            Looped = false,
            MaxDistance = 250.48046875,
            PlaybackSpeed = 1,
            SoundId = "rbxassetid://135222880779884",
            Volume = 5
        }
    },
    AttackAnimation = AnimationAssets.Get("rbxassetid://92056552605052"),
    AttackSound = {
        Looped = false,
        MaxDistance = 150,
        PlaybackSpeed = 1.0700000524520874,
        SoundId = "rbxassetid://72888043826727",
        Volume = 2
    },
    FootstepSound = {
        Looped = true,
        MaxDistance = 60,
        PlaybackSpeed = 1,
        SoundId = "rbxassetid://81056698279247",
        Volume = 1.5
    },
    IdleAnimation = AnimationAssets.Get("rbxassetid://94303658291471", v1),
    Rarity = require(game:GetService("ReplicatedStorage").Data.Rarity).Rarities.Epic,
    SleepAnimation = AnimationAssets.Get("rbxassetid://100861389361947", v1),
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
    WalkAnimation = AnimationAssets.Get("rbxassetid://95119608968567", v1)
})
