-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local GameplayUtility = require(ReplicatedStorage.Modules.GameplayUtility);
local Utility = require(ReplicatedStorage.Modules.Utility);
local Signal = require(ReplicatedStorage.Modules.Signal);
local SpectateController = require(Players.LocalPlayer.PlayerScripts.Controllers.SpectateController);
local FighterController = require(Players.LocalPlayer.PlayerScripts.Controllers.FighterController);
local CameraController = require(Players.LocalPlayer.PlayerScripts.Controllers.CameraController);
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 16
    -- upvalues: u1 (copy), Signal (copy)
    local v3 = setmetatable({}, u1);
    v3.EmoteController = p2;
    v3._subject_enemies = {};
    v3._subject_enemies_changed = Signal.new();
    v3._subject_enemy_added = Signal.new();
    v3._subject_enemy_removed = Signal.new();
    v3._update_visibility_thread = nil;
    v3._dont_render_until = 0;
    v3._last_is_emoting_check = nil;
    v3:_Init();

    return v3;
end;

function u1._IsSystemActive(p4) -- Line: 44
    -- upvalues: SpectateController (copy), CameraController (copy)
    return (SpectateController:IsSubjectEmoting() or tick() < p4._dont_render_until) and not CameraController:HasThirdPersonAccess(true);
end;

function u1._GetPosition(p5, p6) -- Line: 51
    local v7 = p6 and p6:IsAlive() and (p6.Entity and p6.Entity.RootPart) and p6.Entity.RootPart.Position;

    return v7;
end;

function u1._IsHidden(p8, p9) -- Line: 59
    -- upvalues: SpectateController (copy), Utility (copy), GameplayUtility (copy)
    if p9 == SpectateController.CurrentSubject then
        return false;
    end;

    if tick() > p8._dont_render_until and not SpectateController:IsSubjectEmoting() then
        return false;
    end;

    local v10 = p8:_GetPosition(SpectateController.CurrentSubject);
    local v11;

    if v10 then
        v11 = p8:_GetPosition(p9);
    else
        v11 = v10;
    end;

    if v10 and v11 then
        return Utility:Raycast(v10, v11, (v10 - v11).Magnitude, SpectateController.CurrentSubject:GetRaycastWhitelist(), Enum.RaycastFilterType.Include).Instance and true or ((GameplayUtility:GetSmokeCloudBetweenPoints(v10, v11) or (#GameplayUtility:GetSmokeCloudsInSphere(v11) > 0 or #GameplayUtility:GetSmokeCloudsInSphere(v10) > 0)) and true or false);
    end;

    return false;
end;

function u1._UpdateVisibility(p12) -- Line: 88
    -- upvalues: SpectateController (copy)
    local v13 = SpectateController:IsSubjectEmoting();

    if p12._last_is_emoting_check and not v13 then
        p12._dont_render_until = tick() + 0.25;
        task.delay(0.25, p12._CheckSubjectEmoteStatus, p12);
    end;

    p12._last_is_emoting_check = v13;

    for _, v in pairs(p12._subject_enemies) do
        local v14 = p12:_IsHidden(v) or nil;

        if v14 ~= v:Get("IsHiddenByEmotes") then
            v:SetReplicate("IsHiddenByEmotes", v14);
        end;
    end;
end;

function u1._CheckSubjectEmoteStatus(u15) -- Line: 114
    if u15._update_visibility_thread then
        task.cancel(u15._update_visibility_thread);
        u15._update_visibility_thread = nil;
    end;

    u15:_UpdateVisibility();
    u15:_UpdateList();

    if not u15:_IsSystemActive() then
        return;
    end;

    u15._update_visibility_thread = task.spawn(function() -- Line: 127
        -- upvalues: u15 (copy)
        while true do
            wait(0.1);
            u15:_UpdateVisibility();
        end;
    end);
end;

function u1._GetList(p16) -- Line: 135
    -- upvalues: SpectateController (copy), FighterController (copy)
    local CurrentSubject = SpectateController.CurrentSubject;

    if not (CurrentSubject and (CurrentSubject:Get("IsInDuel") and (p16:_IsSystemActive() and (SpectateController.CurrentDuelSubject and SpectateController.CurrentDuelSubject.LocalDueler)))) then
        return {};
    end;

    local v17 = {};

    for _, v in pairs(FighterController.Objects) do
        if v ~= CurrentSubject and (v:Get("EnvironmentID") == CurrentSubject:Get("EnvironmentID") and (not v:Get("TeamID") or v:Get("TeamID") ~= CurrentSubject:Get("TeamID"))) then
            table.insert(v17, v);
        end;
    end;

    return v17;
end;

function u1._UpdateList(p18) -- Line: 165
    local v19 = p18:_GetList();
    local v20 = false;

    for i = #p18._subject_enemies, 1, -1 do
        local v21 = p18._subject_enemies[i];
        local v22;

        if table.find(v19, v21) then
            v22 = i;
        else
            table.remove(p18._subject_enemies, i);
            p18._subject_enemy_removed:Fire(v21);
            v22 = i;
            v20 = true;
        end;
    end;

    for _, v in pairs(v19) do
        if not table.find(p18._subject_enemies, v) then
            table.insert(p18._subject_enemies, v);
            p18._subject_enemy_added:Fire(v);
            v20 = true;
        end;
    end;

    if v20 then
        p18._subject_enemies_changed:Fire();
    end;
end;

function u1._FighterAdded(u23, p24, p25) -- Line: 194
    p24:GetDataChangedSignal("EnvironmentID"):Connect(function() -- Line: 195
        -- upvalues: u23 (copy)
        u23:_UpdateList();
    end);
    p24:GetDataChangedSignal("TeamID"):Connect(function() -- Line: 199
        -- upvalues: u23 (copy)
        u23:_UpdateList();
    end);

    if not p25 then
        u23:_UpdateList();
    end;
end;

function u1._Init(u26) -- Line: 208
    -- upvalues: SpectateController (copy), FighterController (copy)
    u26._subject_enemy_added:Connect(function(p27) -- Line: 209
        p27:SetReplicate("IsHiddenByEmotes", nil);
    end);
    u26._subject_enemy_removed:Connect(function(p28) -- Line: 213
        p28:SetReplicate("IsHiddenByEmotes", nil);
    end);
    SpectateController.DuelSubjectChanged:Connect(function() -- Line: 217
        -- upvalues: u26 (copy)
        u26:_CheckSubjectEmoteStatus();
    end);
    SpectateController.SubjectEmoteStatusChanged:Connect(function() -- Line: 221
        -- upvalues: u26 (copy)
        u26:_CheckSubjectEmoteStatus();
    end);
    FighterController.ObjectAdded:Connect(function(p29) -- Line: 225
        -- upvalues: u26 (copy)
        u26:_FighterAdded(p29);
    end);

    for _, v in pairs(FighterController.Objects) do
        task.spawn(u26._FighterAdded, u26, v, true);
    end;

    task.defer(u26._CheckSubjectEmoteStatus, u26);
end;

return u1;