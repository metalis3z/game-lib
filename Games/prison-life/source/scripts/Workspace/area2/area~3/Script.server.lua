script.Parent.Touched:Connect(function(hit)
	if hit.Parent:FindFirstChild("Humanoid") then
		local plr = game.Players:GetPlayerFromCharacter(hit.Parent)
		if plr.valueArrest.Value == true then
			plr.valueArrest.Value = false
		end
	end
end)
