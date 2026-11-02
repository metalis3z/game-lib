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
    AnimationBaseWalkSpeed = 35,
    EggPickupDistance = 18,
    FlatRadius = 20,
    HitDistance = 5,
    HomeImpulseBoostDistanceXZ = 220,
    WalkSpeed = 113,
    _id = "Volcano",
    AfterWakeSound = {
        {
            Looped = false,
            MaxDistance = 250.48046875,
            PlaybackSpeed = 1,
            SoundId = "rbxassetid://132723699319391",
            Volume = 5
        },
        {
            Looped = false,
            MaxDistance = 250.48046875,
            PlaybackSpeed = 1,
            SoundId = "rbxassetid://132723699319391",
            Volume = 5
        }
    },
    AttackAnimation = AnimationAssets.Get("rbxassetid://82244556268321"),
    AttackSound = {
        Looped = false,
        MaxDistance = 150,
        PlaybackSpeed = 1.0700000524520874,
        SoundId = "rbxassetid://102430672086990",
        Volume = 2
    },
    FootstepSound = {
        Looped = true,
        MaxDistance = 60,
        PlaybackSpeed = 1,
        SoundId = "rbxassetid://115218701863479",
        Volume = 1.5
    },
    IdleAnimation = AnimationAssets.Get("rbxassetid://110993901572788", v1),
    Rarity = require(game:GetService("ReplicatedStorage").Data.Rarity).Rarities.Mythic,
    SleepAnimation = AnimationAssets.Get("rbxassetid://72478313199906", v1),
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
    WalkAnimation = AnimationAssets.Get("rbxassetid://113707767038491", v1)
})
