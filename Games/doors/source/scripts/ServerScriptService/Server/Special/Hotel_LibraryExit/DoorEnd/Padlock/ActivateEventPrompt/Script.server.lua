script.Parent.Triggered:Connect(function(Player)
	game.ReplicatedStorage.EntityInfo.EngageMinigame:FireClient(Player, "Padlock")
end)