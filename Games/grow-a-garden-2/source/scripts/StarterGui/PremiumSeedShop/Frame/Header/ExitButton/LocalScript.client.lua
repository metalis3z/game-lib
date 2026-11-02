--credit to leon games studio
local GuiController = require(game.Players.LocalPlayer.PlayerScripts.Controllers.GuiController)

game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("SeedShop")
script.Parent.MouseButton1Click:Connect(function() --[[ Line: 7 | Upvalues: GuiController (copy) ]]
	if not GuiController:IsOpen("SeedShop") then
		return
	end

	GuiController:Close("SeedShop")
end)