--credit to quartz games studio
local DevProductController = require(game.Players.LocalPlayer.PlayerScripts.Controllers.DevProductController)

game:GetService("MarketplaceService")

local TextLabel = script.Parent.TextLabel
local TextLabel2 = TextLabel.TextLabel

TextLabel.Text = "Refund"
TextLabel2.Text = "Refund"

local v1 = DevProductController:WaitForPreloadedProductInfo("RefundPoints:Refund Points:1", 5)

if v1 then
	local v2 = tostring(v1.PriceInRobux) .. "\238\128\130"

	script.Parent.MouseEnter:Connect(function() --[[ Line: 19 | Upvalues: TextLabel (copy), v2 (copy), TextLabel2 (copy) ]]
		TextLabel.Text = v2
		TextLabel2.Text = v2
	end)
	script.Parent.MouseLeave:Connect(function() --[[ Line: 23 | Upvalues: TextLabel (copy), TextLabel2 (copy) ]]
		TextLabel.Text = "Refund"
		TextLabel2.Text = "Refund"
	end)
	script.Parent.MouseButton1Up:Connect(function() --[[ Line: 27 | Upvalues: TextLabel (copy), TextLabel2 (copy) ]]
		TextLabel.Text = "Refund"
		TextLabel2.Text = "Refund"
	end)
else
	require(game.ReplicatedStorage.SharedModules.DevProducts)
end

script.Parent.MouseButton1Click:Connect(function() --[[ Line: 33 | Upvalues: DevProductController (copy) ]]
	DevProductController:PromptPurchase("RefundPoints:Refund Points:1")
end)