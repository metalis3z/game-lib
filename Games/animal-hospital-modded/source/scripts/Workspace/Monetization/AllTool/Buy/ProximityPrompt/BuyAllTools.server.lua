--[[ AllTool — comprar TODAS las tools (DevProduct). Grant vía ProcessReceipt. ]]
local MarketplaceService = game:GetService("MarketplaceService")
local Prods = require(game.ReplicatedStorage.Data.Prods)
script.Parent.Triggered:Connect(function(player)
	MarketplaceService:PromptProductPurchase(player, Prods.all_tools.id)
end)
