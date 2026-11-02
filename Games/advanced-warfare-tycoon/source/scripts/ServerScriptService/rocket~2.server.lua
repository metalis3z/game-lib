pcall(function()
	game.Players.PlayerAdded:connect(function(player)
		if game.GamePassService:PlayerHasPass(player,204143610) then
			repeat wait() until game.ServerStorage.MoneyStorage
			local cashmoney = game.ServerStorage.MoneyStorage:WaitForChild(player.Name)
			cashmoney.Value = cashmoney.Value + 0
			player.CharacterAdded:connect(function(char)
				if char:WaitForChild("Humanoid") then
					game.Lighting.HeatRocket:Clone().Parent=player.Backpack
				end
			end)
			local msg = Instance.new("Message",workspace)
			msg.Text = player.Name..""
			wait(2)
			msg:Destroy()
		end
	end)
end)