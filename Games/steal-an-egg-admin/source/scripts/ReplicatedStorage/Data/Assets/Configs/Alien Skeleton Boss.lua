-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rarity = require(ReplicatedStorage.Data.Rarity)

local function makeAnimation(v1) -- line 6
    local Animation = Instance.new("Animation")
    if not pcall(function() -- line 8 | captures: v1, Animation
            Animation.AnimationId = v1
        end) then
        warn((("Animation %* is not shared with this experience"):format(v1)))
    end
    return Animation
end

local v2 = {
    _id = "Alien Skeleton Boss",
    DisplayName = "Cosmic Skeleton Boss",
    Icon = "rbxassetid://126032307148071",
    EarningRate = 45000000,
    IndexSpeedReward = 1680000,
    DropWeight = 0.1,
    VisualOdds = 5266356515000.135,
    ModelWeight = 1000,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    GenderLocked = "Male",
    Egg = table.freeze({
        DisplayName = "Cosmic Skeleton Boss Egg",
        Icon = "rbxassetid://102395451894667",
        GrowthTime = 9000,
        WeightKg = 8
    })
}
local v3 = {}
local v4 = Instance.new("Animation")

if not pcall(function() -- line 34 | captures: v4
        v4.AnimationId = "rbxassetid://131160350870352"
    end) then
    warn("Animation rbxassetid://131160350870352 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 43 | captures: Animation
        Animation.AnimationId = "rbxassetid://116519216488649"
    end) then
    warn("Animation rbxassetid://116519216488649 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Secret
v2.BaseModelColor = Color3.new(0.10588235408067703, 0.16470588743686676, 0.2078431397676468)

local v5 = {}
local v6 = {}

v6[1] = Color3.new(0.10588235408067703, 0.16470588743686676, 0.2078431397676468)
v6[2] = 990

local v7 = table.freeze(v6)
local v8 = {}

v8[1] = Color3.new(1, 1, 1)
v8[2] = 10
v5[1] = v7
v5[2] = table.freeze(v8)
v2.PossibleModelColors = table.freeze(v5)
v2.WalkSound = table.freeze({
    SoundId = 119582858497406,
    Data = table.freeze({
        Looped = true,
        MaxDistance = 20,
        Speed = 1,
        Volume = 1.5
    })
})
v2.RandomIdleSound = table.freeze({
    SoundId = 127999900124417,
    Data = table.freeze({
        MaxDistance = 20,
        Volume = 1.5
    })
})
return (table.freeze(v2))
