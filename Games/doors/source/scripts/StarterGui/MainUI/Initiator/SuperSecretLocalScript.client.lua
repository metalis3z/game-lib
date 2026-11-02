local v1 = script:FindFirstAncestor("MainUI");

if game.Players.LocalPlayer.Name == "XZrtgf" then
	v1.ConsoleMonitoring.Visible = true
	game.ReplicatedStorage.EntityInfo.SendErrorLog.OnClientEvent:Connect(function(text, typE)
		
		local tmp = v1.ConsoleMonitoring.Template:Clone()
		tmp.Parent = v1.ConsoleMonitoring
		tmp.Visible = true
		tmp.BackgroundColor3 = Color3.fromRGB(109, 113, 141)
		
		if text then
			if v1.ConsoleMonitoring then
				tmp.Text = tostring(text)
			end
		end
		
		if typE then
			if v1.ConsoleMonitoring then
				if typE == "Error" then
					tmp.Text = "Error: "..tostring(text)
					tmp.BackgroundColor3 = Color3.fromRGB(141, 63, 63)
				elseif typE == "Warn" then
					tmp.Text = "Warn: "..tostring(text)
					tmp.BackgroundColor3 = Color3.fromRGB(141, 126, 67)
				elseif typE == "AntiVirus" then
					tmp.Text = "Anti Virus: "..tostring(text)
					tmp.BackgroundColor3 = Color3.fromRGB(141, 45, 95)
				end
			end
		end
		
		task.delay(8, function()
			tmp.Visible = false
		end)
		
	end)
else
	v1.ConsoleMonitoring:Destroy()
	script:Destroy()
end