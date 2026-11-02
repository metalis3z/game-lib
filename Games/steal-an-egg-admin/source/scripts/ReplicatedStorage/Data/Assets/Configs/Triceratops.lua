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
    _id = "Triceratops",
    DisplayName = "Triceratops",
    Icon = "rbxassetid://110369954301113",
    EarningRate = 1200000,
    IndexSpeedReward = 360000,
    DropWeight = 0.3333333333333333,
    VisualOdds = 13901.327813000002,
    ModelWeight = 3500,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Triceratops Egg",
        Icon = "rbxassetid://73329615832715",
        GrowthTime = 480,
        WeightKg = 3
    })
}
local v3 = {}
local v4 = Instance.new("Animation")

if not pcall(function() -- line 36 | captures: v4
        v4.AnimationId = "rbxassetid://83453543037408"
    end) then
    warn("Animation rbxassetid://83453543037408 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 45 | captures: Animation
        Animation.AnimationId = "rbxassetid://86521244889882"
    end) then
    warn("Animation rbxassetid://86521244889882 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Cosmic
v2.BaseModelColor = Color3.new(0.35686275362968445, 0.30588236451148987, 0.2823529541492462)

local v5 = {}
local v6 = {}

v6[1] = Color3.new(0.35686275362968445, 0.30588236451148987, 0.2823529541492462)
v6[2] = 520

local v7 = table.freeze(v6)
local v8 = {}

v8[1] = Color3.new(0.4313725531101227, 0.37254902720451355, 0.2549019753932953)
v8[2] = 180

local v9 = table.freeze(v8)
local v10 = {}

v10[1] = Color3.new(0.3333333432674408, 0.4117647111415863, 0.2549019753932953)
v10[2] = 130

local v11 = table.freeze(v10)
local v12 = {}

v12[1] = Color3.new(0.5098039507865906, 0.47058823704719543, 0.37254902720451355)
v12[2] = 110

local v13 = table.freeze(v12)
local v14 = {}

v14[1] = Color3.new(0.23529411852359772, 0.21568627655506134, 0.19607843458652496)
v14[2] = 60

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
    SoundId = 126735408634542,
    Data = table.freeze({
        Looped = true,
        MaxDistance = 20,
        Speed = 1,
        Volume = 1.5
    })
})
v2.RandomIdleSound = table.freeze({
    SoundId = 137847544489094,
    Data = table.freeze({
        MaxDistance = 20,
        Volume = 1.5
    })
})
return (table.freeze(v2))
