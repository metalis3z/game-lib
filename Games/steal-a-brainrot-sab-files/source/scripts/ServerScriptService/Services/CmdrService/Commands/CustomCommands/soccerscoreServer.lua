local ServerScriptService = game:GetService("ServerScriptService")

return function(context, teamName: string)
	local LiveSoccerEventService = require(ServerScriptService.Services.LiveSoccerEventService)

	-- credits to nobody i dont know who maid thnis
	LiveSoccerEventService.StandaloneScore(teamName)

	return string.format(
		"GOAL! %s scored! Trait icon shown for 30 seconds. Brainrot spawned! (Standalone - does not modify the real board)",
		teamName
	)
end