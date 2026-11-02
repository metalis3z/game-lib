script.Parent.Touched:Connect(function(part)
	if part.Parent:FindFirstChild("Humanoid") then
		local player = game.Players:GetPlayerFromCharacter(part.Parent)
		if not game:GetService("BadgeService"):UserHasBadgeAsync(player.UserId, 2144310351) then
			game.ReplicatedStorage.Achievement:FireClient(player, "Welcome", "Enjoy your stay!", "Join for the first time.", "rbxassetid://13182539759")
			game:GetService("BadgeService"):AwardBadge(player.UserId, 2144310351)
		else
			return
		end
	end
end)