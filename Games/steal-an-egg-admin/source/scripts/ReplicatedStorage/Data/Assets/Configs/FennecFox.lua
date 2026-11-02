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
    _id = "FennecFox",
    DisplayName = "Fennec",
    Icon = "rbxassetid://130204625520606",
    EarningRate = 18,
    IndexSpeedReward = 8100,
    DropWeight = 0.5,
    VisualOdds = 7778.721339,
    ModelWeight = 8,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Fennec Egg",
        Icon = "rbxassetid://73808584409925",
        GrowthTime = 30,
        WeightKg = 2
    })
}
local v3 = {}
local v4 = Instance.new("Animation")

if not pcall(function() -- line 36 | captures: v4
        v4.AnimationId = "rbxassetid://103244943284951"
    end) then
    warn("Animation rbxassetid://103244943284951 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 45 | captures: Animation
        Animation.AnimationId = "rbxassetid://88738924845369"
    end) then
    warn("Animation rbxassetid://88738924845369 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Uncommon
v2.BaseModelColor = Color3.new(0.8392156958580017, 0.729411780834198, 0.5568627715110779)

local v5 = {}
local v6 = {}

v6[1] = Color3.new(0.8392156958580017, 0.729411780834198, 0.5568627715110779)
v6[2] = 780

local v7 = table.freeze(v6)
local v8 = {}

v8[1] = Color3.new(0.9215686321258545, 0.843137264251709, 0.686274528503418)
v8[2] = 130

local v9 = table.freeze(v8)
local v10 = {}

v10[1] = Color3.new(0.7058823704719543, 0.529411792755127, 0.3137255012989044)
v10[2] = 70

local v11 = table.freeze(v10)
local v12 = {}

v12[1] = Color3.new(1, 0.7333333492279053, 0.501960813999176)
v12[2] = 20

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
    SoundId = 85748248207263,
    Data = table.freeze({
        Looped = true,
        MaxDistance = 20,
        Speed = 1,
        Volume = 1.5
    })
})
v2.RandomIdleSound = table.freeze({
    SoundId = 108444972911831,
    Data = table.freeze({
        MaxDistance = 20,
        Volume = 1.5
    })
})
return (table.freeze(v2))
