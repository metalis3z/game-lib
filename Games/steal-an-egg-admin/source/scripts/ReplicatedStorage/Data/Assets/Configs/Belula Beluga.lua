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
    _id = "Belula Beluga",
    DisplayName = "Belula Beluga",
    Icon = "rbxassetid://131612050648072",
    EarningRate = 40000,
    IndexSpeedReward = 2580,
    DropWeight = 0.2,
    VisualOdds = 5,
    ModelWeight = 800,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Belula Beluga Egg",
        Icon = "rbxassetid://139937203160382",
        GrowthTime = 120,
        WeightKg = 6,
        HideRarity = true
    })
}
local v3 = {}
local v4 = Instance.new("Animation")

if not pcall(function() -- line 42 | captures: v4
        v4.AnimationId = "rbxassetid://131037597109586"
    end) then
    warn("Animation rbxassetid://131037597109586 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 51 | captures: Animation
        Animation.AnimationId = "rbxassetid://71387701777410"
    end) then
    warn("Animation rbxassetid://71387701777410 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Mythic
v2.BaseModelColor = Color3.new(0.33725491166114807, 0.6274510025978088, 0.239215686917305)
v2.PossibleModelColors = table.freeze({})
v2.WalkSound = table.freeze({
    SoundId = 78380594184989,
    Data = table.freeze({
        Looped = true,
        MaxDistance = 20,
        Speed = 1,
        Volume = 1.5
    })
})
v2.RandomIdleSound = table.freeze({
    SoundId = 87806871273697,
    Data = table.freeze({
        MaxDistance = 20,
        Volume = 1.5
    })
})
return (table.freeze(v2))
