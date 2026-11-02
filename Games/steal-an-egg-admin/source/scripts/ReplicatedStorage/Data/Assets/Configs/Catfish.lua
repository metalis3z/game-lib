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
    _id = "Catfish",
    DisplayName = "Catfish",
    Icon = "rbxassetid://137813424891388",
    EarningRate = 12,
    IndexSpeedReward = 2500,
    DropWeight = 0.5,
    VisualOdds = 262.769001,
    ModelWeight = 35,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Catfish Egg",
        Icon = "rbxassetid://79651367855993",
        GrowthTime = 30,
        WeightKg = 2
    })
}
local v3 = {}
local v4 = Instance.new("Animation")

if not pcall(function() -- line 36 | captures: v4
        v4.AnimationId = "rbxassetid://136763053900057"
    end) then
    warn("Animation rbxassetid://136763053900057 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 45 | captures: Animation
        Animation.AnimationId = "rbxassetid://106016134642151"
    end) then
    warn("Animation rbxassetid://106016134642151 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Uncommon
v2.BaseModelColor = Color3.new(0.01568627543747425, 0.686274528503418, 0.9254902005195618)

local v5 = {}
local v6 = {}

v6[1] = Color3.new(0.01568627543747425, 0.686274528503418, 0.9254902005195618)
v6[2] = 470

local v7 = table.freeze(v6)
local v8 = {}

v8[1] = Color3.new(0.25882354378700256, 0.2705882489681244, 0.250980406999588)
v8[2] = 230

local v9 = table.freeze(v8)
local v10 = {}

v10[1] = Color3.new(0.2549019753932953, 0.23529411852359772, 0.19607843458652496)
v10[2] = 150

local v11 = table.freeze(v10)
local v12 = {}

v12[1] = Color3.new(0.45490196347236633, 1, 0.5921568870544434)
v12[2] = 100

local v13 = table.freeze(v12)
local v14 = {}

v14[1] = Color3.new(0.13725490868091583, 0.13725490868091583, 0.13725490868091583)
v14[2] = 50

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
v2.RandomIdleSound = table.freeze({
    SoundId = 116980148625296,
    Data = table.freeze({
        MaxDistance = 20,
        Volume = 1.5
    })
})
return (table.freeze(v2))
