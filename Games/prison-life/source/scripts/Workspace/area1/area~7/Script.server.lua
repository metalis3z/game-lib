local OpenValue = game.ReplicatedStorage.DoorValue.OpenDoorCV

script.Parent.Touched:Connect(function(hit)
	if hit.Parent:FindFirstChild("Humanoid") then
		local plr = game.Players:GetPlayerFromCharacter(hit.Parent)
		
		if OpenValue.Value == false then
			plr.valueArrest.Value = true
		end
	end
end)
