local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DataStoreService = game:GetService("DataStoreService")
local UserService = game:GetService("UserService")
local LocalizationService = game:GetService("LocalizationService")

local Net = require(ReplicatedStorage.Packages.Net)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local SharedAnimals = require(ReplicatedStorage.Shared.Animals)

local LeaderboardService = {}

-- --- Config -------------------------------------------------------------------
local UPDATE_INTERVAL      = 15 -- Refresh leaderboard DataStore toutes les 60s
local GENERATION_INTERVAL  = 5  -- Recalcul génération toutes les 30s
local LOG_BASE             = 1.0000001
local CACHE_DURATION       = 12

local LEADERBOARD_NAMES = { "Generation", "Steals" }
local SCALED_LEADERBOARDS = {
	["Generation"] = true,
	["Steals"]     = false,
}
local BannedUsers = {}

-- --- Stores -------------------------------------------------------------------
local leaderboards = {}
for _, name in ipairs(LEADERBOARD_NAMES) do
	leaderboards[name] = DataStoreService:GetOrderedDataStore(name .. "Leaderboard_2")
end

local countryStore       = DataStoreService:GetDataStore("PlayerCountry_2")
local regionHiddenStore  = DataStoreService:GetDataStore("PlayerRegionHidden_2")

-- --- Caches -------------------------------------------------------------------
local displayNameCache  = {}
local countryCache      = {}
local leaderboardCache  = {}
local regionHiddenCache = {}

-- --- Remotes ------------------------------------------------------------------
local GetDisplayNames        = Net:RemoteFunction("Leaderboard/GetDisplayNames")
local GetTopPlayers          = Net:RemoteFunction("Leaderboard/GetTopPlayers")
local GetTopFriends          = Net:RemoteFunction("Leaderboard/GetTopFriends")
local GetCountryLeaderboard  = Net:RemoteFunction("Leaderboard/GetCountryLeaderboard")
local ReplicateDisplayNames  = Net:RemoteEvent("Leaderboard/ReplicateDisplayNames")
local ReplicateUpdate        = Net:RemoteEvent("Leaderboard/ReplicateUpdate")
local ReplicateCountryUpdate = Net:RemoteEvent("Leaderboard/ReplicateCountryUpdate")

-- --- Calcul Generation réelle -------------------------------------------------
local function RecalculateGeneration(player)
	local playerChannel = Synchronizer:Get(player)
	if not playerChannel then return end

	local podiums = playerChannel:Get("AnimalPodiums")
	if not podiums then return end

	local total = 0
	for _, animalInfo in pairs(podiums) do
		if type(animalInfo) == "table" and animalInfo.Index then
			local ok, gen = pcall(function()
				return SharedAnimals:GetGeneration(
					animalInfo.Index,
					animalInfo.Mutation,
					animalInfo.Traits,
					player
				)
			end)
			if ok and gen then
				total += gen
			end
		end
	end

	playerChannel:Set("Generation", total)
	return total
end

-- --- Country helpers ----------------------------------------------------------
local function getCountryCode(player)
	local userId = player.UserId
	if regionHiddenCache[userId] then countryCache[userId] = false; return nil end
	if countryCache[userId] ~= nil then return countryCache[userId] or nil end
	local ok, code = pcall(LocalizationService.GetCountryRegionForPlayerAsync, LocalizationService, player)
	local result = (ok and type(code) == "string" and #code == 2) and code or false
	countryCache[userId] = result
	if result then pcall(function() countryStore:SetAsync(tostring(userId), result) end) end
	return result or nil
end

local _countryPermanentCache = {}
local function getStoredCountryCode(userId)
	if regionHiddenCache[userId] then return nil end
	-- Cache permanent: si déjà vérifié (même nil), ne plus faire GetAsync
	if _countryPermanentCache[userId] ~= nil then
		return _countryPermanentCache[userId] or nil
	end
	if countryCache[userId] ~= nil then return countryCache[userId] or nil end
	local ok, code = pcall(function() return countryStore:GetAsync(tostring(userId)) end)
	local result = (ok and type(code) == "string" and #code == 2) and code or false
	countryCache[userId] = result
	_countryPermanentCache[userId] = result
	return result or nil
end

-- --- Display names ------------------------------------------------------------
local function getAndReplicateDisplayNames(userIds)
	local idsToFetch = {}
	for _, id in ipairs(userIds) do
		if not displayNameCache[id] then table.insert(idsToFetch, id) end
	end
	if #idsToFetch == 0 then return end
	local ok, result = pcall(function() return UserService:GetUserInfosByUserIdsAsync(idsToFetch) end)
	if not ok then return end
	local newNames = {}
	for _, info in ipairs(result) do
		displayNameCache[info.Id] = info.DisplayName
		newNames[info.Id] = info.DisplayName
	end
	if next(newNames) then ReplicateDisplayNames:FireAllClients(newNames) end
end

-- --- Top players --------------------------------------------------------------
local function getTopPlayersData(boardName, count)
	local now = tick()
	local c = leaderboardCache[boardName]
	if c and now - c.timestamp < CACHE_DURATION then return c.data end

	local store = leaderboards[boardName]
	if not store then return nil end
	local ok, pages = pcall(function() return store:GetSortedAsync(false, count) end)
	if not ok then return nil end

	local data = pages:GetCurrentPage()
	local isScaled = SCALED_LEADERBOARDS[boardName]
	local topPlayers = {}
	local rank = 0
	local missingCountryIds = {}

	for i = 1, #data do
		local entry = data[i]
		local val = entry.value
		if isScaled and val > 0 then val = math.floor(LOG_BASE ^ val) end
		local userId = tonumber(entry.key)
		if not BannedUsers[userId] then
			rank += 1
			local country = nil
			if countryCache[userId] ~= nil then
				country = countryCache[userId] or nil
			else
				table.insert(missingCountryIds, userId)
			end
			topPlayers[#topPlayers + 1] = { Rank = rank, UserId = userId, Value = val, Country = country }
		end
	end

	if #missingCountryIds > 0 then
		for _, userId in ipairs(missingCountryIds) do
			task.spawn(function()
				local code = getStoredCountryCode(userId)
				if code then
					for _, p in ipairs(topPlayers) do
						if p.UserId == userId then p.Country = code; break end
					end
				end
			end)
		end
		task.wait(0.5)
	end

	leaderboardCache[boardName] = { timestamp = now, data = topPlayers }
	return topPlayers
end

local function getCountryLeaderboardData(boardName, player)
	local countryCode = getCountryCode(player)
	if not countryCode then return nil, nil end
	local globalData = getTopPlayersData(boardName, 100)
	if not globalData then return nil, nil end
	local filtered = {}
	for _, entry in ipairs(globalData) do
		if entry.Country == countryCode then
			local copy = {}
			for k, v in pairs(entry) do copy[k] = v end
			table.insert(filtered, copy)
		end
	end
	for i, entry in ipairs(filtered) do entry.Rank = i end
	return filtered, countryCode
end

-- --- Update stat (DataStore) --------------------------------------------------
function LeaderboardService:UpdatePlayerStat(player, boardName, value)
	local store = leaderboards[boardName]
	if not store then return end
	if BannedUsers[player.UserId] then return end
	local valueToStore
	if SCALED_LEADERBOARDS[boardName] then
		valueToStore = value > 0 and math.floor(math.log(value) / math.log(LOG_BASE)) or 0
	else
		valueToStore = math.floor(value)
	end
	pcall(function() store:SetAsync(player.UserId, valueToStore) end)
end

-- --- Push immédiat (vol, trade, ajout/retrait) --------------------------------
function LeaderboardService:PushPlayerNow(player)
	local playerChannel = Synchronizer:Get(player)
	if not playerChannel then return end

	local gen = RecalculateGeneration(player)
	if gen then
		LeaderboardService:UpdatePlayerStat(player, "Generation", gen)
	end

	local steals = playerChannel:Get("Steals")
	if steals then
		LeaderboardService:UpdatePlayerStat(player, "Steals", steals)
	end

	-- Invalider le cache pour forcer un refresh propre
	leaderboardCache["Generation"] = nil
	leaderboardCache["Steals"] = nil
end

-- --- Toggle region ------------------------------------------------------------
function LeaderboardService:ToggleRegion(player)
	local userId = player.UserId
	local newState = not regionHiddenCache[userId]
	regionHiddenCache[userId] = newState
	countryCache[userId] = nil
	leaderboardCache = {}
	pcall(function() regionHiddenStore:SetAsync(tostring(userId), newState) end)
	if not newState then task.spawn(getCountryCode, player) end
	return newState
end

function LeaderboardService:IsRegionHidden(player)
	return regionHiddenCache[player.UserId] == true
end

-- --- Start --------------------------------------------------------------------
function LeaderboardService:Start()

	local function SetupPlayerHooks(player)
		local playerChannel = Synchronizer:Wait(player)
		if not playerChannel then return end

		-- Hook : brainrot ajouté, retiré, volé ou échangé ? push immédiat
		playerChannel:OnChanged("AnimalAddedOrRemoved", function()
			task.spawn(function()
				LeaderboardService:PushPlayerNow(player)
			end)
		end)

		-- Hook : steal complété ? push Steals immédiat
		playerChannel:OnChanged("Steals", function()
			task.spawn(function()
				local steals = playerChannel:Get("Steals")
				if steals then
					LeaderboardService:UpdatePlayerStat(player, "Steals", steals)
					leaderboardCache["Steals"] = nil
				end
			end)
		end)
	end

	Players.PlayerAdded:Connect(function(player)
		pcall(function()
			local stored = regionHiddenStore:GetAsync(tostring(player.UserId))
			if stored == true then regionHiddenCache[player.UserId] = true end
		end)
		task.defer(getCountryCode, player)
		task.spawn(SetupPlayerHooks, player)
	end)

	Players.PlayerRemoving:Connect(function(player)
		-- Push final avant déconnexion
		task.spawn(function()
			LeaderboardService:PushPlayerNow(player)
		end)
		regionHiddenCache[player.UserId] = nil
		countryCache[player.UserId] = nil
	end)

	for _, player in ipairs(Players:GetPlayers()) do
		task.spawn(function()
			pcall(function()
				local stored = regionHiddenStore:GetAsync(tostring(player.UserId))
				if stored == true then regionHiddenCache[player.UserId] = true end
			end)
			getCountryCode(player)
		end)
		task.spawn(SetupPlayerHooks, player)
	end

	-- --- Remotes --------------------------------------------------------------
	GetTopPlayers.OnServerInvoke = function(player, boardName)
		local topPlayers = getTopPlayersData(boardName, 100)
		if topPlayers then
			local userIds = {}
			for _, d in ipairs(topPlayers) do table.insert(userIds, d.UserId) end
			getAndReplicateDisplayNames(userIds)
		end
		return topPlayers
	end

	GetTopFriends.OnServerInvoke = function(player, boardName)
		local store = leaderboards[boardName]
		if not store then return false, nil end
		if BannedUsers[player.UserId] then return false, nil end
		local ok, pages = pcall(function() return Players:GetFriendsAsync(player.UserId) end)
		if not ok then return false, nil end
		local friendIds = { player.UserId }
		local fetched = 0
		while fetched < 200 do
			local page = pages:GetCurrentPage()
			for _, info in ipairs(page) do table.insert(friendIds, info.Id); fetched += 1 end
			if pages.IsFinished then break end
			pcall(function() pages:AdvanceToNextPageAsync() end)
		end
		local infoMap = {}
		pcall(function()
			local infos = UserService:GetUserInfosByUserIdsAsync(friendIds)
			for _, info in ipairs(infos) do
				infoMap[info.Id] = info
				displayNameCache[info.Id] = info.DisplayName
			end
		end)
		local results = {}
		local pending = 0
		for _, uid in ipairs(friendIds) do
			if not BannedUsers[uid] then
				pending += 1
				task.spawn(function()
					local s, val = pcall(function() return store:GetAsync(tostring(uid)) end)
					if s and val then
						local decoded = val
						if SCALED_LEADERBOARDS[boardName] and decoded > 0 then
							decoded = math.floor(LOG_BASE ^ decoded)
						end
						local info = infoMap[uid]
						local country = nil
						local onlinePlayer = Players:GetPlayerByUserId(uid)
						if onlinePlayer then country = getCountryCode(onlinePlayer)
						else country = getStoredCountryCode(uid) end
						table.insert(results, {
							Id = uid, Amount = decoded,
							DisplayName = info and info.DisplayName or tostring(uid),
							Username = info and info.Username or tostring(uid),
							Country = country,
						})
					end
					pending -= 1
				end)
			end
		end
		local deadline = tick() + 10
		while pending > 0 and tick() < deadline do task.wait() end
		table.sort(results, function(a, b) return (a.Amount or 0) > (b.Amount or 0) end)
		return true, results
	end

	GetCountryLeaderboard.OnServerInvoke = function(player, boardName)
		local data, code = getCountryLeaderboardData(boardName, player)
		if data then
			local userIds = {}
			for _, entry in ipairs(data) do table.insert(userIds, entry.UserId) end
			getAndReplicateDisplayNames(userIds)
		end
		return data, code
	end

	GetDisplayNames.OnServerInvoke = function(player)
		return displayNameCache
	end

	-- --- Boucle 30s : recalcul génération -------------------------------------
	task.spawn(function()
		while true do
			task.wait(GENERATION_INTERVAL)
			for _, player in pairs(Players:GetPlayers()) do
				task.spawn(function()
					pcall(RecalculateGeneration, player)
				end)
			end
		end
	end)

	-- --- Boucle 60s : push DataStore + broadcast leaderboard ------------------
	task.spawn(function()
		while true do
			task.wait(UPDATE_INTERVAL)

			for _, player in pairs(Players:GetPlayers()) do
				task.spawn(function()
					pcall(function() LeaderboardService:PushPlayerNow(player) end)
				end)
			end

			task.wait(2)

			leaderboardCache = {}

			for _, player in pairs(Players:GetPlayers()) do
				task.spawn(getCountryCode, player)
			end

			for boardName in pairs(leaderboards) do
				local topPlayers = getTopPlayersData(boardName, 100)
				if topPlayers then
					local userIds = {}
					for _, d in ipairs(topPlayers) do table.insert(userIds, d.UserId) end
					getAndReplicateDisplayNames(userIds)
					ReplicateUpdate:FireAllClients(boardName, topPlayers)
					for _, player in pairs(Players:GetPlayers()) do
						task.spawn(function()
							local data, code = getCountryLeaderboardData(boardName, player)
							if data then
								ReplicateCountryUpdate:FireClient(player, boardName, data)
							end
						end)
					end
				end
			end
		end
	end)
end


return LeaderboardService
