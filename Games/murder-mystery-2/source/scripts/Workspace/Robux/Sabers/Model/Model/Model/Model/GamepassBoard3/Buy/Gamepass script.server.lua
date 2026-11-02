local IDOfGamepass = 13155044508 --Change the ID to your ID --New 12138824113 -- OLD 13155044508
local Player = game.Players.LocalPlayer

script.Parent.ClickDetector.MouseClick:Connect(function(Player)
	game:GetService("MarketplaceService"):PromptPurchase(Player, IDOfGamepass)
end)
