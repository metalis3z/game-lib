local module = function(Conch, Config)
	Conch.register("globalskipcraftingtimer", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return {}
		end,
		callback = function()
			local Synchronizer = require(game:GetService("ReplicatedStorage").Packages.Synchronizer)
			local Players = game:GetService("Players")
			local NotificationService = require(game:GetService("ServerScriptService").Services.NotificationService)
			local currentTime = workspace:GetServerTimeNow()

			for _, player in Players:GetPlayers() do
				local Data = Synchronizer:Get(player)
				if Data then
					local crafting = Data:Get("CraftingMachine")
					if crafting and crafting.StartTime and crafting.StartTime ~= 0 and currentTime < crafting.FinishTime then
						Data:Set("CraftingMachine.FinishTime", currentTime)
						local podiums = Data:Get("AnimalPodiums") or {}
						for i, podium in podiums do
							if type(podium) == "table" and podium.Machine and podium.Machine.Type == "Crafting" then
								podium.Machine.FinishTime = currentTime
								podiums[i] = podium
							end
						end
						Data:Set("AnimalPodiums", podiums)
						Data:Set("AnimalAddedOrRemoved", currentTime)
						NotificationService.Notify(
							player,
							string.format('Sammy skipped the Crafting Machine timer!'),
							5,
							"Sounds.Sfx.Success"
						)
					end
				end
			end

			return true, "Skipped crafting timer for all players"
		end,
	})
end
return module