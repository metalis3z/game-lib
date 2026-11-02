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
    _id = "Gorilla",
    DisplayName = "Gorilla",
    Icon = "rbxassetid://81176247138562",
    EarningRate = 4800,
    IndexSpeedReward = 9900,
    DropWeight = 0.3333333333333333,
    VisualOdds = 294259.18734308693,
    ModelWeight = 190,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Gorilla Egg",
        Icon = "rbxassetid://125019217025479",
        GrowthTime = 120,
        WeightKg = 3
    })
}
local v3 = {}
local v4 = Instance.new("Animation")

if not pcall(function() -- line 36 | captures: v4
        v4.AnimationId = "rbxassetid://129672615000985"
    end) then
    warn("Animation rbxassetid://129672615000985 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 45 | captures: Animation
        Animation.AnimationId = "rbxassetid://103450539020124"
    end) then
    warn("Animation rbxassetid://103450539020124 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Legendary
v2.BaseModelColor = Color3.new(0.15294118225574493, 0.15294118225574493, 0.15294118225574493)

local v5 = {}
local v6 = {}

v6[1] = Color3.new(0.15294118225574493, 0.15294118225574493, 0.15294118225574493)
v6[2] = 720

local v7 = table.freeze(v6)
local v8 = {}

v8[1] = Color3.new(0.2549019753932953, 0.2549019753932953, 0.2549019753932953)
v8[2] = 180

local v9 = table.freeze(v8)
local v10 = {}

v10[1] = Color3.new(0.4117647111415863, 0.4117647111415863, 0.3921568691730499)
v10[2] = 80

local v11 = table.freeze(v10)
local v12 = {}

v12[1] = Color3.new(0.09803921729326248, 0.09803921729326248, 0.09803921729326248)
v12[2] = 20

local v13 = table.freeze(v12)
local v14 = {}

v14[1] = Color3.new(0.929411768913269, 0.9176470637321472, 0.9176470637321472)
v14[2] = 2
v5[1] = v7
v5[2] = v9
v5[3] = v11
v5[4] = v13
v5[5] = table.freeze(v14)
v2.PossibleModelColors = table.freeze(v5)
v2.WalkSound = table.freeze({
    SoundId = 103546776041964,
    Data = table.freeze({
        Looped = true,
        MaxDistance = 20,
        Speed = 1,
        Volume = 1.5
    })
})
v2.RandomIdleSound = table.freeze({
    SoundId = 100762379702055,
    Data = table.freeze({
        MaxDistance = 20,
        Volume = 1.5
    })
})
return (table.freeze(v2))
