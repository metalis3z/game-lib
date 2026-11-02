local id = "1192316880"

local mkps = game:GetService("MarketplaceService")


script.Parent.ProximityPrompt.Triggered:Connect(function(player)
	mkps:PromptProductPurchase(player, id)
end)