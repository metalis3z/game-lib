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
    _id = "Mosasaurus",
    DisplayName = "Mosasaurus",
    Icon = "rbxassetid://123248563786924",
    EarningRate = 180000000,
    IndexSpeedReward = 600000,
    DropWeight = 0.55,
    VisualOdds = 2773109151.841,
    ModelWeight = 30000,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    AlbinosColorFullWhite = true,
    Egg = table.freeze({
        DisplayName = "Mosasaurus Egg",
        Icon = "rbxassetid://110731551346220",
        GrowthTime = 21600,
        WeightKg = 6
    })
}
local v3 = {}
local v4 = Instance.new("Animation")

if not pcall(function() -- line 37 | captures: v4
        v4.AnimationId = "rbxassetid://138479227728919"
    end) then
    warn("Animation rbxassetid://138479227728919 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 46 | captures: Animation
        Animation.AnimationId = "rbxassetid://92836491639161"
    end) then
    warn("Animation rbxassetid://92836491639161 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Eternal
v2.BaseModelColor = Color3.new(0.32156863808631897, 0.3686274588108063, 0.4941176474094391)

local v5 = {}
local v6 = {}

v6[1] = Color3.new(0.32156863808631897, 0.3686274588108063, 0.4941176474094391)
v6[2] = 540

local v7 = table.freeze(v6)
local v8 = {}

v8[1] = Color3.new(0.1764705926179886, 0.29411765933036804, 0.37254902720451355)
v8[2] = 190

local v9 = table.freeze(v8)
local v10 = {}

v10[1] = Color3.new(0.23529411852359772, 0.3333333432674408, 0.29411765933036804)
v10[2] = 120

local v11 = table.freeze(v10)
local v12 = {}

v12[1] = Color3.new(0.1568627506494522, 0.1764705926179886, 0.19607843458652496)
v12[2] = 100

local v13 = table.freeze(v12)
local v14 = {}

v14[1] = Color3.new(0.4588235318660736, 0.4000000059604645, 0.21176470816135406)
v14[2] = 120

local v15 = table.freeze(v14)
local v16 = {}

v16[1] = Color3.new(0.529411792755127, 0.5490196347236633, 0.529411792755127)
v16[2] = 50

local v17 = table.freeze(v16)
local v18 = {}

v18[1] = Color3.new(1, 0, 0)
v18[2] = 10

local v19 = table.freeze(v18)
local v20 = {}

v20[1] = Color3.new(1, 1, 1)
v20[2] = 10
v5[1] = v7
v5[2] = v9
v5[3] = v11
v5[4] = v13
v5[5] = v15
v5[6] = v17
v5[7] = v19
v5[8] = table.freeze(v20)
v2.PossibleModelColors = table.freeze(v5)
v2.RandomIdleSound = table.freeze({
    SoundId = 123495760504060,
    Data = table.freeze({
        MaxDistance = 20,
        Volume = 1.5
    })
})
return (table.freeze(v2))
