local gamepassId = 261748517
local marketplaceService = game:GetService("MarketplaceService")
local button = script.Parent
local player = game.Players.LocalPlayer

button.MouseButton1Up:Connect(function()
	
	script.Parent.ClickSound:Play() 
	marketplaceService:PromptGamePassPurchase(player, gamepassId)
	
end)