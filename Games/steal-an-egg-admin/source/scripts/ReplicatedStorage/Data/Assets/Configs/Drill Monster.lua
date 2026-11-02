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
    _id = "Drill Monster",
    DisplayName = "Drilla",
    Icon = "rbxassetid://104277075118392",
    EarningRate = 100000000,
    IndexSpeedReward = 150000,
    DropWeight = 0,
    VisualOdds = 22000000000,
    ModelWeight = 5000,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Drilla Egg",
        Icon = "rbxassetid://84559714209690",
        GrowthTime = 720,
        WeightKg = 6
    })
}
local v3 = {}
local v4 = Instance.new("Animation")

if not pcall(function() -- line 36 | captures: v4
        v4.AnimationId = "rbxassetid://71162358243814"
    end) then
    warn("Animation rbxassetid://71162358243814 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 45 | captures: Animation
        Animation.AnimationId = "rbxassetid://105277827896306"
    end) then
    warn("Animation rbxassetid://105277827896306 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Cosmic
v2.BaseModelColor = Color3.new(0.627451, 0.627451, 0.627451)
v2.PossibleModelColors = table.freeze({})
return (table.freeze(v2))
