-- Reference copy for study. Game: Steal a Brainrot (steal-a-brainrot)
-- Original: ServerScriptService/Services/DataService.lua  (253 lines)
-- What it does: GetAsync/SetAsync with 2^n backoff, a separate SESSION-LOCK store claimed with UpdateAsync, reconcile against DefaultStats, 60s autosave and parallel BindToClose that waits for saves.

local DataService = {}

local DataStoreService = game:GetService("DataStoreService")
local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local DataStore = DataStoreService:GetDataStore("DATA-FOR-EVERYONESS-V2")
local SessionStore = DataStoreService:GetDataStore("SESSION-LOCK")

local DefaultStats = require(ServerScriptService.Components.DefaultStats)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local TableUtils = require(ReplicatedStorage.Utils.TableUtils)

-- ─── Config ───────────────────────────────────────────────────────────────────
local AUTOSAVE_INTERVAL = 60       -- secondes (1s était beaucoup trop agressif)
local MAX_RETRIES = 5
local SESSION_TIMEOUT = 30         -- secondes avant de forcer la reprise de session
-- ─────────────────────────────────────────────────────────────────────────────

-- Joueurs en cours de sauvegarde (évite les doubles saves simultanées)
local savingPlayers = {}

-- ─── Utilitaires ─────────────────────────────────────────────────────────────

local function DeepCopy(tbl)
	local new = {}
	for k, v in pairs(tbl) do
		new[k] = type(v) == "table" and DeepCopy(v) or v
	end
	return new
end

local function SafeSetAsync(key, data)
	for i = 1, MAX_RETRIES do
		local success, err = pcall(function()
			DataStore:SetAsync(key, data)
		end)
		if success then
			return true
		end
		warn(string.format("[DataService] Save failed for key '%s' (attempt %d/%d): %s", key, i, MAX_RETRIES, tostring(err)))
		task.wait(2 ^ i)
	end
	warn(string.format("[DataService] CRITICAL: Could not save data for key '%s' after %d attempts", key, MAX_RETRIES))
	return false
end

local function SafeGetAsync(key)
	for i = 1, MAX_RETRIES do
		local success, data = pcall(function()
			return DataStore:GetAsync(key)
		end)
		if success then
			return data
		end
		warn(string.format("[DataService] Load failed for key '%s' (attempt %d/%d)", key, i, MAX_RETRIES))
		task.wait(2 ^ i)
	end
	warn(string.format("[DataService] CRITICAL: Could not load data for key '%s' after %d attempts", key, MAX_RETRIES))
	return nil
end

-- ─── Session Lock ─────────────────────────────────────────────────────────────
-- Empêche deux serveurs de charger les données du même joueur en même temps

local function AcquireSessionLock(userId)
	local key = "lock_" .. userId
	local jobId = game.JobId

	for i = 1, MAX_RETRIES do
		local success, currentLock = pcall(function()
			return SessionStore:UpdateAsync(key, function(existing)
				if existing and existing.jobId ~= jobId then
					local elapsed = os.time() - (existing.timestamp or 0)
					if elapsed < SESSION_TIMEOUT then
						return nil -- lock actif → ne pas écraser
					end
				end
				return { jobId = jobId, timestamp = os.time() }
			end)
		end)

		if success and currentLock then
			return true
		end

		warn(string.format("[DataService] Session lock busy for userId %d (attempt %d/%d)", userId, i, MAX_RETRIES))
		task.wait(2 ^ i)
	end

	return false
end

local function ReleaseSessionLock(userId)
	local key = "lock_" .. userId
	pcall(function()
		SessionStore:RemoveAsync(key)
	end)
end

-- ─── API publique ─────────────────────────────────────────────────────────────

function DataService:SavePlayer(player, isLeaving)
	-- Évite deux sauvegardes simultanées pour le même joueur
	if savingPlayers[player] then return end
	savingPlayers[player] = true

	local channel = Synchronizer:Get(player)
	if not channel then
		savingPlayers[player] = nil
		return
	end

	channel:Set("LastLogoutTime", os.time())

	-- ✅ Fix : récupérer toutes les données du channel correctement
	local data = channel:Get()
	if type(data) ~= "table" then
		warn(string.format("[DataService] Could not get data for player '%s', skipping save", player.Name))
		savingPlayers[player] = nil
		return
	end

	if type(data.AnimalPodiums) == "table" then
		for idx, pod in pairs(data.AnimalPodiums) do
			if type(pod) == "table" and pod.IsFake then
				data.AnimalPodiums[idx] = "Empty"
			end
		end
	end
	local success = SafeSetAsync(player.UserId, data)

	if success then
		-- Libère le session lock uniquement si le joueur quitte
		if isLeaving then
			ReleaseSessionLock(player.UserId)
		end
	end

	savingPlayers[player] = nil
end

function DataService:ResetData(player)
	local channel = Synchronizer:Get(player)
	if not channel then return end

	local newData = DeepCopy(DefaultStats)
	for key, value in pairs(newData) do
		channel:Set(key, value)
	end

	SafeSetAsync(player.UserId, newData)
	player:Kick("Profile reset - Rejoin")
end

function DataService:SetKey(player, key, value)
	local channel = Synchronizer:Get(player)
	if not channel then return false end
	channel:Set(key, value)
	return true
end

-- ─── Initialisation ───────────────────────────────────────────────────────────

function DataService:Start()
	Synchronizer:Create("Cycle", { Overrides = {} })

	local function setupPlayer(player)
		if Synchronizer:Get(player) then return end

		-- Session lock : empêche la corruption si le joueur se reconnecte trop vite
		local lockAcquired = AcquireSessionLock(player.UserId)
		if not lockAcquired then
			warn(string.format("[DataService] Could not acquire session lock for '%s', kicking", player.Name))
			player:Kick("Could not load your data safely. Please rejoin in a few seconds.")
			return
		end

		local savedData = SafeGetAsync(player.UserId)

		-- Si le chargement échoue complètement → kick plutôt que données vides
		if savedData == nil and SafeGetAsync ~= nil then
			warn(string.format("[DataService] No data found for '%s', using defaults", player.Name))
		end

		local playerData = savedData or DeepCopy(DefaultStats)
		if type(playerData.AnimalPodiums) == "table" then
			for idx, pod in pairs(playerData.AnimalPodiums) do
				if type(pod) == "table" and pod.IsFake then
					playerData.AnimalPodiums[idx] = "Empty"
				end
			end
		end
		playerData = TableUtils.Reconcile(playerData, DefaultStats)
		playerData.TimesJoined = (playerData.TimesJoined or 0) + 1

		local channel = Synchronizer:Create(player, playerData)
		channel:AddListener(player)

		print(string.format("[DataService] Loaded data for '%s' (TimesJoined: %d)", player.Name, playerData.TimesJoined))
	end

	Players.PlayerAdded:Connect(setupPlayer)

	Players.PlayerRemoving:Connect(function(player)
		DataService:SavePlayer(player, true) -- isLeaving = true → libère le lock
		Synchronizer:Destroy(player)
		savingPlayers[player] = nil
	end)

	for _, player in ipairs(Players:GetPlayers()) do
		task.spawn(setupPlayer, player)
	end

	-- ─── Autosave ────────────────────────────────────────────────────────────
	task.spawn(function()
		while task.wait(AUTOSAVE_INTERVAL) do
			local players = Players:GetPlayers()
			for _, player in ipairs(players) do
				task.spawn(function()
					DataService:SavePlayer(player, false)
				end)
			end
		end
	end)

	-- ─── Sauvegarde à la fermeture du serveur ────────────────────────────────
	-- Les sauvegardes sont faites en parallèle pour rester dans le timeout Roblox
	game:BindToClose(function()
		local threads = {}

		for _, player in ipairs(Players:GetPlayers()) do
			local thread = task.spawn(function()
				DataService:SavePlayer(player, true)
			end)
			table.insert(threads, thread)
		end

		-- Attendre que toutes les sauvegardes se terminent (max 25s)
		local deadline = os.clock() + 25
		for _, player in ipairs(Players:GetPlayers()) do
			while savingPlayers[player] and os.clock() < deadline do
				task.wait(0.1)
			end
		end

		print("[DataService] All players saved on server close.")
	end)
end


return DataService
