-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local EnumLibrary = require(ReplicatedStorage.Modules.EnumLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local Signal = require(ReplicatedStorage.Modules.Signal);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local CameraController = require(Players.LocalPlayer.PlayerScripts.Controllers.CameraController);
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 13
    -- upvalues: u1 (copy), Signal (copy)
    local v3 = setmetatable({}, u1);
    v3.EnabledChanged = Signal.new();
    v3.MobileInputs = p2;
    v3.ModalFrame = v3.MobileInputs.Frame:WaitForChild("Modal");
    v3.Enabled = false;
    v3._edits_pending = false;
    v3:_Init();

    return v3;
end;

function u1.SetEnabled(p4, p5) -- Line: 33
    local v6 = p5 and true or false;

    if v6 == p4.Enabled then
        return;
    end;

    p4.Enabled = v6 or false;
    p4.EnabledChanged:Fire();

    if not p4.Enabled then
        p4:ApplyEdits();
    end;
end;

function u1.ResetLayout(p7) -- Line: 48
    -- upvalues: ReplicatedStorage (copy), PlayerDataController (copy)
    for _, v in pairs(p7.MobileInputs.Buttons.Buttons) do
        v:ResetPositionAndSize();
    end;

    p7._edits_pending = false;
    ReplicatedStorage.Remotes.Data.UpdateMobileButtonSettings:FireServer(PlayerDataController:Get("SettingsProfile"), nil);
end;

function u1.ApplyEdits(p8) -- Line: 57
    -- upvalues: ReplicatedStorage (copy), PlayerDataController (copy)
    if not p8._edits_pending then
        return;
    end;

    p8._edits_pending = false;
    ReplicatedStorage.Remotes.Data.UpdateMobileButtonSettings:FireServer(PlayerDataController:Get("SettingsProfile"), p8.MobileInputs.Buttons:GetCurrentProfile());
end;

function u1.PendEdits(p9) -- Line: 66
    p9._edits_pending = true;
end;

function u1.ImportProfile(p10, p11) -- Line: 70
    -- upvalues: EnumLibrary (copy), Utility (copy)
    local v12, v13 = EnumLibrary:DecryptTable(p11);

    if not v12 then
        Utility:CreateSound("rbxassetid://17153811469", 2, 1, script, true, 5);

        return;
    end;

    p10._edits_pending = true;
    p10.MobileInputs.Buttons:UpdatePositionsAndSizes(v13);
end;

function u1._UpdateModal(p14) -- Line: 86
    p14.ModalFrame.Visible = p14.Enabled;
end;

function u1._Init(u15) -- Line: 90
    -- upvalues: CameraController (copy)
    u15.EnabledChanged:Connect(function() -- Line: 91
        -- upvalues: u15 (copy), CameraController (ref)
        u15:_UpdateModal();
        CameraController:SetIsEditingMobileButtons(u15.Enabled);
    end);
    u15:_UpdateModal();
end;

return u1;