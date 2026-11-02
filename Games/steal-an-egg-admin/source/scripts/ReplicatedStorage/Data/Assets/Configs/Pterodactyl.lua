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
    _id = "Pterodactyl",
    DisplayName = "Pterodactyl",
    Icon = "rbxassetid://92643140066500",
    EarningRate = 22000,
    IndexSpeedReward = 270000,
    DropWeight = 0.5,
    VisualOdds = 215470.581098,
    ModelWeight = 180,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Pterodactyl Egg",
        Icon = "rbxassetid://88209726148785",
        GrowthTime = 180,
        WeightKg = 3
    })
}
local v3 = {}
local v4 = Instance.new("Animation")

if not pcall(function() -- line 36 | captures: v4
        v4.AnimationId = "rbxassetid://113067956636310"
    end) then
    warn("Animation rbxassetid://113067956636310 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 45 | captures: Animation
        Animation.AnimationId = "rbxassetid://134964461960138"
    end) then
    warn("Animation rbxassetid://134964461960138 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Legendary
v2.BaseModelColor = Color3.new(0.33725491166114807, 0.3137255012989044, 0.30588236451148987)

local v5 = {}
local v6 = {}

v6[1] = Color3.new(0.33725491166114807, 0.3137255012989044, 0.30588236451148987)
v6[2] = 520

local v7 = table.freeze(v6)
local v8 = {}

v8[1] = Color3.new(0.47058823704719543, 0.37254902720451355, 0.2549019753932953)
v8[2] = 180

local v9 = table.freeze(v8)
local v10 = {}

v10[1] = Color3.new(0.5882353186607361, 0.5098039507865906, 0.37254902720451355)
v10[2] = 130

local v11 = table.freeze(v10)
local v12 = {}

v12[1] = Color3.new(0.21568627655506134, 0.21568627655506134, 0.23529411852359772)
v12[2] = 100

local v13 = table.freeze(v12)
local v14 = {}

v14[1] = Color3.new(0.37254902720451355, 0.4117647111415863, 0.45098039507865906)
v14[2] = 70

local v15 = table.freeze(v14)
local v16 = {}

v16[1] = Color3.new(1, 1, 1)
v16[2] = 10
v5[1] = v7
v5[2] = v9
v5[3] = v11
v5[4] = v13
v5[5] = v15
v5[6] = table.freeze(v16)
v2.PossibleModelColors = table.freeze(v5)
v2.WalkSound = table.freeze({
    SoundId = 116970148707359,
    Data = table.freeze({
        Looped = true,
        MaxDistance = 20,
        Speed = 1,
        Volume = 1.5
    })
})
v2.RandomIdleSound = table.freeze({
    SoundId = 102155485475316,
    Data = table.freeze({
        MaxDistance = 20,
        Volume = 1.5
    })
})
return (table.freeze(v2))
