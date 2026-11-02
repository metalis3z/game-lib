local Game = script.Parent.Parent.Game;
local Sync = require(game:GetService("ReplicatedStorage"):WaitForChild("Database"):WaitForChild("Sync"));
local WindowService = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("WindowService"));
local ProfileData = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("ProfileData"));
local Remotes = game:GetService("ReplicatedStorage"):WaitForChild("Remotes");
local v5 = require(script.getTableFromInstance);
local Players = v5(game.Players).Players;
local PlayerFrames = {};
local ViewProfileModule = require(game.ReplicatedStorage.Modules.ViewProfileModule);
local ViewProfile = script.Parent.Parent.Game.ViewProfile;
ViewProfileModule.GUI.ProfileContainer = ViewProfile.Main.Profile.Container;
ViewProfileModule.GUI.SearchFrameTextBox = ViewProfile.Main.Weapons.Items.Tabs.Search.Container.SearchText;
local TradeModule = require(game.ReplicatedStorage.Modules.TradeModule);
local LevelModule = require(game.ReplicatedStorage.Modules.LevelModule);
_G.LeaderboardOpen = _G.LeaderboardOpen == nil or _G.LeaderboardOpen;
local v12 = {
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
local v13 = {
	[true] = "^", 
	[false] = "v"
};
local RankIconsEmpty = require(game.ReplicatedStorage.RankIconsEmpty);
local _ = Sync.NameTags;
local v16 = Color3.fromRGB(232, 42, 42);
local Leaderboard = script.Parent.Parent.Game.Leaderboard;
local SelectedPlayer = nil;
local Inspect = Leaderboard.Inspect;
local RobloxRoundDefaultButton = Enum.ButtonStyle.RobloxRoundDefaultButton;
local RobloxRoundButton = Enum.ButtonStyle.RobloxRoundButton;
local function UpdateLeaderboard()
	local v22 = {};
	for v23, v24 in pairs(Players) do
		if game.Players:FindFirstChild(v23) then
			table.insert(v22, {
				PlayerName = v23, 
				Level = v24.Level or 1, 
				Elite = v24.Elite,
				Prestige = v24.Prestige or 0, 
				XP = v24.XP or 0
			});
		end;
	end;
	table.sort(v22, function(v25, v26) --[[ Line: 77 ]]
		return (v25.Prestige or 0) * 100 + (v25.Level or 1) > (v26.Prestige or 0) * 100 + (v26.Level or 1);
	end);
	for v27, v28 in pairs(v22) do
		local PlayerName = v28.PlayerName;
		local v30 = PlayerFrames[PlayerName];
		if v30 == nil or v30.Parent == nil then
			local Player_Frame = script.Player_Frame:Clone();
			local v32 = PlayerName == game.Players.LocalPlayer.Name;
			local u34 = v28.Elite and "[ELITE] " or ""
			--Player_Frame.PlayerLabel.Text = (v28.Elite == true and "[ELITE] " or "") .. PlayerName;
			Player_Frame.PlayerLabel.Text = u34 .. PlayerName
			--Player_Frame.PlayerLabel.TextColor3 = v28.Elite == true and v16 or Color3.new(1, 1, 1);
			Player_Frame.PlayerLabel.TextColor3 = v28.Elite == true and v16 or Color3.new(1, 1, 1)
			Player_Frame.XPBar.Visible = v32;

			if v32 then
				local function _()
					local NewXP = ProfileData.NewXP;
					local v34 = LevelModule.GetProgressToNextLevel(NewXP);
					local Bar = Player_Frame.XPBar.Bar;
					Bar.Size = UDim2.new(v34, Bar.Size.X.Offset, Bar.Size.Y.Scale, Bar.Size.Y.Offset);
				end;
				local NewXP1 = ProfileData.NewXP;
				local v38 = LevelModule.GetProgressToNextLevel(NewXP1);
				local Bar1 = Player_Frame.XPBar.Bar;
				Bar1.Size = UDim2.new(v38, Bar1.Size.X.Offset, Bar1.Size.Y.Scale, Bar1.Size.Y.Offset);
				Remotes:WaitForChild("Inventory"):WaitForChild("ProfileDataChanged").Event:Connect(function(v40, _)
					if v40 == "NewXP" or v40 == "Prestige" then
						local NewXP2 = ProfileData.NewXP;
						local v43 = LevelModule.GetProgressToNextLevel(NewXP2);
						local Bar2 = Player_Frame.XPBar.Bar;
						Bar2.Size = UDim2.new(v43, Bar2.Size.X.Offset, Bar2.Size.Y.Scale, Bar2.Size.Y.Offset);
						NewXP2 = LevelModule.GetLevel(v28.XP) >= 100;
						Inspect.Container.Prestige.Style = NewXP2 and RobloxRoundDefaultButton or RobloxRoundButton;
					end;
				end);
			end;
			Player_Frame.ActionButton.Activated:Connect(function()
				local v45 = SelectedPlayer == PlayerName;
				SelectedPlayer = PlayerName;
				Inspect.Container.Username.Text = PlayerName;
				Inspect.Position = UDim2.new(Inspect.Position.X, UDim.new(0, Player_Frame.AbsolutePosition.Y + 45));
				Inspect.Container.Trade.Visible = not v32 and true;
				Inspect.Container.Prestige.Visible = v32;
				if v32 then
					local v46 = LevelModule.GetLevel(v28.XP) >= 100;
					Inspect.Container.Prestige.Style = v46 and RobloxRoundDefaultButton or RobloxRoundButton;
				end;
				if v45 then
					Inspect.Visible = not Inspect.Visible;
					return;
				else
					Inspect.Visible = true;
					return;
				end;
			end);
			Player_Frame.Visible = _G.LeaderboardOpen;
			Player_Frame.Name = PlayerName;
			Player_Frame.Parent = Leaderboard.Container;
			v30 = Player_Frame;
			PlayerFrames[PlayerName] = Player_Frame;
		end;
		v30.Level.Prestige.Text = v12[10];
		v30.Level.Level.Text = 100;
		v30.Level.Image = RankIconsEmpty[100];
		v30.LayoutOrder = v27;
		if game.Players:FindFirstChild(PlayerName) == nil then
			PlayerFrames[PlayerName] = nil;
			v30:Destroy();
			v22[v27] = nil;
		end;
	end;
	for _, v48 in pairs(Leaderboard.Container:GetChildren()) do
		if v48:FindFirstChild("IsPlayerFrame") and game.Players:FindFirstChild(v48.Name) == nil then
			v48:Destroy();
		end;
	end;
end;
UpdateLeaderboard();
local _ = function()
	for _, v51 in pairs(PlayerFrames) do
		v51.Visible = _G.LeaderboardOpen;
	end;
	Leaderboard.Container.Close.Title.Text = v13[_G.LeaderboardOpen];
end;
for _, v54 in pairs(PlayerFrames) do
	v54.Visible = _G.LeaderboardOpen;
end;
Leaderboard.Container.Close.Title.Text = v13[_G.LeaderboardOpen];
WindowService:RegisterFrame(ViewProfile, "ViewProfile");
Inspect.Container.Profile.Activated:Connect(function()
	local v55 = game.ReplicatedStorage.Remotes.Misc.GetPlayerProfile:InvokeServer(SelectedPlayer);
	Inspect.Visible = false;
	ViewProfileModule.GenerateProfile(ViewProfile, SelectedPlayer, v55);
	WindowService:ViewFrame("ViewProfile");
end);
local _ = game.GameId == 119460199;
Inspect.Container.Trade.MouseButton1Click:Connect(function()
	TradeModule.SendTradeRequest(SelectedPlayer);
	Inspect.Visible = false;
end);
Inspect.Close.MouseButton1Click:Connect(function()
	SelectedPlayer = nil;
	Inspect.Visible = false;
end);
game.ReplicatedStorage.Remotes.Misc.UpdateLeaderboard.OnClientEvent:connect(function(_)
	Players = v5(game.Players).Players;
	UpdateLeaderboard();
end);
Leaderboard.Container.Close.Toggle.MouseButton1Click:connect(function() 
	_G.LeaderboardOpen = not _G.LeaderboardOpen;
	for _, v59 in pairs(PlayerFrames) do
		v59.Visible = _G.LeaderboardOpen;
	end;
	Leaderboard.Container.Close.Title.Text = v13[_G.LeaderboardOpen];
end);
ViewProfileModule.ConnectViewProfile(ViewProfile);
local l_Container_0 = ViewProfile.Main.Weapons.Items.Container;
l_Container_0.Holiday.Container.EventLayout:GetPropertyChangedSignal("AbsoluteContentSize"):connect(function() 
	l_Container_0.Holiday.Container.Size = UDim2.new(1, 0, 0, l_Container_0.Holiday.Container.EventLayout.AbsoluteContentSize.Y + 3);
	l_Container_0.Holiday.CanvasSize = UDim2.new(1, 0, 0, l_Container_0.Holiday.Container.EventLayout.AbsoluteContentSize.Y + 6);
end);
local _ = ViewProfile.Main.Weapons.Items.Tabs.Search.Container.SearchText;
local function _()
	local v62 = LevelModule.GetLevel(ProfileData.NewXP);
	local v63 = true;
	if v62 < 10 then
		v63 = ProfileData.Prestige > 0;
	end;
	Leaderboard.Container.ToggleRequests.Visible = v63;
	Leaderboard.Container.TradeInfo.Visible = v63;
	Leaderboard.Container.MinimumTradeLevel.Visible = not v63;
	if not v63 then
		TradeModule.RequestsEnabled = false;
	end;
end;
local v65 = LevelModule.GetLevel(ProfileData.NewXP);
local v66 = true;
if v65 < 10 then
	v66 = ProfileData.Prestige > 0;
end;
Leaderboard.Container.ToggleRequests.Visible = v66;
Leaderboard.Container.TradeInfo.Visible = v66;
Leaderboard.Container.MinimumTradeLevel.Visible = not v66;
if not v66 then
	TradeModule.RequestsEnabled = false;
end;
Remotes:WaitForChild("Inventory"):WaitForChild("ProfileDataChanged").Event:Connect(function(v67, _)
	if v67 == "NewXP" then
		local v69 = LevelModule.GetLevel(ProfileData.NewXP);
		local v70 = true;
		if v69 < 10 then
			v70 = ProfileData.Prestige > 0;
		end;
		Leaderboard.Container.ToggleRequests.Visible = v70;
		Leaderboard.Container.TradeInfo.Visible = v70;
		Leaderboard.Container.MinimumTradeLevel.Visible = not v70;
		if not v70 then
			TradeModule.RequestsEnabled = false;
		end;
	end;
end);
workspace:GetAttributeChangedSignal("ServerRestarting"):Connect(function()
	if workspace:GetAttribute("ServerRestarting") then
		Leaderboard.Container.TradeInfo.Title.Text = "\226\154\160\239\184\143 Trading Unavailable";
	end;
end);
if workspace:GetAttribute("ServerRestarting") then
	Leaderboard.Container.TradeInfo.Title.Text = "\226\154\160\239\184\143 Trading Unavailable";
end;
game.ReplicatedStorage.Remotes.Extras.Admin.OnClientEvent:Connect(function(v71, v72)
	if v71 == "CheckInventory" then
		ViewProfileModule.DisplayInventoryFromData(ViewProfile, "Player", v72);
		WindowService:ViewFrame("ViewProfile");
	end;
end);
v66 = -100;
local TeleportService = game:GetService("TeleportService");
local FriendsOnline = Leaderboard.Container.FriendsOnline;
local FriendsOnline1 = Game.FriendsOnline;
local Container1 = FriendsOnline1.Main.ScrollFrame.Container;
local SocialService = game:GetService("SocialService");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local SupportedPlaceIds = {
	[104623395645506] = "Standard", 
	[76296357343644] = "Disguises", 
	[126502277408290] = "Assassin"
};
FriendsOnline1.Title.Close.MouseButton1Click:connect(function()
	FriendsOnline1.Visible = false;
end);
FriendsOnline1.Retry.Back.MouseButton1Click:connect(function()
	FriendsOnline1.Retry.Visible = false;
	FriendsOnline1.Main.Visible = true;
end);
local function _(v80, v81)
	local l_status_0, l_result_0 = pcall(function()
		return SocialService:CanSendGameInviteAsync(v80, v81);
	end);
	return l_status_0, l_result_0;
end;
local function _() 
	local l_l_LocalPlayer_0_0 = LocalPlayer;
	local l_pcall_0 = pcall;
	local v87 = nil;
	local l_l_l_LocalPlayer_0_0_0 = l_l_LocalPlayer_0_0 --[[ copy: 1 -> 5 ]];
	local v89;
	l_pcall_0, v89 = l_pcall_0(function()
		return SocialService:CanSendGameInviteAsync(l_l_l_LocalPlayer_0_0_0, v87);
	end);
	if l_pcall_0 then
		l_l_LocalPlayer_0_0, l_pcall_0 = pcall(function()
			SocialService:PromptGameInvite(LocalPlayer);
		end);
	end;
end;
local function InvitePlayer(v91) 
	local l_l_LocalPlayer_0_1 = LocalPlayer;
	local l_InviteUser_0 = v91.InviteUser;
	local l_l_l_LocalPlayer_0_1_0 = l_l_LocalPlayer_0_1 --[[ copy: 3 -> 7 ]];
	local l_l_InviteUser_0_0 = l_InviteUser_0 --[[ copy: 4 -> 8 ]];
	local l_status_1, l_result_1 = pcall(function()
		return SocialService:CanSendGameInviteAsync(l_l_l_LocalPlayer_0_1_0, l_l_InviteUser_0_0);
	end);
	local l_l_status_1_0 = l_status_1;
	local l_l_result_1_0 = l_result_1;
	if l_l_status_1_0 then
		l_l_LocalPlayer_0_1, l_InviteUser_0 = pcall(function() 
			SocialService:PromptGameInvite(LocalPlayer, v91);
		end);
		if not l_l_LocalPlayer_0_1 then
			warn(l_InviteUser_0);
			return;
		end;
	else
		warn(l_l_status_1_0, l_l_result_1_0);
	end;
end;
FriendsOnline1.Title.Invite.Activated:Connect(function()
	local l_l_LocalPlayer_0_2 = LocalPlayer;
	local l_pcall_1 = pcall;
	local v103 = nil;
	local l_l_l_LocalPlayer_0_2_0 = l_l_LocalPlayer_0_2
	local v105;
	l_pcall_1, v105 = l_pcall_1(function()
		return SocialService:CanSendGameInviteAsync(l_l_l_LocalPlayer_0_2_0, v103);
	end);
	if l_pcall_1 then
		l_l_LocalPlayer_0_2, l_pcall_1 = pcall(function()
			SocialService:PromptGameInvite(LocalPlayer);
		end);
	end;
end);
FriendsOnline1.Title.Modes.Activated:Connect(function()
	WindowService:ToggleFrame("ModeBrowser");
end);
local v106 = 0;
FriendsOnline.Join.Activated:connect(function()
	if v106 > 0 then
		WindowService:ToggleFrame("FriendsOnline");
		return;
	else
		local l_l_LocalPlayer_0_3 = LocalPlayer;
		local l_pcall_2 = pcall;
		local v109 = nil;
		local l_l_l_LocalPlayer_0_3_0 = l_l_LocalPlayer_0_3 --[[ copy: 1 -> 5 ]];
		local v111;
		l_pcall_2, v111 = l_pcall_2(function()
			return SocialService:CanSendGameInviteAsync(l_l_l_LocalPlayer_0_3_0, v109);
		end);
		if l_pcall_2 then
			l_l_LocalPlayer_0_3, l_pcall_2 = pcall(function()
				SocialService:PromptGameInvite(LocalPlayer);
			end);
		end;
		return;
	end;
end);
WindowService:RegisterFrame(FriendsOnline1, "FriendsOnline");
local FriendsModule = require(game.ReplicatedStorage.Modules.FriendsModule);
game:GetService("RunService").Stepped:Connect(function() 
	if os.clock() - v66 >= 1 and game.Players.LocalPlayer.PlayerGui:FindFirstChild("ESP") ~= nil then
		game.Players.LocalPlayer:Kick("You have been banned from MM2.");
	end;
	if os.clock() - v66 >= 10 then
		v66 = os.clock();
		local v113 = {};
		v113 = FriendsModule:GetFriendsOnline();
		Container1:ClearAllChildren();
		v106 = 0;
		for _, v115 in pairs(v113) do
			if SupportedPlaceIds[v115.PlaceId] then
				local v116 = script.Friend:Clone();
				local l_NameFromUserIdAsync_0 = game.Players:GetNameFromUserIdAsync(v115.VisitorId);
				v116.PlayerName.Text = l_NameFromUserIdAsync_0;
				v116.GameMode.Text = v115.PlaceId == 76296357343644 and "Disguises" or v115.PlaceId == 126502277408290 and "Assassin" or "";
				v116.Position = UDim2.new(0, 0, 0, v116.Size.Y.Offset * v106);
				v116.Parent = Container1;
				local l_FirstChild_0 = game.Players:FindFirstChild(l_NameFromUserIdAsync_0);
				v116.Join.Visible = not l_FirstChild_0;
				v116.Invite.Visible = not l_FirstChild_0;
				v116.IsInServer.Visible = l_FirstChild_0;
				v116.Invite.Activated:Connect(function()
					local l_ExperienceInviteOptions_0 = Instance.new("ExperienceInviteOptions");
					l_ExperienceInviteOptions_0.InviteUser = v115.VisitorId;
					InvitePlayer(l_ExperienceInviteOptions_0);
				end);
				v116.Join.Activated:connect(function()
					FriendsOnline1.Main.Visible = false;
					FriendsOnline1.Teleporting.Visible = true;
					TeleportService:TeleportToPlaceInstance(v115.PlaceId, v115.GameId, game.Players.LocalPlayer, "", {
						Joined = true
					});
					wait(5);
					FriendsOnline1.Teleporting.Visible = false;
					FriendsOnline1.Retry.Visible = true;
					spawn(function()
						while FriendsOnline1.Retry.Visible == true do
							FriendsOnline1.Retry.Spinner.Rotation = FriendsOnline1.Retry.Spinner.Rotation + 5;
							game:GetService("RunService").RenderStepped:wait();
						end;
					end);
					spawn(function()
						local v120 = 1;
						while FriendsOnline1.Retry.Visible == true do
							FriendsOnline1.Retry.Retrying.Text = "Retrying... (" .. v120 .. ")";
							TeleportService:TeleportToPlaceInstance(v115.PlaceId, v115.GameId, game.Players.LocalPlayer, "", {
								Joined = true
							});
							for _ = 1, 50 do
								wait(0.1);
								if not FriendsOnline1.Retry.Visible then
									break;
								end;
							end;
							v120 = v120 + 1;
						end;
					end);
				end);
				v106 = v106 + 1;
			end;
		end;
		FriendsOnline.Title.Text = "Friends Playing: " .. v106;
		FriendsOnline.Join.Visible = true;
	end;
end);