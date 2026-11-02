-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local Utility = require(ReplicatedStorage.Modules.Utility);
local Signal = require(ReplicatedStorage.Modules.Signal);
local FighterController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("FighterController"));
local SocialController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("SocialController"));
local QueuePadController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("QueuePadController"));
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local TeammateSlot = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("TeammateSlot"));
local UILibrary = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"));
local LocalQueuePlayerSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("LocalQueuePlayerSlot");
local TitleVS = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("TitleVS");
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 23
    -- upvalues: u1 (copy), Signal (copy), UILibrary (copy)
    local v2 = setmetatable({}, u1);
    v2.VisibilityChanged = Signal.new();
    v2.Frame = UILibrary:GetTo("MainFrame", "Queue");
    v2.Container = v2.Frame:WaitForChild("Container");
    v2._cleanup = {};
    v2._countdown_hash = 0;
    v2._last_countdown_sound = nil;
    v2:_Init();

    return v2;
end;

function u1.IsVisible(p3) -- Line: 44
    return p3.Frame.Visible;
end;

function u1._UpdateInviteFrame(p4) -- Line: 52
    -- upvalues: SocialController (copy)
    p4.Container.Invite.Visible = SocialController.CanSendGameInvite and not p4.Container.Countdown.Visible;
end;

function u1._UpdateWaitingBackground(p5) -- Line: 56
    p5.Container.Waiting.Background.Size = UDim2.new(0, p5.Container.Background.AbsoluteSize.X, 0, p5.Container.Background.AbsoluteSize.Y);
end;

function u1._StartCountdown(p6) -- Line: 60
    -- upvalues: Utility (copy), TweenService (copy), RunService (copy)
    p6._countdown_hash = p6._countdown_hash + 1;
    local _countdown_hash = p6._countdown_hash;
    p6.Container.Countdown.Visible = true;
    p6.Container.Waiting.Visible = false;
    p6.Container.Start.Visible = false;

    for i = 3, 1, -1 do
        if _countdown_hash ~= p6._countdown_hash then
            return;
        end;

        p6.Container.Countdown.Value.Text = i;
        p6._last_countdown_sound = Utility:CreateSound("rbxassetid://17259538274", 0.5, 1, script, true, 5);
        local v7 = tick();
        local _ = i;

        while tick() < v7 + 0.375 do
            if _countdown_hash ~= p6._countdown_hash then
                return;
            end;

            local v8 = (tick() - v7) / 0.375;
            local Value = TweenService:GetValue(v8, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
            local Value2 = TweenService:GetValue(v8, Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
            p6.Container.Countdown.Value.Size = UDim2.new(1, 0, 1.25 - 0.625 * Value);
            p6.Container.Countdown.Glow.ImageTransparency = 0.875 - 0.25 * Value2;
            p6.Container.Countdown.Glow.Size = UDim2.new(Value2, 0, Value2, 0);
            RunService.RenderStepped:Wait();
        end;

        local v9 = tick();

        while tick() < v9 + 0.625 do
            if _countdown_hash ~= p6._countdown_hash then
                return;
            end;

            local v10 = (tick() - v9) / 0.625;
            local Value = TweenService:GetValue(v10, Enum.EasingStyle.Quint, Enum.EasingDirection.In);
            local Value2 = TweenService:GetValue(v10, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
            p6.Container.Countdown.Value.Size = UDim2.new(1, 0, 0.625 - 0.625 * Value);
            p6.Container.Countdown.Glow.ImageTransparency = 0.625 + 0.25 * Value2;
            RunService.RenderStepped:Wait();
        end;
    end;
end;

function u1._StopCountdown(p11) -- Line: 113
    p11._countdown_hash = p11._countdown_hash + 1;
    p11.Container.Countdown.Visible = false;

    if p11._last_countdown_sound then
        p11._last_countdown_sound:Destroy();
        p11._last_countdown_sound = nil;
    end;
end;

function u1._Update(p12) -- Line: 123
    -- upvalues: QueuePadController (copy), Players (copy), FighterController (copy), LocalQueuePlayerSlot (copy), TeammateSlot (copy), TitleVS (copy), CONSTANTS (copy)
    for _, v in pairs(p12._cleanup) do
        v:Destroy();
    end;

    p12._cleanup = {};
    local QueuePad = QueuePadController:GetQueuePad(Players.LocalPlayer);
    p12.Frame.Visible = QueuePad and true or false;
    p12.VisibilityChanged:Fire();

    if not p12.Frame.Visible then
        p12.Frame.UIScale.Scale = 1;
        p12:_StopCountdown();

        return;
    end;

    local ClientFightersWaiting = QueuePad:GetClientFightersWaiting();
    local v13 = 0;
    local v14 = 0;
    local v15 = 0;
    local v16 = 0;
    local v17 = 0;
    local v18 = 0;
    local v19 = 0;

    for i = 1, QueuePad:Get("NumTeams") do
        local v20 = ClientFightersWaiting[i];
        v13 = math.max(v13, #v20);
        v19 = table.find(v20, FighterController.LocalFighter) and (#v20 or v19) or v19;
        local v21 = i;
        local v22 = false;
        local v23 = false;

        for i2 = 1, QueuePad:Get("InfinitePlayersPerTeam") and (1 / 0) or QueuePad:Get("PlayersPerTeam") do
            local v24 = v20[i2];

            if not v24 and QueuePad:Get("InfinitePlayersPerTeam") then
                if v22 then
                    break;
                end;

                v22 = true;
            end;

            local v25 = LocalQueuePlayerSlot:Clone();
            local v26;

            if QueuePad:Get("NumTeams") == 2 and v21 == 1 then
                v26 = -v18 or v18;
            else
                v26 = v18;
            end;

            v25.LayoutOrder = v26;
            local Ready = v25.Container.Ready;
            local v27;

            if v24 then
                v27 = QueuePad:IsReady(v24.Player);
            else
                v27 = v24;
            end;

            Ready.Visible = v27;
            v25.Parent = p12.Container.Details;
            table.insert(p12._cleanup, v25);
            v14 = v14 + 1;
            v18 = v18 + 1;
            local v28;

            if v24 then
                v25.Container.Dots:Destroy();
                local v29 = TeammateSlot.new(v24.Player.UserId, v24:Get("Controls"), 1, false, true, v24.Player:GetAttribute("StatisticDuelsWinStreak"), v24.Player:GetAttribute("Level"));
                v29.SlotFrame.Container.Background.Visible = false;
                v29.SlotFrame.Parent = v25.Container;
                table.insert(p12._cleanup, v29);
                v15 = v15 + 1;
                v28 = i2;
                v23 = true;
            else
                v25.Container.Dots:AddTag("UILoadingDots");
                v28 = i2;
            end;
        end;

        if v21 ~= QueuePad:Get("NumTeams") then
            local v30 = TitleVS:Clone();
            v30.LayoutOrder = v18;
            v30.Parent = p12.Container.Details;
            table.insert(p12._cleanup, v30);
            v17 = v17 + 1;
            v18 = v18 + 1;
        end;

        if v23 then
            v16 = v16 + 1;
        end;
    end;

    p12.Frame.UIScale.Scale = math.clamp(1.3 - v14 * 0.05, 0.5, 1);
    p12.Container.Background.Size = UDim2.new(v17 * 0.7 + 0.125 + v14 * 0.875, 0, 1, 0);
    local Ready = p12.Container.Ready;
    local v31 = not QueuePad:Get("InfinitePlayersPerTeam");

    if v31 then
        if v16 == QueuePad:Get("NumTeams") and v19 < v13 then
            v31 = not QueuePad:IsReady(FighterController.LocalFighter.Player);
        else
            v31 = false;
        end;
    end;

    Ready.Visible = v31;
    local Start = p12.Container.Start;
    local v32 = QueuePad:Get("InfinitePlayersPerTeam");

    if v32 then
        if v16 > 1 then
            v32 = CONSTANTS.IS_PRIVATE_SERVER_OWNER(Players.LocalPlayer.UserId);
        else
            v32 = false;
        end;
    end;

    Start.Visible = v32;
    local Waiting = p12.Container.Waiting;
    local v33 = QueuePad:Get("InfinitePlayersPerTeam");

    if v33 then
        if v16 > 1 then
            v33 = not CONSTANTS.IS_PRIVATE_SERVER_OWNER(Players.LocalPlayer.UserId);
        else
            v33 = false;
        end;
    end;

    Waiting.Visible = v33;

    if QueuePad:Get("IsStarting") then
        p12:_StartCountdown();

        return;
    end;

    p12:_StopCountdown();
end;

function u1._WaitForLocalFighter(p34) -- Line: 219
    -- upvalues: FighterController (copy)
    FighterController:WaitForLocalFighter();
    p34:_Update();
end;

function u1._Init(u35) -- Line: 224
    -- upvalues: ReplicatedStorage (copy), SocialController (copy), QueuePadController (copy), ButtonEffect (copy)
    u35.Container.Background:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 225
        -- upvalues: u35 (copy)
        u35:_UpdateWaitingBackground();
    end);
    u35.Container.Countdown:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 229
        -- upvalues: u35 (copy)
        u35:_UpdateInviteFrame();
    end);
    u35.Container.Start.MouseButton1Click:Connect(function() -- Line: 233
        -- upvalues: ReplicatedStorage (ref)
        ReplicatedStorage.Remotes.PrivateServer.StartQueuePad:FireServer();
    end);
    u35.Container.Ready.MouseButton1Click:Connect(function() -- Line: 237
        -- upvalues: ReplicatedStorage (ref)
        ReplicatedStorage.Remotes.Misc.QueueReady:FireServer();
    end);
    u35.Container.Invite.Button.MouseButton1Click:Connect(function() -- Line: 241
        -- upvalues: SocialController (ref)
        SocialController:PromptFriendInvite();
    end);
    QueuePadController.LocalPlayerActivity:Connect(function() -- Line: 245
        -- upvalues: u35 (copy)
        u35:_Update();
    end);
    SocialController.CanSendGameInviteChanged:Connect(function() -- Line: 249
        -- upvalues: u35 (copy)
        u35:_UpdateInviteFrame();
    end);
    u35:_Update();
    u35:_UpdateInviteFrame();
    u35:_UpdateWaitingBackground();
    task.spawn(u35._WaitForLocalFighter, u35);
    ButtonEffect:Add(u35.Container.Start);
    ButtonEffect:Add(u35.Container.Ready);
    ButtonEffect:Add(u35.Container.Invite.Button, nil, {
        HoverRatio = UDim2.new(0, 10, 0, 10),
        ReleaseRatio = UDim2.new(0, 10, 0, 10)
    });
end;

return u1._new();