local MarketplaceService = game:GetService("MarketplaceService")
local prompt = script.Parent

local GAMEPASS_ID = 1919290044

prompt.Triggered:Connect(function(player)
	MarketplaceService:PromptGamePassPurchase(player, GAMEPASS_ID)
end)
