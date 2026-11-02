--This script says the Developer Product's id.
local productId = 3324422106
local player = game.Players.LocalPlayer

script.Parent.MouseButton1Click:connect(function() --DONT CHANGE THIS
	Game:GetService("MarketplaceService"):PromptProductPurchase(player, productId)
end)