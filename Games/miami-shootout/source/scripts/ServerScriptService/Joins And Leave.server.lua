
local RemoteEvent = game.ReplicatedStorage.RemoteEvents.Notifications


local function onPlayerJoin(player)
	local playerName = player.Name
	local message = playerName .. " has joined the game!"


	for _, otherPlayer in pairs(game.Players:GetPlayers()) do
		RemoteEvent:FireClient(otherPlayer, "Info", message, 3)
	end
end


local function onPlayerLeave(player)
	local playerName = player.Name
	local message = playerName .. " has left the game."

	for _, otherPlayer in pairs(game.Players:GetPlayers()) do
		RemoteEvent:FireClient(otherPlayer, "Info", message, 3)
	end
end

game.Players.PlayerAdded:Connect(onPlayerJoin)
game.Players.PlayerRemoving:Connect(onPlayerLeave)
