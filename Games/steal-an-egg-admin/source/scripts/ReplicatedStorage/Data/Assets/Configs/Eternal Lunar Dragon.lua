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
    _id = "Eternal Lunar Dragon",
    DisplayName = "Eternal Lunar Dragon",
    Icon = "rbxassetid://78672993667680",
    EarningRate = 250000000,
    IndexSpeedReward = 1920000,
    DropWeight = 20,
    VisualOdds = 28729410813070.773,
    ModelWeight = 60000,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Eternal Lunar Dragon Egg",
        Icon = "rbxassetid://76095389378180",
        GrowthTime = 25200,
        WeightKg = 9
    })
}
local v3 = {}
local v4 = Instance.new("Animation")

if not pcall(function() -- line 36 | captures: v4
        v4.AnimationId = "rbxassetid://114101129760631"
    end) then
    warn("Animation rbxassetid://114101129760631 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 45 | captures: Animation
        Animation.AnimationId = "rbxassetid://107228311393999"
    end) then
    warn("Animation rbxassetid://107228311393999 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Eternal
v2.BaseModelColor = Color3.new(0.10588235408067703, 0.16470588743686676, 0.2078431397676468)

local v5 = {}
local v6 = {}

v6[1] = Color3.new(0.10588235408067703, 0.16470588743686676, 0.2078431397676468)
v6[2] = 700

local v7 = table.freeze(v6)
local v8 = {}

v8[1] = Color3.new(0.1921568661928177, 0.2078431397676468, 0.27843138575553894)
v8[2] = 200

local v9 = table.freeze(v8)
local v10 = {}

v10[1] = Color3.new(0.20000000298023224, 0.23137255012989044, 0.23529411852359772)
v10[2] = 100

local v11 = table.freeze(v10)
local v12 = {}

v12[1] = Color3.new(1, 1, 1)
v12[2] = 12
v5[1] = v7
v5[2] = v9
v5[3] = v11
v5[4] = table.freeze(v12)
v2.PossibleModelColors = table.freeze(v5)
v2.WalkSound = table.freeze({
    SoundId = 138151886365111,
    Data = table.freeze({
        Looped = true,
        MaxDistance = 20,
        Speed = 1,
        Volume = 1.5
    })
})
v2.RandomIdleSound = table.freeze({
    SoundId = 80361709197851,
    Data = table.freeze({
        MaxDistance = 20,
        Volume = 1.5
    })
})
return (table.freeze(v2))
