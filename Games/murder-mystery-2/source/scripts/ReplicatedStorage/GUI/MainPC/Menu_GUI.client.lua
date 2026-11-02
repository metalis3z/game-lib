local MainGUI = script.Parent.Game;
local v1 = require(game.ReplicatedStorage.Modules.FadeModule);
local TweenService = game:GetService("TweenService")
local LocalPlayer = game.Players.LocalPlayer;
local EndMusic = {
	"http://www.roblox.com/asset/?id=0";
	"http://www.roblox.com/asset/?id=0";
	"http://www.roblox.com/asset/?id=0";
	"http://www.roblox.com/asset/?id=0";
};
local Coins = 0;
local Elite = game.ReplicatedStorage.AmElite:InvokeServer();
local Mythic = game.ReplicatedStorage.AmMythic:InvokeServer();
_G.LockTarget = nil;
LocalPlayer.CameraMode = Enum.CameraMode.Classic;

local SyncedData = {};
function GetSyncData(DataName) 
	if SyncedData[DataName] == nil then
		SyncedData[DataName] = game.ReplicatedStorage.GetSyncData:InvokeServer(DataName);
	end
	return SyncedData[DataName];
end
game.ReplicatedStorage.UpdateSyncedData.OnClientEvent:connect(function(DataName,Data)
	SyncedData[DataName] = Data;
end)

local LevelCap = 82500;
local RankIcons = require(game.ReplicatedStorage.RankIcons);
local CodeImages = require(game.ReplicatedStorage.CodeImages);


local LevelIcon = MainGUI.Level;

function GetData(DataName)
	return game.ReplicatedStorage.GetData:InvokeServer(DataName)
end

function GetLevel(XP)
	return math.floor((25 + math.sqrt(625 + 300 * XP))/50);
end 


function UpdateLevel()
	local XP = GetData("XP")
	local Bar = LevelIcon:WaitForChild("XPBar").XP;
	LevelIcon.LevelText.Text = GetLevel(XP);
	local Progress = ((25 + math.sqrt(625 + 300 * XP))/50)%1/1
	Bar.Size = UDim2.new(Progress,Bar.Size.X.Offset,Bar.Size.Y.Scale,Bar.Size.Y.Offset)
	--LevelIcon.Image = RankIcons[GetLevel(XP)];
	if GetLevel(XP) >= 100 then
		LevelIcon.Prestige.Visible = true;
	else
		LevelIcon.Prestige.Visible = false;
	end;
end

LevelIcon.Prestige.MouseButton1Click:connect(function()
	MainGUI.Prestige.Visible = true;
end)
_G.CoinBagFull = false;
local u5 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0);
local u6 = TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0);
local u7 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0);
game.ReplicatedStorage.GetCoin.OnClientEvent:connect(function()
	local MaxCoins = (Elite and 50) or (Mythic and 50) or 40;
	if Coins < MaxCoins then
		Coins = Coins + 1;
		MainGUI.CashBag.CoinIcon.Coins.Text = Coins;
	end
	if Coins >= MaxCoins then		
		MainGUI.CashBag.CoinIcon.Coins.Text = Coins;
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
		
		MainGUI.CashBag.Image = "http://www.roblox.com/asset/?id=197073328";
		MainGUI.CoinBagFull.Visible = true;
		_G.CoinBagFull = true;
		TweenService:Create(MainGUI.CoinBagFull, u5, {
			Position = UDim2.new(0.5, 0, 0.8, 0)
		}):Play()
		wait(0.5);
		TweenService:Create(MainGUI.CoinBagFull, u6, {
			Rotation = 3
		}):Play()
		wait(1.5);
		TweenService:Create(MainGUI.CoinBagFull, u7, {
			Position = UDim2.new(0.5, 0, 1.15, 0)
		}):Play()
		wait(0.5);
		MainGUI.CoinBagFull.Visible = false;
		--if not Elite then GameGUI.CashBag.Elite.Visible = true; end;
	end	

end)
MainGUI.Prestige.Accept.MouseButton1Click:connect(function()
	game.ReplicatedStorage.Prestige:FireServer();
	MainGUI.Prestige.Visible = false;
	UpdateLevel();
end)

MainGUI.Prestige.Decline.MouseButton1Click:connect(function()
	MainGUI.Prestige.Visible = false;
end)


function comma_value(amount)
  local formatted = amount
  while true do  
    formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
    if (k==0) then
      break
    end
  end
  return formatted
end	

function UpdateCash()
	local Coins = _G.PlayerData.Credits;
	local Gems = _G.PlayerData.Gems;
	--MainGUI.Inventory.Equipped.CreditsLabel.Text = comma_value(Credits);
	MainGUI.Shop.Title.Coins.Container.Amount.Text = comma_value(Coins);
	MainGUI.Shop.Title.Gems.Container.Amount.Text = comma_value(Gems);
end

game.ReplicatedStorage.UpdateDataClient.Event:connect(function()
	UpdateCash();
	UpdateLevel();
end);

game.ReplicatedStorage.UpdateData2.OnClientEvent:connect(function()
	UpdateCash();
	UpdateLevel();
end)

UpdateCash();



game.ReplicatedStorage.GiveXP.OnClientEvent:connect(function(Amount)
	-- No longer used (Kuz)
end)

--[[game.ReplicatedStorage.EndCurrentRound.OnClientEvent:Connect(function(TimerData)
	MainGUI.Timer.Visible = false

	local PlayerData = game.ReplicatedStorage.GetPlayerData:InvokeServer()

	if PlayerData[LocalPlayer.Name]["Role"] == "Innocent" and PlayerData[LocalPlayer.Name]["Dead"] == false then
		local Song = Instance.new("Sound",script.Parent.Parent);
		Song.SoundId = EndMusic[math.random(1,#EndMusic)];
		Song.Volume = 1;
		Song.Looped = false;
		Song.PlayOnRemove = false;
		Song:Play();
		local Victory = script.InnocentVictory		
		Victory.Parent = MainGUI
		Victory.Visible = true
		Victory.Container:TweenSize(UDim2.new(1, 0,1, 0), "Out", "Sine", 0.3, false)
		wait(7)
		Victory:TweenPosition(UDim2.new(0.5, 0,-0.3, 0), "Out", "Sine", 0.5, false)
		wait(0.5)	
		v1.PlayCameraFade("In")
		Victory.Visible = false
	elseif PlayerData[LocalPlayer.Name]["Role"] == "Sheriff" and PlayerData[LocalPlayer.Name]["Dead"] == false and TimerData <= 0 then
		local Victory = script.InnocentVictory
		Victory.Parent = MainGUI
		Victory.Container.MurdererVictory.BorderColor3 = Color3.fromRGB(121, 121, 121)
		Victory.Container.MurdererVictory.BackgroundColor3 = Color3.fromRGB(179, 179, 179)
		Victory.Container.MurdererVictory.TextLabel.Text = "Times Up"
		Victory.Visible = true
		Victory.Container:TweenSize(UDim2.new(1, 0,1, 0), "Out", "Sine", 0.3, false)
		wait(7)
		Victory:TweenPosition(UDim2.new(0.5, 0,-0.3, 0), "Out", "Sine", 0.5, false)
		wait(0.5)
		v1.PlayCameraFade("In")
		Victory.Visible = false
	elseif PlayerData[LocalPlayer.Name]["Role"] == "Sheriff" and PlayerData[LocalPlayer.Name]["Dead"] == false and TimerData > 0 then
		local Song = Instance.new("Sound",script.Parent.Parent);
		Song.SoundId = EndMusic[math.random(1,#EndMusic)];
		Song.Volume = 1;
		Song.Looped = false;
		Song.PlayOnRemove = false;
		Song:Play();
		local Victory = script.SheriffVictory	
		Victory.Parent = MainGUI
		Victory.Visible = true
		Victory.Container:TweenSize(UDim2.new(1, 0,1, 0), "Out", "Sine", 0.3, false)
		wait(7)
		Victory:TweenPosition(UDim2.new(0.5, 0,-0.3, 0), "Out", "Sine", 0.5, false)
		wait(0.25)
		v1.PlayCameraFade("In")
		Victory.Visible = false
	elseif PlayerData[LocalPlayer.Name]["Role"] == "Hero" and PlayerData[LocalPlayer.Name]["Dead"] == false then
		local Song = Instance.new("Sound",script.Parent.Parent);
		Song.SoundId = EndMusic[math.random(1,#EndMusic)];
		Song.Volume = 1;
		Song.Looped = false;
		Song.PlayOnRemove = false;
		Song:Play();
		local Victory = script.SheriffVictory		
		Victory.Parent = MainGUI
		Victory.Container.MurdererVictory.BorderColor3 = Color3.fromRGB(121, 121, 0)
		Victory.Container.MurdererVictory.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
		Victory.Visible = true
		Victory.Container:TweenSize(UDim2.new(1, 0,1, 0), "Out", "Sine", 0.3, false)
		wait(7)
		Victory:TweenPosition(UDim2.new(0.5, 0,-0.3, 0), "Out", "Sine", 0.5, false)
		wait(0.5)
		v1.PlayCameraFade("In")
		Victory.Visible = false
	elseif PlayerData[LocalPlayer.Name]["Role"] == "Murderer" and PlayerData[LocalPlayer.Name]["Dead"] == false and TimerData > 0 then
		if tonumber(CountInnocentsAlive(PlayerData)) <= 0 then
			local Song = Instance.new("Sound",script.Parent.Parent);
			Song.SoundId = EndMusic[math.random(1,#EndMusic)];
			Song.Volume = 1;
			Song.Looped = false;
			Song.PlayOnRemove = false;
			Song:Play();
			local Victory = script.MurdererVictory			
			Victory.Parent = MainGUI
			Victory.Visible = true
			Victory.Container:TweenSize(UDim2.new(1, 0,1, 0), "Out", "Sine", 0.3, false)
			wait(7)
			Victory:TweenPosition(UDim2.new(0.5, 0,-0.3, 0), "Out", "Sine", 0.5, false)
			wait(0.5)
			v1.PlayCameraFade("In")
			Victory.Visible = false
		else 
			local Victory = script.InnocentVictory
			Victory.Parent = MainGUI
			Victory.Container.MurdererVictory.BorderColor3 = Color3.fromRGB(121, 121, 121)
			Victory.Container.MurdererVictory.BackgroundColor3 = Color3.fromRGB(179, 179, 179)
			Victory.Container.MurdererVictory.TextLabel.Text = "Times Up"
			Victory.Visible = true
			Victory.Container:TweenSize(UDim2.new(1, 0,1, 0), "Out", "Sine", 0.3, false)
			wait(7)
			Victory:TweenPosition(UDim2.new(0.5, 0,-0.3, 0), "Out", "Sine", 0.5, false)
			wait(0.5)
			Victory.Visible = false
			v1.PlayCameraFade("In")
		end
	elseif PlayerData[LocalPlayer.Name]["Role"] == "Murderer" and PlayerData[LocalPlayer.Name]["Dead"] == false and TimerData <= 0 then
		local Victory = script.InnocentVictory
		Victory.Parent = MainGUI
		Victory.Container.MurdererVictory.BorderColor3 = Color3.fromRGB(121, 121, 121)
		Victory.Container.MurdererVictory.BackgroundColor3 = Color3.fromRGB(179, 179, 179)
		Victory.Container.MurdererVictory.TextLabel.Text = "Times Up"
		Victory.Visible = true
		Victory.Container:TweenSize(UDim2.new(1, 0,1, 0), "Out", "Sine", 0.3, false)
		wait(7)
		Victory:TweenPosition(UDim2.new(0.5, 0,-0.1, 0), "Out", "Sine", 0.5, false)
		wait(0.25)
		v1.PlayCameraFade("In")
		Victory.Visible = false	

	end


end)]]
game.ReplicatedStorage.SpecialXPEvent.OnClientEvent:connect(function(Text)
	local XPText = script.XPText:Clone();
	XPText.Text = Text;
	XPText.Parent = MainGUI;
	game.Debris:AddItem(XPText,2);
end)


local EarnedXP = MainGUI.EarnedXP;
local Playing = false;

LocalPlayer.Backpack.ChildAdded:connect(function(Child)
	if Child.Name == "Gun" then
		MainGUI.Timer.Visible = true
	end
end)

UpdateLevel();

game.Players.LocalPlayer.Character.Humanoid.Died:connect(function()
	v1.DeathFlash()
	game.Players.LocalPlayer.PlayerGui.SpawnFade.Enabled = true;
	game.Players.LocalPlayer.PlayerGui.SpawnFade.Fade.Visible = true
	EarnedXP.Dead.Visible = true;
	EarnedXP.XPText.TextColor3 = BrickColor.new("Medium stone grey").Color;
	EarnedXP.VictoryLabel.TextColor3 = BrickColor.new("Medium stone grey").Color;
	Playing = false;
end)


MainGUI.GetElite.Info.Buy.MouseButton1Down:connect(function()
	game.ReplicatedStorage.GetElite:FireServer();
	MainGUI.GetElite.Visible = false;
end)

MainGUI.GetElite.Info.Cancel.MouseButton1Down:connect(function()
	MainGUI.GetElite.Visible = false;
end)

game.ReplicatedStorage.GetElite.OnClientEvent:connect(function()
	MainGUI.Shop.Visible = false;
	MainGUI.GetElite.Visible = true;
end)

local RoundStop = false
game.ReplicatedStorage.RoundStart.OnClientEvent:connect(function(GameTimer)
	local u8 = time()
	local PlayerData = game.ReplicatedStorage.GetPlayerData:InvokeServer()
	RoundStop = false
	if PlayerData[LocalPlayer.Name] ~= nil then
		local function u11(p11)
			local v15 = math.floor(p11 / 60);
			return (v15 > 0 and v15 .. "m " or "") .. p11 - v15 * 60 .. "s";
		end;
		game:GetService("RunService"):BindToRenderStep("RoundStart", 1000, function()
			if Playing then


				local v16 = math.floor(time() - u8);
				local v17 = 180 - v16;
				if v17 > 0 then
					MainGUI.Timer.XPText.Text = u11(v17);
					if not (v17 <= 30) then
						return;
					end;
				else
					MainGUI.Timer.XPText.Text = "Game Over!";
					MainGUI.Timer.XPText.TextColor3 = Color3.new(1, 1, 1);
					return;
				end;
				MainGUI.Timer.XPText.TextColor3 = Color3.new(255, 0, 0);
			else
				MainGUI.Timer.XPText.Text = "Game Over!";
				MainGUI.Timer.XPText.TextColor3 = Color3.new(1, 1, 1);
			end
		end);
		if PlayerData[LocalPlayer.Name]["Role"] == "Innocent" then
			Playing = true;
			local XPEarned = 0;
			EarnedXP.XPText.Text = XPEarned;
			EarnedXP.Visible = true;
			EarnedXP.VictoryLabel.Text = "Survival XP";
			EarnedXP.XPText.TextColor3 = Color3.new(1, 0.568627, 0.0745098);
			while Playing and not RoundStop do
				wait(1);
				if XPEarned <= 900 then
				XPEarned = XPEarned + 5;
					EarnedXP.XPText.Text = XPEarned;
				end
				if XPEarned == 900 then
					RoundStop = true
					EarnedXP.VictoryLabel.Text = "Game Over!";
					EarnedXP.XPText.TextColor3 = Color3.new(0, 1, 0);
				end
			end
		else
			Playing = true;
			MainGUI.Timer.Visible = true
		end 
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
	end;
end)

game.ReplicatedStorage.RoundEnd.OnClientEvent:connect(function(GameTimer)
	local PlayerData = game.ReplicatedStorage.GetPlayerData:InvokeServer()
	if PlayerData[LocalPlayer.Name]["Role"] == "Innocent" then 
		RoundStop = true
	end
	Playing = false
end)

function CountInnocentsAlive(PlayerData)
	local Count = 0;
	for PlayerName,Data in pairs(PlayerData) do
		if Data["Role"] == "Innocent" and Data["Dead"] == false then
			Count = Count + 1;
		end
	end
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
	return Count;
end

function CountInnocentsDead(PlayerData)
	local Count = 0;
	for PlayerName,Data in pairs(PlayerData) do
		if (Data["Role"] == "Innocent" or Data["Role"] == "Sheriff") and Data["Dead"] == true then
			Count = Count + 1;
		end
	end
	return Count;
end


game.ReplicatedStorage.LevelUp.OnClientEvent:connect(function(OldRankImage,NewRankImage)
	local Vote = Instance.new("Sound",script.Parent);
	Vote.SoundId = "http://www.roblox.com/asset/?id=169038670";
	Vote.Volume = 0.7;
	Vote.Looped = false;
	Vote.PlayOnRemove = false;
	--Vote:Play();
	MainGUI.RankUp.Visible = true;
	MainGUI.OldRank.Image = OldRankImage;
	MainGUI.NewRank.Image = NewRankImage;
	MainGUI.OldRank.Visible = true;
	wait(1);
	MainGUI.OldRank:TweenPosition(UDim2.new(0, -150, 1, -250), "Out", "Quad", 0.5, false)
	MainGUI.NewRank:TweenPosition(UDim2.new(0.5,-75, 1, -250), "Out", "Quad", 0.5, false)
	wait(4);
	MainGUI.RankUp.Visible = false;
	MainGUI.OldRank.Visible = false;
	MainGUI.NewRank.Visible = false;
end)

game.ReplicatedStorage.SpecialRound.OnClientEvent:connect(function()
	local Vote = Instance.new("Sound",script.Parent);
	Vote.SoundId = "http://www.roblox.com/asset/?id=136938019";
	Vote.Volume = 0.7;
	Vote.Looped = false;
	Vote.PlayOnRemove = false;
	Vote:Play();
	MainGUI.SpecialRound:TweenPosition(UDim2.new(0.5, -250, 0.5, -125), "Out", "Quad", 0.5, false);
	MainGUI.SpecialRound.Visible = true;
	wait(5);
	MainGUI.SpecialRound.Visible = false;
	Vote:Stop();
end);


repeat wait() until LocalPlayer.Character ~= nil;
wait();
LocalPlayer.CameraMode = "Classic";
LocalPlayer.CameraMinZoomDistance = 7;
wait(0.5);
LocalPlayer.CameraMinZoomDistance = 0.5;
game.StarterGui:SetCoreGuiEnabled("Health",false);
game.StarterGui:SetCoreGuiEnabled("PlayerList",false);

local Version = game.ReplicatedStorage.GetVersion:InvokeServer();
MainGUI.Dock.Version.Text = Version;


MainGUI.Dock.Touch.Visible = game:GetService("UserInputService").TouchEnabled;

local Open = true;
MainGUI.Dock.Touch.Button.MouseButton1Click:connect(function()
	Open = not Open;
	MainGUI.Dock.Touch.Title.Text = (Open and "<") or ">";
	MainGUI.Dock:TweenPosition(
		UDim2.new(0, (Open and 0) or -135, 0.5, -150),
		"Out","Quad",0.2,true
	);
end)


