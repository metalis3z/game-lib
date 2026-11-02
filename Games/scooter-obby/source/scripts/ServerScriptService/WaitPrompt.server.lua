script.Prompt.Event:Connect(function(player, id)
	wait(3)
	game:GetService("MarketplaceService"):PromptPurchase(player, id)
end)