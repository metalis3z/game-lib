MPS = game:GetService("MarketplaceService")
id = 1116189837 -- replace with your ID
local player = game.Players.LocalPlayer

script.Parent.MouseButton1Click:connect(function()
	MPS:PromptProductPurchase(player, id)
end)