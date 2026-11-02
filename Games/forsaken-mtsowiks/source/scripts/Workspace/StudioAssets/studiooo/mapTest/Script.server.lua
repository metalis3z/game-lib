script.Parent.ProximityPrompt.Triggered:Connect(function(Player)
	local roundManager = require(game.ServerScriptService.Server.Systems.Core.RoundManager);
	if roundManager.IntermissionTimePast then
		roundManager.IntermissionTimePast = roundManager.IntermissionTimePast + 99999
	end
end)