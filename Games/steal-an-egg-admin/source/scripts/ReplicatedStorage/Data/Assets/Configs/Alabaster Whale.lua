-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rarity = require(ReplicatedStorage.Data.Rarity)

local function makeAnimation(v1) -- line 6
    local Animation = Instance.new("Animation")
    if not pcall(function() -- line 8 | captures: v1, Animation
            Animation.AnimationId = v1
        end) then
        warn((("Animation %* is not shared with this experience"):format(v1)))
    end
    return Animation
end

local v2 = {
    _id = "Alabaster Whale",
    DisplayName = "Beluga Whale",
    Icon = "rbxassetid://76173930911542",
    EarningRate = 850000,
    IndexSpeedReward = 126000,
    DropWeight = 0,
    VisualOdds = 22000000000,
    ModelWeight = 5000,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Beluga Whale Egg",
        Icon = "rbxassetid://94470939106990",
        GrowthTime = 720,
        WeightKg = 6
    })
}
local v3 = {}
local v4 = Instance.new("Animation")

if not pcall(function() -- line 33 | captures: v4
        v4.AnimationId = "rbxassetid://125489567620095"
    end) then
    warn("Animation rbxassetid://125489567620095 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 42 | captures: Animation
        Animation.AnimationId = "rbxassetid://133481491746233"
    end) then
    warn("Animation rbxassetid://133481491746233 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Cosmic
v2.BaseModelColor = Color3.new(0.33725491166114807, 0.6274510025978088, 0.239215686917305)
v2.PossibleModelColors = table.freeze({})
v2.RandomIdleSound = table.freeze({
    SoundId = 86723402620809,
    Data = table.freeze({
        MaxDistance = 20,
        Volume = 1.5
    })
})
return (table.freeze(v2))
