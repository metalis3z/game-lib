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
    _id = "Crocodile",
    DisplayName = "Crocodile",
    Icon = "rbxassetid://122868974506056",
    EarningRate = 420,
    IndexSpeedReward = 9000,
    DropWeight = 0.5,
    VisualOdds = 215470.581098,
    ModelWeight = 400,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Crocodile Egg",
        Icon = "rbxassetid://130480701116478",
        GrowthTime = 60,
        WeightKg = 3
    })
}
local v3 = {}
local v4 = Instance.new("Animation")

if not pcall(function() -- line 36 | captures: v4
        v4.AnimationId = "rbxassetid://116131553369592"
    end) then
    warn("Animation rbxassetid://116131553369592 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 45 | captures: Animation
        Animation.AnimationId = "rbxassetid://109901829098691"
    end) then
    warn("Animation rbxassetid://109901829098691 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Epic
v2.BaseModelColor = Color3.new(0.3607843220233917, 0.40784314274787903, 0.23529411852359772)

local v5 = {}
local v6 = {}

v6[1] = Color3.new(0.3607843220233917, 0.40784314274787903, 0.23529411852359772)
v6[2] = 560

local v7 = table.freeze(v6)
local v8 = {}

v8[1] = Color3.new(0.21568627655506134, 0.29411765933036804, 0.1764705926179886)
v8[2] = 210

local v9 = table.freeze(v8)
local v10 = {}

v10[1] = Color3.new(0.3529411852359772, 0.3137255012989044, 0.21568627655506134)
v10[2] = 130

local v11 = table.freeze(v10)
local v12 = {}

v12[1] = Color3.new(0.13725490868091583, 0.1764705926179886, 0.125490203499794)
v12[2] = 25

local v13 = table.freeze(v12)
local v14 = {}

v14[1] = Color3.new(1, 1, 1)
v14[2] = 2
v5[1] = v7
v5[2] = v9
v5[3] = v11
v5[4] = v13
v5[5] = table.freeze(v14)
v2.PossibleModelColors = table.freeze(v5)
v2.WalkSound = table.freeze({
    SoundId = 82254279708488,
    Data = table.freeze({
        Looped = true,
        MaxDistance = 20,
        Speed = 1,
        Volume = 1.5
    })
})
v2.RandomIdleSound = table.freeze({
    SoundId = 74609169325308,
    Data = table.freeze({
        MaxDistance = 20,
        Volume = 1.5
    })
})
return (table.freeze(v2))
