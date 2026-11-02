local TweenService = game:GetService("TweenService")

script.Parent.Touched:Connect(function(hit)
	if hit.Parent:FindFirstChild("Humanoid") then
		local player = game.Players:GetPlayerFromCharacter(hit.Parent)
		local frame = player.PlayerGui.GUI.Frames.Index
		
		if frame.Visible == false then
			
			frame.Position = UDim2.fromScale(.5,.6)
			TweenService:Create(frame, TweenInfo.new(.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.fromScale(0.5,0.5)}):Play()
			for _, frame in pairs( player.PlayerGui.GUI.Frames:GetChildren()) do
				frame.Visible = false
			end
			frame.Visible = true
		end
	end
end)

script.Parent.TouchEnded:Connect(function(hit)
	if hit.Parent:FindFirstChild("Humanoid") then
		local player = game.Players:GetPlayerFromCharacter(hit.Parent)
		if player.PlayerGui.GUI.Frames.Index.Visible == true then
			player.PlayerGui.GUI.Frames.Index.Visible = false
		end
	end
end)