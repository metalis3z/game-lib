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
    _id = "Swan",
    DisplayName = "Swan",
    Icon = "rbxassetid://125076114591417",
    EarningRate = 320,
    IndexSpeedReward = 3500,
    DropWeight = 0.2,
    VisualOdds = 670.5118643718583,
    ModelWeight = 22,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Swan Egg",
        Icon = "rbxassetid://84237066771646",
        GrowthTime = 120,
        WeightKg = 2
    })
}
local v3 = {}
local v4 = Instance.new("Animation")

if not pcall(function() -- line 36 | captures: v4
        v4.AnimationId = "rbxassetid://88133232910091"
    end) then
    warn("Animation rbxassetid://88133232910091 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 45 | captures: Animation
        Animation.AnimationId = "rbxassetid://129981096365422"
    end) then
    warn("Animation rbxassetid://129981096365422 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Epic
v2.BaseModelColor = Color3.new(0.7921568751335144, 0.7960784435272217, 0.8196078538894653)

local v5 = {}
local v6 = {}

v6[1] = Color3.new(0.7921568751335144, 0.7960784435272217, 0.8196078538894653)
v6[2] = 200

local v7 = table.freeze(v6)
local v8 = {}

v8[1] = Color3.new(0.9607843160629272, 0.9607843160629272, 0.9333333373069763)
v8[2] = 710

local v9 = table.freeze(v8)
local v10 = {}

v10[1] = Color3.new(0.21568627655506134, 0.21568627655506134, 0.21568627655506134)
v10[2] = 70

local v11 = table.freeze(v10)
local v12 = {}

v12[1] = Color3.new(0.7450980544090271, 0.686274528503418, 0.6078431606292725)
v12[2] = 20
v5[1] = v7
v5[2] = v9
v5[3] = v11
v5[4] = table.freeze(v12)
v2.PossibleModelColors = table.freeze(v5)
v2.WalkSound = table.freeze({
    SoundId = 134348956668414,
    Data = table.freeze({
        Looped = true,
        MaxDistance = 20,
        Speed = 1,
        Volume = 1.5
    })
})
v2.RandomIdleSound = table.freeze({
    SoundId = 75638277784583,
    Data = table.freeze({
        MaxDistance = 20,
        Volume = 1.5
    })
})
return (table.freeze(v2))
