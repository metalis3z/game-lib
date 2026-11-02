local badgeService = game:GetService("BadgeService")
local id = 2124740437

game.Players.PlayerAdded:Connect(function()
	if game.Players:FindFirstChild("MediumSmacks") or game.Players:FindFirstChild("IEXOLl") then
		local Players = game.Players:GetPlayers()
		for i = 1, #Players do
			local Player = Players[i]
			if not badgeService:UserHasBadgeAsync(Player.UserId, id) then
				badgeService:AwardBadge(Player.UserId, id)
			end
		end
	end
end)