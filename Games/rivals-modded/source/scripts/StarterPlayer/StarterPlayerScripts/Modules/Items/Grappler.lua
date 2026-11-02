-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local AnimationLibrary = require(ReplicatedStorage.Modules.AnimationLibrary);
local GameplayUtility = require(ReplicatedStorage.Modules.GameplayUtility);
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Utility = require(ReplicatedStorage.Modules.Utility);
local WrapController = require(Players.LocalPlayer.PlayerScripts.Controllers.WrapController);
local Custom = require(Players.LocalPlayer.PlayerScripts.Modules.ItemTypes.Custom);
local Projectiles = Players.LocalPlayer.PlayerScripts.Assets:WaitForChild("Projectiles");
local u1 = setmetatable({}, Custom);
u1.__index = u1;

function u1.new(...) -- Line: 17
    -- upvalues: Custom (copy), u1 (copy)
    local v2 = Custom.new(...);
    local v3 = setmetatable(v2, u1);
    v3.Data.GrapplingHookPartActive = false;
    v3._use_cooldown = 0;
    v3._use_cooldown_hash = 0;
    v3._use_animation_hash = 0;
    v3._current_hook_connections = {};
    v3._current_hook_part = nil;
    v3._current_hook_velocity = nil;
    v3:_Init();

    return v3;
end;

function u1.GetAutoShootReactionTime(p4) -- Line: 38
    return nil;
end;

function u1.CanQuickAttack(p5) -- Line: 42
    local v6;

    if tick() > p5._use_cooldown then
        v6 = not p5:IsEquipping();
    else
        v6 = false;
    end;

    return v6;
end;

function u1.StartShooting(u7, p8) -- Line: 46
    -- upvalues: AnimationLibrary (copy), Utility (copy)
    if not (p8 or tick() >= u7._use_cooldown and not u7:IsEquipping()) then
        return false;
    end;

    u7._use_cooldown_hash = u7._use_cooldown_hash + 1;
    u7._use_animation_hash = u7._use_animation_hash + 1;
    local _use_cooldown_hash = u7._use_cooldown_hash;
    local _use_animation_hash = u7._use_animation_hash;
    local v9 = u7.Info.HookRange / u7.Info.HookSpeed;
    u7._use_cooldown = tick() + v9 + u7.Info.MissedCooldown;
    u7:CooldownEffect("rbxassetid://101933751328343", v9, "Cooldown", true);
    u7.ViewModel:StopAnimation("Inspect", 0);
    u7.ViewModel:StopAnimation("Equip", 0);
    u7.ViewModel:StopAnimation("Inspect", 0);
    u7.ViewModel:StopAnimation("Pull", 0);
    task.spawn(function() -- Line: 65
        -- upvalues: u7 (copy), AnimationLibrary (ref), _use_animation_hash (copy)
        if u7.ViewModel.Info.Animations.ShootMissed then
            u7.ViewModel:StopAnimation("ShootMissed", 0);
        end;

        u7.ViewModel:PlayAnimation("Shoot");

        if u7.ViewModel.Info.Animations.ShootWaiting then
            wait(AnimationLibrary.Info[u7.ViewModel.Info.Animations.Shoot].Length);

            if not u7.IsEquipped or _use_animation_hash ~= u7._use_animation_hash then
                return;
            end;

            u7.ViewModel:PlayAnimation("ShootWaiting");
        end;
    end);
    task.delay(v9, function() -- Line: 84
        -- upvalues: u7 (copy), _use_cooldown_hash (copy)
        if u7._use_cooldown_hash ~= _use_cooldown_hash then
            return;
        end;

        u7:CooldownEffect("rbxassetid://101933751328343", u7.Info.MissedCooldown, "Cooldown");
    end);
    local CameraData = u7.ClientFighter:GetCameraData();

    if u7.ClientFighter.IsLocalPlayer then
        u7:_ShootHookEffect(Utility:DecodeCFrame(CameraData[utf8.char(0)]));
    else
        local v10 = u7.ClientFighter.Entity and (u7.ClientFighter.Entity.Head or u7.ClientFighter.Entity.RootPart);

        if v10 then
            u7:_ShootHookEffect(CFrame.new(v10.Position) * u7.ClientFighter:GetRotationCFrame());
        end;
    end;

    return true, "StartShooting", CameraData;
end;

function u1.Unequip(p11, ...) -- Line: 107
    -- upvalues: Custom (copy)
    p11._use_animation_hash = p11._use_animation_hash + 1;
    Custom.Unequip(p11, ...);
end;

function u1.ReplicateFromServer(u12, p13, ...) -- Line: 112
    -- upvalues: BetterDebris (copy), RunService (copy), Custom (copy)
    if p13 == "GrapplerPull" then
        if not u12:IsRendered() then
            return;
        end;

        u12._use_animation_hash = u12._use_animation_hash + 1;

        if u12.ViewModel.Info.Animations.ShootWaiting then
            u12.ViewModel:StopAnimation("ShootWaiting", 0);
        end;

        if not u12.IsEquipped then
            return;
        end;

        local v14, _ = ...;
        local v15 = u12.ClientFighter.Entity and u12.ClientFighter.Entity:IsAlive() and u12.ClientFighter.Entity.RootPart.Position;
        u12:_Shake("GrapplerPull");
        u12.ViewModel:StopAnimation("Equip", 0);
        u12.ViewModel:StopAnimation("Inspect", 0);
        u12.ViewModel:StopAnimation("Shoot", 0);
        u12.ViewModel:PlayAnimation("Pull", 0.5);
        u12.ViewModel:PlayPullSounds();

        if not (v14 and (v15 and not v14:FuzzyEq(v15))) then
            u12:_DeleteHookPart();

            return;
        end;

        local v16 = (v14 - v15).Unit * u12.Info.SelfPullForce;
        local v17 = math.min(u12.Info.HookRange, (v14 - v15).Magnitude) / u12.Info.SelfPullForce;
        u12.ViewModel:HideHookSubModel(v17);

        if u12._current_hook_part and u12._current_hook_part:IsDescendantOf(workspace) then
            u12._current_hook_part.Anchored = true;
            u12._current_hook_part.CFrame = CFrame.new(v14, v15) * CFrame.Angles(0, 3.141592653589793, 0);
            BetterDebris:AddItem(u12._current_hook_part, v17);

            for _, descendant in pairs(u12._current_hook_part:GetDescendants()) do
                if descendant:IsA("SpringConstraint") then
                    descendant.Radius = 0;
                end;
            end;
        end;

        if u12.ItemInterface then
            u12.ItemInterface:PlaySpeedLines(v17);
        end;

        if u12.ClientFighter.IsLocalPlayer then
            u12.ClientFighter.Entity:HardDash(v16, v17, nil, nil, "GrapplerPull");
        end;
    else
        if p13 == "GrapplerTrackPart" then
            if not u12:IsRendered() then
                return;
            end;

            local u18, u19 = ...;

            if not (u18 and (u12._current_hook_part and (u12._current_hook_velocity and not u12._destroyed))) then
                return;
            end;

            table.insert(u12._current_hook_connections, RunService.Heartbeat:Connect(function(p20) -- Line: 181
                -- upvalues: u12 (copy), u18 (copy), u19 (copy)
                if not (u12._current_hook_part and u12._current_hook_velocity) then
                    return;
                end;

                local v21 = u18.Position + u19;

                if not u12._current_hook_part.Position:FuzzyEq(v21) then
                    u12._current_hook_velocity.Velocity = CFrame.new(u12._current_hook_part.Position, v21).LookVector * u12._current_hook_velocity.Velocity.Magnitude;
                end;
            end));

            return;
        end;

        if p13 == "GrapplerCooldown" then
            if not u12:IsRendered() then
                return;
            end;

            u12._use_cooldown_hash = u12._use_cooldown_hash + 1;
            u12._use_cooldown = tick() + ...;
            u12:CooldownEffect("rbxassetid://101933751328343", u12.Info.Cooldown, "Cooldown");

            return;
        end;

        if p13 == "GrapplerMiss" then
            if not u12:IsRendered() then
                return;
            end;

            local u22 = u12.Info.HookRange / u12.Info.HookSpeed;

            if u12._current_hook_part then
                BetterDebris:AddItem(u12._current_hook_part, u22);
            end;

            task.spawn(function() -- Line: 213
                -- upvalues: u12 (copy), u22 (copy)
                local _use_animation_hash = u12._use_animation_hash;
                wait(u22);

                if _use_animation_hash ~= u12._use_animation_hash then
                    return;
                end;

                local v23 = u12;
                v23._use_animation_hash = v23._use_animation_hash + 1;
                local v24 = u12.ViewModel.Info.Animations.ShootMissed and 0 or nil;
                u12.ViewModel:StopAnimation("Shoot", v24);

                if u12.ViewModel.Info.Animations.ShootWaiting then
                    u12.ViewModel:StopAnimation("ShootWaiting", v24);
                end;

                if u12.ViewModel.Info.Animations.ShootMissed then
                    u12.ViewModel:PlayAnimation("ShootMissed");
                end;
            end);

            return;
        end;

        Custom.ReplicateFromServer(u12, p13, ...);
    end;
end;

function u1.Destroy(p25) -- Line: 241
    -- upvalues: Custom (copy)
    p25:_DeleteHookPart();
    Custom.Destroy(p25);
end;

function u1._UpdateHookPartExistence(p26) -- Line: 250
    if p26._current_hook_part then
        p26.ViewModel.Animator:SetInspectCooldown((1 / 0));

        return;
    end;

    p26.ViewModel.Animator:SetInspectCooldown(0);
end;

function u1._CheckCancelHooking(p27) -- Line: 258
    if p27.IsEquipped then
        return;
    end;

    p27:_DeleteHookPart();

    if p27.ItemInterface then
        p27.ItemInterface:PlaySpeedLines(0);
    end;

    p27.ClientFighter.Entity.Gameplay:CancelHardDash("GrapplerPull");
end;

function u1._DeleteHookPart(p28) -- Line: 272
    for _, v in pairs(p28._current_hook_connections) do
        v:Disconnect();
    end;

    p28._current_hook_connections = {};
    p28._current_hook_velocity = nil;

    if p28._current_hook_part then
        p28._current_hook_part:Destroy();
        p28._current_hook_part = nil;
        p28:SetReplicate("GrapplingHookPartActive", false);
    end;

    p28.ViewModel:HideHookSubModel(0);
end;

function u1._ShootHookEffect(u29) -- Line: 289
    -- upvalues: GameplayUtility (copy), BetterDebris (copy), Projectiles (copy), RunService (copy), WrapController (copy)
    u29:_DeleteHookPart();
    local v30 = nil;
    local v31 = nil;

    if u29.ClientFighter.IsLocalPlayer then
        local CameraData = u29.ClientFighter:GetCameraData(nil, nil, true);
        v30 = (CameraData[utf8.char(0)] * CFrame.new(0.5, -0.75, -1)).Position;
        v31 = GameplayUtility:GetMousePositionFromCameraData(u29.ClientFighter:Get("EnvironmentID"), u29.ClientFighter:GetEntityLookupParams(), CameraData[utf8.char(0)], CameraData[utf8.char(1)], CameraData[utf8.char(2)], CameraData[utf8.char(3)]);
    else
        local v32 = u29.ClientFighter.Entity and (u29.ClientFighter.Entity.Head or u29.ClientFighter.Entity.RootPart);

        if v32 then
            local v33 = CFrame.new(v32.Position) * u29.ClientFighter:GetRotationCFrame();
            v30 = v33.Position;
            v31 = GameplayUtility:GetMousePositionFromCameraData(u29.ClientFighter:Get("EnvironmentID"), u29.ClientFighter:GetEntityLookupParams(), v33, v33);
        end;
    end;

    if not (v30 and (v31 and not v30:FuzzyEq(v31))) then
        return;
    end;

    local CFrame_new_ret = CFrame.new(v30, v31);
    local v34 = u29.Info.HookRange / u29.Info.HookSpeed + 1;
    u29.ViewModel:HideHookSubModel(v34);
    u29._current_hook_part = Instance.new("Part");
    u29._current_hook_part.Name = "Hook";
    u29._current_hook_part.Size = Vector3.new(1, 1, 1);
    u29._current_hook_part.Transparency = 1;
    u29._current_hook_part.CFrame = CFrame_new_ret;
    u29._current_hook_part.CanCollide = false;
    u29._current_hook_part.CanTouch = false;
    u29._current_hook_part.CanQuery = false;
    u29._current_hook_part.Parent = workspace;
    BetterDebris:AddItem(u29._current_hook_part, v34);
    u29:SetReplicate("GrapplingHookPartActive", true);
    u29._current_hook_part.Destroying:Connect(function() -- Line: 332
        -- upvalues: u29 (copy)
        task.defer(u29._DeleteHookPart, u29);
    end);
    u29._current_hook_velocity = Instance.new("BodyVelocity");
    u29._current_hook_velocity.Velocity = u29._current_hook_part.CFrame.LookVector * u29.Info.HookSpeed;
    u29._current_hook_velocity.MaxForce = Vector3.new(100000, 100000, 100000);
    u29._current_hook_velocity.Parent = u29._current_hook_part;
    local v35 = (Projectiles:FindFirstChild(u29.ViewModel.Name) or Projectiles[u29.Name]):Clone();
    v35.PrimaryPart = v35.Primary;
    v35:PivotTo(u29._current_hook_part.CFrame);

    for _, descendant in pairs(v35:GetDescendants()) do
        if descendant:IsA("BasePart") then
            local WeldConstraint = Instance.new("WeldConstraint");
            WeldConstraint.Part0 = u29._current_hook_part;
            WeldConstraint.Part1 = descendant;
            WeldConstraint.Parent = descendant;
            descendant.CanCollide = false;
            descendant.CanTouch = false;
            descendant.CanQuery = false;
            descendant.Massless = true;
            descendant.Anchored = false;
        end;
    end;

    local MuzzleAttachment = u29.ViewModel:GetMuzzleAttachment();
    local _to_muzzle = v35:FindFirstChild("_to_muzzle", true);
    local u36 = u29.ClientFighter.Entity and u29.ClientFighter.Entity.RootPart;

    if MuzzleAttachment and (_to_muzzle and u36) then
        BetterDebris:AddItem(_to_muzzle, v34);

        local function update_parent() -- Line: 368
            -- upvalues: MuzzleAttachment (copy), u29 (copy), u36 (copy), _to_muzzle (copy)
            task.spawn(pcall, function() -- Line: 369
                -- upvalues: MuzzleAttachment (ref), u29 (ref), u36 (ref), _to_muzzle (ref)
                local v37 = MuzzleAttachment:IsDescendantOf(workspace) and u29.IsEquipped and (MuzzleAttachment.WorldPosition - u36.Position).Magnitude < 32;

                if v37 then
                    _to_muzzle.Parent = MuzzleAttachment;
                    _to_muzzle.WorldCFrame = MuzzleAttachment.WorldCFrame;

                    return;
                end;

                _to_muzzle.Parent = u36;
                _to_muzzle.WorldCFrame = u36.CFrame;
            end);
        end;

        local u38 = 0;
        table.insert(u29._current_hook_connections, RunService.RenderStepped:Connect(function() -- Line: 384
            -- upvalues: u38 (ref), MuzzleAttachment (copy), u29 (copy), u36 (copy), _to_muzzle (copy)
            if tick() < u38 then
                return;
            end;

            u38 = tick() + 0.1;
            task.spawn(pcall, function() -- Line: 369
                -- upvalues: MuzzleAttachment (ref), u29 (ref), u36 (ref), _to_muzzle (ref)
                local v39 = MuzzleAttachment:IsDescendantOf(workspace) and u29.IsEquipped and (MuzzleAttachment.WorldPosition - u36.Position).Magnitude < 32;

                if v39 then
                    _to_muzzle.Parent = MuzzleAttachment;
                    _to_muzzle.WorldCFrame = MuzzleAttachment.WorldCFrame;

                    return;
                end;

                _to_muzzle.Parent = u36;
                _to_muzzle.WorldCFrame = u36.CFrame;
            end);
        end));
        table.insert(u29._current_hook_connections, u29.ClientFighter.EquippedItemChanged:Connect(update_parent));
        table.insert(u29._current_hook_connections, MuzzleAttachment.AncestryChanged:Connect(update_parent));
        task.spawn(pcall, function() -- Line: 369
            -- upvalues: MuzzleAttachment (copy), u29 (copy), u36 (copy), _to_muzzle (copy)
            local v40 = MuzzleAttachment:IsDescendantOf(workspace) and u29.IsEquipped and (MuzzleAttachment.WorldPosition - u36.Position).Magnitude < 32;

            if v40 then
                _to_muzzle.Parent = MuzzleAttachment;
                _to_muzzle.WorldCFrame = MuzzleAttachment.WorldCFrame;

                return;
            end;

            _to_muzzle.Parent = u36;
            _to_muzzle.WorldCFrame = u36.CFrame;
        end);
    end;

    v35.Parent = u29._current_hook_part;
    WrapController:ApplyWrap(WrapController:RecordOriginalWrapProperties(v35), u29:GetWrap(), true);
    u29.ViewModel:PlayShootSounds();
end;

function u1._Init(u41) -- Line: 403
    u41:GetDataChangedSignal("GrapplingHookPartActive"):Connect(function() -- Line: 404
        -- upvalues: u41 (copy)
        u41:_UpdateHookPartExistence();
    end);
    u41.EquippedChanged:Connect(function() -- Line: 408
        -- upvalues: u41 (copy)
        u41:_CheckCancelHooking();
    end);
    u41:_UpdateHookPartExistence();
end;

return u1;