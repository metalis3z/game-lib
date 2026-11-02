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
    _id = "Duckling",
    DisplayName = "Duckling",
    Icon = "rbxassetid://81116137079823",
    EarningRate = 4,
    IndexSpeedReward = 2250,
    DropWeight = 0,
    VisualOdds = 190,
    ModelWeight = 3,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Duckling Egg",
        Icon = "rbxassetid://81777724258949",
        GrowthTime = 20,
        WeightKg = 2
    })
}
local v3 = {}
local v4 = Instance.new("Animation")

if not pcall(function() -- line 36 | captures: v4
        v4.AnimationId = "rbxassetid://73183092847504"
    end) then
    warn("Animation rbxassetid://73183092847504 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 45 | captures: Animation
        Animation.AnimationId = "rbxassetid://106652360052040"
    end) then
    warn("Animation rbxassetid://106652360052040 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Common
v2.BaseModelColor = Color3.new(0.5098039507865906, 0.4941176474094391, 0.32156863808631897)

local v5 = {}
local v6 = {}

v6[1] = Color3.new(0.5098039507865906, 0.4941176474094391, 0.32156863808631897)
v6[2] = 360

local v7 = table.freeze(v6)
local v8 = {}

v8[1] = Color3.new(1, 0.7921568751335144, 0.47843137383461)
v8[2] = 480

local v9 = table.freeze(v8)
local v10 = {}

v10[1] = Color3.new(0.37254902720451355, 0.29411765933036804, 0.1764705926179886)
v10[2] = 80

local v11 = table.freeze(v10)
local v12 = {}

v12[1] = Color3.new(0.9607843160629272, 0.9215686321258545, 0.7058823704719543)
v12[2] = 60

local v13 = table.freeze(v12)
local v14 = {}

v14[1] = Color3.new(0.23529411852359772, 0.21568627655506134, 0.1764705926179886)
v14[2] = 20

local v15 = table.freeze(v14)
local v16 = {}

v16[1] = Color3.new(1, 1, 1)
v16[2] = 20
v5[1] = v7
v5[2] = v9
v5[3] = v11
v5[4] = v13
v5[5] = v15
v5[6] = table.freeze(v16)
v2.PossibleModelColors = table.freeze(v5)
v2.WalkSound = table.freeze({
    SoundId = 132569427692636,
    Data = table.freeze({
        Looped = true,
        MaxDistance = 20,
        Speed = 1,
        Volume = 1.9
    })
})
v2.RandomIdleSound = table.freeze({
    SoundId = 128566291793682,
    Data = table.freeze({
        MaxDistance = 20,
        Volume = 1.5
    })
})
return (table.freeze(v2))
