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
    _id = "Chimpanzee",
    DisplayName = "Chimpanzee",
    Icon = "rbxassetid://74635759656969",
    EarningRate = 90,
    IndexSpeedReward = 7200,
    DropWeight = 0,
    VisualOdds = 190000,
    ModelWeight = 65,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Chimpanzee Egg",
        Icon = "rbxassetid://134992089982715",
        GrowthTime = 30,
        WeightKg = 3
    })
}
local v3 = {}
local v4 = Instance.new("Animation")

if not pcall(function() -- line 36 | captures: v4
        v4.AnimationId = "rbxassetid://116041684311549"
    end) then
    warn("Animation rbxassetid://116041684311549 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 45 | captures: Animation
        Animation.AnimationId = "rbxassetid://93274789936972"
    end) then
    warn("Animation rbxassetid://93274789936972 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Rare
v2.BaseModelColor = Color3.new(0.33725491166114807, 0.2235294133424759, 0.14509804546833038)

local v5 = {}
local v6 = {}

v6[1] = Color3.new(0.33725491166114807, 0.2235294133424759, 0.14509804546833038)
v6[2] = 650

local v7 = table.freeze(v6)
local v8 = {}

v8[1] = Color3.new(0.21568627655506134, 0.16470588743686676, 0.125490203499794)
v8[2] = 180

local v9 = table.freeze(v8)
local v10 = {}

v10[1] = Color3.new(0.47058823704719543, 0.3333333432674408, 0.21568627655506134)
v10[2] = 125

local v11 = table.freeze(v10)
local v12 = {}

v12[1] = Color3.new(0.6078431606292725, 0.4901960790157318, 0.37254902720451355)
v12[2] = 45

local v13 = table.freeze(v12)
local v14 = {}

v14[1] = Color3.new(1, 1, 1)
v14[2] = 10
v5[1] = v7
v5[2] = v9
v5[3] = v11
v5[4] = v13
v5[5] = table.freeze(v14)
v2.PossibleModelColors = table.freeze(v5)
v2.WalkSound = table.freeze({
    SoundId = 76308946586160,
    Data = table.freeze({
        Looped = true,
        MaxDistance = 20,
        Speed = 1,
        Volume = 1.5
    })
})
v2.RandomIdleSound = table.freeze({
    SoundId = 102628736600319,
    Data = table.freeze({
        MaxDistance = 20,
        Volume = 1.5
    })
})
return (table.freeze(v2))
