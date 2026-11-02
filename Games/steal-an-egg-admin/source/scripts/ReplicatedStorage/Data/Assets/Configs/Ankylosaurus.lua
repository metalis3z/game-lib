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
    _id = "Ankylosaurus",
    DisplayName = "Ankylosaurus",
    Icon = "rbxassetid://132979891891560",
    EarningRate = 120000,
    IndexSpeedReward = 330000,
    DropWeight = 0.5,
    VisualOdds = 7778.721339,
    ModelWeight = 2500,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Ankylosaurus Egg",
        Icon = "rbxassetid://103179713771844",
        GrowthTime = 300,
        WeightKg = 2
    })
}
local v3 = {}
local v4 = Instance.new("Animation")

if not pcall(function() -- line 36 | captures: v4
        v4.AnimationId = "rbxassetid://130880255967207"
    end) then
    warn("Animation rbxassetid://130880255967207 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 45 | captures: Animation
        Animation.AnimationId = "rbxassetid://92090222773037"
    end) then
    warn("Animation rbxassetid://92090222773037 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Mythic
v2.BaseModelColor = Color3.new(0.3843137323856354, 0.3450980484485626, 0.364705890417099)

local v5 = {}
local v6 = {}

v6[1] = Color3.new(0.3843137323856354, 0.3450980484485626, 0.364705890417099)
v6[2] = 450

local v7 = table.freeze(v6)
local v8 = {}

v8[1] = Color3.new(0.37254902720451355, 0.3137255012989044, 0.23529411852359772)
v8[2] = 210

local v9 = table.freeze(v8)
local v10 = {}

v10[1] = Color3.new(0.3137255012989044, 0.37254902720451355, 0.2549019753932953)
v10[2] = 150

local v11 = table.freeze(v10)
local v12 = {}

v12[1] = Color3.new(0.5098039507865906, 0.45098039507865906, 0.3529411852359772)
v12[2] = 120

local v13 = table.freeze(v12)
local v14 = {}

v14[1] = Color3.new(0.21568627655506134, 0.21568627655506134, 0.21568627655506134)
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
    SoundId = 106821833753722,
    Data = table.freeze({
        Looped = true,
        MaxDistance = 20,
        Speed = 1,
        Volume = 1.5
    })
})
v2.RandomIdleSound = table.freeze({
    SoundId = 79516186764884,
    Data = table.freeze({
        MaxDistance = 20,
        Volume = 1.5
    })
})
return (table.freeze(v2))
