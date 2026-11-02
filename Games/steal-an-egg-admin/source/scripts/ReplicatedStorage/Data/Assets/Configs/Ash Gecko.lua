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
    _id = "Ash Gecko",
    DisplayName = "Lava Gecko",
    Icon = "rbxassetid://72012424724645",
    EarningRate = 180,
    IndexSpeedReward = 24000,
    DropWeight = 0.5,
    VisualOdds = 89779408.791,
    ModelWeight = 14,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Lava Gecko Egg",
        Icon = "rbxassetid://133900489402684",
        GrowthTime = 60,
        WeightKg = 5
    })
}
local v3 = {}
local v4 = Instance.new("Animation")

if not pcall(function() -- line 36 | captures: v4
        v4.AnimationId = "rbxassetid://72018833167577"
    end) then
    warn("Animation rbxassetid://72018833167577 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 45 | captures: Animation
        Animation.AnimationId = "rbxassetid://73133089621880"
    end) then
    warn("Animation rbxassetid://73133089621880 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Rare
v2.BaseModelColor = Color3.new(0.2666666805744171, 0.23137255012989044, 0.23529411852359772)
v2.PossibleModelColors = table.freeze({})
v2.WalkSound = table.freeze({
    SoundId = 101311068431732,
    Data = table.freeze({
        Looped = true,
        MaxDistance = 20,
        Speed = 1,
        Volume = 1.5
    })
})
v2.RandomIdleSound = table.freeze({
    SoundId = 100184390632269,
    Data = table.freeze({
        MaxDistance = 20,
        Volume = 1.5
    })
})
return (table.freeze(v2))
