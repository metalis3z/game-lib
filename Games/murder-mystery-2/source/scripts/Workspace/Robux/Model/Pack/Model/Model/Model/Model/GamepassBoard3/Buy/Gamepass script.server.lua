local IDOfGamepass = 14598528440 --Change the ID to your ID
local Player = game.Players.LocalPlayer

script.Parent.ClickDetector.MouseClick:Connect(function(Player)
	game:GetService("MarketplaceService"):PromptPurchase(Player, IDOfGamepass)
end)
