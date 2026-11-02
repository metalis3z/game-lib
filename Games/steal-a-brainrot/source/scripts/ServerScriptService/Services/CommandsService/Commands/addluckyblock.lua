local module = function(Conch, Config)
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local ServerScriptService = game:GetService("ServerScriptService")
	local Players = game:GetService("Players")

	local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
	local PlotService = require(ServerScriptService.Services.PlotService)
	local AnimalsData = require(ReplicatedStorage.Datas.Animals)
	local MutationsData = require(ReplicatedStorage.Datas.Mutations)
	local LuckyBlocksData = require(ReplicatedStorage.Datas.LuckyBlocks)
	local NotificationService = require(ServerScriptService.Services.NotificationService)

	Conch.register("addluckyblock", {
		permissions = { Config.RequiredRole or "super-user" },

		arguments = function()
			return
				{ kind = "argument", type = "player",     name = "Player" },
				{ kind = "argument", type = "LuckyBlock",  name = "Lucky Block" },
				{ kind = "argument", type = "Mutation",    name = "Mutation", optional = true },
				{ kind = "argument", type = "number",      name = "Amount",   optional = true }
		end,

		callback = function(targetPlayer, luckyBlockName, mutation, amount)
			if typeof(targetPlayer) ~= "Instance" or not targetPlayer:IsA("Player") then
				return false, "Joueur invalide."
			end

			local spawnAmount = math.max(1, tonumber(amount) or 1)

			-- Vérifier que le lucky block existe
			local animalData = AnimalsData[luckyBlockName]
			if not animalData then
				return false, "Lucky Block '" .. tostring(luckyBlockName) .. "' introuvable."
			end

			-- Vérifier la mutation
			local cleanMutation = nil
			if mutation and mutation ~= "" and mutation ~= "Normal" then
				if MutationsData[mutation] then
					cleanMutation = mutation
				end
			end

			-- Placer directement via Synchronizer:Get (non-bloquant)
			local playerChannel = Synchronizer:Get(targetPlayer)
			if not playerChannel then
				return false, "Channel joueur introuvable."
			end

			local placed = 0
			for i = 1, spawnAmount do
				local freePodium = PlotService.getFreePodium(targetPlayer)
				if not freePodium then
					break -- base pleine
				end

				local podiumIndex = tonumber(freePodium.Name)
				if not podiumIndex then continue end

				local AnimalPodiums = playerChannel:Get("AnimalPodiums") or {}
				AnimalPodiums[podiumIndex] = {
					Index       = luckyBlockName,
					LastCollect = os.time(),
					Mutation    = cleanMutation,
					Traits      = nil,
					Timer       = LuckyBlocksData[luckyBlockName] and 0 or nil,
				}
				playerChannel:Set("AnimalPodiums", AnimalPodiums)
				placed += 1
			end

			playerChannel:Set("AnimalAddedOrRemoved", true)

			if placed == 0 then
				return false, "Base pleine pour " .. targetPlayer.Name
			end

			-- Notifier le joueur
			NotificationService.Success(targetPlayer,
				string.format("🎰 Tu as reçu <b>%d× %s</b>%s !",
					placed,
					luckyBlockName,
					cleanMutation and (" (<font color=\"#ffd13b\">" .. cleanMutation .. "</font>)") or ""))

			return string.format("✅ %d× %s ajouté à %s", placed, luckyBlockName, targetPlayer.Name)
		end
	})
end

return module
