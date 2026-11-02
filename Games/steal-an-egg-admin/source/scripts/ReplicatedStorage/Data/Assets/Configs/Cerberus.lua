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
    _id = "Cerberus",
    DisplayName = "Cerberus",
    Icon = "rbxassetid://108544031967330",
    EarningRate = 8000000,
    IndexSpeedReward = 42000,
    DropWeight = 0.12,
    VisualOdds = 718235270.327,
    ModelWeight = 9000,
    WalkAnimationReferenceSpeed = 7,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    GenderLocked = "Male",
    Egg = table.freeze({
        DisplayName = "Cerberus Egg",
        Icon = "rbxassetid://107853009376509",
        GrowthTime = 7200,
        WeightKg = 5
    })
}
local v3 = {}
local v4 = Instance.new("Animation")

if not pcall(function() -- line 38 | captures: v4
        v4.AnimationId = "rbxassetid://100285400353573"
    end) then
    warn("Animation rbxassetid://100285400353573 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 47 | captures: Animation
        Animation.AnimationId = "rbxassetid://110642767024840"
    end) then
    warn("Animation rbxassetid://110642767024840 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Secret
v2.BaseModelColor = Color3.new(0.23137255012989044, 0.21176470816135406, 0.21176470816135406)

local v5 = {}
local v6 = {}

v6[1] = Color3.new(0.23137255012989044, 0.21176470816135406, 0.21176470816135406)
v6[2] = 950

local v7 = table.freeze(v6)
local v8 = {}

v8[1] = Color3.new(0.7058823704719543, 0.13725490868091583, 0.09803921729326248)
v8[2] = 50

local v9 = table.freeze(v8)
local v10 = {}

v10[1] = Color3.new(1, 1, 1)
v10[2] = 12
v5[1] = v7
v5[2] = v9
v5[3] = table.freeze(v10)
v2.PossibleModelColors = table.freeze(v5)
v2.WalkSound = table.freeze({
    SoundId = 95219305433383,
    Data = table.freeze({
        Looped = true,
        MaxDistance = 20,
        Speed = 1,
        Volume = 1.5
    })
})
v2.RandomIdleSound = table.freeze({
    SoundId = 119965643757055,
    Data = table.freeze({
        MaxDistance = 20,
        Volume = 1.5
    })
})
return (table.freeze(v2))
