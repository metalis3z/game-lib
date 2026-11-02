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
    _id = "Bananita Dolphinita",
    DisplayName = "Bananita Dolphinita",
    Icon = "rbxassetid://99962600313926",
    EarningRate = 400,
    IndexSpeedReward = 710,
    DropWeight = 0.26,
    VisualOdds = 3.8461538461538463,
    ModelWeight = 300,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Bananita Dolphinita Egg",
        Icon = "rbxassetid://139937203160382",
        GrowthTime = 35,
        WeightKg = 6,
        HideRarity = true
    })
}
local v3 = {}
local v4 = Instance.new("Animation")

if not pcall(function() -- line 42 | captures: v4
        v4.AnimationId = "rbxassetid://109038087005456"
    end) then
    warn("Animation rbxassetid://109038087005456 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 51 | captures: Animation
        Animation.AnimationId = "rbxassetid://130886171019138"
    end) then
    warn("Animation rbxassetid://130886171019138 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Epic
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
    SoundId = 97253287014672,
    Data = table.freeze({
        Looped = true,
        MaxDistance = 20,
        Speed = 1,
        Volume = 1.5
    })
})
v2.RandomIdleSound = table.freeze({
    SoundId = 83977433345328,
    Data = table.freeze({
        MaxDistance = 20,
        Volume = 1.5
    })
})
return (table.freeze(v2))
