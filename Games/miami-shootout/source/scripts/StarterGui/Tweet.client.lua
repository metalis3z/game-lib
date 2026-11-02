game.ReplicatedStorage.Tweet.OnClientEvent:Connect(function(plr, text, mode)
	local sg = game:GetService("StarterGui")

	print("Received")
	if mode == "Success" then

		sg:SetCore("SendNotification", {
			Title = "Tweet from "..plr.Name;
			Text = text;
			Icon = "http://www.roblox.com/asset/?id=740771683";
			Duration = 15
		})
	elseif mode == "Failed" then

		sg:SetCore("SendNotification", {
			Title = "Tweet failed";
			Text = text;
			Icon = "http://www.roblox.com/asset/?id=740771683";
			Duration = 15
		})
	end
end)

game.ReplicatedStorage.Emojis.OnClientEvent:Connect(function(plr)
		print("Emojis")
	for _,descendants in pairs(workspace.Emojis:GetDescendants()) do
		if descendants:IsA("TextLabel") then
			if descendants.Visible == true then
				print("hidden")
				descendants.Visible = false
			elseif descendants.Visible == false then
				print("shown")
				descendants.Visible = true
			end	
		end
	end	
end)