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
    _id = "Red Panda",
    DisplayName = "Red Panda",
    Icon = "rbxassetid://84103693170055",
    EarningRate = 450000,
    IndexSpeedReward = 3435120,
    DropWeight = 0,
    VisualOdds = 2500000000000,
    ModelWeight = 25,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Red Panda Egg",
        Icon = "rbxassetid://129024376616157",
        GrowthTime = 480,
        WeightKg = 2
    })
}
local v3 = {}
local v4 = Instance.new("Animation")

if not pcall(function() -- line 36 | captures: v4
        v4.AnimationId = "rbxassetid://88810959597944"
    end) then
    warn("Animation rbxassetid://88810959597944 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 45 | captures: Animation
        Animation.AnimationId = "rbxassetid://70570646760776"
    end) then
    warn("Animation rbxassetid://70570646760776 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Mythic
v2.BaseModelColor = Color3.new(0.8392156958580017, 0.3843137323856354, 0.14901961386203766)

local v5 = {}
local v6 = {}

v6[1] = Color3.new(0.8392156958580017, 0.3843137323856354, 0.14901961386203766)
v6[2] = 850

local v7 = table.freeze(v6)
local v8 = {}

v8[1] = Color3.new(0.6274510025978088, 0.27450981736183167, 0.11764705926179886)
v8[2] = 90

local v9 = table.freeze(v8)
local v10 = {}

v10[1] = Color3.new(0.8823529481887817, 0.5882353186607361, 0.3137255012989044)
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
    SoundId = 85810173012807,
    Data = table.freeze({
        Looped = true,
        MaxDistance = 20,
        Speed = 1,
        Volume = 1.5
    })
})
return (table.freeze(v2))
