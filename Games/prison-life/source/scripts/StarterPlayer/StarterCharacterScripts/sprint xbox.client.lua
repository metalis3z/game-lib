local uis = game:GetService("UserInputService")

uis.InputBegan:Connect(function(key)
	if key.KeyCode == Enum.KeyCode.ButtonL2 then
		local player = game.Players.LocalPlayer
		if player.sprint.Value == true then
			game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = 24
		end
	end
end)

uis.InputEnded:Connect(function(key)
	if key.KeyCode == Enum.KeyCode.ButtonL2 then
		game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = 16
	end
end)