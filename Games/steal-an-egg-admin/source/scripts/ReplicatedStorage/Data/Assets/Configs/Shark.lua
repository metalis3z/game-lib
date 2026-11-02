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
    _id = "Shark",
    DisplayName = "Mutant Shark",
    Icon = "rbxassetid://132435731927862",
    EarningRate = 215000000,
    IndexSpeedReward = 4122144,
    DropWeight = 0,
    VisualOdds = 5266000000000,
    ModelWeight = 60000,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Mutant Shark Egg",
        Icon = "rbxassetid://109722826097480",
        GrowthTime = 10800,
        WeightKg = 3
    })
}
local v3 = {}
local v4 = Instance.new("Animation")

if not pcall(function() -- line 36 | captures: v4
        v4.AnimationId = "rbxassetid://104318976941512"
    end) then
    warn("Animation rbxassetid://104318976941512 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 45 | captures: Animation
        Animation.AnimationId = "rbxassetid://109985169326318"
    end) then
    warn("Animation rbxassetid://109985169326318 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Secret
v2.BaseModelColor = Color3.new(0.9490196108818054, 0.9529411792755127, 0.9529411792755127)

local v5 = {}
local v6 = {}

v6[1] = Color3.new(0.9490196108818054, 0.9529411792755127, 0.9529411792755127)
v6[2] = 850

local v7 = table.freeze(v6)
local v8 = {}

v8[1] = Color3.new(1, 0.8392156958580017, 0.47058823704719543)
v8[2] = 90

local v9 = table.freeze(v8)
local v10 = {}

v10[1] = Color3.new(0.4313725531101227, 0.4313725531101227, 0.47058823704719543)
v10[2] = 48

local v11 = table.freeze(v10)
local v12 = {}

v12[1] = Color3.new(1, 1, 1)
v12[2] = 12
v5[1] = v7
v5[2] = v9
v5[3] = v11
v5[4] = table.freeze(v12)
v2.PossibleModelColors = table.freeze(v5)
return (table.freeze(v2))
