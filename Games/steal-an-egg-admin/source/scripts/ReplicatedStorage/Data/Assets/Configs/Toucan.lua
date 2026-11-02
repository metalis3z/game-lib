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
    _id = "Toucan",
    DisplayName = "Toucan",
    Icon = "rbxassetid://125683101618417",
    EarningRate = 110,
    IndexSpeedReward = 8100,
    DropWeight = 0.5,
    VisualOdds = 215470.581098,
    ModelWeight = 5,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Toucan Egg",
        Icon = "rbxassetid://120301498654307",
        GrowthTime = 40,
        WeightKg = 3
    })
}
local v3 = {}
local v4 = Instance.new("Animation")

if not pcall(function() -- line 36 | captures: v4
        v4.AnimationId = "rbxassetid://139835402005118"
    end) then
    warn("Animation rbxassetid://139835402005118 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 45 | captures: Animation
        Animation.AnimationId = "rbxassetid://118238590461629"
    end) then
    warn("Animation rbxassetid://118238590461629 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Rare
v2.BaseModelColor = Color3.new(0.0313725508749485, 0.0313725508749485, 0.03529411926865578)

local v5 = {}
local v6 = {}

v6[1] = Color3.new(0.0313725508749485, 0.0313725508749485, 0.03529411926865578)
v6[2] = 760

local v7 = table.freeze(v6)
local v8 = {}

v8[1] = Color3.new(0.1764705926179886, 0.1764705926179886, 0.16470588743686676)
v8[2] = 120

local v9 = table.freeze(v8)
local v10 = {}

v10[1] = Color3.new(0.9607843160629272, 0.9215686321258545, 0.8039215803146362)
v10[2] = 80

local v11 = table.freeze(v10)
local v12 = {}

v12[1] = Color3.new(0.29411765933036804, 0.21568627655506134, 0.13725490868091583)
v12[2] = 40

local v13 = table.freeze(v12)
local v14 = {}

v14[1] = Color3.new(1, 1, 1)
v14[2] = 10
v5[1] = v7
v5[2] = v9
v5[3] = v11
v5[4] = v13
v5[5] = table.freeze(v14)
v2.PossibleModelColors = table.freeze(v5)
v2.WalkSound = table.freeze({
    SoundId = 101776201860240,
    Data = table.freeze({
        Looped = true,
        MaxDistance = 20,
        Speed = 1,
        Volume = 1.5
    })
})
return (table.freeze(v2))
