-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
require(ReplicatedStorage.Modules.ItemLibrary);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local ControlsController = require(Players.LocalPlayer.PlayerScripts.Controllers.ControlsController);
local CameraController = require(Players.LocalPlayer.PlayerScripts.Controllers.CameraController);
local FighterKeybindSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("FighterKeybindSlot");
local u1 = { { "QuickUtility", "Quick Utility" }, { "QuickMelee", "Quick Melee" }, { "OpenPlayerList", "Scoreboard" }, { "SwitchCameraPOV", "Camera" }, { "UseEmote", "Emote" }, { "LeaveDuel", "Leave Shooting Range" } };
local u2 = {};
u2.__index = u2;

function u2.new(p3) -- Line: 22
    -- upvalues: u2 (copy)
    local v4 = setmetatable({}, u2);
    v4.FighterInterface = p3;
    v4.KeybindGamepadEquipLastFrame = v4.FighterInterface.Hotbar.Container:WaitForChild("KeybindGamepadEquipLast");
    v4.KeybindGamepadEquipNextFrame = v4.FighterInterface.Hotbar.Container:WaitForChild("KeybindGamepadEquipNext");
    v4.Frame = v4.FighterInterface.BottomRight.Container:WaitForChild("Keybinds");
    v4.Layout = v4.Frame:WaitForChild("Layout");
    v4._destroyed = false;
    v4._connections = {};
    v4._slots = {};
    v4:_Init();

    return v4;
end;

function u2.Refresh(p5) -- Line: 44
    -- upvalues: Players (copy), PlayerDataController (copy), ControlsController (copy), CameraController (copy)
    if p5._destroyed then
        return;
    end;

    local EmoteController = require(Players.LocalPlayer.PlayerScripts.Controllers.EmoteController);
    local Frame = p5.Frame;
    local v6;

    if PlayerDataController:GetSetting("Keybinds Interface") == "Disabled" or #p5.FighterInterface.ClientFighter.Items <= 0 then
        v6 = false;
    else
        v6 = ControlsController.CurrentControls == "MouseKeyboard" and true or ControlsController.CurrentControls == "Gamepad";
    end;

    Frame.Visible = v6;
    p5._slots.QuickUtility.Visible = p5:_IsQuickAttackKeybindVisible("Utility");
    p5._slots.QuickMelee.Visible = p5:_IsQuickAttackKeybindVisible("Melee");
    p5._slots.OpenPlayerList.Visible = p5.FighterInterface.ClientFighter:Get("IsInDuel");
    p5._slots.SwitchCameraPOV.Visible = CameraController:HasThirdPersonAccess();
    p5._slots.UseEmote.Visible = EmoteController:CanEmote();
    p5._slots.LeaveDuel.Visible = p5.FighterInterface.ClientFighter:Get("IsInShootingRange");
    p5:_UpdateGamepad();
    p5:_UpdateParent();
end;

function u2.Destroy(p7) -- Line: 64
    p7._destroyed = true;

    for _, v in pairs(p7._connections) do
        v:Disconnect();
    end;

    p7._connections = {};
    p7._slots = {};
end;

function u2._UpdateParent(u8) -- Line: 79
    -- upvalues: PlayerDataController (copy)
    task.defer(pcall, function() -- Line: 80
        -- upvalues: PlayerDataController (ref), u8 (copy)
        local v9 = PlayerDataController:GetSetting("Keybinds Interface") == "Bottom Left";

        for _, v in pairs(u8._slots) do
            v.Container.AnchorPoint = v9 and Vector2.new(0, 0.5) or Vector2.new(1, 0.5);
            v.Container.Position = v9 and UDim2.new(0, 0, 0.5, 0) or UDim2.new(1, 0, 0.5, 0);
            v.Container.Title.AnchorPoint = v9 and Vector2.new(0, 0.5) or Vector2.new(1, 0.5);
            v.Container.Title.Position = v9 and UDim2.new(1, 0, 0.5, 0) or UDim2.new(0, 0, 0.5, 0);
            v.Container.Title.TextXAlignment = v9 and Enum.TextXAlignment.Left or Enum.TextXAlignment.Right;
        end;

        u8.Layout.HorizontalAlignment = v9 and Enum.HorizontalAlignment.Left or Enum.HorizontalAlignment.Right;
        u8.Frame.Parent = v9 and u8.FighterInterface.BottomLeft.Container or u8.FighterInterface.BottomRight.Container;
    end);
end;

function u2._IsQuickAttackKeybindVisible(p10, p11) -- Line: 96
    local QuickAttackIndex = p10.FighterInterface.ClientFighter:GetQuickAttackIndex(p11);
    local IsLocalPlayer = p10.FighterInterface.ClientFighter.IsLocalPlayer;

    if IsLocalPlayer then
        if QuickAttackIndex <= #p10.FighterInterface.ClientFighter.Items then
            IsLocalPlayer = p10.FighterInterface.ClientFighter.EquippedItem ~= p10.FighterInterface.ClientFighter.Items[QuickAttackIndex];
        else
            IsLocalPlayer = false;
        end;
    end;

    return IsLocalPlayer;
end;

function u2._UpdateGamepad(p12) -- Line: 104
    -- upvalues: ControlsController (copy)
    local v13;

    if ControlsController.CurrentControls == "Gamepad" then
        v13 = #p12.FighterInterface.ClientFighter.Items > 1;
    else
        v13 = false;
    end;

    p12.KeybindGamepadEquipLastFrame.Visible = v13;
    p12.KeybindGamepadEquipNextFrame.Visible = v13;
end;

function u2._UpdateBackground(p14) -- Line: 111
    p14.Frame.Size = UDim2.new(0, p14.Layout.AbsoluteContentSize.X, 0.0934, 0);
end;

function u2._Setup(p15) -- Line: 115
    -- upvalues: u1 (copy), FighterKeybindSlot (copy)
    for i, v in pairs(u1) do
        local table_unpack_ret, v16 = table.unpack(v);
        local u17 = FighterKeybindSlot:Clone();
        u17.Container.Keybind:SetAttribute("InputName", table_unpack_ret);
        u17.Container.Title.Text = v16;
        u17.LayoutOrder = -i;
        u17.Parent = p15.Frame;
        p15._slots[table_unpack_ret] = u17;
        local Title = u17.Container.Title;
        Title:GetPropertyChangedSignal("TextBounds"):Connect(function() -- Line: 128, Name: update
            -- upvalues: u17 (copy), Title (copy)
            u17.Size = UDim2.new(1.3, Title.TextBounds.X, 1, 0);
        end);
    end;
end;

function u2._Init(u18) -- Line: 136
    u18.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 137
        -- upvalues: u18 (copy)
        u18:_UpdateBackground();
    end);
    u18:_Setup();
    u18:_UpdateGamepad();
    u18:_UpdateBackground();
end;

return u2;