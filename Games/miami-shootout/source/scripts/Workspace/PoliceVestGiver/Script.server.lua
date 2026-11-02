script.Parent.ClickDetector.MouseClick:Connect(function(plr)
	print("clicked")
	if (not plr.Character:FindFirstChild("PoliceVest") and not plr.Character:FindFirstChild("CIAVest") and not plr.Character:FindFirstChild("ESUVest") and not plr.Character:FindFirstChild("FBIVest")) and plr.Team == game.Teams.Police then
		print("smh")
		if plr.Character:FindFirstChild("SPUNIFORM") then
			local hat = game.ServerStorage:FindFirstChild("Hats"):FindFirstChild("StatePolice"):FindFirstChild("PoliceVest")
			local clon = hat:Clone()

			plr.Character.Humanoid:AddAccessory(clon)
			plr.Character.Humanoid.MaxHealth = 200
			plr.Character.Humanoid.Health = 200
			return
		end
		
		if plr.Character:FindFirstChild("BHUNI") then
			local hat = game.ServerStorage:FindFirstChild("Hats"):FindFirstChild("BH"):FindFirstChild("PoliceVest")
			local clon = hat:Clone()

			plr.Character.Humanoid:AddAccessory(clon)
			plr.Character.Humanoid.MaxHealth = 200
			plr.Character.Humanoid.Health = 200
			return
		end
		
		if plr.Character:FindFirstChild("FBIUNI") then
			local hat = game.ServerStorage:FindFirstChild("Hats"):FindFirstChild("FBI"):FindFirstChild("FBIVest")
			local clon = hat:Clone()

			plr.Character.Humanoid:AddAccessory(clon)
			plr.Character.Humanoid.MaxHealth = 200
			plr.Character.Humanoid.Health = 200
			return
		end
		
		
		local groupRank = plr:GetRankInGroup(16324260)
	 	--groupRank = 2
		
		local hat = game.ServerStorage:FindFirstChild("Hats"):FindFirstChild("Police"):FindFirstChild("PoliceVest")
		local clon = hat:Clone()
		
		if groupRank >= 5 then
			clon.Badge.SurfaceGui.Frame.ImageLabel.Image = "rbxassetid://11766223387"
		else
			clon.Badge.SurfaceGui.Frame.ImageLabel.Image = "rbxassetid://11766224088"
		end
		
		plr.Character.Humanoid:AddAccessory(clon)
		plr.Character.Humanoid.MaxHealth = 200
		plr.Character.Humanoid.Health = 200
		print("done")
	end
	
end)