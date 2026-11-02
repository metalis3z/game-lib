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
    _id = "TyrannosaurusRex",
    DisplayName = "TRex",
    Icon = "rbxassetid://123124934383954",
    EarningRate = 25000000,
    IndexSpeedReward = 420000,
    DropWeight = 0.3333333333333333,
    VisualOdds = 134669113.186,
    ModelWeight = 7500,
    WalkAnimationReferenceSpeed = 16,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "TRex Egg",
        Icon = "rbxassetid://124390268104324",
        GrowthTime = 9000,
        WeightKg = 5
    })
}
local v3 = {}
local v4 = Instance.new("Animation")

if not pcall(function() -- line 37 | captures: v4
        v4.AnimationId = "rbxassetid://132203135629681"
    end) then
    warn("Animation rbxassetid://132203135629681 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 46 | captures: Animation
        Animation.AnimationId = "rbxassetid://102965663457125"
    end) then
    warn("Animation rbxassetid://102965663457125 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Secret
v2.BaseModelColor = Color3.new(0.4470588266849518, 0.47843137383461, 0.25882354378700256)

local v5 = {}
local v6 = {}

v6[1] = Color3.new(0.4470588266849518, 0.47843137383461, 0.25882354378700256)
v6[2] = 470

local v7 = table.freeze(v6)
local v8 = {}

v8[1] = Color3.new(0.37254902720451355, 0.29411765933036804, 0.1764705926179886)
v8[2] = 210

local v9 = table.freeze(v8)
local v10 = {}

v10[1] = Color3.new(0.27450981736183167, 0.37254902720451355, 0.21568627655506134)
v10[2] = 140

local v11 = table.freeze(v10)
local v12 = {}

v12[1] = Color3.new(0.5686274766921997, 0.47058823704719543, 0.27450981736183167)
v12[2] = 100

local v13 = table.freeze(v12)
local v14 = {}

v14[1] = Color3.new(0.4431372582912445, 0.40392157435417175, 0.33725491166114807)
v14[2] = 60

local v15 = table.freeze(v14)
local v16 = {}

v16[1] = Color3.new(0.16862745583057404, 0.25882354378700256, 0.35686275362968445)
v16[2] = 60

local v17 = table.freeze(v16)
local v18 = {}

v18[1] = Color3.new(0.6274510025978088, 0.27450981736183167, 0.1764705926179886)
v18[2] = 20

local v19 = table.freeze(v18)
local v20 = {}

v20[1] = Color3.new(1, 1, 1)
v20[2] = 10
v5[1] = v7
v5[2] = v9
v5[3] = v11
v5[4] = v13
v5[5] = v15
v5[6] = v17
v5[7] = v19
v5[8] = table.freeze(v20)
v2.PossibleModelColors = table.freeze(v5)
v2.WalkSound = table.freeze({
    SoundId = 125603505298810,
    Data = table.freeze({
        Looped = true,
        MaxDistance = 20,
        Speed = 1,
        Volume = 1.5
    })
})
v2.RandomIdleSound = table.freeze({
    SoundId = 88026752307055,
    Data = table.freeze({
        MaxDistance = 20,
        Volume = 1.5
    })
})
return (table.freeze(v2))
