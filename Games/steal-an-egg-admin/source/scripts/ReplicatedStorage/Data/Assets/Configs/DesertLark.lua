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
    _id = "DesertLark",
    DisplayName = "Bird",
    Icon = "rbxassetid://107145283169125",
    EarningRate = 8,
    IndexSpeedReward = 500,
    DropWeight = 0.3333333333333333,
    VisualOdds = 3.265923580159354,
    ModelWeight = 5,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Bird Egg",
        Icon = "rbxassetid://74743575552986",
        GrowthTime = 25,
        WeightKg = 1
    })
}
local v3 = {}
local v4 = Instance.new("Animation")

if not pcall(function() -- line 36 | captures: v4
        v4.AnimationId = "rbxassetid://134520216217942"
    end) then
    warn("Animation rbxassetid://134520216217942 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 45 | captures: Animation
        Animation.AnimationId = "rbxassetid://118685523682780"
    end) then
    warn("Animation rbxassetid://118685523682780 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Uncommon
v2.BaseModelColor = Color3.new(0.6470588445663452, 0.6078431606292725, 0.5058823823928833)

local v5 = {}
local v6 = {}

v6[1] = Color3.new(0.6470588445663452, 0.6078431606292725, 0.5058823823928833)
v6[2] = 700

local v7 = table.freeze(v6)
local v8 = {}

v8[1] = Color3.new(0.7450980544090271, 0.686274528503418, 0.529411792755127)
v8[2] = 180

local v9 = table.freeze(v8)
local v10 = {}

v10[1] = Color3.new(0.4901960790157318, 0.4117647111415863, 0.29411765933036804)
v10[2] = 85

local v11 = table.freeze(v10)
local v12 = {}

v12[1] = Color3.new(0.843137264251709, 0.7843137383460999, 0.6470588445663452)
v12[2] = 35

local v13 = table.freeze(v12)
local v14 = {}

v14[1] = Color3.new(1, 1, 1)
v14[2] = 15
v5[1] = v7
v5[2] = v9
v5[3] = v11
v5[4] = v13
v5[5] = table.freeze(v14)
v2.PossibleModelColors = table.freeze(v5)
v2.WalkSound = table.freeze({
    SoundId = 127846388831776,
    Data = table.freeze({
        Looped = true,
        MaxDistance = 20,
        Speed = 1,
        Volume = 1.5
    })
})
v2.RandomIdleSound = table.freeze({
    SoundId = 73753170448216,
    Data = table.freeze({
        MaxDistance = 20,
        Volume = 1.5
    })
})
return (table.freeze(v2))
