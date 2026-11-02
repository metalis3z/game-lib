-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local DuelLibrary = require(ReplicatedStorage.Modules.DuelLibrary);
local TeammateSlot = require(Players.LocalPlayer.PlayerScripts.Modules.TeammateSlot);
local DuelScoresChatBubbleContainer = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("DuelScoresChatBubbleContainer");
local DuelScoresTeamSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("DuelScoresTeamSlot");
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 13
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.Teams = p2;
    v3._connections = {};
    v3._team_slots = {};
    v3._dueler_slots = {};
    v3:_Init();

    return v3;
end;

function u1.GetChatBubbleContainer(p4, p5) -- Line: 31
    for i, v in pairs(p4._dueler_slots) do
        if i.Player == p5 then
            return v.ChatBubbleContainer;
        end;
    end;
end;

function u1.Generate(u6) -- Line: 39
    -- upvalues: DuelLibrary (copy), DuelScoresTeamSlot (copy)
    u6:_Clear();

    if u6.Teams.Scores.DuelInterface.ClientDuel:Get("ScoresBehavior") ~= "Teams" or u6.Teams.Scores.DuelInterface.ClientDuel:Get("ScoreNeededToWin") then
        return;
    end;

    for i = 1, u6.Teams.Scores.DuelInterface.ClientDuel:Get("NumTeams") do
        local v7 = DuelLibrary.Teams[i];
        local v8 = u6.Teams.Scores.DuelInterface.ClientDuel.LocalDueler and v7.TeamID == u6.Teams.Scores.DuelInterface.ClientDuel.LocalDueler:Get("TeamID");

        if not u6.Teams.Scores.DuelInterface.ClientDuel.LocalDueler then
            v8 = i % 2 == 0;
        end;

        local u9 = DuelScoresTeamSlot:Clone();
        u9.Background.ImageColor3 = DuelLibrary:GetTeamColor(v7.TeamID);
        u9.Container.Position = v8 and UDim2.new(1, 0, 0.5, 0) or UDim2.new(0, 0, 0.5, 0);
        u9.Container.AnchorPoint = v8 and Vector2.new(1, 0.5) or Vector2.new(0, 0.5);
        u9.Container.Teammates.Position = v8 and UDim2.new(0, 0, 0.5, 0) or UDim2.new(1, 0, 0.5, 0);
        u9.Container.Teammates.AnchorPoint = v8 and Vector2.new(0, 0.5) or Vector2.new(1, 0.5);
        u9.Container.Score.Position = v8 and UDim2.new(1, 0, 0.5, 0) or UDim2.new(0, 0, 0.5, 0);
        u9.Container.Score.AnchorPoint = v8 and Vector2.new(1, 0.5) or Vector2.new(0, 0.5);
        u9.Container.Teammates.Layout.HorizontalAlignment = v8 and Enum.HorizontalAlignment.Right or Enum.HorizontalAlignment.Left;
        u9.LayoutOrder = i;
        u9.Parent = v8 and u6.Teams.LeftFrame or u6.Teams.RightFrame;
        u6._team_slots[i] = u9;
        local Score = u9.Container.Score;
        local Layout = u9.Container.Teammates.Layout;

        local function update() -- Line: 68
            -- upvalues: u9 (copy), Layout (copy), Score (copy)
            u9.Size = UDim2.new(0, Layout.AbsoluteContentSize.X + Score.AbsoluteSize.X, 1, 0);
        end;

        Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(update);
        Score:GetPropertyChangedSignal("AbsoluteSize"):Connect(update);
        u9.Size = UDim2.new(0, Layout.AbsoluteContentSize.X + Score.AbsoluteSize.X, 1, 0);
        local _ = i;
    end;

    local _connections = u6._connections;
    local DataChangedSignal = u6.Teams.Scores.DuelInterface.ClientDuel:GetDataChangedSignal("Scores");
    table.insert(_connections, DataChangedSignal:Connect(function(p10) -- Line: 77
        -- upvalues: u6 (copy)
        u6:_UpdateScores();
    end));
    table.insert(u6._connections, u6.Teams.Scores.DuelInterface.ClientDuel.DuelerAdded:Connect(function(p11) -- Line: 81
        -- upvalues: u6 (copy)
        u6:_AddClientDueler(p11);
    end));

    if u6.Teams.Scores.DuelInterface.ClientDuel:Get("ArcadeMode") then
        table.insert(u6._connections, u6.Teams.Scores.DuelInterface.ClientDuel.DuelerRemoved:Connect(function(p12) -- Line: 86
            -- upvalues: u6 (copy)
            u6:_RemoveClientDueler(p12);
        end));
    end;

    for i in pairs(u6.Teams.Scores.DuelInterface:GetLoggedClientDuelers()) do
        u6:_AddClientDueler(i, true);
    end;

    u6:_UpdateScores();
end;

function u1.Destroy(p13) -- Line: 98
    p13:_Clear();
end;

function u1._UpdateScores(p14) -- Line: 106
    -- upvalues: DuelLibrary (copy)
    local v15 = p14.Teams.Scores.DuelInterface.ClientDuel:Get("Scores");

    for i, v in pairs(p14._team_slots) do
        v.Container.Score.Text = v15[DuelLibrary.Teams[i].TeamID];
    end;
end;

function u1._RemoveClientDueler(p16, p17) -- Line: 114
    local v18 = p16._dueler_slots[p17];

    if not v18 then
        return;
    end;

    for _, v in pairs(v18.Connections) do
        v:Disconnect();
    end;

    v18.TeammateSlot:Destroy();
    p16._dueler_slots[p17] = nil;
end;

function u1._AddClientDueler(u19, u20) -- Line: 129
    -- upvalues: TeammateSlot (copy), DuelLibrary (copy), DuelScoresChatBubbleContainer (copy)
    u19:_RemoveClientDueler(u20);
    local v21 = {};
    local u22 = TeammateSlot.new(u20.Player.UserId);
    u22.SlotFrame.Container.Background.Visible = false;

    local function update_details() -- Line: 137
        -- upvalues: u19 (copy), u20 (copy), u22 (copy)
        local v23 = u19.Teams.Scores.DuelInterface.ClientDuel:Get("Status");
        local v24 = u20:Get("TeamID");
        local v25 = u19.Teams.Scores.DuelInterface.ClientDuel.LocalDueler and v24 == u19.Teams.Scores.DuelInterface.ClientDuel.LocalDueler:Get("TeamID");
        local v26 = u20.ClientFighter:Get("Controls");
        local v27 = u20:GetHealth() / u20:GetMaxHealth();
        local v28 = not table.find(u19.Teams.Scores.DuelInterface.ClientDuel.Duelers, u20);
        local v29 = u19.Teams.Scores.DuelInterface.ClientDuel.LocalDueler and not v25;

        if v29 then
            if v23 == "RoundFinished" then
                v29 = false;
            else
                v29 = v23 ~= "GameOver";
            end;
        end;

        local v30;

        if u19.Teams.Scores.DuelInterface.ClientDuel.IsRanked then
            v30 = nil;
        else
            v30 = u20.Player:GetAttribute("Level");
        end;

        u22:SetDetails(v26, v27, v28, v29, nil, v30);
    end;

    local DataChangedSignal = u19.Teams.Scores.DuelInterface.ClientDuel:GetDataChangedSignal("Status");
    table.insert(v21, DataChangedSignal:Connect(update_details));
    local DataChangedSignal2 = u20.ClientFighter:GetDataChangedSignal("Controls");
    table.insert(v21, DataChangedSignal2:Connect(update_details));
    local AttributeChangedSignal = u20.Player:GetAttributeChangedSignal("Level");
    table.insert(v21, AttributeChangedSignal:Connect(update_details));
    table.insert(v21, u19.Teams.Scores.DuelInterface.ClientDuel.DuelerRemoved:Connect(update_details));
    local DataChangedSignal3 = u20:GetDataChangedSignal("TeamID");
    table.insert(v21, DataChangedSignal3:Connect(update_details));
    table.insert(v21, u20.HealthChanged:Connect(update_details));
    update_details();

    local function update_parent() -- Line: 159
        -- upvalues: u20 (copy), u22 (copy), u19 (copy), DuelLibrary (ref)
        local v31 = u20:Get("TeamID");
        local v32;

        if v31 then
            v32 = u19._team_slots[DuelLibrary.TeamsByID[v31].TeamIndex].Container.Teammates;
        else
            v32 = nil;
        end;

        u22.SlotFrame.Parent = v32;
    end;

    local DataChangedSignal4 = u20:GetDataChangedSignal("TeamID");
    table.insert(v21, DataChangedSignal4:Connect(update_parent));

    local function update_turn() -- Line: 166
        -- upvalues: u22 (copy), u20 (copy)
        u22:SetStaggeredSpawnsTurn(u20:GetStaggeredSpawnsTurn(), u20:Get("TeamID"));
    end;

    local DataChangedSignal5 = u19.Teams.Scores.DuelInterface.ClientDuel:GetDataChangedSignal("StaggeredSpawnsOrder");
    table.insert(v21, DataChangedSignal5:Connect(update_turn));
    local DataChangedSignal6 = u20:GetDataChangedSignal("TeamID");
    table.insert(v21, DataChangedSignal6:Connect(update_turn));
    u22:SetStaggeredSpawnsTurn(u20:GetStaggeredSpawnsTurn(), u20:Get("TeamID"));

    if u19.Teams.Scores.DuelInterface.ClientDuel.IsRanked and u20:CanShowRankToLocalPlayer() then
        u22:SetDisplayELO(u20.Player:GetAttribute("DisplayELO"));
    end;

    local v33 = DuelScoresChatBubbleContainer:Clone();
    v33.Parent = u22.SlotFrame;
    local v34 = u20:Get("TeamID");
    local v35;

    if v34 then
        v35 = u19._team_slots[DuelLibrary.TeamsByID[v34].TeamIndex].Container.Teammates;
    else
        v35 = nil;
    end;

    u22.SlotFrame.Parent = v35;
    u19._dueler_slots[u20] = {
        ClientDueler = u20,
        TeammateSlot = u22,
        ChatBubbleContainer = v33,
        Connections = v21
    };
end;

function u1._Clear(p36) -- Line: 191
    for _, v in pairs(p36._connections) do
        v:Disconnect();
    end;

    for _, v in pairs(p36._team_slots) do
        v:Destroy();
    end;

    for i in pairs(p36._dueler_slots) do
        p36:_RemoveClientDueler(i);
    end;

    p36._connections = {};
    p36._team_slots = {};
    p36._dueler_slots = {};
end;

function u1._Init(p37) -- Line: 209
end;

return u1;