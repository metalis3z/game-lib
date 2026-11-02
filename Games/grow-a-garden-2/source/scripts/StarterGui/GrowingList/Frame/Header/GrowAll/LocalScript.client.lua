--credit to leon games studio
local DevProductController = require(game.Players.LocalPlayer.PlayerScripts.Controllers.DevProductController)

game:GetService("MarketplaceService")

local TextLabel = script.Parent.TextLabel
local TextLabel2 = TextLabel.TextLabel

TextLabel.Text = "Grow All"
TextLabel2.Text = "Grow All"

local v1 = DevProductController:WaitForPreloadedProductInfo("Standalone:Grow All:1", 5)

if v1 then
	local v2 = tostring(v1.PriceInRobux) .. "\238\128\130"

	script.Parent.MouseEnter:Connect(function() --[[ Line: 22 | Upvalues: TextLabel (copy), v2 (copy), TextLabel2 (copy) ]]
		TextLabel.Text = v2
		TextLabel2.Text = v2
	end)
	script.Parent.MouseLeave:Connect(function() --[[ Line: 26 | Upvalues: TextLabel (copy), TextLabel2 (copy) ]]
		TextLabel.Text = "Grow All"
		TextLabel2.Text = "Grow All"
	end)
	script.Parent.MouseButton1Up:Connect(function() --[[ Line: 30 | Upvalues: TextLabel (copy), TextLabel2 (copy) ]]
		TextLabel.Text = "Grow All"
		TextLabel2.Text = "Grow All"
	end)
else
	require(game.ReplicatedStorage.SharedModules.DevProducts)
end

script.Parent.MouseButton1Click:Connect(function() --[[ Line: 36 | Upvalues: DevProductController (copy) ]]
	DevProductController:PromptPurchase("Standalone:Grow All:1")
end)