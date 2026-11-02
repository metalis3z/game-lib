game.Players.PlayerAdded:connect(function(player)
	player.CharacterAdded:connect(function(character)
		
	wait(1)
	
	if player.Data.Geppo.Value == true and player.Backpack:FindFirstChild("Geppo") == nil then
		Geppo = game.Lighting.Rokushiki.Geppo:Clone()
		Geppo.Parent = player.Backpack
		Geppo.Disabled = false
	end
	
	if player.Data.Tekkai.Value == true and player.Backpack:FindFirstChild("Tekkai") == nil then
		Tekkai = game.Lighting.Rokushiki.Tekkai:Clone()
		Tekkai.Parent = player.Backpack
		Tekkai.Disabled = false
	end
	
	if player.Data.Shigan.Value == true and player.Backpack:FindFirstChild("Shigan") == nil then
		Shigan = game.Lighting.Rokushiki.Shigan:Clone()
		Shigan.Parent = player.Backpack
		Shigan.Disabled = false
	end
	
	if player.Data.Rankyaku.Value == true and player.Backpack:FindFirstChild("Rankyaku") == nil then
		Rankyaku = game.Lighting.Rokushiki.Rankyaku:Clone()
		Rankyaku.Parent = player.Backpack
		Rankyaku.Disabled = false
	end
	
	if player.Data.Soru.Value == true and player.Backpack:FindFirstChild("Soru") == nil then
		Soru = game.Lighting.Rokushiki.Soru:Clone()
		Soru.Parent = player.Backpack
		Soru.Disabled = false
	end
	
	if player.Data.Kamie.Value == true and player.Backpack:FindFirstChild("Kamie") == nil then
		Kamie = game.Lighting.Rokushiki.Kamie:Clone()
		Kamie.Parent = player.Backpack
		Kamie.Disabled = false
	end
	
	end)
end)