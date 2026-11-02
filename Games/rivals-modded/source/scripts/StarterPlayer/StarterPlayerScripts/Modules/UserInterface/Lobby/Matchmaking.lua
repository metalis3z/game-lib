-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local GuiService = game:GetService("GuiService");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local DuelLibrary = require(ReplicatedStorage.Modules.DuelLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local Signal = require(ReplicatedStorage.Modules.Signal);
local MatchmakingController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("MatchmakingController"));
require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"));
local MobileInputs = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("MobileInputs"));
local Teleporting = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Teleporting"));
local Equipment = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Equipment"));
local Queue = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Queue"));
local Pages = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Pages"));
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local UILibrary = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"));
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 25
    -- upvalues: u1 (copy), Signal (copy), UILibrary (copy)
    local v2 = setmetatable({}, u1);
    v2.VisibilityChanged = Signal.new();
    v2.OpenedChanged = Signal.new();
    v2.Frame = UILibrary:GetTo("MainFrame", "Lobby", "Matchmaking");
    v2.Container = v2.Frame:WaitForChild("Container");
    v2.LeavingFrame = v2.Container:WaitForChild("Leaving");
    v2.LeavingDotsFrame = v2.LeavingFrame:WaitForChild("Dots");
    v2.LeaveButton = v2.Container:WaitForChild("Leave");
    v2.Icon = v2.Container:WaitForChild("Icon");
    v2.TitleText = v2.Container:WaitForChild("Title");
    v2.TimerText = v2.Container:WaitForChild("Timer");
    v2.QueueText = v2.Container:WaitForChild("Queue");
    v2._current_queue_name = nil;
    v2._queue_hash = 0;
    v2._renderstep_connection = nil;
    v2._is_open = false;
    v2:_Init();

    return v2;
end;

function u1.IsVisible(p3) -- Line: 55
    return p3.Container.Visible;
end;

function u1.IsOpened(p4) -- Line: 59
    local v5 = p4:IsVisible() and p4._is_open;

    return v5;
end;

function u1._SetIsLeaving(p6, p7) -- Line: 67
    p6.LeavingFrame.Visible = p7;
    p6.LeaveButton.Visible = not p7;

    if p7 then
        p6.LeavingDotsFrame:AddTag("UILoadingDots");

        return;
    end;

    p6.LeavingDotsFrame:RemoveTag("UILoadingDots");
end;

function u1._SetQueueName(u8, p9) -- Line: 78
    -- upvalues: DuelLibrary (copy), Utility (copy)
    u8._queue_hash = u8._queue_hash + 1;
    u8._current_queue_name = p9;
    local _queue_hash = u8._queue_hash;
    local v10 = DuelLibrary.MatchmakingQueues[u8._current_queue_name];
    u8.Container.Visible = u8._current_queue_name ~= nil;
    u8.QueueText.Text = v10 and (v10.DisplayName or "") or "";
    u8.Icon.Image = v10 and v10.Image or "";
    u8:_SetIsLeaving(false);
    u8.VisibilityChanged:Fire();
    u8.OpenedChanged:Fire();

    if not u8._current_queue_name then
        return;
    end;

    Utility:CreateSound("rbxassetid://18525513345", 1, 1, script, true, 5);
    task.spawn(function() -- Line: 100
        -- upvalues: u8 (copy), _queue_hash (copy), Utility (ref)
        for i = 0, (1 / 0) do
            if u8._queue_hash ~= _queue_hash then
                return;
            end;

            u8.TimerText.Text = Utility:TimeFormat(i);
            wait(1);
            local _ = i;
        end;
    end);
end;

function u1._UpdateVisibility(u11) -- Line: 113
    -- upvalues: Pages (copy), Equipment (copy), Queue (copy), Teleporting (copy), MobileInputs (copy), GuiService (copy), RunService (copy), DuelLibrary (copy)
    local v12 = not (Pages.PageSystem.CurrentPage or (Equipment.IsOpen or Queue:IsVisible() or (Teleporting.Enabled or MobileInputs.EditorEnabled))) and not GuiService.MenuIsOpen;
    u11._is_open = v12;
    u11.OpenedChanged:Fire();
    u11.Container:TweenPosition(u11._is_open and UDim2.new(0.5, 0, 0.075, 40) or UDim2.new(0.5, 0, -0.2, -40), "Out", "Quint", 0.25, true);

    if u11._renderstep_connection then
        u11._renderstep_connection:Disconnect();
        u11._renderstep_connection = nil;
    end;

    local u13 = 0;
    local u14 = tick() + 0.5;
    local v18 = u11._is_open and RunService.RenderStepped:Connect(function(p15) -- Line: 127
        -- upvalues: u11 (copy), u14 (ref), u13 (ref), DuelLibrary (ref)
        local Icon = u11.Icon;
        local v16 = tick();
        Icon.Rotation = math.sin(v16) * 5;

        if tick() < u14 then
            return;
        end;

        u13 = (u13 + 1) % 4;
        u14 = tick() + 0.5;
        local v17 = u11._current_queue_name and DuelLibrary.PlaySources[u11._current_queue_name];
        u11.TitleText.Text = (v17 and (v17.DuelLogic == "Zombie Tower" and "Searching for zombies" or (v17.DatabaseInfo.NumTeams * v17.DatabaseInfo.PlayersPerTeam <= 1 and "Waiting for server" or "Searching for players")) or "Searching for players") .. string.rep(".", u13);
    end);
    u11._renderstep_connection = v18;
end;

function u1._Init(u19) -- Line: 147
    -- upvalues: MatchmakingController (copy), Equipment (copy), Pages (copy), Queue (copy), Teleporting (copy), MobileInputs (copy), GuiService (copy), ReplicatedStorage (copy), ButtonEffect (copy)
    u19.LeaveButton.MouseButton1Click:Connect(function() -- Line: 148
        -- upvalues: u19 (copy), MatchmakingController (ref)
        u19:_SetIsLeaving(true);
        MatchmakingController:TryLeaveQueue();
    end);
    Equipment.Opened:Connect(function() -- Line: 153
        -- upvalues: u19 (copy)
        u19:_UpdateVisibility();
    end);
    Pages.PageSystem.PageOpened:Connect(function() -- Line: 157
        -- upvalues: u19 (copy)
        u19:_UpdateVisibility();
    end);
    Pages.PageSystem.PageClosed:Connect(function() -- Line: 161
        -- upvalues: u19 (copy)
        u19:_UpdateVisibility();
    end);
    Queue.VisibilityChanged:Connect(function() -- Line: 165
        -- upvalues: u19 (copy)
        u19:_UpdateVisibility();
    end);
    Teleporting.EnabledChanged:Connect(function() -- Line: 169
        -- upvalues: u19 (copy)
        u19:_UpdateVisibility();
    end);
    MobileInputs.EditorEnabledChanged:Connect(function() -- Line: 173
        -- upvalues: u19 (copy)
        u19:_UpdateVisibility();
    end);
    GuiService:GetPropertyChangedSignal("MenuIsOpen"):Connect(function() -- Line: 177
        -- upvalues: u19 (copy)
        u19:_UpdateVisibility();
    end);
    ReplicatedStorage.Remotes.Matchmaking.UpdateQueueStatus.OnClientEvent:Connect(function(...) -- Line: 181
        -- upvalues: u19 (copy)
        u19:_SetQueueName(...);
    end);
    u19:_SetQueueName(nil);
    u19:_SetIsLeaving(false);
    u19:_UpdateVisibility();
    ButtonEffect:Add(u19.LeaveButton);
end;

return u1._new();