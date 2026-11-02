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
    _id = "Orca",
    DisplayName = "Orca",
    Icon = "rbxassetid://90382263788089",
    EarningRate = 80000,
    IndexSpeedReward = 99000,
    DropWeight = 0,
    VisualOdds = 19000000000,
    ModelWeight = 1800,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Orca Egg",
        Icon = "rbxassetid://99932807273458",
        GrowthTime = 360,
        WeightKg = 6
    })
}
local v3 = {}
local v4 = Instance.new("Animation")

if not pcall(function() -- line 36 | captures: v4
        v4.AnimationId = "rbxassetid://83292564100878"
    end) then
    warn("Animation rbxassetid://83292564100878 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 45 | captures: Animation
        Animation.AnimationId = "rbxassetid://139557322067011"
    end) then
    warn("Animation rbxassetid://139557322067011 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Mythic
v2.BaseModelColor = Color3.new(0.06666667014360428, 0.06666667014360428, 0.06666667014360428)
v2.PossibleModelColors = table.freeze({})
v2.RandomIdleSound = table.freeze({
    SoundId = 72073369821369,
    Data = table.freeze({
        MaxDistance = 20,
        Volume = 1.5
    })
})
return (table.freeze(v2))
