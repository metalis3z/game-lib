local player = script.Parent.Parent.Parent.Parent.Parent

script.Parent.MouseButton1Click:connect(function()
	player.Team = game.Teams:FindFirstChild("Suçlu")
	player.Character.Humanoid.Health = 0
end)