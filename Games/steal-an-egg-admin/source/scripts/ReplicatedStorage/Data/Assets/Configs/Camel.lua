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
    _id = "Camel",
    DisplayName = "Camel",
    Icon = "rbxassetid://108762713931799",
    EarningRate = 75,
    IndexSpeedReward = 9000,
    DropWeight = 0.5,
    VisualOdds = 7778.721339,
    ModelWeight = 700,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Camel Egg",
        Icon = "rbxassetid://115243820830396",
        GrowthTime = 45,
        WeightKg = 2
    })
}
local v3 = {}
local v4 = Instance.new("Animation")

if not pcall(function() -- line 36 | captures: v4
        v4.AnimationId = "rbxassetid://132412960463671"
    end) then
    warn("Animation rbxassetid://132412960463671 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 45 | captures: Animation
        Animation.AnimationId = "rbxassetid://98731243592840"
    end) then
    warn("Animation rbxassetid://98731243592840 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Rare
v2.BaseModelColor = Color3.new(0.6901960968971252, 0.5333333611488342, 0.3529411852359772)

local v5 = {}
local v6 = {}

v6[1] = Color3.new(0.7372549176216125, 0.6078431606292725, 0.364705890417099)
v6[2] = 680

local v7 = table.freeze(v6)
local v8 = {}

v8[1] = Color3.new(0.5882353186607361, 0.4117647111415863, 0.23529411852359772)
v8[2] = 180

local v9 = table.freeze(v8)
local v10 = {}

v10[1] = Color3.new(0.8627451062202454, 0.7647058963775635, 0.5490196347236633)
v10[2] = 105

local v11 = table.freeze(v10)
local v12 = {}

v12[1] = Color3.new(0.37254902720451355, 0.2549019753932953, 0.1568627506494522)
v12[2] = 35

local v13 = table.freeze(v12)
local v14 = {}

v14[1] = Color3.new(1, 1, 1)
v14[2] = 12
v5[1] = v7
v5[2] = v9
v5[3] = v11
v5[4] = v13
v5[5] = table.freeze(v14)
v2.PossibleModelColors = table.freeze(v5)
v2.WalkSound = table.freeze({
    SoundId = 131805745851154,
    Data = table.freeze({
        Looped = true,
        MaxDistance = 20,
        Speed = 1,
        Volume = 1.5
    })
})
return (table.freeze(v2))
