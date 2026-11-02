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
    _id = "Finned Thresher",
    DisplayName = "Shark",
    Icon = "rbxassetid://125497863961128",
    EarningRate = 15000,
    IndexSpeedReward = 90000,
    DropWeight = 0,
    VisualOdds = 9500000000,
    ModelWeight = 450,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Shark Egg",
        Icon = "rbxassetid://71615245424079",
        GrowthTime = 240,
        WeightKg = 6
    })
}
local v3 = {}
local v4 = Instance.new("Animation")

if not pcall(function() -- line 36 | captures: v4
        v4.AnimationId = "rbxassetid://138891911167325"
    end) then
    warn("Animation rbxassetid://138891911167325 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 45 | captures: Animation
        Animation.AnimationId = "rbxassetid://98595078545908"
    end) then
    warn("Animation rbxassetid://98595078545908 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Legendary
v2.BaseModelColor = Color3.new(0, 0.27843138575553894, 0.4274509847164154)

local v5 = {}
local v6 = {}

v6[1] = Color3.new(0, 0.27843138575553894, 0.4274509847164154)
v6[2] = 610

local v7 = table.freeze(v6)
local v8 = {}

v8[1] = Color3.new(0.1764705926179886, 0.29411765933036804, 0.3529411852359772)
v8[2] = 190

local v9 = table.freeze(v8)
local v10 = {}

v10[1] = Color3.new(0.0784313753247261, 0.1764705926179886, 0.27450981736183167)
v10[2] = 70

local v11 = table.freeze(v10)
local v12 = {}

v12[1] = Color3.new(1, 1, 1)
v12[2] = 10
v5[1] = v7
v5[2] = v9
v5[3] = v11
v5[4] = table.freeze(v12)
v2.PossibleModelColors = table.freeze(v5)
v2.RandomIdleSound = table.freeze({
    SoundId = 97519876501844,
    Data = table.freeze({
        MaxDistance = 20,
        Volume = 1.5
    })
})
return (table.freeze(v2))
