-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local InputLibrary = require(ReplicatedStorage.Modules.InputLibrary);
local EnumLibrary = require(ReplicatedStorage.Modules.EnumLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"));
local MechanicsController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("MechanicsController"));
local SpectateController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("SpectateController"));
local CameraController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("CameraController"));
local EmoteController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("EmoteController"));
local MobileButton = require(script:WaitForChild("MobileButton"));
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 19
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.MobileInputs = p2;
    v3.Frame = v3.MobileInputs.Frame:WaitForChild("Buttons");
    v3.Buttons = {};
    v3._generated = false;
    v3._hooked_fighter = false;
    v3._local_fighter = nil;
    v3._connections = {};
    v3._duel_subject_connections = {};
    v3:_Init();

    return v3;
end;

function u1.IsReallyVisible(p4) -- Line: 41
    return p4.Frame.Visible and p4.MobileInputs.Frame.Visible;
end;

function u1.GetButtonsFromPosition(p5, p6, p7) -- Line: 45
    -- upvalues: Players (copy)
    if require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface.Inset):IsWithinAnyBar(p6, p7) then
        return {};
    end;

    local v8 = {};

    for _, v in pairs(p5.Buttons) do
        if v:IsReallyVisible() and v:IsWithin(p6, p7) then
            table.insert(v8, v);
        end;
    end;

    return v8;
end;

function u1.GetCurrentProfile(p9) -- Line: 63
    local v10 = {};

    for i, v in pairs(p9.Buttons) do
        local v11 = v.Frame.AbsolutePosition + v.Frame.AbsoluteSize * v.Frame.AnchorPoint - p9.Frame.AbsolutePosition;
        v10[i] = {
            Position = { v11.X, v11.Y },
            Size = { v.Frame.Size.X.Offset, v.Frame.Size.Y.Offset }
        };
    end;

    return v10;
end;

function u1.EncryptProfile(p12) -- Line: 78
    -- upvalues: EnumLibrary (copy)
    return EnumLibrary:EncryptTable(p12:GetCurrentProfile());
end;

function u1.VerifyControls(u13, p14) -- Line: 82
    -- upvalues: MechanicsController (copy), RunService (copy), CameraController (copy), EmoteController (copy), PlayerDataController (copy), SpectateController (copy), UserInputService (copy)
    for _, v in pairs(u13._connections) do
        v:Disconnect();
    end;

    for _, v in pairs(u13._duel_subject_connections) do
        v:Disconnect();
    end;

    u13._connections = {};
    u13._duel_subject_connections = {};

    if u13._generated then
        MechanicsController:MobileInput("mobile_shoot", false);
    end;

    if not p14 then
        return;
    end;

    u13:_GenerateButtons();
    task.spawn(u13._HookFighter, u13);
    table.insert(u13._connections, RunService.RenderStepped:Connect(function(p15) -- Line: 106
        -- upvalues: u13 (copy)
        for _, v in pairs(u13.Buttons) do
            v:Update(p15);
        end;
    end));
    table.insert(u13._connections, CameraController.ActiveStateChanged:Connect(function(p16) -- Line: 113
        -- upvalues: u13 (copy)
        u13:_UpdateVisibilities();
    end));
    table.insert(u13._connections, EmoteController.CanEmoteChanged:Connect(function() -- Line: 117
        -- upvalues: u13 (copy)
        u13:_UpdateVisibilities();
    end));
    local _connections = u13._connections;
    local DataChangedSignal = PlayerDataController:GetDataChangedSignal("SettingsProfile");
    table.insert(_connections, DataChangedSignal:Connect(function() -- Line: 121
        -- upvalues: u13 (copy)
        u13:_UpdatePositionsAndSizes();
    end));
    local _connections2 = u13._connections;
    local DataChangedSignal2 = PlayerDataController:GetDataChangedSignal("MobileButtonSettings");
    table.insert(_connections2, DataChangedSignal2:Connect(function() -- Line: 125
        -- upvalues: u13 (copy)
        u13:_UpdatePositionsAndSizes();
    end));

    local function update_duel_subject() -- Line: 129
        -- upvalues: u13 (copy), SpectateController (ref)
        for _, v in pairs(u13._duel_subject_connections) do
            v:Disconnect();
        end;

        u13._duel_subject_connections = {};
        u13:_UpdateVisibilities();

        if not SpectateController.CurrentDuelSubject then
            return;
        end;

        table.insert(u13._duel_subject_connections, SpectateController.CurrentDuelSubject.DuelInterface.Voting.VisibilityChanged:Connect(function() -- Line: 141
            -- upvalues: u13 (ref)
            u13:_UpdateVisibilities();
        end));
    end;

    table.insert(u13._connections, SpectateController.DuelSubjectChanged:Connect(update_duel_subject));
    update_duel_subject();
    table.insert(u13._connections, UserInputService.InputBegan:Connect(function(p17, p18) -- Line: 150
        -- upvalues: u13 (copy)
        if p17.UserInputType ~= Enum.UserInputType.Touch and p17.UserInputType ~= Enum.UserInputType.MouseButton1 then
            return;
        end;

        local ButtonsFromPosition = u13:GetButtonsFromPosition(p17.Position.X, p17.Position.Y);

        for _, v in pairs(ButtonsFromPosition) do
            v:Button1Down(p17);
        end;
    end));
    table.insert(u13._connections, UserInputService.InputEnded:Connect(function(p19, p20) -- Line: 162
        -- upvalues: u13 (copy)
        if p19.UserInputType == Enum.UserInputType.Touch or p19.UserInputType == Enum.UserInputType.MouseButton1 then
            for _, v in pairs(u13.Buttons) do
                v:InputEnded(p19);
            end;
        end;
    end));
    table.insert(u13._connections, MechanicsController.StateChanged:Connect(function(p21) -- Line: 170
        -- upvalues: u13 (copy), MechanicsController (ref)
        if u13:IsReallyVisible() and not MechanicsController.IsCrouching then
            u13.Buttons.mobile_crouch:Input(false, true);
        end;
    end));
end;

function u1.UpdatePositionsAndSizes(p22, ...) -- Line: 177
    p22:_UpdatePositionsAndSizes(...);
end;

function u1._UpdateWeaponIcons(p23, ...) -- Line: 185
    for _, v in pairs(p23.Buttons) do
        v:UpdateWeaponIcon(...);
    end;
end;

function u1._UpdatePositionsAndSizes(p24, ...) -- Line: 191
    for _, v in pairs(p24.Buttons) do
        v:UpdatePositionAndSize(...);
    end;
end;

function u1._UpdateVisibilities(p25, ...) -- Line: 197
    for _, v in pairs(p25.Buttons) do
        v:UpdateVisibility(...);
    end;
end;

function u1._UpdateMobileInputSettings(p26, ...) -- Line: 203
    for _, v in pairs(p26.Buttons) do
        v:UpdateMobileInputSettings(...);
    end;
end;

function u1._GenerateButtons(u27) -- Line: 209
    -- upvalues: InputLibrary (copy), MobileButton (copy)
    if u27._generated then
        return;
    end;

    u27._generated = true;

    for i in pairs(InputLibrary.MobileButtons) do
        local v28 = MobileButton.new(u27, i);
        v28.Frame.Parent = u27.Frame;
        u27.Buttons[v28.Name] = v28;
    end;

    u27.Frame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 222
        -- upvalues: u27 (copy)
        u27:_UpdatePositionsAndSizes();
    end);
end;

function u1._HookFighter(u29) -- Line: 227
    -- upvalues: MechanicsController (copy)
    if u29._hooked_fighter then
        return;
    end;

    u29._hooked_fighter = true;
    u29._local_fighter = MechanicsController:WaitForLocalFighter();

    local function check_scoped() -- Line: 235
        -- upvalues: u29 (copy)
        local v30 = false;

        for i in pairs(u29._local_fighter:GetEquippedItems()) do
            if i.ItemInterface and i.ItemInterface:IsScopeActive() then
                v30 = true;
                break;
            end;
        end;

        for _, v in pairs(u29.Buttons) do
            v:SetScoped(v30);
        end;
    end;

    u29._local_fighter.EquippedItemChanged:Connect(check_scoped);

    local function item_interface_added(p31, p32) -- Line: 252
        -- upvalues: check_scoped (copy)
        p31.Mouse.Scope.ActiveChanged:Connect(check_scoped);

        if not p32 then
            check_scoped();
        end;
    end;

    local function client_item_added(p33, p34) -- Line: 260
        -- upvalues: u29 (copy), item_interface_added (copy), check_scoped (copy)
        p33.ToggleOffMobileInputButton:Connect(function(p35) -- Line: 261
            -- upvalues: u29 (ref)
            u29.Buttons[p35]:Button1Up();
        end);
        p33.InterfaceAdded:Connect(item_interface_added);

        if p33.ItemInterface then
            p33.ItemInterface.Mouse.Scope.ActiveChanged:Connect(check_scoped);

            if not p34 then
                check_scoped();
            end;
        end;
    end;

    u29._local_fighter.ItemAdded:Connect(client_item_added);

    for _, v in pairs(u29._local_fighter.Items) do
        task.spawn(client_item_added, v, true);
    end;

    task.defer(check_scoped);
    u29._local_fighter.EquippedItemChanged:Connect(function() -- Line: 280
        -- upvalues: u29 (copy)
        u29:_UpdateMobileInputSettings();
    end);
    u29._local_fighter.HealthChanged:Connect(function() -- Line: 284
        -- upvalues: u29 (copy)
        u29:_UpdateVisibilities();
    end);
    u29._local_fighter.EntityAdded:Connect(function() -- Line: 288
        -- upvalues: u29 (copy)
        u29:_UpdateVisibilities();
    end);
    u29._local_fighter.Died:Connect(function() -- Line: 292
        -- upvalues: u29 (copy)
        u29:_UpdateVisibilities();
    end);
    u29._local_fighter:GetDataChangedSignal("IsInDuel"):Connect(function() -- Line: 296
        -- upvalues: u29 (copy)
        u29:_UpdateVisibilities();
    end);
    u29._local_fighter:GetDataChangedSignal("QuickAttackOverrides"):Connect(function() -- Line: 300
        -- upvalues: u29 (copy)
        u29:_UpdateVisibilities();
    end);
    u29._local_fighter.ItemAdded:Connect(function() -- Line: 304
        -- upvalues: u29 (copy)
        u29:_UpdateWeaponIcons();
    end);
    u29._local_fighter.ItemRemoved:Connect(function() -- Line: 308
        -- upvalues: u29 (copy)
        u29:_UpdateWeaponIcons();
    end);
    u29:_UpdateWeaponIcons();
end;

function u1._HookTouchGui(p36) -- Line: 315
    -- upvalues: Utility (copy), Players (copy)
    local JumpButton = Utility:SilentWaitForChild(Players.LocalPlayer:WaitForChild("PlayerGui"), "TouchGui"):WaitForChild("TouchControlFrame"):WaitForChild("JumpButton");
    task.defer(JumpButton.Destroy, JumpButton);
end;

function u1._Init(u37) -- Line: 322
    u37.MobileInputs.EditorEnabledChanged:Connect(function() -- Line: 323
        -- upvalues: u37 (copy)
        u37:_UpdateVisibilities();
        u37:_UpdateWeaponIcons();
    end);
    task.defer(u37._HookTouchGui, u37);
end;

return u1;