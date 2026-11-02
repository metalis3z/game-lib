game.Players.PlayerAdded:connect(function(player)
	player.CharacterAdded:connect(function(character)
		
	repeat wait() until player.Data.Weapon.Value ~= ""

	wait(0.5)
	
	if player.Data.Weapon.Value == "Cutlass" and player.Character:FindFirstChild("Cutlass") == nil and player.Backpack:FindFirstChild("Cutlass") == nil then
		cutlass = game.Lighting.Weapons.Cutlass:Clone()
		cutlass.Parent = player.Backpack
	end
		
	if player.Data.Weapon.Value == "Katana" and player.Character:FindFirstChild("Katana") == nil and player.Backpack:FindFirstChild("Katana") == nil then
		katana = game.Lighting.Weapons.Katana:Clone()
		katana.Parent = player.Backpack
	end
		
	if player.Data.Weapon.Value == "Sabre" and player.Character:FindFirstChild("Sabre") == nil and player.Backpack:FindFirstChild("Sabre") == nil then
		sabre = game.Lighting.Weapons.Sabre:Clone()
		sabre.Parent = player.Backpack
	end
	
	end)
end)