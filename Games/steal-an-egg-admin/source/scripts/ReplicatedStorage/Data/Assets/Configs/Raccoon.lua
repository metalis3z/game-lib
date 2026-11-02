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
    _id = "Raccoon",
    DisplayName = "Raccoon",
    Icon = "rbxassetid://108876887480947",
    EarningRate = 45,
    IndexSpeedReward = 620,
    DropWeight = 0.16666666666666666,
    VisualOdds = 8.44701453885662,
    ModelWeight = 19,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Raccoon Egg",
        Icon = "rbxassetid://119179522600617",
        GrowthTime = 50,
        WeightKg = 1
    })
}
local v3 = {}
local v4 = Instance.new("Animation")

if not pcall(function() -- line 36 | captures: v4
        v4.AnimationId = "rbxassetid://84324202203232"
    end) then
    warn("Animation rbxassetid://84324202203232 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 45 | captures: Animation
        Animation.AnimationId = "rbxassetid://75657260738691"
    end) then
    warn("Animation rbxassetid://75657260738691 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Rare
v2.BaseModelColor = Color3.new(0.35686275362968445, 0.364705890417099, 0.4117647111415863)

local v5 = {}
local v6 = {}

v6[1] = Color3.new(0.35686275362968445, 0.364705890417099, 0.4117647111415863)
v6[2] = 760

local v7 = table.freeze(v6)
local v8 = {}

v8[1] = Color3.new(0.2549019753932953, 0.2549019753932953, 0.27450981736183167)
v8[2] = 140

local v9 = table.freeze(v8)
local v10 = {}

v10[1] = Color3.new(0.5098039507865906, 0.4901960790157318, 0.45098039507865906)
v10[2] = 70

local v11 = table.freeze(v10)
local v12 = {}

v12[1] = Color3.new(0.25882354378700256, 0.250980406999588, 0.250980406999588)
v12[2] = 30

local v13 = table.freeze(v12)
local v14 = {}

v14[1] = Color3.new(1, 1, 1)
v14[2] = 12
v5[1] = v7
v5[2] = v9
v5[3] = v11
v5[4] = v13
v5[5] = table.freeze(v14)
v2.PossibleModelColors = table.freeze(v5)
v2.WalkSound = table.freeze({
    SoundId = 133892878002687,
    Data = table.freeze({
        Looped = true,
        MaxDistance = 20,
        Speed = 1,
        Volume = 1.5
    })
})
v2.RandomIdleSound = table.freeze({
    SoundId = 80656525949581,
    Data = table.freeze({
        MaxDistance = 20,
        Volume = 1.5
    })
})
return (table.freeze(v2))
