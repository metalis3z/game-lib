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
    _id = "Jerboa",
    DisplayName = "Jerboa",
    Icon = "rbxassetid://139650837807677",
    EarningRate = 6,
    IndexSpeedReward = 7200,
    DropWeight = 0.1,
    VisualOdds = 4275.209942,
    ModelWeight = 2,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Jerboa Egg",
        Icon = "rbxassetid://109714991972247",
        GrowthTime = 20,
        WeightKg = 2
    })
}
local v3 = {}
local v4 = Instance.new("Animation")

if not pcall(function() -- line 36 | captures: v4
        v4.AnimationId = "rbxassetid://123391674147868"
    end) then
    warn("Animation rbxassetid://123391674147868 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 45 | captures: Animation
        Animation.AnimationId = "rbxassetid://91516687459636"
    end) then
    warn("Animation rbxassetid://91516687459636 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Common
v2.BaseModelColor = Color3.new(0.8274509906768799, 0.7450980544090271, 0.5882353186607361)

local v5 = {}
local v6 = {}

v6[1] = Color3.new(0.8392156958580017, 0.729411780834198, 0.5568627715110779)
v6[2] = 760

local v7 = table.freeze(v6)
local v8 = {}

v8[1] = Color3.new(0.7254902124404907, 0.5882353186607361, 0.37254902720451355)
v8[2] = 145

local v9 = table.freeze(v8)
local v10 = {}

v10[1] = Color3.new(0.9215686321258545, 0.843137264251709, 0.686274528503418)
v10[2] = 70

local v11 = table.freeze(v10)
local v12 = {}

v12[1] = Color3.new(0.8588235378265381, 0.6352941393852234, 0.4117647111415863)
v12[2] = 25

local v13 = table.freeze(v12)
local v14 = {}

v14[1] = Color3.new(1, 1, 1)
v14[2] = 15
v5[1] = v7
v5[2] = v9
v5[3] = v11
v5[4] = v13
v5[5] = table.freeze(v14)
v2.PossibleModelColors = table.freeze(v5)
v2.WalkSound = table.freeze({
    SoundId = 73049784528209,
    Data = table.freeze({
        Looped = true,
        MaxDistance = 20,
        Speed = 1,
        Volume = 1.5
    })
})
v2.RandomIdleSound = table.freeze({
    SoundId = 74697523043846,
    Data = table.freeze({
        MaxDistance = 20,
        Volume = 1.5
    })
})
return (table.freeze(v2))
