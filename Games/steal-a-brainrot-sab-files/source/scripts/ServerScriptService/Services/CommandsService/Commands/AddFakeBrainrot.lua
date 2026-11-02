local module = function(Conch, Config)
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local Players = game:GetService("Players")
	local ServerScriptService = game:GetService("ServerScriptService")

	local PlotService = require(ServerScriptService.Services.PlotService)
	local AnimalsData = require(ReplicatedStorage.Datas.Animals)
	local MutationsData = require(ReplicatedStorage.Datas.Mutations)
	local NotificationService = require(ServerScriptService.Services.NotificationService)
	local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)

	Conch.register("addfakebrainrot", {
		permissions = { Config.RequiredRole or "super-user" },

		arguments = function()
			return
				{
					kind = "argument",
					type = "player",
					name = "Player",
				},
				{
					kind = "argument",
					type = "Brainrot",
					name = "Brainrot",
				},
				{
					kind = "argument",
					type = "Mutation",
					name = "Mutation",
					optional = true
				}
		end,

		callback = function(targetPlayer, brainrotName, mutation)
			if typeof(targetPlayer) ~= "Instance" or not targetPlayer:IsA("Player") then
				return false, "Invalid player."
			end

			local animalData = AnimalsData[brainrotName]
			if not animalData then
				return false, "Brainrot '" .. tostring(brainrotName) .. "' not found."
			end

			local cleanMutation = nil
			if mutation and mutation ~= "" and mutation ~= "Default" and mutation ~= "Normal" then
				if not MutationsData[mutation] then
					return false, "Mutation '" .. tostring(mutation) .. "' not found."
				end
				cleanMutation = mutation
			end

			-- Récupérer un podium libre
			local Plot = PlotService.getPlot(targetPlayer)
			if not Plot then
				return false, "Player has no plot."
			end

			local PlayerChannel = Synchronizer:Get(targetPlayer)
			if not PlayerChannel then
				return false, "Player channel not found."
			end

			local AnimalPodiums = PlayerChannel:Get("AnimalPodiums") or {}
			local podiumIndex = nil

			-- Trouver un podium vide
			for _, podium in ipairs(Plot.AnimalPodiums:GetChildren()) do
				local index = tonumber(podium.Name)
				if index and (AnimalPodiums[index] == "Empty" or AnimalPodiums[index] == nil) then
					podiumIndex = index
					break
				end
			end

			if not podiumIndex then
				return false, "No free podium available."
			end

			-- Ajouter le faux brainrot avec le flag IsFake
			AnimalPodiums[podiumIndex] = {
				Index = brainrotName,
				LastCollect = os.time(),
				Mutation = cleanMutation,
				Traits = nil,
				IsFake = true,
			}

			PlayerChannel:Set("AnimalPodiums", AnimalPodiums)
			PlayerChannel:Set("AnimalAddedOrRemoved", workspace:GetServerTimeNow())

			return "Fake brainrot '" .. brainrotName .. "' added to " .. targetPlayer.Name .. "'s base!"
		end
	})
end

return module