--credit to quartz games studio
local GuiController = require(game.Players.LocalPlayer.PlayerScripts.Controllers.GuiController)

game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("CrateShop")
script.Parent.MouseButton1Click:Connect(function() --[[ Line: 7 | Upvalues: GuiController (copy) ]]
	if not GuiController:IsOpen("CrateShop") then
		return
	end

	GuiController:Close("CrateShop")
end)