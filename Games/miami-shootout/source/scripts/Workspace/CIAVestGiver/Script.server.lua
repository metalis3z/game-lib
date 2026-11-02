script.Parent.ClickDetector.MouseClick:Connect(function(plr)
	
	if (not plr.Character:FindFirstChild("PoliceVest") and not plr.Character:FindFirstChild("ESUVest") and not plr.Character:FindFirstChild("CIAVest") and not plr.Character:FindFirstChild("FBIVest")) and plr.Character:FindFirstChild("CIAUNI") and plr.Team == game.Teams.Police then
		
		--local groupRank = plr:GetRankInGroup(16324260)
	 	--groupRank = 2
		
		local hat = game.ServerStorage:FindFirstChild("Hats"):FindFirstChild("CIA"):FindFirstChild("CIAVest")
		local clon = hat:Clone()
		
		plr.Character.Humanoid:AddAccessory(clon)
		plr.Character.Humanoid.MaxHealth = 145
		plr.Character.Humanoid.Health = 145
		
	end
	
end)