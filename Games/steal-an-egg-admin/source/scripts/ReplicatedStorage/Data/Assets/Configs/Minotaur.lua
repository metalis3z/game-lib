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
    _id = "Minotaur",
    DisplayName = "Minotaur",
    Icon = "rbxassetid://130702120729224",
    EarningRate = 40000000,
    IndexSpeedReward = 3000000,
    DropWeight = 0,
    VisualOdds = 10,
    ModelWeight = 55000,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    DontRoll = true,
    Egg = table.freeze({
        DisplayName = "Demonic Egg",
        Icon = "rbxassetid://128770392825945",
        GrowthTime = 82800,
        WeightKg = 12
    })
}
local v3 = {}
local v4 = Instance.new("Animation")

if not pcall(function() -- line 37 | captures: v4
        v4.AnimationId = "rbxassetid://102296038955980"
    end) then
    warn("Animation rbxassetid://102296038955980 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 46 | captures: Animation
        Animation.AnimationId = "rbxassetid://87806786946178"
    end) then
    warn("Animation rbxassetid://87806786946178 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Secret
v2.BaseModelColor = Color3.new(0.4000000059604645, 0.24705882370471954, 0.18431372940540314)

local v5 = {}
local v6 = {}

v6[1] = Color3.new(0.4000000059604645, 0.24705882370471954, 0.18431372940540314)
v6[2] = 1000
v5[1] = table.freeze(v6)
v2.PossibleModelColors = table.freeze(v5)
return (table.freeze(v2))
