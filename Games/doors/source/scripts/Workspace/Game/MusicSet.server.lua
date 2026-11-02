script.Parent:GetAttributeChangedSignal("GameTimer"):Connect(function()
	if script.Parent:GetAttribute("GameStart") == true then
		if script.Parent:GetAttribute("GameTimer") < 31 then
			game.Workspace.Game:SetAttribute("CanLeverSpawn", true)
		else
			game.Workspace.Game:SetAttribute("CanLeverSpawn", false)
		end
	end
end)

script.Parent:GetAttributeChangedSignal("Ambience"):Connect(function()
	if script.Parent:GetAttribute("GameStart") == true then
		if script.Parent:GetAttribute("Ambience") == 0 then
			game.Workspace.Hunt_AmbienceStart:Play()
			game.Workspace.Hunt_AmbienceStart.TimePosition = script.Parent:GetAttribute("Ambience")
		end
	end
end)

game.ReplicatedStorage.EntityInfo.HuntEnd.OnServerEvent:Connect(function()
	game.Workspace.Game:SetAttribute("StopTimer", true)
	
	for i, v in pairs(game.Players:GetPlayers()) do
		local module = require(game.ReplicatedStorage.ClientModules.Module_AdminPanel)

		if not module:haveAccess(v) and v.PlayerStats.AdminPanel.Value == true then
			if not game:GetService("BadgeService"):UserHasBadgeAsync(v.UserId, 9296652267332) then
				game.ReplicatedStorage.EntityInfo.AchievementUnlock:FireClient(v, "EscapeBackdoor")
				game:GetService("BadgeService"):AwardBadge(v.UserId, 9296652267332)
			end
		end
	end
end)