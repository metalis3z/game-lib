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
    _id = "Basilisk",
    DisplayName = "Leviathan",
    Icon = "rbxassetid://125867102340608",
    EarningRate = 220000,
    IndexSpeedReward = 5000,
    DropWeight = 0.14285714285714285,
    VisualOdds = 1372.3499248948783,
    ModelWeight = 5000,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Leviathan Egg",
        Icon = "rbxassetid://120297489068938",
        GrowthTime = 1500,
        WeightKg = 2
    })
}
local v3 = {}
local v4 = Instance.new("Animation")

if not pcall(function() -- line 36 | captures: v4
        v4.AnimationId = "rbxassetid://138239582760998"
    end) then
    warn("Animation rbxassetid://138239582760998 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 45 | captures: Animation
        Animation.AnimationId = "rbxassetid://81693908793369"
    end) then
    warn("Animation rbxassetid://81693908793369 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Cosmic
v2.BaseModelColor = Color3.new(0.10588235408067703, 0.16470588743686676, 0.2078431397676468)

local v5 = {}
local v6 = {}

v6[1] = Color3.new(0.10588235408067703, 0.16470588743686676, 0.2078431397676468)
v6[2] = 520

local v7 = table.freeze(v6)
local v8 = {}

v8[1] = Color3.new(0.07450980693101883, 0.0941176488995552, 0.05098039284348488)
v8[2] = 210

local v9 = table.freeze(v8)
local v10 = {}

v10[1] = Color3.new(0.20392157137393951, 0.16078431904315948, 0.10196078568696976)
v10[2] = 140

local v11 = table.freeze(v10)
local v12 = {}

v12[1] = Color3.new(0.12156862765550613, 0.11764705926179886, 0.08235294371843338)
v12[2] = 90

local v13 = table.freeze(v12)
local v14 = {}

v14[1] = Color3.new(0.12941177189350128, 0.12941177189350128, 0.12156862765550613)
v14[2] = 40

local v15 = table.freeze(v14)
local v16 = {}

v16[1] = Color3.new(1, 1, 1)
v16[2] = 12
v5[1] = v7
v5[2] = v9
v5[3] = v11
v5[4] = v13
v5[5] = v15
v5[6] = table.freeze(v16)
v2.PossibleModelColors = table.freeze(v5)
v2.RandomIdleSound = table.freeze({
    SoundId = 125022992566729,
    Data = table.freeze({
        MaxDistance = 20,
        Volume = 1.5
    })
})
return (table.freeze(v2))
