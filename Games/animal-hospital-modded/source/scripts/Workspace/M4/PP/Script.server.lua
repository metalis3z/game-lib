--[[ M4 prop — comprar el rifle (DevProduct, permanente, 500 balas).
     El grant lo hace GunService.ProcessReceipt -> GunService:BuyM4(player).
     A diferencia de la pistola comun, este SE PERSISTE en el perfil: si se
     te acaban las balas lo perdes para siempre, pero si te salis con balas
     restantes lo seguis teniendo al volver a entrar. Se puede comprar mas
     de uno (cada compra da un M4 nuevo con su propia municion). ]]
local MarketplaceService = game:GetService("MarketplaceService")
local Prods = require(game.ReplicatedStorage.Data.Prods)
local prompt = script.Parent

prompt.Triggered:Connect(function(player)
	MarketplaceService:PromptProductPurchase(player, Prods.m4.id)
end)
