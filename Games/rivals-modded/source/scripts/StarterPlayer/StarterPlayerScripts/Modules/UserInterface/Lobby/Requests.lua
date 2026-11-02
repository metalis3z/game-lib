-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local GuiService = game:GetService("GuiService");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"));
local ComplianceController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ComplianceController"));
local QueuePadController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("QueuePadController"));
local FighterController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("FighterController"));
local SocialController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("SocialController"));
local MobileInputs = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("MobileInputs"));
local Teleporting = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Teleporting"));
local PlayerList = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("PlayerList"));
local Equipment = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Equipment"));
local JoinQueuePadSlot = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("JoinQueuePadSlot"));
local Queue = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Queue"));
local Pages = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Pages"));
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local UILibrary = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"));
local RequestChallengeSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("RequestChallengeSlot");
local RequestPartySlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("RequestPartySlot");
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 27
    -- upvalues: u1 (copy), UILibrary (copy)
    local v2 = setmetatable({}, u1);
    v2.Frame = UILibrary:GetTo("MainFrame", "Lobby", "Requests");
    v2.Container = v2.Frame:WaitForChild("Container");
    v2.PlayerListBuffer = v2.Container:WaitForChild("PlayerListBuffer");
    v2:_Init();

    return v2;
end;

function u1.SendRequest(p3, u4, p5, p6, u7, u8) -- Line: 43
    -- upvalues: FighterController (copy), UILibrary (copy), ComplianceController (copy), CONSTANTS (copy), ButtonEffect (copy), PlayerList (copy)
    if not u4 then
        return;
    end;

    local Fighter = FighterController:GetFighter(u4);
    local u9 = p5:Clone();
    u9.Container.Background.ImageColor3 = UILibrary.BUTTON_BACKGROUND_COLOR;
    u9.Container.Background.ImageTransparency = UILibrary.BUTTON_BACKGROUND_TRANSPARENCY;
    u9.Container.DisplayName.Text = ComplianceController:GetName(u4);
    local Controls = u9.Container.DisplayName.Controls;
    local CONTROLS_IMAGES = CONSTANTS.CONTROLS_IMAGES;

    if Fighter then
        Fighter = Fighter:Get("Controls");
    end;

    Controls.Image = CONTROLS_IMAGES[Fighter] or "";
    u9.Container.Headshot.Image = string.format(CONSTANTS.HEADSHOT_IMAGE, u4.UserId);
    u9.Parent = p3.Container;
    ButtonEffect:Add(u9.Container.Accept);
    ButtonEffect:Add(u9.Container.Decline);

    local function remove() -- Line: 60
        -- upvalues: u9 (copy), u7 (copy), PlayerList (ref), u4 (copy)
        u9:Destroy();

        if u7 then
            PlayerList:SetRequestDuration(u4, u7, 0);
        end;
    end;

    u9.Container.Decline.MouseButton1Click:Connect(remove);
    task.delay(p6, remove);
    u9.Container.Accept.MouseButton1Click:Connect(function() -- Line: 71
        -- upvalues: u8 (copy), u9 (copy), u7 (copy), PlayerList (ref), u4 (copy)
        if u8 then
            u8();
        end;

        u9:Destroy();

        if u7 then
            PlayerList:SetRequestDuration(u4, u7, 0);
        end;
    end);
    u9.Container.DisplayName:GetPropertyChangedSignal("TextBounds"):Connect(function() -- Line: 79, Name: update
        -- upvalues: u9 (copy)
        u9.Container.DisplayName.Controls.Position = UDim2.new(0, u9.Container.DisplayName.TextBounds.X, 0.5, 0);
    end);
    u9.Container.DisplayName.Controls.Position = UDim2.new(0, u9.Container.DisplayName.TextBounds.X, 0.5, 0);
    u9.Container.Position = UDim2.new(4, 0, 0, 0);
    u9.Container:TweenPosition(UDim2.new(0, 0, 0, 0), "Out", "Quint", 0.5, true);
    u9.Container.Timeout.Bar.Size = UDim2.new(1, 0, 1, 0);
    u9.Container.Timeout.Bar:TweenSize(UDim2.new(0, 0, 1, 0), "Out", "Linear", p6, true);

    if u7 then
        PlayerList:SetRequestDuration(u4, u7, p6);
    end;
end;

function u1.ChallengeRequest(p10, u11, p12) -- Line: 96
    -- upvalues: RequestChallengeSlot (copy), ReplicatedStorage (copy)
    if not p10:_CanReceiveRequest(u11, "Challenge Requests") then
        return;
    end;

    p10:SendRequest(u11, RequestChallengeSlot, p12, "Challenge", function() -- Line: 101
        -- upvalues: ReplicatedStorage (ref), u11 (copy)
        ReplicatedStorage.Remotes.Misc.AcceptChallengeRequest:FireServer(u11);
    end);
end;

function u1.PartyRequest(p13, u14, p15) -- Line: 106
    -- upvalues: RequestPartySlot (copy), ReplicatedStorage (copy)
    if not p13:_CanReceiveRequest(u14, "Party Invites") then
        return;
    end;

    p13:SendRequest(u14, RequestPartySlot, p15, "Party", function() -- Line: 111
        -- upvalues: ReplicatedStorage (ref), u14 (copy)
        ReplicatedStorage.Remotes.Matchmaking.AcceptPartyInvite:FireServer(u14);
    end);
end;

function u1._UpdatePlayerList(p16) -- Line: 120
    -- upvalues: PlayerList (copy)
    p16.PlayerListBuffer:TweenSize(UDim2.new(1, 0, 0, PlayerList.Elements.Frame.AbsolutePosition.Y - PlayerList.Frame.AbsolutePosition.Y + (not PlayerList.IsOpen and -4 or PlayerList.Elements.Frame.AbsoluteSize.Y)), "Out", "Quint", 0.25, true);
    p16.Container.Size = UDim2.new(0, PlayerList.Elements.Frame.AbsoluteSize.X, 0, PlayerList.Elements.Frame.AbsoluteSize.X);
end;

function u1._UpdateVisibility(p17) -- Line: 127
    -- upvalues: Pages (copy), Equipment (copy), Queue (copy), Teleporting (copy), MobileInputs (copy), GuiService (copy)
    local v18 = not (Pages.PageSystem.CurrentPage or (Equipment.IsOpen or Queue:IsVisible() or (Teleporting.Enabled or MobileInputs.EditorEnabled))) and not GuiService.MenuIsOpen;
    local Container = p17.Container;
    local v19;

    if v18 then
        v19 = UDim2.new(1, 0, 0, 0);
    else
        v19 = UDim2.new(2, 20, 0, 0);
    end;

    Container:TweenPosition(v19, "Out", "Quint", 0.25, true);
end;

function u1._CanReceiveRequest(p20, p21, p22) -- Line: 133
    -- upvalues: PlayerDataController (copy), SocialController (copy)
    local Setting = PlayerDataController:GetSetting(p22);

    if Setting == "Everyone" then
        return true;
    end;

    if Setting == "Friends" then
        return SocialController:IsFriendsWith(p21.UserId);
    end;

    return false;
end;

function u1._QueuePadAdded(p23, p24) -- Line: 141
    -- upvalues: JoinQueuePadSlot (copy)
    JoinQueuePadSlot.new(p24).Frame.Parent = p23.Container;
end;

function u1._Init(u25) -- Line: 146
    -- upvalues: Equipment (copy), Pages (copy), Queue (copy), Teleporting (copy), MobileInputs (copy), GuiService (copy), PlayerList (copy), QueuePadController (copy)
    Equipment.Opened:Connect(function() -- Line: 147
        -- upvalues: u25 (copy)
        u25:_UpdateVisibility();
    end);
    Pages.PageSystem.PageOpened:Connect(function() -- Line: 151
        -- upvalues: u25 (copy)
        u25:_UpdateVisibility();
    end);
    Pages.PageSystem.PageClosed:Connect(function() -- Line: 155
        -- upvalues: u25 (copy)
        u25:_UpdateVisibility();
    end);
    Queue.VisibilityChanged:Connect(function() -- Line: 159
        -- upvalues: u25 (copy)
        u25:_UpdateVisibility();
    end);
    Teleporting.EnabledChanged:Connect(function() -- Line: 163
        -- upvalues: u25 (copy)
        u25:_UpdateVisibility();
    end);
    MobileInputs.EditorEnabledChanged:Connect(function() -- Line: 167
        -- upvalues: u25 (copy)
        u25:_UpdateVisibility();
    end);
    GuiService:GetPropertyChangedSignal("MenuIsOpen"):Connect(function() -- Line: 171
        -- upvalues: u25 (copy)
        u25:_UpdateVisibility();
    end);
    PlayerList.Frame:GetPropertyChangedSignal("AbsolutePosition"):Connect(function() -- Line: 175
        -- upvalues: u25 (copy)
        u25:_UpdatePlayerList();
    end);
    PlayerList.Elements.Frame:GetPropertyChangedSignal("AbsolutePosition"):Connect(function() -- Line: 179
        -- upvalues: u25 (copy)
        u25:_UpdatePlayerList();
    end);
    PlayerList.Elements.Frame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 183
        -- upvalues: u25 (copy)
        u25:_UpdatePlayerList();
    end);
    PlayerList.OpenedChanged:Connect(function() -- Line: 187
        -- upvalues: u25 (copy)
        u25:_UpdatePlayerList();
    end);
    QueuePadController.ObjectAdded:Connect(function(p26) -- Line: 191
        -- upvalues: u25 (copy)
        u25:_QueuePadAdded(p26);
    end);

    for _, v in pairs(QueuePadController.Objects) do
        task.defer(u25._QueuePadAdded, u25, v);
    end;

    u25:_UpdateVisibility();
    u25:_UpdatePlayerList();
end;

return u1._new();