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
    _id = "Chicken",
    DisplayName = "Chicken",
    Icon = "rbxassetid://87733160598688",
    EarningRate = 1,
    IndexSpeedReward = 420,
    DropWeight = 0.5,
    VisualOdds = 2.154706,
    ModelWeight = 8,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Chicken Egg",
        Icon = "rbxassetid://133004694392561",
        GrowthTime = 10,
        WeightKg = 1
    })
}
local v3 = {}
local v4 = Instance.new("Animation")

if not pcall(function() -- line 36 | captures: v4
        v4.AnimationId = "rbxassetid://118453375095154"
    end) then
    warn("Animation rbxassetid://118453375095154 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 45 | captures: Animation
        Animation.AnimationId = "rbxassetid://118524051414603"
    end) then
    warn("Animation rbxassetid://118524051414603 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Common
v2.BaseModelColor = Color3.new(0.9725490212440491, 0.9725490212440491, 0.9725490212440491)

local v5 = {}
local v6 = {}

v6[1] = Color3.new(0.9725490212440491, 0.9725490212440491, 0.9725490212440491)
v6[2] = 760

local v7 = table.freeze(v6)
local v8 = {}

v8[1] = Color3.new(0.9019607901573181, 0.8235294222831726, 0.6274510025978088)
v8[2] = 120
v5[1] = v7
v5[2] = table.freeze(v8)
v2.PossibleModelColors = table.freeze(v5)
v2.WalkSound = table.freeze({
    SoundId = 113637185713855,
    Data = table.freeze({
        Looped = true,
        MaxDistance = 20,
        Speed = 1,
        Volume = 2
    })
})
return (table.freeze(v2))
