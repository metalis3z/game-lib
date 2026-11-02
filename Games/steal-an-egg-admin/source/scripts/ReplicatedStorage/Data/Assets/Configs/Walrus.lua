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
    _id = "Walrus",
    DisplayName = "Walrus",
    Icon = "rbxassetid://129141571024477",
    EarningRate = 600,
    IndexSpeedReward = 14400,
    DropWeight = 0.5,
    VisualOdds = 4788235.136,
    ModelWeight = 200,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Walrus Egg",
        Icon = "rbxassetid://81034642321828",
        GrowthTime = 60,
        WeightKg = 4
    })
}
local v3 = {}
local v4 = Instance.new("Animation")

if not pcall(function() -- line 36 | captures: v4
        v4.AnimationId = "rbxassetid://130043494088310"
    end) then
    warn("Animation rbxassetid://130043494088310 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 45 | captures: Animation
        Animation.AnimationId = "rbxassetid://83151101275731"
    end) then
    warn("Animation rbxassetid://83151101275731 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Epic
v2.BaseModelColor = Color3.new(0.46666666865348816, 0.4431372582912445, 0.41960784792900085)

local v5 = {}
local v6 = {}

v6[1] = Color3.new(0.46666666865348816, 0.4431372582912445, 0.41960784792900085)
v6[2] = 620

local v7 = table.freeze(v6)
local v8 = {}

v8[1] = Color3.new(0.4117647111415863, 0.3333333432674408, 0.27450981736183167)
v8[2] = 180

local v9 = table.freeze(v8)
local v10 = {}

v10[1] = Color3.new(0.6470588445663452, 0.5490196347236633, 0.47058823704719543)
v10[2] = 140

local v11 = table.freeze(v10)
local v12 = {}

v12[1] = Color3.new(0.7450980544090271, 0.6470588445663452, 0.5686274766921997)
v12[2] = 45

local v13 = table.freeze(v12)
local v14 = {}

v14[1] = Color3.new(0.27450981736183167, 0.23529411852359772, 0.21568627655506134)
v14[2] = 15

local v15 = table.freeze(v14)
local v16 = {}

v16[1] = Color3.new(0.27843138575553894, 0.3686274588108063, 0.615686297416687)
v16[2] = 7

local v17 = table.freeze(v16)
local v18 = {}

v18[1] = Color3.new(1, 1, 1)
v18[2] = 10
v5[1] = v7
v5[2] = v9
v5[3] = v11
v5[4] = v13
v5[5] = v15
v5[6] = v17
v5[7] = table.freeze(v18)
v2.PossibleModelColors = table.freeze(v5)
v2.WalkSound = table.freeze({
    SoundId = 93209551369966,
    Data = table.freeze({
        Looped = true,
        MaxDistance = 20,
        Speed = 1,
        Volume = 1.5
    })
})
return (table.freeze(v2))
