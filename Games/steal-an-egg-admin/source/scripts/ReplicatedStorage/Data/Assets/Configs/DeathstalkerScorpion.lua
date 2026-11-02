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
    _id = "DeathstalkerScorpion",
    DisplayName = "Scorpion",
    Icon = "rbxassetid://95410883489917",
    EarningRate = 18500,
    IndexSpeedReward = 14400,
    DropWeight = 0.2,
    VisualOdds = 35911.763516,
    ModelWeight = 75,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Scorpion Egg",
        Icon = "rbxassetid://124805981735905",
        GrowthTime = 300,
        WeightKg = 3
    })
}
local v3 = {}
local v4 = Instance.new("Animation")

if not pcall(function() -- line 36 | captures: v4
        v4.AnimationId = "rbxassetid://109518032175154"
    end) then
    warn("Animation rbxassetid://109518032175154 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 45 | captures: Animation
        Animation.AnimationId = "rbxassetid://86141571660663"
    end) then
    warn("Animation rbxassetid://86141571660663 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Mythic
v2.BaseModelColor = Color3.new(0.8352941274642944, 0.6313725709915161, 0.364705890417099)

local v5 = {}
local v6 = {}

v6[1] = Color3.new(0.9176470637321472, 0.6941176652908325, 0.4000000059604645)
v6[2] = 520

local v7 = table.freeze(v6)
local v8 = {}

v8[1] = Color3.new(0.686274528503418, 0.47058823704719543, 0.2549019753932953)
v8[2] = 220

local v9 = table.freeze(v8)
local v10 = {}

v10[1] = Color3.new(0.7490196228027344, 0.5137255191802979, 0.35686275362968445)
v10[2] = 150

local v11 = table.freeze(v10)
local v12 = {}

v12[1] = Color3.new(0.8627451062202454, 0.8039215803146362, 0.5882353186607361)
v12[2] = 30

local v13 = table.freeze(v12)
local v14 = {}

v14[1] = Color3.new(1, 1, 1)
v14[2] = 12
v5[1] = v7
v5[2] = v9
v5[3] = v11
v5[4] = v13
v5[5] = table.freeze(v14)
v2.PossibleModelColors = table.freeze(v5)
v2.WalkSound = table.freeze({
    SoundId = 138857268696727,
    Data = table.freeze({
        Looped = true,
        MaxDistance = 20,
        Speed = 1,
        Volume = 1.5
    })
})
v2.RandomIdleSound = table.freeze({
    SoundId = 98686198947249,
    Data = table.freeze({
        MaxDistance = 20,
        Volume = 1.5
    })
})
return (table.freeze(v2))
