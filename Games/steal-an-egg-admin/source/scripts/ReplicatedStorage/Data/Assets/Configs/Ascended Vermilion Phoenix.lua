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
    _id = "Ascended Vermilion Phoenix",
    DisplayName = "Phoenix",
    Icon = "rbxassetid://118067990008425",
    EarningRate = 85000000,
    IndexSpeedReward = 48000,
    DropWeight = 0.1111111111111111,
    VisualOdds = 1077352905.49,
    ModelWeight = 2500,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Phoenix Egg",
        Icon = "rbxassetid://134491333572507",
        GrowthTime = 16200,
        WeightKg = 5
    })
}
local v3 = {}
local v4 = Instance.new("Animation")

if not pcall(function() -- line 36 | captures: v4
        v4.AnimationId = "rbxassetid://94347130176640"
    end) then
    warn("Animation rbxassetid://94347130176640 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 45 | captures: Animation
        Animation.AnimationId = "rbxassetid://104897270694494"
    end) then
    warn("Animation rbxassetid://104897270694494 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Eternal
v2.BaseModelColor = Color3.new(0.6392157077789307, 0.33725491166114807, 0.16470588743686676)

local v5 = {}
local v6 = {}

v6[1] = Color3.new(0.6392157077789307, 0.33725491166114807, 0.16470588743686676)
v6[2] = 440

local v7 = table.freeze(v6)
local v8 = {}

v8[1] = Color3.new(1, 0.48235294222831726, 0.18431372940540314)
v8[2] = 210

local v9 = table.freeze(v8)
local v10 = {}

v10[1] = Color3.new(0.5098039507865906, 0.2549019753932953, 0.10588235408067703)
v10[2] = 150

local v11 = table.freeze(v10)
local v12 = {}

v12[1] = Color3.new(0.7176470756530762, 0.30588236451148987, 0.07058823853731155)
v12[2] = 120

local v13 = table.freeze(v12)
local v14 = {}

v14[1] = Color3.new(1, 0, 0)
v14[2] = 80

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
    SoundId = 112498065440079,
    Data = table.freeze({
        Looped = true,
        MaxDistance = 20,
        Speed = 1,
        Volume = 1.5
    })
})
v2.RandomIdleSound = table.freeze({
    SoundId = 107613992738568,
    Data = table.freeze({
        MaxDistance = 20,
        Volume = 1.5
    })
})
return (table.freeze(v2))
