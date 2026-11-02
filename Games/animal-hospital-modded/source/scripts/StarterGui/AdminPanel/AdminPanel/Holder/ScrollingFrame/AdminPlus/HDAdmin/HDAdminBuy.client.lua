--[[ Al hacer click/tap ofrece comprar HD Admin (rango Admin). ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")

local Lib = require(ReplicatedStorage:WaitForChild("Lib"))
local Prods = require(ReplicatedStorage.Data.Prods)
local LocalPlayer = game.Players.LocalPlayer

Lib.Buttons.OnActivate(script.Parent, function()
	MarketplaceService:PromptProductPurchase(LocalPlayer, Prods.hd_admin.id)
end)
