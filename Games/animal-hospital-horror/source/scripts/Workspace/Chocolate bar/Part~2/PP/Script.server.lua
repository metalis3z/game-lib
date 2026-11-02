--[[ Chocolate bar — comprar chocolate (DevProduct). El grant lo hace
     GunService.ProcessReceipt -> ConsumableService:Give(player,"Chocolate"). ]]
local MarketplaceService = game:GetService("MarketplaceService")
local Prods = require(game.ReplicatedStorage.Data.Prods)
local prompt = script.Parent

prompt.Triggered:Connect(function(player)
	MarketplaceService:PromptProductPurchase(player, Prods.chocolate.id)
end)
