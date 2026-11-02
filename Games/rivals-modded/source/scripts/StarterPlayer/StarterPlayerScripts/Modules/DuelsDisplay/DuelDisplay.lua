-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local DuelLibrary = require(ReplicatedStorage.Modules.DuelLibrary);
local Signal = require(ReplicatedStorage.Modules.Signal);
local SpectateController = require(Players.LocalPlayer.PlayerScripts.Controllers.SpectateController);
local TeammateSlot = require(Players.LocalPlayer.PlayerScripts.Modules.TeammateSlot);
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules.ButtonEffect);
local DuelsBoardTeamSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("DuelsBoardTeamSlot");
local DuelsBoardSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("DuelsBoardSlot");
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 16
    -- upvalues: u1 (copy), Signal (copy), DuelsBoardSlot (copy)
    local v3 = setmetatable({}, u1);
    v3.GameOver = Signal.new();
    v3.ClientDuel = p2;
    v3.Frame = DuelsBoardSlot:Clone();
    v3._destroyed = false;
    v3._connections = {};
    v3._num_teams = v3.ClientDuel:Get("NumTeams");
    v3._team_slots = {};
    v3._team_ids = {};
    v3._dueler_slots = {};
    v3:_Init();

    return v3;
end;

function u1.Destroy(p4) -- Line: 40
    p4._destroyed = true;

    for _, v in pairs(p4._connections) do
        v:Disconnect();
    end;

    p4.GameOver:Destroy();
    p4.Frame:Destroy();
end;

function u1._DuelerAdded(p5, u6) -- Line: 55
    -- upvalues: TeammateSlot (copy)
    if p5._destroyed then
        return;
    end;

    p5:_UpdateScores();
    local table_find_ret = table.find(p5._team_ids, u6:Get("TeamID"));
    local u7 = TeammateSlot.new(u6.Player.UserId, u6.ClientFighter:Get("Controls"), 1, false, false, u6.Player:GetAttribute("StatisticDuelsWinStreak"), u6.Player:GetAttribute("Level"));
    u7.SlotFrame.Container.Background.Visible = false;
    u7.SlotFrame.Parent = table_find_ret and p5.Frame.Teams[table_find_ret].Container or p5.Frame.Teams;
    p5._dueler_slots[u6] = u7;
    table.insert(p5._connections, u6.HealthChanged:Connect(function() -- Line: 68, Name: update_health
        -- upvalues: u7 (copy), u6 (copy)
        u7:SetHealthPercent(u6:GetHealth() / u6:GetMaxHealth());
    end));
    u7:SetHealthPercent(u6:GetHealth() / u6:GetMaxHealth());
end;

function u1._DuelerRemoved(p8, p9) -- Line: 76
    if not p8.ClientDuel:Get("ArcadeMode") then
        return;
    end;

    local v10 = p8._dueler_slots[p9];

    if not v10 then
        return;
    end;

    v10:Destroy();
    p8._dueler_slots[p9] = nil;
end;

function u1._UpdateScores(p11) -- Line: 91
    local v12 = p11.ClientDuel:Get("ScoresBehavior");
    local v13 = p11.ClientDuel:Get("Scores");

    for i, v in pairs(p11._team_ids) do
        p11.Frame.Teams[i].Container.Score.Visible = v12 == "Teams";
        p11.Frame.Teams[i].Container.Score.Text = v13[v] or "0";
    end;
end;

function u1._UpdateMap(p14) -- Line: 101
    -- upvalues: DuelLibrary (copy)
    local v15 = p14.ClientDuel.Map and p14.ClientDuel.Map.Model and p14.ClientDuel.Map.Model.Name;
    p14.Frame.Picture.Image = not v15 and "" or DuelLibrary.Maps[v15].Image;
    p14.Frame.NoPicture.Visible = v15 == nil;
end;

function u1._Setup(p16) -- Line: 108
    -- upvalues: DuelsBoardTeamSlot (copy)
    for i = 1, p16._num_teams do
        local v17 = DuelsBoardTeamSlot:Clone();
        v17.Container.Layout.HorizontalAlignment = p16._num_teams == 2 and i == 1 and Enum.HorizontalAlignment.Right or Enum.HorizontalAlignment.Left;
        v17.Container.Score.LayoutOrder = v17.Container.Layout.HorizontalAlignment == Enum.HorizontalAlignment.Right and 99999 or -99999;
        v17.Size = UDim2.new(0.9 / p16._num_teams, 0, 1, 0);
        v17.LayoutOrder = i * 2;
        v17.Name = i;
        v17.Parent = p16.Frame.Teams;
        p16._team_slots[i] = v17;
        table.insert(p16._team_ids, utf8.char(i));
        local _ = i;
    end;

    p16.Frame.Teams.Spectate.LayoutOrder = p16._num_teams == 2 and 3 or -1;

    for _, v in pairs(p16.ClientDuel.Duelers) do
        task.defer(p16._DuelerAdded, p16, v);
    end;
end;

function u1._Init(u18) -- Line: 128
    -- upvalues: SpectateController (copy), ButtonEffect (copy)
    u18.Frame.SpectateButton.MouseButton1Click:Connect(function() -- Line: 129
        -- upvalues: SpectateController (ref), u18 (copy)
        SpectateController:SpectateDuelRequest(u18.ClientDuel);
    end);
    table.insert(u18._connections, u18.ClientDuel.MapAdded:Connect(function() -- Line: 133
        -- upvalues: u18 (copy)
        u18:_UpdateMap();
    end));
    local _connections = u18._connections;
    local DataChangedSignal = u18.ClientDuel:GetDataChangedSignal("Scores");
    table.insert(_connections, DataChangedSignal:Connect(function() -- Line: 137
        -- upvalues: u18 (copy)
        u18:_UpdateScores();
    end));
    table.insert(u18._connections, u18.ClientDuel.DuelerAdded:Connect(function(p19) -- Line: 141
        -- upvalues: u18 (copy)
        u18:_DuelerAdded(p19);
    end));
    table.insert(u18._connections, u18.ClientDuel.DuelerRemoved:Connect(function(p20) -- Line: 145
        -- upvalues: u18 (copy)
        u18:_DuelerRemoved(p20);
    end));
    table.insert(u18._connections, u18.ClientDuel.DuelerRemoved:Connect(function(p21) -- Line: 149
        -- upvalues: u18 (copy)
        if u18._dueler_slots[p21] then
            u18._dueler_slots[p21]:SetDisconnected(true);
        end;
    end));
    local _connections2 = u18._connections;
    local DataChangedSignal2 = u18.ClientDuel:GetDataChangedSignal("Status");
    table.insert(_connections2, DataChangedSignal2:Connect(function() -- Line: 155
        -- upvalues: u18 (copy)
        if u18.ClientDuel:Get("Status") == "GameOver" then
            u18.GameOver:Fire();
        end;
    end));
    u18:_Setup();
    u18:_UpdateMap();
    u18:_UpdateScores();
    ButtonEffect:Add(u18.Frame.SpectateButton, nil, {
        TargetElement = u18.Frame.Teams.Spectate.Icon
    });
end;

return u1;