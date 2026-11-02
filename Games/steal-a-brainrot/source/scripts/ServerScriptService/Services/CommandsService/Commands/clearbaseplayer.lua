local module = function(Conch, Config)
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)

	Conch.register("clearbaseplayer", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return {
				kind = "argument",
				type = "player",
				name = "Target Player",
			}
		end,
		callback = function(targetPlayer)
			if not targetPlayer then 
				return false, "Player not found" 
			end
			
			local data = Synchronizer:Get(targetPlayer)
			if not data then 
				return false, "Data not found for " .. targetPlayer.Name 
			end
			
			local animalPodiums = data:Get("AnimalPodiums") or {}
			local clearedCount = 0
			
			for index, podiumData in pairs(animalPodiums) do
				if type(podiumData) == "table" and podiumData.Index then
					animalPodiums[index] = "Empty"
					clearedCount = clearedCount + 1
				end
			end
			
			if clearedCount == 0 then
				return "Base already empty for " .. targetPlayer.Name
			end
			
			data:Set("AnimalPodiums", animalPodiums)
			data:Set("AnimalAddedOrRemoved", true)
			
			return "Cleared " .. clearedCount .. " brainrots from " .. targetPlayer.Name .. "'s base"
		end,
	})
end

return module