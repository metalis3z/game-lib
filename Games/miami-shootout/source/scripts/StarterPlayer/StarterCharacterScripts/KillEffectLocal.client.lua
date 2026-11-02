game.Players.LocalPlayer.Character.Humanoid.Died:Connect(function()
	spawn(function()
		local creator = game.Players.LocalPlayer.Character.Humanoid:FindFirstChild("creator").Value
		if creator then
			game.ReplicatedStorage.deathevent:FireServer(creator)
			game.ReplicatedStorage.deathevent:FireServer()
		end
	end)
end)