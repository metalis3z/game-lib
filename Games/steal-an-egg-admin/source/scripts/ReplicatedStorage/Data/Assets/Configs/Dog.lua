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
    _id = "Dog",
    DisplayName = "Dog",
    Icon = "rbxassetid://136081034959237",
    EarningRate = 2,
    IndexSpeedReward = 460,
    DropWeight = 0,
    VisualOdds = 2,
    ModelWeight = 25,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Dog Egg",
        Icon = "rbxassetid://91260564167870",
        GrowthTime = 15,
        WeightKg = 1
    })
}
local v3 = {}
local v4 = Instance.new("Animation")

if not pcall(function() -- line 36 | captures: v4
        v4.AnimationId = "rbxassetid://138620670241654"
    end) then
    warn("Animation rbxassetid://138620670241654 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 45 | captures: Animation
        Animation.AnimationId = "rbxassetid://134385122622824"
    end) then
    warn("Animation rbxassetid://134385122622824 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Common
v2.BaseModelColor = Color3.new(0.6470588445663452, 0.3333333432674408, 0.3333333432674408)

local v5 = {}
local v6 = {}

v6[1] = Color3.new(0.6470588445663452, 0.3333333432674408, 0.3333333432674408)
v6[2] = 170

local v7 = table.freeze(v6)
local v8 = {}

v8[1] = Color3.new(0.8549019694328308, 0.6196078658103943, 0.2823529541492462)
v8[2] = 160

local v9 = table.freeze(v8)
local v10 = {}

v10[1] = Color3.new(0.8039215803146362, 0.6666666865348816, 0.4117647111415863)
v10[2] = 145

local v11 = table.freeze(v10)
local v12 = {}

v12[1] = Color3.new(0.9333333373069763, 0.8627451062202454, 0.686274528503418)
v12[2] = 115

local v13 = table.freeze(v12)
local v14 = {}

v14[1] = Color3.new(0.9607843160629272, 0.9411764740943909, 0.8823529481887817)
v14[2] = 85

local v15 = table.freeze(v14)
local v16 = {}

v16[1] = Color3.new(0.4117647111415863, 0.2549019753932953, 0.1568627506494522)
v16[2] = 115

local v17 = table.freeze(v16)
local v18 = {}

v18[1] = Color3.new(0.21568627655506134, 0.1764705926179886, 0.14901961386203766)
v18[2] = 90

local v19 = table.freeze(v18)
local v20 = {}

v20[1] = Color3.new(0.5882353186607361, 0.529411792755127, 0.45098039507865906)
v20[2] = 55

local v21 = table.freeze(v20)
local v22 = {}

v22[1] = Color3.new(0.37254902720451355, 0.3921568691730499, 0.4117647111415863)
v22[2] = 40

local v23 = table.freeze(v22)
local v24 = {}

v24[1] = Color3.new(0.7254902124404907, 0.7254902124404907, 0.6980392336845398)
v24[2] = 25
v5[1] = v7
v5[2] = v9
v5[3] = v11
v5[4] = v13
v5[5] = v15
v5[6] = v17
v5[7] = v19
v5[8] = v21
v5[9] = v23
v5[10] = table.freeze(v24)
v2.PossibleModelColors = table.freeze(v5)
v2.WalkSound = table.freeze({
    SoundId = 140035021914527,
    Data = table.freeze({
        Looped = true,
        MaxDistance = 20,
        Speed = 1,
        Volume = 1.5
    })
})
return (table.freeze(v2))
