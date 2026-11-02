game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Died:connect(function()
	_G.Unboxing = false
end)

spawn(function()
	_G.Unboxing = false
end)