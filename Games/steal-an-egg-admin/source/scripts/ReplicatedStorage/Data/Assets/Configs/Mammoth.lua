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
    _id = "Mammoth",
    DisplayName = "Mammoth",
    Icon = "rbxassetid://72054098131730",
    EarningRate = 42000,
    IndexSpeedReward = 19200,
    DropWeight = 0,
    VisualOdds = 12000000,
    ModelWeight = 2000,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Mammoth Egg",
        Icon = "rbxassetid://88448405951568",
        GrowthTime = 300,
        WeightKg = 4
    })
}
local v3 = {}
local v4 = Instance.new("Animation")

if not pcall(function() -- line 36 | captures: v4
        v4.AnimationId = "rbxassetid://88404296318633"
    end) then
    warn("Animation rbxassetid://88404296318633 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 45 | captures: Animation
        Animation.AnimationId = "rbxassetid://88166868199113"
    end) then
    warn("Animation rbxassetid://88166868199113 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Mythic
v2.BaseModelColor = Color3.new(0.20392157137393951, 0.13333334028720856, 0.09019608050584793)

local v5 = {}
local v6 = {}

v6[1] = Color3.new(0.20392157137393951, 0.13333334028720856, 0.09019608050584793)
v6[2] = 620

local v7 = table.freeze(v6)
local v8 = {}

v8[1] = Color3.new(0.3529411852359772, 0.23529411852359772, 0.13725490868091583)
v8[2] = 210

local v9 = table.freeze(v8)
local v10 = {}

v10[1] = Color3.new(0.529411792755127, 0.37254902720451355, 0.21568627655506134)
v10[2] = 120

local v11 = table.freeze(v10)
local v12 = {}

v12[1] = Color3.new(0.7450980544090271, 0.6470588445663452, 0.4901960790157318)
v12[2] = 40

local v13 = table.freeze(v12)
local v14 = {}

v14[1] = Color3.new(0.10980392247438431, 0.09803921729326248, 0.08627451211214066)
v14[2] = 10

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
    SoundId = 105414352264761,
    Data = table.freeze({
        Looped = true,
        MaxDistance = 20,
        Speed = 1,
        Volume = 1.5
    })
})
v2.RandomIdleSound = table.freeze({
    SoundId = 122091287433205,
    Data = table.freeze({
        MaxDistance = 20,
        Volume = 1.5
    })
})
return (table.freeze(v2))
