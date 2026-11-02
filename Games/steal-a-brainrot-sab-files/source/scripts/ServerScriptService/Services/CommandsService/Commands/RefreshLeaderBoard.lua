local module = function(Conch, Config)
	Conch.register("refreshleaderboard", {
		permissions = { Config.RequiredRole or "limited-commands" },
		arguments = function()
			return 
		end,
		callback = function()
			local ServerScriptService = game:GetService("ServerScriptService")
			local LeaderboardService = require(ServerScriptService.Services.LeaderboardService)
			
			local results = LeaderboardService:ForceRefresh()
			
			local generationCount = results["Generation"] or 0
			local stealsCount = results["Steals"] or 0
			
			return string.format("Refreshed leaderboards: Generation (%d players), Steals (%d players)", generationCount, stealsCount)
		end,
	})
end

return module