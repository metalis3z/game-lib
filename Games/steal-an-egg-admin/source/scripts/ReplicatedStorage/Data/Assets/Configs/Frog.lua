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
    _id = "Frog",
    DisplayName = "Frog",
    Icon = "rbxassetid://72292680831922",
    EarningRate = 3,
    IndexSpeedReward = 2000,
    DropWeight = 0.2,
    VisualOdds = 159.607838,
    ModelWeight = 3,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Frog Egg",
        Icon = "rbxassetid://106952885335586",
        GrowthTime = 15,
        WeightKg = 2
    })
}
local v3 = {}
local v4 = Instance.new("Animation")

if not pcall(function() -- line 36 | captures: v4
        v4.AnimationId = "rbxassetid://125431724102906"
    end) then
    warn("Animation rbxassetid://125431724102906 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 45 | captures: Animation
        Animation.AnimationId = "rbxassetid://98654336213348"
    end) then
    warn("Animation rbxassetid://98654336213348 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Common
v2.BaseModelColor = Color3.new(0.29411765933036804, 0.5921568870544434, 0.29411765933036804)

local v5 = {}
local v6 = {}

v6[1] = Color3.new(0.29411765933036804, 0.5921568870544434, 0.29411765933036804)
v6[2] = 620

local v7 = table.freeze(v6)
local v8 = {}

v8[1] = Color3.new(0.4117647111415863, 0.5098039507865906, 0.21568627655506134)
v8[2] = 170

local v9 = table.freeze(v8)
local v10 = {}

v10[1] = Color3.new(0.37254902720451355, 0.3137255012989044, 0.1764705926179886)
v10[2] = 95

local v11 = table.freeze(v10)
local v12 = {}

v12[1] = Color3.new(0.886274516582489, 0.13725490868091583, 1)
v12[2] = 65

local v13 = table.freeze(v12)
local v14 = {}

v14[1] = Color3.new(0.21568627655506134, 0.47058823704719543, 0.47058823704719543)
v14[2] = 35

local v15 = table.freeze(v14)
local v16 = {}

v16[1] = Color3.new(0.1568627506494522, 0.1764705926179886, 0.13725490868091583)
v16[2] = 15

local v17 = table.freeze(v16)
local v18 = {}

v18[1] = Color3.new(1, 1, 1)
v18[2] = 15
v5[1] = v7
v5[2] = v9
v5[3] = v11
v5[4] = v13
v5[5] = v15
v5[6] = v17
v5[7] = table.freeze(v18)
v2.PossibleModelColors = table.freeze(v5)
v2.WalkSound = table.freeze({
    SoundId = 138683356337551,
    Data = table.freeze({
        Looped = true,
        MaxDistance = 20,
        Speed = 1,
        Volume = 2.1
    })
})
v2.RandomIdleSound = table.freeze({
    SoundId = 75677111966851,
    Data = table.freeze({
        MaxDistance = 20,
        Volume = 1.5
    })
})
return (table.freeze(v2))
