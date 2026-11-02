-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local AnimationLibrary = require(ReplicatedStorage.Modules.AnimationLibrary);
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Utility = require(ReplicatedStorage.Modules.Utility);
local Spring = require(ReplicatedStorage.Modules.Spring);
local Signal = require(ReplicatedStorage.Modules.Signal);
local WrapController = require(Players.LocalPlayer.PlayerScripts.Controllers.WrapController);
local ClientItem = require(Players.LocalPlayer.PlayerScripts.Modules.ClientReplicatedClasses.ClientFighter.ClientItem);
local TrajectoryVisual = require(Players.LocalPlayer.PlayerScripts.Modules.TrajectoryVisual);
local Throwables = Players.LocalPlayer.PlayerScripts.Assets:WaitForChild("Throwables");
local CFrame_new_ret = CFrame.new(0.75, -0.5, 0);
local u1 = setmetatable({}, ClientItem);
u1.__index = u1;

function u1.new(...) -- Line: 20
    -- upvalues: ClientItem (copy), u1 (copy), Signal (copy)
    local v2 = ClientItem.new(...);
    local v3 = setmetatable(v2, u1);
    v3.ProjectileThrown = Signal.new();
    v3._is_throwing = nil;
    v3._throw_type = nil;
    v3._throw_cooldown = 0;
    v3._throw_hash = 0;
    v3._trajectory_visual = nil;
    v3._cook_detonate_delay = v3.Info.CanCook and v3.Info.DetonateDelay;
    v3:_Init();

    return v3;
end;

function u1.GetAutoShootReactionTime(p4) -- Line: 41
    return nil;
end;

function u1.CanQuickAttack(p5) -- Line: 45
    local v6 = not p5._is_throwing;

    if v6 then
        if tick() > p5._throw_cooldown and (p5:Get("Ammo") or (1 / 0)) > 0 then
            v6 = not p5:IsEquipping();
        else
            v6 = false;
        end;
    end;

    return v6;
end;

function u1.StartShooting(p7, p8) -- Line: 49
    if not p8 and (p7._is_throwing or (tick() < p7._throw_cooldown or ((p7:Get("Ammo") or (1 / 0)) <= 0 or p7:IsEquipping()))) then
        return false;
    end;

    p7._throw_type = "Throw";
    p7:_StartThrow("ThrowStart", "ThrowIdle", p7.Info.ThrowMaxChargeTime, p7.Info.ThrowForceMin, p7.Info.ThrowForceMax, p7.Info.ThrowGravity, "FinishShooting");

    return true, "StartShooting";
end;

function u1.FinishShooting(p9, p10) -- Line: 60
    if not (p10 or p9._is_throwing and (tick() >= p9._throw_cooldown and ((p9:Get("Ammo") or (1 / 0)) > 0 and p9._throw_type == "Throw"))) then
        return false;
    end;

    p9._throw_type = nil;
    local v11, v12 = p9:_FinishThrow("ThrowStart", "ThrowIdle", "ThrowFinish", p9.Info.ThrowMaxChargeTime);

    if v11 then
        return true, "FinishShooting", p9:_GetThrowCameraCFrame(), v11, v12;
    end;

    return false;
end;

function u1.StartAiming(p13, p14) -- Line: 75
    if not p14 and (p13._is_throwing or (tick() < p13._throw_cooldown or ((p13:Get("Ammo") or (1 / 0)) <= 0 or p13:IsEquipping()))) then
        return false;
    end;

    p13._throw_type = "Lob";
    p13:_StartThrow("LobStart", "LobIdle", p13.Info.LobMaxChargeTime, p13.Info.LobForceMin, p13.Info.LobForceMax, p13.Info.LobGravity, "FinishAiming");

    return true, "StartAiming";
end;

function u1.FinishAiming(p15, p16) -- Line: 86
    if not (p16 or p15._is_throwing and (tick() >= p15._throw_cooldown and ((p15:Get("Ammo") or (1 / 0)) > 0 and p15._throw_type == "Lob"))) then
        return false;
    end;

    p15._throw_type = nil;
    local v17, v18 = p15:_FinishThrow("LobStart", "LobIdle", "LobFinish", p15.Info.LobMaxChargeTime);

    if v17 then
        return true, "FinishAiming", p15:_GetThrowCameraCFrame(), v17, v18;
    end;

    return false;
end;

function u1.Unequip(p19, ...) -- Line: 101
    -- upvalues: ClientItem (copy)
    p19:_CancelThrow();
    ClientItem.Unequip(p19, ...);
end;

function u1.ReplicateFromServer(u20, p21, ...) -- Line: 106
    -- upvalues: Throwables (copy), BetterDebris (copy), WrapController (copy), Spring (copy), RunService (copy), ClientItem (copy)
    if p21 ~= "ThrowEffect" then
        ClientItem.ReplicateFromServer(u20, p21, ...);

        return;
    end;

    if not u20:IsRendered() then
        return;
    end;

    local u22 = ...;

    if not u22 then
        return;
    end;

    u22.Transparency = 1;
    u22.CanCollide = false;
    local u23 = (Throwables:FindFirstChild(u20.ViewModel.Name) or Throwables[u20.Name]):Clone();
    u23.WorldPivot = u23.Primary.CFrame;
    u23.Parent = workspace;
    BetterDebris:AddItem(u23, u20.Info.Lifetime + 10);
    WrapController:ApplyWrap(WrapController:RecordOriginalWrapProperties(u23), u20:GetWrap(), true);

    for _, child in pairs(u23:GetChildren()) do
        child.CanCollide = false;
        child.CanTouch = false;
        child.CanQuery = false;
        child.Anchored = true;
    end;

    u20.ProjectileThrown:Fire(u22, u23);
    task.defer(function() -- Line: 136
        -- upvalues: u20 (copy), Spring (ref), u22 (copy), u23 (copy), RunService (ref), BetterDebris (ref)
        local v24 = u20.ClientFighter:IsActuallyFirstPerson();
        local v25 = Spring.new(u22.Position + (v24 and -u22.Velocity.Unit * 200 or Vector3.new(0, 0, 0)), 1, 40);
        local CFrame_Angles_ret = CFrame.Angles(math.random() * 3.141592653589793 * 2, math.random() * 3.141592653589793 * 2, math.random() * 3.141592653589793 * 2);
        local v26 = tick();
        local v27 = 0;
        local v28 = 0;
        local v29 = nil;
        local u30 = nil;

        local function update_throwable_orientation() -- Line: 148
            -- upvalues: u30 (ref), u22 (ref)
            u30 = u22:GetAttribute("ThrowableOrientation");
        end;

        u22:GetAttributeChangedSignal("ThrowableOrientation"):Connect(update_throwable_orientation);
        u30 = u22:GetAttribute("ThrowableOrientation");

        while u22:IsDescendantOf(workspace) do
            local v31 = (tick() - v26) * 1.5;
            local math_clamp_ret = math.clamp(v31, 0.01, 1);
            v25.Speed = math_clamp_ret * 60 + 40;
            v25.Target = u22.Position - workspace.CurrentCamera.CFrame.UpVector * (1 - math_clamp_ret) * 0.5;
            v27 = v27 + u22.Velocity.Magnitude * v28 * 0.25;
            v29 = u22.Velocity.Magnitude > 0.01 and CFrame.new(v25.Position, v25.Position + u22.Velocity) or CFrame.new(v25.Position) * (v29 and v29.Rotation or CFrame.identity);
            local v32 = v29 * CFrame_Angles_ret * CFrame.Angles(-v27, 0, 0);

            if u30 then
                v32 = CFrame.new(v32.Position) * u30.Rotation;
            end;

            if u20.ViewModel.Name == "Skullbang" and not v32.Position:FuzzyEq(workspace.CurrentCamera.CFrame.Position) then
                local CFrame_new_ret2 = CFrame.new(v32.Position, workspace.CurrentCamera.CFrame.Position);
                local v33 = 1.25 * (tick() - v26) / u20.Info.DetonateDelay;
                v32 = v32:Lerp(CFrame_new_ret2, (math.min(1, v33)));
            end;

            u23:ScaleTo(math_clamp_ret * 1.5);
            u23:PivotTo(v32);
            v28 = RunService.RenderStepped:Wait();
        end;

        local v34 = 0;

        for _, descendant in pairs(u23:GetDescendants()) do
            if descendant:IsA("BasePart") or (descendant:IsA("Texture") or (descendant:IsA("Beam") or descendant:IsA("Decal"))) then
                descendant.LocalTransparencyModifier = 1;
            elseif descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            elseif descendant:IsA("Trail") then
                v34 = math.max(v34, descendant.Lifetime);
            end;
        end;

        BetterDebris:AddItem(u23, v34);
    end);
end;

function u1.Destroy(p35) -- Line: 198
    -- upvalues: ClientItem (copy)
    p35.ProjectileThrown:Destroy();
    p35:_ClearTrajectoryVisual();
    ClientItem.Destroy(p35);
end;

function u1._CancelThrow(p36) -- Line: 208
    p36:_ClearTrajectoryVisual();

    if p36._is_throwing then
        p36._throw_type = nil;
        p36._is_throwing = nil;
        p36._throw_hash = p36._throw_hash + 1;
    end;

    p36.ViewModel:StopAnimation("ThrowStart");
    p36.ViewModel:StopAnimation("ThrowIdle");
    p36.ViewModel:StopAnimation("ThrowFinish");
    p36.ViewModel:StopAnimation("LobStart");
    p36.ViewModel:StopAnimation("LobIdle");
    p36.ViewModel:StopAnimation("LobFinish", nil, 0);
end;

function u1._FinishThrow(p37, p38, p39, p40, p41) -- Line: 225
    -- upvalues: AnimationLibrary (copy)
    p37:_ClearTrajectoryVisual();
    local _is_throwing = p37._is_throwing;

    if _is_throwing then
        local v42 = (tick() - p37._is_throwing) / p41;
        _is_throwing = math.clamp(v42, 0, 1);
    end;

    local v43 = p37._is_throwing and (p37._cook_detonate_delay and p37._is_throwing + (p37._cook_detonate_delay or 0) - tick() or p37.Info.DetonateDelay);
    p37._is_throwing = nil;
    p37._throw_cooldown = p37.Info.Cooldown and (tick() + p37.Info.Cooldown or 0) or 0;
    p37._throw_hash = p37._throw_hash + 1;
    p37.ViewModel:StopAnimation(p38, nil, 0);
    p37.ViewModel:StopAnimation(p39, nil, 0);

    if not (p37._cook_detonate_delay and (v43 and v43 <= 0)) then
        p37.ViewModel:PlayAnimation(p40, AnimationLibrary.Info[p37.ViewModel.Info.Animations[p40]].Length);
    end;

    if p37.Info.Cooldown then
        p37:CooldownEffect("rbxassetid://17156089790", p37.Info.Cooldown, "Throw");
    end;

    return _is_throwing, v43;
end;

function u1._StartThrow(u44, u45, u46, p47, p48, p49, p50, u51) -- Line: 249
    -- upvalues: AnimationLibrary (copy)
    u44._is_throwing = tick();
    u44._throw_hash = u44._throw_hash + 1;
    u44.ViewModel:StopAnimation("Equip");
    u44.ViewModel:PlayAnimation(u45, (1 / 0));

    if u44.ClientFighter.IsLocalPlayer then
        u44:_CreateTractoryVisual(p47, p48, p49, p50);
    end;

    local _throw_hash = u44._throw_hash;
    task.spawn(function() -- Line: 263
        -- upvalues: AnimationLibrary (ref), u44 (copy), u45 (copy), _throw_hash (copy), u46 (copy)
        wait(AnimationLibrary.Info[u44.ViewModel.Info.Animations[u45]].Length or 0.1);

        if _throw_hash ~= u44._throw_hash then
            return;
        end;

        u44.ViewModel:PlayAnimation(u46, nil, 0);
    end);

    if u44._cook_detonate_delay then
        task.delay(u44._cook_detonate_delay, function() -- Line: 275
            -- upvalues: _throw_hash (copy), u44 (copy), u51 (copy)
            if _throw_hash ~= u44._throw_hash then
                return;
            end;

            u44:SimulateInputFromGameplayMechanic(u51, true);
        end);
    end;
end;

function u1._GetThrowCameraCFrame(p52, p53, p54, p55) -- Line: 285
    -- upvalues: Utility (copy), CFrame_new_ret (copy)
    local CameraData = p52.ClientFighter:GetCameraData(p53, p54, true);
    local v56 = CameraData[utf8.char(0)];
    local v57 = CameraData[utf8.char(1)];
    local v58 = CameraData[utf8.char(2)];
    local v59 = CameraData[utf8.char(3)];

    if v58 then
        v58 = v58.CFrame * (v59 or CFrame.identity);
    end;

    if v58 then
        v57 = CFrame.new(v57.Position, v58.Position) or v57;
    end;

    local v60 = Utility:Raycast(v57.Position, v57.Position + v57.LookVector * 999, 999, p53, Enum.RaycastFilterType.Include);
    local v61 = CFrame.new(v56.Position, v60.Position) * CFrame_new_ret;

    if p55 then
        return v61;
    end;

    return Utility:EncodeCFrame(v61);
end;

function u1._ClearTrajectoryVisual(p62) -- Line: 296
    if p62._trajectory_visual then
        p62._trajectory_visual:Destroy();
        p62._trajectory_visual = nil;
    end;
end;

function u1._CreateTractoryVisual(u63, u64, u65, u66, u67) -- Line: 304
    -- upvalues: TrajectoryVisual (copy)
    u63:_ClearTrajectoryVisual();
    local RaycastWhitelist = u63.ClientFighter:GetRaycastWhitelist(true);
    u63._trajectory_visual = TrajectoryVisual.new();
    u63._trajectory_visual:OnStep(function() -- Line: 310
        -- upvalues: u63 (copy), RaycastWhitelist (copy), u64 (copy), u65 (copy), u66 (copy), u67 (copy)
        local v68 = u63:_GetThrowCameraCFrame(RaycastWhitelist, nil, true);
        local v69 = tick();
        local math_clamp_ret = math.clamp((v69 - (u63._is_throwing or u63._is_lobbing)) / u64, 0, 1);
        local v70;

        if u63._cook_detonate_delay then
            v70 = u63._is_throwing + u63._cook_detonate_delay - tick();
        else
            v70 = u63.Info.DetonateDelay;
        end;

        u63._trajectory_visual:Update(v68.Position, v68.LookVector * (u65 + (u66 - u65) * math_clamp_ret), workspace.Gravity * 0.5 * u67, nil, RaycastWhitelist, v70);
    end);
end;

function u1._Init(u71) -- Line: 320
    table.insert(u71._connections, u71.ClientFighter.Interrupted:Connect(function() -- Line: 321
        -- upvalues: u71 (copy)
        u71:_CancelThrow();
    end));
end;

return u1;