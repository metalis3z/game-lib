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
    AnimationBaseWalkSpeed = 17,
    EggPickupDistance = 18,
    FlatRadius = 20,
    HitDistance = 5,
    HomeImpulseBoostDistanceXZ = 250,
    WalkSpeed = 130,
    _id = "Abyss Ocean",
    AfterWakeSound = {
        {
            Looped = false,
            MaxDistance = 250.48046875,
            PlaybackSpeed = 1,
            SoundId = "rbxassetid://134578891090053",
            Volume = 5
        },
        {
            Looped = false,
            MaxDistance = 250.48046875,
            PlaybackSpeed = 1,
            SoundId = "rbxassetid://134578891090053",
            Volume = 5
        }
    },
    AttackAnimation = AnimationAssets.Get("rbxassetid://130334621418380"),
    AttackSound = {
        Looped = false,
        MaxDistance = 150,
        PlaybackSpeed = 1.0700000524520874,
        SoundId = "rbxassetid://80946945131325",
        Volume = 2
    },
    FootstepSound = {
        Looped = false,
        MaxDistance = 74.38033294677734,
        PlaybackSpeed = 1.0700000524520874,
        SoundId = "rbxassetid://100877942414372",
        Volume = 1.5
    },
    IdleAnimation = AnimationAssets.Get("rbxassetid://121857252251626", v1),
    Rarity = require(game:GetService("ReplicatedStorage").Data.Rarity).Rarities.Cosmic,
    SleepAnimation = AnimationAssets.Get("rbxassetid://116797897640235", v1),
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
    WalkAnimation = AnimationAssets.Get("rbxassetid://96363560262445", v1)
})
