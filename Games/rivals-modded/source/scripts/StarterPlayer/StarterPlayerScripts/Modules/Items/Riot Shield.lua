-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
require(ReplicatedStorage.Modules.CosmeticLibrary);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local CameraController = require(Players.LocalPlayer.PlayerScripts.Controllers.CameraController);
local StaticViewModel = require(Players.LocalPlayer.PlayerScripts.Modules.StaticModel.StaticViewModel);
local Melee = require(Players.LocalPlayer.PlayerScripts.Modules.ItemTypes.Melee);
local u1 = setmetatable({}, Melee);
u1.__index = u1;

function u1.new(...) -- Line: 13
    -- upvalues: Melee (copy), u1 (copy)
    local v2 = Melee.new(...);
    local v3 = setmetatable(v2, u1);
    v3.UnequippedViewModel = nil;
    v3._shield_attached = false;
    v3._update_shield_queued = false;
    v3._is_broken = v3:Get("Ammo") <= 0;
    v3:_Init();

    return v3;
end;

function u1.ReplicateFromServer(p4, p5, ...) -- Line: 31
    -- upvalues: Melee (copy)
    if p5 ~= "AbsorbedHit" then
        Melee.ReplicateFromServer(p4, p5, ...);

        return;
    end;

    if not p4:IsRendered() then
        return;
    end;

    p4.ViewModel:Impulse(Vector3.new(0, -20, 0), 1, nil, true);
    p4.ViewModel:AbsorbedHit();
end;

function u1.Destroy(p6) -- Line: 44
    -- upvalues: Melee (copy)
    p6.UnequippedViewModel:Destroy();
    Melee.Destroy(p6);
end;

function u1._CheckBroken(p7) -- Line: 53
    local v8 = p7:Get("Ammo") <= 0;

    if p7._is_broken == v8 then
        return;
    end;

    p7._is_broken = v8;
    p7:_UpdateUnequippedViewModel();
    p7.ViewModel:ChangeEquipAnimation(p7._is_broken and p7.ViewModel.Info.Animations.EmptyEquip and "EmptyEquip" or "Equip");
    p7.ViewModel:ChangeInspectAnimation(p7._is_broken and p7.ViewModel.Info.Animations.EmptyInspect and "EmptyInspect" or "Inspect");
    p7.ViewModel:ChangeIdleAnimation(p7._is_broken and p7.ViewModel.Info.Animations.EmptyIdle and "EmptyIdle" or "Idle");
    p7.ViewModel:ChangeSprintAnimation(p7._is_broken and p7.ViewModel.Info.Animations.EmptySprint and "EmptySprint" or "Sprint");
    local v9;

    if p7._is_broken and p7.ViewModel.Info.Animations.EmptyIdle then
        v9 = CFrame.identity;
    else
        v9 = nil;
    end;

    p7.ViewModel:OverrideRootPartOffset(v9);

    if not p7._is_broken then
        return;
    end;

    p7.ViewModel:ShieldBroken();
end;

function u1._WaitForUnequippedViewModelRoot(p10) -- Line: 76
    local v11 = p10.ClientFighter.Entity and p10.ClientFighter.Entity.Model and p10.ClientFighter.Entity.Model:WaitForChild("UpperTorso");

    return v11;
end;

function u1._UpdateUnequippedViewModel(u12) -- Line: 80
    if not u12._shield_attached or u12._update_shield_queued then
        return;
    end;

    u12._update_shield_queued = true;
    task.delay(0.1, function() -- Line: 92
        -- upvalues: u12 (copy)
        u12._update_shield_queued = false;

        if u12._destroyed then
            return;
        end;

        local v13 = not (u12.IsEquipped or (u12.ClientFighter:IsActuallyFirstPerson() or u12.ClientFighter:Get("IsHiddenByEmotes"))) and not u12._is_broken;
        local v14;

        if v13 then
            v14 = u12:_WaitForUnequippedViewModelRoot();
        else
            v14 = v13;
        end;

        if v14 then
            u12.UnequippedViewModel:BreakWeld(v14);
            u12.UnequippedViewModel:PivotTo(v14.CFrame, "_riot_shield_back");
            u12.UnequippedViewModel:WeldTo(v14);
        end;

        local UnequippedViewModel = u12.UnequippedViewModel;
        local v15;

        if v13 then
            v15 = u12.ViewModel:GetWrap();
        else
            v15 = nil;
        end;

        UnequippedViewModel:SetWrap(v15);
        local v16;

        if v13 then
            v16 = u12.ClientFighter.Entity and u12.ClientFighter.Entity.Model or nil;
        else
            v16 = nil;
        end;

        u12.UnequippedViewModel:SetParent(v16);
    end);
end;

function u1._AttachUneqippedViewModel(p17) -- Line: 113
    if p17._shield_attached then
        return;
    end;

    local v18 = p17:_WaitForUnequippedViewModelRoot();

    if not (v18 and (not p17._shield_attached and p17.ClientFighter:IsAlive())) then
        return;
    end;

    p17._shield_attached = true;
    p17.UnequippedViewModel:PivotTo(v18.CFrame, "_riot_shield_back");
    p17.UnequippedViewModel:WeldTo(v18);
    p17:_UpdateUnequippedViewModel();
end;

function u1._Setup(p19) -- Line: 130
    -- upvalues: StaticViewModel (copy)
    p19.UnequippedViewModel = StaticViewModel.new(p19.ViewModel.Name);
    p19.UnequippedViewModel:SetArchivable(false);
end;

function u1._Init(u20) -- Line: 136
    -- upvalues: PlayerDataController (copy), CameraController (copy)
    u20.EquippedChanged:Connect(function() -- Line: 137
        -- upvalues: u20 (copy)
        u20:_UpdateUnequippedViewModel();
    end);
    u20:GetDataChangedSignal("Ammo"):Connect(function() -- Line: 141
        -- upvalues: u20 (copy)
        u20:_CheckBroken();
    end);
    local _connections = u20._connections;
    local DataChangedSignal = u20.ClientFighter:GetDataChangedSignal("IsSpectating");
    table.insert(_connections, DataChangedSignal:Connect(function() -- Line: 145
        -- upvalues: u20 (copy)
        u20:_UpdateUnequippedViewModel();
    end));
    local _connections2 = u20._connections;
    local DataChangedSignal2 = u20.ClientFighter:GetDataChangedSignal("IsHiddenByEmotes");
    table.insert(_connections2, DataChangedSignal2:Connect(function() -- Line: 149
        -- upvalues: u20 (copy)
        u20:_UpdateUnequippedViewModel();
    end));
    table.insert(u20._connections, u20.ClientFighter.EntityAdded:Connect(function() -- Line: 153
        -- upvalues: u20 (copy)
        u20:_AttachUneqippedViewModel();
    end));
    table.insert(u20._connections, u20.ClientFighter.HealthChanged:Connect(function() -- Line: 157
        -- upvalues: u20 (copy)
        u20:_AttachUneqippedViewModel();
    end));
    local _connections3 = u20._connections;
    local SettingChangedSignal = PlayerDataController:GetSettingChangedSignal("Wraps Disabled");
    table.insert(_connections3, SettingChangedSignal:Connect(function() -- Line: 161
        -- upvalues: u20 (copy)
        u20:_UpdateUnequippedViewModel();
    end));
    table.insert(u20._connections, CameraController.POVStateChanged:Connect(function() -- Line: 165
        -- upvalues: u20 (copy)
        u20:_UpdateUnequippedViewModel();
    end));
    u20:_Setup();
    task.spawn(u20._CheckBroken, u20);
    task.defer(u20._AttachUneqippedViewModel, u20);
end;

return u1;