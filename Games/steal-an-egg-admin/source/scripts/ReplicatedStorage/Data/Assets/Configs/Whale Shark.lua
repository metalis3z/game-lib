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
    _id = "Whale Shark",
    DisplayName = "Whale Shark",
    Icon = "rbxassetid://135659954957208",
    EarningRate = 700000,
    IndexSpeedReward = 108000,
    DropWeight = 0.25,
    VisualOdds = 14504941186.087273,
    ModelWeight = 2000,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Whale Shark Egg",
        Icon = "rbxassetid://95374412366370",
        GrowthTime = 600,
        WeightKg = 6
    })
}
local v3 = {}
local v4 = Instance.new("Animation")

if not pcall(function() -- line 36 | captures: v4
        v4.AnimationId = "rbxassetid://140193772482652"
    end) then
    warn("Animation rbxassetid://140193772482652 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 45 | captures: Animation
        Animation.AnimationId = "rbxassetid://76942012579199"
    end) then
    warn("Animation rbxassetid://76942012579199 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Cosmic
v2.BaseModelColor = Color3.new(0, 0.125490203499794, 0.3764705955982208)

local v5 = {}
local v6 = {}

v6[1] = Color3.new(0, 0.125490203499794, 0.3764705955982208)
v6[2] = 680

local v7 = table.freeze(v6)
local v8 = {}

v8[1] = Color3.new(0.09803921729326248, 0.16862745583057404, 0.21176470816135406)
v8[2] = 160

local v9 = table.freeze(v8)
local v10 = {}

v10[1] = Color3.new(0.14509804546833038, 0.16862745583057404, 0.1764705926179886)
v10[2] = 110

local v11 = table.freeze(v10)
local v12 = {}

v12[1] = Color3.new(0.14901961386203766, 0.16078431904315948, 0.16078431904315948)
v12[2] = 35

local v13 = table.freeze(v12)
local v14 = {}

v14[1] = Color3.new(0.09803921729326248, 0.13725490868091583, 0.1764705926179886)
v14[2] = 15

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
v2.RandomIdleSound = table.freeze({
    SoundId = 122798677575215,
    Data = table.freeze({
        MaxDistance = 20,
        Volume = 1.5
    })
})
return (table.freeze(v2))
