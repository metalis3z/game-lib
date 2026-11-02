local player = game.Players.LocalPlayer

script.Parent.MouseButton1Down:Connect(function()
	if player.leaderstats.Coins.Value >= 90 then
		player.leaderstats.Coins.Value = player.leaderstats.Coins.Value - 90

		game.ReplicatedStorage.FusionCoil:Clone() .Parent = player:WaitForChild("Backpack")
	end
end)