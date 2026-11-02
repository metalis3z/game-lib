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
    _id = "Void Dragon",
    DisplayName = "Void Dragon",
    Icon = "rbxassetid://108642175549864",
    EarningRate = 120000000,
    IndexSpeedReward = 40000,
    DropWeight = 0,
    VisualOdds = 5000,
    ModelWeight = 12000,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    DontRoll = true,
    Egg = table.freeze({
        DisplayName = "Dragon Egg",
        Icon = "rbxassetid://105587107333631",
        GrowthTime = 60,
        WeightKg = 5
    })
}
local v3 = {}
local v4 = Instance.new("Animation")

if not pcall(function() -- line 37 | captures: v4
        v4.AnimationId = "rbxassetid://102807046002909"
    end) then
    warn("Animation rbxassetid://102807046002909 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 46 | captures: Animation
        Animation.AnimationId = "rbxassetid://112183148174922"
    end) then
    warn("Animation rbxassetid://112183148174922 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Eternal
v2.BaseModelColor = Color3.new(0.19607843458652496, 0.1568627506494522, 0.27450981736183167)

local v5 = {}
local v6 = {}

v6[1] = Color3.new(0.19607843458652496, 0.1568627506494522, 0.27450981736183167)
v6[2] = 700

local v7 = table.freeze(v6)
local v8 = {}

v8[1] = Color3.new(0.35686275362968445, 0.239215686917305, 0.4588235318660736)
v8[2] = 180

local v9 = table.freeze(v8)
local v10 = {}

v10[1] = Color3.new(0.5490196347236633, 0.35686275362968445, 0.6235294342041016)
v10[2] = 108

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
    SoundId = 131092059995772,
    Data = table.freeze({
        Looped = true,
        MaxDistance = 20,
        Speed = 0.97,
        Volume = 1.5
    })
})
return (table.freeze(v2))
