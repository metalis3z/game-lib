local MarketplaceService = game:GetService("MarketplaceService")

local Net = require(game.ReplicatedStorage.Packages.Net)
local NotificationEvent = Net:RemoteEvent("NotificationService/Notify")

local GAMEPASS_ID = 1903134525

MarketplaceService.PromptGamePassPurchaseFinished:Connect(function(player, gamePassId, wasPurchased)
	if gamePassId == GAMEPASS_ID and wasPurchased then
		NotificationEvent:FireClient(
			player,
			"🎉 Merci pour votre achat du Brainrot Spawn Tapis !",
			5,
			nil,
			"Top"
		)
	end
end)