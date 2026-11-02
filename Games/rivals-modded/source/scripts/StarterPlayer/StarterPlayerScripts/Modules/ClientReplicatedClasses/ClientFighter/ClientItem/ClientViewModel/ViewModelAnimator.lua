-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ContentProvider = game:GetService("ContentProvider");
local AnimationLibrary = require(ReplicatedStorage.Modules.AnimationLibrary);
local SoundLibrary = require(ReplicatedStorage.Modules.SoundLibrary);
local Signal = require(ReplicatedStorage.Modules.Signal);
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 13
    -- upvalues: u1 (copy), Signal (copy)
    local v3 = setmetatable({}, u1);
    v3.AnimationPlayed = Signal.new();
    v3.AnimationStopped = Signal.new();
    v3.ClientViewModel = p2;
    v3.SprintTrackSpeed = 1;
    v3._viewmodel_animations = v3.ClientViewModel.Info.Animations;
    v3._play_animations_instantly = v3.ClientViewModel.Info.PlayAnimationsInstantly;
    v3._render_cooldown = 0;
    v3._inspect_cooldown = 0;
    v3._animations_loaded = false;
    v3._animation_cleanup = {};
    v3._animation_tracks = {};
    v3._animation_hashes = {};
    v3._animation_threads = {};
    v3._animation_keys_lookup = {};
    v3._equip_animation = nil;
    v3._idle_animation = nil;
    v3._inspect_animation = nil;
    v3._rare_inspect_animation = nil;
    v3._sprint_animation = nil;
    v3._should_override_previous_animations_on_play = false;
    v3._last_animation_key_played = nil;
    v3._blocked_animations = {};
    v3:_Init();

    return v3;
end;

function u1.HasEmptyReloadAnimations(p4) -- Line: 50
    return p4._viewmodel_animations.EmptyReload ~= nil and true or p4._viewmodel_animations.EmptyReloadStart ~= nil;
end;

function u1.IsRenderingDisabled(p5) -- Line: 54
    return tick() < p5._render_cooldown;
end;

function u1.IsAnimationPlaying(p6, p7) -- Line: 58
    local AnimationTrack = p6:GetAnimationTrack(p7);

    if AnimationTrack then
        AnimationTrack = AnimationTrack.IsPlaying;
    end;

    return AnimationTrack;
end;

function u1.AreAnimationsPlaying(p8, p9) -- Line: 63
    for _, v in pairs(p9) do
        if p8:IsAnimationPlaying(v) then
            return true;
        end;
    end;
end;

function u1.GetEquipAnimationKey(p10) -- Line: 71
    return p10._equip_animation;
end;

function u1.GetIdleAnimationKey(p11) -- Line: 75
    return p11._idle_animation;
end;

function u1.GetInspectAnimationKey(p12) -- Line: 79
    return p12._inspect_animation;
end;

function u1.GetRareInspectAnimationKey(p13) -- Line: 83
    return p13._rare_inspect_animation;
end;

function u1.GetAnimationTrack(p14, p15) -- Line: 87
    return p14._animation_tracks[p15];
end;

function u1.GetAnimationKeys(p16, p17) -- Line: 91
    if p16._animation_keys_lookup[p17] then
        return p16._animation_keys_lookup[p17];
    end;

    local v18 = {};

    for i = 1, (1 / 0) do
        local v19 = p17 .. i;

        if not p16:GetAnimationTrack(v19) then
            break;
        end;

        table.insert(v18, v19);
        local _ = i;
    end;

    p16._animation_keys_lookup[p17] = v18;

    return v18;
end;

function u1.IsInspectAnimationPlaying(p20) -- Line: 113
    return p20:IsAnimationPlaying(p20._inspect_animation) or p20:IsAnimationPlaying(p20._rare_inspect_animation);
end;

function u1.GetSprintTrack(p21) -- Line: 117
    return p21:GetAnimationTrack(p21._sprint_animation);
end;

function u1.IsAnimationHashValid(p22, p23, p24) -- Line: 122
    return p22._animation_hashes[p23] == p24;
end;

function u1.AnimationWait(p25, p26, p27, p28) -- Line: 127
    local v29 = wait(p28) and p25:IsAnimationHashValid(p26, p27);

    return v29;
end;

function u1.SetInspectCooldown(p30, p31) -- Line: 131
    p30._inspect_cooldown = tick() + p31;
end;

function u1.CreateSound(p32, ...) -- Line: 135
    return p32.ClientViewModel:CreateSound(...);
end;

function u1.OverridePreviousAnimationsOnPlay(p33, p34) -- Line: 139
    p33._should_override_previous_animations_on_play = p34;
end;

function u1.BlockAnimation(p35, p36, p37) -- Line: 143
    local v38 = typeof(p36) == "string";
    assert(v38, "Argument 1 invalid, expected a string");
    local v39 = typeof(p37) == "number";
    assert(v39, "Argument 2 invalid, expected a number");
    p35._blocked_animations[p36] = tick() + p37;
end;

function u1.PlayAnimation(p40, p41, p42, p43, p44, p45) -- Line: 152
    -- upvalues: AnimationLibrary (copy)
    local v46 = typeof(p41) == "string";
    assert(v46, "Argument 1 invalid, expected a string");
    local v47 = not p42 or typeof(p42) == "number";
    assert(v47, "Argument 2 invalid, expected a number");

    if tick() < (p40._blocked_animations[p41] or 0) then
        return;
    end;

    local v48 = p40._play_animations_instantly and 0 or p43;

    if p42 then
        p40:SetInspectCooldown(p42);
        p40:StopInspecting();
    end;

    local v49 = p40:_AnimationKeyToName(p41);

    if v49 then
        p40:_CancelAnimationSoundCallback(v49);
    end;

    local v50 = p40._should_override_previous_animations_on_play or (p41 == p40:GetInspectAnimationKey() and true or p41 == p40:GetRareInspectAnimationKey());

    if p41 ~= p40:GetIdleAnimationKey() and (p41 ~= p40._sprint_animation and (p40._last_animation_key_played ~= p40:GetIdleAnimationKey() and p40._last_animation_key_played ~= p40._sprint_animation)) then
        if v50 and p40._last_animation_key_played then
            p40:StopAnimation(p40._last_animation_key_played, 0);
        end;

        p40._last_animation_key_played = p41;
    end;

    local AnimationTrack = p40:GetAnimationTrack(p41);

    if not AnimationTrack then
        warn("Animation key failed to play (not found): " .. tostring(p41));

        return;
    end;

    local v51 = p40._animation_hashes[v49];
    local v52 = AnimationLibrary.Info[v49];
    local v53 = v52.Speed * (p45 or 1);
    AnimationTrack:Play(v48, p44, v53);

    if v52.SoundCallback then
        table.insert(p40._animation_threads[v49], task.defer(v52.SoundCallback, p40.ClientViewModel, v53, v51));
    end;

    if v52.EffectCallback then
        table.insert(p40._animation_threads[v49], task.defer(v52.EffectCallback, p40.ClientViewModel, v53, v51));
    end;

    p40.AnimationPlayed:Fire(p41, v49, v51);
end;

function u1.PlayIdleAnimation(p54) -- Line: 206
    if p54.ClientViewModel:IsEquipped() then
        p54:PlayAnimation(p54._idle_animation, nil, 0);
    end;
end;

function u1.PlayEquipAnimation(p55) -- Line: 212
    if p55:GetAnimationTrack(p55._equip_animation) then
        p55:PlayAnimation(p55._equip_animation);

        return true;
    end;
end;

function u1.PlaySprintAnimation(p56) -- Line: 222
    p56:PlayAnimation(p56._sprint_animation);
end;

function u1.Inspect(p57, p58) -- Line: 228
    -- upvalues: SoundLibrary (copy)
    local v59 = not p58 or typeof(p58) == "boolean";
    assert(v59, "Argument 1 invalid, expected a boolean or nil");

    if tick() < p57._inspect_cooldown or p57.ClientViewModel.ClientItem:IsEquipping() then
        return false;
    end;

    p57:StopAnimation(p57._equip_animation, 0);
    local v60 = p57:StopInspecting();

    if not p58 then
        if p58 == nil then
            p58 = p57:GetAnimationTrack(p57._rare_inspect_animation) and math.random() < 0.1;
        else
            p58 = false;
        end;
    end;

    if p58 then
        p57:CreateSound(SoundLibrary.EquipSounds[math.random(#SoundLibrary.EquipSounds)], 0.375, 1.4 + 0.2 * math.random(), true, 5);
        p57:CreateSound("rbxassetid://13159969353", 0.25, 1 + 0.25 * math.random(), true, 5);
        p57:PlayAnimation(p57._rare_inspect_animation, nil, v60 and 0 or 0.2);
    else
        if not p57:GetAnimationTrack(p57._inspect_animation) then
            return false;
        end;

        p57:CreateSound(SoundLibrary.EquipSounds[math.random(#SoundLibrary.EquipSounds)], 0.375, 1.4 + 0.2 * math.random(), true, 5);
        p57:PlayAnimation(p57._inspect_animation, nil, v60 and 0 or 0.2);
    end;

    return true, p58;
end;

function u1.StopAnimation(p61, p62, p63, p64) -- Line: 260
    local v65 = typeof(p62) == "string";
    assert(v65, "Argument 1 invalid, expected a string");
    local v66 = not p64 or typeof(p64) == "number";
    assert(v66, "Argument 3 invalid, expected a number");
    local v67 = p61._play_animations_instantly and 0 or p63;

    if p64 then
        p61:SetInspectCooldown(p64);
        p61:StopInspecting();
    end;

    local v68 = p61:_AnimationKeyToName(p62);

    if v68 then
        p61:_CancelAnimationSoundCallback(v68);
    end;

    local AnimationTrack = p61:GetAnimationTrack(p62);

    if not AnimationTrack then
        return;
    end;

    AnimationTrack:Stop(v67);
    p61.AnimationStopped:Fire(p62, v68);
end;

function u1.StopInspecting(p69) -- Line: 287
    if p69:GetAnimationTrack(p69._inspect_animation) and p69:GetAnimationTrack(p69._inspect_animation).IsPlaying then
        p69:StopAnimation(p69._inspect_animation, 0.1);

        return 0.1;
    end;

    if p69:GetAnimationTrack(p69._rare_inspect_animation) and p69:GetAnimationTrack(p69._rare_inspect_animation).IsPlaying then
        p69:StopAnimation(p69._rare_inspect_animation, 0.1);

        return 0.1;
    end;
end;

function u1.StopSprintAnimation(p70) -- Line: 297
    p70:StopAnimation(p70._sprint_animation);
end;

function u1.StopAllAnimations(p71) -- Line: 301
    for i in pairs(p71._animation_tracks) do
        p71:StopAnimation(i);
    end;
end;

function u1.ChangeEquipAnimation(p72, p73) -- Line: 307
    local v74 = p73 or "Equip";

    if v74 == p72._equip_animation then
        return;
    end;

    p72._equip_animation = v74;
end;

function u1.ChangeIdleAnimation(p75, p76) -- Line: 317
    local v77 = p76 or "Idle";

    if v77 == p75._idle_animation then
        return;
    end;

    if p75._idle_animation then
        p75:StopAnimation(p75._idle_animation);
    end;

    p75._idle_animation = v77;
    p75:PlayIdleAnimation();
end;

function u1.ChangeSprintAnimation(p78, p79) -- Line: 332
    -- upvalues: AnimationLibrary (copy)
    local v80 = p79 or "Sprint";

    if v80 == p78._sprint_animation then
        return;
    end;

    if p78._sprint_animation then
        p78:StopAnimation(p78._sprint_animation);
    end;

    p78._sprint_animation = v80;
    p78.SprintTrackSpeed = p78:_AnimationKeyToName(p78._sprint_animation) and (AnimationLibrary.Info[p78:_AnimationKeyToName(p78._sprint_animation)].Speed or 1) or 1;
end;

function u1.ChangeInspectAnimation(p81, p82) -- Line: 347
    local v83 = p82 or "Inspect";

    if v83 == p81._inspect_animation then
        return;
    end;

    if p81._inspect_animation then
        p81:StopAnimation(p81._inspect_animation);
    end;

    p81._inspect_animation = v83;
end;

function u1.ChangeRareInspectAnimation(p84, p85) -- Line: 361
    local v86 = p85 ~= "nil" and (p85 or "RareInspect") or nil;

    if v86 == p84._rare_inspect_animation then
        return;
    end;

    if p84._rare_inspect_animation then
        p84:StopAnimation(p84._rare_inspect_animation);
    end;

    p84._rare_inspect_animation = v86;
end;

function u1.LoadAnimations(u87) -- Line: 375
    -- upvalues: AnimationLibrary (copy), ContentProvider (copy)
    if u87._animations_loaded or not u87.ClientViewModel.Model:IsDescendantOf(game) then
        return;
    end;

    u87._animations_loaded = true;
    local u88 = {};

    local function preload_animation(u89, u90) -- Line: 384
        -- upvalues: AnimationLibrary (ref), u88 (copy), u87 (copy)
        local AnimationID = AnimationLibrary.Info[u90].AnimationID;
        local Animation = Instance.new("Animation");
        Animation.AnimationId = AnimationID;
        table.insert(u88, Animation);
        table.insert(u87._animation_cleanup, Animation);
        local success, result = pcall(u87.ClientViewModel.Model.AnimationController.Animator.LoadAnimation, u87.ClientViewModel.Model.AnimationController.Animator, Animation);

        if not success then
            warn("FAILED TO LOAD ANIMATION FOR " .. u87.ClientViewModel.Name .. ": " .. u89 .. ", " .. u90 .. ", " .. AnimationID);

            return;
        end;

        table.insert(u87._animation_cleanup, result);
        result.Stopped:Connect(function() -- Line: 401
            -- upvalues: u87 (ref), u90 (copy), u89 (copy), result (copy)
            u87:_CancelAnimationSoundCallback(u90);
            u87.AnimationStopped:Fire(u89, u90);

            if u87._play_animations_instantly then
                result:Stop(0);
            end;
        end);
        u87._animation_tracks[u89] = result;
    end;

    for i, v in pairs(u87._viewmodel_animations) do
        task.spawn(preload_animation, i, v);
    end;

    task.spawn(function() -- Line: 417
        -- upvalues: ContentProvider (ref), u88 (copy), u87 (copy)
        ContentProvider:PreloadAsync(u88);
        u87._render_cooldown = tick() + 0.1;
    end);
    u87._render_cooldown = tick() + 5;
    u87:ChangeEquipAnimation("Equip");
    u87:ChangeIdleAnimation("Idle");
    u87:ChangeSprintAnimation("Sprint");
    u87:ChangeInspectAnimation("Inspect");
    u87:ChangeRareInspectAnimation("RareInspect");
    u87:PlayIdleAnimation();
end;

function u1.Destroy(p91) -- Line: 431
    p91.AnimationPlayed:Destroy();
    p91.AnimationStopped:Destroy();

    for _, v in pairs(p91._animation_cleanup) do
        v:Destroy();
    end;

    for _, _ in pairs(p91._animation_threads) do
        for _, v in pairs(p91._animation_threads) do
            pcall(task.cancel, v);
        end;
    end;

    p91._animation_cleanup = {};
    p91._animation_threads = {};
    p91._animation_hashes = {};
end;

function u1._ResetIdleAfterEquipping(p92, p93, p94, p95) -- Line: 454
    -- upvalues: AnimationLibrary (copy)
    local v96 = AnimationLibrary.Info[p94];

    if v96 then
        v96 = v96.ExtraInformation.ResetIdleTimestamp;
    end;

    if p93 ~= "Equip" or not v96 then
        return;
    end;

    wait(v96);

    if not p92:IsAnimationHashValid(p94, p95) then
        return;
    end;

    local AnimationTrack = p92:GetAnimationTrack(p92:GetIdleAnimationKey());

    if not AnimationTrack then
        return;
    end;

    AnimationTrack.TimePosition = 0;
end;

function u1._CancelAnimationSoundCallback(p97, p98) -- Line: 477
    for _, v in pairs(p97._animation_threads[p98] or {}) do
        pcall(task.cancel, v);
    end;

    p97._animation_threads[p98] = {};
    p97._animation_hashes[p98] = (p97._animation_hashes[p98] or 0) + 1;
end;

function u1._AnimationKeyToName(p99, p100) -- Line: 487
    return p99._viewmodel_animations[p100];
end;

function u1._Init(u101) -- Line: 491
    u101.AnimationPlayed:Connect(function(p102, p103, p104) -- Line: 492
        -- upvalues: u101 (copy)
        u101:_ResetIdleAfterEquipping(p102, p103, p104);
    end);
end;

return u1;