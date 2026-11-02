game.Players.PlayerAdded:connect(function(player)
	player.CharacterAdded:connect(function(character)

	wait(2)
	
	if player.Data.Weapon.Value == "" then
		x = game.Lighting.SwordGui:Clone()
		x.Parent = player.PlayerGui
		player.Data.Bounty.Value = 0
		player.Data.Side.Value = "Pirate"
		wait(10)
		
		x2 = math.random(1, 20)
		
		if x2 == 1 then
			player.Data.Haoshoku.Value = true
			gui = game.Lighting.HaoGui:Clone()
			gui.Parent = player.PlayerGui
			game.Debris:AddItem(gui, 3)
			hao = game.Lighting.Haki.HaoshokuHaki:Clone()
			hao.Parent = player.Backpack
			hao.Disabled = false
			end
		end
	end)
end)