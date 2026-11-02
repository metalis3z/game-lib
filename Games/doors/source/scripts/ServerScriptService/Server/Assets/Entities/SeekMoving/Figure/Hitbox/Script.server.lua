script.Parent.Touched:Connect(function(hit)
	if hit.Parent:FindFirstChild("Humanoid") then
		local plrhum = hit.Parent
		local playername = game.Players:GetPlayerFromCharacter(hit.Parent).Name
		if game.Players:GetPlayerFromCharacter(hit.Parent) then
			if game.Players:GetPlayerFromCharacter(hit.Parent).Character:GetAttribute("CrucifixEnabled", true) then
				game.Players:GetPlayerFromCharacter(hit.Parent).Character:FindFirstChild("Crucifix").Function:Fire(script.Parent.Parent)
			    script.Parent.CanTouch = false
			elseif game.Players:GetPlayerFromCharacter(hit.Parent).Character:GetAttribute("CrucifixEnabled", false) then
				if script.Parent.Parent.Parent.Settings.GetCrucifixed.Value == true then
					game.Players:WaitForChild(hit.Parent.Name).Stats.Death.Value = "Angry Seek"
					game.Players:GetPlayerFromCharacter(hit.Parent).Character.Humanoid.Health = 0 
					game.ReplicatedStorage.EntityInfo.DeathHint:FireClient(game.Players:WaitForChild(hit.Parent.Name), {"You Died to Angry Seek", "Doesn't turn around, just run."}, "Blue")
					game.ReplicatedStorage.EntityInfo.Jumpscare:FireClient(game.Players:WaitForChild(hit.Parent.Name), "Seek")
				else
					game.Players:WaitForChild(hit.Parent.Name).Stats.Death.Value = "Seek"
					game.Players:GetPlayerFromCharacter(hit.Parent).Character.Humanoid.Health = 0 
					game.ReplicatedStorage.EntityInfo.DeathHint:FireClient(game.Players:WaitForChild(hit.Parent.Name), {"You Died to Seek", "Look both ways before you progress."}, "Blue")
					game.ReplicatedStorage.EntityInfo.Jumpscare:FireClient(game.Players:WaitForChild(hit.Parent.Name), "Seek")
				end
			else
				if script.Parent.Parent.Parent.Settings.GetCrucifixed.Value == true then
					game.Players:WaitForChild(hit.Parent.Name).Stats.Death.Value = "Angry Seek"
					game.Players:GetPlayerFromCharacter(hit.Parent).Character.Humanoid.Health = 0 
					game.ReplicatedStorage.EntityInfo.DeathHint:FireClient(game.Players:WaitForChild(hit.Parent.Name), {"You Died to Angry Seek", "Doesn't turn around, just run."}, "Blue")
					game.ReplicatedStorage.EntityInfo.Jumpscare:FireClient(game.Players:WaitForChild(hit.Parent.Name), "Seek")
				else
					game.Players:WaitForChild(hit.Parent.Name).Stats.Death.Value = "Seek"
					game.Players:GetPlayerFromCharacter(hit.Parent).Character.Humanoid.Health = 0 
					game.ReplicatedStorage.EntityInfo.DeathHint:FireClient(game.Players:WaitForChild(hit.Parent.Name), {"You Died to Seek", "Look both ways before you progress."}, "Blue")
					game.ReplicatedStorage.EntityInfo.Jumpscare:FireClient(game.Players:WaitForChild(hit.Parent.Name), "Seek")
				end
			end
		end
	end
end)