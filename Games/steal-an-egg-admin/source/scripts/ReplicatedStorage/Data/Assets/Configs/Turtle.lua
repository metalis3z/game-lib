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
    _id = "Turtle",
    DisplayName = "Turtle",
    Icon = "rbxassetid://90736612624734",
    EarningRate = 60,
    IndexSpeedReward = 2750,
    DropWeight = 0.3333333333333333,
    VisualOdds = 349.30572063219404,
    ModelWeight = 100,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Turtle Egg",
        Icon = "rbxassetid://87685717325235",
        GrowthTime = 50,
        WeightKg = 2
    })
}
local v3 = {}
local v4 = Instance.new("Animation")

if not pcall(function() -- line 36 | captures: v4
        v4.AnimationId = "rbxassetid://81296040721286"
    end) then
    warn("Animation rbxassetid://81296040721286 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 45 | captures: Animation
        Animation.AnimationId = "rbxassetid://77106208322796"
    end) then
    warn("Animation rbxassetid://77106208322796 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Rare
v2.BaseModelColor = Color3.new(0.364705890417099, 0.5254902243614197, 0.239215686917305)

local v5 = {}
local v6 = {}

v6[1] = Color3.new(0.364705890417099, 0.5254902243614197, 0.239215686917305)
v6[2] = 560

local v7 = table.freeze(v6)
local v8 = {}

v8[1] = Color3.new(0.3529411852359772, 0.3137255012989044, 0.1764705926179886)
v8[2] = 220

local v9 = table.freeze(v8)
local v10 = {}

v10[1] = Color3.new(0.23529411852359772, 0.37254902720451355, 0.21568627655506134)
v10[2] = 120

local v11 = table.freeze(v10)
local v12 = {}

v12[1] = Color3.new(0.5490196347236633, 0.45098039507865906, 0.2549019753932953)
v12[2] = 75

local v13 = table.freeze(v12)
local v14 = {}

v14[1] = Color3.new(0.1764705926179886, 0.19607843458652496, 0.13725490868091583)
v14[2] = 25

local v15 = table.freeze(v14)
local v16 = {}

v16[1] = Color3.new(1, 1, 1)
v16[2] = 15
v5[1] = v7
v5[2] = v9
v5[3] = v11
v5[4] = v13
v5[5] = v15
v5[6] = table.freeze(v16)
v2.PossibleModelColors = table.freeze(v5)
v2.WalkSound = table.freeze({
    SoundId = 88745368450239,
    Data = table.freeze({
        Looped = true,
        MaxDistance = 20,
        Speed = 1,
        Volume = 1.5
    })
})
return (table.freeze(v2))
