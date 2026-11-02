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
    _id = "Sand Spider",
    DisplayName = "Sand Spider",
    Icon = "rbxassetid://70412724408814",
    EarningRate = 16000,
    IndexSpeedReward = 12600,
    DropWeight = 0.16666666666666666,
    VisualOdds = 53867.64527500001,
    ModelWeight = 120,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Sand Spider Egg",
        Icon = "rbxassetid://122421093207285",
        GrowthTime = 240,
        WeightKg = 3
    })
}
local v3 = {}
local v4 = Instance.new("Animation")

if not pcall(function() -- line 36 | captures: v4
        v4.AnimationId = "rbxassetid://113626384394088"
    end) then
    warn("Animation rbxassetid://113626384394088 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 45 | captures: Animation
        Animation.AnimationId = "rbxassetid://91893541862863"
    end) then
    warn("Animation rbxassetid://91893541862863 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Mythic
v2.BaseModelColor = Color3.new(0.5176470875740051, 0.4274509847164154, 0.2549019753932953)

local v5 = {}
local v6 = {}

v6[1] = Color3.new(0.5176470875740051, 0.4274509847164154, 0.2549019753932953)
v6[2] = 670

local v7 = table.freeze(v6)
local v8 = {}

v8[1] = Color3.new(0.5686274766921997, 0.4117647111415863, 0.2549019753932953)
v8[2] = 180

local v9 = table.freeze(v8)
local v10 = {}

v10[1] = Color3.new(0.8627451062202454, 0.7647058963775635, 0.5490196347236633)
v10[2] = 100

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
    SoundId = 137161165461759,
    Data = table.freeze({
        Looped = true,
        MaxDistance = 20,
        Speed = 1,
        Volume = 1.5
    })
})
v2.RandomIdleSound = table.freeze({
    SoundId = 71619933675914,
    Data = table.freeze({
        MaxDistance = 20,
        Volume = 1.5
    })
})
return (table.freeze(v2))
