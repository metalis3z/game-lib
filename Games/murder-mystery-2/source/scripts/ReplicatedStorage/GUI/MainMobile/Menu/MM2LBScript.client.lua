-- Decompiled with the Synapse X Luau decompiler.

local l__Lobby__1 = script.Parent.Parent.Lobby;
local l__Screens__2 = l__Lobby__1.Screens;
local l__Game__3 = script.Parent.Parent.Game;
local l__ViewProfileModule__4 = game.ReplicatedStorage.Modules.ViewProfileModule;
local v5 = require(l__ViewProfileModule__4);
local l__ViewProfile__6 = l__Lobby__1.ViewProfile;
v5.GUI.ProfileContainer = l__ViewProfile__6.Main.Profile.Container.ScrollingFrame;
v5.GUI.SearchFrameTextBox = l__ViewProfile__6.Main.Weapons.TitleBar.Container.Search.Container.SearchText;
local v7 = require(game.ReplicatedStorage.Modules.TradeModule);
local v8 = game.ReplicatedStorage.GetSyncData:InvokeServer("NameTags");
local l__Leaderboard__9 = l__Lobby__1.Leaderboard;
local u1 = game.ReplicatedStorage.Remotes.Inventory.GetLeaderboardData:InvokeServer() or {};
local l__LeaderBar__2 = l__Lobby__1.LeaderBar;
local l__GameBar__3 = l__Lobby__1.GameBar;
local l__PlayerList__4 = l__Leaderboard__9.Container.PlayerList;
local u5 = {};
local u6 = Color3.fromRGB(232, 42, 42);
local u7 = nil;
local l__Popup__8 = l__Leaderboard__9.Popup;
local u9 = require(game.ReplicatedStorage.Modules.LevelModule);
local u10 = {
	[0] = "",
	"I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X"
};
local u11 = require(game.ReplicatedStorage.RankIconsEmpty);
local function v10()
	table.sort(u1, function(p1, p2)
		return (p2.Prestige and 0) * 100 + p2.Level < (p1.Prestige and 0) * 100 + p1.Level;
	end);
	local v11 = #u1;
	l__LeaderBar__2.Main.Players.PlayerCount.Text = v11 and 1;
	l__GameBar__3.Main.Players.PlayerCount.Text = v11 and 1;
	local l__ItemSizer__12 = l__Leaderboard__9.Container:FindFirstChild("ItemSizer");
	local v13 = nil;
	if l__ItemSizer__12 then
		v13 = l__ItemSizer__12.AbsoluteSize.Y;
	end;
	if v13 then
		local l__CellSize__14 = l__PlayerList__4.GridLayout.CellSize;
		l__PlayerList__4.GridLayout.CellSize = UDim2.new(l__CellSize__14.X.Scale, l__CellSize__14.X.Offset, 0, v13);
	end;
	local v15, v16, v17 = pairs(u1);
	while true do
		local v18, v19 = v15(v16, v17);
		if not v18 then
			break;
		end;
		local l__PlayerName__20 = v19.PlayerName;
		local v21 = u5[l__PlayerName__20];
		local v22 = game.Players:GetUserThumbnailAsync(math.abs(game.Players[l__PlayerName__20].userId), Enum.ThumbnailType.AvatarBust, Enum.ThumbnailSize.Size352x352) and "";
		if v21 == nil then
			local v23 = script.Player_Frame:Clone();
			if v19.Elite == true then
				local v24 = "[ELITE] ";
			else
				v24 = "";
			end;
			v23.UsernameFrame.PlayerLabel.Text = v24 .. l__PlayerName__20;
			v23.UsernameFrame.PlayerLabel.TextColor3 = v19.Elite == true and u6 or Color3.new(1, 1, 1);
			v23.ActionButton.MouseButton1Click:connect(function()
				if u7 ~= l__PlayerName__20 then

				end;
				u7 = l__PlayerName__20;
				l__Popup__8.Container.Username.Text = l__PlayerName__20;
				l__Popup__8.Container.Action.Trade.Style = u7 == game.Players.LocalPlayer.Name and Enum.ButtonStyle.RobloxRoundButton or Enum.ButtonStyle.RobloxRoundDefaultButton;
				l__Popup__8.Container.IconContainer.PlayerIcon.Image = v22;
				l__Popup__8.Visible = true;
			end);
			v23.Name = l__PlayerName__20;
			v23.Parent = l__PlayerList__4;
			v21 = v23;
			u5[l__PlayerName__20] = v23;
		end;
		v21.Icon.Image = v22;
		v21.Level.Level.Text = u9.GetLevel(v19.XP);
		v21.Level.Prestige.Text = u10[v19.Prestige];
		v21.Level.Image = u11[v19.Level];
		v21.LayoutOrder = v18;
		if game.Players:FindFirstChild(l__PlayerName__20) == nil then
			u5[l__PlayerName__20] = nil;
			v21:Destroy();
			u1[v18] = nil;
		end;
		l__Leaderboard__9.Container.PlayerList.CanvasSize = UDim2.new(0, 0, 0, (v21.AbsoluteSize.Y + 9) * #u1);	
	end;
	for v25, v26 in pairs(l__PlayerList__4:GetChildren()) do
		if v26:FindFirstChild("IsPlayerFrame") and game.Players:FindFirstChild(v26.Name) == nil then
			v26:Destroy();
		end;
	end;
end;
v10();
game.ReplicatedStorage.Remotes.Misc.UpdateLeaderboard.OnClientEvent:connect(function(p3)
	u1 = p3;
	v10();
end);
l__Popup__8.Container.Close.MouseButton1Click:connect(function()
	l__Popup__8.Visible = false;
	u7 = nil;
end);
l__Popup__8.Close2.MouseButton1Click:connect(function()
	l__Popup__8.Visible = false;
	u7 = nil;
end);
if game.GameId ~= 119460199 then
	l__Popup__8.Container.Action.Trade.MouseButton1Click:connect(function()
		v7.SendTradeRequest(u7);
		l__Popup__8.Visible = false;
	end);
else
	l__Popup__8.Container.Action.Trade.Visible = false;
end;
l__Popup__8.Container.Action.ViewProfile.MouseButton1Click:connect(function()
	l__Popup__8.Visible = false;
	l__Leaderboard__9.Visible = false;
	v5.GenerateProfile(l__ViewProfile__6, u7, game.ReplicatedStorage.Remotes.Misc.GetPlayerProfile:InvokeServer(u7), l__ViewProfileModule__4.Phone.ViewProfileGridLayout);
	l__ViewProfile__6.Visible = true;
end);
l__Leaderboard__9.Container.Close.MouseButton1Click:connect(function()
	l__Leaderboard__9.Visible = false;
end);
l__ViewProfile__6.Nav.Close.MouseButton1Click:connect(function()
	l__ViewProfile__6.Visible = false;
end);
l__LeaderBar__2.Main.Plus.Button.MouseButton1Click:connect(function()
	l__Leaderboard__9.Visible = true;
end);
l__GameBar__3.Main.Plus.Button.MouseButton1Click:connect(function()
	l__Leaderboard__9.Visible = true;
end);
v5.ConnectViewProfile(l__ViewProfile__6);
local l__FriendsOnline__27 = l__Lobby__1.FriendsOnline;
local u12 = -11;
local l__Container__13 = l__FriendsOnline__27.Main.ScrollFrame.Container;
local u14 = {
	[142823291] = "MM2", 
	[188331334] = "Testing", 
	[335132309] = "Hardcore", 
	[333740520] = "Testing", 
	[636649648] = "Assassin", 
	[594100598] = "Testing"
};
local l__TeleportService__15 = game:GetService("TeleportService");
game:GetService("RunService"):BindToRenderStep("FriendsOnline", 1000, function()
	if time() - u12 >= 10 then
		u12 = time();
		if game.Players.LocalPlayer.userId > 0 then
			local v28 = game.Players.LocalPlayer:GetFriendsOnline() or {};
		else
			v28 = {};
		end;
		l__Container__13:ClearAllChildren();
		local v29 = script.FriendLayout:Clone();
		v29.Parent = l__Container__13;
		local l__CellSize__30 = v29.CellSize;
		v29.CellSize = UDim2.new(l__CellSize__30.X.Scale, l__CellSize__30.X.Offset, 0, l__FriendsOnline__27.Main:FindFirstChild("ItemSizer").AbsoluteSize.Y);
		for v31, v32 in pairs(v28) do
			if u14[v32.PlaceId] then
				local v33 = script.FriendFrame:Clone();
				v33.PlayerName.Username.Text = v32.UserName;
				v33.Icon.Image = game.Players:GetUserThumbnailAsync(math.abs(v32.VisitorId), Enum.ThumbnailType.AvatarBust, Enum.ThumbnailSize.Size352x352) and "";
				local v34 = v33.GameMode:FindFirstChild(u14[v32.PlaceId]);
				if v34 then
					v34.Visible = true;
				end;
				v33.Parent = l__Container__13;
				v33.Join.MouseButton1Click:connect(function()
					l__FriendsOnline__27.Main.Visible = false;
					l__FriendsOnline__27.Teleporting.Visible = true;
					l__TeleportService__15:TeleportToPlaceInstance(v32.PlaceId, v32.GameId, game.Players.LocalPlayer, "", {
						Joined = true
					});
					wait(5);
					l__FriendsOnline__27.Teleporting.Visible = false;
					l__FriendsOnline__27.Retry.Visible = true;
				end);
			end;
		end;
		l__LeaderBar__2.Main.Friends.Container.Friends.Text = 0;
		l__LeaderBar__2.Main.Friends.Visible = 0 < 0;
		l__GameBar__3.Main.Friends.FriendsCount.Text = 0;
		l__GameBar__3.Main.Friends.Visible = 0 < 0;
		if 1 < 0 then
			local v35 = "s";
		else
			v35 = "";
		end;
		l__Leaderboard__9.Container.OverlayMenu.Friends.OnlineCount.Text = 0 .. " Friend" .. v35 .. " Online";
		l__Leaderboard__9.Container.OverlayMenu.Friends.Visible = 0 < 0;
	end;
end);
l__Leaderboard__9.Container.OverlayMenu.Friends.View.MouseButton1Click:connect(function()
	l__Leaderboard__9.Visible = false;
	l__FriendsOnline__27.Visible = true;
end);
l__FriendsOnline__27.Retry.Back.MouseButton1Click:connect(function()
	l__FriendsOnline__27.Retry.Visible = false;
end);
l__FriendsOnline__27.Title.Close.MouseButton1Click:connect(function()
	l__FriendsOnline__27.Visible = false;
end);
local l__Level__16 = l__LeaderBar__2.Main.Level;
function UpdateLevel()
	local l__NewXP__36 = _G.PlayerData.NewXP;
	local l__XPBar__37 = l__Level__16:WaitForChild("XPBar");
	l__Level__16.Level.Text = u9.GetLevel(l__NewXP__36);
	l__XPBar__37.Size = UDim2.new(u9.GetProgressToNextLevel(l__NewXP__36), l__XPBar__37.Size.X.Offset, l__XPBar__37.Size.Y.Scale, l__XPBar__37.Size.Y.Offset);
end;
game.ReplicatedStorage.UpdateDataClient.Event:connect(UpdateLevel);
game.ReplicatedStorage.UpdateData2.OnClientEvent:connect(UpdateLevel);
UpdateLevel();
