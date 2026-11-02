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
    _id = "Spider",
    DisplayName = "Spider",
    Icon = "rbxassetid://132010793204072",
    EarningRate = 22000,
    IndexSpeedReward = 12600,
    DropWeight = 0.16666666666666666,
    VisualOdds = 861882.324392,
    ModelWeight = 120,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Spider Egg",
        Icon = "rbxassetid://106778490216774",
        GrowthTime = 270,
        WeightKg = 4
    })
}
local v3 = {}
local v4 = Instance.new("Animation")

if not pcall(function() -- line 36 | captures: v4
        v4.AnimationId = "rbxassetid://139841019307735"
    end) then
    warn("Animation rbxassetid://139841019307735 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 45 | captures: Animation
        Animation.AnimationId = "rbxassetid://105084836992838"
    end) then
    warn("Animation rbxassetid://105084836992838 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Mythic
v2.BaseModelColor = Color3.new(0.21568627655506134, 0.21960784494876862, 0.24313725531101227)

local v5 = {}
local v6 = {}

v6[1] = Color3.new(0.21568627655506134, 0.21960784494876862, 0.24313725531101227)
v6[2] = 520

local v7 = table.freeze(v6)
local v8 = {}

v8[1] = Color3.new(0.1764705926179886, 0.13725490868091583, 0.11764705926179886)
v8[2] = 180

local v9 = table.freeze(v8)
local v10 = {}

v10[1] = Color3.new(0.3333333432674408, 0.27450981736183167, 0.1764705926179886)
v10[2] = 130

local v11 = table.freeze(v10)
local v12 = {}

v12[1] = Color3.new(0.13725490868091583, 0.1764705926179886, 0.13725490868091583)
v12[2] = 100

local v13 = table.freeze(v12)
local v14 = {}

v14[1] = Color3.new(0.5098039507865906, 0.37254902720451355, 0.1764705926179886)
v14[2] = 50

local v15 = table.freeze(v14)
local v16 = {}

v16[1] = Color3.new(0.09803921729326248, 0.09803921729326248, 0.09803921729326248)
v16[2] = 20

local v17 = table.freeze(v16)
local v18 = {}

v18[1] = Color3.new(1, 1, 1)
v18[2] = 12
v5[1] = v7
v5[2] = v9
v5[3] = v11
v5[4] = v13
v5[5] = v15
v5[6] = v17
v5[7] = table.freeze(v18)
v2.PossibleModelColors = table.freeze(v5)
v2.WalkSound = table.freeze({
    SoundId = 79817876684945,
    Data = table.freeze({
        Looped = true,
        MaxDistance = 20,
        Speed = 1,
        Volume = 1.5
    })
})
v2.RandomIdleSound = table.freeze({
    SoundId = 122834878636399,
    Data = table.freeze({
        MaxDistance = 20,
        Volume = 1.5
    })
})
return (table.freeze(v2))
