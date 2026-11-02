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
    _id = "Dream Axolotl",
    DisplayName = "Axolotl",
    Icon = "rbxassetid://84193700181481",
    EarningRate = 2800,
    IndexSpeedReward = 4000,
    DropWeight = 0.16666666666666666,
    VisualOdds = 954.119769692145,
    ModelWeight = 28,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Axolotl Egg",
        Icon = "rbxassetid://125947630197409",
        GrowthTime = 300,
        WeightKg = 2
    })
}
local v3 = {}
local v4 = Instance.new("Animation")

if not pcall(function() -- line 36 | captures: v4
        v4.AnimationId = "rbxassetid://79117852234312"
    end) then
    warn("Animation rbxassetid://79117852234312 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 45 | captures: Animation
        Animation.AnimationId = "rbxassetid://100032419839399"
    end) then
    warn("Animation rbxassetid://100032419839399 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Legendary
v2.BaseModelColor = Color3.new(0.20000000298023224, 0.3450980484485626, 0.5098039507865906)

local v5 = {}
local v6 = {}

v6[1] = Color3.new(0.20000000298023224, 0.3450980484485626, 0.5098039507865906)
v6[2] = 430

local v7 = table.freeze(v6)
local v8 = {}

v8[1] = Color3.new(0.37254902720451355, 0.27450981736183167, 0.21568627655506134)
v8[2] = 230

local v9 = table.freeze(v8)
local v10 = {}

v10[1] = Color3.new(0.9215686321258545, 0.8235294222831726, 0.47058823704719543)
v10[2] = 150

local v11 = table.freeze(v10)
local v12 = {}

v12[1] = Color3.new(0.9607843160629272, 0.9607843160629272, 0.9019607901573181)
v12[2] = 110

local v13 = table.freeze(v12)
local v14 = {}

v14[1] = Color3.new(0.1764705926179886, 0.1764705926179886, 0.1764705926179886)
v14[2] = 60

local v15 = table.freeze(v14)
local v16 = {}

v16[1] = Color3.new(0.6274510025978088, 0.5098039507865906, 0.4117647111415863)
v16[2] = 20
v5[1] = v7
v5[2] = v9
v5[3] = v11
v5[4] = v13
v5[5] = v15
v5[6] = table.freeze(v16)
v2.PossibleModelColors = table.freeze(v5)
v2.WalkSound = table.freeze({
    SoundId = 139078355640288,
    Data = table.freeze({
        Looped = true,
        MaxDistance = 20,
        Speed = 1,
        Volume = 1.5
    })
})
v2.RandomIdleSound = table.freeze({
    SoundId = 130563104837830,
    Data = table.freeze({
        MaxDistance = 20,
        Volume = 1.5
    })
})
return (table.freeze(v2))
