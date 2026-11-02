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
    _id = "Dragon",
    DisplayName = "Lava Dragon",
    Icon = "rbxassetid://123880531664365",
    EarningRate = 100000000,
    IndexSpeedReward = 60000,
    DropWeight = 0.1,
    VisualOdds = 1723764648.784,
    ModelWeight = 14000,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Lava Dragon Egg",
        Icon = "rbxassetid://137621122825975",
        GrowthTime = 18000,
        WeightKg = 5
    })
}
local v3 = {}
local v4 = Instance.new("Animation")

if not pcall(function() -- line 36 | captures: v4
        v4.AnimationId = "rbxassetid://140353821141394"
    end) then
    warn("Animation rbxassetid://140353821141394 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 45 | captures: Animation
        Animation.AnimationId = "rbxassetid://116523163429378"
    end) then
    warn("Animation rbxassetid://116523163429378 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Eternal
v2.BaseModelColor = Color3.new(0.18431372940540314, 0.13333334028720856, 0.13333334028720856)

local v5 = {}
local v6 = {}

v6[1] = Color3.new(0.18431372940540314, 0.13333334028720856, 0.13333334028720856)
v6[2] = 950

local v7 = table.freeze(v6)
local v8 = {}

v8[1] = Color3.new(0.7450980544090271, 0.13725490868091583, 0.09803921729326248)
v8[2] = 50

local v9 = table.freeze(v8)
local v10 = {}

v10[1] = Color3.new(1, 1, 1)
v10[2] = 12
v5[1] = v7
v5[2] = v9
v5[3] = table.freeze(v10)
v2.PossibleModelColors = table.freeze(v5)
v2.WalkSound = table.freeze({
    SoundId = 115587362723775,
    Data = table.freeze({
        Looped = true,
        MaxDistance = 20,
        Speed = 1,
        Volume = 1.5
    })
})
v2.RandomIdleSound = table.freeze({
    SoundId = 108525367976686,
    Data = table.freeze({
        MaxDistance = 20,
        Volume = 1.5
    })
})
return (table.freeze(v2))
