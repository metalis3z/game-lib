--[[ AdminOpen — al presionar el botón Admin abre el AdminPanel SI el jugador
     compró el DevProduct (atributo OwnsAdminPanel). Si no, ofrece la compra. ]]
--[[ AdminOpen — al presionar el botón Admin abre el AdminPanel SI el jugador
     compró el DevProduct (atributo OwnsAdminPanel). Si no, ofrece la compra. ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")

local Lib = require(ReplicatedStorage:WaitForChild("Lib"))
local Prods = require(ReplicatedStorage.Data.Prods)
local LocalPlayer = game.Players.LocalPlayer

Lib.Buttons.OnActivate(script.Parent, function()
	if LocalPlayer:GetAttribute("OwnsAdminPanel") then
		local gui = LocalPlayer.PlayerGui:WaitForChild("AdminPanel")
		Lib.Buttons.ChangeVisibility(gui:WaitForChild("AdminPanel"))
	else
		MarketplaceService:PromptProductPurchase(LocalPlayer, Prods.adminpanel.id)
	end
end)
