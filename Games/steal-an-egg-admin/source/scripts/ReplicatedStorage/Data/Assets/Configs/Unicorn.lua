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
    _id = "Unicorn",
    DisplayName = "Unicorn",
    Icon = "rbxassetid://70463817382627",
    EarningRate = 1000000000,
    IndexSpeedReward = 2400000,
    DropWeight = 10,
    VisualOdds = 168336391482836.53,
    ModelWeight = 1200,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Unicorn Egg",
        Icon = "rbxassetid://126240842939586",
        GrowthTime = 43200,
        WeightKg = 10
    })
}
local v3 = {}
local v4 = Instance.new("Animation")

if not pcall(function() -- line 36 | captures: v4
        v4.AnimationId = "rbxassetid://100825123841453"
    end) then
    warn("Animation rbxassetid://100825123841453 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 45 | captures: Animation
        Animation.AnimationId = "rbxassetid://97124347474792"
    end) then
    warn("Animation rbxassetid://97124347474792 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Divine
v2.BaseModelColor = Color3.new(0.33725491166114807, 0.6274510025978088, 0.239215686917305)
v2.PossibleModelColors = table.freeze({})
v2.WalkSound = table.freeze({
    SoundId = 130108529138254,
    Data = table.freeze({
        Looped = true,
        MaxDistance = 20,
        Speed = 1,
        Volume = 1.5
    })
})
v2.RandomIdleSound = table.freeze({
    SoundId = 73352947350227,
    Data = table.freeze({
        MaxDistance = 20,
        Volume = 1.5
    })
})
return (table.freeze(v2))
