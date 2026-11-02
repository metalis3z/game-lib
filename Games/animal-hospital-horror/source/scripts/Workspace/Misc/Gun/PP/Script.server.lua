--[[ Gun prop — comprar el arma (DevProduct). El grant lo hace
     GunService.ProcessReceipt -> GunService:GiveGun(player). ]]
local MarketplaceService = game:GetService("MarketplaceService")
local Prods = require(game.ReplicatedStorage.Data.Prods)
local prompt = script.Parent

prompt.Triggered:Connect(function(player)
	MarketplaceService:PromptProductPurchase(player, Prods.gun.id)
end)
