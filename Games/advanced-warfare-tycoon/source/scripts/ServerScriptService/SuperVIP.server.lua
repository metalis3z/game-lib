pcall(function()
	game.Players.PlayerAdded:connect(function(player)
		if game.GamePassService:PlayerHasPass(player,204889179) then
			repeat wait() until game.ServerStorage.MoneyStorage
			local cashmoney = game.ServerStorage.MoneyStorage:WaitForChild(player.Name)
			cashmoney.Value = cashmoney.Value + 15000
			player.CharacterAdded:connect(function(char)
				if char:WaitForChild("Humanoid") then
					char.Humanoid.WalkSpeed = char.Humanoid.WalkSpeed + 6
					char.Humanoid.MaxHealth = 500
					char.Humanoid.Health = char.Humanoid.MaxHealth
					game.Lighting.AdvancedMinigun:Clone().Parent=player.Backpack
				end
			end)
			local msg = Instance.new("Message",workspace)
			msg.Text = player.Name.." has joined the game as a Super Soldier!"
			wait(2)
			msg:Destroy()
		end
	end)
end)