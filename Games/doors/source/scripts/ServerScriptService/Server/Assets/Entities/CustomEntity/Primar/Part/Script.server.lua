script.Parent.Touched:Connect(function(hit)
	if hit.Parent:FindFirstChild("Humanoid") then
		local plrhum = hit.Parent
		local p1 = game.Players:GetPlayerFromCharacter(hit.Parent)
		local playername = game.Players:GetPlayerFromCharacter(hit.Parent).Name
		if game.Players:GetPlayerFromCharacter(hit.Parent) then
			if game.Players:GetPlayerFromCharacter(hit.Parent).Character:GetAttribute("CrucifixEnabled", true) then
				game.Players:GetPlayerFromCharacter(hit.Parent).Character:FindFirstChild("Crucifix").Function:Fire(script.Parent.Parent)
			elseif game.Players:GetPlayerFromCharacter(hit.Parent).Character:GetAttribute("CrucifixEnabled", false) then

				if p1 then
					if p1:FindFirstChild("Stats") then
						if p1:FindFirstChild("Stats"):WaitForChild("Death") then
							p1:FindFirstChild("Stats"):WaitForChild("Death").Value = "Custom Entity"
						end
					end
				end

				if p1 then
					if p1.PlayerStats then
						if p1.PlayerStats.RushDeaths then
							game.ReplicatedStorage.EntityInfo.DeathHint:FireClient(p1, {"hi"}, "Grey")
						end
					end
				end
				
				game.Players:GetPlayerFromCharacter(hit.Parent).Character.Humanoid.Health = 0
			else
				

				if p1 then
					if p1:FindFirstChild("Stats") then
						if p1:FindFirstChild("Stats"):WaitForChild("Death") then
							p1:FindFirstChild("Stats"):WaitForChild("Death").Value = "Custom Entity"
						end
					end
				end

				if p1 then
					if p1.PlayerStats then
						if p1.PlayerStats.RushDeaths then
							game.ReplicatedStorage.EntityInfo.DeathHint:FireClient(p1, {"hi"}, "Grey")
						end
					end
				end
				
				game.Players:GetPlayerFromCharacter(hit.Parent).Character.Humanoid.Health = 0
			end
		end
	end
end)