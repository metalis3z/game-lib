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
    _id = "Burrowing Owl",
    DisplayName = "Burrowing Owl",
    Icon = "rbxassetid://123516361239872",
    EarningRate = 35,
    IndexSpeedReward = 560,
    DropWeight = 0.2,
    VisualOdds = 6.484806179286864,
    ModelWeight = 8,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Burrowing Owl Egg",
        Icon = "rbxassetid://96603112916917",
        GrowthTime = 40,
        WeightKg = 1
    })
}
local v3 = {}
local v4 = Instance.new("Animation")

if not pcall(function() -- line 36 | captures: v4
        v4.AnimationId = "rbxassetid://110866993212332"
    end) then
    warn("Animation rbxassetid://110866993212332 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 45 | captures: Animation
        Animation.AnimationId = "rbxassetid://82371248555357"
    end) then
    warn("Animation rbxassetid://82371248555357 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Rare
v2.BaseModelColor = Color3.new(0.3450980484485626, 0.2980392277240753, 0.2078431397676468)

local v5 = {}
local v6 = {}

v6[1] = Color3.new(0.3450980484485626, 0.2980392277240753, 0.2078431397676468)
v6[2] = 720

local v7 = table.freeze(v6)
local v8 = {}

v8[1] = Color3.new(0.4901960790157318, 0.4117647111415863, 0.27450981736183167)
v8[2] = 170

local v9 = table.freeze(v8)
local v10 = {}

v10[1] = Color3.new(0.2549019753932953, 0.22745098173618317, 0.1764705926179886)
v10[2] = 75

local v11 = table.freeze(v10)
local v12 = {}

v12[1] = Color3.new(0.47058823704719543, 0.4117647111415863, 0.29019609093666077)
v12[2] = 35

local v13 = table.freeze(v12)
local v14 = {}

v14[1] = Color3.new(1, 1, 1)
v14[2] = 15
v5[1] = v7
v5[2] = v9
v5[3] = v11
v5[4] = v13
v5[5] = table.freeze(v14)
v2.PossibleModelColors = table.freeze(v5)
v2.WalkSound = table.freeze({
    SoundId = 119647441340351,
    Data = table.freeze({
        Looped = true,
        MaxDistance = 20,
        Speed = 1,
        Volume = 1.5
    })
})
v2.RandomIdleSound = table.freeze({
    SoundId = 81165768086213,
    Data = table.freeze({
        MaxDistance = 20,
        Volume = 1.5
    })
})
return (table.freeze(v2))
