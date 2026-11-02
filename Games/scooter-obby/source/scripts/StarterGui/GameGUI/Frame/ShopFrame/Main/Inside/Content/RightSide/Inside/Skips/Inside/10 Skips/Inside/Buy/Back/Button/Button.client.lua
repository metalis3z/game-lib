local Player = game:GetService('Players').LocalPlayer
local MarketplaceService = game:GetService('MarketplaceService')

script.Parent.MouseButton1Click:Connect(function()
	MarketplaceService:PromptProductPurchase(Player,1684487957)
end)