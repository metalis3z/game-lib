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
    _id = "Cyclops Gorilla",
    DisplayName = "Cosmic Gorilla",
    Icon = "rbxassetid://94290378980560",
    EarningRate = 180000,
    IndexSpeedReward = 1200000,
    DropWeight = 0.2,
    VisualOdds = 1723764648784.246,
    ModelWeight = 450,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Cosmic Gorilla Egg",
        Icon = "rbxassetid://116039419189340",
        GrowthTime = 420,
        WeightKg = 8
    })
}
local v3 = {}
local v4 = Instance.new("Animation")

if not pcall(function() -- line 36 | captures: v4
        v4.AnimationId = "rbxassetid://125673064526127"
    end) then
    warn("Animation rbxassetid://125673064526127 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 45 | captures: Animation
        Animation.AnimationId = "rbxassetid://94007456460334"
    end) then
    warn("Animation rbxassetid://94007456460334 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Mythic
v2.BaseModelColor = Color3.new(0.3921568691730499, 0.4000000059604645, 0.5803921818733215)

local v5 = {}
local v6 = {}

v6[1] = Color3.new(0.3921568691730499, 0.4000000059604645, 0.5803921818733215)
v6[2] = 990

local v7 = table.freeze(v6)
local v8 = {}

v8[1] = Color3.new(1, 1, 1)
v8[2] = 10
v5[1] = v7
v5[2] = table.freeze(v8)
v2.PossibleModelColors = table.freeze(v5)
v2.WalkSound = table.freeze({
    SoundId = 130034638862991,
    Data = table.freeze({
        Looped = true,
        MaxDistance = 20,
        Speed = 1,
        Volume = 1.5
    })
})
v2.RandomIdleSound = table.freeze({
    SoundId = 77276574352426,
    Data = table.freeze({
        MaxDistance = 20,
        Volume = 1.5
    })
})
return (table.freeze(v2))
