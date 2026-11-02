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
    _id = "Krakenoid",
    DisplayName = "Krakenoid",
    Icon = "rbxassetid://73748109765067",
    EarningRate = 500000000,
    IndexSpeedReward = 0,
    DropWeight = 0,
    VisualOdds = 15.38461538,
    ModelWeight = 35,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    DontRoll = true,
    Egg = table.freeze({
        DisplayName = "Krakenoid Egg",
        Icon = "rbxassetid://132230992115265",
        ModelName = "Monster Egg",
        GrowthTime = 10,
        WeightKg = 6,
        HideRarity = true,
        IgnoreSizeGrowthMultiplier = true
    })
}
local v3 = {}
local v4 = Instance.new("Animation")

if not pcall(function() -- line 45 | captures: v4
        v4.AnimationId = "rbxassetid://105432664203125"
    end) then
    warn("Animation rbxassetid://105432664203125 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 54 | captures: Animation
        Animation.AnimationId = "rbxassetid://114407634480186"
    end) then
    warn("Animation rbxassetid://114407634480186 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Eternal
v2.BaseModelColor = Color3.fromRGB(230, 140, 40)

local v5 = {}
local v6 = {}

v6[1] = Color3.fromRGB(230, 140, 40)
v6[2] = 1
v5[1] = table.freeze(v6)
v2.PossibleModelColors = table.freeze(v5)
return (table.freeze(v2))
