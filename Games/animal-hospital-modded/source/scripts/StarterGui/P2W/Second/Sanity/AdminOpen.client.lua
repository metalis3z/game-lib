--[[ AdminOpen — al presionar el botón Admin, compra el DevProduct de cordura
     infinita (Data.Prods.infinite_sanity) por el resto de la sesión. ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")

local Lib = require(ReplicatedStorage:WaitForChild("Lib"))
local Prods = require(ReplicatedStorage.Data.Prods)
local LocalPlayer = game.Players.LocalPlayer

Lib.Buttons.OnActivate(script.Parent, function()
	MarketplaceService:PromptProductPurchase(LocalPlayer, Prods.infinite_sanity.id)
end)
