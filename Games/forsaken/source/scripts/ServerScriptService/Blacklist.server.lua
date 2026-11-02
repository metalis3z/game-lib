local Players = game:GetService("Players")

local BlacklistUsers = {
	[5105334818] = "Skibidi toilet",
	[8361416157] = "Skibidi rizzler",
	[417308417] = "Skibidi sigma",
	[3175253096] = "Posting inapropriet content",
}

local BlacklistGroups = {
	[35949831] = "very bad group",
	[35947750] = "Being a part of a condo group",
	[15699736] = "very very bad group",
}

local function onPlayerAdded(player)
	local userReason = BlacklistUsers[player.UserId]
	if userReason then
		player:Kick("\n[ACCESS DENIED]\nReason: " .. userReason)
		return
	end

	for groupId, groupReason in pairs(BlacklistGroups) do
		local success, isInGroup = pcall(function()
			return player:IsInGroup(groupId)
		end)

		if success and isInGroup then
			player:Kick("\n[ACCESS DENIED]\nReason: " .. groupReason)
			return
		end
	end
end

Players.PlayerAdded:Connect(onPlayerAdded)
for _, player in ipairs(Players:GetPlayers()) do
	onPlayerAdded(player)
end