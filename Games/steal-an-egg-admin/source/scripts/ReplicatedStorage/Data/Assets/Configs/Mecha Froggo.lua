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
    _id = "Mecha Froggo",
    DisplayName = "Mecha Froggo",
    Icon = "rbxassetid://111870944172695",
    EarningRate = 155000000,
    IndexSpeedReward = 0,
    DropWeight = 0,
    VisualOdds = 416.6666667,
    ModelWeight = 35,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    DontRoll = true,
    Egg = table.freeze({
        DisplayName = "Mecha Froggo Egg",
        Icon = "rbxassetid://74342815127941",
        ModelName = "Mecha Egg",
        GrowthTime = 10,
        WeightKg = 6,
        HideRarity = true,
        IgnoreSizeGrowthMultiplier = true
    })
}
local v3 = {}
local v4 = Instance.new("Animation")

if not pcall(function() -- line 45 | captures: v4
        v4.AnimationId = "rbxassetid://104066978204020"
    end) then
    warn("Animation rbxassetid://104066978204020 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 54 | captures: Animation
        Animation.AnimationId = "rbxassetid://132376726367267"
    end) then
    warn("Animation rbxassetid://132376726367267 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Secret
v2.BaseModelColor = Color3.fromRGB(150, 160, 175)

local v5 = {}
local v6 = {}

v6[1] = Color3.fromRGB(150, 160, 175)
v6[2] = 1
v5[1] = table.freeze(v6)
v2.PossibleModelColors = table.freeze(v5)
return (table.freeze(v2))
