local module = function(Conch, Config)
	Conch.register("globalskipfusiontimer", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return {}
		end,
		callback = function()
			local Synchronizer = require(game:GetService("ReplicatedStorage").Packages.Synchronizer)
			local ForceUpdate = require(game:GetService("ReplicatedStorage").Datas.FuseMachineData).Remotes.ForceUpdate
			local Players = game:GetService("Players")
			local CurrentTime = workspace:GetServerTimeNow()

			for _, player in Players:GetPlayers() do
				local Data = Synchronizer:Wait(player, 5)
				if Data then
					local FuseMachine = Data:Get("FuseMachine")
					if FuseMachine and FuseMachine.StartTime and FuseMachine.StartTime ~= 0 then
						Data:Set("FuseMachine.FinishTime", CurrentTime)
						Data:Set("FuseMachine.StartTime", CurrentTime - 1)

						local Podiums = Data:Get("AnimalPodiums") or {}
						for PodiumIndex, PodiumData in Podiums do
							if type(PodiumData) == "table" and PodiumData.Machine and PodiumData.Machine.Type == "Fuse" then
								PodiumData.Machine.FinishTime = CurrentTime
								PodiumData.Machine.Active = true
								Podiums[PodiumIndex] = PodiumData
							end
						end
						Data:Set("AnimalPodiums", Podiums)
						Data:Set("AnimalAddedOrRemoved", CurrentTime)
						ForceUpdate:FireClient(player)
					end
				end
			end

			return true, "Sammy Skipped fuse timer for all players"
		end,
	})
end
return module