-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rarity = require(ReplicatedStorage.Data.Rarity)

local function makeAnimation(v1) -- line 9
    local Animation = Instance.new("Animation")
    if not pcall(function() -- line 11 | captures: v1, Animation
            Animation.AnimationId = v1
        end) then
        warn((("Animation %* is not shared with this experience"):format(v1)))
    end
    return Animation
end

local v2 = {
    _id = "Mire Fox",
    DisplayName = "Fox",
    Icon = "rbxassetid://74606412738420",
    EarningRate = 180,
    IndexSpeedReward = 720,
    DropWeight = 0.14285714285714285,
    VisualOdds = 10.773529,
    ModelWeight = 28,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Fox Egg",
        Icon = "rbxassetid://81784802036459",
        GrowthTime = 90,
        WeightKg = 1
    })
}
local v3 = {}
local v4 = Instance.new("Animation")

if not pcall(function() -- line 36 | captures: v4
        v4.AnimationId = "rbxassetid://106327412627634"
    end) then
    warn("Animation rbxassetid://106327412627634 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 45 | captures: Animation
        Animation.AnimationId = "rbxassetid://97675479845041"
    end) then
    warn("Animation rbxassetid://97675479845041 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Epic
v2.BaseModelColor = Color3.new(1, 0.2823529541492462, 0)

local v5 = {}
local v6 = {}

v6[1] = Color3.new(1, 0.2823529541492462, 0)
v6[2] = 760

local v7 = table.freeze(v6)
local v8 = {}

v8[1] = Color3.new(0.48627451062202454, 0.3137255012989044, 0.18431372940540314)
v8[2] = 120

local v9 = table.freeze(v8)
local v10 = {}

v10[1] = Color3.new(0.9215686321258545, 0.8235294222831726, 0.6470588445663452)
v10[2] = 70

local v11 = table.freeze(v10)
local v12 = {}

v12[1] = Color3.new(0.1764705926179886, 0.16470588743686676, 0.14901961386203766)
v12[2] = 35

local v13 = table.freeze(v12)
local v14 = {}

v14[1] = Color3.new(0.9607843160629272, 0.9607843160629272, 0.9215686321258545)
v14[2] = 15
v5[1] = v7
v5[2] = v9
v5[3] = v11
v5[4] = v13
v5[5] = table.freeze(v14)
v2.PossibleModelColors = table.freeze(v5)
v2.WalkSound = table.freeze({
    SoundId = 88010981929242,
    Data = table.freeze({
        Looped = true,
        MaxDistance = 20,
        Speed = 1,
        Volume = 1.5
    })
})
v2.RandomIdleSound = table.freeze({
    SoundId = 81977852395691,
    Data = table.freeze({
        MaxDistance = 20,
        Volume = 1.5
    })
})
return (table.freeze(v2))
