script.Parent.ClickDetector.MouseClick:Connect(function(plr)
	
	if not plr.Character:FindFirstChild("PoliceCap") and plr.Team == game.Teams.Police then
		
		local hat = game.ServerStorage:FindFirstChild("Hats"):FindFirstChild("Police"):FindFirstChild("PoliceCap")
		plr.Character.Humanoid:AddAccessory(hat:Clone())
		
	end
	
end)