-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local Utility = require(ReplicatedStorage.Modules.Utility);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local CameraController = require(Players.LocalPlayer.PlayerScripts.Controllers.CameraController);
local u1 = { "HitboxHead", "HitboxBody", "HitboxHeadSmall", "HitboxBodySmall" };
local u2 = {};
u2.__index = u2;

function u2.new(p3) -- Line: 13
    -- upvalues: u2 (copy)
    local v4 = setmetatable({}, u2);
    v4.ClientFighterCharacter = p3;
    v4._destroyed = false;
    v4._original_properties = {};
    v4._is_translucent = false;
    v4._update_debounce = false;
    v4._hitboxes_visible = nil;
    v4._update_hitboxes_check = false;
    v4:_Init();

    return v4;
end;

function u2.SetTranslucent(p5, p6) -- Line: 34
    if p6 == p5._is_translucent then
        return;
    end;

    p5._is_translucent = p6;
    p5:_BulkUpdate();
end;

function u2.SetHitboxesVisible(p7, p8) -- Line: 43
    p7._hitboxes_visible = p8;
    p7:_UpdateHitboxes();
end;

function u2.CloneModel(p9) -- Line: 48
    p9:_Verify(true, false);
    local Archivable = p9.ClientFighterCharacter.Model.Archivable;
    p9.ClientFighterCharacter.Model.Archivable = true;
    local v10 = p9.ClientFighterCharacter.Model:Clone();
    p9.ClientFighterCharacter.Model.Archivable = Archivable;
    p9:_Verify(true, nil);

    return v10;
end;

function u2.Update(p11, p12, p13) -- Line: 61
end;

function u2.Destroy(p14) -- Line: 65
    p14._destroyed = true;
end;

function u2._GetHeight(p15) -- Line: 73
    local Model = Instance.new("Model");

    for _, child in pairs(p15.ClientFighterCharacter.Model:GetChildren()) do
        if child:IsA("BasePart") and (child.Transparency < 0.9 and child.Material ~= Enum.Material.ForceField) then
            local Part = Instance.new("Part");
            Part.Size = child.ExtentsSize;
            Part.CFrame = child.ExtentsCFrame;
            Part.Parent = Model;
        end;
    end;

    local _, v16 = Model:GetBoundingBox();

    return v16.Y;
end;

function u2._UpdateHitboxes(u17) -- Line: 90
    -- upvalues: u1 (copy), Utility (copy)
    if u17._hitboxes_visible == nil then
        return;
    end;

    u17._update_hitboxes_check = true;
    task.defer(function() -- Line: 97
        -- upvalues: u17 (copy), u1 (ref), Utility (ref)
        if not u17._update_hitboxes_check or u17._destroyed then
            return;
        end;

        u17._update_hitboxes_check = false;
        local v18 = u17._hitboxes_visible and not u17.ClientFighterCharacter.ClientFighter:IsActuallyFirstPerson();
        local v19 = v18 and 0 or 1;

        for _, v in pairs(u1) do
            Utility:SilentWaitForChild(u17.ClientFighterCharacter.Model, v).Transparency = v19;
        end;
    end);
end;

function u2._Update(p20, p21) -- Line: 113
    if not (p20._original_properties[p21] or p20.ClientFighterCharacter:IsAlive()) then
        return;
    end;

    local v22 = p20.ClientFighterCharacter:IsHidden() or (p20.ClientFighterCharacter.ClientFighter:Get("IsHiddenByEmotes") or p20.ClientFighterCharacter.ClientFighter:Get("IsHiddenByCutscene"));
    local v23 = p20._is_translucent or p20.ClientFighterCharacter:Get("IsTranslucent") and not p20.ClientFighterCharacter.ClientFighter:Get("IsSpectating");

    if not (p21:IsA("BasePart") or (p21:IsA("Decal") or p21:IsA("Texture"))) then
        if p21:IsA("ParticleEmitter") or (p21:IsA("Fire") or (p21:IsA("Sparkles") or (p21:IsA("Smoke") or p21:IsA("Trail")))) then
            p20._original_properties[p21] = p20._original_properties[p21] or {
                Enabled = p21.Enabled
            };
            local v24;

            if v22 or v23 then
                v24 = false;
            else
                v24 = p20._original_properties[p21].Enabled;
            end;

            p21.Enabled = v24;

            if not p21.Enabled and p21:IsA("ParticleEmitter") then
                p21:Clear();
            end;
        end;

        return;
    end;

    p20._original_properties[p21] = p20._original_properties[p21] or {
        Transparency = p21.Transparency
    };
    local Transparency = p20._original_properties[p21].Transparency;
    p21.Transparency = Transparency + (1 - Transparency) * (v22 and 1 or (v23 and 0.875 or 0));
end;

function u2._BulkUpdate(p25) -- Line: 142
    -- upvalues: u1 (copy)
    for _, descendant in pairs(p25.ClientFighterCharacter.Model:GetDescendants()) do
        if not (table.find(u1, descendant.Name) or descendant:GetAttribute("IgnoreVisibilityCheck")) then
            p25:_Update(descendant);
        end;
    end;
end;

function u2._Verify(p26, p27, p28) -- Line: 152
    local v29 = p26.ClientFighterCharacter.ClientFighter:IsActuallyFirstPerson() and p26.ClientFighterCharacter.ClientFighter:IsActive();

    if not p27 and v29 == p26.ClientFighterCharacter:IsHidden() then
        return;
    end;

    if p28 ~= nil then
        v29 = p28;
    end;

    p26.ClientFighterCharacter:SetHidden(v29);
    p26:_BulkUpdate();
end;

function u2._Init(u30) -- Line: 163
    -- upvalues: CameraController (copy), PlayerDataController (copy)
    u30.ClientFighterCharacter.EnteredWorld:Connect(function() -- Line: 164
        -- upvalues: u30 (copy)
        u30:_Verify(true);
        u30:_UpdateHitboxes();
    end);
    u30.ClientFighterCharacter.BurnEffectPlaying:Connect(function(p31) -- Line: 169
        -- upvalues: u30 (copy)
        for _, v in pairs(p31) do
            u30:_Update(v);
        end;
    end);
    u30.ClientFighterCharacter.Model.ChildAdded:Connect(function(p32) -- Line: 175
        -- upvalues: u30 (copy)
        if u30._update_debounce or not u30.ClientFighterCharacter:IsAlive() then
            return;
        end;

        u30._update_debounce = true;
        task.defer(function() -- Line: 182
            -- upvalues: u30 (ref)
            u30._update_debounce = false;
            u30:_Verify(true);
            u30:_UpdateHitboxes();
        end);
    end);
    u30.ClientFighterCharacter:GetDataChangedSignal("IsTranslucent"):Connect(function() -- Line: 189
        -- upvalues: u30 (copy)
        u30:_Verify();
    end);
    u30.ClientFighterCharacter:AddConnection(u30.ClientFighterCharacter.ClientFighter:GetDataChangedSignal("IsSpectating"):Connect(function() -- Line: 193
        -- upvalues: u30 (copy)
        u30:_Verify();
        u30:_UpdateHitboxes();
    end));
    u30.ClientFighterCharacter:AddConnection(u30.ClientFighterCharacter.ClientFighter:GetDataChangedSignal("IsInDuel"):Connect(function() -- Line: 198
        -- upvalues: u30 (copy)
        u30:_Verify();
    end));
    u30.ClientFighterCharacter:AddConnection(u30.ClientFighterCharacter.ClientFighter.ItemAdded:Connect(function() -- Line: 202
        -- upvalues: u30 (copy)
        u30:_Verify();
        u30:_UpdateHitboxes();
    end));
    u30.ClientFighterCharacter:AddConnection(u30.ClientFighterCharacter.ClientFighter.ItemRemoved:Connect(function() -- Line: 207
        -- upvalues: u30 (copy)
        u30:_Verify();
        u30:_UpdateHitboxes();
    end));
    u30.ClientFighterCharacter:AddConnection(u30.ClientFighterCharacter.ClientFighter:GetDataChangedSignal("IsHiddenByEmotes"):Connect(function() -- Line: 212
        -- upvalues: u30 (copy)
        u30:_Verify(true);
    end));
    u30.ClientFighterCharacter:AddConnection(u30.ClientFighterCharacter.ClientFighter:GetDataChangedSignal("IsHiddenByCutscene"):Connect(function() -- Line: 216
        -- upvalues: u30 (copy)
        u30:_Verify(true);
    end));
    u30.ClientFighterCharacter:AddConnection(CameraController.StateChanged:Connect(function() -- Line: 220
        -- upvalues: u30 (copy)
        u30:_Verify();
        u30:_UpdateHitboxes();
    end));
    u30.ClientFighterCharacter:AddConnection(PlayerDataController:GetSettingChangedSignal("Player Hitboxes"):Connect(function() -- Line: 225
        -- upvalues: u30 (copy)
        u30:_UpdateHitboxes();
    end));
    u30:_Verify(true);
    u30:_UpdateHitboxes();
end;

return u2;