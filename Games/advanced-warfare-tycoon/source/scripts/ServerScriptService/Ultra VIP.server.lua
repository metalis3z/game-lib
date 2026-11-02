pcall(function()
	game.Players.PlayerAdded:connect(function(player)
		if game.GamePassService:PlayerHasPass(player,204143218) then
			repeat wait() until game.ServerStorage.MoneyStorage
			local cashmoney = game.ServerStorage.MoneyStorage:WaitForChild(player.Name)
			cashmoney.Value = cashmoney.Value + 10000
			player.CharacterAdded:connect(function(char)
				if char:WaitForChild("Humanoid") then
					char.Humanoid.WalkSpeed = char.Humanoid.WalkSpeed + 5
					game.Lighting.Minigun:Clone().Parent=player.Backpack
				end
			end)
			local msg = Instance.new("Message",workspace)
			msg.Text = player.Name.." joined the game with Ultra VIP!"
			wait(2)
			msg:Destroy()
		end
	end)
end)