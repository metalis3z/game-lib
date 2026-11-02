
local player = game.Players.LocalPlayer

function onClick() 
local bloxyColaId = script.Parent.Parent.ID.Value
wait()
game:GetService("MarketplaceService"):PromptPurchase(player, bloxyColaId) 
end

script.Parent.MouseButton1Click:connect(onClick)