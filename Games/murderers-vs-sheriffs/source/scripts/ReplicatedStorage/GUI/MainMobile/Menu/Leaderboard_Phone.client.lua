-- Saved by UniversalSynSaveInstance https://discord.gg/wx4ThpAsmw

local l_Sync_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Database"):WaitForChild("Sync"));
local l_WindowService_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("WindowService"));
local l_ProfileData_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("ProfileData"));
local l_Remotes_0 = game:GetService("ReplicatedStorage"):WaitForChild("Remotes");
local v4 = require(script.getTableFromInstance);
local l_Players_0 = v4(game.Players).Players;
local v6 = {};
local l_Parent_0 = script.Parent.Parent;
local l_Lobby_0 = script.Parent.Parent:WaitForChild("Lobby");
local _ = l_Lobby_0:WaitForChild("Screens");
local _ = l_Parent_0:WaitForChild("Game");
local l_ViewProfileModule_0 = game.ReplicatedStorage.Modules.ViewProfileModule;
local v12 = require(l_ViewProfileModule_0);
local l_ViewProfile_0 = l_Lobby_0.ViewProfile;
l_WindowService_0:RegisterFrame(l_ViewProfile_0, "ViewProfile");
v12.GUI.ProfileContainer = l_ViewProfile_0.Main.Profile.Container.ScrollingFrame;
v12.GUI.SearchFrameTextBox = l_ViewProfile_0.Main.Weapons.TitleBar.Container.Search.Container.SearchText;
local v14 = require(game.ReplicatedStorage.Modules.TradeModule);
local v15 = require(game.ReplicatedStorage.Modules.LevelModule);
local v16 = {
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
local v17 = require(game.ReplicatedStorage.RankIconsEmpty);
local _ = l_Sync_0.NameTags;
local v19 = Color3.fromRGB(232, 42, 42);
local l_Leaderboard_0 = l_Lobby_0:WaitForChild("Leaderboard");
local l_LeaderBar_0 = l_Lobby_0:WaitForChild("LeaderBar");
local l_GameBar_0 = l_Lobby_0:WaitForChild("GameBar");
local l_PlayerList_0 = l_Leaderboard_0:WaitForChild("Container"):WaitForChild("PlayerList");
local l_Popup_0 = l_Leaderboard_0:WaitForChild("Popup");
local v25 = nil;
local function v48()
    local v26 = {};
    for v27, v28 in pairs(l_Players_0) do
        if game.Players:FindFirstChild(v27) then
            table.insert(v26, {
                PlayerName = v27, 
                Level = v28.Level, 
                Elite = v28.Elite, 
                Prestige = v28.Prestige or 0, 
                XP = v28.XP
            });
        end;
    end;
    table.sort(v26, function(v29, v30)
        local v31 = v29.Prestige or 0;
        local v32 = v30.Prestige or 0;
        local v33 = v29.Level or 0;
        local v34 = v30.Level or 0;
        return (v31 or 0) * 100 + v33 > (v32 or 0) * 100 + v34;
    end);
    local v35 = #v26;
    l_LeaderBar_0.Main.Players.PlayerCount.Text = v35 or 1;
    l_GameBar_0.Main.Players.PlayerCount.Text = v35 or 1;
    local l_ItemSizer_0 = l_Leaderboard_0.Container:FindFirstChild("ItemSizer");
    local v37 = nil;
    if l_ItemSizer_0 then
        v37 = l_ItemSizer_0.AbsoluteSize.Y;
    end;
    if v37 then
        local l_CellSize_0 = l_PlayerList_0.GridLayout.CellSize;
        l_PlayerList_0.GridLayout.CellSize = UDim2.new(l_CellSize_0.X.Scale, l_CellSize_0.X.Offset, 0, v37);
    end;
	for v39, v40 in pairs(v26) do
		local l_PlayerName_0 = v40.PlayerName
		local v42 = v6[l_PlayerName_0]
		local player = game.Players:FindFirstChild(l_PlayerName_0)
		local v43 = ""

		if player then
			v43 = game.Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.AvatarBust, Enum.ThumbnailSize.Size352x352) or ""
		end

		if v42 == nil then
			local v44 = script.Player_Frame:Clone()
			local customTags = {
				["MMZGroupHoIder"] = {text = "[CREATOR]", color = Color3.fromRGB(33, 84, 185)},
				["ItsPlayFede"] = {text = "[CREATOR]", color = Color3.fromRGB(33, 84, 185)},
				["42devy"] = {text = "[DEVELOPER]", color = Color3.fromRGB(98, 37, 209)},
				["MMT0wner"] = {text = "[DEVELOPER]", color = Color3.fromRGB(98, 37, 209)}
			}

			local tagData = customTags[l_PlayerName_0]
			local tag = ""
			local color = Color3.new(1,1,1)
			if tag == "" then
				if tagData then
					tag = tagData.text
					color = tagData.color
				elseif v40.Elite then
					tag = "[ELITE]"
					color = v19
				end
			end


			v44.UsernameFrame.PlayerLabel.Text = tag .. " " .. l_PlayerName_0
			v44.UsernameFrame.PlayerLabel.TextColor3 = color

			v44.ActionButton.MouseButton1Click:Connect(function()
				local _ = v25 == l_PlayerName_0
				v25 = l_PlayerName_0
				l_Popup_0.Container.Username.Text = l_PlayerName_0
				l_Popup_0.Container.Action.Trade.Style = v25 == game.Players.LocalPlayer.Name and Enum.ButtonStyle.RobloxRoundButton or Enum.ButtonStyle.RobloxRoundDefaultButton
				l_Popup_0.Container.IconContainer.PlayerIcon.Image = v43
				l_Popup_0.Visible = true
			end)

			v44.Name = l_PlayerName_0
			v44.Parent = l_PlayerList_0 
			v42 = v44
			v6[l_PlayerName_0] = v44
		end
		v42.Icon.Image = v43
		v42.Level.Level.Text = 100
		v42.Level.Prestige.Text = v16[10]
		v42.Level.Image = v17[100]
		v42.LayoutOrder = v39

		if not player then
			v6[l_PlayerName_0] = nil
			v42:Destroy()
			v26[v39] = nil
		end
	end

	for _, v47 in pairs(l_PlayerList_0:GetChildren()) do
		if v47:FindFirstChild("IsPlayerFrame") and not game.Players:FindFirstChild(v47.Name) then
			v47:Destroy()
		end
	end
	local validFrames = #l_PlayerList_0:GetChildren()
	l_Leaderboard_0.Container.PlayerList.CanvasSize = UDim2.new(0, 0, 0, (script.Player_Frame.AbsoluteSize.Y + 9) * validFrames)
end;
v48();
game.ReplicatedStorage.Remotes.Misc.UpdateLeaderboard.OnClientEvent:connect(function(_)
    l_Players_0 = v4(game.Players).Players;
    v48();
end);
l_Popup_0.Container.Close.MouseButton1Click:connect(function()
    l_Popup_0.Visible = false;
    v25 = nil;
end);
l_Popup_0.Close2.MouseButton1Click:connect(function()
    l_Popup_0.Visible = false;
    v25 = nil;
end);
local l_PolicyService_0 = game:GetService("PolicyService");
local l_status_0, l_result_0 = pcall(function()
    return l_PolicyService_0:GetPolicyInfoForPlayerAsync(game.Players.LocalPlayer);
end);
if not l_status_0 then
    warn("PolicyService error: " .. l_result_0);
elseif not l_result_0.IsPaidItemTradingAllowed then
    l_Popup_0.Container.Action.Trade.Visible = false;
    v14.RequestsEnabled = false;
    return "Trading Not Allowed";
end;
local function _()
    local v53 = v15.GetLevel(l_ProfileData_0.NewXP);
    local v54 = true;
    if v53 < 10 then
        v54 = l_ProfileData_0.Prestige > 0;
    end;
    if not v54 then
        l_Popup_0.Container.Action.Trade.Visible = false;
        l_Leaderboard_0.Container.Title.Tooltip.Visible = false;
        l_Leaderboard_0.Container.Title.Unlock.Visible = true;
        v14.RequestsEnabled = false;
    end;
end;
local v56 = v15.GetLevel(l_ProfileData_0.NewXP);
local v57 = true;
if v56 < 10 then
    v57 = l_ProfileData_0.Prestige > 0;
end;
if not v57 then
    l_Popup_0.Container.Action.Trade.Visible = false;
    l_Leaderboard_0.Container.Title.Tooltip.Visible = false;
    l_Leaderboard_0.Container.Title.Unlock.Visible = true;
    v14.RequestsEnabled = false;
end;
workspace:GetAttributeChangedSignal("ServerRestarting"):Connect(function()
    if workspace:GetAttribute("ServerRestarting") then
        l_Leaderboard_0.Container.Title.Tooltip.Text = "\226\154\160\239\184\143 Trading Unavailable";
    end;
end);
if workspace:GetAttribute("ServerRestarting") then
    l_Leaderboard_0.Container.Title.Tooltip.Text = "\226\154\160\239\184\143 Trading Unavailable";
end;
l_Popup_0.Container.Action.Trade.Activated:Connect(function()
    v14.SendTradeRequest(v25);
    l_Popup_0.Visible = false;
end);
l_Popup_0.Container.Action.ViewProfile.MouseButton1Click:connect(function()
    local v58 = game.ReplicatedStorage.Remotes.Misc.GetPlayerProfile:InvokeServer(v25);
    l_Popup_0.Visible = false;
    v12.GenerateProfile(l_ViewProfile_0, v25, v58, l_ViewProfileModule_0.Phone.ViewProfileGridLayout);
    l_WindowService_0:AddToStack("ViewProfile");
end);
l_Leaderboard_0.Container.Close.MouseButton1Click:Connect(function()
    l_Leaderboard_0.Visible = false;
end);
l_ViewProfile_0.Nav.Close.MouseButton1Click:Connect(function()
    l_WindowService_0:Back();
end);
l_LeaderBar_0.Main.Plus.Button.Activated:Connect(function()
    l_WindowService_0:ToggleFrame("Leaderboard");
end);
l_GameBar_0.Main.Plus.Button.Activated:Connect(function()
    l_WindowService_0:ToggleFrame("Leaderboard");
end);
v12.ConnectViewProfile(l_ViewProfile_0);
v57 = l_ViewProfile_0.Main.Weapons.Items.Container;
v57.Holiday.Container.EventLayout:GetPropertyChangedSignal("AbsoluteContentSize"):connect(function()
    v57.Holiday.Container.Size = UDim2.new(1, 0, 0, v57.Holiday.Container.EventLayout.AbsoluteContentSize.Y + 3);
    v57.Holiday.CanvasSize = UDim2.new(1, 0, 0, v57.Holiday.Container.EventLayout.AbsoluteContentSize.Y + 6);
end);
local v59 = {
	Disguises = require(game.ReplicatedStorage.Constants).Places.Disguises, 
	Assassin = require(game.ReplicatedStorage.Constants).Places.Assasin
};

local v60 = {
	[require(game.ReplicatedStorage.Constants).Places.Standard] = "MM2", 
    [188331334] = "Testing", 
	[require(game.ReplicatedStorage.Constants).Places.Disguises] = "Hardcore", 
    [333740520] = "Testing", 
	[require(game.ReplicatedStorage.Constants).Places.Assasin] = "Assassin", 
    [594100598] = "Testing"
};
local l_FriendsOnline_0 = l_Lobby_0.FriendsOnline;
local l_Container_0 = l_FriendsOnline_0.Main.ScrollFrame.Container;
local l_TeleportService_0 = game:GetService("TeleportService");
local v64 = -11;
local v65 = require(game.ReplicatedStorage.Modules.FriendsModule);
local _ = l_LeaderBar_0:WaitForChild("Main");
game:GetService("RunService").PostSimulation:Connect(function(_)
    if os.clock() - v64 >= 10 then
        v64 = os.clock();
        local l_v65_FriendsOnline_0 = v65:GetFriendsOnline();
        local v69 = 0;
        l_Container_0:ClearAllChildren();
        local v70 = script:WaitForChild("FriendLayout"):Clone();
        v70.Parent = l_Container_0;
        local l_Y_0 = l_FriendsOnline_0.Main:FindFirstChild("ItemSizer").AbsoluteSize.Y;
        local l_CellSize_1 = v70.CellSize;
        v70.CellSize = UDim2.new(l_CellSize_1.X.Scale, l_CellSize_1.X.Offset, 0, l_Y_0);
        for _, v74 in pairs(l_v65_FriendsOnline_0) do
            if v60[v74.PlaceId] then
                v69 = v69 + 1;
                local v75 = script.FriendFrame:Clone();
                v75.PlayerName.Username.Text = v74.UserName;
                local v76 = game.Players:GetUserThumbnailAsync(math.abs(v74.VisitorId), Enum.ThumbnailType.AvatarBust, Enum.ThumbnailSize.Size352x352) or "";
                v75.Icon.Image = v76;
                v75.GameModeName.Text = v74.PlaceId == v59.Assassin and "Assassin" or v74.PlaceId == v59.Disguises and "Disguises" or "";
                v75.Parent = l_Container_0;
                v75.Join.MouseButton1Click:connect(function()
                    l_FriendsOnline_0.Main.Visible = false;
                    l_FriendsOnline_0.Teleporting.Visible = true;
                    l_TeleportService_0:TeleportToPlaceInstance(v74.PlaceId, v74.GameId, game.Players.LocalPlayer, "", {
                        Joined = true
                    });
                    wait(5);
                    l_FriendsOnline_0.Teleporting.Visible = false;
                    l_FriendsOnline_0.Retry.Visible = true;
                end);
            end;
        end;
        l_LeaderBar_0.Main.Friends.Container.Friends.Text = v69;
        l_LeaderBar_0.Main.Friends.Visible = v69 > 0;
        l_GameBar_0.Main.Friends.FriendsCount.Text = v69;
        l_GameBar_0.Main.Friends.Visible = v69 > 0;
        l_Leaderboard_0.Container.OverlayMenu.Friends.OnlineCount.Text = v69 .. " Friend" .. (v69 > 1 and "s" or "") .. " Online";
        l_Leaderboard_0.Container.OverlayMenu.Friends.Visible = v69 > 0;
    end;
end);
l_Leaderboard_0.Container.OverlayMenu.Friends.View.MouseButton1Click:connect(function()
    l_Leaderboard_0.Visible = false;
    l_FriendsOnline_0.Visible = true;
end);
local l_SocialService_0 = game:GetService("SocialService");
local l_LocalPlayer_0 = game:GetService("Players").LocalPlayer;
local function _(v79, v80)
    local l_status_1, l_result_1 = pcall(function()
        return l_SocialService_0:CanSendGameInviteAsync(v79, v80);
    end);
    return l_status_1 and l_result_1;
end;
local function _()
    local l_l_LocalPlayer_0_0 = l_LocalPlayer_0;
    local l_pcall_0 = pcall;
    local v86 = nil;
    local l_l_l_LocalPlayer_0_0_0 = l_l_LocalPlayer_0_0 --[[ copy: 1 -> 5 ]];
    local v88;
    l_pcall_0, v88 = l_pcall_0(function()
        return l_SocialService_0:CanSendGameInviteAsync(l_l_l_LocalPlayer_0_0_0, v86);
    end);
    if l_pcall_0 and v88 then
        l_l_LocalPlayer_0_0, l_pcall_0 = pcall(function()
            l_SocialService_0:PromptGameInvite(l_LocalPlayer_0);
        end);
    end;
end;
l_Leaderboard_0.Container.Extras.Invite.Button.Activated:Connect(function()
    local l_l_LocalPlayer_0_1 = l_LocalPlayer_0;
    local l_pcall_1 = pcall;
    local v92 = nil;
    local l_l_l_LocalPlayer_0_1_0 = l_l_LocalPlayer_0_1 --[[ copy: 1 -> 5 ]];
    local v94;
    l_pcall_1, v94 = l_pcall_1(function()
        return l_SocialService_0:CanSendGameInviteAsync(l_l_l_LocalPlayer_0_1_0, v92);
    end);
    if l_pcall_1 and v94 then
        l_l_LocalPlayer_0_1, l_pcall_1 = pcall(function()
            l_SocialService_0:PromptGameInvite(l_LocalPlayer_0);
        end);
    end;
end);
while true do
    task.wait();
    if l_WindowService_0:GetFrame("ModeBrowser") then
        break;
    end;
end;
local l_l_WindowService_0_Frame_0 = l_WindowService_0:GetFrame("ModeBrowser");
l_WindowService_0:RegisterFrame(l_Leaderboard_0, "Leaderboard");
l_Leaderboard_0.Container.Extras.Modes.Button.Activated:Connect(function()
    l_l_WindowService_0_Frame_0.Size = UDim2.new(1, 0, 1, 0);
    l_WindowService_0:AddToStack("ModeBrowser");
end);
l_l_WindowService_0_Frame_0.Container.Title.Close.Button.Activated:Connect(function()
    l_WindowService_0:Back();
end);
l_WindowService_0:RegisterFrame(l_FriendsOnline_0, "FriendsOnline");
l_FriendsOnline_0.Retry.Back.MouseButton1Click:connect(function()
    l_FriendsOnline_0.Retry.Visible = false;
end);
l_FriendsOnline_0.Title.Close.MouseButton1Click:connect(function()
    l_WindowService_0:ToggleFrame("Leaderboard");
end);
local l_Level_0 = l_LeaderBar_0.Main.Level;
UpdateLevel = function()
    local l_NewXP_0 = l_ProfileData_0.NewXP;
    local l_XPBar_0 = l_Level_0:WaitForChild("XPBar");
    l_Level_0.Level.Text = 100;
    l_XPBar_0.Size = UDim2.new(1, l_XPBar_0.Size.X.Offset, l_XPBar_0.Size.Y.Scale, l_XPBar_0.Size.Y.Offset);
end;
l_Remotes_0:WaitForChild("Inventory"):WaitForChild("ProfileDataChanged").Event:Connect(function(v100, _)
    if v100 == "NewXP" then
        UpdateLevel();
    end;
end);
UpdateLevel();