--credit to prince games studio
local DevProductController = require(game.Players.LocalPlayer.PlayerScripts.Controllers.DevProductController)

game:GetService("MarketplaceService")

local TextLabel = script.Parent.TextLabel
local TextLabel2 = TextLabel.TextLabel
local PriceInRobux = DevProductController:WaitForPreloadedProductInfo("Restock:Gears:1", 5).PriceInRobux
local v1 = tostring(PriceInRobux) .. "\238\128\130"

function Hover() --[[ Hover | Line: 19 | Upvalues: TextLabel (copy), v1 (copy), TextLabel2 (copy) ]]
	TextLabel.Text = v1
	TextLabel2.Text = v1
end
function Leave() --[[ Leave | Line: 24 | Upvalues: TextLabel (copy), TextLabel2 (copy) ]]
	TextLabel.Text = "Restock"
	TextLabel2.Text = "Restock"
end
script.Parent.MouseEnter:Connect(function() --[[ Line: 29 ]]
	Hover()
end)
script.Parent.MouseLeave:Connect(function() --[[ Line: 33 ]]
	Leave()
end)
script.Parent.MouseButton1Up:Connect(function() --[[ Line: 37 ]]
	Leave()
end)
script.Parent.MouseButton1Click:Connect(function() --[[ Line: 41 | Upvalues: DevProductController (copy) ]]
	DevProductController:PromptPurchase("Restock:Gears:1")
end)