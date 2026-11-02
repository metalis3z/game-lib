-- Saved by UniversalSynSaveInstance https://discord.gg/wx4ThpAsmw

local l_Parent_0 = script.Parent.Parent;
local _ = game.Players.LocalPlayer;
local l_ProfileData_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("ProfileData"));
local l_Remotes_0 = game:GetService("ReplicatedStorage"):WaitForChild("Remotes");
local v4 = require(game.ReplicatedStorage.RankIconsEmpty);
local l_Leaderboard_0 = l_Parent_0.Leaderboard;
local l_List_0 = l_Parent_0.Leaderboard.List;
local l_Trade_0 = game.ReplicatedStorage.Trade;
local v8 = require(game.ReplicatedStorage.Modules.LevelModule);
local v9 = {
    [0] = "", 
    [1] = "I", 
    [2] = "II", 
    [3] = "III", 
    [4] = "IV", 
    [5] = "V", 
    [6] = "VI", 
    [7] = "VII", 
    [8] = "VIII", 
    [9] = "IX", 
    [10] = "X"
};
local l_ContextActionService_0 = game:GetService("ContextActionService");
local _ = script.Parent.Parent;
local _ = function(v12, v13, v14)
    l_ContextActionService_0:BindAction(v12, function(_, v16)
        if v16 == Enum.UserInputState.Begin and not _G.PauseBinds then
            v14();
        end;
    end, false, v13);
end;
local _ = function(v18, _, _)
    l_ContextActionService_0:UnbindAction(v18);
end;
local v22 = {};
local function v26(v23)
    for _, v25 in pairs(v22) do
        game:GetService("GuiService"):RemoveSelectionGroup(v25);
    end;
    if v23 then
        game:GetService("GuiService"):AddSelectionParent(v23.Name, v23);
        table.insert(v22, v23.Name);
    end;
end;
local l_GetLevel_0 = v8.GetLevel;
UpdateLevel = function()
    local l_NewXP_0 = l_ProfileData_0.NewXP;
    local l_XPBar_0 = l_List_0.Parent.XP.XPBar;
    l_XPBar_0.Parent.Level.Text = "Level " .. l_GetLevel_0(l_NewXP_0);
    local v30 = v8.GetProgressToNextLevel(l_NewXP_0);
    l_XPBar_0.Size = UDim2.new(v30, l_XPBar_0.Size.X.Offset, l_XPBar_0.Size.Y.Scale, l_XPBar_0.Size.Y.Offset);
end;
UpdateLevel();
local v31 = {};
local function v34()
    for _, v33 in pairs(l_List_0:GetChildren()) do
        if v33.Container.PlayerName.Text == game.Players.LocalPlayer.Name then
            return v33;
        end;
    end;
end;
local l_Sync_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Database"):WaitForChild("Sync"));
UpdateLeaderboard = function()
    local l_NameTags_0 = l_Sync_0.NameTags;
    local v37 = {};
    for _, v39 in pairs(game.Players:GetPlayers()) do
        if not v31[v39.Name] then
            local v40 = 0;
            local v41 = 0;
            local v42 = false;
            local v43, v44, v45 = game.ReplicatedStorage.Remotes.Extras.GetPlayerLevel:InvokeServer(v39);
            v40 = v43;
            v41 = v44;
            v42 = v45;
            v31[v39.Name] = {};
            v31[v39.Name].Level = v40;
            v31[v39.Name].Prestige = v41 or 0;
            v31[v39.Name].Elite = v42;
        end;
        table.insert(v37, {
            Player = v39, 
            LD = v31[v39.Name]
        });
    end;
    table.sort(v37, function(v46, v47)
        if v46.Elite and not v47.Elite then
            return true;
        elseif v47.Elite and not v46.Elite then
            return false;
        else
            return v46.LD.Prestige * 100 + v46.LD.Level > v47.LD.Prestige * 100 + v47.LD.Level;
        end;
    end);
    local v48 = false;
    if game:GetService("GuiService").SelectedObject and game:GetService("GuiService").SelectedObject.Parent == l_List_0 then
        v48 = game:GetService("GuiService").SelectedObject.Name;
    end;
    l_List_0:ClearAllChildren();
    for v49, v50 in pairs(v37) do
        local l_Player_0 = v50.Player;
        if l_Player_0 ~= nil then
            local v52 = script:WaitForChild("Player"):Clone();
            v52.Name = "Player" .. v49;
            v52.Position = UDim2.new(0, 0, (v49 - 1) * 0.05, 0);
            local v53 = v31[l_Player_0.Name];
            v52.Container.RankIcon.Image = v4[100];
            v52.Container.Prestige.Text = v9[10];
            v52.Container.RankIcon.Level.Text = 100;
            local v54 = "";
            if v53.Elite then
                v52.Container.PlayerName.TextColor3 = Color3.new(0.9098039215686274, 0.16470588235294117, 0.16470588235294117);
                v54 = "[ELITE] ";
            end;
            local v55 = Instance.new("ObjectValue", v52);
            v55.Name = "PlayerObj";
            v55.Value = l_Player_0;
            v52.Container.PlayerName.Text = v54 .. l_Player_0.Name;
            local v56 = nil;
            do
                local l_v56_0 = v56;
                if l_Player_0 ~= game.Players.LocalPlayer then
                    v52.Container.Button.SelectionGained:connect(function()
                        if l_Parent_0.Leaderboard.Trade.Request.Visible then
                            return;
                        else
                            v52.Container.Response.Visible = true;
                            l_v56_0 = game:GetService("UserInputService").InputBegan:connect(function(v58)
                                if v58.KeyCode == Enum.KeyCode.DPadLeft and not l_Parent_0.Chat.Control.Visible then
                                    local v59 = l_Trade_0.SendRequest:InvokeServer(l_Player_0);
                                    print("IsBusy", v59);
                                    if not v59 then
                                        _G.ShowRequest(l_Player_0.Name, false);
                                        v52.Container.Response.Visible = false;
                                        return;
                                    end;
                                elseif v58.KeyCode == Enum.KeyCode.DPadRight and not l_Parent_0.Chat.Control.Visible then
                                    _G.Examine(game.ReplicatedStorage.Remotes.Extras.GetFullInventory:InvokeServer(l_Player_0), l_Player_0.Name);
                                end;
                            end);
                            return;
                        end;
                    end);
                    v52.Container.Button.SelectionLost:connect(function()
                        v52.Container.Response.Visible = false;
                        if l_v56_0 then
                            l_v56_0:disconnect();
                        end;
                    end);
                    v52.Container.Response.Changed:connect(function()
                        if v52.Container.Response.Visible == false and l_v56_0 then
                            l_v56_0:disconnect();
                        end;
                    end);
                end;
                local v60 = l_NameTags_0[tostring(l_Player_0.userId)];
                if v60 then
                    v52.Container.PlayerName.TextColor3 = v60;
                end;
                v52.Parent = l_List_0;
            end;
        end;
    end;
    if v48 then
        v26(l_Leaderboard_0);
        game:GetService("GuiService").SelectedObject = l_List_0:FindFirstChild(v48) or v34() and v34().Container.Button or l_List_0.Player1.Container.Button;
    end;
    wait(2);
end;
UpdateLeaderboard();
local v61 = "PlayerList";
local l_ButtonSelect_0 = Enum.KeyCode.ButtonSelect;
local function v67()
    if v61 == "PlayerList" then
        v61 = "Trade";
        l_Leaderboard_0.Trade.Visible = true;
        l_Leaderboard_0.Title.Title.Text = "Trading";
        l_List_0.Position = UDim2.new(1, -5, 0.15, 20);
        v26(l_Leaderboard_0);
        game:GetService("GuiService").SelectedObject = v34() and v34().Container.Button or l_List_0.Player1.Container.Button;
        local l_ButtonB_0 = Enum.KeyCode.ButtonB;
        local function v64()
            l_ContextActionService_0:UnbindAction("CloseLeaderTrade");
            v61 = "PlayerList";
            l_Leaderboard_0.Trade.Visible = false;
            l_List_0.Visible = true;
            l_List_0.Position = UDim2.new(1, -5, 0.1, 10);
            v26(nil);
            game:GetService("GuiService").SelectedObject = nil;
        end;
        l_ContextActionService_0:BindAction("CloseLeaderTrade", function(_, v66)
            if v66 == Enum.UserInputState.Begin and not _G.PauseBinds then
                v64();
            end;
        end, false, l_ButtonB_0);
        return;
    elseif v61 == "Trade" then
        l_ContextActionService_0:UnbindAction("CloseLeaderTrade");
        v61 = "Closed";
        v26(nil);
        game:GetService("GuiService").SelectedObject = nil;
        l_List_0.Visible = false;
        l_Leaderboard_0.Trade.Visible = false;
        l_Leaderboard_0.Title.Title.Text = "Player List";
        return;
    else
        if v61 == "Closed" then
            v61 = "PlayerList";
            l_List_0.Visible = true;
            l_List_0.Position = UDim2.new(1, -5, 0.1, 10);
        end;
        return;
    end;
end;
l_ContextActionService_0:BindAction("ShowLeaderboard", function(_, v69)
    if v69 == Enum.UserInputState.Begin and not _G.PauseBinds then
        v67();
    end;
end, false, l_ButtonSelect_0);
l_Remotes_0:WaitForChild("Inventory"):WaitForChild("ProfileDataChanged").Event:Connect(function(v70, _)
    if v70 == "NewXP" then
        UpdateLevel();
    end;
end);