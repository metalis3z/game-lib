local FE2Library = require(game.ReplicatedStorage.SharedModules.FE2Library)
local Frame = script.Parent.Frame
local Difficutly = Frame.Difficulty
local TimeLeft = Frame.TimeLeft
local MapName = Frame.MapName
local Players = Frame.Players

game.ReplicatedStorage.Remote.UpdateLobby.Event:Connect(function(BarSizeX, Max, StatusName, PlayerCount, Dif)
	Difficutly.BackgroundColor3 = FE2Library.Difficulties_Goals[math.floor(Dif)].Color
	Difficutly.Difficulty.Text = FE2Library.Difficulties_Goals[math.floor(Dif)].Name .. ": " .. Dif
	MapName.Text = StatusName
	Players.Text = PlayerCount
	if BarSizeX == nil or Max == nil then
		return
	end
end)