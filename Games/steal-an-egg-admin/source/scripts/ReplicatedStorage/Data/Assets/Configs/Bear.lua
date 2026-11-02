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
    _id = "Bear",
    DisplayName = "Bear",
    Icon = "rbxassetid://99309954423391",
    EarningRate = 240,
    IndexSpeedReward = 820,
    DropWeight = 0.3333333333333333,
    VisualOdds = 56.702784,
    ModelWeight = 220,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Bear Egg",
        Icon = "rbxassetid://71030998820335",
        GrowthTime = 120,
        WeightKg = 2
    })
}
local v3 = {}
local v4 = Instance.new("Animation")

if not pcall(function() -- line 36 | captures: v4
        v4.AnimationId = "rbxassetid://77565626907263"
    end) then
    warn("Animation rbxassetid://77565626907263 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 45 | captures: Animation
        Animation.AnimationId = "rbxassetid://102109984802867"
    end) then
    warn("Animation rbxassetid://102109984802867 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Epic
v2.BaseModelColor = Color3.new(0.32549020648002625, 0.23529411852359772, 0.125490203499794)

local v5 = {}
local v6 = {}

v6[1] = Color3.new(0.32549020648002625, 0.23529411852359772, 0.125490203499794)
v6[2] = 640

local v7 = table.freeze(v6)
local v8 = {}

v8[1] = Color3.new(0.1764705926179886, 0.14901961386203766, 0.125490203499794)
v8[2] = 180

local v9 = table.freeze(v8)
local v10 = {}

v10[1] = Color3.new(0.364705890417099, 0.26274511218070984, 0.1725490242242813)
v10[2] = 120

local v11 = table.freeze(v10)
local v12 = {}

v12[1] = Color3.new(0.8235294222831726, 0.7450980544090271, 0.5882353186607361)
v12[2] = 45

local v13 = table.freeze(v12)
local v14 = {}

v14[1] = Color3.new(0.9215686321258545, 0.9019607901573181, 0.843137264251709)
v14[2] = 15
v5[1] = v7
v5[2] = v9
v5[3] = v11
v5[4] = v13
v5[5] = table.freeze(v14)
v2.PossibleModelColors = table.freeze(v5)
v2.WalkSound = table.freeze({
    SoundId = 125934411338333,
    Data = table.freeze({
        Looped = true,
        MaxDistance = 20,
        Speed = 1,
        Volume = 1.5
    })
})
v2.RandomIdleSound = table.freeze({
    SoundId = 88803960407657,
    Data = table.freeze({
        MaxDistance = 20,
        Volume = 1.5
    })
})
return (table.freeze(v2))
