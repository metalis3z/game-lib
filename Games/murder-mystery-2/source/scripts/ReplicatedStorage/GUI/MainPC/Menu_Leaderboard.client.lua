local MainGUI = script.Parent.Game;
local LocalPlayer = game.Players.LocalPlayer;

local RankIcons = require(game.ReplicatedStorage.RankIconsEmpty);
local Leaderboard = MainGUI.Leaderboard;
local ProfileFrame = MainGUI.ViewProfile;

local PrestigeTexts = {
	[0]	= "";
	[1]	= "I";
	[2]	= "II";
	[3]	= "III";
	[4]	= "IV";
	[5]	= "V";
	[6]	= "VI";
	[7]	= "VII";
	[8]	= "VIII";
	[9]	= "IX";
	[10]= "X";
};

local Selecting = false;
local Select = 0;
--local Selector = Leaderboard.Selector;
local LeaderboardOpen = true;
local NameTags = game.ReplicatedStorage.GetSyncData:InvokeServer("NameTags");

local LevelData = {};
local TradeLock = true;

function GetData(DataName)
	return game.ReplicatedStorage.GetData:InvokeServer(DataName)
end

function GetLevel(XP)
	return math.floor((25 + math.sqrt(625 + 300 * XP))/50);
end

function UpdateLeaderboard()
	
	local PlayerTable = {}
	for _,Player in pairs(game.Players:GetPlayers()) do
		if not LevelData[Player.Name] then
			local Level,Prestige,Mythical,Elite = game.ReplicatedStorage.GetPlayerLevel:InvokeServer(Player);
			if Level~=nil and Prestige ~=nil and Mythical ~= nil and Elite ~= nil then
				LevelData[Player.Name] = {};
				LevelData[Player.Name].Level = Level;
				LevelData[Player.Name].Prestige = Prestige;
				LevelData[Player.Name].Mythical = Mythical;
				LevelData[Player.Name].Elite = Elite;
			end;
		end
		
		if LevelData[Player.Name] ~= nil and LevelData[Player.Name].Level ~= nil and LevelData[Player.Name].Prestige ~=nil and LevelData[Player.Name].Mythical ~= nil and LevelData[Player.Name].Elite ~= nil then
			table.insert(PlayerTable,{
				Player = Player;
				LD = LevelData[Player.Name];
			});
		end;
	end	
	
	table.sort(PlayerTable,function(a,b)
		if a.Elite and not b.Elite then
			return true;
		elseif b.Elite and not a.Elite then
			return false;
		else
			local SortLevelA = (a.LD.Prestige*100)+a.LD.Level;
			local SortLevelB = (b.LD.Prestige*100)+b.LD.Level;
			return SortLevelA > SortLevelB;
		end;
	end)

	for _,Obj in pairs(Leaderboard.Container:GetChildren()) do
		if Obj.Name ~= "Close" and Obj.Name ~= "UIListLayout" and Obj.Name ~= "TradeRequest" and Obj.Name ~= "ToggleRequests" and Obj.Name ~= "MinimumTradeLevel" and Obj.Name~="FriendsOnline" and Obj.Name~="TradeInfo" and Obj.Name~="TradeText" then
			Obj:Destroy();
		end
	end
	
	for i,Table in pairs(PlayerTable) do
		
		local Player = Table.Player;
		
		if Player ~= nil then
			local NewLabel = script:WaitForChild("PlayerFrame"):Clone();
			NewLabel.Visible = LeaderboardOpen;
			NewLabel.Name = "Player" .. i;
			local LD = LevelData[Player.Name];
			
            
			NewLabel.Level.Image = RankIcons[LD.Level];
			NewLabel.Level.Prestige.Text = PrestigeTexts[LD.Prestige];
			NewLabel.Level.Level.Text = LD.Level
			local Prefix = "";
			if LD.Elite then 
				NewLabel.PlayerLabel.TextColor3 = Color3.new(232/255,42/255,42/255);
				Prefix = "[ELITE] ";
			end
			if LD.Mythical then 
				NewLabel.PlayerLabel.TextColor3 = Color3.new(1, 0.333333, 0);
				Prefix = "[MYTHICAL] ";
				NewLabel.Level.Image = "http://www.roblox.com/asset/?id=14264153062";
			end
			
			if Player.MembershipType == Enum.MembershipType.Premium then 
				NewLabel.PlayerLabel.TextColor3 = Color3.new(1, 1, 1);
				Prefix = "[Premium] ";
			end
			
			if Player.Name == "IJayd_nBeast" then 
				NewLabel.PlayerLabel.TextColor3 = Color3.new(0, 0.333333, 1); 
				Prefix = "[CREATOR] "; 
			end
			if Player.Name == "toooher" then 
				NewLabel.PlayerLabel.TextColor3 = Color3.new(0.666667, 0, 1); 
				Prefix = "[DEVELOPER] "; 
			end
			if Player.Name == "Cringley" then 
				NewLabel.PlayerLabel.TextColor3 = Color3.new(1, 0, 0); 
				Prefix = "[YOUTUBER] "; 
			end
			if Player.Name == "bekometoye" then 
				NewLabel.PlayerLabel.TextColor3 = Color3.new(0.333333, 1, 0); 
				Prefix = "[Moderator] "; 
			end
			if Player.Name == "caimoo9" then 
				NewLabel.PlayerLabel.TextColor3 = Color3.new(0, 0.333333, 1); 
				Prefix = "[Head-Admin] "; 
			end


			
			if Player.Name == "RealSavageBeast5456" then 
				NewLabel.PlayerLabel.TextColor3 = Color3.new(0, 0.333333, 1); 
				Prefix = "[Creator] "; 
			end

			if Player.Name == "IL0veDallas" then 
				NewLabel.PlayerLabel.TextColor3 = Color3.new(1, 0.729412, 0.858824); 
				Prefix = "[Trial-Moderator] "; 
			end
			
			if Player.Name == "BxJ524" then 
				NewLabel.PlayerLabel.TextColor3 = Color3.new(0.333333, 0, 1); 
				Prefix = "[DEVELOPER] "; 
			end
			
			if Player.Name == "Durpsmm2reborn" then 
				NewLabel.PlayerLabel.TextColor3 = Color3.new(0.14902, 1, 0); 
				Prefix = "[DEVELOPER] "; 
			end
		
			if Player.Name == "Produde0822" then 
				NewLabel.PlayerLabel.TextColor3 = Color3.new(0, 1, 1); 
				Prefix = "[Trial-Moderator] "; 
			end
			
			if Player.Name == "JayAminAcc" then 
				NewLabel.PlayerLabel.TextColor3 = Color3.new(0, 1, 1); 
				Prefix = "[Senior-Admin] "; 
			end
			
			if Player.Name == "vardy10clone" then 
				NewLabel.PlayerLabel.TextColor3 = Color3.new(0, 1, 1); 
				Prefix = "[Special] "; 
			end
			
			if Player.UserId == 702952403 then 
				NewLabel.PlayerLabel.TextColor3 = Color3.new(1, 1, 0); 
				Prefix = "[DEVELOPER] "; 
			end
			
			if Player.Name == "CopeGalaxy" then 
				NewLabel.PlayerLabel.TextColor3 = Color3.new(0.666667, 1, 1);
				Prefix = "[Moderator] "; 
			end
			
			if Player.Name == "Fiouze_III" then 
				NewLabel.PlayerLabel.TextColor3 = Color3.new(1, 0.596078, 0.027451);  
				Prefix = "[Trial-Moderator] "; 
			end
			
			--[[if Player.Name == "Kr0gd" then 
				NewLabel.PlayerLabel.TextColor3 = Color3.new(1, 0, 0); 
				Prefix = "[YOUTUBER] "; 
			end]]
			
			if Player.Name == "Angelazz" then 
				NewLabel.PlayerLabel.TextColor3 = Color3.new(1, 0, 0); 
				Prefix = "[YOUTUBER] "; 
			end
			
			if Player.Name == "yuvanyudishtra" then 
				NewLabel.PlayerLabel.TextColor3 = Color3.new(1, 0, 0); 
				Prefix = "[YOUTUBER] "; 
			end
	

			if Player.Name == "Fiouze_III" then 
				NewLabel.PlayerLabel.TextColor3 = Color3.new(0, 1, 0); 
				Prefix = "[Trial-Moderator] "; 
			end
			
			if Player.Name == "iLogan_nBeast" then 
				NewLabel.PlayerLabel.TextColor3 = Color3.new(0.333333, 0, 0.498039); 
				Prefix = "[Head-Admin] "; 
			end

			if Player.Name == "CertifiedBellaaaa" then 
				NewLabel.PlayerLabel.TextColor3 = Color3.new(1, 0, 1); 
				Prefix = "[Community Manager] "; 
			end
			
			if Player.Name == "Dodosheet" then
				Prefix = "[OG] "; 
			end
			
			local PlayerObj = Instance.new("ObjectValue",NewLabel);
			PlayerObj.Name = "PlayerObj";
			PlayerObj.Value = Player;
			NewLabel.PlayerLabel.Text = Prefix .. Player.Name;
			local Color = NameTags[ tostring(Player.userId) ];			

			if Color then
				NewLabel.PlayerLabel.TextColor3 = Color;
			end
			--[[if Player.Name == "ChampulseV0" then
				NewLabel.PlayerLabel.Text = "Father Champulse"
				NewLabel.Level.Prestige.Text = ":)";
				NewLabel.PlayerLabel.TextColor3 = Color3.new(1, 0, 1);
			end--]]
			if Player.Name == "toooher" then
				NewLabel.PlayerLabel.Text = "[Developer] Toooher"
				NewLabel.Level.Prestige.Text = "79";
				NewLabel.Level.Level.Text = "600";
	            NewLabel.Level.Image = "http://www.roblox.com/asset/?id=10038489466";
				NewLabel.PlayerLabel.BackgroundColor3 = Color3.new(0.968627, 0.968627, 1);
			end
			if Player.UserId == 702952403 then
				NewLabel.PlayerLabel.Text = "[Developer] Rhavi"
				NewLabel.Level.Prestige.Text = "69";
				NewLabel.Level.Level.Text = "420";
				NewLabel.Level.Image = "http://www.roblox.com/asset/?id=10038489466";
				NewLabel.PlayerLabel.BackgroundColor3 = Color3.new(0.364706, 0, 1);
			end

			NewLabel.Parent = Leaderboard.Container;
			
			if Player == LocalPlayer then
				NewLabel.PlayerLabel.TextStrokeColor3 = Color3.new(15/255,15/255,15/255);
			end
			
			NewLabel.Button.MouseButton1Click:connect(function()
				_G.MenuPlayer = Player;
				Leaderboard.Inspect.Position = UDim2.new(Leaderboard.Inspect.Position.X, UDim.new(0, NewLabel.AbsolutePosition.Y - 3));
				Leaderboard.Inspect.Visible = not Leaderboard.Inspect.Visible;
				Leaderboard.Inspect.Username.Text = Player.Name
				--Leaderboard.Inspect.Username.Text = game.Players:FindFirstChild(Table.Player).Name
				if _G.MenuPlayer.Name == game.Players.LocalPlayer.Name then
					Leaderboard.Inspect.Trade.Style = Enum.ButtonStyle.RobloxRoundButton;
					Leaderboard.Inspect.Trade.Selectable = false;
					Leaderboard.Inspect.Username.Text = "You";
					Leaderboard.Inspect.Trade.Visible = TradeLock;
				else
					Leaderboard.Inspect.Username.Text = Player.Name;
					Leaderboard.Inspect.Trade.Style = Enum.ButtonStyle.RobloxRoundDefaultButton;	
					Leaderboard.Inspect.Trade.Visible = TradeLock;
				end
			end)
			
			NewLabel.Button.Selectable = true;
			NewLabel.Button.Selectable = false;
		end;
	end
	wait(1);
	UpdateLeaderboard();
end

for i,v in pairs(Leaderboard.Container:GetChildren()) do
	if v:FindFirstChild("IsPlayerFrame") and game.Players:FindFirstChild(v.Name) == nil then
		v:Destroy();
	end;
end;

Leaderboard.Container.Close.Toggle.MouseButton1Click:connect(function()
	LeaderboardOpen = not LeaderboardOpen;
	for i, v in pairs(Leaderboard.Container:GetChildren()) do
		if v:FindFirstChild("IsPlayerFrame") then
			v.Visible = LeaderboardOpen;
		end;
	end;
	if LeaderboardOpen == false then
		Leaderboard.Container.Close.Title.Rotation = 180;
		return;
	end;
	Leaderboard.Container.Close.Title.Rotation = 0;
end);

_G.Windows.Frames[ProfileFrame] = true;
_G.Windows.FrameNames.ViewProfile = ProfileFrame;

local XP = GetData("XP");
if not (GetLevel(XP) >= 10) then
	TradeLock = _G.PlayerData.Prestige > 0;
end;
Leaderboard.Container.ToggleRequests.Visible = TradeLock;
Leaderboard.Container.TradeInfo.Visible = TradeLock;
Leaderboard.Container.MinimumTradeLevel.Visible = not TradeLock;

if not TradeLock then
	_G.RequestsEnabled = false;
end

Leaderboard.Inspect.Close.MouseButton1Click:connect(function()
	Leaderboard.Inspect.Visible = false
end)

UpdateLeaderboard();

game.ReplicatedStorage.UpdateLeaderboard.OnClientEvent:connect(UpdateLeaderboard);