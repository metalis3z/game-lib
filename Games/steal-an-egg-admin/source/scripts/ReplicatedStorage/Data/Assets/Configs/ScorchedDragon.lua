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
    _id = "ScorchedDragon",
    DisplayName = "Scorched Dragon",
    Icon = "rbxassetid://118256340851628",
    EarningRate = 35000000,
    IndexSpeedReward = 150000,
    DropWeight = 0,
    VisualOdds = 1000,
    ModelWeight = 120000,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    DontRoll = true,
    Egg = table.freeze({
        DisplayName = "Dragon's Egg",
        Icon = "rbxassetid://100644181945680",
        GrowthTime = 10800,
        WeightKg = 40,
        IgnoreSizeGrowthMultiplier = true
    })
}
local v3 = {}
local v4 = Instance.new("Animation")

if not pcall(function() -- line 43 | captures: v4
        v4.AnimationId = "rbxassetid://76817701592713"
    end) then
    warn("Animation rbxassetid://76817701592713 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 52 | captures: Animation
        Animation.AnimationId = "rbxassetid://95675485384755"
    end) then
    warn("Animation rbxassetid://95675485384755 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Secret
v2.BaseModelColor = Color3.new(0.3529411852359772, 0.2980392277240753, 0.25882354378700256)

local v5 = {}
local v6 = {}

v6[1] = Color3.new(0.3529411852359772, 0.2980392277240753, 0.25882354378700256)
v6[2] = 700

local v7 = table.freeze(v6)
local v8 = {}

v8[1] = Color3.new(0.20000000298023224, 0.18039216101169586, 0.16862745583057404)
v8[2] = 180

local v9 = table.freeze(v8)
local v10 = {}

v10[1] = Color3.new(0.6666666865348816, 0.3333333432674408, 0.13725490868091583)
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
    SoundId = 80955737198756,
    Data = table.freeze({
        Looped = true,
        MaxDistance = 20,
        Speed = 1,
        Volume = 1.5
    })
})
return (table.freeze(v2))
