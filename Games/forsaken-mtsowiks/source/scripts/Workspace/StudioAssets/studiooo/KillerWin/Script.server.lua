local Round = require(game.ServerScriptService.Server.Systems.Core.RoundManager)
script.Parent.ProximityPrompt.Triggered:Connect(function()
	workspace.Misc:ClearAllChildren()
	local _, result = Round:WinnerCutscene("Killers")
	if not result then
		script.Parent.no:Play()
	end
end)