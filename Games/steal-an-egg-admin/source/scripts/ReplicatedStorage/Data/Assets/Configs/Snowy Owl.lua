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
    _id = "Snowy Owl",
    DisplayName = "Snowy Owl",
    Icon = "rbxassetid://131965186730050",
    EarningRate = 7500000,
    IndexSpeedReward = 3778632,
    DropWeight = 0,
    VisualOdds = 1724000000000,
    ModelWeight = 20,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Snowy Owl Egg",
        Icon = "rbxassetid://118563170214834",
        GrowthTime = 900,
        WeightKg = 2
    })
}
local v3 = {}
local v4 = Instance.new("Animation")

if not pcall(function() -- line 36 | captures: v4
        v4.AnimationId = "rbxassetid://127934535949532"
    end) then
    warn("Animation rbxassetid://127934535949532 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 45 | captures: Animation
        Animation.AnimationId = "rbxassetid://94387629411885"
    end) then
    warn("Animation rbxassetid://94387629411885 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Cosmic
v2.BaseModelColor = Color3.new(0.8156862854957581, 0.7921568751335144, 0.7215686440467834)

local v5 = {}
local v6 = {}

v6[1] = Color3.new(0.8156862854957581, 0.7921568751335144, 0.7215686440467834)
v6[2] = 850

local v7 = table.freeze(v6)
local v8 = {}

v8[1] = Color3.new(0.6666666865348816, 0.529411792755127, 0.37254902720451355)
v8[2] = 90

local v9 = table.freeze(v8)
local v10 = {}

v10[1] = Color3.new(0.47058823704719543, 0.47058823704719543, 0.4901960790157318)
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
    SoundId = 112958966421431,
    Data = table.freeze({
        Looped = true,
        MaxDistance = 20,
        Speed = 1,
        Volume = 1.5
    })
})
return (table.freeze(v2))
