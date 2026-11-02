-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local SeasonLibrary = require(ReplicatedStorage.Modules.SeasonLibrary);
local DuelLibrary = require(ReplicatedStorage.Modules.DuelLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local ComplianceController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ComplianceController"));
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"));
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local RankIcon = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("RankIcon"));
local Page = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("Page"));
local DuelHistoryRageQuitSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("DuelHistoryRageQuitSlot");
local DuelHistoryHeadshotSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("DuelHistoryHeadshotSlot");
local DuelHistoryDuelerSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("DuelHistoryDuelerSlot");
local DuelHistoryEmptySlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("DuelHistoryEmptySlot");
local DuelHistorySlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("DuelHistorySlot");
local u1 = setmetatable({}, Page);
u1.__index = u1;

function u1._new() -- Line: 23
    -- upvalues: Page (copy), u1 (copy)
    local v2 = Page.new(script.Name);
    local v3 = setmetatable(v2, u1);
    v3.CloseButton = v3.PageFrame:WaitForChild("Close");
    v3.List = v3.PageFrame:WaitForChild("List");
    v3.Container = v3.List:WaitForChild("Container");
    v3.Layout = v3.Container:WaitForChild("Layout");
    v3._duel_history_slots = {};
    v3._generate_hash = 0;
    v3:_Init();

    return v3;
end;

function u1.Open(p4, ...) -- Line: 43
    -- upvalues: Page (copy)
    Page.Open(p4, ...);
    task.spawn(p4._Generate, p4);
end;

function u1._SetupELOEventLog(p5, p6, p7) -- Line: 52
    -- upvalues: RankIcon (copy)
    p6.Visible = p7;

    if not p7 then
        return;
    end;

    local v8 = RankIcon.new(p7.CurrentELO, nil, p7.CurrentLeaderboardRanking or (1 / 0));
    v8:SetLabelFromELOEvent(p7.ELOIncrement, p7.CurrentELO, p7.DuelsPlayed);
    v8:SetParent(p6);
end;

function u1._Generate(p9) -- Line: 64
    -- upvalues: PlayerDataController (copy), DuelHistoryRageQuitSlot (copy), Players (copy), DuelHistorySlot (copy), DuelLibrary (copy), SeasonLibrary (copy), DuelHistoryHeadshotSlot (copy), CONSTANTS (copy), DuelHistoryDuelerSlot (copy), Utility (copy), RankIcon (copy), ButtonEffect (copy), ComplianceController (copy), DuelHistoryEmptySlot (copy)
    for _, v in pairs(p9._duel_history_slots) do
        v:Destroy();
    end;

    p9._duel_history_slots = {};
    p9._generate_hash = p9._generate_hash + 1;
    local _generate_hash = p9._generate_hash;
    local v10 = {};

    for _, v in pairs(PlayerDataController:Get("LoggedELOEvents")) do
        if v.LogID then
            v10[v.LogID] = v;
        end;
    end;

    for i, v in pairs(PlayerDataController:Get("DuelHistory")) do
        if _generate_hash ~= p9._generate_hash then
            return;
        end;

        local v11 = v10[v.LogID];

        if v.IsRageQuit then
            local v12 = DuelHistoryRageQuitSlot:Clone();
            v12.LayoutOrder = i;
            v12.Parent = p9.Container;
            table.insert(p9._duel_history_slots, v12);
            p9:_SetupELOEventLog(v12.RankContainer, v11);
            wait(0.03);
        else
            local u13 = v;
            local v14 = i;
            local v15 = false;

            for _, v2 in pairs(v.Duelers) do
                if v2.UserID == Players.LocalPlayer.UserId then
                    v15 = true;
                    break;
                end;
            end;

            if v15 then
                local u16 = DuelHistorySlot:Clone();
                u16.LayoutOrder = v14;
                u16.Map.Image = u13.Map and DuelLibrary.Maps[u13.Map] and (DuelLibrary.Maps[u13.Map].Image or "") or "";
                u16.Container.QueueName.Text = u13.QueueName and DuelLibrary.MatchmakingQueues[u13.QueueName] and DuelLibrary.MatchmakingQueues[u13.QueueName].DisplayName or (u13.QueueName or "");
                u16.Container.Score.Text = "";
                u16.Container.EDATitle.Visible = false;
                u16.Container.EDA.Visible = false;
                p9:_SetupELOEventLog(u16.Container.RankContainer, v11);

                for i2 = 1, u13.NumTeams do
                    local Score = u16.Container.Score;
                    Score.Text = Score.Text .. u13.Scores[i2] .. (i2 == u13.NumTeams and "" or " • ");
                    local _ = i2;
                end;

                local v17 = SeasonLibrary:IsRankedQueue(u13.QueueName);
                local u18 = {};

                for i2, v2 in pairs(u13.Duelers) do
                    local TeamColor = DuelLibrary:GetTeamColor(v2.TeamIndex and DuelLibrary.Teams[v2.TeamIndex] and DuelLibrary.Teams[v2.TeamIndex].TeamID);

                    if v2.UserID == Players.LocalPlayer.UserId then
                        local v19 = u13.WinningTeamIndex and u13.WinningTeamIndex == v2.TeamIndex;
                        u16.Container.Background.ImageColor3 = v19 and Color3.fromRGB(100, 255, 50) or Color3.fromRGB(255, 50, 50);
                        u16.Container.Title.Text = v19 and "VICTORY" or "DEFEAT";
                        u16.Container.EDA.Text = (v2.Eliminations or "?") .. " • " .. (v2.Deaths or "?") .. " • " .. (v2.Assists or "?");
                        u16.Container.EDA.Visible = not u16.Container.RankContainer.Visible;
                        u16.Container.EDATitle.Visible = u16.Container.EDA.Visible;
                    end;

                    local v20 = DuelHistoryHeadshotSlot:Clone();
                    v20.Picture.Image = not v2.UserID and "rbxassetid://18623501726" or string.format(CONSTANTS.HEADSHOT_IMAGE, v2.UserID);
                    v20.Picture.ImageColor3 = not v2.UserID and Color3.fromRGB(0, 0, 0) or v20.Picture.ImageColor3;
                    v20.Picture.ImageTransparency = not v2.UserID and 0.5 or v20.Picture.ImageTransparency;
                    v20.Picture.Size = not v2.UserID and UDim2.new(0.75, 0, 0.75, 0) or v20.Picture.Size;
                    v20.Background.BackgroundColor3 = TeamColor;
                    v20.LayoutOrder = v2.TeamIndex * 1000 + i2;
                    v20.Parent = u16.Container.Headshots;
                    local v21 = DuelHistoryDuelerSlot:Clone();
                    v21.Player.Image = not v2.UserID and "rbxassetid://18623501726" or string.format(CONSTANTS.HEADSHOT_IMAGE, v2.UserID);
                    v21.DisplayName.Text = "• • •";
                    v21.Username.Text = "@• • •";
                    v21.Damage.Text = v2.Damage and (Utility:PrettyNumber((math.floor(v2.Damage + 0.5))) or "") or "";
                    v21.Eliminations.Text = v2.Eliminations or "";
                    v21.Deaths.Text = v2.Deaths or "";
                    v21.Assists.Text = v2.Assists or "";
                    v21.MVPText.Visible = v2.IsMVP;
                    v21.MVPIcon.Visible = v2.IsMVP;
                    v21.BackgroundColor3 = TeamColor;
                    v21.LayoutOrder = i2;
                    v21.Parent = u16.Container.Duelers;

                    if v2.UserID then
                        u18[tostring(v2.UserID)] = v21;
                    end;

                    if v17 then
                        RankIcon.new(v2.DisplayELO, nil, v2.DisplayELOLeaderboardRanking or (1 / 0)):SetParent(v21.Rank);
                    end;
                end;

                u16.Parent = p9.Container;
                table.insert(p9._duel_history_slots, u16);
                local u22 = ButtonEffect:Add(u16, nil, {
                    HoverRatio = 1.025,
                    ReleaseRatio = 1.025
                });
                local u23 = false;
                local u24 = false;
                u16.MouseButton1Click:Connect(function() -- Line: 183
                    -- upvalues: u24 (ref), u16 (copy), u22 (copy), u23 (ref), u13 (copy), ComplianceController (ref), u18 (copy)
                    u24 = not u24;
                    local v25 = u24 and UDim2.new(1, 0, (#u16.Container.Duelers:GetChildren() - 3) * 0.07500000000000001 + 0.2475, 0) or UDim2.new(1, 0, 0.2, 0);
                    u22.UpdateOriginalSize(v25);
                    u16.Size = v25;
                    u16.Container.Duelers.Visible = u24;

                    if u23 then
                        return;
                    end;

                    u23 = true;
                    local v26 = {};

                    for _, v2 in pairs(u13.Duelers) do
                        if v2.UserID then
                            table.insert(v26, v2.UserID);
                        end;
                    end;

                    local UserInfos = ComplianceController:GetUserInfos(v26);

                    for i2, v2 in pairs(u18) do
                        local v27 = UserInfos[i2];

                        if v27 then
                            v2.Username.Text = v27.Username == v27.DisplayName and "" or "@" .. v27.Username;
                            v2.DisplayName.Text = v27.DisplayName;
                            v2.DisplayName.Position = v2.Username.Text == "" and UDim2.new(0.1, 0, 0.5, 0) or UDim2.new(0.1, 0, 0.35, 0);
                        end;
                    end;
                end);
                wait(0.03);
            end;
        end;
    end;

    for i = #p9._duel_history_slots + 1, 6 do
        if _generate_hash ~= p9._generate_hash then
            return;
        end;

        local v28 = DuelHistoryEmptySlot:Clone();
        v28.LayoutOrder = 99999;
        v28.Parent = p9.Container;
        table.insert(p9._duel_history_slots, v28);
        wait(0.03);
        local _ = i;
    end;
end;

function u1._Init(u29) -- Line: 238
    -- upvalues: ButtonEffect (copy)
    u29.CloseButton.MouseButton1Click:Connect(function() -- Line: 239
        -- upvalues: u29 (copy)
        u29:CloseRequest();
    end);
    u29.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 243
        -- upvalues: u29 (copy)
        u29.List.CanvasSize = UDim2.new(0, 0, 0, u29.Layout.AbsoluteContentSize.Y);
    end);
    ButtonEffect:Add(u29.CloseButton);
end;

return u1._new();