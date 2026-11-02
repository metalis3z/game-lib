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
    _id = "Tung Tung Sahur",
    DisplayName = "Tung Tung Sahur",
    Icon = "rbxassetid://133341038169489",
    EarningRate = 100,
    IndexSpeedReward = 640,
    DropWeight = 0.4,
    VisualOdds = 2.5,
    ModelWeight = 35,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Tung Tung Sahur Egg",
        Icon = "rbxassetid://139937203160382",
        GrowthTime = 15,
        WeightKg = 6,
        HideRarity = true
    })
}
local v3 = {}
local v4 = Instance.new("Animation")

if not pcall(function() -- line 42 | captures: v4
        v4.AnimationId = "rbxassetid://94294531109007"
    end) then
    warn("Animation rbxassetid://94294531109007 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 51 | captures: Animation
        Animation.AnimationId = "rbxassetid://136990298536362"
    end) then
    warn("Animation rbxassetid://136990298536362 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Rare
v2.BaseModelColor = Color3.new(0.35686275362968445, 0.43529412150382996, 0.5058823823928833)

local v5 = {}
local v6 = {}

v6[1] = Color3.new(0.35686275362968445, 0.43529412150382996, 0.5058823823928833)
v6[2] = 990

local v7 = table.freeze(v6)
local v8 = {}

v8[1] = Color3.new(1, 1, 1)
v8[2] = 10
v5[1] = v7
v5[2] = table.freeze(v8)
v2.PossibleModelColors = table.freeze(v5)
v2.WalkSound = table.freeze({
    SoundId = 125666615533601,
    Data = table.freeze({
        Looped = true,
        MaxDistance = 20,
        Speed = 1,
        Volume = 1.5
    })
})
v2.RandomIdleSound = table.freeze({
    SoundId = 113701751779006,
    Data = table.freeze({
        MaxDistance = 20,
        Volume = 1.5
    })
})
return (table.freeze(v2))
