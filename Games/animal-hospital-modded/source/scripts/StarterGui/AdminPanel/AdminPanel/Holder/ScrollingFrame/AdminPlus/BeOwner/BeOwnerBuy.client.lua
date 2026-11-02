--[[ Al hacer click/tap ofrece comprar BeOwner (rango Owner). ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")

local Lib = require(ReplicatedStorage:WaitForChild("Lib"))
local Prods = require(ReplicatedStorage.Data.Prods)
local LocalPlayer = game.Players.LocalPlayer

Lib.Buttons.OnActivate(script.Parent, function()
	MarketplaceService:PromptProductPurchase(LocalPlayer, Prods.be_owner.id)
end)
