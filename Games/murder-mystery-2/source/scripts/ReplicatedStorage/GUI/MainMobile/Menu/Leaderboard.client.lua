local LocalPlayer = game.Players.LocalPlayer;
local MainGUI = script.Parent.Parent;
local PlayerGui = MainGUI.Parent;
local LobbyGUI = MainGUI:WaitForChild("Lobby");
local Screens = LobbyGUI:WaitForChild("Screens");

local Items = game.ReplicatedStorage.GetSyncData:InvokeServer("Item");
local RankIcons = require(game.ReplicatedStorage.RankIconsEmpty);

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

local NameTags = game.ReplicatedStorage.GetSyncData:InvokeServer("NameTags");

local LevelData = {};

function UpdateLeaderboard(LeaderTable)

	Screens.Waiting.Leaderboard.Container.PlayerList:ClearAllChildren();
    local GridLayout = script.GridLayout:Clone()
	GridLayout.Parent = Screens.Waiting.Leaderboard.Container.PlayerList

	local PlayerTable = {}
	for _,Player in pairs(game.Players:GetPlayers()) do
		if not LevelData[Player.Name] then
			local Level,Prestige,Elite,Mythical = game.ReplicatedStorage.GetPlayerLevel:InvokeServer(Player);
			if Level~=nil and Prestige ~=nil and Elite ~= nil and Mythical ~= nil then
				LevelData[Player.Name] = {};
				LevelData[Player.Name].Level = Level;
				LevelData[Player.Name].Prestige = Prestige;
				LevelData[Player.Name].Elite = Elite;
				LevelData[Player.Name].Mythical = Mythical;
			end;
		end

		if LevelData[Player.Name] ~= nil and LevelData[Player.Name].Level ~= nil and LevelData[Player.Name].Prestige ~=nil and LevelData[Player.Name].Elite ~= nil and LevelData[Player.Name].Mythical ~= nil then
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
	
	for i,Table in pairs(PlayerTable) do

        local Player = Table.Player

		if Player ~= nil then
		local NewLabel = script:WaitForChild("PlayerFrame"):Clone();
		NewLabel.Name = "Player" .. i;

		local LD = LevelData[Player.Name];
		NewLabel.Level.Image = RankIcons[LD.Level];
		NewLabel.Level.Prestige.Text = PrestigeTexts[LD.Prestige];
		NewLabel.Level.Level.Text = LD.Level

		local Prefix = "";

		if LD.Elite then
			NewLabel.UsernameFrame.PlayerLabel.TextColor3 = Color3.new(232/255,42/255,42/255);
			Prefix = "[ELITE]";	
			end
			
			if LD.Mythical then
				NewLabel.UsernameFrame.PlayerLabel.TextColor3 = Color3.new(1, 0.333333, 0);
				Prefix = "[MYTHICAL] ";	
			end
			

		local Color = NameTags[ tostring(Player.userId) ];			

		if Color then
			NewLabel.UsernameFrame.PlayerLabel.TextColor3 = Color;
		end

		local PlayerObj = Instance.new("ObjectValue",NewLabel);
		PlayerObj.Name = "PlayerObj";
		PlayerObj.Value = Player;
		NewLabel.UsernameFrame.PlayerLabel.Text = Prefix .. Player.Name;

		NewLabel.Parent = Screens.Waiting.Leaderboard.Container.PlayerList;

		if Player == LocalPlayer then
				NewLabel.UsernameFrame.PlayerLabel.TextStrokeColor3 = Color3.new(15/255,15/255,15/255);
		end

		NewLabel.Icon.Image = game.Players:GetUserThumbnailAsync(game.Players:GetUserIdFromNameAsync(Player.Name), Enum.ThumbnailType.AvatarBust, Enum.ThumbnailSize.Size352x352)
		NewLabel.ActionButton.MouseButton1Click:connect(function()
			_G.MenuPlayer = Player;
			Screens.Waiting.Leaderboard.Popup.Visible = true;
			Screens.Waiting.Leaderboard.Popup.Container.Username.Text = Player.Name
			Screens.Waiting.Leaderboard.Popup.Container.IconContainer.PlayerIcon.Image = game.Players:GetUserThumbnailAsync(game.Players:GetUserIdFromNameAsync(Player.Name), Enum.ThumbnailType.AvatarBust, Enum.ThumbnailSize.Size352x352)
		   end)
			Screens.Waiting.Leaderboard.Popup.Container.Close.MouseButton1Click:connect(function()
				Screens.Waiting.Leaderboard.Popup.Visible = false
           end)
		end
	end
end

Screens.Waiting.Leaderboard.Popup.Close2.MouseButton1Click:connect(function()
	Screens.Waiting.Leaderboard.Popup.Visible = false
end)



function GetLevel(XP)
	return math.floor((25 + math.sqrt(625 + 300 * XP))/50);
end 

function UpdateLevel()
	local XP = _G.PlayerData.XP;
	local Bar = Screens:WaitForChild("Waiting").Level.XPBar;
	Bar.Parent.Level.Text = "Level " .. GetLevel(XP);
	local Progress = ((25 + math.sqrt(625 + 300 * XP))/50)%1/1
	Bar.Size = UDim2.new(Progress,Bar.Size.X.Offset,Bar.Size.Y.Scale,Bar.Size.Y.Offset)
end


UpdateLevel();
UpdateLeaderboard(game.ReplicatedStorage.GetLeaderboard:InvokeServer());
game.ReplicatedStorage.GiveLeaderboard.OnClientEvent:connect(UpdateLeaderboard);
game.ReplicatedStorage.UpdateData.OnClientEvent:connect(UpdateLevel);
game.ReplicatedStorage.UpdateDataClient.Event:connect(UpdateLevel);
