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
    _id = "El Maja",
    DisplayName = "El Maja",
    Icon = "rbxassetid://78386570682703",
    EarningRate = 130000000,
    IndexSpeedReward = 180000,
    DropWeight = 0.125,
    VisualOdds = 66391535236.3381,
    ModelWeight = 90000,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    GenderLocked = "Male",
    Egg = table.freeze({
        DisplayName = "El Maja Egg",
        Icon = "rbxassetid://86275614169244",
        GrowthTime = 19800,
        WeightKg = 6
    })
}
local v3 = {}
local v4 = Instance.new("Animation")

if not pcall(function() -- line 37 | captures: v4
        v4.AnimationId = "rbxassetid://93659227865610"
    end) then
    warn("Animation rbxassetid://93659227865610 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 46 | captures: Animation
        Animation.AnimationId = "rbxassetid://98812671629588"
    end) then
    warn("Animation rbxassetid://98812671629588 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Eternal
v2.BaseModelColor = Color3.new(0, 0.6000000238418579, 1)

local v5 = {}
local v6 = {}

v6[1] = Color3.new(0, 0.6000000238418579, 1)
v6[2] = 900

local v7 = table.freeze(v6)
local v8 = {}

v8[1] = Color3.new(0, 0.1764705926179886, 0.37254902720451355)
v8[2] = 100

local v9 = table.freeze(v8)
local v10 = {}

v10[1] = Color3.new(1, 1, 1)
v10[2] = 12
v5[1] = v7
v5[2] = v9
v5[3] = table.freeze(v10)
v2.PossibleModelColors = table.freeze(v5)
v2.RandomIdleSound = table.freeze({
    SoundId = 81075541421251,
    Data = table.freeze({
        MaxDistance = 20,
        Volume = 1.5
    })
})
return (table.freeze(v2))
