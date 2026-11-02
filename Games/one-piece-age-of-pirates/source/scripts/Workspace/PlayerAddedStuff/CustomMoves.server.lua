game.Players.PlayerAdded:connect(function(player)
	player.CharacterAdded:connect(function(character)
		
	wait(2)
	
	if player.Name == "Tlmsuper" ~= false and player.Backpack:FindFirstChild("LightRay") ~= true then
		print(player.Name)
		ray = game.Lighting.CustomMoves.LightRay:Clone()
		ray.Parent = player.Backpack
		ray.Disabled = false
	end
	
	if player.Name == "Tlmsuper" ~= false and player.Backpack:FindFirstChild("LightMonkey") ~= true then
		print(player.Name)
		monkey = game.Lighting.CustomMoves.LightMonkey:Clone()
		monkey.Parent = player.Backpack
		monkey.Disabled = false
	end
	
	if player.Name == "FasterThanSanic" ~= false and player.Backpack:FindFirstChild("MassiveEruption") ~= true then
		print(player.Name)
		massive = game.Lighting.CustomMoves.MassiveEruption:Clone()
		massive.Parent = player.Backpack
		massive.Disabled = false
	end
	
	if player.Name == "Kyinite" ~= false and player.Backpack:FindFirstChild("Balloon") ~= true then
		print(player.Name)
		balloon = game.Lighting.CustomMoves.Balloon:Clone()
		balloon.Parent = player.Backpack
		balloon.Disabled = false
	end
	
	end)
end)