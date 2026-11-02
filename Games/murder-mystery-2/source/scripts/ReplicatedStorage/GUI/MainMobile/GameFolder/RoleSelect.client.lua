local LocalPlayer = game.Players.LocalPlayer;
local MainGUI = script.Parent.Parent;
local PlayerGui = MainGUI.Parent;
local LobbyGUI = MainGUI:WaitForChild("Lobby");
local Dock = LobbyGUI:WaitForChild("Dock");
local Screens = LobbyGUI:WaitForChild("Screens");
local UserInputService = game:GetService("UserInputService")

local GameGUI = MainGUI:WaitForChild("Game");
local RoleSelector = GameGUI:WaitForChild("RoleSelector")


for _,Sound in pairs(script:GetChildren()) do
	game:GetService("ContentProvider"):Preload(Sound.SoundId)
end

game.ReplicatedStorage.Fade.OnClientEvent:connect(function(PlayerData)
	LobbyGUI.Screens.Waiting.Scoreboard.Visible = false;
	if not PlayerData[LocalPlayer.Name] then return; end;
	game.Players.LocalPlayer.PlayerGui:SetTopbarTransparency(0)
	for i = 1,30 do
		LobbyGUI.Fade.Transparency = LobbyGUI.Fade.Transparency - 1/30;
		game:GetService("RunService").RenderStepped:wait();
	end
	--LobbyGUI.Visible = false;
	UserInputService.ModalEnabled = false;
	GameGUI.Visible = true
end)

game.ReplicatedStorage.LoadingMap.OnClientEvent:connect(function(SpecialRound)
	if SpecialRound ~= "Classic" then
		GameGUI.SpecialRoundTutorial.Visible = true;
		GameGUI.SpecialRoundTutorial[SpecialRound].Visible = true;
	end
end)

game.ReplicatedStorage.RoleSelect.OnClientEvent:connect(function(Role,Color,CodeName,LockFirstPerson,GameMode,Target,Knife,Gun)
	_G.InRound = true
	GameGUI.Parent.Lobby.Screens.Waiting.LeaderBar.Visible = false
	GameGUI.Parent.Lobby.GameBar.Visible = true
	local Colors = {
		["Innocent"] = Color3.new(0,1,0);
		["Sheriff"] = Color3.new(0,0,1);
		["Murderer"] = Color3.new(1,0,0);
	};
	local Stop = {
		["Innocent"] = 13;
		["Sheriff"] = 14;
		["Murderer"] = 15;
	};
	local RoleIndex = {"Innocent","Sheriff","Murderer"};
	--GameGUI.Fade.Visible = true;
	LobbyGUI.Screens.Waiting.Leaderboard.Visible = false;
	for i = 1,30 do
		LobbyGUI.Fade.Transparency = LobbyGUI.Fade.Transparency + 1/30;
		game:GetService("RunService").RenderStepped:wait();
	end
	game.Players.LocalPlayer.PlayerGui:SetTopbarTransparency(0.5);

	RoleSelector.Visible = true;	
	
	if GameMode == "Classic" then
		for i = 1,Stop[Role] do
			local cRole = RoleIndex[((i-1)%3)+1];
			if i ~= Stop[Role] then
				script[cRole]:Play();
			else
				script.Ding:Play();
			end;
			wait(0.04);
			RoleSelector.Role.Text = cRole;
			RoleSelector.Role.TextColor3 = Colors[cRole];
			wait(0.06);
		end	

		wait(2.5);

		if Role == "Innocent" then
			RoleSelector.Title.Text = "Game starts in...";
			RoleSelector.Role.TextColor3 = Color3.new(1,1,1);
			for i = 1,10 do
				RoleSelector.Role.Text = 11-i
				if i == 3 then
					RoleSelector:TweenPosition(UDim2.new(0,0,0,0), "Out", "Quad", 1, false)
				end
				wait(1);
			end
			RoleSelector.Visible = false;
			--GameGUI.CashBag.Visible = true;
		else
			RoleSelector.Title.Text = "You will receive your weapon in...";
			RoleSelector.Role.TextColor3 = Color3.new(1,1,1);
			for i = 1,10 do
				RoleSelector.Role.Text = 11-i
				if i == 3 then
					RoleSelector:TweenPosition(UDim2.new(0,0,0,0), "Out", "Quad", 1, false)
				end
				wait(1);
			end
			RoleSelector.Visible = false;
			--GameGUI.CashBag.Visible = true;
		end;

		if LockFirstPerson then LocalPlayer.CameraMode = "LockFirstPerson"; end;
		--GameGUI.RoleFrame.CodeName.Text = CodeName;
		--GameGUI.RoleFrame.CodeName.TextColor3 = Color.Color;
		--GameGUI.RoleFrame.Visible = true;
		--GameGUI.Chat.Visible = true;
		GameGUI.CoinBag.Visible = true;

		if Role ~= "Innocent" then
		--[[GameGUI.Instructions.Visible = true;
		GameGUI.Instructions[Role].Visible = true;
		GameGUI.Instructions.Close.MouseButton1Click:connect(function()
			GameGUI.Instructions.Visible = false;
		end)]]
			GameGUI.Weapons[Role].Visible = true;
		end;

		if Role == "Murderer" then
			GameGUI.Perk.Visible = true;
			GameGUI.Throw.Visible = true;

		end
	elseif GameMode == "ElfInvasion" then
		RoleSelector.Title.Text = "Everyone is with the "
		RoleSelector.Role.Text = "Ocean"
		RoleSelector.Role.TextColor3 = Color3.new(0, 0.333333, 1);
		wait(3)
		RoleSelector.Title.Text = "Someone will be sand infected in...";
		RoleSelector:TweenPosition(UDim2.new(0,0,0,0), "Out", "Quad", 1, false)
		RoleSelector.Role.TextColor3 = Color3.new(1, 0.803922, 0.411765);
		for i = 1,18 do
			RoleSelector.Role.Text = 19-i
			wait(1);
		end
	elseif GameMode == "Dodeball" then
		RoleSelector.Title.Text = "You are on the"
		RoleSelector.Role.Text = Role .. " Team";
		RoleSelector.Role.TextColor3 = Colors[Role]or Color3.new();
		wait(3);
		RoleSelector.Title.Text = "Game starts in...";
		RoleSelector:TweenPosition(UDim2.new(0,0,0,0), "Out", "Quad", 1, false)
		RoleSelector.Role.TextColor3 = Color3.new(1,1,1);
		for i = 1,5 do
			RoleSelector.Role.Text = 6-i
			wait(1);
		end
	end
end)

local function u3(p4)
	for v19, v20 in pairs(p4) do
		v20:Play();
	end;
end;

local TweenService = game:GetService("TweenService");
local u5 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0);
local u6 = TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0);
local u7 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0);
local Coins = 0;
local Elite = game.ReplicatedStorage.AmElite:InvokeServer();
local Mythic = game.ReplicatedStorage.AmMythic:InvokeServer();
game.ReplicatedStorage.GetCoin.OnClientEvent:connect(function()
	local MaxCoins = (Elite and 50) or (Mythic and 50) or 40;
	if Coins < MaxCoins then
		Coins = Coins + 1;
	end
	if Coins >= MaxCoins then
		_G.CoinBagFull = true;
		for v21, v22 in pairs(game.Workspace:GetChildren()) do
			local l__CoinContainer__23 = v22:FindFirstChild("CoinContainer");
			if l__CoinContainer__23 then
				for v24, v25 in pairs(l__CoinContainer__23:GetChildren()) do
					local v26 = Instance.new("Model");
					v26.Name = "BagFull";
					v26.Parent = v25;
					v25:Destroy()
				end;
			end;
		end;
		GameGUI.CoinBag.Image = "ttp://www.roblox.com/asset/?id=197073328";
		GameGUI.CoinBag.Full.Visible = true;
		GameGUI.CoinBagFull.Visible = true;
		u3({ TweenService:Create(GameGUI.CoinBagFull, u5, {
			Position = UDim2.new(0.5, 0, 0.8, 0)
		}) });
		wait(0.5);
		u3({ TweenService:Create(GameGUI.CoinBagFull, u6, {
			Rotation = 3
		}) });
		wait(1.5);
		u3({ TweenService:Create(GameGUI.CoinBagFull, u7, {
			Position = UDim2.new(0.5, 0, 1.15, 0)
		}) });
		wait(0.5);
		GameGUI.CoinBagFull.Visible = false;
		--if not Elite then GameGUI.CashBag.Elite.Visible = true; end;
	end	
	GameGUI.CoinBag.CoinIcon.Coins.Text = Coins;
end)
game.ReplicatedStorage.GameOver.OnClientEvent:Connect(function()
	for v21, v22 in pairs(game.Workspace:GetChildren()) do
		local l__CoinContainer__23 = v22:FindFirstChild("CoinContainer");
		if l__CoinContainer__23 then
			for v24, v25 in pairs(l__CoinContainer__23:GetChildren()) do
				local v26 = Instance.new("Model");
				v26.Name = "BagFull";
				v26.Parent = v25;
				v25:Destroy()
			end;
		end;
	end;
end)
game.ReplicatedStorage.EndGame.OnClientEvent:Connect(function()
	for v21, v22 in pairs(game.Workspace:GetChildren()) do
		local l__CoinContainer__23 = v22:FindFirstChild("CoinContainer");
		if l__CoinContainer__23 then
			for v24, v25 in pairs(l__CoinContainer__23:GetChildren()) do
				local v26 = Instance.new("Model");
				v26.Name = "BagFull";
				v26.Parent = v25;
				v25:Destroy()
			end;
		end;
	end;
end)

_G.LockTarget = nil;
LocalPlayer.CameraMode = Enum.CameraMode.Classic;
LocalPlayer.CameraMinZoomDistance = 7;
wait(0.5);
LocalPlayer.CameraMinZoomDistance = 0.5;

game.Players.LocalPlayer.Character.Humanoid.Died:connect(function() game.Players.LocalPlayer.CameraMode = Enum.CameraMode.Classic; end);
