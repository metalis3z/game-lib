-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local ReplicatedClass = require(ReplicatedStorage.Modules.ReplicatedClass);
local GameplayUtility = require(ReplicatedStorage.Modules.GameplayUtility);
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Utility = require(ReplicatedStorage.Modules.Utility);
local Signal = require(ReplicatedStorage.Modules.Signal);
local WrapController = require(Players.LocalPlayer.PlayerScripts.Controllers.WrapController);
local Attachment = Players.LocalPlayer.PlayerScripts.Assets.Misc.InvincibilityParticles.Attachment;
local ExtinguishParticles = Players.LocalPlayer.PlayerScripts.Assets.Misc.ExtinguishParticles;
local FreezeEffects = Players.LocalPlayer.PlayerScripts.Assets.Misc.FreezeEffects;
local SlowParticles = Players.LocalPlayer.PlayerScripts.Assets.Misc.SlowParticles;
local BurningEffects = Players.LocalPlayer.PlayerScripts.Assets.Misc.BurningEffects;
local BlipEffects = Players.LocalPlayer.PlayerScripts.Assets.Misc.BlipEffects;
local Finishers = ReplicatedStorage.Modules.Finishers;
local u1 = setmetatable({}, ReplicatedClass);
u1.__index = u1;

function u1.new(p2) -- Line: 26
    -- upvalues: ReplicatedClass (copy), u1 (copy), Signal (copy)
    local v3 = ReplicatedClass.new(p2);
    local v4 = setmetatable(v3, u1);
    v4.Died = Signal.new();
    v4.HealthChanged = Signal.new();
    v4.BurnEffectPlaying = Signal.new();
    v4.Model = p2.Model;
    v4.RootPart = p2.RootPart;
    v4.AimAssistBlacklist = false;
    v4._destroyed = nil;
    v4._is_hidden = nil;
    v4._is_dead = nil;
    v4._connections = {};
    v4._hurt_effect_hash = 0;
    v4._hitboxes = {};
    v4._hitboxes_small = {};
    v4._burn_effect_finish = 0;
    v4._burn_effect_sound = nil;
    v4._burn_effect_particles = {};
    v4._model_original_parent_hurt_effect = nil;
    v4._thaw_callback = nil;
    v4._thaw_highlight = nil;
    v4._current_finisher = nil;
    v4._invincibility_visual = nil;
    v4._headshot_particles = nil;
    v4._permafrost_slow_particles = nil;
    v4:_Init();

    return v4;
end;

function u1.IsRendered(p5) -- Line: 70
    -- upvalues: CONSTANTS (copy)
    local v6 = CONSTANTS.SHOULD_ALWAYS_REPLICATE();

    if not v6 then
        if p5.ClientFighter then
            return p5.ClientFighter:IsRendered();
        end;

        v6 = (workspace.CurrentCamera.CFrame.Position - p5.RootPart.Position).Magnitude < CONSTANTS.RENDER_DISTANCE;
    end;

    return v6;
end;

function u1.IsAlive(p7) -- Line: 74
    local v8 = not (p7._destroyed or p7._is_dead) and p7:GetHealth() > 0;

    return v8;
end;

function u1.IsHidden(p9) -- Line: 78
    return p9._is_hidden;
end;

function u1.GetScreenPoint(p10) -- Line: 82
    return workspace.CurrentCamera:WorldToScreenPoint(p10.RootPart.Position);
end;

function u1.GetHitboxes(p11, p12) -- Line: 86
    return p12 and #p11._hitboxes_small > 0 and p11._hitboxes_small or p11._hitboxes;
end;

function u1.SetHidden(p13, p14) -- Line: 90
    p13._is_hidden = p14;
end;

function u1.ReplicateFromServer(p15, p16, ...) -- Line: 94
    -- upvalues: ReplicatedClass (copy)
    if p16 == "BurnEffect" then
        if not p15:IsRendered() then
            return;
        end;

        p15:_BurnEffect(...);

        return;
    end;

    if p16 == "ExtinguishEffect" then
        if not p15:IsRendered() then
            return;
        end;

        p15:_ExtinguishEffect(...);

        return;
    end;

    if p16 == "HurtEffect" then
        if not p15:IsRendered() then
            return;
        end;

        p15:_HurtEffect(...);

        return;
    end;

    if p16 == "HealEffect" then
        if not p15:IsRendered() then
            return;
        end;

        p15:_HealEffect(...);

        return;
    end;

    if p16 == "FreezeEffect" then
        if not p15:IsRendered() then
            return;
        end;

        p15:_FreezeEffect(...);

        return;
    end;

    if p16 == "ThawFreezeEffect" then
        if not p15:IsRendered() then
            return;
        end;

        p15:_ThawFreezeEffect(...);

        return;
    end;

    if p16 == "FinisherEffect" then
        if not p15:IsRendered() then
            return;
        end;

        local v17, v18, v19, v20 = ...;
        p15:_PlayFinisher(p15:FromEnum(v17), v18, v19, v20);

        return;
    end;

    if p16 == "BlipEffect" then
        if not p15:IsRendered() then
            return;
        end;

        p15:_BlipEffect(...);

        return;
    end;

    if p16 == "SlowEffect" then
        if not p15:IsRendered() then
            return;
        end;

        p15:_SlowEffect(...);

        return;
    end;

    if p16 == "CreateSound" then
        if not p15:IsRendered() then
            return;
        end;

        p15:_CreateSound(...);

        return;
    end;

    if p16 ~= "Died" then
        ReplicatedClass.ReplicateFromServer(p15, p16, ...);

        return;
    end;

    p15._is_dead = true;
    p15.Died:Fire();
end;

function u1.Destroy(p21) -- Line: 165
    -- upvalues: ReplicatedClass (copy)
    p21._destroyed = true;

    for _, v in pairs(p21._connections) do
        v:Disconnect();
    end;

    p21._hitboxes = {};
    p21._hitboxes_small = {};
    p21.Died:Destroy();
    p21.HealthChanged:Destroy();
    p21.BurnEffectPlaying:Destroy();

    if p21.Model then
        p21.Model:Destroy();
    end;

    if p21._current_finisher then
        p21._current_finisher:Destroy();
        p21._current_finisher = nil;
    end;

    ReplicatedClass.Destroy(p21);
end;

function u1._CreateSound(p22, p23, p24, p25, p26, p27) -- Line: 195
    -- upvalues: Utility (copy)
    local v28 = p27 and 400 or nil;
    local v29 = Utility:CreateSound(p23, p24 * (p27 and 2 or 1), p25, p22.RootPart, true, 15, v28, v28);

    if p26 and p26 ~= 1 then
        local PitchShiftSoundEffect = Instance.new("PitchShiftSoundEffect");
        PitchShiftSoundEffect.Octave = p26;
        PitchShiftSoundEffect.Parent = v29;
    end;
end;

function u1._UpdatePermafrostSlowStacks(p30) -- Line: 208
    -- upvalues: SlowParticles (copy)
    if p30._permafrost_slow_highlight then
        p30._permafrost_slow_highlight:Destroy();
        p30._permafrost_slow_highlight = nil;
    end;

    if not p30:IsAlive() then
        return;
    end;

    local v31 = p30:IsAlive() and p30:Get("ReplicatedExternalGameplayData") and p30:Get("ReplicatedExternalGameplayData").PermafrostSlowStacks;
    local v32 = (v31 and (v31.Stacks or 0) or 0) / math.max(1, v31 and v31.MaxStacks or 0);

    if v32 <= 0 then
        for _, v in pairs(p30._permafrost_slow_particles or {}) do
            v:Destroy();
        end;

        p30._permafrost_slow_particles = nil;

        return;
    end;

    if not p30._permafrost_slow_particles then
        p30._permafrost_slow_particles = {};

        for _, child in pairs(SlowParticles:GetChildren()) do
            local v33 = child:Clone();
            v33.Parent = p30.RootPart;
            table.insert(p30._permafrost_slow_particles, v33);
        end;
    end;

    for _, v in pairs(p30._permafrost_slow_particles) do
        v.LocalTransparencyModifier = 1 + -1 * v32;
    end;
end;

function u1._UpdateInvincibilityVisual(p34) -- Line: 248
    -- upvalues: Attachment (copy)
    if p34:Get("IsInvincible") or not p34._invincibility_visual then
        if p34:Get("IsInvincible") and not p34._invincibility_visual then
            p34._invincibility_visual = Attachment:Clone();
            p34._invincibility_visual.Parent = p34.RootPart;
        end;

        return;
    end;

    p34._invincibility_visual:Destroy();
    p34._invincibility_visual = nil;
end;

function u1._PlayFinisher(p35, p36, p37, p38, p39) -- Line: 258
    -- upvalues: Finishers (copy), CONSTANTS (copy)
    local v40 = p35.Humanoid or p35.RootPart;

    if not (v40 and v40:IsDescendantOf(workspace)) then
        return;
    end;

    if p35._current_finisher then
        p35._current_finisher:Destroy();
    end;

    p35._current_finisher = require(Finishers[p36]).new(v40, p37, p38);
    p35._current_finisher:SetSerial(p39);

    if CONSTANTS.IS_STUDIO then
        p35._current_finisher:PlayClient();

        return;
    end;

    pcall(p35._current_finisher.PlayClient, p35._current_finisher);
end;

function u1._SlowEffect(p41, p42) -- Line: 279
    -- upvalues: SlowParticles (copy), BetterDebris (copy)
    for _, child in pairs(SlowParticles:GetChildren()) do
        local v43 = child:Clone();
        v43.Parent = p41.RootPart;
        BetterDebris:AddItem(v43, p42);
    end;
end;

function u1._BlipEffect(p44, p45, p46, p47, p48) -- Line: 287
    -- upvalues: BlipEffects (copy), BetterDebris (copy), Utility (copy), WrapController (copy)
    local v49 = p48 and p44.ClientFighter and p44.ClientFighter:GetItem(p48);

    if v49 then
        v49 = v49:GetWrap();
    end;

    for _, v in pairs({ p45, p46 }) do
        local v50 = (BlipEffects:FindFirstChild(p47) or BlipEffects.Default):Clone();
        v50.CFrame = v or p44.RootPart.CFrame;
        v50.Parent = workspace;
        BetterDebris:AddItem(v50, 5);
        Utility:PlayParticles(v50);

        if v49 then
            WrapController:ApplyWrap(WrapController:RecordOriginalWrapProperties(v50), v49, true);
        end;
    end;

    Utility:CreateSound("rbxassetid://123181974576488", 1, 1.5 + 0.2 * math.random(), p44.RootPart, true, 5);
end;

function u1._ThawFreezeEffect(u51, u52) -- Line: 306
    -- upvalues: BetterDebris (copy), RunService (copy)
    if u51._thaw_highlight then
        u51._thaw_highlight:Destroy();
        u51._thaw_highlight = nil;
    end;

    if u52 and u52 > 0 then
        u51._thaw_highlight = Instance.new("Highlight");
        u51._thaw_highlight.FillColor = Color3.fromRGB(161, 222, 255);
        u51._thaw_highlight.OutlineColor = Color3.fromRGB(0, 200, 255);
        u51._thaw_highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
        u51._thaw_highlight.Adornee = u51.Model;
        u51._thaw_highlight.Parent = u51.Model;
        BetterDebris:AddItem(u51._thaw_highlight, u52);
        task.spawn(function() -- Line: 321
            -- upvalues: u51 (copy), u52 (copy), RunService (ref)
            local _thaw_highlight = u51._thaw_highlight;
            local v53 = tick();

            while tick() < v53 + u52 do
                local v54 = ((tick() - v53) / u52) ^ 4;
                _thaw_highlight.FillTransparency = 0.5 + 0.5 * v54;
                _thaw_highlight.OutlineTransparency = 0 + 1 * v54;
                RunService.RenderStepped:Wait();
            end;
        end);
    end;

    if u51._thaw_callback then
        pcall(u51._thaw_callback, u51);
        u51._thaw_callback = nil;
    end;
end;

function u1._FreezeEffect(u55, p56, u57) -- Line: 342
    -- upvalues: FreezeEffects (copy), BetterDebris (copy), Utility (copy)
    u55:_ThawFreezeEffect();
    local u58 = (FreezeEffects:FindFirstChild(u57 or "Default") or FreezeEffects.Default):Clone();
    u58.PrimaryPart = u58.Primary;

    for _, descendant in pairs(u58:GetDescendants()) do
        if descendant:IsA("BasePart") then
            descendant.CanCollide = false;
            descendant.CanTouch = false;
            descendant.CanQuery = false;
            descendant.CanTouch = false;
            descendant.Massless = true;
            descendant.Anchored = false;

            if descendant ~= u58.PrimaryPart then
                local WeldConstraint = Instance.new("WeldConstraint");
                WeldConstraint.Part0 = u58.PrimaryPart;
                WeldConstraint.Part1 = descendant;
                WeldConstraint.Parent = u58.PrimaryPart;
            end;
        end;
    end;

    u58:SetPrimaryPartCFrame(u55.RootPart.CFrame);
    u58.Parent = workspace;
    BetterDebris:AddItem(u58, p56 + 3);
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = u55.RootPart;
    WeldConstraint.Part1 = u58.PrimaryPart;
    WeldConstraint.Parent = u58;

    if u57 == "Bubble" or u57 == "Gum" then
        function u55._thaw_callback() -- Line: 380
            -- upvalues: u58 (copy), BetterDebris (ref), Utility (ref)
            if not u58.PrimaryPart then
                u58:Destroy();

                return;
            end;

            BetterDebris:AddItem(u58, 2);
            Utility:CreateSound("rbxassetid://18763517194", 1, 1, u58.PrimaryPart and u58.PrimaryPart.Position, true, 10);
            local Size = u58.PrimaryPart.Size;
            Utility:RenderstepForLoop(0, 100, 10, function(p59) -- Line: 391
                -- upvalues: u58 (ref), Size (copy)
                if not u58.PrimaryPart then
                    return true;
                end;

                local v60 = 1 - (1 - p59 / 100) ^ 3;
                u58.PrimaryPart.Transparency = 0.5 + 0.5 * v60;
                u58.PrimaryPart.Size = Size * (1 + 2 * v60);
            end);
            u58:Destroy();
        end;
    elseif u57 == "Temporal" then
        Utility:CreateSound("rbxassetid://18431054727", 1.5, 1 + 0.1 * math.random(), u58.PrimaryPart, true, 10);
        Utility:CreateSound("rbxassetid://8571334160", 0.75, 1.2, u58.PrimaryPart, true, 10);

        function u55._thaw_callback() -- Line: 408
            -- upvalues: u58 (copy), BetterDebris (ref), Utility (ref)
            if not u58.PrimaryPart then
                u58:Destroy();

                return;
            end;

            BetterDebris:AddItem(u58, 2);
            Utility:CreateSound("rbxassetid://8571436177", 0.5, 2, u58.PrimaryPart and u58.PrimaryPart.Position, true, 10);
            local Size = u58.PrimaryPart.Size;
            Utility:RenderstepForLoop(0, 100, 5, function(p61) -- Line: 419
                -- upvalues: u58 (ref), Size (copy)
                if not u58.PrimaryPart then
                    return true;
                end;

                local v62 = (p61 / 100) ^ 3;
                u58.PrimaryPart.Transparency = v62;
                u58.PrimaryPart.Size = Size * (1 + 2 * v62);
            end);
            u58:Destroy();
        end;
    elseif u57 == "Cocoon" then
        function u55._thaw_callback() -- Line: 433
            -- upvalues: u58 (copy), BetterDebris (ref), Utility (ref)
            local Cocoon = u58:FindFirstChild("Cocoon");

            if not Cocoon then
                u58:Destroy();

                return;
            end;

            Cocoon.Transparency = 1;
            BetterDebris:AddItem(u58, 2);
            Utility:PlayParticles(Cocoon);
        end;
    elseif u57 == "SandBucket" then
        function u55._thaw_callback() -- Line: 446
            -- upvalues: u58 (copy)
            u58:Destroy();
        end;
    elseif u57 == "Wires" or (u57 == "Ropes" or (u57 == "WhiteWires" or u57 == "PurpleWires")) then
        function u55._thaw_callback() -- Line: 450
            -- upvalues: u58 (copy)
            u58:Destroy();
        end;
    elseif u57 == "Selection" then
        function u55._thaw_callback() -- Line: 454
            -- upvalues: u58 (copy)
            u58:Destroy();
        end;
    elseif u57 == "Starforge" then
        function u55._thaw_callback() -- Line: 458
            -- upvalues: u58 (copy)
            u58:Destroy();
        end;
    else
        if u57 == "Wrapped" then
            Utility:CreateSound("rbxassetid://74885181688460", 0.875, 1 + 0.1 * math.random(), u58.PrimaryPart, true, 5);
        else
            Utility:CreateSound("rbxassetid://18429138544", 0.75, 2 + 0.5 * math.random(), u58.PrimaryPart, true, 10);
        end;

        function u55._thaw_callback() -- Line: 468
            -- upvalues: u58 (copy), BetterDebris (ref), u57 (copy), Utility (ref)
            if not u58.PrimaryPart then
                u58:Destroy();

                return;
            end;

            BetterDebris:AddItem(u58, 2);
            local Position = u58.PrimaryPart.Position;
            u58.PrimaryPart:Destroy();

            for _, child in pairs(u58:GetChildren()) do
                if child:IsA("BasePart") then
                    child.Velocity = CFrame.new(Position, child.Position).LookVector * (25 + 25 * math.random());
                    child.RotVelocity = CFrame.Angles(math.random() * 3.141592653589793 * 2, math.random() * 3.141592653589793 * 2, math.random() * 3.141592653589793 * 2).LookVector * (10 + 10 * math.random());
                end;
            end;

            if u57 == "Wrapped" then
                Utility:CreateSound("rbxassetid://121822631205080", 0.875, 1, Position, true, 10);

                return;
            end;

            Utility:CreateSound("rbxassetid://135970869546121", 0.875, 1, Position, true, 10);
        end;
    end;

    local _thaw_callback = u55._thaw_callback;
    task.delay(p56, function() -- Line: 497
        -- upvalues: u55 (copy), _thaw_callback (copy)
        if u55._thaw_callback ~= _thaw_callback then
            return;
        end;

        u55._thaw_callback = nil;
        _thaw_callback();
    end);
end;

function u1._ExtinguishEffect(p63) -- Line: 507
    -- upvalues: ExtinguishParticles (copy), BetterDebris (copy), Utility (copy)
    for _, v in pairs(p63._burn_effect_particles) do
        v:Destroy();
    end;

    p63._burn_effect_particles = {};
    p63._burn_effect_finish = 0;

    if p63._burn_effect_sound then
        p63._burn_effect_sound:Destroy();
        p63._burn_effect_sound = nil;
    end;

    local v64 = ExtinguishParticles:Clone();
    v64.CFrame = p63.RootPart.CFrame;
    v64.Parent = workspace;
    BetterDebris:AddItem(v64, 10);
    Utility:CreateSound("rbxassetid://16812185839", 0.75, 1.3 + 0.2 * math.random(), v64, true);
    Utility:CreateSound("rbxassetid://16812389263", 0.75, 1.3 + 0.2 * math.random(), v64, true);
    Utility:PlayParticles(v64.Attachment);
end;

function u1._BurnEffect(p65, p66, p67, p68) -- Line: 531
    -- upvalues: Utility (copy), BurningEffects (copy), BetterDebris (copy), WrapController (copy)
    if p67 then
        p67 = p65:FromEnum(p67);
    end;

    local v69 = tick() < p65._burn_effect_finish;

    if p65._burn_effect_sound then
        p65._burn_effect_sound:Destroy();
    end;

    p65._burn_effect_sound = Utility:CreateSound("rbxassetid://13702989275", 0.25, 0.9 + 0.2 * math.random(), p65.RootPart, true, 10);
    p65._burn_effect_finish = tick() + p66;

    if v69 then
        return;
    end;

    local v70 = p65.RootPart.Size.Y / 2;
    local v71 = {};

    for _, child in pairs((BurningEffects:FindFirstChild(p67 or "Default") or BurningEffects.Default):GetChildren()) do
        if child:IsA("ParticleEmitter") then
            local v72 = child:Clone();
            v72.Parent = p65.RootPart;
            table.insert(v71, v72);
            Utility:ScaleParticleEmitter(v72, v70);
        elseif child:IsA("Light") then
            local v73 = child:Clone();
            v73.Range = v73.Range * v70;
            v73.Parent = p65.RootPart;
            BetterDebris:AddItem(v73, p66 + 4);
            table.insert(v71, v73);
        end;
    end;

    if p68 then
        WrapController:ApplyWrap(WrapController:RecordOriginalWrapProperties(v71), p68, true);
    end;

    p65._burn_effect_particles = v71;
    p65.BurnEffectPlaying:Fire(p65._burn_effect_particles);

    while tick() < p65._burn_effect_finish do
        wait(p65._burn_effect_finish - tick());
    end;

    for _, v in pairs(v71) do
        if v:IsA("ParticleEmitter") then
            v.Enabled = false;
            BetterDebris:AddItem(v, v.Lifetime.Max / v.TimeScale);
        elseif v:IsA("Light") then
            task.spawn(function() -- Line: 580
                -- upvalues: v (copy), Utility (ref)
                local Brightness = v.Brightness;
                Utility:RenderstepForLoop(0, 100, 1, function(p74) -- Line: 583
                    -- upvalues: v (ref), Brightness (copy)
                    v.Brightness = Brightness * (1 - p74 / 100);
                end);
                v:Destroy();
            end);
        end;
    end;

    p65._burn_effect_sound = nil;
end;

function u1._HealEffect(p75) -- Line: 597
    -- upvalues: Utility (copy)
    local Highlight = Instance.new("Highlight");
    Highlight.FillColor = Color3.fromRGB(100, 255, 50);
    Highlight.OutlineColor = Color3.fromRGB(179, 255, 153);
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.Adornee = p75.Model;
    Highlight.Parent = p75.Model;
    Utility:RenderstepForLoop(0, 100, 2, function(p76) -- Line: 605
        -- upvalues: Highlight (copy)
        local v77 = p76 / 100;
        Highlight.OutlineTransparency = v77;
        Highlight.FillTransparency = v77;
    end);
    Highlight:Destroy();
end;

function u1._HurtEffect(p78, p79) -- Line: 616
    -- upvalues: Utility (copy), GameplayUtility (copy)
    local v80 = p79[utf8.char(0)] or 0;

    if math.abs(v80) < 0.001 then
        return;
    end;

    if p79[utf8.char(1)] and (not p78._is_hidden and p78._headshot_particles) then
        Utility:PlayParticles(p78._headshot_particles);
    end;

    if #GameplayUtility:GetSmokeCloudsInSphere(p78.RootPart.Position) > 0 then
        return;
    end;

    p78._hurt_effect_hash = p78._hurt_effect_hash + 1;
    local _hurt_effect_hash = p78._hurt_effect_hash;

    if not p78.Model.Parent then
        return;
    end;

    p78._model_original_parent_hurt_effect = p78._model_original_parent_hurt_effect or p78.Model.Parent;
    p78.Model.Parent = workspace.HurtEffect;
    workspace.HurtEffect:SetAttribute("PlayHurtEffect", workspace.HurtEffect:GetAttribute("PlayHurtEffect") + 1);
    wait(1);

    if p78._hurt_effect_hash ~= _hurt_effect_hash or not p78.Model.Parent then
        return;
    end;

    p78.Model.Parent = p78._model_original_parent_hurt_effect;
    p78._model_original_parent_hurt_effect = nil;
end;

function u1._PotentialHitboxAdded(u81, u82) -- Line: 651
    -- upvalues: CollectionService (copy)
    if not u82:IsA("BasePart") then
        return;
    end;

    local function check() -- Line: 656
        -- upvalues: CollectionService (ref), u82 (copy), u81 (copy)
        if not CollectionService:HasTag(u82, "EntityHitbox") then
            return;
        end;

        local v83;

        if u82:GetAttribute("IsSmallHitbox") then
            v83 = u81._hitboxes_small;
        else
            v83 = u81._hitboxes;
        end;

        if not table.find(v83, u82) then
            table.insert(v83, u82);
        end;
    end;

    u82:GetAttributeChangedSignal("EntityHitboxUpdate"):Connect(check);
    check();
end;

function u1._Setup(u84) -- Line: 672
    if u84.Model then
        u84.Model.DescendantAdded:Connect(function(p85) -- Line: 674
            -- upvalues: u84 (copy)
            u84:_PotentialHitboxAdded(p85);
        end);

        for _, descendant in pairs(u84.Model:GetDescendants()) do
            u84:_PotentialHitboxAdded(descendant);
        end;
    end;
end;

function u1._Init(u86) -- Line: 684
    u86.Died:Connect(function() -- Line: 685
        -- upvalues: u86 (copy)
        u86.HealthChanged:Fire();
        u86:_UpdatePermafrostSlowStacks();
    end);
    u86:GetDataChangedSignal("IsInvincible"):Connect(function() -- Line: 690
        -- upvalues: u86 (copy)
        u86:_UpdateInvincibilityVisual();
    end);
    u86:GetDataChangedSignal("ReplicatedExternalGameplayData"):Connect(function() -- Line: 694
        -- upvalues: u86 (copy)
        u86:_UpdatePermafrostSlowStacks();
    end);
    u86:_Setup();
    u86:_UpdateInvincibilityVisual();
    task.defer(u86._UpdatePermafrostSlowStacks, u86);
end;

return u1;