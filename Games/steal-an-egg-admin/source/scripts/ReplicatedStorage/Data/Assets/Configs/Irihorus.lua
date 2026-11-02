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
    _id = "Irihorus",
    DisplayName = "Royal Sphinx",
    Icon = "rbxassetid://120583937636646",
    EarningRate = 280000,
    IndexSpeedReward = 18000,
    DropWeight = 0.14285714285714285,
    VisualOdds = 86188.232439,
    ModelWeight = 4000,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Royal Sphinx Egg",
        Icon = "rbxassetid://102158231449811",
        GrowthTime = 1800,
        WeightKg = 3
    })
}
local v3 = {}
local v4 = Instance.new("Animation")

if not pcall(function() -- line 36 | captures: v4
        v4.AnimationId = "rbxassetid://100825634533827"
    end) then
    warn("Animation rbxassetid://100825634533827 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 45 | captures: Animation
        Animation.AnimationId = "rbxassetid://121407208433872"
    end) then
    warn("Animation rbxassetid://121407208433872 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Cosmic
v2.BaseModelColor = Color3.new(0.5098039507865906, 0.3921568691730499, 0.25882354378700256)

local v5 = {}
local v6 = {}

v6[1] = Color3.new(0.5098039507865906, 0.3921568691730499, 0.25882354378700256)
v6[2] = 850

local v7 = table.freeze(v6)
local v8 = {}

v8[1] = Color3.new(0.6470588445663452, 0.5098039507865906, 0.3137255012989044)
v8[2] = 100

local v9 = table.freeze(v8)
local v10 = {}

v10[1] = Color3.new(0.37254902720451355, 0.27450981736183167, 0.1764705926179886)
v10[2] = 50

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
    SoundId = 79014910220107,
    Data = table.freeze({
        Looped = true,
        MaxDistance = 20,
        Speed = 1,
        Volume = 1.5
    })
})
v2.RandomIdleSound = table.freeze({
    SoundId = 112285338118905,
    Data = table.freeze({
        MaxDistance = 20,
        Volume = 1.5
    })
})
return (table.freeze(v2))
