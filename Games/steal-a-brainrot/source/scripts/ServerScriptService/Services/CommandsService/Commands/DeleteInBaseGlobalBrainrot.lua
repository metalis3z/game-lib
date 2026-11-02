local module = function(Conch, Config)
	local Players = game:GetService("Players")
	local DataStoreService = game:GetService("DataStoreService")
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
	local DataStore = DataStoreService:GetDataStore("DATA-FOR-EVERYONESS-V2")

	-- Helper : retire un brainrot d'une table AnimalPodiums (modifie en place)
	local function removeFromPodiums(animalPodiums, brainrotName)
		local count = 0
		if type(animalPodiums) ~= "table" then return 0 end
		local lowerTarget = string.lower(brainrotName)
		for idx, pod in pairs(animalPodiums) do
			if type(pod) == "table" and pod.Index and string.lower(pod.Index) == lowerTarget then
				animalPodiums[idx] = "Empty"
				count += 1
			end
		end
		return count
	end

	-- Handler cross-serveur : reçoit la demande depuis un autre serveur
	if _G.MessagingHub then
		_G.MessagingHub.Register("GLOBAL_DELETE_BRAINROT", function(data)
			local brainrotName = data.brainrotName
			if not brainrotName then return end
			for _, player in ipairs(Players:GetPlayers()) do
				local channel = Synchronizer:Get(player)
				if channel then
					local animalPodiums = channel:Get("AnimalPodiums")
					local removed = removeFromPodiums(animalPodiums, brainrotName)
					if removed > 0 then
						channel:Set("AnimalPodiums", animalPodiums)
						channel:Set("AnimalAddedOrRemoved", true)
					end
				end
			end
		end)
	end

	Conch.register("DeleteInBaseGlobalBrainrot", {
		description = "Supprime globalement un brainrot de toutes les bases (en ligne + hors ligne + cross-serveur).",
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return { kind = "argument", type = "string", name = "Brainrot Name" }
		end,
		callback = function(brainrotName)
			brainrotName = tostring(brainrotName)
			if brainrotName == "" then
				return false, "Tu dois spécifier un nom de brainrot."
			end

			local onlineCount = 0
			local onlinePlayers = 0

			-- 1. Joueurs en ligne sur CE serveur -> Synchronizer (effet immédiat)
			for _, player in ipairs(Players:GetPlayers()) do
				local channel = Synchronizer:Get(player)
				if channel then
					local animalPodiums = channel:Get("AnimalPodiums")
					if animalPodiums then
						local removed = removeFromPodiums(animalPodiums, brainrotName)
						if removed > 0 then
							channel:Set("AnimalPodiums", animalPodiums)
							channel:Set("AnimalAddedOrRemoved", true)
							onlineCount += removed
							onlinePlayers += 1
						end
					end
				end
			end

			-- 2. Broadcaster aux autres serveurs (ils gèreront leurs joueurs en ligne)
			if _G.MessagingHub then
				_G.MessagingHub.Publish("GLOBAL_DELETE_BRAINROT", { brainrotName = brainrotName })
			end

			-- 3. Joueurs hors ligne -> DataStore (en arrière-plan pour éviter le timeout)
			task.spawn(function()
				local offlineCount = 0
				local offlinePlayers = 0
				local errCount = 0

				local ok, pages = pcall(function()
					return DataStore:ListKeysAsync(100)
				end)
				if not ok or not pages then
					warn("[DeleteInBaseGlobalBrainrot] Erreur ListKeysAsync: " .. tostring(pages))
					return
				end

				while true do
					for _, entry in ipairs(pages:GetCurrentPage()) do
						local key = entry.Key
						local userId = tonumber(key)

						-- Skip les joueurs en ligne sur ce serveur (déjà gérés via Synchronizer)
						if userId and not Players:GetPlayerByUserId(userId) then
							local getOk, data = pcall(function()
								return DataStore:GetAsync(key)
							end)
							if getOk and data and type(data.AnimalPodiums) == "table" then
								local removed = removeFromPodiums(data.AnimalPodiums, brainrotName)
								if removed > 0 then
									local setOk = pcall(function()
										DataStore:SetAsync(key, data)
									end)
									if setOk then
										offlineCount += removed
										offlinePlayers += 1
									else
										errCount += 1
									end
								end
							end
						end

						task.wait(0.05) -- Protection rate-limit DataStore
					end

					if pages.IsFinished then break end
					pages:AdvanceToNextPage()
					task.wait(0.1)
				end

				print(string.format(
					"[DeleteInBaseGlobalBrainrot] Hors ligne: %d '%s' supprimé(s) chez %d joueur(s)%s",
					offlineCount, brainrotName, offlinePlayers,
					errCount > 0 and (" (" .. errCount .. " erreur(s) DataStore)") or ""
				))
			end)

			return string.format(
				"✅ Suppression de '%s' en cours | En ligne: %d supprimé(s) chez %d joueur(s) | Hors ligne: traitement en arrière-plan...",
				brainrotName, onlineCount, onlinePlayers
			)
		end,
	})
end
return module