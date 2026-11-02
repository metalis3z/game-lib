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
    _id = "Rhino",
    DisplayName = "Rhinotaur",
    Icon = "rbxassetid://80226955825306",
    EarningRate = 17500000,
    IndexSpeedReward = 3091608,
    DropWeight = 0,
    VisualOdds = 2500000000000,
    ModelWeight = 35000,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Rhinotaur Egg",
        Icon = "rbxassetid://94856871321711",
        GrowthTime = 1740,
        WeightKg = 2
    })
}
local v3 = {}
local v4 = Instance.new("Animation")

if not pcall(function() -- line 36 | captures: v4
        v4.AnimationId = "rbxassetid://83474371744190"
    end) then
    warn("Animation rbxassetid://83474371744190 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 45 | captures: Animation
        Animation.AnimationId = "rbxassetid://91380346644326"
    end) then
    warn("Animation rbxassetid://91380346644326 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Cosmic
v2.BaseModelColor = Color3.new(0.23137255012989044, 0.21960784494876862, 0.23137255012989044)

local v5 = {}
local v6 = {}

v6[1] = Color3.new(0.23137255012989044, 0.21960784494876862, 0.23137255012989044)
v6[2] = 850

local v7 = table.freeze(v6)
local v8 = {}

v8[1] = Color3.new(0.27450981736183167, 0.21568627655506134, 0.1764705926179886)
v8[2] = 90

local v9 = table.freeze(v8)
local v10 = {}

v10[1] = Color3.new(0.19607843458652496, 0.2549019753932953, 0.21568627655506134)
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
