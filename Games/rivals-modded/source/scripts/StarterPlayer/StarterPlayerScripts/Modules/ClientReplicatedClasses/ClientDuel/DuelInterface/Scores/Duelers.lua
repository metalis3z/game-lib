-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local DuelLibrary = require(ReplicatedStorage.Modules.DuelLibrary);
local ItemLibrary = require(ReplicatedStorage.Modules.ItemLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local TeammateSlot = require(Players.LocalPlayer.PlayerScripts.Modules.TeammateSlot);
local DuelScoresDuelerTeamBackground = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("DuelScoresDuelerTeamBackground");
local DuelScoresChatBubbleContainer = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("DuelScoresChatBubbleContainer");
local DuelScoresDuelerSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("DuelScoresDuelerSlot");
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 18
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.Scores = p2;
    v3.Frame = v3.Scores.Frame:WaitForChild("Duelers");
    v3.Container = v3.Frame:WaitForChild("Container");
    v3._connections = {};
    v3._dueler_slots = {};
    v3:_Init();

    return v3;
end;

function u1.GetChatBubbleContainer(p4, p5) -- Line: 37
    local v6 = nil;

    for i, v in pairs(p4._dueler_slots) do
        local v7 = i.Player == p5;

        if not v6 then
            if v7 then
                v6 = v.ChatBubbleContainer;
            else
                v6 = v7;
            end;
        end;

        v.TeammateSlot.SlotFrame.ZIndex = v7 and 2 or 1;
    end;

    return v6;
end;

function u1.Generate(u8) -- Line: 49
    u8:_Clear();

    if u8.Scores.DuelInterface.ClientDuel:Get("ScoresBehavior") ~= "Duelers" or u8.Scores.DuelInterface.ClientDuel:Get("VoteOptions") then
        return;
    end;

    local _connections = u8._connections;
    local DataChangedSignal = u8.Scores.DuelInterface.ClientDuel:GetDataChangedSignal("Scores");
    table.insert(_connections, DataChangedSignal:Connect(function(p9) -- Line: 56
        -- upvalues: u8 (copy)
        u8:_UpdateRanks();
    end));
    table.insert(u8._connections, u8.Scores.DuelInterface.ClientDuel.DuelerAdded:Connect(function(p10) -- Line: 60
        -- upvalues: u8 (copy)
        u8:_AddClientDueler(p10);
    end));

    if u8.Scores.DuelInterface.ClientDuel:Get("ArcadeMode") then
        table.insert(u8._connections, u8.Scores.DuelInterface.ClientDuel.DuelerRemoved:Connect(function(p11) -- Line: 65
            -- upvalues: u8 (copy)
            u8:_RemoveClientDueler(p11);
        end));
    end;

    for i in pairs(u8.Scores.DuelInterface:GetLoggedClientDuelers()) do
        u8:_AddClientDueler(i, true);
    end;

    u8:_UpdateRanks();
end;

function u1.Destroy(p12) -- Line: 77
    p12:_Clear();
end;

function u1._UpdateRanks(u13) -- Line: 85
    task.defer(function() -- Line: 87
        -- upvalues: u13 (copy)
        local LoggedClientDuelers = u13.Scores.DuelInterface:GetLoggedClientDuelers(true);

        for i, v in pairs(LoggedClientDuelers) do
            local v14 = u13._dueler_slots[v];

            if v14 then
                v14.TeammateSlot.SlotFrame.LayoutOrder = i;
                v14.TeammateSlot.SlotFrame.Visible = i <= 9 and true or v.IsLocalPlayer;
                v14.ScoreSlot.Rank.Text = "#" .. i;
            end;
        end;
    end);
end;

function u1._RemoveClientDueler(p15, p16, p17) -- Line: 104
    local v18 = p15._dueler_slots[p16];

    if not v18 then
        return;
    end;

    for _, v in pairs(v18.Connections) do
        v:Disconnect();
    end;

    v18.TeammateSlot:Destroy();
    p15._dueler_slots[p16] = nil;

    if not p17 then
        p15:_UpdateRanks();
    end;
end;

function u1._AddClientDueler(u19, u20, p21) -- Line: 123
    -- upvalues: TeammateSlot (copy), DuelScoresDuelerTeamBackground (copy), DuelLibrary (copy), DuelScoresDuelerSlot (copy), Utility (copy), ItemLibrary (copy), DuelScoresChatBubbleContainer (copy)
    u19:_RemoveClientDueler(u20, p21);
    local v22 = {};
    local u23 = TeammateSlot.new(u20.Player.UserId, nil, nil, nil, true);
    local u24 = DuelScoresDuelerTeamBackground:Clone();
    u24.Parent = u23.SlotFrame.Container.Background;
    local ImageTransparency = u23.SlotFrame.Container.Background.ImageTransparency;

    local function update_team() -- Line: 135
        -- upvalues: u20 (copy), u23 (copy), ImageTransparency (copy), u24 (copy), DuelLibrary (ref)
        local v25 = u20:Get("TeamID");
        u23.SlotFrame.Container.Background.ImageTransparency = v25 and 1 or ImageTransparency;
        u24.ImageColor3 = DuelLibrary:GetTeamColor(v25);
        u24.Visible = v25 ~= nil;
    end;

    local DataChangedSignal = u20:GetDataChangedSignal("TeamID");
    table.insert(v22, DataChangedSignal:Connect(update_team));
    local v26 = u20:Get("TeamID");
    u23.SlotFrame.Container.Background.ImageTransparency = v26 and 1 or ImageTransparency;
    u24.ImageColor3 = DuelLibrary:GetTeamColor(v26);
    u24.Visible = v26 ~= nil;
    local u27 = DuelScoresDuelerSlot:Clone();
    u27.Parent = u23.SlotFrame;

    local function update_score() -- Line: 149
        -- upvalues: Utility (ref), u19 (copy), u20 (copy), ItemLibrary (ref), u27 (copy)
        local v28 = Utility:PrettyNumber(u19.Scores.DuelInterface.ClientDuel:Get("Scores")[u20:Get("DuelerID")]);
        local _ = u20 and (u20.ClientFighter and (u20.ClientFighter.Items[1] and ItemLibrary.ViewModels[u20.ClientFighter.Items[1].Name].EliminationFeedImage));
        u27.Score.Text = v28;
        u27.Weapon.Image = "";
    end;

    local DataChangedSignal2 = u19.Scores.DuelInterface.ClientDuel:GetDataChangedSignal("IsGunGame");
    table.insert(v22, DataChangedSignal2:Connect(update_score));
    local DataChangedSignal3 = u19.Scores.DuelInterface.ClientDuel:GetDataChangedSignal("Scores");
    table.insert(v22, DataChangedSignal3:Connect(update_score));
    update_score();
    local v29 = DuelScoresChatBubbleContainer:Clone();
    v29.Position = UDim2.new(0.5, 0, 1.375, 0);
    v29.Parent = u23.SlotFrame;
    u23.SlotFrame.Parent = u19.Container;
    u19._dueler_slots[u20] = {
        ClientDueler = u20,
        TeammateSlot = u23,
        ScoreSlot = u27,
        ChatBubbleContainer = v29,
        Connections = v22
    };

    if not p21 then
        u19:_UpdateRanks();
    end;
end;

function u1._Clear(p30) -- Line: 181
    for _, v in pairs(p30._connections) do
        v:Disconnect();
    end;

    for i in pairs(p30._dueler_slots) do
        p30:_RemoveClientDueler(i);
    end;

    p30._connections = {};
    p30._dueler_slots = {};
end;

function u1._Init(p31) -- Line: 194
end;

return u1;