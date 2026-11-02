local MainGUI = script.Parent.Parent;
local LocalPlayer = game.Players.LocalPlayer;

local RankIcons = require(game.ReplicatedStorage.RankIconsEmpty);
local LeaderboardFrame = MainGUI.Leaderboard;
local Leaderboard = MainGUI.Leaderboard.List;
local TradeEvents = game.ReplicatedStorage.Trade;


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

local Actions = game:GetService("ContextActionService");
local Main = script.Parent.Parent;
local Bind = function(Name,Button,Function)
	local F = function(_,State)
		if State == Enum.UserInputState.Begin and (not _G.PauseBinds) then
			Function();
		end
	end
	Actions:BindAction(Name,F,false,Button);
end
local Unbind = function(Name,Button,Function)
	Actions:UnbindAction(Name);
end

function GetLevel(XP)
	return math.floor((25 + math.sqrt(625 + 300 * XP))/50);
end 
function UpdateLevel()
	local XP = _G.PlayerData.XP;
	local Bar = Leaderboard.Parent.XP.XPBar;
	Bar.Parent.Level.Text = "Level " .. GetLevel(XP);
	local Progress = ((25 + math.sqrt(625 + 300 * XP))/50)%1/1
	Bar.Size = UDim2.new(Progress,Bar.Size.X.Offset,Bar.Size.Y.Scale,Bar.Size.Y.Offset)
	--LevelIcon.Image = RankIcons[GetLevel(XP)];
	--[[if GetLevel(XP) >= 100 then
		LevelIcon.Prestige.Visible = true;
	else
		LevelIcon.Prestige.Visible = false;
	end;]]
end

UpdateLevel();


local LevelData = {};

local function GetSelfFrame()
	for _,Frame in pairs(Leaderboard:GetChildren()) do
		if Frame.Container.PlayerName.Text == game.Players.LocalPlayer.Name then
			return Frame;
		end
	end	
end

function UpdateLeaderboard()
	local NameTags = game.ReplicatedStorage.GetSyncData:InvokeServer("NameTags");
	
	local PlayerTable = {}
	for _,Player in pairs(game.Players:GetPlayers()) do

		if not LevelData[Player.Name] then
			local Level,Prestige,Elite = 0,0,false;
			Level,Prestige,Elite = game.ReplicatedStorage.GetPlayerLevel:InvokeServer(Player);
			
			LevelData[Player.Name] = {};
			LevelData[Player.Name].Level = Level;
			LevelData[Player.Name].Prestige = Prestige;
			LevelData[Player.Name].Elite = Elite;
		end

		table.insert(PlayerTable,{
			Player = Player;
			LD = LevelData[Player.Name];
		});

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
	
	local Reselect = false;
	if game:GetService("GuiService").SelectedObject and game:GetService("GuiService").SelectedObject.Parent == Leaderboard then
		Reselect = game:GetService("GuiService").SelectedObject.Name;
	end
	
	Leaderboard:ClearAllChildren();	
	
	for i,Table in pairs(PlayerTable) do
		local Player = Table.Player;
		if Player ~= nil then
			local NewLabel = script:WaitForChild("Player"):Clone();
			NewLabel.Name = "Player" .. i;
			NewLabel.Position = UDim2.new(0,0,(i-1)*0.05,0);
			local LD = LevelData[Player.Name];

			NewLabel.Container.RankIcon.Image = RankIcons[LD.Level];
			NewLabel.Container.Prestige.Text = PrestigeTexts[LD.Prestige];
			NewLabel.Container.RankIcon.Level.Text = LD.Level;
			local Prefix = "";
			if LD.Elite then 
				NewLabel.Container.PlayerName.TextColor3 = Color3.new(232/255,42/255,42/255);
				Prefix = "[ELITE] ";
			end
			local PlayerObj = Instance.new("ObjectValue",NewLabel);
			PlayerObj.Name = "PlayerObj";
			PlayerObj.Value = Player;
			NewLabel.Container.PlayerName.Text = Prefix .. Player.Name;
			
			local HoverConnection;
			
			if Player ~= game.Players.LocalPlayer then
				
				NewLabel.Container.Button.SelectionGained:connect(function()
					if MainGUI.Leaderboard.Trade.Request.Visible then return; end;
					NewLabel.Container.Response.Visible = true;
					HoverConnection = game:GetService("UserInputService").InputBegan:connect(function(Input)
						if Input.KeyCode == Enum.KeyCode.DPadLeft and (not MainGUI.Chat.Control.Visible) then
							local IsBusy = TradeEvents.SendRequest:InvokeServer(Player);
							if (not IsBusy)  then
								_G.ShowRequest(Player.Name,false);
								NewLabel.Container.Response.Visible = false;
							end
						elseif Input.KeyCode == Enum.KeyCode.DPadRight and (not MainGUI.Chat.Control.Visible) then
							_G.Examine(game.ReplicatedStorage.GetFullInventory:InvokeServer(Player),Player.Name);
						end;
					end)
				end)
				
				NewLabel.Container.Button.SelectionLost:connect(function()
					NewLabel.Container.Response.Visible = false;
					if HoverConnection then HoverConnection:disconnect(); end;
				end)
				
				NewLabel.Container.Response.Changed:connect(function()
					if NewLabel.Container.Response.Visible == false then
						if HoverConnection then HoverConnection:disconnect(); end;
					end
				end)
				
			end;
			
			
			local Color = NameTags[ tostring(Player.userId) ];
			
			if Color then
				NewLabel.Container.PlayerName.TextColor3 = Color;
			end
			
			NewLabel.Parent = Leaderboard;
		end;
	end
	
	if Reselect then
		game:GetService("GuiService").SelectedObject = Leaderboard:FindFirstChild(Reselect) or (GetSelfFrame() and GetSelfFrame().Container.Button) or Leaderboard.Player1.Container.Button;
	end
	
	wait(2);
end


UpdateLeaderboard();

local State = "PlayerList";


Bind("ShowLeaderboard",Enum.KeyCode.ButtonSelect,function()
	
	if State == "PlayerList" then
		State = "Trade";
		LeaderboardFrame.Trade.Visible = true;
		LeaderboardFrame.Title.Title.Text = "Trading";
		Leaderboard.Position = UDim2.new(1,-5,0.15, 20);
		game:GetService("GuiService").SelectedObject = (GetSelfFrame() and GetSelfFrame().Container.Button) or Leaderboard.Player1.Container.Button;
		
		Bind("CloseLeaderTrade",Enum.KeyCode.ButtonB,function()
			Unbind("CloseLeaderTrade");
			State = "PlayerList";
			LeaderboardFrame.Trade.Visible = false;
			Leaderboard.Visible = true;
			Leaderboard.Position = UDim2.new(1,-5,0.1, 10);
			game:GetService("GuiService").SelectedObject = nil;
		end)	
			
	elseif State == "Trade" then
		Unbind("CloseLeaderTrade");
		State = "Closed";
		game:GetService("GuiService").SelectedObject = nil;
		Leaderboard.Visible = false;
		LeaderboardFrame.Trade.Visible = false;
		LeaderboardFrame.Title.Title.Text = "Player List";
		
	elseif State == "Closed" then
		State = "PlayerList";
		Leaderboard.Visible = true;
		Leaderboard.Position = UDim2.new(1,-5,0.1, 10);
		
	end;
end)

game.ReplicatedStorage.UpdateData.OnClientEvent:connect(UpdateLevel);
game.ReplicatedStorage.UpdateDataClient.Event:connect(UpdateLevel);


--game.ReplicatedStorage.UpdateLeaderboard.OnClientEvent:connect(UpdateLeaderboard);