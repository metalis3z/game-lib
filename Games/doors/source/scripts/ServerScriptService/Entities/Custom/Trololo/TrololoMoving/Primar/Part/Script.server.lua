script.Parent.Touched:Connect(function(hit)
	if hit.Parent:FindFirstChild("Humanoid") then
		local plrhum = hit.Parent
		local p1 = game.Players:GetPlayerFromCharacter(hit.Parent)
		local playername = game.Players:GetPlayerFromCharacter(hit.Parent).Name
		if game.Players:GetPlayerFromCharacter(hit.Parent) then
			if game.Players:GetPlayerFromCharacter(hit.Parent).Character then
				if game.Players:GetPlayerFromCharacter(hit.Parent).Character:FindFirstChildOfClass("Tool") then
					local FindedItem = game.Players:GetPlayerFromCharacter(hit.Parent).Character:FindFirstChildOfClass("Tool")
					
					if FindedItem.Name == "CuriousCrucifix" then
						FindedItem.Function:Fire(script.Parent.Parent)
					end
				else
					
					p1.Character.Humanoid:TakeDamage(100)

					if p1 then
						if p1:FindFirstChild("Stats") then
							if p1:FindFirstChild("Stats"):WaitForChild("Death") then
								p1:FindFirstChild("Stats"):WaitForChild("Death").Value = "Trololo"
							end
						end
					end

					game.ReplicatedStorage.EntityInfo.DeathHint:FireClient(p1, {"use curious crucifix next time."}, "Yellow")
					
				end
			end
		end
	end
end)