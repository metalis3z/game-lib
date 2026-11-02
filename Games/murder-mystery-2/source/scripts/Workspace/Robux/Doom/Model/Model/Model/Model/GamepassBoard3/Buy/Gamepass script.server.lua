local IDOfGamepass = 14075293413 --Change the ID to your ID
local Player = game.Players.LocalPlayer

script.Parent.ClickDetector.MouseClick:Connect(function(Player)
	game:GetService("MarketplaceService"):PromptPurchase(Player, IDOfGamepass)
end)
