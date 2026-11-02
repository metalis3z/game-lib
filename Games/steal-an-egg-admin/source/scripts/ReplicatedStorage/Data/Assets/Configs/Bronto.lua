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
    _id = "Bronto",
    DisplayName = "Bronto",
    Icon = "rbxassetid://79435491383993",
    EarningRate = 1500000,
    IndexSpeedReward = 300000,
    DropWeight = 0.25,
    VisualOdds = 10773529.055,
    ModelWeight = 35000,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Bronto Egg",
        Icon = "rbxassetid://102498197407436",
        GrowthTime = 660,
        WeightKg = 4
    })
}
local v3 = {}
local v4 = Instance.new("Animation")

if not pcall(function() -- line 36 | captures: v4
        v4.AnimationId = "rbxassetid://125257949492806"
    end) then
    warn("Animation rbxassetid://125257949492806 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 45 | captures: Animation
        Animation.AnimationId = "rbxassetid://81533835013675"
    end) then
    warn("Animation rbxassetid://81533835013675 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Cosmic
v2.BaseModelColor = Color3.new(0.4117647111415863, 0.41960784792900085, 0.4745098054409027)

local v5 = {}
local v6 = {}

v6[1] = Color3.new(0.4117647111415863, 0.41960784792900085, 0.4745098054409027)
v6[2] = 440

local v7 = table.freeze(v6)
local v8 = {}

v8[1] = Color3.new(0.4313725531101227, 0.37254902720451355, 0.27450981736183167)
v8[2] = 210

local v9 = table.freeze(v8)
local v10 = {}

v10[1] = Color3.new(0.37254902720451355, 0.45098039507865906, 0.29411765933036804)
v10[2] = 150

local v11 = table.freeze(v10)
local v12 = {}

v12[1] = Color3.new(0.5686274766921997, 0.5098039507865906, 0.37254902720451355)
v12[2] = 120

local v13 = table.freeze(v12)
local v14 = {}

v14[1] = Color3.new(0.2549019753932953, 0.2549019753932953, 0.27450981736183167)
v14[2] = 80

local v15 = table.freeze(v14)
local v16 = {}

v16[1] = Color3.new(1, 1, 1)
v16[2] = 10
v5[1] = v7
v5[2] = v9
v5[3] = v11
v5[4] = v13
v5[5] = v15
v5[6] = table.freeze(v16)
v2.PossibleModelColors = table.freeze(v5)
v2.WalkSound = table.freeze({
    SoundId = 114024686767991,
    Data = table.freeze({
        Looped = true,
        MaxDistance = 20,
        Speed = 1,
        Volume = 1.5
    })
})
v2.RandomIdleSound = table.freeze({
    SoundId = 110969180505237,
    Data = table.freeze({
        MaxDistance = 20,
        Volume = 1.5
    })
})
return (table.freeze(v2))
