local enabled = false
--[[
game.Players.LocalPlayer.PlayerGui.ChildAdded:Connect(function(child)
	if child.Name == "Infected" and enabled == false then
		wait(0.5)
		if game.Players.LocalPlayer.Character:FindFirstChild("Infected") then
			game:GetService("TweenService"):Create(game.Lighting:FindFirstChild("610CC"), TweenInfo.new(10, Enum.EasingStyle.Sine), {TintColor = Color3.fromRGB(255,0,0)}):Play()
					enabled = true
				
		workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.UpperTorso
		
		
end
	end
end)
]]

while wait(1) do
	if game.Players.LocalPlayer.Character:FindFirstChild("Infected") then
		game:GetService("TweenService"):Create(game.Lighting:FindFirstChild("610CC"), TweenInfo.new(10, Enum.EasingStyle.Sine), {TintColor = Color3.fromRGB(255,0,0)}):Play()
				
				
		workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.UpperTorso
	else
			
				
			workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
			game:GetService("TweenService"):Create(game.Lighting:FindFirstChild("610CC"), TweenInfo.new(10, Enum.EasingStyle.Sine), {TintColor = Color3.fromRGB(255,255,255)}):Play()
	end
end
