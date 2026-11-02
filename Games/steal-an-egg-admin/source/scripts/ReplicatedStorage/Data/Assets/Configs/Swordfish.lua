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
    _id = "Swordfish",
    DisplayName = "Swordfish",
    Icon = "rbxassetid://103426699196063",
    EarningRate = 1100,
    IndexSpeedReward = 81000,
    DropWeight = 0.5,
    VisualOdds = 4910446705.478001,
    ModelWeight = 250,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Swordfish Egg",
        Icon = "rbxassetid://108314641239947",
        GrowthTime = 120,
        WeightKg = 6
    })
}
local v3 = {}
local v4 = Instance.new("Animation")

if not pcall(function() -- line 36 | captures: v4
        v4.AnimationId = "rbxassetid://138709577771363"
    end) then
    warn("Animation rbxassetid://138709577771363 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 45 | captures: Animation
        Animation.AnimationId = "rbxassetid://116265566227895"
    end) then
    warn("Animation rbxassetid://116265566227895 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Epic
v2.BaseModelColor = Color3.new(0.22745098173618317, 0.2980392277240753, 0.38823530077934265)

local v5 = {}
local v6 = {}

v6[1] = Color3.new(0.22745098173618317, 0.2980392277240753, 0.38823530077934265)
v6[2] = 650

local v7 = table.freeze(v6)
local v8 = {}

v8[1] = Color3.new(0.4313725531101227, 0.572549045085907, 0.7098039388656616)
v8[2] = 170

local v9 = table.freeze(v8)
local v10 = {}

v10[1] = Color3.new(0.13725490868091583, 0.21568627655506134, 0.3333333432674408)
v10[2] = 120

local v11 = table.freeze(v10)
local v12 = {}

v12[1] = Color3.new(0.09803921729326248, 0.13725490868091583, 0.21568627655506134)
v12[2] = 15

local v13 = table.freeze(v12)
local v14 = {}

v14[1] = Color3.new(1, 1, 1)
v14[2] = 10
v5[1] = v7
v5[2] = v9
v5[3] = v11
v5[4] = v13
v5[5] = table.freeze(v14)
v2.PossibleModelColors = table.freeze(v5)
v2.RandomIdleSound = table.freeze({
    SoundId = 103128081429287,
    Data = table.freeze({
        MaxDistance = 20,
        Volume = 1.5
    })
})
return (table.freeze(v2))
