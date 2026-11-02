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
    _id = "Rattlesnake",
    DisplayName = "Snake",
    Icon = "rbxassetid://119006769959865",
    EarningRate = 3600,
    IndexSpeedReward = 10800,
    DropWeight = 0.25,
    VisualOdds = 21547.05811,
    ModelWeight = 45,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Snake Egg",
        Icon = "rbxassetid://102762474708216",
        GrowthTime = 150,
        WeightKg = 3
    })
}
local v3 = { TransitionFadeDuration = 0 }
local v4 = Instance.new("Animation")

if not pcall(function() -- line 36 | captures: v4
        v4.AnimationId = "rbxassetid://101464154860512"
    end) then
    warn("Animation rbxassetid://101464154860512 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 45 | captures: Animation
        Animation.AnimationId = "rbxassetid://101464154860512"
    end) then
    warn("Animation rbxassetid://101464154860512 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Legendary
v2.BaseModelColor = Color3.new(0.6470588445663452, 0.4941176474094391, 0.2823529541492462)

local v5 = {}
local v6 = {}

v6[1] = Color3.new(0.6470588445663452, 0.4941176474094391, 0.2823529541492462)
v6[2] = 680

local v7 = table.freeze(v6)
local v8 = {}

v8[1] = Color3.new(0.7176470756530762, 0.5607843399047852, 0.3450980484485626)
v8[2] = 170

local v9 = table.freeze(v8)
local v10 = {}

v10[1] = Color3.new(0.8039215803146362, 0.686274528503418, 0.45098039507865906)
v10[2] = 115

local v11 = table.freeze(v10)
local v12 = {}

v12[1] = Color3.new(1, 1, 1)
v12[2] = 12
v5[1] = v7
v5[2] = v9
v5[3] = v11
v5[4] = table.freeze(v12)
v2.PossibleModelColors = table.freeze(v5)
v2.WalkSound = table.freeze({
    SoundId = 109276493192796,
    Data = table.freeze({
        Looped = true,
        MaxDistance = 20,
        Speed = 1,
        Volume = 1.5
    })
})
v2.RandomIdleSound = table.freeze({
    SoundId = 71205988211342,
    Data = table.freeze({
        MaxDistance = 20,
        Volume = 1.5
    })
})
return (table.freeze(v2))
