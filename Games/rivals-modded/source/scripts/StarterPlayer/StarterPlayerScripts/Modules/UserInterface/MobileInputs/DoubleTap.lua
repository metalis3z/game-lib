-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local UserInputService = game:GetService("UserInputService");
local Players = game:GetService("Players");
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"));
local FighterController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("FighterController"));
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 10
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.MobileInputs = p2;
    v3.Frame = v3.MobileInputs.Frame:WaitForChild("DoubleTapArea");
    v3._connections = {};
    v3._shooting_connection = nil;
    v3._last_tap = 0;
    v3:_Init();

    return v3;
end;

function u1.IsWithin(p4, p5) -- Line: 29
    -- upvalues: PlayerDataController (copy)
    local v6 = p5 - p4.MobileInputs.Frame.AbsolutePosition.X;

    if PlayerDataController:GetSetting("Left Handed Touch Controls") then
        return v6 <= p4.MobileInputs.Frame.AbsoluteSize.X / 2;
    end;

    return p4.MobileInputs.Frame.AbsoluteSize.X / 2 <= v6;
end;

function u1.ResetTapWindow(p7) -- Line: 36
    p7._last_tap = 0;
end;

function u1.UpdateVisuals(p8) -- Line: 40
    -- upvalues: PlayerDataController (copy)
    local Frame = p8.Frame;
    local v9 = p8.MobileInputs.EditorEnabled and PlayerDataController:GetSetting("Double Tap Shoot");
    Frame.Visible = v9;
    local Frame2 = p8.Frame;
    local v10;

    if PlayerDataController:GetSetting("Left Handed Touch Controls") then
        v10 = UDim2.new(0.5, 0, 0.5, 0);
    else
        v10 = UDim2.new(1, 0, 0.5, 0);
    end;

    Frame2.Position = v10;
end;

function u1.VerifyControls(u11, p12) -- Line: 45
    -- upvalues: UserInputService (copy), PlayerDataController (copy), FighterController (copy)
    for _, v in pairs(u11._connections) do
        v:Disconnect();
    end;

    u11._connections = {};
    u11:_CancelShootingConnection();
    u11:ResetTapWindow();

    if not p12 then
        return;
    end;

    table.insert(u11._connections, UserInputService.InputBegan:Connect(function(u13, p14) -- Line: 59
        -- upvalues: u11 (copy), PlayerDataController (ref), FighterController (ref)
        if u13.UserInputType ~= Enum.UserInputType.Touch then
            return;
        end;

        if u11.MobileInputs.EditorEnabled or (not u11:IsWithin(u13.Position.X) or #u11.MobileInputs.Buttons:GetButtonsFromPosition(u13.Position.X, u13.Position.Y) > 0) then
            return;
        end;

        if tick() - u11._last_tap > PlayerDataController:GetSetting("Double Tap Shoot Window") then
            u11._last_tap = tick();

            return;
        end;

        local v15 = PlayerDataController:GetSetting("Double Tap Shoot") or FighterController.LocalFighter and not FighterController.LocalFighter:Get("IsInDuel") and not FighterController.LocalFighter:Get("IsInShootingRange");

        if not v15 then
            return;
        end;

        u11:_CancelShootingConnection();
        u11._shooting_connection = u13:GetPropertyChangedSignal("UserInputState"):Connect(function() -- Line: 82
            -- upvalues: u13 (copy), u11 (ref)
            if u13.UserInputState == Enum.UserInputState.End then
                u11:_CancelShootingConnection();
                u11.MobileInputs.Buttons.Buttons.mobile_shoot:Button1Up();
            end;
        end);
        u11.MobileInputs.Buttons.Buttons.mobile_shoot:Button1Down();
    end));
end;

function u1._CancelShootingConnection(p16) -- Line: 97
    if p16._shooting_connection then
        p16._shooting_connection:Disconnect();
        p16._shooting_connection = nil;
    end;
end;

function u1._Init(u17) -- Line: 104
    -- upvalues: PlayerDataController (copy)
    u17.MobileInputs.EditorEnabledChanged:Connect(function() -- Line: 105
        -- upvalues: u17 (copy)
        u17:UpdateVisuals();
    end);
    PlayerDataController:GetSettingChangedSignal("Left Handed Touch Controls"):Connect(function() -- Line: 109
        -- upvalues: u17 (copy)
        u17:UpdateVisuals();
    end);
    PlayerDataController:GetSettingChangedSignal("Double Tap Shoot"):Connect(function() -- Line: 113
        -- upvalues: u17 (copy)
        u17:UpdateVisuals();
    end);
    u17:UpdateVisuals();
end;

return u1;