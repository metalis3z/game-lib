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
    _id = "Cave Dragon",
    DisplayName = "Cosmic Dragon",
    Icon = "rbxassetid://83307181491796",
    EarningRate = 60000000,
    IndexSpeedReward = 1440000,
    DropWeight = 70,
    VisualOdds = 1141825743428080.3,
    ModelWeight = 15000,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Cosmic Dragon Egg",
        Icon = "rbxassetid://108447968078067",
        GrowthTime = 10800,
        WeightKg = 8
    })
}
local v3 = {}
local v4 = Instance.new("Animation")

if not pcall(function() -- line 36 | captures: v4
        v4.AnimationId = "rbxassetid://109841204463552"
    end) then
    warn("Animation rbxassetid://109841204463552 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 45 | captures: Animation
        Animation.AnimationId = "rbxassetid://86443111378998"
    end) then
    warn("Animation rbxassetid://86443111378998 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Secret
v2.BaseModelColor = Color3.new(0.10588235408067703, 0.16470588743686676, 0.2078431397676468)

local v5 = {}
local v6 = {}

v6[1] = Color3.new(0.10588235408067703, 0.16470588743686676, 0.2078431397676468)
v6[2] = 1000

local v7 = table.freeze(v6)
local v8 = {}

v8[1] = Color3.new(0.20392157137393951, 0.30980393290519714, 0.3333333432674408)
v8[2] = 200

local v9 = table.freeze(v8)
local v10 = {}

v10[1] = Color3.new(1, 1, 1)
v10[2] = 12
v5[1] = v7
v5[2] = v9
v5[3] = table.freeze(v10)
v2.PossibleModelColors = table.freeze(v5)
v2.WalkSound = table.freeze({
    SoundId = 94065626392735,
    Data = table.freeze({
        Looped = true,
        MaxDistance = 20,
        Speed = 1,
        Volume = 1.5
    })
})
v2.RandomIdleSound = table.freeze({
    SoundId = 117339625356547,
    Data = table.freeze({
        MaxDistance = 20,
        Volume = 1.5
    })
})
return (table.freeze(v2))
