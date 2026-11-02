-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
require(ReplicatedStorage.Modules.CONSTANTS);
local ComplianceController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ComplianceController"));
local ControlsController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ControlsController"));
local SpectateController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("SpectateController"));
local ArcadeController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ArcadeController"));
local CameraController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("CameraController"));
local EliminatedEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("UserInterface"):WaitForChild("EliminatedEffect"));
local Pages = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("UserInterface"):WaitForChild("Pages"));
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local UILibrary = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"));
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 18
    -- upvalues: u1 (copy), UILibrary (copy)
    local v2 = setmetatable({}, u1);
    v2.BottomStackFrame = UILibrary:GetTo("MainFrame", "BottomStack");
    v2.BufferFrame = UILibrary:GetTo("MainFrame", "BottomStack", "SpectateBuffer");
    v2.Frame = UILibrary:GetTo("MainFrame", "BottomStack", "Spectate");
    v2.Container = v2.Frame:WaitForChild("Container");
    v2.Background = v2.Container:WaitForChild("Background");
    v2.NextButton = v2.Container:WaitForChild("Next");
    v2.LastButton = v2.Container:WaitForChild("Last");
    v2.ExitButton = v2.Container:WaitForChild("Exit");
    v2.JoinButton = v2.Container:WaitForChild("Join");
    v2.JoinButtonOff = v2.JoinButton:WaitForChild("Off");
    v2.JoinButtonOffTitle = v2.JoinButtonOff:WaitForChild("Title");
    v2.JoinButtonOn = v2.JoinButton:WaitForChild("On");
    v2.JoinBubble = v2.JoinButtonOn:WaitForChild("Bubble");
    v2.PlayerText = v2.Container:WaitForChild("Player");
    v2.UsernameText = v2.Container:WaitForChild("Username");
    v2.FreecamButton = v2.Container:WaitForChild("Freecam");
    v2.ExitFreecamButton = v2.Container:WaitForChild("ExitFreecam");
    v2._duel_connections = {};
    v2._fighter_connections = {};
    v2._join_bubble_connection = nil;
    v2._join_bubble_hash = 0;
    v2:_Init();

    return v2;
end;

function u1._UpdateBuffer(p3) -- Line: 59
    -- upvalues: SpectateController (copy)
    p3.BufferFrame.Size = UDim2.new(1, 0, 0, (math.max((SpectateController.CurrentSubject and (SpectateController.CurrentSubject.FighterInterface and SpectateController.CurrentSubject.FighterInterface.BottomCenter.Layout.AbsoluteContentSize.Y) or 0) + p3.BottomStackFrame.AbsoluteSize.Y * 0.03, p3.BottomStackFrame.AbsoluteSize.Y * 0.2)));
end;

function u1._UpdateJoinCooldown(p4) -- Line: 65
    -- upvalues: ArcadeController (copy)
    local JoinCooldown = ArcadeController:GetJoinCooldown();
    local v5 = ArcadeController:CanJoin();
    p4.JoinButtonOffTitle.Text = JoinCooldown > 0 and JoinCooldown and JoinCooldown or "Join";
    p4.JoinButtonOff.Visible = not v5;
    p4.JoinButtonOn.Visible = v5;
end;

function u1._Update(u6) -- Line: 74
    -- upvalues: Pages (copy), SpectateController (copy), CameraController (copy), ComplianceController (copy), ControlsController (copy), EliminatedEffect (copy), Players (copy)
    local v7 = not Pages.PageSystem.CurrentPage;

    if v7 then
        local v8 = SpectateController.CurrentDuelSubject and SpectateController.CurrentDuelSubject.LocalDueler and not SpectateController:IsThereValidSubject();
        v7 = not v8;
    end;

    local v9 = CameraController:GetPublicState() == CameraController.CameraState.States.CustomFreecam;
    local JoinButton = u6.JoinButton;
    local v10 = v7 and not v9 and (SpectateController.CurrentDuelSubject and not SpectateController.CurrentDuelSubject.LocalDueler) and SpectateController.CurrentDuelSubject:Get("IsCurrentArcadeDuel");
    JoinButton.Visible = v10;
    local v11;

    if v7 then
        v11 = not v9;
    else
        v11 = v7;
    end;

    u6.Background.Visible = v11;
    local v12;

    if v7 then
        v12 = not v9;
    else
        v12 = v7;
    end;

    u6.LastButton.Visible = v12;
    local v13;

    if v7 then
        v13 = not v9;
    else
        v13 = v7;
    end;

    u6.NextButton.Visible = v13;
    local v14;

    if v7 then
        v14 = not v9;
    else
        v14 = v7;
    end;

    u6.PlayerText.Visible = v14;
    local v15;

    if v7 then
        v15 = not v9;
    else
        v15 = v7;
    end;

    u6.UsernameText.Visible = v15;
    u6.ExitFreecamButton.Visible = false;
    u6.PlayerText.Text = v7 and not SpectateController.CurrentDuelSubject and "" or (not SpectateController.CurrentSubject and u6.PlayerText.Text or ComplianceController:GetName(SpectateController.CurrentSubject.Player));
    u6.UsernameText.Text = v7 and not SpectateController.CurrentDuelSubject and "" or (not SpectateController.CurrentSubject and u6.UsernameText.Text or (SpectateController.CurrentSubject.Player.DisplayName ~= SpectateController.CurrentSubject.Player.Name and "@" .. SpectateController.CurrentSubject.Player.Name or ""));
    u6.PlayerText.Position = v7 and u6.UsernameText.Text == "" and UDim2.new(0.5, 0, 0.5, 0) or UDim2.new(0.5, 0, 0.35, 0);
    local v16 = v7 and (SpectateController.CurrentDuelSubject and not SpectateController.CurrentDuelSubject.LocalDueler);

    if v16 then
        if ControlsController.CurrentControls == "MouseKeyboard" then
            v16 = not v9;
        else
            v16 = false;
        end;
    end;

    u6.FreecamButton.Visible = v16;

    if v7 then
        v7 = SpectateController.CurrentDuelSubject and not SpectateController.CurrentDuelSubject.LocalDueler and not v9;
    end;

    u6.ExitButton.Visible = v7;
    u6.Frame.Size = u6.ExitButton.Visible and UDim2.new(0.04, 20, 0.08, 40) or UDim2.new(0.04, 20, 0.04, 20);
    local Frame = u6.Frame;
    local CurrentDuelSubject = SpectateController.CurrentDuelSubject;

    if CurrentDuelSubject then
        CurrentDuelSubject = not (SpectateController.CurrentSubject and SpectateController.CurrentSubject.IsLocalPlayer or SpectateController.CurrentDuelSubject:Get("VoteOptions"));

        if CurrentDuelSubject then
            if SpectateController.CurrentDuelSubject:Get("Status") == "GameOver" then
                CurrentDuelSubject = false;
            else
                CurrentDuelSubject = not (SpectateController.CurrentDuelSubject.DuelInterface.Buttons:IsAnythingVisible() or SpectateController.CurrentDuelSubject.DuelInterface.Scoreboard:IsOpen()) and not EliminatedEffect:IsVisible();
            end;
        end;
    end;

    Frame.Visible = CurrentDuelSubject;
    u6._join_bubble_hash = u6._join_bubble_hash + 1;
    local _join_bubble_hash = u6._join_bubble_hash;
    task.defer(function() -- Line: 102
        -- upvalues: u6 (copy), _join_bubble_hash (copy), Players (ref)
        if not (u6.JoinButton.Visible and u6.JoinBubble.Visible) then
            return;
        end;

        if _join_bubble_hash ~= u6._join_bubble_hash then
            return;
        end;

        while true do
            if u6.JoinBubble:IsDescendantOf(Players) then
                u6.JoinBubble:TweenPosition(UDim2.new(0.5, 0, -0.6, 0), "Out", "Sine", 0.5, true);
            end;

            wait(0.5);

            if _join_bubble_hash ~= u6._join_bubble_hash then
                return;
            end;

            if u6.JoinBubble:IsDescendantOf(Players) then
                u6.JoinBubble:TweenPosition(UDim2.new(0.5, 0, -0.25, 0), "In", "Sine", 0.5, true);
            end;

            wait(0.5);

            if _join_bubble_hash ~= u6._join_bubble_hash then
                return;
            end;
        end;
    end);
end;

function u1._ListenFighterSubject(u17) -- Line: 135
    -- upvalues: SpectateController (copy)
    for _, v in pairs(u17._fighter_connections) do
        v:Disconnect();
    end;

    u17._fighter_connections = {};

    if not SpectateController.CurrentSubject then
        u17:_UpdateBuffer();

        return;
    end;

    table.insert(u17._fighter_connections, SpectateController.CurrentSubject.InterfaceRemoved:Connect(function(p18) -- Line: 147
        -- upvalues: u17 (copy)
        u17:_UpdateBuffer();
    end));

    local function interface_added(p19) -- Line: 151
        -- upvalues: u17 (copy)
        local _fighter_connections = u17._fighter_connections;
        local PropertyChangedSignal = p19.BottomCenter.Layout:GetPropertyChangedSignal("AbsoluteContentSize");
        table.insert(_fighter_connections, PropertyChangedSignal:Connect(function() -- Line: 152
            -- upvalues: u17 (ref)
            u17:_UpdateBuffer();
        end));
        u17:_UpdateBuffer();
    end;

    table.insert(u17._fighter_connections, SpectateController.CurrentSubject.InterfaceAdded:Connect(interface_added));

    if SpectateController.CurrentSubject.FighterInterface then
        task.spawn(interface_added, SpectateController.CurrentSubject.FighterInterface);
    end;

    u17:_UpdateBuffer();
end;

function u1._ListenDuelSubject(u20) -- Line: 168
    -- upvalues: SpectateController (copy), ControlsController (copy), Pages (copy), ArcadeController (copy)
    for _, v in pairs(u20._duel_connections) do
        v:Disconnect();
    end;

    u20._duel_connections = {};

    if not SpectateController.CurrentDuelSubject then
        u20:_Update();
        u20:_UpdateBuffer();

        return;
    end;

    local _duel_connections = u20._duel_connections;
    local DataChangedSignal = SpectateController.CurrentDuelSubject:GetDataChangedSignal("VoteOptions");
    table.insert(_duel_connections, DataChangedSignal:Connect(function() -- Line: 181
        -- upvalues: u20 (copy)
        u20:_Update();
    end));
    local _duel_connections2 = u20._duel_connections;
    local DataChangedSignal2 = SpectateController.CurrentDuelSubject:GetDataChangedSignal("Status");
    table.insert(_duel_connections2, DataChangedSignal2:Connect(function() -- Line: 185
        -- upvalues: u20 (copy)
        u20:_Update();
    end));
    local _duel_connections3 = u20._duel_connections;
    local DataChangedSignal3 = SpectateController.CurrentDuelSubject:GetDataChangedSignal("IsCurrentArcadeDuel");
    table.insert(_duel_connections3, DataChangedSignal3:Connect(function() -- Line: 189
        -- upvalues: u20 (copy)
        u20:_Update();
    end));
    table.insert(u20._duel_connections, SpectateController.CurrentDuelSubject.DuelInterface.Scoreboard.VisibilityChanged:Connect(function() -- Line: 193
        -- upvalues: u20 (copy)
        u20:_Update();
    end));
    table.insert(u20._duel_connections, SpectateController.CurrentDuelSubject.DuelInterface.Buttons.Updated:Connect(function() -- Line: 197
        -- upvalues: u20 (copy)
        u20:_Update();
    end));
    table.insert(u20._duel_connections, SpectateController.SubjectChanged:Connect(function() -- Line: 201
        -- upvalues: u20 (copy)
        u20:_Update();
    end));
    table.insert(u20._duel_connections, ControlsController.ControlsChanged:Connect(function() -- Line: 205
        -- upvalues: u20 (copy)
        u20:_Update();
    end));
    table.insert(u20._duel_connections, Pages.PageSystem.PagesActivity:Connect(function() -- Line: 209
        -- upvalues: u20 (copy)
        u20:_Update();
    end));
    table.insert(u20._duel_connections, ArcadeController.UpdateJoinCooldown:Connect(function() -- Line: 213
        -- upvalues: u20 (copy)
        u20:_UpdateJoinCooldown();
    end));
    u20:_Update();
    u20:_UpdateBuffer();
    u20:_UpdateJoinCooldown();
end;

function u1._Init(u21) -- Line: 222
    -- upvalues: SpectateController (copy), CameraController (copy), ArcadeController (copy), EliminatedEffect (copy), ButtonEffect (copy)
    u21.NextButton.MouseButton1Click:Connect(function() -- Line: 223
        -- upvalues: SpectateController (ref)
        SpectateController:Next();
    end);
    u21.LastButton.MouseButton1Click:Connect(function() -- Line: 227
        -- upvalues: SpectateController (ref)
        SpectateController:Last();
    end);
    u21.ExitButton.MouseButton1Click:Connect(function() -- Line: 231
        -- upvalues: SpectateController (ref)
        SpectateController:Exit();
    end);
    u21.FreecamButton.MouseButton1Click:Connect(function() -- Line: 235
        -- upvalues: CameraController (ref)
        CameraController.CameraState:SetCustomFreecamEnabled(true);
    end);
    u21.ExitFreecamButton.MouseButton1Click:Connect(function() -- Line: 239
        -- upvalues: CameraController (ref)
        CameraController.CameraState:SetCustomFreecamEnabled(false);
    end);
    u21.JoinButton.MouseButton1Click:Connect(function() -- Line: 243
        -- upvalues: ArcadeController (ref), u21 (copy)
        ArcadeController:Join();
        u21.JoinBubble.Visible = false;
        u21:_Update();
    end);
    u21.BottomStackFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 249
        -- upvalues: u21 (copy)
        u21:_UpdateBuffer();
    end);
    CameraController.CustomFreecamStateChanged:Connect(function() -- Line: 253
        -- upvalues: u21 (copy)
        u21:_Update();
    end);
    EliminatedEffect.VisibilityChanged:Connect(function() -- Line: 257
        -- upvalues: u21 (copy)
        u21:_Update();
    end);
    SpectateController.SubjectChanged:Connect(function() -- Line: 261
        -- upvalues: u21 (copy)
        u21:_ListenFighterSubject();
    end);
    SpectateController.DuelSubjectChanged:Connect(function() -- Line: 265
        -- upvalues: u21 (copy)
        u21:_ListenDuelSubject();
    end);
    u21:_UpdateBuffer();
    task.spawn(u21._ListenDuelSubject, u21);
    task.spawn(u21._ListenFighterSubject, u21);
    ButtonEffect:Add(u21.NextButton);
    ButtonEffect:Add(u21.LastButton);
    ButtonEffect:Add(u21.ExitButton);
    ButtonEffect:Add(u21.JoinButton);
    ButtonEffect:Add(u21.FreecamButton);
    ButtonEffect:Add(u21.ExitFreecamButton);
end;

return u1._new();