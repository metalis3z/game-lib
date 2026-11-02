script.Parent.Touched:Connect(function(hit)
	if hit.Parent:FindFirstChild("Humanoid") then
		local plrhum = hit.Parent
		local playername = game.Players:GetPlayerFromCharacter(hit.Parent).Name
		if game.Players:GetPlayerFromCharacter(hit.Parent) then
			if game.Players:GetPlayerFromCharacter(hit.Parent).Character:GetAttribute("CrucifixEnabled", true) then
				game.Players:GetPlayerFromCharacter(hit.Parent).Character:FindFirstChild("Crucifix").Function:Fire(script.Parent.Parent)
			elseif game.Players:GetPlayerFromCharacter(hit.Parent).Character:GetAttribute("CrucifixEnabled", false) then	
				local pt = game.Players:GetPlayerFromCharacter(hit.Parent)
				game.Players:WaitForChild(hit.Parent.Name).Stats.Death.Value = "Ambush"
				game.ReplicatedStorage.EntityInfo.DeathHint:FireClient(pt, {"You died to who you call Ambush...", "It is a tricky one.", "Use what you have learned from Rush!"}, "Blue")
				game.Players:GetPlayerFromCharacter(hit.Parent).Character.Humanoid.Health = 0 
				game.ReplicatedStorage.EntityInfo.Jumpscare:FireClient(pt, "Ambush")
			else
				local pt = game.Players:GetPlayerFromCharacter(hit.Parent)
				game.Players:WaitForChild(hit.Parent.Name).Stats.Death.Value = "Ambush"
				game.ReplicatedStorage.EntityInfo.DeathHint:FireClient(pt, {"You died to who you call Ambush...", "It is a tricky one.", "Use what you have learned from Rush!"}, "Blue")
				game.Players:GetPlayerFromCharacter(hit.Parent).Character.Humanoid.Health = 0 
				game.ReplicatedStorage.EntityInfo.Jumpscare:FireClient(pt, "Ambush")
			end
		end
	end
end)