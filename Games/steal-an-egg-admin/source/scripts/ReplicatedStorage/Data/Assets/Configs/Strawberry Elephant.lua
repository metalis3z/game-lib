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
    _id = "Strawberry Elephant",
    DisplayName = "Strawberry Elephant",
    Icon = "rbxassetid://138871903615614",
    EarningRate = 110000000,
    IndexSpeedReward = 143000,
    DropWeight = 0.01,
    VisualOdds = 100,
    ModelWeight = 35000,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1.4,
    LimitedEggViewportVerticalOffset = 0.15,
    Egg = table.freeze({
        DisplayName = "Strawberry Elephant Egg",
        Icon = "rbxassetid://139937203160382",
        GrowthTime = 14400,
        WeightKg = 6,
        HideRarity = true
    })
}
local v3 = {}
local v4 = Instance.new("Animation")

if not pcall(function() -- line 42 | captures: v4
        v4.AnimationId = "rbxassetid://103071402508081"
    end) then
    warn("Animation rbxassetid://103071402508081 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 51 | captures: Animation
        Animation.AnimationId = "rbxassetid://88779023816108"
    end) then
    warn("Animation rbxassetid://88779023816108 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Eternal
v2.BaseModelColor = Color3.new(1, 0, 0)

local v5 = {}
local v6 = {}

v6[1] = Color3.new(1, 0, 0)
v6[2] = 990

local v7 = table.freeze(v6)
local v8 = {}

v8[1] = Color3.new(1, 1, 1)
v8[2] = 10
v5[1] = v7
v5[2] = table.freeze(v8)
v2.PossibleModelColors = table.freeze(v5)
v2.WalkSound = table.freeze({
    SoundId = 127805107648749,
    Data = table.freeze({
        Looped = true,
        MaxDistance = 20,
        Speed = 1,
        Volume = 2
    })
})
v2.RandomIdleSound = table.freeze({
    SoundId = 117208332806108,
    Data = table.freeze({
        MaxDistance = 20,
        Volume = 1.5
    })
})
return (table.freeze(v2))
