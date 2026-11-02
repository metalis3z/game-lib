local gamepassId = 1668829119
local marketplaceService = game:GetService("MarketplaceService")
local button = script.Parent
local player = game.Players.LocalPlayer

button.MouseButton1Up:Connect(function()
	
	script.Parent.ClickSound:Play() 
	marketplaceService:PromptProductPurchase(player, gamepassId)
	
end)