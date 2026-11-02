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
    _id = "Mangolini Parrochini",
    DisplayName = "Mangolini Parrochini",
    Icon = "rbxassetid://109852386744531",
    EarningRate = 800000,
    IndexSpeedReward = 267000,
    DropWeight = 0.1,
    VisualOdds = 10,
    ModelWeight = 1500,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0.05,
    Egg = table.freeze({
        DisplayName = "Mangolini Parrochini Egg",
        Icon = "rbxassetid://139937203160382",
        GrowthTime = 600,
        WeightKg = 6,
        HideRarity = true
    })
}
local v3 = {}
local v4 = Instance.new("Animation")

if not pcall(function() -- line 42 | captures: v4
        v4.AnimationId = "rbxassetid://106995294541547"
    end) then
    warn("Animation rbxassetid://106995294541547 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 51 | captures: Animation
        Animation.AnimationId = "rbxassetid://82619528805298"
    end) then
    warn("Animation rbxassetid://82619528805298 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Cosmic
v2.BaseModelColor = Color3.new(0.6039215922355652, 0.13333334028720856, 0.0941176488995552)

local v5 = {}
local v6 = {}

v6[1] = Color3.new(0.6039215922355652, 0.13333334028720856, 0.0941176488995552)
v6[2] = 990

local v7 = table.freeze(v6)
local v8 = {}

v8[1] = Color3.new(1, 1, 1)
v8[2] = 10
v5[1] = v7
v5[2] = table.freeze(v8)
v2.PossibleModelColors = table.freeze(v5)
v2.WalkSound = table.freeze({
    SoundId = 137591807647405,
    Data = table.freeze({
        Looped = true,
        MaxDistance = 20,
        Speed = 1,
        Volume = 1.5
    })
})
return (table.freeze(v2))
