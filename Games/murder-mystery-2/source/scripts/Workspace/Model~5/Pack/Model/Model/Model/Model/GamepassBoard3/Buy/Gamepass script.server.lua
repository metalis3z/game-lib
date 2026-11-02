local IDOfGamepass = 14835181351 --Change the ID to your ID -- 14598528440
local Player = game.Players.LocalPlayer

script.Parent.ClickDetector.MouseClick:Connect(function(Player)
	game:GetService("MarketplaceService"):PromptPurchase(Player, IDOfGamepass)
end)
