--credit to prince games studio
local GuiController = require(game.Players.LocalPlayer.PlayerScripts.Controllers.GuiController)

script.Parent.MouseButton1Click:Connect(function() --[[ Line: 3 | Upvalues: GuiController (copy) ]]
	GuiController:Close("Odds")
	GuiController:Open("CrateShop", nil, { "HUD" })
end)