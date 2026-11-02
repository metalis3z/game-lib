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
    _id = "Stag",
    DisplayName = "Stag",
    Icon = "rbxassetid://104404147595231",
    EarningRate = 145000000,
    IndexSpeedReward = 4809168,
    DropWeight = 0,
    VisualOdds = 1142000000000000,
    ModelWeight = 180,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Stag Egg",
        Icon = "rbxassetid://85751472108828",
        GrowthTime = 10800,
        WeightKg = 3
    })
}
local v3 = {}
local v4 = Instance.new("Animation")

if not pcall(function() -- line 36 | captures: v4
        v4.AnimationId = "rbxassetid://129764979679217"
    end) then
    warn("Animation rbxassetid://129764979679217 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 45 | captures: Animation
        Animation.AnimationId = "rbxassetid://128412347464247"
    end) then
    warn("Animation rbxassetid://128412347464247 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Secret
v2.BaseModelColor = Color3.new(0.95686274766922, 0.8627451062202454, 0.7098039388656616)

local v5 = {}
local v6 = {}

v6[1] = Color3.new(0.95686274766922, 0.8627451062202454, 0.7098039388656616)
v6[2] = 850

local v7 = table.freeze(v6)
local v8 = {}

v8[1] = Color3.new(0.7450980544090271, 0.5490196347236633, 0.3529411852359772)
v8[2] = 90

local v9 = table.freeze(v8)
local v10 = {}

v10[1] = Color3.new(0.5490196347236633, 0.5098039507865906, 0.47058823704719543)
v10[2] = 48

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
    SoundId = 127449225604986,
    Data = table.freeze({
        Looped = true,
        MaxDistance = 20,
        Speed = 1,
        Volume = 1.5
    })
})
return (table.freeze(v2))
