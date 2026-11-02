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
    _id = "Salamander",
    DisplayName = "Salamander",
    Icon = "rbxassetid://103927965710468",
    EarningRate = 74000,
    IndexSpeedReward = 3091608,
    DropWeight = 0,
    VisualOdds = 2500000000000,
    ModelWeight = 30,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Salamander Egg",
        Icon = "rbxassetid://118979503008914",
        GrowthTime = 300,
        WeightKg = 2
    })
}
local v3 = {}
local v4 = Instance.new("Animation")

if not pcall(function() -- line 36 | captures: v4
        v4.AnimationId = "rbxassetid://88996968666577"
    end) then
    warn("Animation rbxassetid://88996968666577 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 45 | captures: Animation
        Animation.AnimationId = "rbxassetid://110709812264538"
    end) then
    warn("Animation rbxassetid://110709812264538 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Legendary
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
v2.WalkSound = table.freeze({
    SoundId = 123189281925096,
    Data = table.freeze({
        Looped = true,
        MaxDistance = 20,
        Speed = 1,
        Volume = 1.5
    })
})
return (table.freeze(v2))
