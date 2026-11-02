local module = function(Conch, Config)
	Conch.register("clearbase", {
		permissions = { Config.RequiredRole or "limited-commands" },
		arguments = function()
			return 
		end,
		callback = function()
			local ctx = Conch.get_command_context()
			local player = ctx and ctx.executor and ctx.executor.player
			if not player then return "No player found" end
			
			local Synchronizer = require(game.ReplicatedStorage.Packages.Synchronizer)
			local Data = Synchronizer:Get(player)
			if not Data then return "No data found" end
			
			local AnimalPodiums = Data:Get("AnimalPodiums") or {}
			local clearedCount = 0
			
			for PodiumIndex, PodiumData in pairs(AnimalPodiums) do
				if type(PodiumData) == "table" and PodiumData.Index then
					AnimalPodiums[PodiumIndex] = "Empty"
					clearedCount = clearedCount + 1
				end
			end
			
			Data:Set("AnimalPodiums", AnimalPodiums)
			Data:Set("AnimalAddedOrRemoved", true)
			
			return "cleared all brainrots"
		end,
	})
end

return module