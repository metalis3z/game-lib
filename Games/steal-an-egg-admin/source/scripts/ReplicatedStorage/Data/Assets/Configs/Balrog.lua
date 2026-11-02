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
    _id = "Balrog",
    DisplayName = "Balrog",
    Icon = "rbxassetid://136631757702916",
    EarningRate = 200000000,
    IndexSpeedReward = 4500000,
    DropWeight = 0,
    VisualOdds = 20.41,
    ModelWeight = 65000,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    DontRoll = true,
    Egg = table.freeze({
        DisplayName = "Demonic Egg",
        Icon = "rbxassetid://128770392825945",
        GrowthTime = 86400,
        WeightKg = 16
    })
}
local v3 = {}
local v4 = Instance.new("Animation")

if not pcall(function() -- line 37 | captures: v4
        v4.AnimationId = "rbxassetid://82389300217746"
    end) then
    warn("Animation rbxassetid://82389300217746 is not shared with this experience")
end
v3.Idle = v4

local Animation = Instance.new("Animation")

if not pcall(function() -- line 46 | captures: Animation
        Animation.AnimationId = "rbxassetid://71601874191442"
    end) then
    warn("Animation rbxassetid://71601874191442 is not shared with this experience")
end
v3.Walk = Animation
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Eternal
v2.BaseModelColor = Color3.new(0.47058823704719543, 0.1411764770746231, 0.10196078568696976)

local v5 = {}
local v6 = {}

v6[1] = Color3.new(0.47058823704719543, 0.1411764770746231, 0.10196078568696976)
v6[2] = 1000
v5[1] = table.freeze(v6)
v2.PossibleModelColors = table.freeze(v5)
return (table.freeze(v2))
