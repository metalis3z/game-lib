local button = script.Parent

button.MouseButton1Up:Connect(function()
	
	script.Parent.ClickSound:Play()
	game:GetService("MarketplaceService"):PromptGamePassPurchase(game.Players.LocalPlayer, 0)
	
end)