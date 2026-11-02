local badgeService = game:GetService("BadgeService")
local BloodId = 2124740410
local NightmareId = 2124740434
local ShadowId = 2124740436
local MikeId = 2124740435

workspace.Values.BadgeAwards.AwardBloodBadge.Changed:Connect(function()
	if workspace.Values.BadgeAwards.AwardBloodBadge.Value == true then
		local Players = game.Players:GetPlayers()
		for i = 1, #Players do
			local Player = Players[i]
			if not badgeService:UserHasBadgeAsync(Player.UserId, BloodId) then
				badgeService:AwardBadge(Player.UserId, BloodId)
			end
		end
	end
end)

workspace.Values.BadgeAwards.AwardNightmareBadge.Changed:Connect(function()
	if workspace.Values.BadgeAwards.AwardNightmareBadge.Value == true then
		local Players = game.Players:GetPlayers()
		for i = 1, #Players do
			local Player = Players[i]
			if not badgeService:UserHasBadgeAsync(Player.UserId, NightmareId) then
				badgeService:AwardBadge(Player.UserId, NightmareId)
			end
		end
	end
end)

workspace.Values.BadgeAwards.AwardShadowBadge.Changed:Connect(function()
	if workspace.Values.BadgeAwards.AwardShadowBadge.Value == true then
		local Players = game.Players:GetPlayers()
		for i = 1, #Players do
			local Player = Players[i]
			if not badgeService:UserHasBadgeAsync(Player.UserId, ShadowId) then
				badgeService:AwardBadge(Player.UserId, ShadowId)
			end
		end
	end
end)

workspace.Values.BadgeAwards.AwardMikeBadge.Changed:Connect(function()
	if workspace.Values.BadgeAwards.AwardMikeBadge.Value == true then
		local Players = game.Players:GetPlayers()
		for i = 1, #Players do
			local Player = Players[i]
			if not badgeService:UserHasBadgeAsync(Player.UserId, MikeId) then
				badgeService:AwardBadge(Player.UserId, MikeId)
			end
		end
	end
end)