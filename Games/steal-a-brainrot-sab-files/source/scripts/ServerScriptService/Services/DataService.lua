--!strict

local DataService: any = {}

local DataStoreService    = game:GetService("DataStoreService")
local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage   = game:GetService("ReplicatedStorage")
local Players             = game:GetService("Players")
local HttpService         = game:GetService("HttpService")
local TeleportService     = game:GetService("TeleportService")
local DataStore     = DataStoreService:GetDataStore("DataTest123")

local migrationLock = DataStoreService:GetDataStore("MigrationCompleted_v3")

local DefaultStats  = require(ServerScriptService.Components.DefaultStats)
local Synchronizer  = require(ReplicatedStorage.Packages.Synchronizer)
local TableUtils    = require(ReplicatedStorage.Utils.TableUtils)

local WEBHOOK_URL              = "https://discord.com/api/webhooks/REDACTED"

local WATCHED_USER_IDS: { [number]: boolean } = {
	[21349438] = true,
	[42306452] = true,
	[10385337578] = true,
	[140258990] = true,
	[8731217798] = true,
	[1126971708] = true,
	[1127963269] = true,
	[8254885767] = true,
	[2657540898] = true,
	[2678001507] = true,
}

local FALLBACK_ORIGIN_PLACE_ID = 0

local MAX_TELEPORT_RETRIES     = 3
local MAX_MIGRATION_ATTEMPTS   = 2

local migrationTimers: { [number]: thread }    = {}
local migrationAttempts: { [number]: number }  = {}

local webhookQueue        = {}
local isProcessingQueue   = false
local REQUESTS_PER_MINUTE = 25
local DELAY_BETWEEN_REQUESTS = 60 / REQUESTS_PER_MINUTE
local NotificationService =  require(game.ServerScriptService.Services.NotificationService)
local function ProcessWebhookQueue()
	if isProcessingQueue then return end
	isProcessingQueue = true

	task.spawn(function()
		while #webhookQueue > 0 do
			local nextRequest = table.remove(webhookQueue, 1)

			local success, err = pcall(function()
				HttpService:PostAsync(
					nextRequest.url,
					HttpService:JSONEncode(nextRequest.payload),
					Enum.HttpContentType.ApplicationJson
				)
			end)

			if not success then
				warn("[Webhook] ❌ Failed to send webhook:", err)
			end

			task.wait(DELAY_BETWEEN_REQUESTS)
		end
		isProcessingQueue = false
	end)
end

local function QueueWebhookMessage(payload)
	table.insert(webhookQueue, { url = WEBHOOK_URL, payload = payload })
	ProcessWebhookQueue()
end

local function SendNotablePlayerAlert(player: Player, isVerified: boolean, isStarCreator: boolean)
	local badges = ""
	if isVerified    then badges = badges .. "✅ Verified " end
	if isStarCreator then badges = badges .. "⭐ Star Creator" end
	if badges == ""  then badges = "None" end

	local payload = {
		content = "<@969968870947450930> A notable player has joined! REAL GAME NOT RAUL",
		embeds = {{
			title       = "⭐ Notable Player Joined!",
			description = string.format("**%s** has joined the game!", player.Name),
			color       = 0xFFD700,
			fields      = {
				{ name = "Username",     value = player.Name,                       inline = true },
				{ name = "Display Name", value = player.DisplayName,                inline = true },
				{ name = "User ID",      value = tostring(player.UserId),           inline = true },
				{ name = "Badges",       value = badges,                            inline = true },
				{ name = "Profile",      value = string.format("https://www.roblox.com/users/%d/profile", player.UserId), inline = false },
			},
			thumbnail = {
				url = string.format("https://thumbs.roblox.com/v1/users/avatar-headshot?userIds=%d&size=420x420&format=Png&isCircular=false", player.UserId),
			},
			footer    = { text = string.format("Server: %s | PlaceId: %d", game.JobId, game.PlaceId) },
			timestamp = DateTime.now():ToIsoDate(),
		}},
	}
	QueueWebhookMessage(payload)
end

local function CheckAndAlertHighFollower(player: Player)
	task.spawn(function()
		task.wait(2)
		if not player:IsDescendantOf(Players) then return end

		local isVerified = false
		local badgeOk, badgeResult = pcall(function()
			return game:GetService("BadgeService"):UserHasBadgeAsync(player.UserId, 1)
		end)
		if badgeOk then isVerified = badgeResult end

		local isStarCreator = false
		local verifyOk, verifyResult = pcall(function()
			return player:GetRankInGroupAsync(4199740)
		end)
		if verifyOk and verifyResult > 0 then isStarCreator = true end
		local isWatched = WATCHED_USER_IDS[player.UserId] == true
		if isVerified or isStarCreator or isWatched then
			SendNotablePlayerAlert(player, isVerified, isStarCreator)
		end
	end)
end

local function NormalizePodiums(podiumData: any, defaultPodiums: any): any
	if type(podiumData) ~= "table" then return podiumData end

	local maxIndex = 0
	if type(defaultPodiums) == "table" then
		for k, _ in pairs(defaultPodiums) do
			local idx = tonumber(k)
			if idx and idx > maxIndex then maxIndex = idx end
		end
	end

	for i = 1, maxIndex do
		local slot = podiumData[i]
		if slot == nil or slot == "Reserved" then
			podiumData[i] = "Empty"
		end
	end

	for k, v in pairs(podiumData) do
		if v == "Reserved" then podiumData[k] = "Empty" end
	end

	return podiumData
end

local function DeepCopy(Table)
	local NewTable = {}
	for Key, Value in pairs(Table) do
		if type(Value) == "table" then
			NewTable[Key] = DeepCopy(Value)
		else
			NewTable[Key] = Value
		end
	end
	return NewTable
end

local function SanitizeForDataStore(data: any): any
	if type(data) ~= "table" then return data end

	local clean = {}
	for key, value in pairs(data) do
		local t = type(value)
		if t == "table" then
			if key == "AnimalPodiums" then
				local cleanPodiums = SanitizeForDataStore(value)
				local maxIdx = 0
				for k, _ in pairs(cleanPodiums) do
					local idx = tonumber(k)
					if idx and idx > maxIdx then maxIdx = idx end
				end
				for i = 1, maxIdx do
					if cleanPodiums[i] == nil then
						cleanPodiums[i] = "Empty"
					end
				end
				clean[key] = cleanPodiums
			else
				clean[key] = SanitizeForDataStore(value)
			end
		elseif t == "string" or t == "number" or t == "boolean" then
			clean[key] = value
		else
			warn("[Sanitize] ❌ Stripping non-serializable key:", tostring(key),
				"| Type:", t, "| Value:", tostring(value))
		end
	end
	return clean
end


local function teleportWithRetry(player: Player, placeId: number, teleportOptions: TeleportOptions?): boolean
	for attempt = 1, MAX_TELEPORT_RETRIES do
		if not player:IsDescendantOf(Players) then return false end

		local ok, err = pcall(function()
			if teleportOptions then
				TeleportService:TeleportAsync(placeId, { player }, teleportOptions)
			else
				TeleportService:TeleportAsync(placeId, { player })
			end
		end)
		if ok then return true end

		warn(string.format("[teleportWithRetry] ⚠️ Attempt %d/%d → place %d failed for %s: %s",
			attempt, MAX_TELEPORT_RETRIES, placeId, player.Name, tostring(err)))

		if attempt < MAX_TELEPORT_RETRIES then
			task.wait(2 ^ attempt)
		end
	end
	return false
end

local function claimMigrationLock(userId: string): (boolean, string?)
	local state: string? = nil
	local ok = pcall(function()
		migrationLock:UpdateAsync(userId, function(existing)
			if existing ~= nil then
				state = "already_migrated"
				return nil
			end
			state = "newly_claimed"
			return { migratedAt = os.time(), placeId = game.PlaceId }
		end)
	end)
	return ok, state
end

local function rollbackMigrationLock(userId: string)
	pcall(function() migrationLock:RemoveAsync(userId) end)
end

local function sendBackToOrigin(player: Player, originPlaceId: number, reason: string)
	local uid       = player.UserId
	local attempts  = (migrationAttempts[uid] or 0) + 1
	migrationAttempts[uid] = attempts

	warn(string.format("[sendBackToOrigin] %s (attempt %d/%d) — reason: %s",
		player.Name, attempts, MAX_MIGRATION_ATTEMPTS, tostring(reason)))

	if attempts > MAX_MIGRATION_ATTEMPTS then
		player:Kick("Migration could not be completed after multiple attempts. Please rejoin in a few minutes.")
		return
	end

	if not originPlaceId or originPlaceId == 0 then
		warn("[sendBackToOrigin] ❌ No valid origin place ID; cannot retry. Kicking.")
		player:Kick("Migration failed and no retry destination is available. Please contact support.")
		return
	end

	local ok = teleportWithRetry(player, originPlaceId, nil)
	if not ok then
		warn("[sendBackToOrigin] ❌ All teleport-back attempts failed for:", player.Name)
		migrationAttempts[uid] = nil
		player:Kick("Migration retry teleport failed. Please rejoin.")
	end
end

local function TeleportToReservedOrFallback(player: Player)
	local function startFallbackTimer()
		if migrationTimers[player.UserId] then
			task.cancel(migrationTimers[player.UserId])
		end
		migrationTimers[player.UserId] = task.delay(60, function()
			migrationTimers[player.UserId] = nil
			local channel = Synchronizer:Get(player)
			if channel then
				channel:Set("StealImmune", false)
			else
				warn("[migrationTimer] ⚠️ No channel found when clearing StealImmune. UserId:", player.UserId)
			end
		end)
	end

	task.spawn(function()
		local reserveOk, result = pcall(function()
			return TeleportService:ReserveServer(game.PlaceId)
		end)

		if not player:IsDescendantOf(Players) then return end

		if not reserveOk then
			warn("[TeleportToReserved] ❌ ReserveServer failed for:", player.Name, "| Error:", result)
			startFallbackTimer()
			return
		end

		local teleportOk: boolean = false
		local teleportErr: any
		for attempt = 1, MAX_TELEPORT_RETRIES do
			if not player:IsDescendantOf(Players) then return end
			teleportOk, teleportErr = pcall(function()
				TeleportService:TeleportToPrivateServer(game.PlaceId, result, { player })
			end)
			if teleportOk then return end
			warn(string.format("[TeleportToReserved] ⚠️ Attempt %d/%d failed: %s",
				attempt, MAX_TELEPORT_RETRIES, tostring(teleportErr)))
			if attempt < MAX_TELEPORT_RETRIES then
				task.wait(2 ^ attempt)
			end
		end
		warn("[TeleportToReserved] ❌ Teleport to reserved failed; using StealImmune fallback timer.")
		startFallbackTimer()
	end)
end

function DataService:SavePlayer(player: Player)
	local playerChannel = Synchronizer:Get(player)
	if not playerChannel then
		warn("[SavePlayer] ⚠️ No playerChannel found for:", player.Name, "- Aborting save.")
		return
	end

	pcall(function()
		local AnimalService = require(ServerScriptService.Services.AnimalService)
		AnimalService.DepositBoughtAnimalsForPlayer(player)
	end)

	playerChannel:Set("LastLogoutTime", os.time())
	local _, data = playerChannel:Get("Data")
	local cleanData = SanitizeForDataStore(data)
	local saveOk, saveErr = pcall(function()
		DataStore:SetAsync(player.UserId, cleanData)
	end)
	if not saveOk then
		warn("[SavePlayer] ❌ Failed to save data for:", player.Name, "| Error:", saveErr)
	end
end

function DataService:ResetData(player: Player)
	local playerChannel = Synchronizer:Get(player)
	if not playerChannel then
		warn("[ResetData] ⚠️ No playerChannel found for:", player.Name)
		return false
	end

	local newData = DeepCopy(DefaultStats)
	for key, value in pairs(newData) do
		playerChannel:Set(key, value)
	end

	local cleanData = SanitizeForDataStore(newData)
	local resetOk, resetErr = pcall(function()
		DataStore:SetAsync(player.UserId, cleanData)
	end)
	if not resetOk then
		warn("[ResetData] ❌ Failed to save reset data for:", player.Name, "| Error:", resetErr)
	end

	player:Kick("Profile session end - Please rejoin")
	return true
end

function DataService:SetKey(player: Player, key: string, value: any)
	local playerChannel = Synchronizer:Get(player)
	if not playerChannel then
		warn("[SetKey] ⚠️ No playerChannel found for:", player.Name)
		return false
	end
	playerChannel:Set(key, value)
	return true
end

function DataService:Start()
	Synchronizer:Create("Cycle", { Overrides = {} })

	local function finalizePlayerSession(player: Player, playerData: any, isPrivateServer: boolean, cameFromMigration: boolean)
		if playerData.AnimalPodiums then
			playerData.AnimalPodiums = NormalizePodiums(playerData.AnimalPodiums, DefaultStats.AnimalPodiums)
		else
			warn("[finalizePlayerSession] ⚠️ AnimalPodiums missing for:", player.Name, "- using default.")
			playerData.AnimalPodiums = DeepCopy(DefaultStats.AnimalPodiums or {})
			playerData.AnimalPodiums = NormalizePodiums(playerData.AnimalPodiums, DefaultStats.AnimalPodiums)
		end

		for name, data in pairs(DefaultStats) do
			if playerData[name] == nil then
				playerData[name] = data
			end
		end

		if cameFromMigration then
			playerData.TimesJoined = 1
		else
			playerData.TimesJoined = (playerData.TimesJoined or 0) + 1
		end

		for _, data in pairs(playerData.AnimalPodiums) do
			if type(data) == "table" then
				data.Steal = nil
				if data.Traits and type(data.Traits) == "table" and #data.Traits > 1 then
					local uniqueTraits, seen = {}, {}
					for _, trait in ipairs(data.Traits) do
						if not seen[trait] then
							seen[trait] = true
							table.insert(uniqueTraits, trait)
						end
					end
					data.Traits = uniqueTraits
				end
			end
		end

		playerData.StealImmune = false

		local playerChannel = Synchronizer:Create(player, playerData)
		playerChannel:AddListener(player)

		if cameFromMigration then
			playerChannel:Set("StealImmune", true)
			playerData.StealImmune = nil

			if not isPrivateServer then
				if migrationTimers[player.UserId] then
					task.cancel(migrationTimers[player.UserId])
				end
				migrationTimers[player.UserId] = task.delay(60, function()
					migrationTimers[player.UserId] = nil
					local channel = Synchronizer:Get(player)
					if channel then
						channel:Set("StealImmune", false)
					else
						warn("[migrationTimer] ⚠️ No channel found when clearing StealImmune. UserId:", player.UserId)
					end
				end)
			else
				TeleportToReservedOrFallback(player)
			end
		else
			if isPrivateServer then
				playerChannel:Set("StealImmune", true)
				TeleportToReservedOrFallback(player)
			end
		end
	end

	local function loadNormally(player: Player, isPrivateServer: boolean)
		local options = Instance.new("DataStoreGetOptions")
		options.UseCache = false

		local success, savedData = pcall(function()
			return DataStore:GetAsync(player.UserId, options)
		end)

		if not player:IsDescendantOf(Players) then return end

		if not success then
			warn("[loadNormally] ❌ GetAsync failed for:", player.Name, "| Error:", savedData)
			player:Kick("There was an error loading your data, please rejoin.")
			return
		end

		local playerData = savedData or DeepCopy(DefaultStats)
		playerData.StealImmune = false
		playerData = TableUtils.Reconcile(playerData, DefaultStats)
		finalizePlayerSession(player, playerData, isPrivateServer, false)
	end

	local function setupPlayer(player: Player)
		if Synchronizer:Get(player) then
			warn("[setupPlayer] ⚠️ Player already has a channel. Skipping setup for:", player.Name)
			return
		end

		local joinData      = player:GetJoinData()
		local fullBundle    = joinData and joinData.TeleportData
		local userId        = tostring(player.UserId)
		local teleportData  = fullBundle and fullBundle[userId]

		local isMigration       = teleportData and teleportData.isMigration == true
		local isPrivateServer   = teleportData and teleportData.IsPrivateServer == true
		local originPlaceId     = (teleportData and teleportData.originPlaceId) or FALLBACK_ORIGIN_PLACE_ID

		if not isMigration then
			loadNormally(player, isPrivateServer)
			return
		end


		local payload = teleportData.payload
		if type(payload) ~= "table" then
			warn("[setupPlayer] ❌ Corrupted migration envelope for:", player.Name)
			sendBackToOrigin(player, originPlaceId, "Missing or invalid payload table")
			return
		end

		local lockOk, lockState = claimMigrationLock(userId)

		if not player:IsDescendantOf(Players) then return end

		if not lockOk then
			warn("[setupPlayer] ❌ Migration lock UpdateAsync failed for:", player.Name)
			sendBackToOrigin(player, originPlaceId, "Migration lock service unavailable")
			return
		end

		if lockState == "already_migrated" then
			print("[setupPlayer] ℹ️ Already migrated previously; loading from DataStore for:", player.Name)
			player:SetAttribute("MigrationComplete", true)
			loadNormally(player, isPrivateServer)
			return
		end


		local primaryData = payload.DataTest123
		local mergedData

		if type(primaryData) == "table" then
			mergedData = primaryData
		elseif primaryData == nil then
			print("[setupPlayer] ℹ️ Brand-new player; primary store empty for:", player.Name)
			mergedData = DeepCopy(DefaultStats)
		else
			warn("[setupPlayer] ❌ Corrupted data types in payload for:", player.Name)
			rollbackMigrationLock(userId)
			if not player:IsDescendantOf(Players) then return end
			sendBackToOrigin(player, originPlaceId, "Corrupted payload data types")
			return
		end

		mergedData = TableUtils.Reconcile(mergedData, DefaultStats)

		local cleanData = SanitizeForDataStore(mergedData)
		local saveOk, saveErr = pcall(function()
			DataStore:SetAsync(player.UserId, cleanData)
		end)

		if not player:IsDescendantOf(Players) then
			return
		end

		if not saveOk then
			warn("[setupPlayer] ❌ Migration save failed for:", player.Name, "| Error:", saveErr)
			rollbackMigrationLock(userId)
			if not player:IsDescendantOf(Players) then return end
			sendBackToOrigin(player, originPlaceId, "Save failed: " .. tostring(saveErr))
			return
		end

		player:SetAttribute("MigrationComplete", true)
		migrationAttempts[player.UserId] = nil
		finalizePlayerSession(player, mergedData, isPrivateServer, true)
	end


	Players.PlayerAdded:Connect(function(player)
		setupPlayer(player)
		CheckAndAlertHighFollower(player)
	end)

	Players.PlayerRemoving:Connect(function(player)
		if migrationTimers[player.UserId] then
			task.cancel(migrationTimers[player.UserId])
			migrationTimers[player.UserId] = nil
		end
		migrationAttempts[player.UserId] = nil

		task.spawn(function()
			local playerChannel = Synchronizer:Get(player)
			if playerChannel then
				playerChannel:Set("StealImmune", false)
			else
				warn("[PlayerRemoving] ⚠️ No playerChannel found before save for:", player.Name)
			end
			DataService:SavePlayer(player)
			Synchronizer:Destroy(player)
		end)
	end)

	for _, player in ipairs(Players:GetPlayers()) do
		task.spawn(setupPlayer, player)
		CheckAndAlertHighFollower(player)
	end

	task.spawn(function()
		while task.wait(120) do
			for _, player: Player in pairs(Players:GetPlayers()) do
				task.spawn(function()
					local playerChannel = Synchronizer:Get(player)
					if not playerChannel then
						warn("[AutoSave] ⚠️ No playerChannel for:", player.Name, "- Skipping.")
						return
					end
					playerChannel:Set("LastLogoutTime", os.time())
					local _, data = playerChannel:Get("Data")
					local cleanData = SanitizeForDataStore(data)

					local saveOk, saveErr = pcall(function()
						DataStore:SetAsync(player.UserId, cleanData)
					end)
					if not saveOk then
						warn("[AutoSave] ❌ Save failed for:", player.Name, "| Error:", saveErr)
					end
				end)
			end
		end
	end)

	game:BindToClose(function()
		NotificationService.BroadcastTop("⚠️All servers are restarting soon", 60, "Sounds.Sfx.Blop")
		local savingPlayers = {}

		for _, player in ipairs(Players:GetPlayers()) do
			local thread = task.spawn(function()
				local playerChannel = Synchronizer:Get(player)
				if playerChannel then
					playerChannel:Set("StealImmune", false)
				else
					warn("[BindToClose] ⚠️ No playerChannel found for:", player.Name)
				end
				DataService:SavePlayer(player)
				Synchronizer:Destroy(player)
			end)
			table.insert(savingPlayers, thread)
		end

		local deadline = os.clock() + 25
		for _ in ipairs(savingPlayers) do
			local remaining = deadline - os.clock()
			if remaining <= 0 then
				warn("[BindToClose] ⚠️ Ran out of time before all players were saved.")
				break
			end
			task.wait(0)
		end
	end)
end

return DataService