local HoverInfoService = {}

local DataStoreService   = game:GetService("DataStoreService")
local MemoryStoreService = game:GetService("MemoryStoreService")
local ReplicatedStorage  = game:GetService("ReplicatedStorage")
local Players            = game:GetService("Players")

local Synchronizer     = require(ReplicatedStorage.Packages.Synchronizer)
local ReplicatorServer = require(ReplicatedStorage.Packages.ReplicatorServer)


local EXIST_COUNTS_ID = "ExistCounts"
local existsRep       = ReplicatorServer.get(EXIST_COUNTS_ID, {})

local SYNC_EVERY     = 60
local FAST_SYNC      = 3
local SHARD_TTL      = 150
local DELTA_TTL      = 3600
local SHARD_PAGE_CAP = 50
local DELTA_PAGE_CAP = 50
local DS_BUDGET_MIN  = 5

local LEASE_TTL  = 240
local LEASE_POLL = 90

local SERVER_KEY = (game.JobId ~= "" and game.JobId) or "studio_local"

local ExistDS   = DataStoreService:GetDataStore("ExistCounts")
local ContribDS = DataStoreService:GetDataStore("EC_OfflineContrib_v2")

local OFFLINE_AGG_KEY = "offlineAggregate_v2"
local GLOBAL_KEY      = "globalCensus_v2"
local LEGACY_EXISTS   = "exists"

local ShardMap         = MemoryStoreService:GetSortedMap("EC_OnlineShards_v1")
local DeltaMap         = MemoryStoreService:GetSortedMap("EC_DeltaQueue_v1")
local LeaseMap         = MemoryStoreService:GetSortedMap("EC_WriterLease_v1")
local LegacyOfflineMap = MemoryStoreService:GetSortedMap("EC_Offline_v1")

local LEASE_KEY = "ec_writer"

local globalCensus     = {}
local offlineAgg       = {}
local offlineAggLoaded = false
local leaseExpiry      = 0
local lastLeaseAttempt = -1e9
local legacyCleanedUp  = false

local myOnline         = {}
local myPublishedShard = {}
local globalDirty      = true

local function dsBudgetOk(reqType, minBudget)
	return DataStoreService:GetRequestBudgetForRequestType(reqType) >= (minBudget or 1)
end

local function countFromPodiums(podiums)
	local counts = {}
	for _, entry in pairs(podiums) do
		if type(entry) ~= "table" or not entry.Index then continue end
		if entry.Steal then continue end
		local animalKey   = entry.Index
		local mutationKey = entry.Mutation or "None"
		if not counts[animalKey] then
			counts[animalKey] = { mutations = {} }
		end
		counts[animalKey].mutations[mutationKey] = (counts[animalKey].mutations[mutationKey] or 0) + 1
	end
	return counts
end

local function mergeCounts(total, counts)
	if type(counts) ~= "table" then return end
	for animalKey, animalData in pairs(counts) do
		if type(animalData) == "table" and type(animalData.mutations) == "table" then
			if not total[animalKey] then
				total[animalKey] = { mutations = {} }
			end
			for mutKey, count in pairs(animalData.mutations) do
				if type(count) == "number" then
					total[animalKey].mutations[mutKey] = (total[animalKey].mutations[mutKey] or 0) + count
				end
			end
		end
	end
end

local function countLocalOnline()
	local total = {}
	for _, player in ipairs(Players:GetPlayers()) do
		local ok, channel = pcall(function() return Synchronizer:Get(player) end)
		if ok and channel then
			local ok2, podiums = pcall(function() return channel:Get("AnimalPodiums") end)
			if ok2 and type(podiums) == "table" then
				mergeCounts(total, countFromPodiums(podiums))
			else
				warn("[HoverInfoService] AnimalPodiums read failed for", player.UserId)
			end
		end
	end
	return total
end

local function applyCensus(dst, src, sign)
	if type(src) ~= "table" then return end
	for animalKey, animalData in pairs(src) do
		if type(animalData) == "table" and type(animalData.mutations) == "table" then
			local bucket = dst[animalKey]
			for mutKey, count in pairs(animalData.mutations) do
				if type(count) == "number" then
					if not bucket then
						bucket = { mutations = {} }
						dst[animalKey] = bucket
					end
					local nv = (bucket.mutations[mutKey] or 0) + sign * count
					bucket.mutations[mutKey] = (nv > 0) and nv or nil
				end
			end
			if bucket and next(bucket.mutations) == nil then
				dst[animalKey] = nil
			end
		end
	end
end

local function cloneCensus(src)
	local out = {}
	for animalKey, animalData in pairs(src) do
		if type(animalData) == "table" and type(animalData.mutations) == "table" then
			local muts = {}
			for mutKey, count in pairs(animalData.mutations) do
				muts[mutKey] = count
			end
			out[animalKey] = { mutations = muts }
		end
	end
	return out
end

local function censusEqual(a, b)
	for animalKey, ad in pairs(a) do
		local bd = b[animalKey]
		if type(ad) ~= "table" or type(bd) ~= "table" then return false end
		for mutKey, count in pairs(ad.mutations) do
			if bd.mutations[mutKey] ~= count then return false end
		end
		for mutKey in pairs(bd.mutations) do
			if ad.mutations[mutKey] == nil then return false end
		end
	end
	for animalKey in pairs(b) do
		if a[animalKey] == nil then return false end
	end
	return true
end

local function readContrib(userId)
	local ok, v = pcall(function() return ContribDS:GetAsync(tostring(userId)) end)
	if ok and type(v) == "table" then return v end
	return nil
end

local function writeContrib(userId, census)
	return pcall(function() ContribDS:SetAsync(tostring(userId), census, { userId }) end)
end

local function clearContrib(userId)
	for _ = 1, 3 do
		local ok = pcall(function() ContribDS:RemoveAsync(tostring(userId)) end)
		if ok then return true end
		task.wait(1)
	end
	return false
end

local function enqueueDelta(census, sign)
	if type(census) ~= "table" or next(census) == nil then return true end
	for _ = 1, 3 do
		local ok = pcall(function()
			DeltaMap:UpdateAsync(SERVER_KEY, function(cur)
				local acc = (type(cur) == "table") and cur or {}
				applyCensus(acc, census, sign)
				return acc
			end, DELTA_TTL)
		end)
		if ok then return true end
		task.wait(0.5)
	end
	warn("[HoverInfoService] enqueueDelta failed after retries")
	return false
end

local function markOffline(userId, census)
	census = census or {}
	local prev = readContrib(userId)
	if not writeContrib(userId, census) then
		warn("[HoverInfoService] markOffline: contrib write failed for", userId)
		return
	end
	if prev then enqueueDelta(prev, -1) end
	enqueueDelta(census, 1)
end

local function markOnline(userId)
	local prev = readContrib(userId)
	if not prev then return end
	clearContrib(userId)
	enqueueDelta(prev, -1)
end

local function publishShard(localOnline)
	pcall(function()
		ShardMap:SetAsync(SERVER_KEY, localOnline, SHARD_TTL)
	end)
end

local function sumAllShards(total)
	local lower = nil
	for _ = 1, SHARD_PAGE_CAP do
		local ok, items = pcall(function()
			return ShardMap:GetRangeAsync(Enum.SortDirection.Ascending, 200, lower)
		end)
		if not ok or type(items) ~= "table" or #items == 0 then break end
		for _, item in ipairs(items) do
			mergeCounts(total, item.value)
		end
		if #items < 200 then break end
		lower = items[#items].key
	end
end

local function tryAcquireLease()
	local won = false
	local ok = pcall(function()
		LeaseMap:UpdateAsync(LEASE_KEY, function(current)
			local serverNow = workspace:GetServerTimeNow()
			if not current
				or type(current) ~= "table"
				or (current.expires or 0) <= serverNow
				or current.jobId == game.JobId
			then
				won = true
				return { jobId = game.JobId, expires = serverNow + LEASE_TTL }
			end
			return nil
		end, LEASE_TTL + 60)
	end)

	if ok and won then
		leaseExpiry = workspace:GetServerTimeNow() + LEASE_TTL
		return true
	end
	leaseExpiry = 0
	return false
end

local function ensureLeadership()
	local serverNow = workspace:GetServerTimeNow()
	if leaseExpiry > serverNow + 60 then
		return true
	end
	if leaseExpiry > 0 then
		return tryAcquireLease()
	end
	local now = os.clock()
	if now - lastLeaseAttempt < LEASE_POLL * (0.75 + math.random() * 0.5) then
		return false
	end
	lastLeaseAttempt = now
	return tryAcquireLease()
end

local function releaseLease()
	if leaseExpiry == 0 then return end
	leaseExpiry = 0
	pcall(function()
		LeaseMap:UpdateAsync(LEASE_KEY, function(current)
			if type(current) == "table" and current.jobId == game.JobId then
				return { jobId = game.JobId, expires = 0 }
			end
			return nil
		end, 60)
	end)
end

local function loadAggregate()
	local ok, data = pcall(function() return ExistDS:GetAsync(OFFLINE_AGG_KEY) end)
	if ok and type(data) == "table" then return data end
	return {}
end

local function saveAggregate(agg)
	if not dsBudgetOk(Enum.DataStoreRequestType.SetIncrementAsync, DS_BUDGET_MIN) then return end
	pcall(function() ExistDS:SetAsync(OFFLINE_AGG_KEY, agg) end)
end

local function drainDeltas(agg)
	local lower = nil
	for _ = 1, DELTA_PAGE_CAP do
		local ok, items = pcall(function()
			return DeltaMap:GetRangeAsync(Enum.SortDirection.Ascending, 200, lower)
		end)
		if not ok or type(items) ~= "table" or #items == 0 then break end
		for _, item in ipairs(items) do
			if type(item.value) == "table" and next(item.value) ~= nil then
				local captured = nil
				pcall(function()
					DeltaMap:UpdateAsync(item.key, function(cur)
						captured = cur
						return {}
					end, DELTA_TTL)
				end)
				if type(captured) == "table" then
					applyCensus(agg, captured, 1)
				end
			end
		end
		if #items < 200 then break end
		lower = items[#items].key
	end
end

local function readGlobal()
	local ok, data = pcall(function() return ExistDS:GetAsync(GLOBAL_KEY) end)
	if ok and type(data) == "table" then return data end
	return nil
end

local function saveGlobal(census)
	if not dsBudgetOk(Enum.DataStoreRequestType.SetIncrementAsync, DS_BUDGET_MIN) then return end
	pcall(function() ExistDS:SetAsync(GLOBAL_KEY, census) end)
end

local function cleanupLegacyOffline()
	if legacyCleanedUp then return end
	legacyCleanedUp = true
	task.spawn(function()
		local lower, removed = nil, 0
		while leaseExpiry > workspace:GetServerTimeNow() do
			local ok, items = pcall(function()
				return LegacyOfflineMap:GetRangeAsync(Enum.SortDirection.Ascending, 100, lower)
			end)
			if not ok or type(items) ~= "table" or #items == 0 then break end
			for _, item in ipairs(items) do
				pcall(function() LegacyOfflineMap:RemoveAsync(item.key) end)
				removed += 1
			end
			lower = items[#items].key
			task.wait(2)
		end
		if removed > 0 then
			warn(string.format("[HoverInfoService] Legacy offline cleanup removed %d stale entries", removed))
		end
	end)
end

local function buildDisplayed()
	local d = cloneCensus(globalCensus)
	applyCensus(d, myPublishedShard, -1)
	mergeCounts(d, myOnline)
	return d
end

local function replicateDisplayed()
	existsRep:SetData(buildDisplayed())
end

local function step()
	myOnline = countLocalOnline()
	publishShard(myOnline)
	myPublishedShard = cloneCensus(myOnline)

	if ensureLeadership() then
		if not offlineAggLoaded then
			offlineAgg = loadAggregate()
			offlineAggLoaded = true
		end
		cleanupLegacyOffline()
		drainDeltas(offlineAgg)
		saveAggregate(offlineAgg)

		local combined = {}
		sumAllShards(combined)
		mergeCounts(combined, offlineAgg)
		globalCensus = combined
		saveGlobal(combined)
	else
		local g = readGlobal()
		if g then globalCensus = g end
	end

	globalDirty = true
end	

function HoverInfoService:GetExistCount(animalKey, mutation)
	local animalData = existsRep:GetKey(animalKey)
	if type(animalData) ~= "table" or type(animalData.mutations) ~= "table" then
		return 0
	end

	if mutation then
		return animalData.mutations[mutation] or 0
	end

	local total = 0
	for _, count in pairs(animalData.mutations) do
		total += count
	end
	return total
end

function HoverInfoService:Start()
	task.spawn(function()
		local seed = readGlobal()
		if not seed then
			local agg = loadAggregate()
			if next(agg) ~= nil then
				seed = agg
			else
				local ok, legacy = pcall(function() return ExistDS:GetAsync(LEGACY_EXISTS) end)
				if ok and type(legacy) == "table" then seed = legacy end
			end
		end
		globalCensus = seed or {}
		myOnline     = countLocalOnline()
		replicateDisplayed()
	end)
	for _, player in ipairs(Players:GetPlayers()) do
		existsRep:AddSubscriber(player)
		task.spawn(markOnline, player.UserId)
	end

	Players.PlayerAdded:Connect(function(player)
		existsRep:AddSubscriber(player)
		task.spawn(markOnline, player.UserId)
	end)

	Players.PlayerRemoving:Connect(function(player)
		local census = {}
		local ok, channel = pcall(function() return Synchronizer:Get(player) end)
		if ok and channel then
			local ok2, podiums = pcall(function() return channel:Get("AnimalPodiums") end)
			if ok2 and type(podiums) == "table" then
				census = countFromPodiums(podiums)
			end
		end
		markOffline(player.UserId, census)
	end)

	task.spawn(function()
		task.wait(math.random() * SYNC_EVERY)
		while true do
			local ok, err = pcall(step)
			if not ok then warn("[HoverInfoService] step error:", err) end
			task.wait(SYNC_EVERY * (0.9 + math.random() * 0.2))
		end
	end)

	task.spawn(function()
		while true do
			task.wait(FAST_SYNC)
			local ok, newOnline = pcall(countLocalOnline)
			if ok and (globalDirty or not censusEqual(newOnline, myOnline)) then
				myOnline    = newOnline
				globalDirty = false
				replicateDisplayed()
			end
		end
	end)

	game:BindToClose(function()
		local remaining = #Players:GetPlayers()
		for _, player in ipairs(Players:GetPlayers()) do
			task.spawn(function()
				local census = {}
				local ok, channel = pcall(function() return Synchronizer:Get(player) end)
				if ok and channel then
					local ok2, podiums = pcall(function() return channel:Get("AnimalPodiums") end)
					if ok2 and type(podiums) == "table" then
						census = countFromPodiums(podiums)
					end
				end
				markOffline(player.UserId, census)
				remaining -= 1
			end)
		end

		local deadline = os.clock() + 25
		while remaining > 0 and os.clock() < deadline do
			task.wait(0.1)
		end

		pcall(function() ShardMap:RemoveAsync(SERVER_KEY) end)

		if leaseExpiry > workspace:GetServerTimeNow() then
			if not offlineAggLoaded then
				offlineAgg = loadAggregate()
				offlineAggLoaded = true
			end
			drainDeltas(offlineAgg)
			saveAggregate(offlineAgg)
		end
		releaseLease()
	end)
end

return HoverInfoService
