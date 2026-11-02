-- AdminService.lua (ModuleScript dans ServerScriptService/Services/)

local AdminService = {}

local Players             = game:GetService("Players")
local ReplicatedStorage   = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local DataStoreService    = game:GetService("DataStoreService")
local MessagingService    = game:GetService("MessagingService")
local HttpService         = game:GetService("HttpService")

local Synchronizer  = require(ReplicatedStorage.Packages.Synchronizer)
local SharedAnimals = require(ReplicatedStorage.Shared.Animals)

-- ══════════════════════════════════════
-- ADMINS
-- ══════════════════════════════════════
local ADMIN_IDS = {
	[0] = true,
}

-- ══════════════════════════════════════
-- DataStores
-- ══════════════════════════════════════

-- Sauvegarde les AnimalPodiums de chaque joueur
-- Clé : "Player_" .. userId
local AnimalDataStore = DataStoreService:GetDataStore("AdminAnimalData_v1")

-- File d'attente pour les suppressions hors-ligne
-- Clé : "Pending_" .. userId  →  liste de podiumIndex à vider
local PendingDeleteStore = DataStoreService:GetDataStore("AdminPendingDeletes_v1")

-- ══════════════════════════════════════
-- Remotes
-- ══════════════════════════════════════
local AdminFolder = ReplicatedStorage:FindFirstChild("AdminRemotes")
if not AdminFolder then
	AdminFolder = Instance.new("Folder")
	AdminFolder.Name   = "AdminRemotes"
	AdminFolder.Parent = ReplicatedStorage
end

local function getOrCreate(className, name, parent)
	return parent:FindFirstChild(name) or (function()
		local o = Instance.new(className)
		o.Name   = name
		o.Parent = parent
		return o
	end)()
end

local GetPlayersByAnimalRemote = getOrCreate("RemoteFunction", "GetPlayersByAnimal",  AdminFolder)
local DeleteAnimalRemote       = getOrCreate("RemoteEvent",    "DeleteAnimal",         AdminFolder)
local DeleteAllSuspectsRemote  = getOrCreate("RemoteEvent",    "DeleteAllSuspects",    AdminFolder)

-- ══════════════════════════════════════
-- Constantes
-- ══════════════════════════════════════
local CHEAT_DPS_THRESHOLD = 10_000_000_000

-- Topics MessagingService
local TOPIC_SEARCH   = "AdminSearch_v1"    -- broadcast recherche
local TOPIC_RESPONSE = "AdminResponse_v1"  -- réponses des serveurs
local TOPIC_DELETE   = "AdminDelete_v1"    -- broadcast suppression

local JOB_ID = game.JobId  -- identifiant unique de CE serveur

-- ══════════════════════════════════════
-- Utilitaires
-- ══════════════════════════════════════
local function isAdmin(player: Player): boolean
	return ADMIN_IDS[player.UserId] == true
end

local function getAnimalDPS(index, mutation, traits, player): number
	local ok, result = pcall(SharedAnimals.GetGeneration, SharedAnimals, index, mutation, traits, player)
	if ok and type(result) == "number" then return result end
	return 0
end

local function isSuspect(dps: number): boolean
	return dps > CHEAT_DPS_THRESHOLD
end

local function trimName(s: string): string
	return s:gsub("^%s+", ""):gsub("%s+$", ""):lower()
end

-- ══════════════════════════════════════
-- Sauvegarde DataStore (appelé à chaque login/logoff)
-- ══════════════════════════════════════
local function savePlayerAnimals(player: Player)
	local ok, channel = pcall(Synchronizer.Get, Synchronizer, player)
	if not ok or not channel then return end

	local podiums = channel:Get("AnimalPodiums")
	if not podiums then return end

	local key = "Player_" .. player.UserId
	pcall(function()
		AnimalDataStore:SetAsync(key, {
			AnimalPodiums = podiums,
			PlayerName    = player.Name,
			UserId        = player.UserId,
			SavedAt       = os.time(),
		})
	end)
end

-- Charge et applique les suppressions en attente pour un joueur
local function applyPendingDeletes(player: Player)
	local key = "Pending_" .. player.UserId
	local ok, pending = pcall(AnimalDataStore.GetAsync, AnimalDataStore, key)
	if not ok or not pending or #pending == 0 then return end

	local chanOk, channel = pcall(Synchronizer.Get, Synchronizer, player)
	if not chanOk or not channel then return end

	local podiums  = channel:Get("AnimalPodiums") or {}
	local indexData = channel:Get("Index") or {}
	local changed  = false

	for _, podiumIndex in ipairs(pending) do
		local podium = podiums[podiumIndex]
		if podium and podium ~= "Empty" and type(podium) == "table" then
			-- Met à jour l'index de collection
			if podium.Index and indexData[podium.Index] then
				local mut     = podium.Mutation or "Default"
				local current = tonumber(indexData[podium.Index][mut]) or 0
				if current > 0 then
					indexData[podium.Index][mut] = current - 1
				end
			end
			-- Retire la génération
			local dps = getAnimalDPS(podium.Index, podium.Mutation, podium.Traits, player)
			channel:Increase("Generation", -dps)
			-- Vide le podium
			podiums[podiumIndex] = "Empty"
			changed = true
			print(string.format("[AdminService] Suppression différée appliquée : podium %d de %s", podiumIndex, player.Name))
		end
	end

	if changed then
		channel:Set("Index", indexData)
		channel:Set("AnimalPodiums", podiums)
		channel:Set("AnimalAddedOrRemoved", true)
	end

	-- Efface la liste en attente
	pcall(AnimalDataStore.RemoveAsync, AnimalDataStore, key)
end

-- ══════════════════════════════════════
-- Recherche locale (ce serveur uniquement)
-- ══════════════════════════════════════
local function searchLocalServer(animalName: string): {any}
	local nameLower = trimName(animalName)
	local results   = {}

	for _, player in ipairs(Players:GetPlayers()) do
		local ok, channel = pcall(Synchronizer.Get, Synchronizer, player)
		if not ok or not channel then continue end

		local podiums = channel:Get("AnimalPodiums")
		if not podiums or type(podiums) ~= "table" then continue end

		for podiumIndex, podiumData in pairs(podiums) do
			if podiumData == "Empty" or type(podiumData) ~= "table" then continue end
			if trimName(podiumData.Index or "") ~= nameLower then continue end

			local dps = getAnimalDPS(podiumData.Index, podiumData.Mutation, podiumData.Traits, player)
			table.insert(results, {
				playerName  = player.Name,
				userId      = player.UserId,
				podiumIndex = podiumIndex,
				index       = podiumData.Index,
				mutation    = podiumData.Mutation,
				traits      = podiumData.Traits,
				dps         = dps,
				suspect     = isSuspect(dps),
				online      = true,
				serverId    = JOB_ID,
			})
		end
	end

	return results
end

-- ══════════════════════════════════════
-- Recherche DataStore (joueurs hors-ligne)
-- ══════════════════════════════════════
local function searchOfflinePlayers(animalName: string): {any}
	local nameLower = trimName(animalName)
	local results   = {}

	-- Liste des userId en ligne (pour ne pas les doubler)
	local onlineIds = {}
	for _, p in ipairs(Players:GetPlayers()) do
		onlineIds[p.UserId] = true
	end

	-- Parcourt toutes les pages du DataStore
	local ok, pages = pcall(function()
		return AnimalDataStore:ListKeysAsync("Player_")
	end)
	if not ok or not pages then return results end

	local continueLoop = true
	while continueLoop do
		local pageOk, items = pcall(function() return pages:GetCurrentPage() end)
		if not pageOk then break end

		for _, item in ipairs(items) do
			local key    = item.KeyName
			local userId = tonumber(key:match("Player_(%d+)"))
			if not userId or onlineIds[userId] then continue end

			local dataOk, data = pcall(AnimalDataStore.GetAsync, AnimalDataStore, key)
			if not dataOk or not data then continue end

			local podiums = data.AnimalPodiums
			if not podiums or type(podiums) ~= "table" then continue end

			for podiumIndex, podiumData in pairs(podiums) do
				if podiumData == "Empty" or type(podiumData) ~= "table" then continue end
				if trimName(podiumData.Index or "") ~= nameLower then continue end

				-- DPS sans joueur connecté : on calcule avec les données brutes
				local dps = 0
				local okDps, resultDps = pcall(
					SharedAnimals.GetGeneration, SharedAnimals,
					podiumData.Index, podiumData.Mutation, podiumData.Traits, nil
				)
				if okDps and type(resultDps) == "number" then dps = resultDps end

				table.insert(results, {
					playerName  = data.PlayerName or ("User_" .. userId),
					userId      = userId,
					podiumIndex = podiumIndex,
					index       = podiumData.Index,
					mutation    = podiumData.Mutation,
					traits      = podiumData.Traits,
					dps         = dps,
					suspect     = isSuspect(dps),
					online      = false,
					serverId    = nil,
				})
			end
		end

		if pages.IsFinished then
			continueLoop = false
		else
			local nextOk = pcall(pages.AdvanceToNextPageAsync, pages)
			if not nextOk then break end
		end
	end

	return results
end

-- ══════════════════════════════════════
-- Suppression locale immédiate
-- ══════════════════════════════════════
local function deleteLocalAnimal(adminName: string, targetUsername: string, podiumIndex: number): boolean
	local target: Player?
	for _, p in ipairs(Players:GetPlayers()) do
		if p.Name:lower() == targetUsername:lower() then
			target = p
			break
		end
	end
	if not target then return false end

	local ok, channel = pcall(Synchronizer.Get, Synchronizer, target)
	if not ok or not channel then return false end

	local podiums = channel:Get("AnimalPodiums")
	if not podiums then return false end

	local podium = podiums[podiumIndex]
	if not podium or podium == "Empty" then return false end

	local indexData = channel:Get("Index") or {}
	if type(podium) == "table" and podium.Index and indexData[podium.Index] then
		local mut     = podium.Mutation or "Default"
		local current = tonumber(indexData[podium.Index][mut]) or 0
		if current > 0 then indexData[podium.Index][mut] = current - 1 end
		channel:Set("Index", indexData)
	end

	local dps = getAnimalDPS(podium.Index, podium.Mutation, podium.Traits, target)
	channel:Increase("Generation", -dps)
	podiums[podiumIndex] = "Empty"
	channel:Set("AnimalPodiums", podiums)
	channel:Set("AnimalAddedOrRemoved", true)

	-- Met à jour le DataStore immédiatement
	savePlayerAnimals(target)

	print(string.format("[AdminService] %s a supprimé podium %d de %s", adminName, podiumIndex, target.Name))
	return true
end

-- Suppression différée pour joueur hors-ligne
local function scheduleOfflineDelete(userId: number, podiumIndex: number)
	local key = "Pending_" .. userId
	pcall(function()
		AnimalDataStore:UpdateAsync(key, function(current)
			local list = current or {}
			-- Vérifie que l'index n'est pas déjà dans la liste
			for _, v in ipairs(list) do
				if v == podiumIndex then return list end
			end
			table.insert(list, podiumIndex)
			return list
		end)
	end)

	-- Met aussi à jour le DataStore principal pour effacer l'animal
	local dsKey = "Player_" .. userId
	pcall(function()
		AnimalDataStore:UpdateAsync(dsKey, function(data)
			if not data then return nil end
			local podiums = data.AnimalPodiums
			if podiums and podiums[podiumIndex] then
				podiums[podiumIndex] = "Empty"
			end
			return data
		end)
	end)

	print(string.format("[AdminService] Suppression différée planifiée : userId %d podium %d", userId, podiumIndex))
end

-- ══════════════════════════════════════
-- Gestion MessagingService (recherche inter-serveurs)
-- ══════════════════════════════════════

-- Table des réponses en attente : requestId → { results, event }
local pendingRequests = {}

local function setupMessaging()
	-- Écoute les recherches des autres serveurs
	pcall(function()
		MessagingService:SubscribeAsync(TOPIC_SEARCH, function(message)
			local data = message.Data
			if type(data) ~= "table" then return end
			if data.fromJobId == JOB_ID then return end  -- ignore nos propres requêtes

			local animalName = data.animalName
			local requestId  = data.requestId

			-- Cherche localement
			local localResults = searchLocalServer(animalName)

			if #localResults > 0 then
				-- Répond au serveur demandeur
				pcall(function()
					MessagingService:PublishAsync(TOPIC_RESPONSE, {
						requestId = requestId,
						results   = localResults,
						fromJobId = JOB_ID,
					})
				end)
			end
		end)
	end)

	-- Écoute les réponses des autres serveurs
	pcall(function()
		MessagingService:SubscribeAsync(TOPIC_RESPONSE, function(message)
			local data = message.Data
			if type(data) ~= "table" then return end

			local requestId = data.requestId
			local pending   = pendingRequests[requestId]
			if not pending then return end

			-- Ajoute les résultats reçus
			for _, r in ipairs(data.results or {}) do
				table.insert(pending.results, r)
			end
		end)
	end)

	-- Écoute les suppressions des autres serveurs
	pcall(function()
		MessagingService:SubscribeAsync(TOPIC_DELETE, function(message)
			local data = message.Data
			if type(data) ~= "table" then return end
			if data.fromJobId == JOB_ID then return end

			-- Essaie de supprimer localement si le joueur est sur ce serveur
			deleteLocalAnimal("Admin", data.targetUsername, data.podiumIndex)
		end)
	end)
end

-- Recherche globale : ce serveur + tous les autres serveurs actifs + hors-ligne
local function globalSearch(animalName: string): {any}
	-- 1. Résultats locaux immédiats
	local allResults = searchLocalServer(animalName)

	-- 2. Broadcast aux autres serveurs via MessagingService
	local requestId = HttpService:GenerateGUID(false)
	pendingRequests[requestId] = { results = {}, done = false }

	pcall(function()
		MessagingService:PublishAsync(TOPIC_SEARCH, {
			animalName  = animalName,
			requestId   = requestId,
			fromJobId   = JOB_ID,
		})
	end)

	-- Attend 3 secondes pour collecter les réponses des autres serveurs
	task.wait(3)

	-- Fusionne les résultats des autres serveurs
	local pending = pendingRequests[requestId]
	if pending then
		for _, r in ipairs(pending.results) do
			table.insert(allResults, r)
		end
		pendingRequests[requestId] = nil
	end

	-- 3. Résultats hors-ligne depuis le DataStore
	local offlineResults = searchOfflinePlayers(animalName)
	for _, r in ipairs(offlineResults) do
		table.insert(allResults, r)
	end

	-- Trie : suspects en premier, puis DPS décroissant
	table.sort(allResults, function(a, b)
		if a.suspect ~= b.suspect then return a.suspect end
		return (a.dps or 0) > (b.dps or 0)
	end)

	return allResults
end

-- ══════════════════════════════════════
-- API publique
-- ══════════════════════════════════════
function AdminService.DeleteAnimal(adminPlayer: Player, targetUsername: string, podiumIndex: number, userId: number, online: boolean)
	if not isAdmin(adminPlayer) then return false end

	if online then
		-- Joueur connecté sur CE serveur : suppression directe
		local success = deleteLocalAnimal(adminPlayer.Name, targetUsername, podiumIndex)
		if success then return true end

		-- Joueur connecté sur un AUTRE serveur : broadcast
		pcall(function()
			MessagingService:PublishAsync(TOPIC_DELETE, {
				targetUsername = targetUsername,
				podiumIndex    = podiumIndex,
				userId         = userId,
				fromJobId      = JOB_ID,
			})
		end)
		-- Met aussi à jour le DataStore pour hors-ligne
		scheduleOfflineDelete(userId, podiumIndex)
		return true
	else
		-- Joueur hors-ligne : suppression différée
		scheduleOfflineDelete(userId, podiumIndex)
		return true
	end
end

function AdminService.DeleteAllSuspects(adminPlayer: Player, suspects: {any})
	if not isAdmin(adminPlayer) then return 0 end
	local count = 0
	for _, a in ipairs(suspects) do
		if a.suspect then
			local ok = AdminService.DeleteAnimal(adminPlayer, a.playerName, a.podiumIndex, a.userId, a.online)
			if ok then count += 1 end
		end
	end
	return count
end

-- ══════════════════════════════════════
-- Start
-- ══════════════════════════════════════
function AdminService:Start()
	setupMessaging()

	-- Sauvegarde au login et logoff
	Players.PlayerAdded:Connect(function(player)
		-- Attend que le channel soit prêt
		task.spawn(function()
			local ok, channel = pcall(Synchronizer.Wait, Synchronizer, player)
			if not ok or not channel then return end
			-- Applique les suppressions en attente
			applyPendingDeletes(player)
			-- Sauvegarde initiale
			task.wait(2)
			savePlayerAnimals(player)
		end)
	end)

	Players.PlayerRemoving:Connect(function(player)
		savePlayerAnimals(player)
	end)

	-- Sauvegarde périodique toutes les 5 minutes
	task.spawn(function()
		while true do
			task.wait(300)
			for _, player in ipairs(Players:GetPlayers()) do
				savePlayerAnimals(player)
			end
		end
	end)

	-- Remote : recherche globale
	GetPlayersByAnimalRemote.OnServerInvoke = function(caller: Player, animalName: string)
		if not isAdmin(caller) then return nil, "Accès refusé." end
		if not animalName or trimName(animalName) == "" then return nil, "Nom manquant." end

		local results = globalSearch(animalName)
		if #results == 0 then
			return nil, "Aucun joueur (connecté ou non) ne possède « " .. animalName .. " »."
		end
		return results, nil
	end

	-- Remote : suppression (reçoit maintenant userId et online en plus)
	DeleteAnimalRemote.OnServerEvent:Connect(function(caller, targetUsername, podiumIndex, userId, online)
		if not isAdmin(caller) then return end
		AdminService.DeleteAnimal(caller, targetUsername, podiumIndex, userId, online)
	end)

	-- Remote : supprimer tous les suspects
	DeleteAllSuspectsRemote.OnServerEvent:Connect(function(caller, suspectsJson)
		if not isAdmin(caller) then return end
		local ok, suspects = pcall(game:GetService("HttpService").JSONDecode, game:GetService("HttpService"), suspectsJson)
		if not ok then return end
		local count = AdminService.DeleteAllSuspects(caller, suspects)
		print(string.format("[AdminService] %d suspects supprimés par %s", count, caller.Name))
	end)
end

return AdminService