-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Rarity = require(ReplicatedStorage.Directory.Rarity);

local function makeAnimation(u1) -- Line: 7
    local Animation = Instance.new("Animation");

    if pcall(function() -- Line: 10, Name: setAnimationId
        -- upvalues: Animation (copy), u1 (copy)
        Animation.AnimationId = u1;
    end) then
        return Animation;
    end;

    warn((`Animation {u1} is not shared with this experience`));

    return Animation;
end;

local _ = table.freeze;
local v2 = {
    _id = "Mecha Crocodon",
    DisplayName = "Mecha Crocodon",
    Icon = "rbxassetid://114090116471253",
    WhiteImage = nil,
    MutationIcons = nil,
    EarningRate = 680000000,
    IndexSpeedReward = 0,
    DropWeight = 0,
    VisualOdds = 909.0909091,
    ModelWeight = 35,
    WalkAnimationReferenceSpeed = nil,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    PlaceSound = nil,
    WalkSound = nil,
    RandomIdleSound = nil,
    LuckyBlockDropTable = nil,
    LuckyBlockDropTableType = nil,
    LuckyBlockLevelRange = nil,
    LuckyBlockOpenDuration = nil,
    DontRoll = true,
    CannotFuse = nil,
    GenderLocked = nil,
    AlbinosColorFullWhite = nil,
    Egg = table.freeze({
        DisplayName = "Mecha Crocodon Egg",
        Icon = "rbxassetid://96353647829204",
        ModelName = "Mecha Egg",
        GrowthTime = 10,
        WeightKg = 6,
        HideRarity = true,
        IgnoreSizeGrowthMultiplier = true
    })
};
local table_freeze = table.freeze;
local v3 = {
    TransitionFadeDuration = nil
};
local Animation = Instance.new("Animation");

if not pcall(function() -- Line: 67, Name: setAnimationId
    -- upvalues: Animation (copy)
    Animation.AnimationId = "rbxassetid://100456235153763";
end) then
    warn("Animation rbxassetid://100456235153763 is not shared with this experience");
end;

v3.Idle = Animation;
local Animation2 = Instance.new("Animation");

if pcall(function() -- Line: 80, Name: setAnimationId2
    -- upvalues: Animation2 (copy)
    Animation2.AnimationId = "rbxassetid://121506366667927";
end) then
    v3.Walk = Animation2;
    v2.Animations = table_freeze(v3);
    v2.Rarity = Rarity.Rarities.Eternal;
    v2.BaseModelColor = Color3.fromRGB(150, 160, 175);
    v2.PossibleModelColors = table.freeze({ table.freeze({ Color3.fromRGB(150, 160, 175), 1 }) });

    return v2;
end;

warn("Animation rbxassetid://121506366667927 is not shared with this experience");
v3.Walk = Animation2;
v2.Animations = table_freeze(v3);
v2.Rarity = Rarity.Rarities.Eternal;
v2.BaseModelColor = Color3.fromRGB(150, 160, 175);
v2.PossibleModelColors = table.freeze({ table.freeze({ Color3.fromRGB(150, 160, 175), 1 }) });

return v2;