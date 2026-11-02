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
    _id = "La Vacca Saturno Saturnita",
    DisplayName = "La Vacca Saturno Saturnita",
    Icon = "rbxassetid://86595261029491",
    EarningRate = 2200000,
    IndexSpeedReward = 1320000,
    DropWeight = 0,
    VisualOdds = 3490000000000,
    ModelWeight = 740,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    GenderLocked = "Female",
    Egg = table.freeze({
        DisplayName = "La Vacca Saturno Saturnita Egg",
        Icon = "rbxassetid://135566519246226",
        GrowthTime = 780,
        WeightKg = 8
    })
}
local v3 = {}
local v4 = Instance.new("Animation")

if not pcall(function() -- line 37 | captures: v4
        v4.AnimationId = "rbxassetid://116964880659248"
    end) then
    warn("Animation rbxassetid://116964880659248 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 46 | captures: Animation
        Animation.AnimationId = "rbxassetid://133630286779062"
    end) then
    warn("Animation rbxassetid://133630286779062 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Cosmic
v2.BaseModelColor = Color3.new(0.33725491166114807, 0.6274510025978088, 0.239215686917305)
v2.PossibleModelColors = table.freeze({})
v2.WalkSound = table.freeze({
    SoundId = 85955478622198,
    Data = table.freeze({
        Looped = true,
        MaxDistance = 20,
        Speed = 1,
        Volume = 1.5
    })
})
v2.RandomIdleSound = table.freeze({
    SoundId = 136283967849365,
    Data = table.freeze({
        MaxDistance = 20,
        Volume = 1.2
    })
})
return (table.freeze(v2))
