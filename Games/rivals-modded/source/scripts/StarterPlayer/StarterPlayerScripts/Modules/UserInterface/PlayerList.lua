-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local StarterGui = game:GetService("StarterGui");
local GuiService = game:GetService("GuiService");
local Players = game:GetService("Players");
local InputLibrary = require(ReplicatedStorage.Modules.InputLibrary);
local Signal = require(ReplicatedStorage.Modules.Signal);
require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local ControlsController = require(Players.LocalPlayer.PlayerScripts.Controllers.ControlsController);
local SpectateController = require(Players.LocalPlayer.PlayerScripts.Controllers.SpectateController);
local FighterController = require(Players.LocalPlayer.PlayerScripts.Controllers.FighterController);
local MatchmakingCountdown = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("MatchmakingCountdown"));
local MobileInputs = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("MobileInputs"));
local Teleporting = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Teleporting"));
local Equipment = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Equipment"));
local Pages = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Pages"));
local Queue = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Queue"));
local UILibrary = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"));
local Elements = require(script:WaitForChild("Elements"));
local Inspect = require(script:WaitForChild("Inspect"));
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 29
    -- upvalues: u1 (copy), Signal (copy), UILibrary (copy), Elements (copy), Inspect (copy)
    local v2 = setmetatable({}, u1);
    v2.OpenedChanged = Signal.new();
    v2.ClosedByInputsChanged = Signal.new();
    v2.BaseVisibilityChanged = Signal.new();
    v2.Frame = UILibrary:GetTo("PlayerList");
    v2.Container = v2.Frame:WaitForChild("Container");
    v2.IsOpen = nil;
    v2.ClosedByInputs = false;
    v2.Elements = Elements.new(v2);
    v2.Inspect = Inspect.new(v2);
    v2._local_fighter = nil;
    v2._opened_connections = {};
    v2._is_disabled = false;
    v2._scale = 1;
    v2:_Init();

    return v2;
end;

function u1.GetBaseVisibility(p3) -- Line: 58
    -- upvalues: MobileInputs (copy), Teleporting (copy), SpectateController (copy), Equipment (copy), Pages (copy), MatchmakingCountdown (copy), GuiService (copy), Queue (copy)
    local v4 = not (MobileInputs.EditorEnabled or Teleporting.Enabled or (SpectateController.CurrentDuelSubject or Equipment.IsOpen) or (Pages.PageSystem.CurrentPage or MatchmakingCountdown:IsVisible() or (GuiService.MenuIsOpen or Queue:IsVisible())));

    if v4 then
        local v5 = p3._local_fighter and p3._local_fighter:Get("IsInShootingRange");
        v4 = not v5;
    end;

    return v4;
end;

function u1.SetDisabled(p6, p7) -- Line: 70
    if p7 == p6._is_disabled then
        return;
    end;

    p6._is_disabled = p7;
    p6:_UpdateVisibility();
end;

function u1.SetScale(p8, p9) -- Line: 79
    p8._scale = p9;
    p8.Container.Size = UDim2.new(p8._scale, 0, p8._scale, 0);
    p8:_UpdateSize();
    p8.Inspect:SetScale(p9);
end;

function u1.SetClosedByInputs(p10, p11) -- Line: 86
    p10.ClosedByInputs = p11;
    p10.ClosedByInputsChanged:Fire();
end;

function u1.SetIsFriend(p12, p13, p14) -- Line: 91
    for i, v in pairs(p12.Elements.PlayerListSlots) do
        if i.Player == p13 then
            v:SetIsFriend(p14);
        end;
    end;
end;

function u1.SetIsBlocked(p15, p16, p17) -- Line: 99
    for i, v in pairs(p15.Elements.PlayerListSlots) do
        if i.Player == p16 then
            v:SetIsBlocked(p17);
        end;
    end;
end;

function u1.SetRequestDuration(p18, p19, ...) -- Line: 107
    local PlayerListSlot = p18.Elements:GetPlayerListSlot(p19);

    if PlayerListSlot then
        PlayerListSlot:SetRequestDuration(...);
    end;
end;

function u1.SelectPlayerExternally(p20, p21) -- Line: 115
    p20.Inspect:SelectPlayer(p20.Elements:GetPlayerListSlot(p21));
end;

function u1.OnOpened(u22) -- Line: 119
    -- upvalues: GuiService (copy)
    u22:AddOpenedConnection(u22.Frame.Parent:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 120
        -- upvalues: u22 (copy)
        u22:_UpdateSize();
    end));
    u22:AddOpenedConnection(GuiService:GetPropertyChangedSignal("TopbarInset"):Connect(function() -- Line: 124
        -- upvalues: u22 (copy)
        u22:_UpdatePosition();
    end));
    u22:_UpdateSize();
    u22:_UpdatePosition();
    u22.Elements:OnOpened();
    u22.Inspect:OnOpened();
end;

function u1.AddOpenedConnection(p23, p24) -- Line: 136
    table.insert(p23._opened_connections, p24);
end;

function u1._IsVisibleRegardlessOfInputs(p25) -- Line: 144
    local v26 = p25:GetBaseVisibility() and not p25._is_disabled;

    return v26;
end;

function u1._UpdateSize(p27) -- Line: 148
    p27.Frame.Size = UDim2.new(0, math.min(320, p27.Frame.Parent.AbsoluteSize.X * 0.5), 0.5 * p27._scale, 0);
end;

function u1._UpdatePosition(p28) -- Line: 152
    -- upvalues: GuiService (copy)
    p28.Container.Position = UDim2.new(1, 0, 0, GuiService.TopbarInset.Height);
end;

function u1._UpdateVisibility(p29) -- Line: 156
    p29.BaseVisibilityChanged:Fire();
    local v30 = p29:_IsVisibleRegardlessOfInputs() and not p29.ClosedByInputs;

    if v30 == p29.IsOpen then
        return;
    end;

    p29.IsOpen = v30;
    p29.OpenedChanged:Fire();
    task.defer(p29.Frame.TweenPosition, p29.Frame, p29.IsOpen and UDim2.new(1, -10, 0, 10) or UDim2.new(1, 650, 0, 10), "Out", "Quint", 0.25, true);

    if p29.IsOpen then
        p29:OnOpened();

        return;
    end;

    for _, v in pairs(p29._opened_connections) do
        v:Disconnect();
    end;

    p29._opened_connections = {};
end;

function u1._HookGetCore(p31, u32, u33) -- Line: 180
    -- upvalues: StarterGui (copy)
    task.spawn(function() -- Line: 181
        -- upvalues: StarterGui (ref), u32 (copy), u33 (copy)
        local v34 = nil;
        local v35;

        while true do
            if v34 then
                v35 = v34;
                break;
            end;

            local v36;
            v36, v35 = pcall(StarterGui.GetCore, StarterGui, u32);

            if v36 then
                break;
            end;

            wait(1);
        end;

        v35.Event:Connect(u33);
    end);
end;

function u1._HookLocalFighter(u37) -- Line: 199
    -- upvalues: FighterController (copy)
    u37._local_fighter = FighterController:WaitForLocalFighter();
    u37._local_fighter:GetDataChangedSignal("IsInShootingRange"):Connect(function() -- Line: 202
        -- upvalues: u37 (copy)
        u37:_UpdateVisibility();
    end);
    u37:_UpdateVisibility();
end;

function u1._Init(u38) -- Line: 209
    -- upvalues: ControlsController (copy), SpectateController (copy), Equipment (copy), Pages (copy), Teleporting (copy), MobileInputs (copy), MatchmakingCountdown (copy), GuiService (copy), Queue (copy), UserInputService (copy), InputLibrary (copy)
    u38.ClosedByInputsChanged:Connect(function() -- Line: 210
        -- upvalues: u38 (copy)
        u38:_UpdateVisibility();
    end);
    u38:_HookGetCore("PlayerFriendedEvent", function(p39) -- Line: 214
        -- upvalues: u38 (copy)
        u38:SetIsFriend(p39, true);
    end);
    u38:_HookGetCore("PlayerUnfriendedEvent", function(p40) -- Line: 218
        -- upvalues: u38 (copy)
        u38:SetIsFriend(p40, false);
    end);
    u38:_HookGetCore("PlayerBlockedEvent", function(p41) -- Line: 222
        -- upvalues: u38 (copy)
        u38:SetIsBlocked(p41, true);
    end);
    u38:_HookGetCore("PlayerUnblockedEvent", function(p42) -- Line: 226
        -- upvalues: u38 (copy)
        u38:SetIsBlocked(p42, false);
    end);
    ControlsController.ControlsChanged:Connect(function() -- Line: 230
        -- upvalues: u38 (copy)
        u38:_UpdateVisibility();
    end);
    SpectateController.DuelSubjectChanged:Connect(function() -- Line: 234
        -- upvalues: u38 (copy)
        u38:_UpdateVisibility();
    end);
    Equipment.Opened:Connect(function() -- Line: 238
        -- upvalues: u38 (copy)
        u38:_UpdateVisibility();
    end);
    Pages.PageSystem.PagesActivity:Connect(function() -- Line: 242
        -- upvalues: u38 (copy)
        u38:_UpdateVisibility();
    end);
    Teleporting.EnabledChanged:Connect(function() -- Line: 246
        -- upvalues: u38 (copy)
        u38:_UpdateVisibility();
    end);
    MobileInputs.EditorEnabledChanged:Connect(function() -- Line: 250
        -- upvalues: u38 (copy)
        u38:_UpdateVisibility();
    end);
    MatchmakingCountdown.VisibilityChanged:Connect(function() -- Line: 254
        -- upvalues: u38 (copy)
        u38:_UpdateVisibility();
    end);
    GuiService:GetPropertyChangedSignal("MenuIsOpen"):Connect(function() -- Line: 258
        -- upvalues: u38 (copy)
        u38:_UpdateVisibility();
    end);
    Queue.VisibilityChanged:Connect(function() -- Line: 262
        -- upvalues: u38 (copy)
        u38:_UpdateVisibility();
    end);
    UserInputService.InputBegan:Connect(function(p43, p44) -- Line: 266
        -- upvalues: u38 (copy), InputLibrary (ref), UserInputService (ref)
        if not p44 and (u38:_IsVisibleRegardlessOfInputs() and (InputLibrary:InputIs(p43, "OpenPlayerList") and not UserInputService:IsKeyDown(Enum.KeyCode.LeftAlt))) then
            u38:SetClosedByInputs(not u38.ClosedByInputs);
        end;
    end);
    u38:_UpdateSize();
    u38:_UpdatePosition();
    u38:_UpdateVisibility();
    task.defer(u38._HookLocalFighter, u38);
end;

return u1._new();