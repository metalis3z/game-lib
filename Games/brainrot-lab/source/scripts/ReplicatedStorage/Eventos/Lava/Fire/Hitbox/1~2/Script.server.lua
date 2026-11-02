script.Parent.Touched:Connect(function(hit)
	if hit.Parent:FindFirstChild("Humanoid") then
		local player = game.Players:GetPlayerFromCharacter(hit.Parent)
		
		if player then
			player.Character.Humanoid.Sit = true
			wait(2)
			player.Character.Humanoid.Sit = false
		end
	end
end)