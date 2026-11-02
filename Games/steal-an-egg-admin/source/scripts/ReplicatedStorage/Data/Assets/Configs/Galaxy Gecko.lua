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
    _id = "Galaxy Gecko",
    DisplayName = "Cosmic Gecko",
    Icon = "rbxassetid://115834854015858",
    EarningRate = 30000,
    IndexSpeedReward = 1080000,
    DropWeight = 0,
    VisualOdds = 2500000000000,
    ModelWeight = 18,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Cosmic Gecko Egg",
        Icon = "rbxassetid://107132653319667",
        GrowthTime = 240,
        WeightKg = 8
    })
}
local v3 = {}
local v4 = Instance.new("Animation")

if not pcall(function() -- line 36 | captures: v4
        v4.AnimationId = "rbxassetid://95278754752711"
    end) then
    warn("Animation rbxassetid://95278754752711 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 45 | captures: Animation
        Animation.AnimationId = "rbxassetid://91744189245307"
    end) then
    warn("Animation rbxassetid://91744189245307 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Legendary
v2.BaseModelColor = Color3.new(0.24313725531101227, 0.3294117748737335, 0.40392157435417175)

local v5 = {}
local v6 = {}

v6[1] = Color3.new(0.24313725531101227, 0.3294117748737335, 0.40392157435417175)
v6[2] = 900

local v7 = table.freeze(v6)
local v8 = {}

v8[1] = Color3.new(0.0784313753247261, 0.11764705926179886, 0.21568627655506134)
v8[2] = 100

local v9 = table.freeze(v8)
local v10 = {}

v10[1] = Color3.new(1, 1, 1)
v10[2] = 15
v5[1] = v7
v5[2] = v9
v5[3] = table.freeze(v10)
v2.PossibleModelColors = table.freeze(v5)
v2.WalkSound = table.freeze({
    SoundId = 91858366015966,
    Data = table.freeze({
        Looped = true,
        MaxDistance = 20,
        Speed = 1,
        Volume = 1.5
    })
})
v2.RandomIdleSound = table.freeze({
    SoundId = 103858766460606,
    Data = table.freeze({
        MaxDistance = 20,
        Volume = 1.5
    })
})
return (table.freeze(v2))
