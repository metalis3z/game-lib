script.BillboardGui.Parent = game.ServerScriptService.MainClient
local bill = game.ServerScriptService.MainClient:WaitForChild("BillboardGui")

game.Workspace.ChildAdded:Connect(function(plr)
	local clone = bill:Clone()
	clone.Enabled = true
	clone.Parent = plr.Head
	clone.Frame.TextLabel.Text = plr.Name
	if plr.Name == "" then
		clone.Frame.TextLabel.Text = "[🛡+🍆]" ..plr.Name
	end
	if plr.Name == "Robuxgenious" then
		clone.Frame.TextLabel.Text = '[⭐]'..plr.Name
	end
	if plr.Name == "" then
		clone.Frame.TextLabel.Text = '[⭐]'..plr.Name
	end
	if plr.Name == "favswifty" then
		clone.Frame.TextLabel.Text = '[👑🛠]'..plr.Name
	end
	if plr.Name == "veccmii" then
		clone.Frame.TextLabel.Text = "[👑🛠]" ..plr.Name
	end
	if plr.Name == "JadenCapone" then
		clone.Frame.TextLabel.Text = "[👑🛠]" ..plr.Name
	end
	if plr.Name == "BadFunSeeker" then
		clone.Frame.TextLabel.Text = "[👑]" ..plr.Name
	end
end)

-- Hope this helped you :)
-- Made by EdiTheNoohsi1