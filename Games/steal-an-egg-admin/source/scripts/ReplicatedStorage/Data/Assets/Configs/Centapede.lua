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
    _id = "Centapede",
    DisplayName = "Centapede",
    Icon = "rbxassetid://107200505521053",
    EarningRate = 1500,
    IndexSpeedReward = 960000,
    DropWeight = 0,
    VisualOdds = 135000000000,
    ModelWeight = 6,
    WalkAnimationReferenceSpeed = 2,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Centapede Egg",
        Icon = "rbxassetid://131685653579153",
        GrowthTime = 120,
        WeightKg = 7
    })
}
local v3 = {}
local v4 = Instance.new("Animation")

if not pcall(function() -- line 37 | captures: v4
        v4.AnimationId = "rbxassetid://132892154887722"
    end) then
    warn("Animation rbxassetid://132892154887722 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 46 | captures: Animation
        Animation.AnimationId = "rbxassetid://102018575618449"
    end) then
    warn("Animation rbxassetid://102018575618449 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Epic
v2.BaseModelColor = Color3.new(0.9058823585510254, 0.9058823585510254, 0.9254902005195618)

local v5 = {}
local v6 = {}

v6[1] = Color3.new(0.9058823585510254, 0.9058823585510254, 0.9254902005195618)
v6[2] = 900

local v7 = table.freeze(v6)
local v8 = {}

v8[1] = Color3.new(0.20000000298023224, 1, 0.1882352977991104)
v8[2] = 100

local v9 = table.freeze(v8)
local v10 = {}

v10[1] = Color3.new(1, 1, 1)
v10[2] = 10
v5[1] = v7
v5[2] = v9
v5[3] = table.freeze(v10)
v2.PossibleModelColors = table.freeze(v5)
v2.WalkSound = table.freeze({
    SoundId = 136424818632273,
    Data = table.freeze({
        Looped = true,
        MaxDistance = 20,
        Speed = 1,
        Volume = 1.5
    })
})
return (table.freeze(v2))
