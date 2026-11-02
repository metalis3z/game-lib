local Players = game:GetService("Players")

Players.PlayerAdded:Connect(function(player)
	-- leaderstats setup (si tu ne l'as pas déjà)
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = player

	local cash = Instance.new("IntValue")
	cash.Name = "Cash"
	cash.Value = 0
	cash.Parent = leaderstats

	-- Gagne 10 de cash par seconde
	while player and player.Parent do
		wait(1)
		cash.Value = cash.Value + 10
	end
end)
