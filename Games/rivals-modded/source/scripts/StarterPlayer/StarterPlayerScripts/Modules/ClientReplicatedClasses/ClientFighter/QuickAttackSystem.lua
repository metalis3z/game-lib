-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("HttpService");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local ItemLibrary = require(ReplicatedStorage.Modules.ItemLibrary);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 15
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.ClientFighter = p2;
    v3._quick_attack_down_starts = {};
    v3._is_quick_attacking = false;
    v3._keep_quick_attack = false;
    v3._quick_attack_hash = 0;
    v3._quick_attack_cooldown = 0;
    v3._quick_attack_original_item = nil;
    v3._quick_attack_target_item = nil;
    v3._quick_attack_inputs = nil;
    v3._quick_attack_keep_window = 0;
    v3._dont_skip_equip_animation_from_quick_attacks = 0;
    v3:_Init();

    return v3;
end;

function u1.IsEquippingLocked(p4, p5) -- Line: 41
    local v6 = p4._quick_attack_target_item and p4._quick_attack_target_item:Get("ObjectID") ~= p5;

    return v6;
end;

function u1.GetQuickAttackIndex(p7, p8) -- Line: 45
    -- upvalues: ItemLibrary (copy)
    return p7.ClientFighter:Get("OverrideQuickAttacks") and p7.ClientFighter:Get("OverrideQuickAttacks")[p8] or ItemLibrary.QUICK_ATTACK_ITEM_INDEX_DEFAULTS[p8];
end;

function u1.ShouldSkipEquipAnimation(p9, p10) -- Line: 49
    return p10:Get("QuickAttackQueued") or p10:Get("SkipEquipAnimation");
end;

function u1.InputDown(u11, p12) -- Line: 53
    -- upvalues: PlayerDataController (copy), ReplicatedStorage (copy), ItemLibrary (copy)
    u11._quick_attack_down_starts[p12] = tick();

    if u11.ClientFighter:AreItemsLocked() or tick() < u11._quick_attack_cooldown then
        return;
    end;

    local QuickAttackIndex = u11:GetQuickAttackIndex(p12);
    local v13 = u11.ClientFighter.Items[QuickAttackIndex];
    local EquippedItem = u11.ClientFighter.EquippedItem;

    if not (EquippedItem and v13) then
        return;
    end;

    local v14 = PlayerDataController:GetSetting("Easy Quick Attack") and v13:CanEasyQuickAttack() and v13.Info.QuickAttackInputsEasy ~= nil;
    local v15 = v14 and v13.Info.QuickAttackInputsEasy;

    if not v15 then
        if v13:CanQuickAttack() then
            v15 = v13.Info.QuickAttackInputs or nil;
        else
            v15 = nil;
        end;
    end;

    if EquippedItem == v13 or not v15 then
        v13:PlayEquipFailedEffect();

        return;
    end;

    u11._is_quick_attacking = true;
    u11._keep_quick_attack = PlayerDataController:GetSetting("Keep Quick Attack Enabled");
    u11._quick_attack_hash = u11._quick_attack_hash + 1;
    u11._quick_attack_keep_window = tick() + (not u11._keep_quick_attack and (1 / 0) or PlayerDataController:GetSetting("Keep Quick Attack Window"));
    u11._quick_attack_cooldown = (1 / 0);
    u11._quick_attack_original_item = EquippedItem;
    u11._quick_attack_target_item = v13;
    u11._quick_attack_inputs = v15;
    ReplicatedStorage.Remotes.Replication.Fighter.RegisterQuickAttack:FireServer(p12, v14);
    v13:SetReplicate("QuickAttackQueued", true);
    u11.ClientFighter:EquipItem(table.find(u11.ClientFighter.Items, v13), true);
    task.defer(function() -- Line: 92
        -- upvalues: u11 (copy), ItemLibrary (ref)
        local _quick_attack_hash = u11._quick_attack_hash;
        wait(ItemLibrary.QUICK_ATTACK_TIMEOUT);

        if _quick_attack_hash == u11._quick_attack_hash then
            u11:_Cancel(false);
        end;
    end);
end;

function u1.InputUp(p16, p17) -- Line: 103
    -- upvalues: PlayerDataController (copy)
    if not p16._quick_attack_down_starts[p17] then
        return;
    end;

    if (not PlayerDataController:GetSetting("Keep Quick Attack Enabled") and (1 / 0) or PlayerDataController:GetSetting("Keep Quick Attack Window")) > tick() - p16._quick_attack_down_starts[p17] and tick() < p16._quick_attack_keep_window then
        p16._keep_quick_attack = false;
    end;
end;

function u1.OnReEquip(p18) -- Line: 116
    for _, v in pairs(p18.ClientFighter.Items) do
        v:SetReplicate("SkipEquipAnimation", nil);
    end;

    p18._dont_skip_equip_animation_from_quick_attacks = tick() + 1;
end;

function u1.Clear(p19) -- Line: 124
    p19._is_quick_attacking = false;
    p19._keep_quick_attack = false;
    p19._quick_attack_hash = p19._quick_attack_hash + 1;
    p19._quick_attack_cooldown = tick() + 0;
    p19._quick_attack_original_item = nil;
    p19._quick_attack_target_item = nil;
    p19._quick_attack_inputs = nil;
end;

function u1.Destroy(p20) -- Line: 134
end;

function u1._Cancel(p21, p22) -- Line: 142
    if p22 == nil then
        p22 = p21._keep_quick_attack;
    end;

    if not p21._quick_attack_original_item then
        return;
    end;

    if p21._quick_attack_target_item then
        p21._quick_attack_target_item:SetReplicate("QuickAttackQueued", nil);
    end;

    if not p22 then
        if tick() > p21._dont_skip_equip_animation_from_quick_attacks then
            p21._quick_attack_original_item:SetReplicate("SkipEquipAnimation", true);
        end;

        p21.ClientFighter:EquipItem(table.find(p21.ClientFighter.Items, p21._quick_attack_original_item), true);
    end;

    p21:Clear();
end;

function u1._TryQuickAttackInputs(p23, p24) -- Line: 164
    if not p23._quick_attack_inputs then
        return false;
    end;

    for _, v in pairs(p23._quick_attack_inputs) do
        if not p24:Input(v) then
            return false;
        end;

        wait(0.05);
    end;

    return true;
end;

function u1._OnEquip(u25, u26) -- Line: 180
    -- upvalues: BetterDebris (copy), ItemLibrary (copy), RunService (copy)
    if not u26 then
        return;
    end;

    if u26:Get("SkipEquipAnimation") then
        u26:SetReplicate("SkipEquipAnimation", nil);
    end;

    if not (u26:Get("QuickAttackQueued") and u25.ClientFighter.IsLocalPlayer) then
        return;
    end;

    task.defer(function() -- Line: 193
        -- upvalues: u25 (copy), BetterDebris (ref), ItemLibrary (ref), u26 (copy), RunService (ref)
        local _quick_attack_hash = u25._quick_attack_hash;
        local u27 = false;
        local BindableEvent = Instance.new("BindableEvent");
        BetterDebris:AddItem(BindableEvent, ItemLibrary.QUICK_ATTACK_TIMEOUT);
        task.spawn(function() -- Line: 199
            -- upvalues: u25 (ref), u26 (ref), _quick_attack_hash (copy), u27 (ref), BindableEvent (copy)
            local v28 = u25._quick_attack_inputs and u25._quick_attack_inputs[#u25._quick_attack_inputs];

            if v28 then
                local v29;

                repeat
                    v29 = u26.ServerInputWorkDone:Wait();

                    if u25._quick_attack_hash ~= _quick_attack_hash then
                        return;
                    end;
                until v29 == v28;
            end;

            u27 = true;
            BindableEvent:Fire();
            task.defer(BindableEvent.Destroy, BindableEvent);
        end);
        local v30 = u25:_TryQuickAttackInputs(u26);

        if u25._quick_attack_hash ~= _quick_attack_hash then
            return;
        end;

        if v30 then
            if not u27 then
                BindableEvent.Event:Wait();
            end;

            while u25._keep_quick_attack and tick() < u25._quick_attack_keep_window do
                RunService.Heartbeat:Wait();

                if u25._quick_attack_hash ~= _quick_attack_hash then
                    return;
                end;
            end;

            u25:_Cancel(nil);
        else
            u25:_Cancel(false);
        end;
    end);
end;

function u1._Init(u31) -- Line: 250
    u31.ClientFighter.EquippedItemChanged:Connect(function(p32) -- Line: 251
        -- upvalues: u31 (copy)
        u31:_OnEquip(p32);
    end);
end;

return u1;