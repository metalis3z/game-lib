local MarketplaceService = game:GetService("MarketplaceService")
local TextChatService = game:GetService("TextChatService")

MarketplaceService.PromptGamePassPurchaseFinished:Connect(function(player, gamePassId, purchased)
	if not purchased then
		return
	end

	local success, info = pcall(function()
		return MarketplaceService:GetProductInfo(gamePassId, Enum.InfoType.GamePass)
	end)

	if not success or not info then
		warn("Impossible de récupérer les informations du Game Pass.")
		return
	end

	local channel = TextChatService.TextChannels:FindFirstChild("RBXGeneral")
	if not channel then
		return
	end

	local message = string.format(
		"❤️ %s purchased '%s' for %d R$",
		player.Name,
		info.Name,
		info.PriceInRobux or 0
	)

	channel:DisplaySystemMessage(message)
end)