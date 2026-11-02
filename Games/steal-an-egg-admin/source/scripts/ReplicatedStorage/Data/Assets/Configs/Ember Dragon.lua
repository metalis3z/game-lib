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
    _id = "Ember Dragon",
    DisplayName = "Ember Dragon",
    Icon = "rbxassetid://135461363436221",
    EarningRate = 600000000,
    IndexSpeedReward = 80000,
    DropWeight = 0,
    VisualOdds = 50000,
    ModelWeight = 14000,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    DontRoll = true,
    Egg = table.freeze({
        DisplayName = "Dragon Egg",
        Icon = "rbxassetid://105587107333631",
        GrowthTime = 60,
        WeightKg = 5
    })
}
local v3 = {}
local v4 = Instance.new("Animation")

if not pcall(function() -- line 37 | captures: v4
        v4.AnimationId = "rbxassetid://93012623610055"
    end) then
    warn("Animation rbxassetid://93012623610055 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 46 | captures: Animation
        Animation.AnimationId = "rbxassetid://80115387711372"
    end) then
    warn("Animation rbxassetid://80115387711372 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Secret
v2.BaseModelColor = Color3.new(0.3803921639919281, 0.2823529541492462, 0.23529411852359772)

local v5 = {}
local v6 = {}

v6[1] = Color3.new(0.3803921639919281, 0.2823529541492462, 0.23529411852359772)
v6[2] = 700

local v7 = table.freeze(v6)
local v8 = {}

v8[1] = Color3.new(0.5607843399047852, 0.30980393290519714, 0.16470588743686676)
v8[2] = 180

local v9 = table.freeze(v8)
local v10 = {}

v10[1] = Color3.new(0.27450981736183167, 0.1882352977991104, 0.14901961386203766)
v10[2] = 108

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
    SoundId = 131092059995772,
    Data = table.freeze({
        Looped = true,
        MaxDistance = 20,
        Speed = 0.9,
        Volume = 1.5
    })
})
return (table.freeze(v2))
