function Death(p1)
	if p1 then
		if p1:FindFirstChild("Stats") then
			if p1:FindFirstChild("Stats"):WaitForChild("Death") then
				p1:FindFirstChild("Stats"):WaitForChild("Death").Value = "Blitz"
			end
		end
	end
	
	game.ReplicatedStorage.EntityInfo.DeathHint:FireClient(p1, {"Oh... Hello.","I didn't expect to see you here","Let's see what you died to.","Oh, one of my favorites.","She said we should call that one Blitz.","Well... I'll see you later, right? You'll come back?","Haha... of course you will."}, "Yellow")
	game.ReplicatedStorage.EntityInfo.Jumpscare:FireClient(p1, "Blitz")
end

script.Parent.Touched:Connect(function(hit)
	if hit.Parent:FindFirstChild("Humanoid") then
		local plrhum = hit.Parent
		local p1 = game.Players:GetPlayerFromCharacter(hit.Parent)
		local playername = game.Players:GetPlayerFromCharacter(hit.Parent).Name
		if game.Players:GetPlayerFromCharacter(hit.Parent) then
			if game.Players:GetPlayerFromCharacter(hit.Parent).Character:GetAttribute("CuriousCrucifixEnabled", true) then
				game.Players:GetPlayerFromCharacter(hit.Parent).Character:FindFirstChild("CuriousCrucifix").Function:Fire(script.Parent.Parent)
			elseif game.Players:GetPlayerFromCharacter(hit.Parent).Character:GetAttribute("CuriousCrucifixEnabled", false) then
				
				p1.Character.Humanoid:TakeDamage(100)
				
				if p1 then
					if p1:FindFirstChild("Stats") then
						if p1:FindFirstChild("Stats"):WaitForChild("Death") then
							p1:FindFirstChild("Stats"):WaitForChild("Death").Value = "Blitz"
						end
					end
				end

				game.ReplicatedStorage.EntityInfo.DeathHint:FireClient(p1, {"Oh... Hello.","I didn't expect to see you here","Let's see what you died to.","Oh, one of my favorites.","She said we should call that one Blitz.","Well... I'll see you later, right? You'll come back?","Haha... of course you will."}, "Yellow")
				game.ReplicatedStorage.EntityInfo.Jumpscare:FireClient(p1, "Blitz")
			else
				
				p1.Character.Humanoid:TakeDamage(100)

				if p1 then
					if p1:FindFirstChild("Stats") then
						if p1:FindFirstChild("Stats"):WaitForChild("Death") then
							p1:FindFirstChild("Stats"):WaitForChild("Death").Value = "Blitz"
						end
					end
				end

				game.ReplicatedStorage.EntityInfo.DeathHint:FireClient(p1, {"Oh... Hello.","I didn't expect to see you here","Let's see what you died to.","Oh, one of my favorites.","She said we should call that one Blitz.","Well... I'll see you later, right? You'll come back?","Haha... of course you will."}, "Yellow")
				game.ReplicatedStorage.EntityInfo.Jumpscare:FireClient(p1, "Blitz")
			end
		end
	end
end)