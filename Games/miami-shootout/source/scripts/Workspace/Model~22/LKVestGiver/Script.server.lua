script.Parent.ClickDetector.MouseClick:Connect(function(plr)
	print("clicked")
	if (not plr.Character:FindFirstChild("LKVest") and not plr.Character:FindFirstChild("CIAVest") and not plr.Character:FindFirstChild("ESUVest") and not plr.Character:FindFirstChild("FBIVest")) and plr.Team == game.Teams.Neutral then
		print("smh")
		if plr.Character:FindFirstChild("SPUNIFORM") then
			local hat = game.ServerStorage:FindFirstChild("Hats"):FindFirstChild("StatePolice"):FindFirstChild("PoliceVest")
			local clon = hat:Clone()

			plr.Character.Humanoid:AddAccessory(clon)
			plr.Character.Humanoid.MaxHealth = 150
			plr.Character.Humanoid.Health = 150
			return
		end
		
		if plr.Character:FindFirstChild("BHUNI") then
			local hat = game.ServerStorage:FindFirstChild("Hats"):FindFirstChild("BH"):FindFirstChild("PoliceVest")
			local clon = hat:Clone()

			plr.Character.Humanoid:AddAccessory(clon)
			plr.Character.Humanoid.MaxHealth = 150
			plr.Character.Humanoid.Health = 150
			return
		end
		
		if plr.Character:FindFirstChild("FBIUNI") then
			local hat = game.ServerStorage:FindFirstChild("Hats"):FindFirstChild("FBI"):FindFirstChild("FBIVest")
			local clon = hat:Clone()

			plr.Character.Humanoid:AddAccessory(clon)
			plr.Character.Humanoid.MaxHealth = 150
			plr.Character.Humanoid.Health = 150
			return
		end
		
		
		local groupRank = plr:GetRankInGroup(32868117)
	 	--groupRank = 2
		
		local hat = game.ServerStorage:FindFirstChild("Hats"):FindFirstChild("LK"):FindFirstChild("LKVest")
		local clon = hat:Clone()
		
		if groupRank >= 224 then
			clon.Badge.SurfaceGui.Frame.ImageLabel.Image = "rbxassetid://11766223387"
		else
			clon.Badge.SurfaceGui.Frame.ImageLabel.Image = "rbxassetid://11766224088"
		end
		
		plr.Character.Humanoid:AddAccessory(clon)
		plr.Character.Humanoid.MaxHealth = 150
		plr.Character.Humanoid.Health = 150
		print("done")
	end
	
end)