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
    AnimationBaseWalkSpeed = 30,
    EggPickupDistance = 18,
    FlatRadius = 20,
    HitDistance = 7,
    HomeImpulseBoostDistanceXZ = 275,
    WalkSpeed = 152,
    _id = "Prehistoric",
    AfterWakeSound = {
        Looped = false,
        MaxDistance = 250.48046875,
        PlaybackSpeed = 1,
        SoundId = "rbxassetid://137539252236882",
        Volume = 5
    },
    AttackAnimation = AnimationAssets.Get("rbxassetid://99838041549346"),
    AttackSound = {
        Looped = false,
        MaxDistance = 300,
        PlaybackSpeed = 1,
        SoundId = "rbxassetid://97645621664273",
        Volume = 4
    },
    FootstepSound = {
        Looped = true,
        MaxDistance = 60,
        PlaybackSpeed = 1,
        SoundId = "rbxassetid://112820906341272",
        Volume = 1.5
    },
    IdleAnimation = AnimationAssets.Get("rbxassetid://74005467993073", v1),
    Rarity = require(game:GetService("ReplicatedStorage").Data.Rarity).Rarities.Secret,
    SleepAnimation = AnimationAssets.Get("rbxassetid://131457230955819", v1),
    SleepSound = {
        Looped = false,
        MaxDistance = 107.4382553100586,
        PlaybackSpeed = 1,
        SoundId = "rbxassetid://85712182278317",
        Volume = 0
    },
    WakeSound = {
        Looped = false,
        MaxDistance = 250.48046875,
        PlaybackSpeed = 1.0700000524520874,
        SoundId = "rbxassetid://117777670599081",
        Volume = 0.30000001192092896
    },
    WalkAnimation = AnimationAssets.Get("rbxassetid://110851700429305", v1)
})
