local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DataStoreService = game:GetService("DataStoreService")
local UserService = game:GetService("UserService")
local LocalizationService = game:GetService("LocalizationService")

local Net = require(ReplicatedStorage.Packages.Net)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)

local LeaderboardService = {}


local UPDATE_INTERVAL    = 60
local CACHE_TTL          = 60
local STAT_SAVE_INTERVAL = 120

local TOP_N_TO_CACHE = 500
local TOP_N_PER_VIEW = 100


local BATCH_SIZE = 50
local BATCH_DELAY = 1
local FETCH_RETRY_DELAY = 5
local MAX_FETCH_RETRIES = 4

local MAX_CONCURRENT_US_REQUESTS = 1
local US_REQUEST_DELAY = 0.5

local MAX_CONCURRENT_DS_REQUESTS = 3
local DS_REQUEST_DELAY = 0.1

local FRIENDS_CACHE_TTL = 60
local CACHE_EXPIRY_SECONDS = 3600

local COUNTRY_CACHE_TTL = CACHE_TTL

local COUNTRY_TOP_N = 100

local LEADERBOARD_NAMES = { "Generation", "Steals" }


local leaderboards = {}
for _, name in ipairs(LEADERBOARD_NAMES) do
	leaderboards[name] = DataStoreService:GetOrderedDataStore(name .. "Leaderboard_2")
end

local countryOdsCache: { [string]: any } = {}
local function getCountryOds(boardName: string, country: string): any?
	if type(country) ~= "string" or #country ~= 2 then return nil end
	local key = boardName .. ":" .. country
	local store = countryOdsCache[key]
	if not store then
		local name = "Lb_" .. boardName .. "_" .. country
		local ok, result = pcall(function()
			return DataStoreService:GetOrderedDataStore(name)
		end)
		if ok then
			store = result
			countryOdsCache[key] = store
		end
	end
	return store
end

local cacheStore = DataStoreService:GetDataStore("LeaderboardCacheV1")

local countryStore = DataStoreService:GetDataStore("PlayerCountryCodes_1")


local displayNameCache: { [number]: string } = {}
local displayNameCacheTime: { [number]: number } = {}

local countryCache: { [number]: any } = {}
local countryCacheTime: { [number]: number } = {}

local cachedTopPlayers: { [string]: any } = {}
local cachedFriendsResults: { [number]: { [string]: { time: number, data: any } } } = {}


local GetDisplayNames        = Net:RemoteFunction("Leaderboard/GetDisplayNames")
local GetTopPlayers          = Net:RemoteFunction("Leaderboard/GetTopPlayers")
local GetTopFriends          = Net:RemoteFunction("Leaderboard/GetTopFriends")
local GetCountryLeaderboard  = Net:RemoteFunction("Leaderboard/GetCountryLeaderboard")
local ReplicateDisplayNames  = Net:RemoteEvent("Leaderboard/ReplicateDisplayNames")
local ReplicateUpdate        = Net:RemoteEvent("Leaderboard/ReplicateUpdate")
local ReplicateCountryUpdate = Net:RemoteEvent("Leaderboard/ReplicateCountryUpdate")


local dsQueueRunning = 0
local dsQueue: { () -> () } = {}

local function drainQueue()
	while #dsQueue > 0 and dsQueueRunning < MAX_CONCURRENT_DS_REQUESTS do
		local fn = table.remove(dsQueue, 1)
		dsQueueRunning += 1
		task.spawn(function()
			fn()
			dsQueueRunning -= 1
			task.wait(DS_REQUEST_DELAY)
			drainQueue()
		end)
	end
end

local function queueDataStoreRequest(fn: () -> ())
	table.insert(dsQueue, fn)
	drainQueue()
end


local usQueueRunning = 0
local usQueue: { () -> () } = {}

local function drainUsQueue()
	while #usQueue > 0 and usQueueRunning < MAX_CONCURRENT_US_REQUESTS do
		local fn = table.remove(usQueue, 1)
		usQueueRunning += 1
		task.spawn(function()
			fn()
			usQueueRunning -= 1
			task.wait(US_REQUEST_DELAY)
			drainUsQueue()
		end)
	end
end

local function queueUsRequest(fn: () -> ())
	table.insert(usQueue, fn)
	drainUsQueue()
end

local pendingDisplayNameIds: { [number]: boolean } = {}


local function decodeValue(boardName: string, rawValue: number): number
	return rawValue
end

local function getAndReplicateDisplayNames(userIds: { number })
	local idsToFetch = {}
	for _, id in ipairs(userIds) do
		if not displayNameCache[id] and not pendingDisplayNameIds[id] then
			pendingDisplayNameIds[id] = true
			table.insert(idsToFetch, id)
		end
	end
	if #idsToFetch == 0 then return end

	local batches = {}
	for i = 1, #idsToFetch, BATCH_SIZE do
		local batch = {}
		for j = i, math.min(i + BATCH_SIZE - 1, #idsToFetch) do
			table.insert(batch, idsToFetch[j])
		end
		table.insert(batches, batch)
	end

	for batchIndex, batch in ipairs(batches) do
		if batchIndex > 1 then task.wait(BATCH_DELAY) end

		queueUsRequest(function()
			local success, result
			for attempt = 1, MAX_FETCH_RETRIES do
				success, result = pcall(function()
					return UserService:GetUserInfosByUserIdsAsync(batch)
				end)
				if success then break end
				local delay = FETCH_RETRY_DELAY * (2 ^ (attempt - 1))
				warn(string.format(
					"LeaderboardService: GetUserInfosByUserIdsAsync attempt %d/%d failed (%s) — retrying in %.0fs",
					attempt, MAX_FETCH_RETRIES, tostring(result), delay
					))
				if attempt < MAX_FETCH_RETRIES then task.wait(delay) end
			end

			for _, id in ipairs(batch) do
				pendingDisplayNameIds[id] = nil
			end

			if not success then
				warn("LeaderboardService: Giving up on display name batch:", result)
				return
			end

			local newNames = {}
			for _, info in ipairs(result) do
				displayNameCache[info.Id] = info.DisplayName
				displayNameCacheTime[info.Id] = os.time()
				newNames[info.Id] = info.DisplayName
			end
			if next(newNames) then
				ReplicateDisplayNames:FireAllClients(newNames)
			end
		end)
	end
end

local function getPlayerCountry(player: Player): string?
	local ok, code = pcall(function()
		return LocalizationService:GetCountryRegionForPlayerAsync(player)
	end)
	if ok and type(code) == "string" and #code == 2 then
		return code
	end
	return nil
end

local function loadCountryFromStore(userId: number): (boolean, string?)
	local ok, code = pcall(function()
		return countryStore:GetAsync(tostring(userId))
	end)
	if not ok then return false, nil end
	if type(code) == "string" and #code == 2 then return true, code end
	return true, nil
end

local function saveCountryToStore(userId: number, countryCode: string)
	queueDataStoreRequest(function()
		pcall(function()
			countryStore:SetAsync(tostring(userId), countryCode)
		end)
	end)
end

local function resolveCountry(userId: number): string?
	local v = countryCache[userId]
	if type(v) == "string" then return v end
	return nil
end

local function getGlobalView(boardName: string): { any }
	local all = cachedTopPlayers[boardName]
	if not all then return {} end
	local view = {}
	for i = 1, math.min(TOP_N_PER_VIEW, #all) do
		view[i] = all[i]
	end
	return view
end

local function getLiveStatValue(player: Player, boardName: string): number?
	local value: number? = nil
	pcall(function()
		local channel = Synchronizer:Get(player)
		if channel then
			local v = channel:Get(boardName)
			if type(v) == "number" then value = v end
		end
	end)
	return value
end

local function initPlayer(player: Player)
	displayNameCache[player.UserId] = player.DisplayName
	displayNameCacheTime[player.UserId] = os.time()

	local country = getPlayerCountry(player)
	if country then
		countryCache[player.UserId] = country
		countryCacheTime[player.UserId] = os.time()
		saveCountryToStore(player.UserId, country)
	end
end


local function isCacheFresh(cache: any?): boolean
	if type(cache) ~= "table" then return false end
	local updatedAt = tonumber(cache.UpdatedAt) or 0
	return (os.time() - updatedAt) < CACHE_TTL
end

local function readBoardCache(boardName: string): any?
	local ok, data = pcall(function()
		return cacheStore:GetAsync(boardName)
	end)
	if ok and type(data) == "table" then return data end
	return nil
end

local function applyCache(boardName: string, cache: any)
	if type(cache) ~= "table" or type(cache.Entries) ~= "table" then return end

	local entries = {}
	for rank, e in ipairs(cache.Entries) do
		if type(e) == "table" and e.UserId then
			if type(e.DisplayName) == "string" and not displayNameCache[e.UserId] then
				displayNameCache[e.UserId] = e.DisplayName
				displayNameCacheTime[e.UserId] = os.time()
			end
			if type(e.Country) == "string" and not countryCache[e.UserId] then
				countryCache[e.UserId] = e.Country
				countryCacheTime[e.UserId] = os.time()
			end

			table.insert(entries, {
				Rank    = rank,
				UserId  = e.UserId,
				Value   = e.Value,
				Country = type(e.Country) == "string" and e.Country or nil,
			})
		end
	end
	cachedTopPlayers[boardName] = entries
end

local function fetchSortedTopN(boardName: string, n: number): { any }?
	local store = leaderboards[boardName]
	if not store then return nil end

	local pageSize = math.min(n, 100)
	local ok, pages = pcall(function()
		return store:GetSortedAsync(false, pageSize)
	end)
	if not ok then
		warn("LeaderboardService: GetSortedAsync failed for", boardName, ":", pages)
		return nil
	end

	local all = {}
	while true do
		local current = pages:GetCurrentPage()
		for _, entry in ipairs(current) do
			table.insert(all, entry)
			if #all >= n then return all end
		end
		if pages.IsFinished then break end
		local advOk, advErr = pcall(function() pages:AdvanceToNextPageAsync() end)
		if not advOk then
			warn("LeaderboardService: AdvanceToNextPageAsync failed for", boardName, ":", advErr)
			break
		end
		task.wait(0.5)
	end
	return all
end

local function rebuildBoardEntries(boardName: string, previousEntries: { any }?): any?
	local rawData = fetchSortedTopN(boardName, TOP_N_TO_CACHE)
	if not rawData then return nil end

	local prevByUserId = {}
	if previousEntries then
		for _, e in ipairs(previousEntries) do
			if e.UserId then prevByUserId[e.UserId] = e end
		end
	end

	local userIdsNeedingCountry = {}
	local userIdsNeedingDisplayName = {}

	for _, raw in ipairs(rawData) do
		local uid = tonumber(raw.key)
		if uid then
			if not countryCache[uid] then
				local prev = prevByUserId[uid]
				if prev and type(prev.Country) == "string" then
					countryCache[uid] = prev.Country
					countryCacheTime[uid] = os.time()
				else
					table.insert(userIdsNeedingCountry, uid)
				end
			end

			if not displayNameCache[uid] then
				local prev = prevByUserId[uid]
				if prev and type(prev.DisplayName) == "string" then
					displayNameCache[uid] = prev.DisplayName
					displayNameCacheTime[uid] = os.time()
				else
					table.insert(userIdsNeedingDisplayName, uid)
				end
			end
		end
	end

	if #userIdsNeedingDisplayName > 0 then
		task.spawn(getAndReplicateDisplayNames, userIdsNeedingDisplayName)
	end

	for _, uid in ipairs(userIdsNeedingCountry) do
		local ok2, code = loadCountryFromStore(uid)
		if ok2 then
			countryCache[uid] = code or false
			countryCacheTime[uid] = os.time()
		end
		task.wait(0.15)
	end

	local entries = {}
	for rank, raw in ipairs(rawData) do
		local uid = tonumber(raw.key)
		if uid then
			local country = type(countryCache[uid]) == "string" and countryCache[uid] or nil
			table.insert(entries, {
				Rank        = rank,
				UserId      = uid,
				Value       = decodeValue(boardName, raw.value),
				Country     = country,
				DisplayName = displayNameCache[uid],
			})
		end
	end

	return entries
end

local function tryClaimAndRebuild(boardName: string): any?
	local won = false
	local existingEntries: { any }? = nil

	local ok, _err = pcall(function()
		cacheStore:UpdateAsync(boardName, function(old)
			if isCacheFresh(old) then
				return nil
			end
			won = true
			if type(old) == "table" and type(old.Entries) == "table" then
				existingEntries = old.Entries
			end
			return {
				UpdatedAt = os.time(),
				Entries   = existingEntries or {},
				Building  = true,
			}
		end)
	end)
	if not ok then
		warn("LeaderboardService: tryClaimAndRebuild UpdateAsync failed for", boardName, ":", _err)
		return nil
	end

	if not won then return nil end

	local entries = rebuildBoardEntries(boardName, existingEntries)
	if not entries then return nil end

	local newCache = {
		UpdatedAt = os.time(),
		Entries   = entries,
	}
	pcall(function()
		cacheStore:SetAsync(boardName, newCache)
	end)
	return newCache
end



local function countryCacheKey(boardName: string, country: string): string
	return "Country:" .. boardName .. ":" .. country
end

local function readCountryCache(boardName: string, country: string): any?
	local ok, data = pcall(function()
		return cacheStore:GetAsync(countryCacheKey(boardName, country))
	end)
	if ok and type(data) == "table" then return data end
	return nil
end

local function applyCountryCache(country: string, cache: any): { any }
	if type(cache) ~= "table" or type(cache.Entries) ~= "table" then return {} end
	local result = {}
	for rank, e in ipairs(cache.Entries) do
		if type(e) == "table" and e.UserId then
			if type(e.DisplayName) == "string" and not displayNameCache[e.UserId] then
				displayNameCache[e.UserId] = e.DisplayName
				displayNameCacheTime[e.UserId] = os.time()
			end
			if not countryCache[e.UserId] then
				countryCache[e.UserId] = country
				countryCacheTime[e.UserId] = os.time()
			end
			table.insert(result, {
				Rank    = rank,
				UserId  = e.UserId,
				Value   = e.Value,
				Country = country,
			})
		end
	end
	return result
end

local function rebuildCountryEntries(boardName: string, country: string, previousEntries: { any }?): { any }?
	local store = getCountryOds(boardName, country)
	if not store then return nil end

	local rawData = (function()
		local pageSize = math.min(COUNTRY_TOP_N, 100)
		local ok, pages = pcall(function()
			return store:GetSortedAsync(false, pageSize)
		end)
		if not ok then
			warn("LeaderboardService: country GetSortedAsync failed for", boardName, country, ":", pages)
			return nil
		end

		local all = {}
		while true do
			local page = pages:GetCurrentPage()
			for _, entry in ipairs(page) do
				table.insert(all, entry)
				if #all >= COUNTRY_TOP_N then return all end
			end
			if pages.IsFinished then break end
			local advOk, advErr = pcall(function() pages:AdvanceToNextPageAsync() end)
			if not advOk then
				warn("LeaderboardService: country AdvanceToNextPageAsync failed for", boardName, country, ":", advErr)
				break
			end
			task.wait(0.5)
		end
		return all
	end)()

	if not rawData then return nil end

	local prevDisplayName: { [number]: string } = {}
	if previousEntries then
		for _, e in ipairs(previousEntries) do
			if e.UserId and type(e.DisplayName) == "string" then
				prevDisplayName[e.UserId] = e.DisplayName
			end
		end
	end

	local missingNames = {}
	for _, raw in ipairs(rawData) do
		local uid = tonumber(raw.key)
		if uid then
			if not displayNameCache[uid] then
				if prevDisplayName[uid] then
					displayNameCache[uid] = prevDisplayName[uid]
					displayNameCacheTime[uid] = os.time()
				else
					table.insert(missingNames, uid)
				end
			end
		end
	end
	if #missingNames > 0 then
		task.spawn(getAndReplicateDisplayNames, missingNames)
	end

	local entries = {}
	for rank, raw in ipairs(rawData) do
		local uid = tonumber(raw.key)
		if uid then
			table.insert(entries, {
				Rank        = rank,
				UserId      = uid,
				Value       = decodeValue(boardName, raw.value),
				Country     = country,
				DisplayName = displayNameCache[uid],
			})
		end
	end

	return entries
end

local function tryClaimAndRebuildCountry(boardName: string, country: string): any?
	local key = countryCacheKey(boardName, country)
	local won = false
	local existingEntries: { any }? = nil

	local ok, _err = pcall(function()
		cacheStore:UpdateAsync(key, function(old)
			if isCacheFresh(old) then
				return nil
			end
			won = true
			if type(old) == "table" and type(old.Entries) == "table" then
				existingEntries = old.Entries
			end
			return {
				UpdatedAt = os.time(),
				Entries   = existingEntries or {},
				Building  = true,
			}
		end)
	end)
	if not ok then
		warn("LeaderboardService: tryClaimAndRebuildCountry UpdateAsync failed for", key, ":", _err)
		return nil
	end

	if not won then return nil end

	local entries = rebuildCountryEntries(boardName, country, existingEntries)
	if not entries then return nil end

	local newCache = {
		UpdatedAt = os.time(),
		Entries   = entries,
	}
	pcall(function()
		cacheStore:SetAsync(key, newCache)
	end)
	return newCache
end

local function getOrBuildCountryEntries(boardName: string, country: string): { any }
	local cache = readCountryCache(boardName, country)
	if not isCacheFresh(cache) then
		local rebuilt = tryClaimAndRebuildCountry(boardName, country)
		if rebuilt then
			cache = rebuilt
		else
			local re = readCountryCache(boardName, country)
			if re then cache = re end
		end
	end
	if not cache then return {} end
	return applyCountryCache(country, cache)
end

local function getCountryLeaderboardData(boardName: string, requestingPlayer: Player): (any, string?)
	local playerCountry = resolveCountry(requestingPlayer.UserId)
	if not playerCountry then
		playerCountry = getPlayerCountry(requestingPlayer)
		if playerCountry then
			countryCache[requestingPlayer.UserId] = playerCountry
			countryCacheTime[requestingPlayer.UserId] = os.time()
			saveCountryToStore(requestingPlayer.UserId, playerCountry)
		end
	end
	if not playerCountry then return {}, nil end
	return getOrBuildCountryEntries(boardName, playerCountry), playerCountry
end


local function getFriendsLeaderboardData(boardName: string, player: Player): (boolean, any)
	local userCache = cachedFriendsResults[player.UserId]
	if userCache and userCache[boardName] then
		local entry = userCache[boardName]
		if os.time() - entry.time < FRIENDS_CACHE_TTL then
			return true, entry.data
		end
	end

	local topByUserId: { [number]: number } = {}
	local globalTop = cachedTopPlayers[boardName]
	if globalTop then
		for _, e in ipairs(globalTop) do topByUserId[e.UserId] = e.Value end
	end

	local liveByUserId: { [number]: number } = {}
	for _, p in ipairs(Players:GetPlayers()) do
		local v = getLiveStatValue(p, boardName)
		if v then liveByUserId[p.UserId] = v end
	end

	local seen: { [number]: boolean } = { [player.UserId] = true }
	local friendIds = { player.UserId }
	local friendInfo: { [number]: { DisplayName: string, Username: string } } = {
		[player.UserId] = {
			DisplayName = displayNameCache[player.UserId] or player.DisplayName,
			Username    = player.Name,
		},
	}

	local pagesOk, friendPages = pcall(function()
		return Players:GetFriendsAsync(player.UserId)
	end)

	if pagesOk and friendPages then
		local pageOk = true
		while pageOk do
			local page = friendPages:GetCurrentPage()
			for _, friend in ipairs(page) do
				if not seen[friend.Id] then
					seen[friend.Id] = true
					table.insert(friendIds, friend.Id)
					friendInfo[friend.Id] = {
						DisplayName = friend.DisplayName,
						Username    = friend.Username,
					}
					displayNameCache[friend.Id] = friend.DisplayName
					displayNameCacheTime[friend.Id] = os.time()
				end
			end
			if friendPages.IsFinished then break end
			task.wait(0.5)
			pageOk = pcall(function() friendPages:AdvanceToNextPageAsync() end)
		end
	else
		warn("LeaderboardService: GetFriendsAsync failed for", player.Name, "- showing self only:", friendPages)
	end

	local entries = {}
	for _, userId in ipairs(friendIds) do
		local value = topByUserId[userId] or liveByUserId[userId]
		if value == nil and userId == player.UserId then value = 0 end
		if value ~= nil then
			local info = friendInfo[userId] or {}
			table.insert(entries, {
				Id          = userId,
				Amount      = value,
				DisplayName = info.DisplayName or displayNameCache[userId] or tostring(userId),
				Username    = info.Username or tostring(userId),
				Country     = resolveCountry(userId),
			})
		end
	end

	table.sort(entries, function(a, b) return (a.Amount or 0) > (b.Amount or 0) end)

	if not cachedFriendsResults[player.UserId] then
		cachedFriendsResults[player.UserId] = {}
	end
	cachedFriendsResults[player.UserId][boardName] = {
		time = os.time(),
		data = entries,
	}

	local needNames = {}
	for _, e in ipairs(entries) do
		if not displayNameCache[e.Id] then table.insert(needNames, e.Id) end
	end
	if #needNames > 0 then
		task.spawn(getAndReplicateDisplayNames, needNames)
	end

	return true, entries
end


function LeaderboardService:UpdatePlayerStat(player: Player, boardName: string, value: number)
	local store = leaderboards[boardName]
	if not store then return end

	if value >= 9e18 then value = 9e18 end
	local valueToStore = math.floor(value)

	queueDataStoreRequest(function()
		pcall(function()
			store:SetAsync(tostring(player.UserId), valueToStore)
		end)
	end)

	local country = resolveCountry(player.UserId)
	if country then
		local countryStore_ = getCountryOds(boardName, country)
		if countryStore_ then
			queueDataStoreRequest(function()
				pcall(function()
					countryStore_:SetAsync(tostring(player.UserId), valueToStore)
				end)
			end)
		end
	end
end


function LeaderboardService:Start()

	Players.PlayerAdded:Connect(function(player: Player)
		task.spawn(initPlayer, player)

		task.spawn(function()
			Synchronizer:WaitAndCall(player, function(callback)
				callback:OnChanged("Generation", function(value: number)
					LeaderboardService:UpdatePlayerStat(player, "Generation", value)
				end)
			end)
		end)

		task.spawn(function()
			Synchronizer:WaitAndCall(player, function(callback)
				local generation = callback:Get("Generation")
				if type(generation) == "number" and generation > 0 then
					LeaderboardService:UpdatePlayerStat(player, "Generation", generation)
				end

				local steals = callback:Get("Steals")
				if type(steals) == "number" and steals > 0 then
					LeaderboardService:UpdatePlayerStat(player, "Steals", steals)
				end
			end)
		end)
		task.delay(2, function()
			if player.Parent and next(displayNameCache) then
				ReplicateDisplayNames:FireClient(player, displayNameCache)
			end
		end)
	end)

	Players.PlayerRemoving:Connect(function(player: Player)
		cachedFriendsResults[player.UserId] = nil
	end)

	for _, player in ipairs(Players:GetPlayers()) do
		task.spawn(initPlayer, player)
	end

	local function isValidBoard(boardName: any): boolean
		if type(boardName) ~= "string" then return false end
		for _, name in ipairs(LEADERBOARD_NAMES) do
			if name == boardName then return true end
		end
		return false
	end

	GetTopPlayers.OnServerInvoke = function(_player: Player, boardName: string)
		if not isValidBoard(boardName) then return nil end
		return getGlobalView(boardName)
	end

	GetTopFriends.OnServerInvoke = function(player: Player, boardName: string)
		if not isValidBoard(boardName) then return false, nil end
		return getFriendsLeaderboardData(boardName, player)
	end

	GetCountryLeaderboard.OnServerInvoke = function(player: Player, boardName: string)
		if not isValidBoard(boardName) then return nil, nil end
		local data, code = getCountryLeaderboardData(boardName, player)
		if data and #data > 0 then
			local userIds = {}
			for _, e in ipairs(data) do table.insert(userIds, e.UserId) end
			task.spawn(getAndReplicateDisplayNames, userIds)
		end
		return data, code
	end

	GetDisplayNames.OnServerInvoke = function(_player: Player)
		return displayNameCache
	end

	task.spawn(function()
		while true do
			task.wait(STAT_SAVE_INTERVAL)
			for _, player: Player in ipairs(Players:GetPlayers()) do
				task.spawn(function()
					local channel = Synchronizer:Get(player)
					if not channel then return end
					local steals = channel:Get("Steals")
					if steals then
						LeaderboardService:UpdatePlayerStat(player, "Steals", steals)
					end
				end)
				task.wait(0.05)
			end
		end
	end)

	local function refreshCacheCycle()
		for _, boardName in ipairs(LEADERBOARD_NAMES) do
			local cache = readBoardCache(boardName)
			if not isCacheFresh(cache) then
				local rebuilt = tryClaimAndRebuild(boardName)
				if rebuilt then
					cache = rebuilt
				else
					local re = readBoardCache(boardName)
					if re then cache = re end
				end
			end

			if cache then
				applyCache(boardName, cache)

				local nameMap = {}
				if type(cache.Entries) == "table" then
					for _, e in ipairs(cache.Entries) do
						if e.UserId and type(e.DisplayName) == "string" then
							nameMap[e.UserId] = e.DisplayName
						end
					end
				end
				if next(nameMap) then
					ReplicateDisplayNames:FireAllClients(nameMap)
				end

				local missingNames = {}
				for _, e in ipairs(cachedTopPlayers[boardName]) do
					if not displayNameCache[e.UserId] then
						table.insert(missingNames, e.UserId)
					end
				end
				if #missingNames > 0 then
					task.spawn(getAndReplicateDisplayNames, missingNames)
				end

				ReplicateUpdate:FireAllClients(boardName, getGlobalView(boardName))
			end
		end

		local countriesInServer: { [string]: boolean } = {}
		for _, player in ipairs(Players:GetPlayers()) do
			local c = resolveCountry(player.UserId)
			if c then countriesInServer[c] = true end
		end

		for _, boardName in ipairs(LEADERBOARD_NAMES) do
			local entriesByCountry: { [string]: any } = {}
			for country in pairs(countriesInServer) do
				entriesByCountry[country] = getOrBuildCountryEntries(boardName, country)
			end
			for _, player in ipairs(Players:GetPlayers()) do
				local country = resolveCountry(player.UserId)
				if country and entriesByCountry[country] then
					ReplicateCountryUpdate:FireClient(player, boardName, entriesByCountry[country], country)
				end
			end
		end

		for userId, byBoard in pairs(cachedFriendsResults) do
			for boardName, entry in pairs(byBoard) do
				if os.time() - entry.time >= FRIENDS_CACHE_TTL then
					byBoard[boardName] = nil
				end
			end
			if next(byBoard) == nil then
				cachedFriendsResults[userId] = nil
			end
		end
	end

	local function cleanStaleCaches()
		local now = os.time()
		for userId, timestamp in pairs(displayNameCacheTime) do
			if now - timestamp > CACHE_EXPIRY_SECONDS then
				displayNameCache[userId] = nil
				displayNameCacheTime[userId] = nil
			end
		end
		for userId, timestamp in pairs(countryCacheTime) do
			if countryCache[userId] ~= false and now - timestamp > CACHE_EXPIRY_SECONDS then
				countryCache[userId] = nil
				countryCacheTime[userId] = nil
			end
		end
	end

	task.spawn(function()
		task.wait(math.random(1, 15))
		refreshCacheCycle()
		while true do
			task.wait(UPDATE_INTERVAL)
			refreshCacheCycle()
			cleanStaleCaches()
		end
	end)
end

return LeaderboardService