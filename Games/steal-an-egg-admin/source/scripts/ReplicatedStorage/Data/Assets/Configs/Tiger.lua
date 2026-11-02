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
    _id = "Tiger",
    DisplayName = "Tiger",
    Icon = "rbxassetid://117036371774198",
    EarningRate = 28000,
    IndexSpeedReward = 14400,
    DropWeight = 0.14285714285714285,
    VisualOdds = 1150976.057531318,
    ModelWeight = 260,
    WalkAnimationReferenceSpeed = 10,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Tiger Egg",
        Icon = "rbxassetid://102887289285403",
        GrowthTime = 360,
        WeightKg = 4
    })
}
local v3 = {}
local v4 = Instance.new("Animation")

if not pcall(function() -- line 37 | captures: v4
        v4.AnimationId = "rbxassetid://90519439964790"
    end) then
    warn("Animation rbxassetid://90519439964790 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 46 | captures: Animation
        Animation.AnimationId = "rbxassetid://118653063399998"
    end) then
    warn("Animation rbxassetid://118653063399998 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Mythic
v2.BaseModelColor = Color3.new(1, 0.5333333611488342, 0.20000000298023224)

local v5 = {}
local v6 = {}

v6[1] = Color3.new(1, 0.5333333611488342, 0.20000000298023224)
v6[2] = 820

local v7 = table.freeze(v6)
local v8 = {}

v8[1] = Color3.new(0.9333333373069763, 0.8980392217636108, 0.8039215803146362)
v8[2] = 120

local v9 = table.freeze(v8)
local v10 = {}

v10[1] = Color3.new(0.8313725590705872, 0.6627451181411743, 0.27843138575553894)
v10[2] = 40
v5[1] = v7
v5[2] = v9
v5[3] = table.freeze(v10)
v2.PossibleModelColors = table.freeze(v5)
v2.WalkSound = table.freeze({
    SoundId = 90254063844163,
    Data = table.freeze({
        Looped = true,
        MaxDistance = 20,
        Speed = 1,
        Volume = 1.5
    })
})
v2.RandomIdleSound = table.freeze({
    SoundId = 84280229253205,
    Data = table.freeze({
        MaxDistance = 20,
        Volume = 1.5
    })
})
return (table.freeze(v2))
