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
    _id = "Tralaledon",
    DisplayName = "Tralaledon",
    Icon = "rbxassetid://83759742597862",
    EarningRate = 32000000,
    IndexSpeedReward = 480000,
    DropWeight = 0.5,
    VisualOdds = 4788235.136,
    ModelWeight = 1000,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Tralaledon Egg",
        Icon = "rbxassetid://73956313512014",
        GrowthTime = 10800,
        WeightKg = 4
    })
}
local v3 = {}
local v4 = Instance.new("Animation")

if not pcall(function() -- line 36 | captures: v4
        v4.AnimationId = "rbxassetid://89249556585830"
    end) then
    warn("Animation rbxassetid://89249556585830 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 45 | captures: Animation
        Animation.AnimationId = "rbxassetid://135981680440286"
    end) then
    warn("Animation rbxassetid://135981680440286 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Secret
v2.BaseModelColor = Color3.new(0.33725491166114807, 0.6274510025978088, 0.239215686917305)

local v5 = {}
local v6 = {}

v6[1] = Color3.new(0.33725491166114807, 0.6274510025978088, 0.239215686917305)
v6[2] = 1

local v7 = table.freeze(v6)
local v8 = {}

v8[1] = Color3.new(0.3764705955982208, 0.46666666865348816, 0.32156863808631897)
v8[2] = 1

local v9 = table.freeze(v8)
local v10 = {}

v10[1] = Color3.new(0.3529411852359772, 0.3921568691730499, 0.4117647111415863)
v10[2] = 1

local v11 = table.freeze(v10)
local v12 = {}

v12[1] = Color3.new(0.364705890417099, 0.3294117748737335, 0.26274511218070984)
v12[2] = 1

local v13 = table.freeze(v12)
local v14 = {}

v14[1] = Color3.new(0.5686274766921997, 0.47843137383461, 0.33725491166114807)
v14[2] = 1

local v15 = table.freeze(v14)
local v16 = {}

v16[1] = Color3.new(1, 1, 1)
v16[2] = 12
v5[1] = v7
v5[2] = v9
v5[3] = v11
v5[4] = v13
v5[5] = v15
v5[6] = table.freeze(v16)
v2.PossibleModelColors = table.freeze(v5)
v2.WalkSound = table.freeze({
    SoundId = 112204544250528,
    Data = table.freeze({
        Looped = true,
        MaxDistance = 20,
        Speed = 1,
        Volume = 1.5
    })
})
v2.RandomIdleSound = table.freeze({
    SoundId = 98128572801043,
    Data = table.freeze({
        MaxDistance = 20,
        Volume = 1.5
    })
})
return (table.freeze(v2))
