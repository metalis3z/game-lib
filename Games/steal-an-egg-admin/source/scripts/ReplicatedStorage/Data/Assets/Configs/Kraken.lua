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
    _id = "Kraken",
    DisplayName = "Kraken",
    Icon = "rbxassetid://102398135619986",
    EarningRate = 15000000,
    IndexSpeedReward = 144000,
    DropWeight = 0.14285714285714285,
    VisualOdds = 40284267734.10782,
    ModelWeight = 18000,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Kraken Egg",
        Icon = "rbxassetid://74154644445138",
        GrowthTime = 8100,
        WeightKg = 6
    })
}
local v3 = {}
local v4 = Instance.new("Animation")

if not pcall(function() -- line 36 | captures: v4
        v4.AnimationId = "rbxassetid://102866752135961"
    end) then
    warn("Animation rbxassetid://102866752135961 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 45 | captures: Animation
        Animation.AnimationId = "rbxassetid://106249253705385"
    end) then
    warn("Animation rbxassetid://106249253705385 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Secret
v2.BaseModelColor = Color3.new(0.7686274647712708, 0.1568627506494522, 0.10980392247438431)

local v5 = {}
local v6 = {}

v6[1] = Color3.new(0.7686274647712708, 0.1568627506494522, 0.10980392247438431)
v6[2] = 460

local v7 = table.freeze(v6)
local v8 = {}

v8[1] = Color3.new(0.47058823704719543, 0.21568627655506134, 0.3333333432674408)
v8[2] = 190

local v9 = table.freeze(v8)
local v10 = {}

v10[1] = Color3.new(0.37254902720451355, 0.23529411852359772, 0.1764705926179886)
v10[2] = 140

local v11 = table.freeze(v10)
local v12 = {}

v12[1] = Color3.new(0.7254902124404907, 0.4313725531101227, 0.27450981736183167)
v12[2] = 110

local v13 = table.freeze(v12)
local v14 = {}

v14[1] = Color3.new(0.21568627655506134, 0.1764705926179886, 0.23529411852359772)
v14[2] = 70

local v15 = table.freeze(v14)
local v16 = {}

v16[1] = Color3.new(1, 1, 1)
v16[2] = 10
v5[1] = v7
v5[2] = v9
v5[3] = v11
v5[4] = v13
v5[5] = v15
v5[6] = table.freeze(v16)
v2.PossibleModelColors = table.freeze(v5)
v2.WalkSound = table.freeze({
    SoundId = 107184283224971,
    Data = table.freeze({
        Looped = true,
        MaxDistance = 20,
        Speed = 1,
        Volume = 1.5
    })
})
v2.RandomIdleSound = table.freeze({
    SoundId = 138342610862905,
    Data = table.freeze({
        MaxDistance = 20,
        Volume = 1.5
    })
})
return (table.freeze(v2))
