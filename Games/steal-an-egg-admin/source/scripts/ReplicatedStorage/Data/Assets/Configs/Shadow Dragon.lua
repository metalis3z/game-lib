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
    _id = "Shadow Dragon",
    DisplayName = "Shadow Dragon",
    Icon = "rbxassetid://103518023607141",
    EarningRate = 25000000,
    IndexSpeedReward = 20000,
    DropWeight = 0,
    VisualOdds = 500,
    ModelWeight = 10000,
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
        v4.AnimationId = "rbxassetid://79907688848880"
    end) then
    warn("Animation rbxassetid://79907688848880 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 46 | captures: Animation
        Animation.AnimationId = "rbxassetid://124322229671681"
    end) then
    warn("Animation rbxassetid://124322229671681 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Mythic
v2.BaseModelColor = Color3.new(0.33725491166114807, 0.32549020648002625, 0.3333333432674408)

local v5 = {}
local v6 = {}

v6[1] = Color3.new(0.33725491166114807, 0.32549020648002625, 0.3333333432674408)
v6[2] = 650

local v7 = table.freeze(v6)
local v8 = {}

v8[1] = Color3.new(0.21568627655506134, 0.20392157137393951, 0.23529411852359772)
v8[2] = 230

local v9 = table.freeze(v8)
local v10 = {}

v10[1] = Color3.new(0.07058823853731155, 0.07058823853731155, 0.08627451211214066)
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
        Speed = 1.05,
        Volume = 1.5
    })
})
return (table.freeze(v2))
