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
    _id = "Parrotfish",
    DisplayName = "Parrotfish",
    Icon = "rbxassetid://135424380374502",
    EarningRate = 220,
    IndexSpeedReward = 72000,
    DropWeight = 0.55,
    VisualOdds = 2773109151.841,
    ModelWeight = 5,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Parrotfish Egg",
        Icon = "rbxassetid://140493305582787",
        GrowthTime = 75,
        WeightKg = 6
    })
}
local v3 = {}
local v4 = Instance.new("Animation")

if not pcall(function() -- line 36 | captures: v4
        v4.AnimationId = "rbxassetid://93201379633855"
    end) then
    warn("Animation rbxassetid://93201379633855 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 45 | captures: Animation
        Animation.AnimationId = "rbxassetid://109791213131130"
    end) then
    warn("Animation rbxassetid://109791213131130 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Rare
v2.BaseModelColor = Color3.new(0.8117647171020508, 0.4313725531101227, 0.5960784554481506)
v2.PossibleModelColors = table.freeze({})
v2.RandomIdleSound = table.freeze({
    SoundId = 136740057915515,
    Data = table.freeze({
        MaxDistance = 20,
        Volume = 1.5
    })
})
return (table.freeze(v2))
