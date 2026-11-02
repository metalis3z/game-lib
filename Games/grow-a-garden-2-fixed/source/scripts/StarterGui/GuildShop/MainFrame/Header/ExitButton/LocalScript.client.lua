--credit to prince games studio
local GuiController = require(game.Players.LocalPlayer.PlayerScripts.Controllers.GuiController)

script.Parent.MouseButton1Click:Connect(function() --[[ Line: 5 | Upvalues: GuiController (copy) ]]
	GuiController:Close()
end)