--credit to leon games studio
local GuiController = require(game.Players.LocalPlayer.PlayerScripts.Controllers.GuiController)

game.Players.LocalPlayer:WaitForChild("PlayerGui")
script.Parent.MouseButton1Click:Connect(function() --[[ Line: 6 | Upvalues: GuiController (copy) ]]
	if not GuiController:IsOpen("GearShop") then
		return
	end

	GuiController:Close("GearShop")
end)