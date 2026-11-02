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
    _id = "Colossal Mammoth",
    DisplayName = "King Mammoth",
    Icon = "rbxassetid://121929987331235",
    EarningRate = 400000,
    IndexSpeedReward = 22400,
    DropWeight = 0.2,
    VisualOdds = 17955881.758,
    ModelWeight = 25000,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    GenderLocked = "Male",
    Egg = table.freeze({
        DisplayName = "King Mammoth Egg",
        Icon = "rbxassetid://139700961680740",
        GrowthTime = 900,
        WeightKg = 4
    })
}
local v3 = {}
local v4 = Instance.new("Animation")

if not pcall(function() -- line 37 | captures: v4
        v4.AnimationId = "rbxassetid://103111482414289"
    end) then
    warn("Animation rbxassetid://103111482414289 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 46 | captures: Animation
        Animation.AnimationId = "rbxassetid://120583990936388"
    end) then
    warn("Animation rbxassetid://120583990936388 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Cosmic
v2.BaseModelColor = Color3.new(0.33725491166114807, 0.6274510025978088, 0.239215686917305)
v2.PossibleModelColors = table.freeze({})
v2.WalkSound = table.freeze({
    SoundId = 81855989017339,
    Data = table.freeze({
        Looped = true,
        MaxDistance = 20,
        Speed = 1,
        Volume = 2
    })
})
v2.RandomIdleSound = table.freeze({
    SoundId = 107063061258697,
    Data = table.freeze({
        MaxDistance = 20,
        Volume = 1.8
    })
})
return (table.freeze(v2))
