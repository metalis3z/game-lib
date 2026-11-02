-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local DuelLibrary = require(ReplicatedStorage.Modules.DuelLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local TeammateSlot = require(Players.LocalPlayer.PlayerScripts.Modules.TeammateSlot);
local DuelScoresTeammateScoreNeededSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("DuelScoresTeammateScoreNeededSlot");
local DuelScoresTeamScoreNeededSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("DuelScoresTeamScoreNeededSlot");
local DuelScoresChatBubbleContainer = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("DuelScoresChatBubbleContainer");
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 17
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.Teams = p2;
    v3._connections = {};
    v3._team_slots = {};
    v3._dueler_slots = {};
    v3._bubbles_end_time = nil;
    v3:_Init();

    return v3;
end;

function u1.GetChatBubbleContainer(p4, p5) -- Line: 36
    for i, v in pairs(p4._dueler_slots) do
        if i.Player == p5 then
            return v.ChatBubbleContainer;
        end;
    end;
end;

function u1.Generate(u6) -- Line: 44
    -- upvalues: DuelLibrary (copy), DuelScoresTeamScoreNeededSlot (copy), Players (copy)
    u6:_Clear();

    if u6.Teams.Scores.DuelInterface.ClientDuel:Get("ScoresBehavior") ~= "Teams" or not u6.Teams.Scores.DuelInterface.ClientDuel:Get("ScoreNeededToWin") then
        return;
    end;

    if u6.Teams.Scores.DuelInterface.ClientDuel:Get("VoteOptions") then
        u6._bubbles_end_time = nil;

        return;
    end;

    u6._bubbles_end_time = u6._bubbles_end_time or tick() + 12;
    local v7 = tick() < u6._bubbles_end_time;
    local u8 = {};

    for i = 1, u6.Teams.Scores.DuelInterface.ClientDuel:Get("NumTeams") do
        local v9 = DuelLibrary.Teams[i];
        local v10 = u6.Teams.Scores.DuelInterface.ClientDuel.LocalDueler and v9.TeamID == u6.Teams.Scores.DuelInterface.ClientDuel.LocalDueler:Get("TeamID");

        if not u6.Teams.Scores.DuelInterface.ClientDuel.LocalDueler then
            v10 = i % 2 == 0;
        end;

        local TeamColor = DuelLibrary:GetTeamColor(v9.TeamID);
        local Color3_new_ret = Color3.new(TeamColor.R * 0.5, TeamColor.G * 0.5, TeamColor.B * 0.5);
        local v11 = DuelScoresTeamScoreNeededSlot:Clone();
        v11.Container.Bubble.Visible = v10 and v7;
        v11.Container.Progress.Bar.BackgroundColor3 = Color3_new_ret;
        v11.Container.Progress.Bar.UIStroke.Color = Color3_new_ret;
        v11.Container.Progress.Bar.Bar.BackgroundColor3 = TeamColor;
        v11.Container.Progress.Bar.Bar.UIStroke.Color = TeamColor;
        v11.AnchorPoint = v10 and Vector2.new(1, 0) or Vector2.new(0, 0);
        v11.Container.AnchorPoint = v10 and Vector2.new(1, 0.5) or Vector2.new(0, 0.5);
        v11.Container.Position = v10 and UDim2.new(1, 0, 0.5, 0) or UDim2.new(0, 0, 0.5, 0);
        v11.Container.Progress.Position = v10 and UDim2.new(1, 0, 0.5, 0) or UDim2.new(0, 0, 0.5, 0);
        v11.Container.Progress.AnchorPoint = v10 and Vector2.new(1, 0.5) or Vector2.new(0, 0.5);
        v11.Container.Progress.Bar.Bar.Position = v10 and UDim2.new(0, -1, 0.5, 0) or UDim2.new(1, 1, 0.5, 0);
        v11.Container.Progress.Bar.Bar.AnchorPoint = v10 and Vector2.new(0, 0.5) or Vector2.new(1, 0.5);
        v11.Container.Progress.Bar.Bar.Value.AnchorPoint = v10 and Vector2.new(1, 0.5) or Vector2.new(0, 0.5);
        v11.Container.Progress.Bar.Bar.Value.Position = v10 and UDim2.new(1, 0, 0.5, 0) or UDim2.new(0, 0, 0.5, 0);
        v11.Container.Progress.Bar.Bar.Value.Title.AnchorPoint = v10 and Vector2.new(1, 0.5) or Vector2.new(0, 0.5);
        v11.Container.Progress.Bar.Bar.Value.Title.Position = v10 and UDim2.new(0.875, 0, 0.5, 0) or UDim2.new(0.125, 0, 0.5, 0);
        v11.Container.Progress.Bar.Bar.Value.Title.TextXAlignment = v10 and Enum.TextXAlignment.Right or Enum.TextXAlignment.Left;
        v11.Container.Teammates.Position = v10 and UDim2.new(-7.5, 0, 1.75, 0) or UDim2.new(8.5, 0, 1.75, 0);
        v11.Container.Teammates.Layout.HorizontalAlignment = v10 and Enum.HorizontalAlignment.Left or Enum.HorizontalAlignment.Right;
        v11.LayoutOrder = i;
        v11.Parent = v10 and u6.Teams.LeftFrame or u6.Teams.RightFrame;
        u6._team_slots[i] = v11;
        table.insert(u8, v11.Container.Bubble);
        local Background = v11.Container.Bubble.Container.Background;
        local Title = v11.Container.Bubble.Container.Title;
        Title:GetPropertyChangedSignal("TextBounds"):Connect(function() -- Line: 96, Name: update
            -- upvalues: Background (copy), Title (copy)
            Background.Size = UDim2.new(1.625, Title.TextBounds.X, 1, 0);
        end);
        Background.Size = UDim2.new(1.625, Title.TextBounds.X, 1, 0);
        local _ = i;
    end;

    if v7 then
        local task_spawn_ret = task.spawn(function() -- Line: 106
            -- upvalues: u8 (copy), Players (ref)
            while true do
                for _, v in pairs(u8) do
                    if v:IsDescendantOf(Players) then
                        v:TweenPosition(UDim2.new(1, 0, 1.5, 0), "Out", "Sine", 0.5, true);
                    end;
                end;

                wait(0.5);

                for _, v in pairs(u8) do
                    if v:IsDescendantOf(Players) then
                        v:TweenPosition(UDim2.new(1, 0, 1.25, 0), "In", "Sine", 0.5, true);
                    end;
                end;

                wait(0.5);
            end;
        end);
        task.delay(u6._bubbles_end_time - tick(), function() -- Line: 126
            -- upvalues: task_spawn_ret (copy), u8 (copy)
            task.cancel(task_spawn_ret);

            for _, v in pairs(u8) do
                v.Visible = false;
            end;
        end);
    end;

    local _connections = u6._connections;
    local DataChangedSignal = u6.Teams.Scores.DuelInterface.ClientDuel:GetDataChangedSignal("Scores");
    table.insert(_connections, DataChangedSignal:Connect(function(p12) -- Line: 135
        -- upvalues: u6 (copy)
        u6:_UpdateScores();
    end));
    table.insert(u6._connections, u6.Teams.Scores.DuelInterface.ClientDuel.DuelerAdded:Connect(function(p13) -- Line: 139
        -- upvalues: u6 (copy)
        u6:_AddClientDueler(p13);
    end));

    if u6.Teams.Scores.DuelInterface.ClientDuel:Get("ArcadeMode") then
        table.insert(u6._connections, u6.Teams.Scores.DuelInterface.ClientDuel.DuelerRemoved:Connect(function(p14) -- Line: 144
            -- upvalues: u6 (copy)
            u6:_RemoveClientDueler(p14);
        end));
    end;

    for i in pairs(u6.Teams.Scores.DuelInterface:GetLoggedClientDuelers()) do
        u6:_AddClientDueler(i, true);
    end;

    u6:_UpdateScores();
end;

function u1.Destroy(p15) -- Line: 157
    p15:_Clear();
end;

function u1._UpdateScores(p16) -- Line: 165
    -- upvalues: DuelLibrary (copy), Utility (copy)
    local v17 = p16.Teams.Scores.DuelInterface.ClientDuel:Get("ScoreNeededToWin");
    local v18 = p16.Teams.Scores.DuelInterface.ClientDuel:Get("Scores");

    for i, v in pairs(p16._team_slots) do
        local v19 = v18[DuelLibrary.Teams[i].TeamID];
        v.Container.Bubble.Container.Title.Text = Utility:PrettyNumber(v17) .. " points to win";
        v.Container.Progress.Bar.Bar.Value.Title.Text = " " .. Utility:PrettyNumber(v19) .. " ";
        v.Container.Progress.Bar.Bar.Size = UDim2.new(math.clamp(v19 / v17, 0.125, 1), 2, 1, 2);
    end;
end;

function u1._RemoveClientDueler(p20, p21) -- Line: 178
    local v22 = p20._dueler_slots[p21];

    if not v22 then
        return;
    end;

    for _, v in pairs(v22.Connections) do
        v:Disconnect();
    end;

    v22.PlayerSlot:Destroy();
    v22.TeammateSlot:Destroy();
    p20._dueler_slots[p21] = nil;
end;

function u1._AddClientDueler(u23, u24) -- Line: 194
    -- upvalues: DuelScoresTeammateScoreNeededSlot (copy), DuelLibrary (copy), TeammateSlot (copy), DuelScoresChatBubbleContainer (copy)
    u23:_RemoveClientDueler(u24);
    local v25 = {};
    local u26 = DuelScoresTeammateScoreNeededSlot:Clone();

    local function update_parent() -- Line: 201
        -- upvalues: u24 (copy), u26 (copy), u23 (copy), DuelLibrary (ref)
        local v27 = u24:Get("TeamID");
        local v28;

        if v27 then
            v28 = u23._team_slots[DuelLibrary.TeamsByID[v27].TeamIndex].Container.Teammates;
        else
            v28 = nil;
        end;

        u26.Parent = v28;
    end;

    local DataChangedSignal = u24:GetDataChangedSignal("TeamID");
    table.insert(v25, DataChangedSignal:Connect(update_parent));
    local v29 = TeammateSlot.new(u24.Player.UserId, nil, nil, nil, true);
    v29.SlotFrame.Container.Size = UDim2.new(0.825, 0, 0.825, 0);
    v29.SlotFrame.Container.Headshot.UICorner.CornerRadius = UDim.new(1, 0);
    v29.SlotFrame.Container.Background.Visible = false;
    v29.SlotFrame.Parent = u26;
    local v30 = DuelScoresChatBubbleContainer:Clone();
    v30.Size = UDim2.new(1.5, 0, 1.5, 0);
    v30.Position = UDim2.new(0.5, 0, 1.25, 0);
    v30.Parent = v29.SlotFrame;
    local v31 = u24:Get("TeamID");
    local v32;

    if v31 then
        v32 = u23._team_slots[DuelLibrary.TeamsByID[v31].TeamIndex].Container.Teammates;
    else
        v32 = nil;
    end;

    u26.Parent = v32;
    u23._dueler_slots[u24] = {
        ClientDueler = u24,
        PlayerSlot = u26,
        TeammateSlot = v29,
        ChatBubbleContainer = v30,
        Connections = v25
    };
end;

function u1._Clear(p33) -- Line: 230
    for _, v in pairs(p33._connections) do
        v:Disconnect();
    end;

    for _, v in pairs(p33._team_slots) do
        v:Destroy();
    end;

    for i in pairs(p33._dueler_slots) do
        p33:_RemoveClientDueler(i);
    end;

    p33._connections = {};
    p33._team_slots = {};
    p33._dueler_slots = {};
end;

function u1._Init(p34) -- Line: 248
end;

return u1;