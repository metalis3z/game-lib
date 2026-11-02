local LocalPlayer = game.Players.LocalPlayer;
local MainGUI = script.Parent.Parent;
local PlayerGui = MainGUI.Parent;
local LobbyGUI = MainGUI:WaitForChild("Lobby");
local Screens = LobbyGUI:WaitForChild("Screens");

Screens.Waiting.LeaderBar.Main.Players.PlayerCount.Text = game.Players.NumPlayers
Screens.Parent.GameBar.Main.Players.PlayerCount.Text = game.Players.NumPlayers
Screens.Waiting.LeaderBar.Main.Plus.Button.MouseButton1Click:connect(function()
    Screens.Waiting.Leaderboard.Visible = true
	Screens.Waiting.LeaderBar.Visible = false
end)
Screens.Parent.GameBar.Main.Plus.Button.MouseButton1Click:connect(function()
	Screens.Waiting.Leaderboard.Visible = true
	Screens.Parent.GameBar.Visible = false
end)
Screens.Waiting.Leaderboard.Container.Close.MouseButton1Click:connect(function()
	if not _G.InRound then
	Screens.Waiting.Leaderboard.Visible = false
		Screens.Waiting.LeaderBar.Visible = true
	else
		Screens.Waiting.Leaderboard.Visible = false
		Screens.Parent.GameBar.Visible = true
	end
end)

function GetLevel(XP)
	return math.floor((25 + math.sqrt(625 + 300 * XP))/50);
end 

function UpdateLevel()
	local XP = _G.PlayerData.XP;
	local Bar = Screens:WaitForChild("Waiting").LeaderBar.Main.Level.XPBar;
	Bar.Parent.Level.Text = "" .. GetLevel(XP);
	local Progress = ((25 + math.sqrt(625 + 300 * XP))/50)%1/1
	Bar.Size = UDim2.new(Progress,Bar.Size.X.Offset,Bar.Size.Y.Scale,Bar.Size.Y.Offset)
end



UpdateLevel();
game.ReplicatedStorage.UpdateData.OnClientEvent:connect(UpdateLevel);
game.ReplicatedStorage.UpdateDataClient.Event:connect(UpdateLevel);
