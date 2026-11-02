game.Players.PlayerAdded:connect(function(player)
	player.CharacterAdded:connect(function(character)
		
	wait(1)
	
	if player.Data.Busoshoku.Value ~= false and player.Backpack:FindFirstChild("BusoshokuHaki") ~= true then
		print(player.Name)
		buso = game.Lighting.Haki.BusoshokuHaki:Clone()
		buso.Parent = player.Backpack
		buso.Disabled = false
	end
	
	if player.Data.Kenbunshoku.Value ~= false and player.Backpack:FindFirstChild("KenbunshokuHaki") ~= true then
		print(player.Name)
		ken = game.Lighting.Haki.KenbunshokuHaki:Clone()
		ken.Parent = player.Backpack
		ken.Disabled = false
	end
	
	if player.Data.Haoshoku.Value ~= false and player.Backpack:FindFirstChild("HaoshokuHaki") ~= true then
		print(player.Name)
		hao = game.Lighting.Haki.HaoshokuHaki:Clone()
		hao.Parent = player.Backpack
		hao.Disabled = false
	end
	end)
end)