script.Parent.ProximityPrompt.Triggered:Connect(function(Player)
	if (Player:IsInGroup(33159644) or game:FindService('MarketplaceService'):UserOwnsGamePassAsync(Player.UserId, 800059564) or game:FindService('MarketplaceService'):UserOwnsGamePassAsync(Player.UserId, 780822224)) and Player.Team == game.Teams.PD then
		if Player.PlayerGui:FindFirstChild('Locker') then return end
		if Player:IsInGroup(33159644) and Player:GetRankInGroup(33159644) == 1 then return end
		local Clone = script:FindFirstChild('Locker'):Clone()
		Clone.Parent = Player.PlayerGui
		Clone.Frame.Handler.Enabled = true
	else
		game:FindService('ReplicatedStorage'):FindFirstChild('Notify'):FireClient(Player, 'You arent a Police Officer', 3)
	end
end)