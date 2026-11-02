game.ReplicatedStorage.ClientBricks:FindFirstChild("JackDamageStress").OnServerEvent:Connect(function(player)
	local mathd = math.random(1, 3)

	if mathd == 2 then
		if player.Stats.StressMult.Value > 0 then
			player.Character.Humanoid:TakeDamage(25)
		else
			game.ReplicatedStorage.ClientBricks.StressPlayer:FireClient(player)
		end
	end
end)