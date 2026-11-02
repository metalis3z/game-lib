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
    _id = "Kitsune",
    DisplayName = "Kitsune",
    Icon = "rbxassetid://107842067813602",
    WhiteImage = nil,
    MutationIcons = nil,
    EarningRate = 1800000000,
    IndexSpeedReward = 6870240,
    DropWeight = 0,
    VisualOdds = 168336000000000,
    ModelWeight = 260,
    WalkAnimationReferenceSpeed = nil,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    PlaceSound = nil,
    RandomIdleSound = nil,
    LuckyBlockDropTable = nil,
    LuckyBlockDropTableType = nil,
    LuckyBlockLevelRange = nil,
    LuckyBlockOpenDuration = nil,
    DontRoll = nil,
    CannotFuse = nil,
    GenderLocked = nil,
    AlbinosColorFullWhite = nil,
    Egg = table.freeze({
        DisplayName = "Kitsune Egg",
        Icon = "rbxassetid://136779412524244",
        GrowthTime = 50400,
        WeightKg = 4,
        HideRarity = nil,
        IgnoreSizeGrowthMultiplier = nil
    })
};
local table_freeze = table.freeze;
local v3 = {
    TransitionFadeDuration = nil
};
local Animation = Instance.new("Animation");

if not pcall(function() -- Line: 65, Name: setAnimationId
    -- upvalues: Animation (copy)
    Animation.AnimationId = "rbxassetid://116804851770381";
end) then
    warn("Animation rbxassetid://116804851770381 is not shared with this experience");
end;

v3.Idle = Animation;
local Animation2 = Instance.new("Animation");

if pcall(function() -- Line: 78, Name: setAnimationId2
    -- upvalues: Animation2 (copy)
    Animation2.AnimationId = "rbxassetid://138595419857105";
end) then
    v3.Walk = Animation2;
    v2.Animations = table_freeze(v3);
    v2.Rarity = Rarity.Rarities.Divine;
    v2.BaseModelColor = Color3.new(0.8705882430076599, 0.8274509906768799, 0.6549019813537598);
    v2.PossibleModelColors = table.freeze({
        table.freeze({ Color3.new(0.8705882430076599, 0.8274509906768799, 0.6549019813537598), 850 }),
        table.freeze({ Color3.new(0.9215686321258545, 0.7843137383460999, 0.5490196347236633), 90 }),
        table.freeze({ Color3.new(0.7450980544090271, 0.7450980544090271, 0.7843137383460999), 48 }),
        table.freeze({ Color3.new(1, 1, 1), 12 })
    });
    v2.WalkSound = table.freeze({
        SoundId = 82187981775648,
        Data = table.freeze({
            Looped = true,
            MaxDistance = 20,
            Speed = 1,
            Volume = 1.5
        })
    });

    return v2;
end;

warn("Animation rbxassetid://138595419857105 is not shared with this experience");
v3.Walk = Animation2;
v2.Animations = table_freeze(v3);
v2.Rarity = Rarity.Rarities.Divine;
v2.BaseModelColor = Color3.new(0.8705882430076599, 0.8274509906768799, 0.6549019813537598);
v2.PossibleModelColors = table.freeze({
    table.freeze({ Color3.new(0.8705882430076599, 0.8274509906768799, 0.6549019813537598), 850 }),
    table.freeze({ Color3.new(0.9215686321258545, 0.7843137383460999, 0.5490196347236633), 90 }),
    table.freeze({ Color3.new(0.7450980544090271, 0.7450980544090271, 0.7843137383460999), 48 }),
    table.freeze({ Color3.new(1, 1, 1), 12 })
});
v2.WalkSound = table.freeze({
    SoundId = 82187981775648,
    Data = table.freeze({
        Looped = true,
        MaxDistance = 20,
        Speed = 1,
        Volume = 1.5
    })
});

return v2;